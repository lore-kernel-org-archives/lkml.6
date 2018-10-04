Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81C4C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802122098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbT/DXjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802122098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJDR2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:28:21 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41904 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeJDR2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:28:21 -0400
Received: by mail-yw1-f68.google.com with SMTP id q129-v6so3540101ywg.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 03:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwwfYDJ+cj1RCkEjOr1Yi2gucyGxVZ6x7CodkMiImZc=;
        b=AbT/DXjryqy5dD4vi5J+UVeFqcjAbnwOQ+Q51O7+dejST/gHxQ0Jj9toJFVsMzPaZI
         Rlt4wVefPDrBch9CfwUlyHGytgYBRR4cUfR63uSe91bbAIefZE/851GsW/FGnMlBlzJJ
         jMmoezxJOZmMYYd+x7h6CofX2+2oHmOrFM/8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwwfYDJ+cj1RCkEjOr1Yi2gucyGxVZ6x7CodkMiImZc=;
        b=TzcVfXQrBbDWdz3FkKGLl/FZ2KIf8O/CaSNEanfpVME9WQI2MxE4JExAC17TArxbx+
         w/0z+w80VaWQ2cP4cUEFxexicDagbkWiYOPMFKCFOSaH20i+XjYWTGf3jESWyuV2ItGf
         sAv54BEMc4O2W735FhA/GChlu+cHCCOKqFtnaOjgGy9lMEIeC5j5JHqF/edDCAeKFM9A
         61wH3PHObOwM61IINpYDClD6FSmTdxRkvdXvHZ70SZOh1MG65oho/BnEl4CABWz9EIf0
         XT2dK18pSx2ATSS27c3ERZyRBOzj2GJmfgTtF/Ar9XaVke4hJwaD00aHZYJ9IdajVDbV
         71oQ==
X-Gm-Message-State: ABuFfojhBFObuHtAj6sGuMzq19oBkC310QkK2GikE9s7GC0Ysq6HWiKw
        5drmV5xu+vtrIL4m4/COtlrb7JpEyYdJD27NskLb8A==
X-Google-Smtp-Source: ACcGV615NUMrZgGvp/E2ERJsErxILE9/wXfO92pn+KsrBK4TrF4dyS7Lo2sHvu/DI3PoeEyMI4PaMOT+6AwNAyWXlQg=
X-Received: by 2002:a81:21c1:: with SMTP id h184-v6mr3062517ywh.367.1538649340796;
 Thu, 04 Oct 2018 03:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <1538397784-4214-1-git-send-email-firoz.khan@linaro.org>
 <1538397784-4214-4-git-send-email-firoz.khan@linaro.org> <0741f810-58c9-dcf3-8c1c-93860c08e428@xilinx.com>
 <CALxhOnh4__SMm93Lpr13eHxBTvDnocHzdh3YDxtuogEKg355Vw@mail.gmail.com> <440fc4a0-cd4e-c8fc-9278-928cf5b7cd92@xilinx.com>
In-Reply-To: <440fc4a0-cd4e-c8fc-9278-928cf5b7cd92@xilinx.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 4 Oct 2018 16:05:29 +0530
Message-ID: <CALxhOnhFyb13YZTRFNsvs9FWD7OCzPtbmdzn+V_YepXACVOxiQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] microblaze: uapi header and system call table file generation
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, 3 Oct 2018 at 16:56, Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 3.10.2018 07:08, Firoz Khan wrote:
> > Hi Michal,
> >
> > On Tue, 2 Oct 2018 at 19:37, Michal Simek <michal.simek@xilinx.com> wrote:
> >>
> >> On 1.10.2018 14:43, Firoz Khan wrote:
> >>> System call table generation script must be run to generate
> >>> unistd_32.h and syscall_table.h files. This patch will have
> >>> changes which will invokes the script.
> >>>
> >>> This patch will generate unistd_32.h and syscall_table.h
> >>> files by the syscall table generation script invoked by
> >>> arch/microblaze/Makefile and the generated files against the
> >>> removed files will be identical.
> >>>
> >>> The generated uapi header file will be included in
> >>> uapi/asm/unistd.h and generated system call table support
> >>> file will be included by kernel/syscall_table.S file.
> >>>
> >>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> >>> ---
> >>>  arch/microblaze/Makefile                  |   3 +
> >>>  arch/microblaze/include/asm/Kbuild        |   1 +
> >>>  arch/microblaze/include/uapi/asm/Kbuild   |   1 +
> >>>  arch/microblaze/include/uapi/asm/unistd.h | 411 +-----------------------------
> >>>  arch/microblaze/kernel/syscall_table.S    | 406 +----------------------------
> >>>  5 files changed, 10 insertions(+), 812 deletions(-)
> >>>
> >>> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> >>> index 4f3ab57..cda5e03 100644
> >>> --- a/arch/microblaze/Makefile
> >>> +++ b/arch/microblaze/Makefile
> >>> @@ -81,6 +81,9 @@ all: linux.bin
> >>>  archclean:
> >>>       $(Q)$(MAKE) $(clean)=$(boot)
> >>>
> >>> +archheaders:
> >>> +     $(Q)$(MAKE) $(build)=arch/microblaze/kernel/syscalls all
> >>> +
> >>>  linux.bin linux.bin.gz linux.bin.ub: vmlinux
> >>>       $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> >>>
> >>> diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
> >>> index 569ba9e..d64f5e7 100644
> >>> --- a/arch/microblaze/include/asm/Kbuild
> >>> +++ b/arch/microblaze/include/asm/Kbuild
> >>> @@ -31,3 +31,4 @@ generic-y += trace_clock.h
> >>>  generic-y += vga.h
> >>>  generic-y += word-at-a-time.h
> >>>  generic-y += xor.h
> >>> +generic-y += syscall_table.h
> >>> \ No newline at end of file
> >>
> >> Still the problem with "No newline at end of file"
> >>
> >>> diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
> >>> index 2c6a6bf..3a40659 100644
> >>> --- a/arch/microblaze/include/uapi/asm/Kbuild
> >>> +++ b/arch/microblaze/include/uapi/asm/Kbuild
> >>> @@ -28,3 +28,4 @@ generic-y += termbits.h
> >>>  generic-y += termios.h
> >>>  generic-y += types.h
> >>>  generic-y += ucontext.h
> >>> +generic-y += unistd_32.h
> >>> \ No newline at end of file
> >>
> >> and here too.
> >
> > Thanks for your comment. checkpatch script didn't warn this one:(
> > Hopefully, I can fix this one in the next version.
> >
> > I would appreciate if you can perform the boot test on the actual
> > platform and share the result with me.
>
> I see one issue there.
> Run
> make mrproper
> make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/1/
>
> And then
>
> make mrproper
> make archheaders V=1
> make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/2/
>
> And compare output.
> What I see is that in the first part asm/unistd_32.h pointing to
> asm-generic/unistd_32.h
>
> But when archheaders is run before there is expected content.
>
> That means there is incorrect/missing dependency in Makefiles.
>
>
> Time to time I am able to see compilation warnings
> but I didn't find exact steps to replicate this but it also looks like
> on missing dependency somewhere.
>
> [linux](next)$ make mmu_defconfig
> #
> # configuration written to .config
> #
> [linux](next)$ make -j8 simpleImage.system
>   WRAP    arch/microblaze/include/generated/asm/barrier.h
>   WRAP    arch/microblaze/include/generated/asm/bitops.h
>   WRAP    arch/microblaze/include/generated/asm/bug.h
>   WRAP    arch/microblaze/include/generated/asm/bugs.h
>   WRAP    arch/microblaze/include/generated/asm/device.h
>   WRAP    arch/microblaze/include/generated/asm/compat.h
>   WRAP    arch/microblaze/include/generated/asm/div64.h
>   WRAP    arch/microblaze/include/generated/asm/dma-mapping.h
>   WRAP    arch/microblaze/include/generated/asm/emergency-restart.h
>   WRAP    arch/microblaze/include/generated/asm/exec.h
>   WRAP    arch/microblaze/include/generated/asm/extable.h
>   WRAP    arch/microblaze/include/generated/asm/fb.h
>   WRAP    arch/microblaze/include/generated/asm/hardirq.h
>   WRAP    arch/microblaze/include/generated/asm/irq_regs.h
>   WRAP    arch/microblaze/include/generated/asm/kdebug.h
>   WRAP    arch/microblaze/include/generated/asm/kmap_types.h
>   WRAP    arch/microblaze/include/generated/asm/irq_work.h
>   WRAP    arch/microblaze/include/generated/asm/kprobes.h
>   WRAP    arch/microblaze/include/generated/asm/linkage.h
>   WRAP    arch/microblaze/include/generated/asm/local.h
>   WRAP    arch/microblaze/include/generated/asm/local64.h
>   WRAP    arch/microblaze/include/generated/asm/mcs_spinlock.h
>   WRAP    arch/microblaze/include/generated/asm/mm-arch-hooks.h
>   WRAP    arch/microblaze/include/generated/asm/parport.h
>   WRAP    arch/microblaze/include/generated/asm/percpu.h
>   WRAP    arch/microblaze/include/generated/asm/preempt.h
>   WRAP    arch/microblaze/include/generated/asm/topology.h
>   WRAP    arch/microblaze/include/generated/asm/syscalls.h
>   WRAP    arch/microblaze/include/generated/asm/trace_clock.h
>   WRAP    arch/microblaze/include/generated/asm/vga.h
>   WRAP    arch/microblaze/include/generated/asm/serial.h
>   WRAP    arch/microblaze/include/generated/asm/word-at-a-time.h
>   WRAP    arch/microblaze/include/generated/asm/xor.h
>   HOSTCC  scripts/bin2c
>   HOSTCC  scripts/kallsyms
>   HOSTCC  scripts/dtc/dtc.o
>   HOSTCC  scripts/mod/mk_elfconfig
>   HOSTCC  scripts/sortextable
>   CC      scripts/mod/empty.o
>   HOSTCC  scripts/dtc/flattree.o
>   UPD     include/config/kernel.release
>   HOSTCC  scripts/dtc/fstree.o
>   HOSTCC  scripts/dtc/data.o
>   HOSTCC  scripts/dtc/livetree.o
>   CC      scripts/mod/devicetable-offsets.s
>   HOSTCC  scripts/dtc/treesource.o
>   HOSTCC  scripts/dtc/srcpos.o
>   MKELF   scripts/mod/elfconfig.h
>   UPD     scripts/mod/devicetable-offsets.h
>   HOSTCC  scripts/dtc/checks.o
>   HOSTCC  scripts/dtc/util.o
>   HOSTCC  scripts/mod/sumversion.o
>   LEX     scripts/dtc/dtc-lexer.lex.c
>   YACC    scripts/dtc/dtc-parser.tab.h
>   YACC    scripts/dtc/dtc-parser.tab.c
>   UPD     include/generated/utsrelease.h
>   HOSTCC  scripts/dtc/dtc-lexer.lex.o
>   CC      kernel/bounds.s
>   UPD     include/generated/timeconst.h
>   HOSTCC  scripts/dtc/dtc-parser.tab.o
>   HOSTCC  scripts/mod/file2alias.o
>   HOSTCC  scripts/mod/modpost.o
>   UPD     include/generated/bounds.h
>   CC      arch/microblaze/kernel/asm-offsets.s
> In file included from ./arch/microblaze/include/uapi/asm/unistd.h:14:0,
>                  from ./arch/microblaze/include/asm/unistd.h:12,
>                  from ./include/uapi/linux/unistd.h:8,
>                  from ./arch/microblaze/include/asm/seccomp.h:5,
>                  from ./include/linux/seccomp.h:14,
>                  from ./include/linux/sched.h:21,
>                  from arch/microblaze/kernel/asm-offsets.c:13:
> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:1:35: fatal
> error: asm-generic/unistd_32.h: No such file or directory
>  #include <asm-generic/unistd_32.h>
>                                    ^
> compilation terminated.
> make[1]: *** [arch/microblaze/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2
> make: *** Waiting for unfinished jobs....
>   HOSTLD  scripts/dtc/dtc
>   HOSTLD  scripts/mod/modpost
>
>
>
> When build is fine system is booting fine (v4.19-rc6 + your patches).

Thanks for your support. I'll work on the same which shared above.
I'll update you asap with the fix.

- Firoz

>
> Thanks,
> Michal
>
>
