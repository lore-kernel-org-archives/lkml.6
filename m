Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA60C04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B8F2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B8F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbeKQIJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:09:32 -0500
Received: from mout.gmx.net ([212.227.15.19]:50947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeKQIJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:09:31 -0500
Received: from ls3530.dellerweb.de ([92.116.163.212]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MHXXo-1gKSgw0540-003NQo; Fri, 16 Nov 2018 22:55:06 +0100
Date:   Fri, 16 Nov 2018 22:55:02 +0100
From:   Helge Deller <deller@gmx.de>
To:     Firoz Khan <firoz.khan@linaro.org>, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Helge Deller <deller@gmx.de>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v7 0/5] parisc: system call table generation support
Message-ID: <20181116215502.GA6585@ls3530.dellerweb.de>
References: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org>
 <58c3c4a4-7f55-bf08-1c96-ef1aa7f97072@gmx.de>
 <CALxhOngc1cSSDVznnX+iLg-Ne9+k0ct0wT-z0MXKSeKxJE3Vsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALxhOngc1cSSDVznnX+iLg-Ne9+k0ct0wT-z0MXKSeKxJE3Vsg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:WZfPgxaFlWPHIgWyFZahDkPpRrerxeMIEcXZka3G5FOC1cVTbb8
 9WuDB9GTQfBwaGwyWDpu9SZ9IKzE9in/1Jd/jlmIdrvrNl1bI2wpZ6mnT/pClpUgIzjJE5l
 c1pHrg12QIeK1DR5lfUZpGhhh4UpsSbeuJGGCrHisyIaP0YcKO13NtUULv/ArmfV51cfe5n
 LFre3jDh7iDrLoAbsmA/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PGfJ/vuhSqw=:1+aV31FKogYobrj/miDTqK
 NJGrT+bzy8Y7pVfNxsNwX0+ndMMp2JGkpIj4/mdPnxWFiGugIB6NYbqIfr8fkuii2gmNT9Pkm
 Ticzda7NCIGeX3QuKE6xnJnazDcdleCJkyMJ5/Vxtm2rZlU+ENmQkR5k+v6OA99NTJvQiQOj/
 d1h5O0Fcb8NvmgbYmlnkaavm3O00mY8IVftckMopL+lIvbOO5GaQgPgofu+DeLVe2ybibwG9X
 aCAV36qSBUogmdJXXkbAgjIrDUJA8xdvZEu9nSmKxxn+DlEB3ErSHupOZ6TwdbVjSDLKoT79P
 EyOxMrdd6ZEdabluPlV3kcW1jnDeJnTC4hOwOqSKKrGHxCjOJI74oruKRlcInnPJmTCgbj/5r
 HQTxmlokGDVSgI0DbP9/bEKFLYtXOxVM0PKzZha0Of4qfuerSVbqlx0KPmjN53oXu2LHKNJSH
 FHn1QXEDMvNoSbgtVfOyQ8kxrQKNy6ZVGnLqvt26QghZ4znSCByNre2gMq+baurzoscdOANkI
 t4CMiOyT3xbiDxor2Y98/TW7bQNl3Lab483eBobSXi/GTTT/+ELg/RE+C3Km2027PW0VHToCf
 ieEwwl3nK+9aGyFVERCxHvU0xZ57tNlOpxCcnCD+/2JnAYN7TqE5w2sAnXLr/2JPKE01obPrC
 LEzopC3m50hAD9AnAYysASY9wztwPLSavyN4USiQPApBSdbB31Ok7T4p8y6y1L1QqZvIpsPaW
 v8v7K7R+AimtCBPMFcXIenUW+6HRclWs3SWtoFXpEGB4KUA2Ij36D5wo2uht7XXHjb/B5LcHp
 n6YWf9qIrZV/hA7TXrdtqi81m7jPVdNxVfoO2RMBajwYYi7hcBRWIgLaseEm3D1mTGfWECuG0
 +oJow2UI/9iwbLUmH/Ckx/CnTII/ydvKoVVPq00gE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

> On Fri, 16 Nov 2018 at 01:01, Helge Deller <deller@gmx.de> wrote:
> >
> > On 14.11.2018 07:34, Firoz Khan wrote:
> > > The purpose of this patch series is, we can easily
> > > add/modify/delete system call table support by cha-
> > > nging entry in syscall.tbl file instead of manually
> > > changing many files. The other goal is to unify the
> > > system call table generation support implementation
> > > across all the architectures.
> > >
> > > The system call tables are in different format in
> > > all architecture. It will be difficult to manually
> > > add, modify or delete the system calls in the resp-
> > > ective files manually. To make it easy by keeping a
> > > script and which'll generate uapi header file and
> > > syscall table file.
> > >
> > > syscall.tbl contains the list of available system
> > > calls along with system call number and correspond-
> > > ing entry point. Add a new system call in this arch-
> > > itecture will be possible by adding new entry in the
> > > syscall.tbl file.
> > >
> > > Adding a new table entry consisting of:
> > >         - System call number.
> > >         - ABI.
> > >         - System call name.
> > >         - Entry point name.
> > >
> > > ....
> > > Firoz Khan (5):
> > >   parisc: move __IGNORE* entries to non uapi header
> > >   parisc: add __NR_syscalls along with __NR_Linux_syscalls
> > >   parisc: add system call table generation support
> > >   parisc: generate uapi header and system call table files
> > >   parisc: syscalls: ignore nfsservctl for other architectures
> >
> > Firoz, you may add
> > Acked-by: Helge Deller <deller@gmx.de>
> > to the whole parisc series.
> 
> Sure, will do.
> I'm on a vacation right now. will send mid next week.

That's ok, there is no urgency.

Actually, I noticed that the generated files unistd_32.h
and unistd_64.h do have the same contents, since on parisc
we keep the syscall numbers the same for 32- and 64-bit.
With that in mind, we can simply generate on unistd.h
file for both variants.

Additionally, in the past we had __NR_Linux defined (as 0)
because we initially wanted to support HP-UX syscalls as well,
with NR_Linux being an offset.
The idea to support HP-UX is long gone, so there is no
need to keep that define.

My patch below is on top of your series and cleans up both
items mentioned above.
I suggest you fold it into your patch series before sending
the next version.

Thanks,
Helge

> > >  arch/parisc/Makefile                      |   3 +
> > >  arch/parisc/include/asm/Kbuild            |   3 +
> > >  arch/parisc/include/asm/unistd.h          |   8 +
> > >  arch/parisc/include/uapi/asm/Kbuild       |   2 +
> > >  arch/parisc/include/uapi/asm/unistd.h     | 382 +------------------------
> > >  arch/parisc/kernel/syscall.S              |  11 +-
> > >  arch/parisc/kernel/syscall_table.S        | 459 ------------------------------
> > >  arch/parisc/kernel/syscalls/Makefile      |  57 ++++
> > >  arch/parisc/kernel/syscalls/syscall.tbl   | 369 ++++++++++++++++++++++++
> > >  arch/parisc/kernel/syscalls/syscallhdr.sh |  36 +++
> > >  arch/parisc/kernel/syscalls/syscalltbl.sh |  36 +++
> > >  scripts/checksyscalls.sh                  |   1 +
> > >  12 files changed, 531 insertions(+), 836 deletions(-)


diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index d31b4261cafc..8fdc63ea83ee 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -1,8 +1,7 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generated-y += unistd_32.h
-generated-y += unistd_64.h
+generated-y += unistd.h
 generic-y += auxvec.h
 generic-y += bpf_perf_event.h
 generic-y += kvm_para.h
diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
deleted file mode 100644
index 6e31f58ad6b5..000000000000
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI_ASM_PARISC_UNISTD_H_
-#define _UAPI_ASM_PARISC_UNISTD_H_
-
-#define __NR_Linux		0
-#ifdef __LP64__
-#include <asm/unistd_64.h>
-#else
-#include <asm/unistd_32.h>
-#endif
-
-#define LINUX_GATEWAY_ADDR	0x100
-
-#endif /* _UAPI_ASM_PARISC_UNISTD_H_ */
diff --git a/arch/parisc/kernel/syscalls/Makefile b/arch/parisc/kernel/syscalls/Makefile
index defa8878f6d2..f938acd26145 100644
--- a/arch/parisc/kernel/syscalls/Makefile
+++ b/arch/parisc/kernel/syscalls/Makefile
@@ -12,23 +12,15 @@ systbl := $(srctree)/$(src)/syscalltbl.sh
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
-$(uapi)/unistd_32.h: $(syscall) $(syshdr)
-	$(call if_changed,syshdr)
-
-syshdr_abis_unistd_64 := common,64
-syshdr_offset_unistd_64 := __NR_Linux
-$(uapi)/unistd_64.h: $(syscall) $(syshdr)
+$(uapi)/unistd.h: $(syscall) $(syshdr)
 	$(call if_changed,syshdr)
 
 systbl_abis_syscall_table_32 := common,32
@@ -44,7 +36,7 @@ systbl_abi_syscall_table_c32 := c32
 $(kapi)/syscall_table_c32.h: $(syscall) $(systbl)
 	$(call if_changed,systbl)
 
-uapisyshdr-y		+= unistd_32.h unistd_64.h
+uapisyshdr-y		+= unistd.h
 kapisyshdr-y		+= syscall_table_32.h		\
 			   syscall_table_64.h		\
 			   syscall_table_c32.h
diff --git a/arch/parisc/kernel/syscalls/syscallhdr.sh b/arch/parisc/kernel/syscalls/syscallhdr.sh
index 50242b747d7c..2305707898aa 100644
--- a/arch/parisc/kernel/syscalls/syscallhdr.sh
+++ b/arch/parisc/kernel/syscalls/syscallhdr.sh
@@ -5,7 +5,6 @@ in="$1"
 out="$2"
 my_abis=`echo "($3)" | tr ',' '|'`
 prefix="$4"
-offset="$5"
 
 fileguard=_UAPI_ASM_PARISC_`basename "$out" | sed \
 	-e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
@@ -17,13 +16,8 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 
 	nxt=0
 	while read nr abi name entry compat ; do
-		if [ -z "$offset" ]; then
-			printf "#define __NR_%s%s\t%s\n" \
-				"${prefix}" "${name}" "${nr}"
-		else
-			printf "#define __NR_%s%s\t(%s + %s)\n" \
-				"${prefix}" "${name}" "${offset}" "${nr}"
-		fi
+		printf "#define __NR_%s%s\t%s\n" \
+			"${prefix}" "${name}" "${nr}"
 		nxt=$((nr+1))
 	done
 
@@ -32,5 +26,7 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	printf "#define __NR_syscalls\t%s\n" "${nxt}"
 	printf "#endif\n"
 	printf "\n"
+	printf "#define LINUX_GATEWAY_ADDR\t0x100\n"
+	printf "\n"
 	printf "#endif /* %s */" "${fileguard}"
 ) > "$out"
diff --git a/arch/parisc/kernel/syscalls/syscalltbl.sh b/arch/parisc/kernel/syscalls/syscalltbl.sh
index 45b5bae26240..7627f2d77f61 100644
--- a/arch/parisc/kernel/syscalls/syscalltbl.sh
+++ b/arch/parisc/kernel/syscalls/syscalltbl.sh
@@ -5,7 +5,7 @@ in="$1"
 out="$2"
 my_abis=`echo "($3)" | tr ',' '|'`
 my_abi="$4"
-offset="$5"
+offset=""
 
 emit() {
 	t_nxt="$1"

