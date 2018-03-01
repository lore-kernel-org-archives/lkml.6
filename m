Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967753AbeCALIj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:08:39 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:40472 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967685AbeCALIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:08:31 -0500
X-Google-Smtp-Source: AG47ELvMPZuIIcn5axSNqIofOPzD1AxbFFNkS4BsJdJPaCTRRsf/1QdHFvDUvqAstxzL9AoMz6VHhZJZoB4+7q7UPgE=
MIME-Version: 1.0
In-Reply-To: <26787.1519902415@warthog.procyon.org.uk>
References: <26787.1519902415@warthog.procyon.org.uk>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 1 Mar 2018 11:08:30 +0000
Message-ID: <CAKv+Gu-gs_HuRW2iuW4GA46USd9cNWiSVbU_efZCxgPWrHcrig@mail.gmail.com>
Subject: Re: linux-next: UEFI Secure boot lockdown patchset
To: David Howells <dhowells@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, jmorris@namei.org,
        jforbes@redhat.com, Matthew Garrett <mjg59@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 1 March 2018 at 11:06, David Howells <dhowells@redhat.com> wrote:
>
> Hi Stephen,
>
> Can you pull the following branch into linux-next please?

Could you please include a URL?

>  It does three
> things:
>
>  (1) It restricts various accesses userspace may make upon the kernel when the
>      kernel is locked down.
>
>  (2) It engages the lockdown if UEFI Secure Boot mode is detected.
>
>  (3) It passes the UEFI Secure Boot mode indication across kexec.
>
> The restrictions include:
>
>  - Enforcing the use of module signatures
>  - Enforcing the use of kexec image signatures
>  - Requring IMA to use secure boot rules
>  - Disabling:
>    - The kexec_load() syscall
>    - Use of /dev/{mem,kmem,port,kcore}
>    - Hibernation
>    - PCI BAR access
>    - Direct I/O port access
>  - Preventing direct port specification in drivers:
>    - SCSI EATA
>    - TIOCSSERIAL
>    - Module parameters
>  - Restricting:
>    - MSR access
>    - Certain ACPI features
>    - kprobes
>    - BPF
>    - Perf
>    - Debugfs
>
> The aim of the restrictions is twofold:
>
>   (1) Prevent userspace from altering the kernel image directly (eg. by
>       /dev/mem) or indirectly (eg. by manipulating a device to do DMA);
>
>   (2) Prevent userspace from accessing crypto data stored in the kernel
>       (eg. filesystem keys).
>
> A warning is logged if a restriction is triggered for which I've written a
> manpage that is referenced in the message (see attached).
>
> David
>
