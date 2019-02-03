Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E54C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1750F217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfBCQQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 11:16:07 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53988 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfBCQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 11:16:07 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gqKRB-0004KP-IK; Sun, 03 Feb 2019 17:16:05 +0100
Subject: [GIT pull] efi fix for 5.0
Message-ID: <154921049412.12839.6903655600742454434.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Sun, 03 Feb 2019 17:16:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

The dump info for the efi page table debugging lacks a terminator which
causes the kernel to crash when the debugfile is read.

Thanks,

	tglx

------------------>
Qian Cai (1):
      efi/arm64: Fix debugfs crash by adding a terminator for ptdump marker


 drivers/firmware/efi/arm-runtime.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 23ea1ed409d1..352bd2473162 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -37,8 +37,9 @@ extern u64 efi_system_table;
 static struct ptdump_info efi_ptdump_info = {
 	.mm		= &efi_mm,
 	.markers	= (struct addr_marker[]){
-		{ 0,		"UEFI runtime start" },
-		{ DEFAULT_MAP_WINDOW_64, "UEFI runtime end" }
+		{ 0,				"UEFI runtime start" },
+		{ DEFAULT_MAP_WINDOW_64,	"UEFI runtime end" },
+		{ -1,				NULL }
 	},
 	.base_addr	= 0,
 };

