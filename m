Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0507C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBF020836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBF020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeFTAPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:15:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51073 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbeFTAPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:15:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0FDd43296511
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:15:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0FD1k3296508;
        Tue, 19 Jun 2018 17:15:13 -0700
Date:   Tue, 19 Jun 2018 17:15:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-db436b3135badfa9f701b20f160e19b630538b9b@git.kernel.org>
Cc:     reinette.chatre@intel.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, reinette.chatre@intel.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <26e0715da4e5945b72230c0f72a4399c94bbc2d5.1527593970.git.reinette.chatre@intel.com>
References: <26e0715da4e5945b72230c0f72a4399c94bbc2d5.1527593970.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Introduce test to determine if
 closid is in use
Git-Commit-ID: db436b3135badfa9f701b20f160e19b630538b9b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  db436b3135badfa9f701b20f160e19b630538b9b
Gitweb:     https://git.kernel.org/tip/db436b3135badfa9f701b20f160e19b630538b9b
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:30 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:28 +0200

x86/intel_rdt: Introduce test to determine if closid is in use

During CAT feature discovery the capacity bitmasks (CBMs) associated
with all the classes of service are initialized to all ones, even if the
class of service is not in use. Introduce a test that can be used to
determine if a class of service is in use. This test enables code
interested in parsing the CBMs to know if its values are meaningful or
can be ignored.

Temporarily mark the function as unused to silence compile warnings
until it is used.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/26e0715da4e5945b72230c0f72a4399c94bbc2d5.1527593970.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index eac60602c87b..fdc55357251b 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -126,6 +126,18 @@ static void closid_free(int closid)
 	closid_free_map |= 1 << closid;
 }
 
+/**
+ * closid_allocated - test if provided closid is in use
+ * @closid: closid to be tested
+ *
+ * Return: true if @closid is currently associated with a resource group,
+ * false if @closid is free
+ */
+static bool __attribute__ ((unused)) closid_allocated(unsigned int closid)
+{
+	return (closid_free_map & (1 << closid)) == 0;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
