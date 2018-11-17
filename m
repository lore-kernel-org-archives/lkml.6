Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF658C04EBF
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B768A2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B768A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeKRCnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:43:53 -0500
Received: from mout.gmx.net ([212.227.15.19]:49773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeKRCnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:43:52 -0500
Received: from ls3530.dellerweb.de ([92.116.144.86]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaFmY-1fk5tt2kbG-00m66y; Sat, 17
 Nov 2018 17:26:27 +0100
Date:   Sat, 17 Nov 2018 17:26:23 +0100
From:   Helge Deller <deller@gmx.de>
To:     Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Helge Deller <deller@gmx.de>, Firoz Khan <firoz.khan@linaro.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v7 0/5] parisc: system call table generation support
Message-ID: <20181117162623.GA14763@ls3530.dellerweb.de>
References: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org>
 <58c3c4a4-7f55-bf08-1c96-ef1aa7f97072@gmx.de>
 <CALxhOngc1cSSDVznnX+iLg-Ne9+k0ct0wT-z0MXKSeKxJE3Vsg@mail.gmail.com>
 <20181116215502.GA6585@ls3530.dellerweb.de>
 <CAK8P3a2g-7iR594Fs_goYCYPqgO6FRML5oi9vodDC_wKHF64bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2g-7iR594Fs_goYCYPqgO6FRML5oi9vodDC_wKHF64bA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:Ln9qIfp3HAasxgjRK9ibYLOL+D36RqqMv+TygECYb1Z94ZWdmj6
 Ev3i4E276+Aolxx+TBJY5NIVr+OTwBwBA/r8mmJ5zyYQeSk/6zBO4Jt7If/MRG02oiRBOAp
 XdZncy7mF+2CvgsyALSnUwfkeWxqSpyHWOcMi66Kjn3t4mVQqTmFVAdyRmWkVW4c2OQSp2g
 rEXcaJvdAj5aadIszvu9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:87lLI6iFF00=:NbxCNFaO+QRasYLQHCpZnP
 htAfu8Jzfq63LBAcW1lyw01HMhy5nu7vXlNftcpmfIPOQcF/IXI00168/mmZIB4Pa90juWr6J
 SujyUHdKpIFp+OwzY1DPufAmMRXpGgQ6d8ocRBLKzU7RYGSCJapsh6DUACcBCagdJ2GXZBaAs
 p+0nA9fhHXkzpzZYV88vx0WCZ/YJ8LMDqdK3wX9MbOMx6pgEWyFnp4Q7iEPOAkSt32H8wBewB
 ACGzT80jo80n/UKHM6hNrEAXrLybnI9fEtBaa7PWR3pZPG9rZ3KJX/ItEtF/NolkUvWTdVYEr
 yYwKS/R3ynK2XCF3AVpCy3MdUK7CN03aMr2R9txAWdBlEjxx1Z3PKpyDlwyoU4pWSuS1t8J1O
 SsaFqRgCkXWo53K2cysN9cWrn8iI7yzXScKB9hVdRPG3gZ48sRJWcYu6sxdeGSxMj2Q241/mE
 rguVNhj50lwJgyHBxRiLfnXN5/cF8PshVsrDBcxVV9zlIi9CC8ixsKKnYOwQfk/bCvRO1/bH2
 DxMEH6IE4oXo+bdETQAzv/smZtG2SqlGyghjATXomtNvofCgi56HE8QWzlZ7fm9X6PPvTiuE8
 yTiodJGOagWgXyPrgpp2EbQInbkqUos33kC+1lOUIUHLuCjU004h4JlO9waOPZ3uWRX5npiW3
 4XRAMhMWvuBm5W4LPksMhMGf5a0uYS8Jn1or91OUZTXDXwmEsPRkAtom1GnoswCXwraIaxyuI
 /eQvR4UAN/MSAr1s8bPa5ZW1oi/SELMdEqCT695BAEaN5xGsnK8m0NA5iH5dEbtbM75NXOVt8
 0+KHmYqQLOd0LNlOs6jiLfpWuMs3iKj5UCFAAbwzVMCyeqNaCyqjjRki5OhVt2J+H34Gn6V3t
 EW3yOhybWn+Reygs/AY4qoMgjy10AHjHLiqJC5iuw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de>:
> On Fri, Nov 16, 2018 at 1:55 PM Helge Deller <deller@gmx.de> wrote:
> > > On Fri, 16 Nov 2018 at 01:01, Helge Deller <deller@gmx.de> wrote:
> > > >
> > > > On 14.11.2018 07:34, Firoz Khan wrote:
> > > > > The purpose of this patch series is, we can easily
> > > > > add/modify/delete system call table support by cha-
> > > > > nging entry in syscall.tbl file instead of manually
> > > > > changing many files. The other goal is to unify the
> > > > > system call table generation support implementation
> > > > > across all the architectures.
> > > > >
> > > > > The system call tables are in different format in
> > > > > all architecture. It will be difficult to manually
> > > > > add, modify or delete the system calls in the resp-
> > > > > ective files manually. To make it easy by keeping a
> > > > > script and which'll generate uapi header file and
> > > > > syscall table file.
> > > > >
> > > > > syscall.tbl contains the list of available system
> > > > > calls along with system call number and correspond-
> > > > > ing entry point. Add a new system call in this arch-
> > > > > itecture will be possible by adding new entry in the
> > > > > syscall.tbl file.
> > > > >
> > > > > Adding a new table entry consisting of:
> > > > >         - System call number.
> > > > >         - ABI.
> > > > >         - System call name.
> > > > >         - Entry point name.
> > > > >
> > > > > ....
> > > > > Firoz Khan (5):
> > > > >   parisc: move __IGNORE* entries to non uapi header
> > > > >   parisc: add __NR_syscalls along with __NR_Linux_syscalls
> > > > >   parisc: add system call table generation support
> > > > >   parisc: generate uapi header and system call table files
> > > > >   parisc: syscalls: ignore nfsservctl for other architectures
> > > >
> > > > Firoz, you may add
> > > > Acked-by: Helge Deller <deller@gmx.de>
> > > > to the whole parisc series.
> > >
> > > Sure, will do.
> > > I'm on a vacation right now. will send mid next week.
> >
> > That's ok, there is no urgency.
> >
> > Actually, I noticed that the generated files unistd_32.h
> > and unistd_64.h do have the same contents, since on parisc
> > we keep the syscall numbers the same for 32- and 64-bit.
> > With that in mind, we can simply generate on unistd.h
> > file for both variants.
> 
> It depends on what we want to do in the future. When we add
> around 20 new system calls fro y2038, my plan was to
> only add them for 32-bit architectures, leaving holes on
> 64-bit ones. 

Ok, I didn't thought of that.

> We can also assign the new numbers on parisc64 but they would have the
> same entry point as existing calls.

> If you prefer doing it like that, your patch seems fine for that,
> it's just slightly inconsistent with the other 64-bit architectures
> then.

I really prefer to stay in sync with other major architectures.
So, please drop my last patch.

Instead please apply only the next one, which drops the NR_Linux
offset value (which is 0 anyway).

Thanks,
Helge


diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index 6e31f58ad6b5..98dc953656af 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -2,7 +2,6 @@
 #ifndef _UAPI_ASM_PARISC_UNISTD_H_
 #define _UAPI_ASM_PARISC_UNISTD_H_
 
-#define __NR_Linux		0
 #ifdef __LP64__
 #include <asm/unistd_64.h>
 #else
diff --git a/arch/parisc/kernel/syscalls/Makefile b/arch/parisc/kernel/syscalls/Makefile
index defa8878f6d2..4dcc5c9ae7f2 100644
--- a/arch/parisc/kernel/syscalls/Makefile
+++ b/arch/parisc/kernel/syscalls/Makefile
@@ -12,22 +12,18 @@ systbl := $(srctree)/$(src)/syscalltbl.sh
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
 		   '$(syshdr_abis_$(basetarget))'		\
-		   '$(syshdr_pfx_$(basetarget))'		\
-		   '$(syshdr_offset_$(basetarget))'
+		   '$(syshdr_pfx_$(basetarget))'
 
 quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
 		   '$(systbl_abis_$(basetarget))'		\
-		   '$(systbl_abi_$(basetarget))'		\
-		   '$(systbl_offset_$(basetarget))'
+		   '$(systbl_abi_$(basetarget))'
 
 syshdr_abis_unistd_32 := common,32
-syshdr_offset_unistd_32 := __NR_Linux
 $(uapi)/unistd_32.h: $(syscall) $(syshdr)
 	$(call if_changed,syshdr)
 
 syshdr_abis_unistd_64 := common,64
-syshdr_offset_unistd_64 := __NR_Linux
 $(uapi)/unistd_64.h: $(syscall) $(syshdr)
 	$(call if_changed,syshdr)
 
