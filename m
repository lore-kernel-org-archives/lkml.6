Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08225C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B326621746
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="elRaVkC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B326621746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeGFGix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:38:53 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:17446 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753810AbeGFGiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:38:51 -0400
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com [209.85.213.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w666cdo3008510;
        Fri, 6 Jul 2018 15:38:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w666cdo3008510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530859120;
        bh=Jdz1FmgaCZVU4kAVV3DeX993eyJ6E+Nw4qEupWrb8nU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=elRaVkC+UEdS8079e8Ojux7PCmbMYVgFASXoOlWgULYoRmeCWpt73ZUf4zdpiglWL
         i/SGSlEl4c6TjZ4+rRkKYkNOstKUrF9TfBowpA6H8eav6mu7TpEj9U8xa8AhYH5Dpk
         1d3p3SGV3z3/H4rabDSkni2ZjDUaklkiwnaVNBn4SbBotb3sGTmgdmd5pYPWWeWzvZ
         Qz/0SkxK73PAcSoyox5XQ6GmjoCgBy/szOPtNpJ1YyDUFgVOw5Zit6CgFUVmeDneqf
         We5FYfnJ+/2Tg/BxGxPzbBF+yuRbR4FV80GuMwphYeSalc8E2ePAW1OLQngGEzM0lD
         40M+4iv1jNpXA==
X-Nifty-SrcIP: [209.85.213.52]
Received: by mail-vk0-f52.google.com with SMTP id 125-v6so6234922vke.11;
        Thu, 05 Jul 2018 23:38:40 -0700 (PDT)
X-Gm-Message-State: APt69E1jak9YJaWky5t6oHVe9YzoRk0qkpO6hcSsP78U0WzVS0neMgiV
        msMWREmw4IFyXv0OCjVgUC51KJCzpeXDuewfnc0=
X-Google-Smtp-Source: AAOMgpfhRILnVAs8YNKrU6a41eqh4mi69JEfMOsvVUOAQHUQmhyp1fKmXiHVzwqE4WJgikDy7ff0l6/FbarPTHCXJSg=
X-Received: by 2002:a1f:c102:: with SMTP id r2-v6mr5117479vkf.34.1530859119097;
 Thu, 05 Jul 2018 23:38:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 23:37:58 -0700 (PDT)
In-Reply-To: <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems> <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1> <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 6 Jul 2018 15:37:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
Message-ID: <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Gabriel C <nix.or.die@gmail.com>,
        Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch, Andi Kleen <ak@linux.intel.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


2018-07-05 0:08 GMT+09:00 Kirill A. Shutemov <kirill@shutemov.name>:
> On Tue, Jul 03, 2018 at 05:21:50PM +0300, Kirill A. Shutemov wrote:
>> On Tue, Jul 03, 2018 at 03:44:03PM +0300, Kirill A. Shutemov wrote:
>> > On Tue, Jul 03, 2018 at 01:24:49PM +0200, Gabriel C wrote:
>> > > 2018-07-01 23:32 GMT+02:00 Benjamin Gilbert <bgilbert@redhat.com>:
>> > > > On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
>> > > >> 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig,
>> > > >> up to and including 4.17.3, fail to boot on AMD64 running in (at least)
>> > > >> QEMU/KVM.  No messages are shown post-GRUB; the VM instantly reboots.
>> > > >> Reverting commit 194a9749c73d ("x86/boot/compressed/64: Handle 5-level
>> > > >> paging boot if kernel is above 4G") fixes it.  I've attached our kernel
>> > > >> config for reference, and am happy to test patches, provide sample QCOW
>> > > >> images, etc.
>> > > >
>> > >
>> > > Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
>> > >
>> > > 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
>> > > too with the same symptoms
>> >
>> > I tracked it down to -flto in LDFLAGS. I'll look more into this.
>>
>> -flto in LDFLAGS screws up this part of paging_prepare():
>
> +Masahiro, Michal.
>
> I've got it wrong. *Any* LDFLAGS option passed to make this way:
>
>   make LDFLAGS="..."
>
> would cause a issue. Even empty.
>
> It overrides all assignments to the variable in the makefile.
> As result the image is built without -pie and linker doesn't generate
> position independed code.
>
> Looks like the patch below helps, but my make-fu is poor.
> I don't see many override directives in kernel makefiles.
> It makes me think that there's a better way to fix this.
>
> Hm?


LDFLAGS is for internal-use.
Please do not override it from the command line.


You want to pass your own linker flags
for building vmlinux and modules,
but do not want to pass them to
the decompressor (arch/x86/boot/compressed).

Correct?



Kbuild provides a way for users
to pass additional linker flags to modules.
(LDFLAGS_MODULE)


But, there is no way to do that for vmlinux.

It is easy to support it, though.

https://patchwork.kernel.org/patch/10510833/

If this is the one you want, I can merge this.


make LDFLAGS_KERNEL=...  LDFLAGS_MODULE=...
will allow you to append linker flags.





> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index fa42f895fdde..4f24baa8cdeb 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -42,16 +42,16 @@ KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE :=n
>
> -LDFLAGS := -m elf_$(UTS_MACHINE)
> +override LDFLAGS := -m elf_$(UTS_MACHINE)
>  # Compressed kernel should be built as PIE since it may be loaded at any
>  # address by the bootloader.
>  ifeq ($(CONFIG_X86_32),y)
> -LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
> +override LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
>  else
>  # To build 64-bit compressed kernel as PIE, we disable relocation
>  # overflow check to avoid relocation overflow error with a new linker
>  # command-line option, -z noreloc-overflow.
> -LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
> +override LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
>         && echo "-z noreloc-overflow -pie --no-dynamic-linker")
>  endif
>  LDFLAGS_vmlinux := -T
> --
>  Kirill A. Shutemov



-- 
Best Regards
Masahiro Yamada
