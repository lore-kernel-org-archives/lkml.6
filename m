Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DA8C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A85920852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A85920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbeGYVK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:10:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46985 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbeGYVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:10:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so7705550ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 12:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZnyVhMnjQ9csP7PYxV6MEMFN9O1jEC27W6pJFE9lcaw=;
        b=ZaJpLkhuiCMEt1arqLJ12t/cNAqIepAkIZTG+RJOjjtP2LGsYAQTbMl3WL0aLty94n
         ZFAsxoJB7JAErklui1Zrm2LQQIXme7ujRl9SSyhElZVAHDlNJXTq+sRSzym0W47qQdK6
         1Yg4xePpJAjJCey+JexDf81FSoG5TkVubLapYmpXwBM+6O2BI3OKx1HUf0/vp72SE3Fp
         xDiYLS1G2N2DYvJrrWaNJGyKRpRwRWI4iu7MwzqX6xfpnVeF1wt0baa1sP+zuThJbcAX
         P7YispveWCcsOMUMS+7Yqsd9fU38mUwElG3LdTWbqj4/YTgACilLfvUe4ojRXDCX1Oyx
         Fjyg==
X-Gm-Message-State: AOUpUlG84DEtOTUZICChYB1ydkvhGFrQBigP06enjbvnS/pRaBi676wB
        YaQLbrDvAkggd3xCIRDlXPU42DqH4NSHBrAUyrxjWQ==
X-Google-Smtp-Source: AAOMgpeI2ciBq+DLU6KbKiAk0vrP+48+kTaHIbx2qPhYWk2ZUTVxwqzhLF0cEGL6N1DIhmt0rhmE5me+G9lK9Yfj6o4=
X-Received: by 2002:a2e:4557:: with SMTP id s84-v6mr15981493lja.47.1532548663318;
 Wed, 25 Jul 2018 12:57:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:81a:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 12:57:42 -0700 (PDT)
In-Reply-To: <9c4d7c8d-3f0b-ff2f-68e8-03638a5fe2a4@arm.com>
References: <1531949864-27447-1-git-send-email-bhsharma@redhat.com>
 <d8959ca1-65a1-f59c-bfc4-b048c75add26@arm.com> <CACi5LpOa-BMRSTShS019DDv7MoxNfpnnsqjwR3z13GZC49NrSA@mail.gmail.com>
 <9c4d7c8d-3f0b-ff2f-68e8-03638a5fe2a4@arm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Thu, 26 Jul 2018 01:27:42 +0530
Message-ID: <CACi5LpM9sc+c1M_dAEL9z+Sw6t0Wi1CsQ=M4E1nbQ4RRnkysRw@mail.gmail.com>
Subject: Re: [PATCH] arm64, kaslr: export offset in VMCOREINFO ELF notes
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello James,

On Mon, Jul 23, 2018 at 10:35 PM, James Morse <james.morse@arm.com> wrote:
> Hi Bhupesh,
>
> (CC: +mips list, looks like mips is missing vmcore's KERNELOFFSET too.
> Start of this thread: https://lkml.org/lkml/2018/7/18/951 )

Yes, but the current upstream makedumpfile doesn't seem to contain
mips specific support (please see
<git://git.code.sf.net/p/makedumpfile/code> for details), so I am not
sure they need the 'KERNELOFFSET=' supported in kernel as they are
probably not using it in the user-space.

If someone from the mips list can help suggest if my understanding is
correct it would be great. Just as a side note, I don't have access to
mips hardware, so I will be happy to update the v2 to add mips kernel
bits as well, in case someone is willing to give it a try on their
mips hardware.

> On 19/07/18 15:55, Bhupesh Sharma wrote:
>> On Thu, Jul 19, 2018 at 5:01 PM, James Morse <james.morse@arm.com> wrote:
>>> On 18/07/18 22:37, Bhupesh Sharma wrote:
>>>> Include KASLR offset in VMCOREINFO ELF notes to assist in debugging.
>>>>
>>>> makedumpfile user-space utility will need fixup to use this KASLR offset
>>>> to work with cases where we need to find a way to translate symbol
>>>> address from vmlinux to kernel run time address in case of KASLR boot on
>>>> arm64.
>>>
>>> You need the kernel VA for a symbol. Isn't this what kallsyms is for?
>>> | root@frikadeller:~# cat /proc/kallsyms | grep swapper_pg_dir
>>> | ffff5404610d0000 B swapper_pg_dir
>
>> Its already used by other archs like x86_64.
>> Its just that we are enabling this feature for arm64 now that the
>> KASLR boot cases are more widely seen on arm64 boards (as newer EFI
>> firmware implementations are available which support EFI_RNG_PROTOCOL
>> and hence KASLR boot).
>>
>> And we want existing user-space application(s) to work similarly on
>> arm64 distributions as they work historically on other archs like
>> x86_64 (in most cases the user-space user is not even aware, if he is
>> developing for or using an underlying hardware which is arm64 or
>> x86_64)
>
> Aha, so its ABI. This is the information that should be in the commit message as
> it describes why this patch should be merged.

Sure, will add the description in the commit message of v2.

> ... Ideally core code would do this, that way this information won't be missed
> when an architecture adds KASLR support.
>
> But mips has CONFIG_RANDOMIZE_BASE, and doesn't provide kaslr_offset(),
> and x86 always provides this value, not just if CONFIG_RANDOMIZE_BASE is
> selected. I can't see a way to do this without touching all three architectures.
> (we can try and tidy it up once its clear whether mips needs this too)

Yes, I checked internally at Red Hat and no use-cases for mips
surfaced for this feature. So, if someone from the mips list can help
clarify, it will help me re-write the v2 accordingly.

> I think the patch is fine, but could you re-post it with a commit message that
> describes that vmcore parsing in user-space already expects this value in the
> notes. We're providing it for portability of those existing tools with x86.

Sure.

>>> I picked swapper_pg_dir, but you could use any of the vmcore:SYMBOL() addresses
>>> to work out this offset. (you should expect the kernel to rename these symbols
>>> at a whim).
>>>
>>
>> Perhaps you missed what the above makedumpfile command was doing, so
>> let me summarize again:
>
> Yes, I glossed over it, all that seemed relevant is you are trying to find the
> kernel-va of a symbol from the value in the vmlinux.

Yes, that's correct.

>
>> as it breaks the
>> existing user-space use-cases and the .conf file can be user-defined
>> (and hence he can pick any symbol/functions
>
> My suggestion was you can calculate the offset between the link-time and
> run-time address from information you already have. You just need one of each.
> This would be better as its independent of how the kernel does the relocation.
>
> But, this is irrelevant as 'KERNELOFFSET=' is already an ABI string.

Indeed. We would like to have ABI strings similar across archs.

>> which might not even be present in 'kallsyms').
>
> Eh? How can that happen? I thought even modules had their symbols added to kallsyms.

Sorry, when I re-read my reply, I think I did not explain it better in
terms of the distribution use-cases we usually encounter. Let me try
again:

One of the reason is that existing user-space implementations (for
archs like x86_64), historically use 'vmlinux' for filtering of
symbols from 'vmcore'.

Usually when an end-user uses a distribution kernel on their hardware
and face issues with it, they share the 'vmcore' (crash dump) and
'vmlinux' with the distribution provider. 'vmlinux' can be used by
utilities like gdb/crash-utility to debug the reason for kernel crash.

Let's assume, even if the user manages to save the 'kallsyms' on some
external media (e.g. usb stick) when the kernel crashed, since the
symbol addresses in 'kallsyms' change on each boot (as KASLR
randomizes the same), so we cannot use 'KERNELOFFSET=' to calculate
kaslr offset to the symbols reliably.

For example, let me share the following values of a real use-case:

Let's saw we are looking to find and erase the symbol 'jiffies' from
the vmcore, using (1) - vmlinux and (2) - kallsyms:

(1) vmlinux - Address of 'jiffies' -> 0xffff000009291980
(2) kallsyms - Address of 'jiffies' -> 0xffff4ce385291980 (value seen
during the boot when primary kernel crashed)

In this particular boot, makedumpfile reports 'kaslr_offset' as 0x2934e3000000
So, if we use:
(1) vmlinux - We calculate Address of 'jiffies' as ->
0xffff000009291980 + 0x2934e3000000 = 0xFFFF2934EC291980
(2) kallsyms - We calculate Address of 'jiffies' as ->
0xffff4ce385291980 + 0x2934e3000000 = 0xFFFF761868291980

When we check the 'vmcore' we can see that the address of 'jiffies' is
indeed 0xFFFF2934EC291980 and not 0xFFFF761868291980:

crash> sym jiffies
ffff2934ec291980 (D) jiffies

Since, the address of 'jiffies' pointed to by 'kallsyms' will change
on every boot, its probably not a good source for such user-space
use-cases.

Will send out a v2 shortly (after waiting for some inputs from the mips guys).

Thanks,
Bhupesh
