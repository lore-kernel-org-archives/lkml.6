Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C0DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCE120693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ethantuttle-com.20150623.gappssmtp.com header.i=@ethantuttle-com.20150623.gappssmtp.com header.b="AahoqSUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCE120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ethantuttle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeFTEbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:31:23 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39483 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeFTEbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:31:20 -0400
Received: by mail-pf0-f194.google.com with SMTP id r11-v6so933905pfl.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 21:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ethantuttle-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4WdIOnYBk/gaJ81rghZ0C9OItTocO8iZGa6//nyJE2o=;
        b=AahoqSUYDiR08YKkIKwdXW+22BkOiuHrUtjEZl5Iplo8+hlQgPZhhDJfP3tJhJpfsO
         6O5YuU7djFgEdW5+hme46rDIBuPbzB+HWSwzN5jevVnnp7mrJsisO70yEK+TAegVaAK7
         KhM4qo91o56Iobk/ATrQIVOUrSan18wDbliwXl0eGGh0kbyxWgypkRuSUK9n6UEOCbMJ
         KOgtP1ZJUnzwoBrcHLU6K2d7Td7NzX4deFqMK/VoHLOA0bioihmBMtFXVs/kFAhgX7Qf
         vqfX0qUyw5DCj8cS0ddZPgZ0pc5V1S09WD1oc2jCnlJSPdHYokHxYX/cZfyS+Tcjg0Oc
         63sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4WdIOnYBk/gaJ81rghZ0C9OItTocO8iZGa6//nyJE2o=;
        b=ETAv4EWuy9TeGscw7A9CwzR1Z4T/JUlb2O5DM6DauT+w8m2mFmIbZOjxNYcEg7s1ct
         vdzkdgn0zjmJhlOpqrLkxB6ODdKdgEyv4I4pJMIDUkKY4hA8gmm/zb65cwBIKVFHmAHL
         0y/hs93mB84+i2Ep7mUme3P+OTz5U00hKJxz1dyEoaZnCof6Y3NJ3qB2Hlw9M19CI7Wu
         d/uji450SPsr8hfHaJq2SE5covE/uZSx8kbT/9AmsZXTwlXr2dSBYTEmEtY6Vh5g8e/i
         u9KY4thn2i4bWT0qD+gz146LBftq0nTq3J3iZvDbRr7gBhinOPHoV5zqCCwsls1adYT6
         BNVA==
X-Gm-Message-State: APt69E1TfGfjHme/JsBXzjQB+7kfMZEUuOzahPbJ4tvsO8w/kLrAtkUA
        j1IGzze/KaWC8ynjFXK9iVSjrw==
X-Google-Smtp-Source: ADUXVKJllbDxn99O3wEtGRggpFFz2AzoMl5maO5pKJsd82vRWONpRf51dFc9EmEx8Wnr1uomDVGk0A==
X-Received: by 2002:a63:780b:: with SMTP id t11-v6mr17115738pgc.91.1529469079530;
        Tue, 19 Jun 2018 21:31:19 -0700 (PDT)
Received: from arch.hsd1.ca.comcast.net (c-67-169-71-69.hsd1.ca.comcast.net. [67.169.71.69])
        by smtp.gmail.com with ESMTPSA id j23-v6sm1544432pfi.137.2018.06.19.21.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 21:31:18 -0700 (PDT)
From:   Ethan Tuttle <ethan@ethantuttle.com>
Cc:     Ethan Tuttle <ethan@ethantuttle.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mvebu: declare asm symbols as character arrays in pmsu.c
Date:   Tue, 19 Jun 2018 21:31:08 -0700
Message-Id: <20180620043109.1190-1-ethan@ethantuttle.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_FORTIFY_SOURCE, memcpy uses the declared size of operands to
detect buffer overflows.  If src or dest is declared as a char, attempts to
copy more than byte will result in a fortify_panic().

Address this problem in mvebu_setup_boot_addr_wa() by declaring
mvebu_boot_wa_start and mvebu_boot_wa_end as character arrays.  Also remove
a couple addressof operators to avoid "arithmetic on pointer to an
incomplete type" compiler error.

See commit 54a7d50b9205 ("x86: mark kprobe templates as character arrays,
not single characters") for a similar fix.

Fixes "detected buffer overflow in memcpy" error during init on some mvebu
systems (armada-370-xp, armada-375):

(fortify_panic) from (mvebu_setup_boot_addr_wa+0xb0/0xb4)
(mvebu_setup_boot_addr_wa) from (mvebu_v7_cpu_pm_init+0x154/0x204)
(mvebu_v7_cpu_pm_init) from (do_one_initcall+0x7c/0x1a8)
(do_one_initcall) from (kernel_init_freeable+0x1bc/0x254)
(kernel_init_freeable) from (kernel_init+0x8/0x114)
(kernel_init) from (ret_from_fork+0x14/0x2c)

Signed-off-by: Ethan Tuttle <ethan@ethantuttle.com>
Tested-by: Ethan Tuttle <ethan@ethantuttle.com>
---
 arch/arm/mach-mvebu/pmsu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 27a78c80e5b1..73d5d72dfc3e 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -116,8 +116,8 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
 		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
 }
 
-extern unsigned char mvebu_boot_wa_start;
-extern unsigned char mvebu_boot_wa_end;
+extern unsigned char mvebu_boot_wa_start[];
+extern unsigned char mvebu_boot_wa_end[];
 
 /*
  * This function sets up the boot address workaround needed for SMP
@@ -130,7 +130,7 @@ int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_target,
 			     phys_addr_t resume_addr_reg)
 {
 	void __iomem *sram_virt_base;
-	u32 code_len = &mvebu_boot_wa_end - &mvebu_boot_wa_start;
+	u32 code_len = mvebu_boot_wa_end - mvebu_boot_wa_start;
 
 	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
 	mvebu_mbus_add_window_by_id(crypto_eng_target, crypto_eng_attribute,
-- 
2.17.1

