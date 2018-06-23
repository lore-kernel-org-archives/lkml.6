Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115CDC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C692524BAC
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C692524BAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeFWMJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:09:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56447 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeFWMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:09:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NC9osA463526
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:09:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NC9o21463523;
        Sat, 23 Jun 2018 05:09:50 -0700
Date:   Sat, 23 Jun 2018 05:09:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-0b9aa6562650f42da23c29814adc2318c135cef4@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, reinette.chatre@intel.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, reinette.chatre@intel.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <798f8d89cd9b12df492d48c14bdc8ee3b39b1c6f.1529706536.git.reinette.chatre@intel.com>
References: <798f8d89cd9b12df492d48c14bdc8ee3b39b1c6f.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Introduce test to determine if
 closid is in use
Git-Commit-ID: 0b9aa6562650f42da23c29814adc2318c135cef4
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

Commit-ID:  0b9aa6562650f42da23c29814adc2318c135cef4
Gitweb:     https://git.kernel.org/tip/0b9aa6562650f42da23c29814adc2318c135cef4
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:41:57 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:41 +0200

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
Link: https://lkml.kernel.org/r/798f8d89cd9b12df492d48c14bdc8ee3b39b1c6f.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index d00cce3186ad..659b643fcf94 100644
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
