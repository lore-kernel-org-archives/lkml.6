Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeC0PbN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:31:13 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:40396 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752591AbeC0PbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:31:12 -0400
X-Google-Smtp-Source: AG47ELvb+J4IYNco1VhZ7Yq+H5WWRKjqU96RLX6UGN05j85e9733P/+K+Vl19QWA5b+2Xe9FMYio2w==
Date: Tue, 27 Mar 2018 08:31:10 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Mar 2018 08:30:43 PDT (-0700)
Subject: Re: [tip:irq/core 12/13] drivers/irqchip/irq-vic.c:295:2: error: implicit declaration of function 'set_handle_irq'; did you mean 'vic_handle_irq'?
In-Reply-To: <alpine.DEB.2.21.1803270726140.1537@nanos.tec.linutronix.de>
CC: Arnd Bergmann <arnd@arndb.de>, fengguang.wu@intel.com,
        kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
From: Palmer Dabbelt <palmer@sifive.com>
To: tglx@linutronix.de
Message-ID: <mhng-71f262e9-b9a8-4dd8-9657-955d76aab956@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018 22:27:36 PDT (-0700), tglx@linutronix.de wrote:
> On Mon, 26 Mar 2018, Palmer Dabbelt wrote:
>> On Mon, 26 Mar 2018 01:07:54 PDT (-0700), Arnd Bergmann wrote:
>> > On Tue, Mar 20, 2018 at 6:52 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
>> > > On Tue, 20 Mar 2018 00:53:21 PDT (-0700), tglx@linutronix.de wrote:
>> > > >
>> > > > On Tue, 20 Mar 2018, kbuild test robot wrote:
>> > > >
>> > > > > Hi Palmer,
>> > > > >
>> > > > > FYI, the error/warning still remains.
>> > > >
>> > > >
>> > > > Zapped the commit as well...
>> > >
>> > >
>> > > Sorry, I got the flu at ELC and have been offline for a bit.  It looks
>> > > like
>> > > you've kept the IRQ and RISC-V patches, I'll fix up the others are
>> > > re-submit
>> > > them as a separate patch set.
>> >
>> > Not sure which patches are in flight at the moment. To get a clean build
>> > on arm32 and arm64 randconfig kernels, I needed the fixup below
>> > on top of linux-next (not meant to be applied like this, just for
>> > reference).
>>
>> Thanks, I missed these during my original patch submission.  I think the
>> cleanest way to submit this is to spin a whole new patch set, including those
>> that are already in tip.  Would it be possible to just remove my IRQ cleanups
>> from tip so I can try again?
>
> The commits in tip right now are:
>
>   cc6c98485f8e ("RISC-V: Move to the new GENERIC_IRQ_MULTI_HANDLER handler")
>   caacdbf4aa56 ("genirq: Add CONFIG_GENERIC_IRQ_MULTI_HANDLER")
>
> I surely can revert them, but I don't see how they would break arm or
> anything else.

If GENERIC_IRQ_MULTI_HANDLER is set via randconfig then set_handle_irq() is 
pulled in from the generic code, which conflicts with the definitions in arm, 
arm64, and openrisc.  The RISC-V commit depends on the genirq one.
