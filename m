Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B1C23C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66755208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="OPJ8sgWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66755208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbeFNG0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:26:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39090 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752681AbeFNG0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:26:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so9578955wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 23:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=nWMIDKt80mXBHzI7s8JdB2ZI+XKFuN43FHMLLhT8LRM=;
        b=OPJ8sgWaoi69GKVE76A/HwSmA6WsU36Pl4K4oqLTs5RdAmcYY2jUvUYrBtpnx2n/CM
         a7LsrmBhHF4hNPmYS8YBEtIFmBMv/+DVFRvZeU76SFXE2bd2hXQp/dGihCOV1FWiRlwB
         BEz14mUIT60LmCPhwDAtVwK3G1LrBj1Vqo+kp/VkRhwejUqI93VutVlkwcChd5TBurHz
         LLP9IeawgqCHJb1PbM2LiJb6bit6+oe8eLG2XQOr2evz1L3FMePh7+aZBEYLCGL9XPkd
         KU9hFte+KoSXWuLp01vchT/FsqubYMKFr57KkhGgXAm4NQXxBnuBlfezM/p+zHExlR/b
         fFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=nWMIDKt80mXBHzI7s8JdB2ZI+XKFuN43FHMLLhT8LRM=;
        b=piD06uvH0v9bbonznR5xS+EIhLH4QMXLI88pZY61Km+DPgUbxyLA5KQuZ8hR4aX58H
         8zgYlQUxtvaZyp5GIES4E5Ot6zsJwa0h80rTejXOmujwkjyyL1F57dC9dzPe56Cavchd
         HckVuNg7EtW4cSKQIHnyM389j+wFoDWGSy8UN2CnTvNBROyfYjZmab38LukuMXdWYufn
         z+DiPEIKsRy513QruQkxKOhrqP6c0/AQe0+r7GAAfId2B6+VPuK/6q9ztcjETNiWRBfz
         RWVji1RPBRwAQ3rCFYNuUuj06AO1Jd0fWLL5MlUrkGaqpn45cXxKylmDAR4UqoSlnk1j
         Ok4A==
X-Gm-Message-State: APt69E3VqWJEPYKz60uJlqgNwodbbqefrf88GcFQvBPi1tuYJ5dv0/ap
        TXmgQTqFWrInU7VKupB/w2jmRIvw
X-Google-Smtp-Source: ADUXVKKr3DrZPU6CieFIpzO2cPF/lEhkf5Sxj41KKMvzXlOvUtTChPf4EjRWJWxOSfzO8EYm3WmFdA==
X-Received: by 2002:a1c:c342:: with SMTP id t63-v6mr781271wmf.123.1528957573281;
        Wed, 13 Jun 2018 23:26:13 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d102-v6sm2024428wma.10.2018.06.13.23.26.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 23:26:12 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        u-boot@lists.denx.de, Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] microblaze: Add new syscalls io_pgetevents and rseq
Date:   Thu, 14 Jun 2018 08:26:09 +0200
Message-Id: <b08f5d64603a7aca3f9dd0a9fb57c6d7bc3b433e.1528957563.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up new syscalls io_pgetevents and rseq.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/include/asm/unistd.h      | 2 +-
 arch/microblaze/include/uapi/asm/unistd.h | 2 ++
 arch/microblaze/kernel/syscall_table.S    | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index 9774e1d9507b..a62d09420a47 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -38,6 +38,6 @@
 
 #endif /* __ASSEMBLY__ */
 
-#define __NR_syscalls         399
+#define __NR_syscalls         401
 
 #endif /* _ASM_MICROBLAZE_UNISTD_H */
diff --git a/arch/microblaze/include/uapi/asm/unistd.h b/arch/microblaze/include/uapi/asm/unistd.h
index eb156f914793..7a9f16a76413 100644
--- a/arch/microblaze/include/uapi/asm/unistd.h
+++ b/arch/microblaze/include/uapi/asm/unistd.h
@@ -415,5 +415,7 @@
 #define __NR_pkey_alloc		396
 #define __NR_pkey_free		397
 #define __NR_statx		398
+#define __NR_io_pgetevents	399
+#define __NR_rseq		400
 
 #endif /* _UAPI_ASM_MICROBLAZE_UNISTD_H */
diff --git a/arch/microblaze/kernel/syscall_table.S b/arch/microblaze/kernel/syscall_table.S
index 56bcf313121f..6ab650593792 100644
--- a/arch/microblaze/kernel/syscall_table.S
+++ b/arch/microblaze/kernel/syscall_table.S
@@ -400,3 +400,5 @@ ENTRY(sys_call_table)
 	.long sys_pkey_alloc
 	.long sys_pkey_free
 	.long sys_statx
+	.long sys_io_pgetevents
+	.long sys_rseq
-- 
1.9.1

