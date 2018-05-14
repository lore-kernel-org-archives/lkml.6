Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbeENOQ6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:16:58 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35441 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbeENOQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:16:55 -0400
X-Google-Smtp-Source: AB8JxZprJAaFLg6VwyiK94IUPgHwynqYzpt+wN/dQAAMoghrBYE4JgNj+V0qqvo0WcotGwrSDLKeufHgZ0Zp63MLi34=
MIME-Version: 1.0
In-Reply-To: <20180514125856.GR12217@hirez.programming.kicks-ass.net>
References: <CAEJqkgjMMMwK0Y7xSJCGVnbPor1MirA30HrN=U2EsGZNRQFs8A@mail.gmail.com>
 <20180514072355.GB12198@hirez.programming.kicks-ass.net> <CAEJqkgh2C_t+pq72Y8uOLYk7nCCtFRnrt1La0hsJL2taa4k35g@mail.gmail.com>
 <20180514125856.GR12217@hirez.programming.kicks-ass.net>
From: Gabriel C <nix.or.die@gmail.com>
Date: Mon, 14 May 2018 16:16:23 +0200
Message-ID: <CAEJqkggEAj+DfsYDKiKJFqn9gfsbZcZ52D1TY13RVh-ZomngWw@mail.gmail.com>
Subject: Re: commit bd9240a18edfbfa72e957fc2ba831cf1f13ea073 seems to break
 with intel-ucode 20180425
To: Peter Zijlstra <peterz@infradead.org>
Cc: kevin.b.stanton@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-14 14:58 GMT+02:00 Peter Zijlstra <peterz@infradead.org>:
> On Mon, May 14, 2018 at 02:15:44PM +0200, Gabriel C wrote:
>> http://ftp.frugalware.org/pub/other/people/crazy/ucode/cpuinfo-ucode-20180312
>> http://ftp.frugalware.org/pub/other/people/crazy/ucode/cpuinfo-ucode-20180425
>
> That's 0xc2 and 0x9e respectively, for the microcode revision.
>
> For model 78 (INTEL_FAM6_SKYLAKE_MOBILE) we need at least 0xb2.
>
> Now, obviously 0xc2 is in fact larger than 0xb2, however 0x9e is
> smaller and it is rightfully complaining.
>
> Now, I have (debian testing):
>
> $ apt-cache show intel-microcode
> Package: intel-microcode
> Version: 3.20180425.1
>
> $ hexdump /lib/firmware/intel-ucode/06-4e-03 | head
> 0000000 0001 0000 00c2 0000 2017 1116 06e3 0004
> 0000010 f699 c6c6 0001 0000 00c0 0000 83d0 0001
> 0000020 8400 0001 0000 0000 0000 0000 0000 0000
>
> Which gives 0xc2 as version for your CPU.
>
> If I download microcode-20180425.tgz from:
>
>   https://downloadcenter.intel.com/download/27776/Linux-Processor-Microcode-Data-File
>
> I again get 0xc2 for 06-4e-03.
>
> So please double check your package...

Yes hexdump matches here too.

I've build a initramfs with the files from microcode-20180425.tgz (
with distro packages removed ) with the same result.

Maybe dracut is doing something stupid .. but  I'm not sure what since
the setup does not change just the ucode files.

I'll try to find out.

>
>> Loading microcode manually is working
>
> IIRC late loading doesn't re-evaluate any of this. If you down-grade you
> can 'wreck' your system.
>
>> Also initramfs is made with dracut and his early microcode option.
>
> Yes, early microcode should be the right thing.

I try to build an kernel with  built-in ucode file without a initrd
and figure whatever that works.
