Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A69EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C520D2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C520D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbeHPVxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:53:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57240 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbeHPVrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:47:40 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0DAF4D29;
        Thu, 16 Aug 2018 18:47:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        Mike Travis <mike.travis@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>
Subject: [PATCH 4.17 03/21] x86/platform/UV: Mark memblock related init code and data correctly
Date:   Thu, 16 Aug 2018 20:45:13 +0200
Message-Id: <20180816171612.419949935@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171612.136242278@linuxfoundation.org>
References: <20180816171612.136242278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

commit 24cfd8ca1d28331b9dad3b88d1958c976b2cfab6 upstream.

parse_mem_block_size() and mem_block_size are only used during init. Mark
them accordingly.

Fixes: d7609f4210cb ("x86/platform/UV: Add kernel parameter to set memory block size")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Andrew Banman <andrew.banman@hpe.com>
Link: https://lkml.kernel.org/r/20180730075947.23023-1-douly.fnst@cn.fujitsu.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apic/x2apic_uv_x.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
 


