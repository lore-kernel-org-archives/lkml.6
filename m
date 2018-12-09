Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DA8C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC9820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544393225;
	bh=Xdhy7N4NKO4Yys8fHWKE7jeP5bz4URwYyduVnCHHdDU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kceZMxEOXPqZlwI45vXkwoDaf18VW6cfZ50bG3s8Yn9aV9dVfmXpCgCEjEGtOwDkL
	 nLnNuDUH5bN0sI0FyLkCB7rznXzcycH3g9jgbHGjlLwksmFr+G9oNcYcuP0/xtxerB
	 vEjuZLH7kMJQId4Hbyzc18c0PIHMVr69XjXTD0Cw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC9820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeLIWHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:07:04 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:53586 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeLIWHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:07:00 -0500
Received: by mail-wm1-f47.google.com with SMTP id y1so9027534wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 14:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0Up4loF7UsIrVmiZbNyiZStOa0C4YPv8VzcUav8y8RA=;
        b=ITJi94tUBQw7YotRGeI3NeWaF/gbTXoLoD6SCv6UEz09PQ18wXghEVSoCgfgozHsFU
         xXRFwV9bh1jbehigND0iJ8f1tGOnYZSGD6oL9AwH0BIQM/jQSgUJt923HMrBMhlnOGzK
         yDjJicb8W9aZGBGHE0iO1aBqPhEpzVog3IzuI9/lbyeQdXdlef2Yo5g5vjX9G+eYXah0
         +4hQuGT19++gQ3yuz8SBHQ+GWdJ7IJH/lN47zWQXpMyb0LGHAgwulCqZIprVoivwbeof
         uIjRfl7NSGFatABwxcm4PcKppbSDAyd+ApxSMljguHGxIG3C6xLMkJhgd4hIimPC+BL2
         WjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=0Up4loF7UsIrVmiZbNyiZStOa0C4YPv8VzcUav8y8RA=;
        b=O0qddKjjCos2qVU3EJDgQrFKKryDguEn4ead9jLPm9XhiJMtJpyWPfT+Fm1u86y920
         GyAKZADA1L31ouvCKATqIgrsAQf+zPISvNYzX2pIhi1RM/xwv7dGzfev75/nEz4RANhC
         EHeUPJzP6HVPl4uwH29tq7UUu07o3eKEUWu/m23awRKx82f5p0NNr1+Ssemc1Be1Cv6L
         k9S5KsYvKPAAfJAEIi1UchxGmFspNx6soYR3bh7yM5d+CyF4MNlHHvgTYjTc+vGOVbai
         LAePgibZQloOynqN8bdDWLN8boWQKWoHrAgx89BxPcrHFdvnqjEuePzCcsVgSOtvCKaf
         afdw==
X-Gm-Message-State: AA+aEWZk+kNZC7JElR97eWsBjf1wuFuQ38g7j2KrbPlcQZIQs1wi5Nu+
        HHnPhvrLSPoKBksXWR+USDqOd7tw
X-Google-Smtp-Source: AFSGD/W4YQTt6gBwJjM2tYDT8EAotiQhP0Tglqj1MQPHvkbBIOJzSo2Jj4IBpEOnlyAEAjhmXcLTaA==
X-Received: by 2002:a1c:868a:: with SMTP id i132mr8293243wmd.49.1544393218111;
        Sun, 09 Dec 2018 14:06:58 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 60sm19615961wrb.81.2018.12.09.14.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 14:06:57 -0800 (PST)
Date:   Sun, 9 Dec 2018 23:06:55 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20181209220655.GA105704@gmail.com>
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

   # HEAD: ac3e233d29f7f77f28243af0132057d378d3ea58 x86/vdso: Drop implicit common-page-size linker flag

Three fixes: a boot parameter re-(re-)fix, a retpoline build artifact fix 
and an LLVM workaround.

 Thanks,

	Ingo

------------------>
Juergen Gross (1):
      x86/boot: Clear RSDP address in boot_params for broken loaders

Masahiro Yamada (1):
      x86/build: Fix compiler support check for CONFIG_RETPOLINE

Nick Desaulniers (1):
      x86/vdso: Drop implicit common-page-size linker flag


 arch/x86/Makefile                      | 10 +++++++---
 arch/x86/entry/vdso/Makefile           |  4 ++--
 arch/x86/include/asm/bootparam_utils.h |  1 +
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f5d7f4134524..75ef499a66e2 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -220,9 +220,6 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-ifeq ($(RETPOLINE_CFLAGS),)
-  $(error You are building kernel with non-retpoline compiler, please update your compiler.)
-endif
   KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
 endif
 
@@ -307,6 +304,13 @@ ifndef CC_HAVE_ASM_GOTO
 	@echo Compiler lacks asm-goto support.
 	@exit 1
 endif
+ifdef CONFIG_RETPOLINE
+ifeq ($(RETPOLINE_CFLAGS),)
+	@echo "You are building kernel with non-retpoline compiler." >&2
+	@echo "Please update your compiler." >&2
+	@false
+endif
+endif
 
 archclean:
 	$(Q)rm -rf $(objtree)/arch/i386
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 141d415a8c80..0624bf2266fd 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -47,7 +47,7 @@ targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
-			-z max-page-size=4096 -z common-page-size=4096
+			-z max-page-size=4096
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
@@ -98,7 +98,7 @@ CFLAGS_REMOVE_vvar.o = -pg
 
 CPPFLAGS_vdsox32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdsox32.lds = -m elf32_x86_64 -soname linux-vdso.so.1 \
-			   -z max-page-size=4096 -z common-page-size=4096
+			   -z max-page-size=4096
 
 # x32-rebranded versions
 vobjx32s-y := $(vobjs-y:.o=-x32.o)
diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index a07ffd23e4dd..f6f6ef436599 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -36,6 +36,7 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 	 */
 	if (boot_params->sentinel) {
 		/* fields in boot_params are left uninitialized, clear them */
+		boot_params->acpi_rsdp_addr = 0;
 		memset(&boot_params->ext_ramdisk_image, 0,
 		       (char *)&boot_params->efi_info -
 			(char *)&boot_params->ext_ramdisk_image);
