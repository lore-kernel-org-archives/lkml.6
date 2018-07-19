Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE638ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D06120673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D06120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbeGSPjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:39:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34406 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731236AbeGSPjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:39:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so7970258ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 07:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OWqGw9tF0JpE0p89oUlhFYfSLniOkh+1b4lYF5kF4gg=;
        b=ug0xgjwuvT5j/oZ9CUe+UAClGO5GuLs3zqQTNFklUiwdkbnbWdUS82tI3LCHK11w19
         pGnqDB3HbS3knoTnjeTT17iKG3wuW573S1j1x4/PZ/xOn4Eq+aFbS3hu95JA+RybKgTQ
         jH/bT4LmrnaT5f/dSWm7ZhQkatNermLKMt0ZRNAuzetCtybn7Rr6fF+Cux1OUEer5EvO
         5IKLIAIB8zj0OGBiu2YatV5NZJMJhs4T4KRzxSthi+KNLbC9lv7Li2tfa6QopfdC1hVG
         isiZOzz43f79sMJgQNXSy3HvPSJ0f+kRimbPnNUXcUSUG0WZf57LA0LFhABAUL/VYm9G
         zq2Q==
X-Gm-Message-State: AOUpUlEx/zDMMz0gr2nmocOUswfcZZkGBDVeI5ki5oc33Qd7Jgp0Zw6T
        I/Z/OvBcYF1mhxIcy0K0GjzR7zaYBHtr+BY9Dml/WA==
X-Google-Smtp-Source: AAOMgpep6/kjrmtepx9zJC+Ltvlj2Oxk7eB/cbVGqH19vLE+IgSABNjopOKXmT3p8eiLUCKeXcotNivNlTX1J1A+0f4=
X-Received: by 2002:a2e:4557:: with SMTP id s84-v6mr7836905lja.47.1532012128266;
 Thu, 19 Jul 2018 07:55:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:81a:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 07:55:27 -0700 (PDT)
In-Reply-To: <d8959ca1-65a1-f59c-bfc4-b048c75add26@arm.com>
References: <1531949864-27447-1-git-send-email-bhsharma@redhat.com> <d8959ca1-65a1-f59c-bfc4-b048c75add26@arm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Thu, 19 Jul 2018 20:25:27 +0530
Message-ID: <CACi5LpOa-BMRSTShS019DDv7MoxNfpnnsqjwR3z13GZC49NrSA@mail.gmail.com>
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
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Jul 19, 2018 at 5:01 PM, James Morse <james.morse@arm.com> wrote:
> Hi Bhupesh,
>
> On 18/07/18 22:37, Bhupesh Sharma wrote:
>> Include KASLR offset in VMCOREINFO ELF notes to assist in debugging.
>>
>> makedumpfile user-space utility will need fixup to use this KASLR offset
>> to work with cases where we need to find a way to translate symbol
>> address from vmlinux to kernel run time address in case of KASLR boot on
>> arm64.
>
> You need the kernel VA for a symbol. Isn't this what kallsyms is for?
> | root@frikadeller:~# cat /proc/kallsyms | grep swapper_pg_dir
> | ffff5404610d0000 B swapper_pg_dir

Its already used by other archs like x86_64. See
'arch/x86/kernel/machine_kexec_64.c' :

void arch_crash_save_vmcoreinfo(void)
{
    <..snip..>
    vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
                  kaslr_offset());
    <..snip..>
}

Its just that we are enabling this feature for arm64 now that the
KASLR boot cases are more widely seen on arm64 boards (as newer EFI
firmware implementations are available which support EFI_RNG_PROTOCOL
and hence KASLR boot).

And we want existing user-space application(s) to work similarly on
arm64 distributions as they work historically on other archs like
x86_64 (in most cases the user-space user is not even aware, if he is
developing for or using an underlying hardware which is arm64 or
x86_64)

> This is the KASLR address, the vmlinux has:
> | root@frikadeller:~/linux/build_arm64# nm -s vmlinux | grep swapper_pg_dir
> | ffff0000096d0000 B swapper_pg_dir
>
>
> This is in the vmcoreinfo too, so you can work if out from the vmcore too:
> | root@frikadeller:~# dd if=/proc/kcore bs=8K count=1 2>/dev/null | strings |
> | grep swapper_pg_dir
> | SYMBOL(swapper_pg_dir)=ffff5404610d0000
>
>
> I picked swapper_pg_dir, but you could use any of the vmcore:SYMBOL() addresses
> to work out this offset. (you should expect the kernel to rename these symbols
> at a whim).
>

Perhaps you missed what the above makedumpfile command was doing, so
let me summarize again:

The above makedumpfile command is trying to 'split' a vmcore file into
smaller sub dumpfiles on the basis of some filtering rules. These
rules are defined via a .conf file (scrub.conf in my example below).

Lets see what MAKEDUMPFILE(8) documents about the '--split' option:

--split
              Split the dump data to multiple DUMPFILEs in parallel.
If specifying DUMPFILEs on different  storage  devices,  a  device
can share I/O load with other devices and it reduces time for saving
the
dump data. The file size of each DUMPFILE is smaller than the system
memory size which is  divided by the number of DUMPFILEs. This feature
supports only the kdump-compressed format.

So, this use-case expects 'vmlinux' and 'vmcore' as mandatory inputs.

Now, coming back to the use-case:

# makedumpfile --split -d 31 -x vmlinux --config scrub.conf vmcore
dumpfile_{1,2,3}

Here, 'scrub.conf ' is defined to erase symbols 'jiffies',
'init_task.utime' and 'tsk.utime'

 # cat > scrub.conf << EOF
   [vmlinux]
   erase jiffies
   erase init_task.utime
   for tsk in init_task.tasks.next within task_struct:tasks
       erase tsk.utime
   endfor
   EOF

This is usually used to erase company-confidential or non-important
symbols from a vmcore before handing it over to a debugger (which uses
this vmcore to determine the root-cause of a crash) - as there can be
some sensitive symbols which a reporter may not want the debugger to
read.

So, in this use case both vmlinux (which contains the symbols) and
vmcore are mandatory inputs and we cannot kallsyms. as it breaks the
existing user-space use-cases and the .conf file can be user-defined
(and hence he can pick any symbol/functions which might not even be
present in 'kallsyms'). So no we cannot use 'kallsyms' here.

Thanks,
Bhupesh
