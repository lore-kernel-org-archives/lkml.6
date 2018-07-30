Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15531FC6120
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A9B20857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A9B20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbeG3TeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:34:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36917 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbeG3TeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:34:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6UHvud72394246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 10:57:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6UHvuE02394243;
        Mon, 30 Jul 2018 10:57:56 -0700
Date:   Mon, 30 Jul 2018 10:57:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-24cfd8ca1d28331b9dad3b88d1958c976b2cfab6@git.kernel.org>
Cc:     hpa@zytor.com, andrew.banman@hpe.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, mike.travis@hpe.com, douly.fnst@cn.fujitsu.com,
        tglx@linutronix.de
Reply-To: douly.fnst@cn.fujitsu.com, hpa@zytor.com, andrew.banman@hpe.com,
          mike.travis@hpe.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20180730075947.23023-1-douly.fnst@cn.fujitsu.com>
References: <20180730075947.23023-1-douly.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/platform/UV: Mark memblock related init code
 and data correctly
Git-Commit-ID: 24cfd8ca1d28331b9dad3b88d1958c976b2cfab6
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

Commit-ID:  24cfd8ca1d28331b9dad3b88d1958c976b2cfab6
Gitweb:     https://git.kernel.org/tip/24cfd8ca1d28331b9dad3b88d1958c976b2cfab6
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Mon, 30 Jul 2018 15:59:47 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 30 Jul 2018 19:53:58 +0200

x86/platform/UV: Mark memblock related init code and data correctly

parse_mem_block_size() and mem_block_size are only used during init. Mark
them accordingly.

Fixes: d7609f4210cb ("x86/platform/UV: Add kernel parameter to set memory block size")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Andrew Banman <andrew.banman@hpe.com>
Link: https://lkml.kernel.org/r/20180730075947.23023-1-douly.fnst@cn.fujitsu.com

---
 arch/x86/kernel/apic/x2apic_uv_x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d492752f79e1..391f358ebb4c 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -394,10 +394,10 @@ extern int uv_hub_info_version(void)
 EXPORT_SYMBOL(uv_hub_info_version);
 
 /* Default UV memory block size is 2GB */
-static unsigned long mem_block_size = (2UL << 30);
+static unsigned long mem_block_size __initdata = (2UL << 30);
 
 /* Kernel parameter to specify UV mem block size */
-static int parse_mem_block_size(char *ptr)
+static int __init parse_mem_block_size(char *ptr)
 {
 	unsigned long size = memparse(ptr, NULL);
 
