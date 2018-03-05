Return-Path: <jinb.park7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520248711; cv=none;
        d=google.com; s=arc-20160816;
        b=ABB33fQAST6UWXji2Y/vqbewBCtoAfA2oU2zRqcLjlEDHMshnbrY3LtAHrYHiAdlAe
         XkCG6CqbY23PtLSXtckkURMWUuw9smaK0FdTyDaZ+UIudtb0MO4P0sN2m4NgPCSPodTr
         OQFYs1mJ+Ylq7nc1SKP9nKsBcQnVf1fc8gVrCLAg6ln5LkN6fYJ7qRu+FWuOTIFpiW23
         zWEv47FYmyffS19fzCrZ30Z4ZgP7EpSCoXpGmFdcxG/GvAYE2uCfpIGbuiWJrHgaXW92
         CIEB01sgBJ2DviNfnXWL528BSV1K58P5gJ71O7v6bggWr4dRt1ROSwjq5FP8ESgI8w/A
         wZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=VS5Cvod2yup69YZ8TkrWuwx4G0+ROdocQ7MzaK//5/M=;
        b=OUBSltRqnWZVbimpazNYIdMBGcM2wgxJvgJ5JhWvwV9DHunsCjgM5Wxa5XhJVgLR09
         G8j7Y5SxsGzzIuYRcnTWUcAf5VBbVFBOIW9w/KhVqi8kMe9BsY3Xixa7Z3qOZilJYIds
         JE12iPNHGY7rxazh5kJ926deSzuAwfBzjw9/L87Ohw+bwbhD5UPm+fj7rzX27KY+p38W
         olP616uGvGs8hlD8q4d8EpTeC32D5vbBHjUKjcRUvTJCnk6b5cAt4qZhpiPGH1NwmykG
         ezXkodOWgvKxJ+EGwJqIh/7lYc26rqo3MRT5QJd45ObAr5zGdfnhESRHFCAmonnS+VA/
         jk1w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Mqnedi5d;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Mqnedi5d;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuyQJykPPp4OHWuZbYYO3hWXSmg4n1lenpFYYjGGa4cwOPMCxiUibVctIkA2rXzoc09FgJlbw==
Date: Mon, 5 Mar 2018 20:18:24 +0900
From: Jinbum Park <jinb.park7@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de,
	kstewart@linuxfoundation.org, luto@amacapital.net,
	dsafonov@virtuozzo.com, keescook@chromium.org, will.deacon@arm.com,
	mark.rutland@arm.com, danielmicay@gmail.com, arnd@arndb.de,
	catalin.marinas@arm.com
Subject: [PATCH v2 2/2] arm: Kconfig: Add ARCH_HAS_FORTIFY_SOURCE
Message-ID: <20180305111824.GA4216@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594096312948784945?=
X-GMAIL-MSGID: =?utf-8?q?1594096312948784945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

CONFIG_FORTIFY_SOURCE detects various overflows at compile-time.
(6974f0c4555e ("include/linux/string.h:
add the option of fortified string.h functions)

ARCH_HAS_FORTIFY_SOURCE means that the architecture can be built and
run with CONFIG_FORTIFY_SOURCE.

Since ARM can be built and run with that flag like other architectures,
select ARCH_HAS_FORTIFY_SOURCE as default.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
---
v2: Add fortify_panic() in arch/arm/boot/compressed/misc.c,
    Because there will be a build error if without that function.
---
 arch/arm/Kconfig                | 1 +
 arch/arm/boot/compressed/misc.c | 5 +++++
 2 files changed, 6 insertions(+)

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
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 16a8a80..4a247ac 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -167,3 +167,8 @@ void __stack_chk_fail(void)
 	else
 		putstr(" done, booting the kernel.\n");
 }
+
+void fortify_panic(const char *name)
+{
+	error("detected buffer overflow");
+}
-- 
1.9.1
