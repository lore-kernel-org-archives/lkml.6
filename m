Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753889AbeBESrk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:47:40 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:39393 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753830AbeBESr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:47:29 -0500
X-Google-Smtp-Source: AH8x226YbZWKjdhFgAd1PJM0sZGK2lcUnII8QKgpWXhSBDrrz67R6A7Rt750ObgnFICV9PHIX3mV7mEHNSWrdmMOPOs=
MIME-Version: 1.0
In-Reply-To: <20180205182957.xbeufjgyhd7pgdvq@gmail.com>
References: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151770009703.7213.12036560755602017391.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMzpN2jeq+LDajvwSALpmaZKOChNX1uhRbuEJ3v97HyOEsH44A@mail.gmail.com>
 <CAPcyv4gy=Oq5=ZXCvs0mgziwfgEb2p+pE9BJZZP47W+4yrz0Vg@mail.gmail.com>
 <CA+55aFzC03b5VASq3xjLhU4WAA=gwqKNT2i6-9OBPQd-G_AHEA@mail.gmail.com>
 <20180205162659.kimgef6dkskc6quq@gmail.com> <CALCETrU4S3owtVF5_zVMxH_dXox6HXBbb-Q3+GzTQ-RU_xqgcw@mail.gmail.com>
 <20180205182957.xbeufjgyhd7pgdvq@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 5 Feb 2018 13:47:28 -0500
Message-ID: <CAMzpN2iLXsvufY6yHWg7f-r4J+uCW9bA4fVE=ZjEDf7KnrZuRw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
To: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 1:29 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Andy Lutomirski <luto@kernel.org> wrote:
>
>> [...] Clearing R10 is mostly useless in the syscall path because we'll just
>> unconditionally reload it in do_syscall_64().
>
> AFAICS do_syscall_64() doesn't touch R10 at all. So how does it reload R10?
>
> In fact do_syscall_64() as a C function does not touch R10, R11, R12, R13, R14,
> R15 - it passes their values through.
>
> What am I missing?

The syscall ABI uses R10 for the 4th argument instead of RCX, because
RCX gets clobbered by the SYSCALL instruction for RIP.

--
Brian Gerst
