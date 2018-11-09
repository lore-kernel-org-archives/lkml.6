Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAF5C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF49220840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF49220840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeKIToQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:44:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:43734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727596AbeKIToP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:44:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29681AD94;
        Fri,  9 Nov 2018 10:04:21 +0000 (UTC)
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
To:     Li Zhijian <zhijianx.li@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org,
        hpa@zytor.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        QEMU Developers <qemu-devel@nongnu.org>,
        Philip Li <philip.li@intel.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
 <CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
 <c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
 <20181109072015.GA86700@gmail.com>
 <38905d35-29af-b522-1629-b13e98a47a42@intel.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
Date:   Fri, 9 Nov 2018 11:04:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <38905d35-29af-b522-1629-b13e98a47a42@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 10:57, Li Zhijian wrote:
> On 11/9/2018 3:20 PM, Ingo Molnar wrote:
>> * Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>>
>>>> If the kernel initrd creation process creates an initrd which
>>>> is larger than 2GB and also claims that it can't be placed
>>>> with any part of it above 2GB, then that sounds like a bug
>>>> in the initrd creation process...
>>> Exactly, it's a real problem.
>>>
>>> Add x86 maintainers and LKML:
>>>
>>> The background is that QEMU want to support up to 4G initrd. but
>>> linux header (
>>> initrd_addr_max field) only allow 2G-1.
>>> Is one of the below approaches reasonable:
>>> 1) change initrd_addr_max to 4G-1 directly
>>> simply(arch/x86/boot/header.S)?
>>> 2) lie QEMU bootloader the initrd_addr_max is 4G-1 even though header
>>> said 2G-1
>>> 3) any else
>> A 10 years old comment from hpa says:
>>
>>    initrd_addr_max: .long 0x7fffffff
>>                                          # (Header version 0x0203 or
>> later)
>>                                          # The highest safe address for
>>                                          # the contents of an initrd
>>                                          # The current kernel allows
>> up to 4 GB,
>>                                          # but leave it at 2 GB to avoid
>>                                          # possible bootloader bugs.
>>
>> To avoid the potential of bugs lurking in dozens of major and hundreds of
>> minor iterations of various Linux bootloaders I'd prefer a real solution
>> and extend it - because if there's a 2GB initrd for some weird reason
>> today there might be a 4GB one in two years.
> 
> thank a lots. that's amazing.
> 
> 
>>
>> The real solution would be to:
>>
>>   - Extend the boot protocol with a 64-bit field, named initrd_addr64_max
>>     or such.
>>   - We don't change the old field - but if the new field is set by new
>>     kernels then new bootloaders can use that as a new initrd_addr64_max
>>     value. (or reject to load the kernel if the address is too high.)
>>
>>   - The kernel build should also emit a warning when building larger than
>>     2GB initrds, with a list of bootloaders that support the new
>> protocol.
> 
> Actually i just knew QEMU(Seabios + optionrom(linuxboot_dma.bin)) can
> support ~4GB initrd so far.
> 
> i just drafted at patch to add this field. could you have a look.
> another patch which is to document initrd_addr64_max is ongoing.
> 
> commit db463ac9c1975f115d1ce2acb82d530c2b63b888
> Author: Li Zhijian <lizhijian@cn.fujitsu.com>
> Date:   Fri Nov 9 17:24:14 2018 +0800
> 
>     x86: Add header field initrd_addr64_max
>         Years ago, kernel had support load ~4GB initrd. But for some
> weird reasons (
>     avoid possible bootloader bugs), it only allow leave initrd under
> 2GB address
>     space(see initrd_addr_max fild at arch/x86/boot/header.S).
>         So modern bootloaders have not chance to load >=2G initrd
> previously.
>         To avoid the potential of bugs lurking in dozens of major and
> hundreds of
>     minor iterations of various Linux bootloaders. Ingo suggests to add
> a new field
>     initrd_addr64_max. If bootloader believes that it can load initrd to
>>=2G
>     address space, it can use initrd_addr64_max as the maximum loading
> address in
>     stead of the old field initrd_addr_max.
> 
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 4c881c8..5fc3ebe 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -300,7 +300,7 @@ _start:
>         # Part 2 of the header, from the old setup.S
>  
>                 .ascii  "HdrS"          # header signature
> -               .word   0x020e          # header version number (>= 0x0105)
> +               .word   0x020f          # header version number (>= 0x0105)
>                                         # or else old loadlin-1.5 will
> fail)
>                 .globl realmode_swtch
>  realmode_swtch:        .word   0, 0            # default_switch, SETUPSEG
> @@ -562,6 +562,12 @@ acpi_rsdp_addr:            .quad 0                
> # 64-bit physical pointer to the
>                                                 # ACPI RSDP table, added
> with
>                                                 # version 2.14
>  
> +#ifdef CONFIG_INITRD_SIZE_4GB
> +initrd_addr64_max:     .quad 0xffffffff        # allow ~4G initrd since
> 2.15
> +#else
> +initrd_addr64_max:     .quad 0

Shouldn't this be 0x7fffffff?

And please update Documentation/x86/boot.txt


Juergen
