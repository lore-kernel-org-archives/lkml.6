Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754112AbeBESdO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:33:14 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35877 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753945AbeBESaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:30:01 -0500
X-Google-Smtp-Source: AH8x224KjcTA2EXhvZ8RfXK3LWAptjZ/IcUKnkY3RTjL8Y4oVDakUo6Hn7exsnMUUpLE6Ht9rTaUUg==
Date: Mon, 5 Feb 2018 19:29:57 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
Message-ID: <20180205182957.xbeufjgyhd7pgdvq@gmail.com>
References: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151770009703.7213.12036560755602017391.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMzpN2jeq+LDajvwSALpmaZKOChNX1uhRbuEJ3v97HyOEsH44A@mail.gmail.com>
 <CAPcyv4gy=Oq5=ZXCvs0mgziwfgEb2p+pE9BJZZP47W+4yrz0Vg@mail.gmail.com>
 <CA+55aFzC03b5VASq3xjLhU4WAA=gwqKNT2i6-9OBPQd-G_AHEA@mail.gmail.com>
 <20180205162659.kimgef6dkskc6quq@gmail.com>
 <CALCETrU4S3owtVF5_zVMxH_dXox6HXBbb-Q3+GzTQ-RU_xqgcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrU4S3owtVF5_zVMxH_dXox6HXBbb-Q3+GzTQ-RU_xqgcw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> [...] Clearing R10 is mostly useless in the syscall path because we'll just 
> unconditionally reload it in do_syscall_64().

AFAICS do_syscall_64() doesn't touch R10 at all. So how does it reload R10?

In fact do_syscall_64() as a C function does not touch R10, R11, R12, R13, R14, 
R15 - it passes their values through.

What am I missing?

Thanks,

	Ingo
