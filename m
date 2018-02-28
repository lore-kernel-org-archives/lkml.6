Return-Path: <jinb.park7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519828245; cv=none;
        d=google.com; s=arc-20160816;
        b=cofKHbQpSIvqyqmNRMAo3V3kQPVHQRyV/+DYF2rkoGHtoLxeZydoD2zp31tM699ZZ6
         s/MFtr8V12NNaU7BL0rQzkRErsTSV6CGgOjnhdkHTBGmGDVfu0Zi7ZJvwExCid14Vyzo
         fRhET1mx0kRDLB0RIAz+OecIz7MMvfvALuxoq4Lq+MCUQqpiu4rBoKEAhOImirWo9mPV
         zJ6/UFuToeF7SnVrJmeOXVGm1EZDzOipIkDznEvx35WPQl4/HzEOc8RHkxZ09CDaZy7T
         AURu6Xavu7IdjJ5zZbw4aRP2CnS4QkV24fapAiKditUiIHY1G5SYKklVBIratQxB47yd
         LD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=iomQ1J7o3UWUqhV7v91Kswn2UXPSlUB4AVwkcqhYuJ0=;
        b=BrGfws4NNzjNA69+BP37m0xDGYM2WqD5Injm2Crr9RvhwDfcibi0p9M6j2dwjpo2NH
         W7v/PKhJ9cx3KuQByapHVbEzlOF2hYr4CuMrWX5iSC8zE98tCsX14nKuCDieLEiKSb/J
         sv4Z3F+mlb8n7wiuFLWE1+ifJDGg7DS7Z6sGAW2UA8Hx1HVa2jHvDnmqb4s9bk+GJGWp
         HgVXmY0GDWjUBipZ9BngVak2aa8nrzellXtz8aE2bBAuKfvc5d9qVbbfB1r3SuaNViWF
         qgqPAI+tkIcDTC8B89DTdC2Hy3A5zYYUAeMDvigU+8x1Qh/J/pCXHXvWzeKKnMjxCAb1
         CRDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nq/bAiZj;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nq/bAiZj;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227LBnk14O5LBAmQqwQZNH/Ln7a7Oq+AsgbUCsYR58jz3H8ZHy2PYfhrN6YCknnV7b7ipcLUmA==
Date: Wed, 28 Feb 2018 23:30:37 +0900
From: Jinbum Park <jinb.park7@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Cc: pombredanne@nexb.co, gregkh@linuxfoundation.org, tglx@linutronix.de,
	kstewart@linuxfoundation.org, luto@amacapital.net,
	dsafonov@virtuozzo.com, keescook@chromium.org, will.deacon@arm.com,
	mark.rutland@arm.com, danielmicay@gmail.com, arnd@arndb.de,
	catalin.marinas@arm.com
Subject: [kernel-hardening] [PATCH 2/2] arm: Kconfig: Add
 ARCH_HAS_FORTIFY_SOURCE
Message-ID: <20180228143037.GA3150@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593655422038750745?=
X-GMAIL-MSGID: =?utf-8?q?1593655422038750745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

CONFIG_FORTIFY_SOURCE detects various overflows at compile-time.
(6974f0c4555e ("include/linux/string.h:
add the option of fortified string.h functions)

ARCH_HAS_FORTIFY_SOURCE means that the architecture can be built and
run with CONFIG_FORTIFY_SOURCE.

Since ARM can be built and run with that flag like other architectures,
select ARCH_HAS_FORTIFY_SOURCE as default.

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7e3d535..3765336 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -7,6 +7,7 @@ config ARM
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
-- 
1.9.1
