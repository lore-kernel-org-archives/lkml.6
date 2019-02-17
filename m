Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F304CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A402192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550398756;
	bh=v0WFFrUMAWm/8INn43+0Gj9P+eFe/G0JYEgMFwtrq7M=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uqxU0sXZfJTmWAsiwfs/GXdTcBpeEgM6MTVLav3HKJyTi2WCrEtzVxvO8vnZjiNZD
	 1yaGvL+Rzr9qF9ZJVZXs0oKJAn3dkJZJ+FQZaiplPItP9gCYm7aciEXZMyjIgR1DL2
	 QMqTQmdSgdspsjda1qobZRLNcgSiXLHyTmOtWc3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfBQKTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 05:19:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50211 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfBQKTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 05:19:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so14289782wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 02:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XcvDZD22LPjNHRkJhq3GW++7LUa70TGnuItAJB6uQow=;
        b=oWixms2Bh4vUVnWsBR0kkOFD5Ws+RiCBDPl0XS5NdFFb+FrL9+Z9CJ27isq2hmbIAm
         QT6nv6Sxb4pqb3DenjjMyI9TEX5633eKWpgOXwLSDUCuswBM/A348J92ZoE70OWw8LaY
         NiSNbnrFFPyiLGsbnlfjyaMOXooxZ8hDuuNpRERcsnR5vWXnmR1ZT6Pc9ItkkgmM7z3j
         SvY2UUkQnnC86bh5WTUGDMefrZ45QSWDDsKVWP+2+yAoCkevGtp0Ts/VX9FMOV2zF9gJ
         4u3HGeRia/lpng9bWi+Iv+Naqma10wC9RLCNPi8lxi9rLfNHcbFDwRgi7TG13ALVjZli
         vH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=XcvDZD22LPjNHRkJhq3GW++7LUa70TGnuItAJB6uQow=;
        b=hW3zxdF9swb1wX3+KFsjXKEK/IsgdNe4psIKpAZcUlLVmnbwYJcDLhWmuLVRm8HLT3
         rMal29V+CUguAmK1Qa3CIwN6ImXoZ5JKNaMdYAjeKp9md2pmUmValV3caEtsJy0oZiJD
         j+Je/R0+TKXh0hxj4Xknry+wbwrxQrgio4VR7l1wIOF1NpD94yaSXn9FnwBzfXKDD+8o
         MtNyKREngD2Z/VElXD7RyVGDP6gLRYmtECnlMUtqOmbIptUrCSqozhs7NUdUaGIDKRa8
         bFOYy8ukhvkZa+7Ob71yKsIheAAaZ8Y3wozJrptGjenaAmD3G3Sc3PwTgUxPiwVFzT3v
         RuJQ==
X-Gm-Message-State: AHQUAuaIzL5F00iKsrp2pECkTa/Dxr9d10u/rSbLnvGhW9+28FYM9tU1
        28rNtxtnwwdaJEBnGS5IHOKF+oMt
X-Google-Smtp-Source: AHgI3IbRjkn9a58F9FNEHZfgexubc2lUTBhG6sLegqytfM22AOsLT81tI/RVYrEAezplyPFPtEaQNA==
X-Received: by 2002:a1c:dc8a:: with SMTP id t132mr2681750wmg.48.1550398752006;
        Sun, 17 Feb 2019 02:19:12 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h1sm11720854wmb.0.2019.02.17.02.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 02:19:11 -0800 (PST)
Date:   Sun, 17 Feb 2019 11:19:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20190217101908.GA68624@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: f331e766c4be33f4338574f3c9f7f77e98ab4571 x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls

Three changes:

 - An UV fix/quirk to pull UV BIOS calls into the efi_runtime_lock 
   locking regime. (This done by aliasing __efi_uv_runtime_lock to
   efi_runtime_lock, which should make the quirk nature obvious and
   maintain the general policy that the EFI lock (name...) isn't exposed
   to drivers.)

 - Our version of MAGA: Make a.out Great Again.

 - Add a new Intel model name enumerator to an upstream header to help 
   reduce dependencies going forward.


  out-of-topic modifications in x86-urgent-for-linus:
  -----------------------------------------------------
  drivers/firmware/efi/runtime-wrappers.c# f331e766c4be: x86/platform/UV: Use efi_run

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/a.out: Clear the dump structure initially

Hedi Berriche (1):
      x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls

Rajneesh Bhardwaj (1):
      x86/CPU: Add Icelake model number


 arch/x86/ia32/ia32_aout.c               |  6 ++++--
 arch/x86/include/asm/intel-family.h     |  2 ++
 arch/x86/include/asm/uv/bios.h          |  8 +++++++-
 arch/x86/platform/uv/bios_uv.c          | 23 +++++++++++++++++++++--
 drivers/firmware/efi/runtime-wrappers.c |  7 +++++++
 5 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index f65b78d32f5e..7dbbe9ffda17 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -51,7 +51,7 @@ static unsigned long get_dr(int n)
 /*
  * fill in the user structure for a core dump..
  */
-static void dump_thread32(struct pt_regs *regs, struct user32 *dump)
+static void fill_dump(struct pt_regs *regs, struct user32 *dump)
 {
 	u32 fs, gs;
 	memset(dump, 0, sizeof(*dump));
@@ -157,10 +157,12 @@ static int aout_core_dump(struct coredump_params *cprm)
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 	has_dumped = 1;
+
+	fill_dump(cprm->regs, &dump);
+
 	strncpy(dump.u_comm, current->comm, sizeof(current->comm));
 	dump.u_ar0 = offsetof(struct user32, regs);
 	dump.signal = cprm->siginfo->si_signo;
-	dump_thread32(cprm->regs, &dump);
 
 	/*
 	 * If the size of the dump file exceeds the rlimit, then see
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index d9a9993af882..9f15384c504a 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -52,6 +52,8 @@
 
 #define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
 
+#define INTEL_FAM6_ICELAKE_MOBILE	0x7E
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index e652a7cc6186..3f697a9e3f59 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -48,7 +48,8 @@ enum {
 	BIOS_STATUS_SUCCESS		=  0,
 	BIOS_STATUS_UNIMPLEMENTED	= -ENOSYS,
 	BIOS_STATUS_EINVAL		= -EINVAL,
-	BIOS_STATUS_UNAVAIL		= -EBUSY
+	BIOS_STATUS_UNAVAIL		= -EBUSY,
+	BIOS_STATUS_ABORT		= -EINTR,
 };
 
 /* Address map parameters */
@@ -167,4 +168,9 @@ extern long system_serial_number;
 
 extern struct kobject *sgi_uv_kobj;	/* /sys/firmware/sgi_uv */
 
+/*
+ * EFI runtime lock; cf. firmware/efi/runtime-wrappers.c for details
+ */
+extern struct semaphore __efi_uv_runtime_lock;
+
 #endif /* _ASM_X86_UV_BIOS_H */
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 4a6a5a26c582..eb33432f2f24 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -29,7 +29,8 @@
 
 struct uv_systab *uv_systab;
 
-s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
+static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
+			u64 a4, u64 a5)
 {
 	struct uv_systab *tab = uv_systab;
 	s64 ret;
@@ -51,6 +52,19 @@ s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
 
 	return ret;
 }
+
+s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
+{
+	s64 ret;
+
+	if (down_interruptible(&__efi_uv_runtime_lock))
+		return BIOS_STATUS_ABORT;
+
+	ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
+	up(&__efi_uv_runtime_lock);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(uv_bios_call);
 
 s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
@@ -59,10 +73,15 @@ s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 	unsigned long bios_flags;
 	s64 ret;
 
+	if (down_interruptible(&__efi_uv_runtime_lock))
+		return BIOS_STATUS_ABORT;
+
 	local_irq_save(bios_flags);
-	ret = uv_bios_call(which, a1, a2, a3, a4, a5);
+	ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
 	local_irq_restore(bios_flags);
 
+	up(&__efi_uv_runtime_lock);
+
 	return ret;
 }
 
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 8903b9ccfc2b..e2abfdb5cee6 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -146,6 +146,13 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
  */
 static DEFINE_SEMAPHORE(efi_runtime_lock);
 
+/*
+ * Expose the EFI runtime lock to the UV platform
+ */
+#ifdef CONFIG_X86_UV
+extern struct semaphore __efi_uv_runtime_lock __alias(efi_runtime_lock);
+#endif
+
 /*
  * Calls the appropriate efi_runtime_service() with the appropriate
  * arguments.
