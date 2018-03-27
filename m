Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeC0QSt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:18:49 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38825 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeC0QSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:18:48 -0400
X-Google-Smtp-Source: AG47ELvXZWuraUGMvGyvBfG6JGlSdlLMP2JIBscZcF0e/OuogDQNtKxdGo3sRYFBDAJhXjv2IIImQA==
Date: Tue, 27 Mar 2018 09:18:47 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Mar 2018 09:18:43 PDT (-0700)
Subject: Re: [tip:irq/core 12/13] drivers/irqchip/irq-vic.c:295:2: error: implicit declaration of function 'set_handle_irq'; did you mean 'vic_handle_irq'?
In-Reply-To: <alpine.DEB.2.21.1803271734170.1964@nanos.tec.linutronix.de>
CC: Arnd Bergmann <arnd@arndb.de>, fengguang.wu@intel.com,
        kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
From: Palmer Dabbelt <palmer@sifive.com>
To: tglx@linutronix.de
Message-ID: <mhng-b8f6e13a-d514-4af3-936e-22dd9ab9a546@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018 08:38:29 PDT (-0700), tglx@linutronix.de wrote:
> On Tue, 27 Mar 2018, Palmer Dabbelt wrote:
>> On Mon, 26 Mar 2018 22:27:36 PDT (-0700), tglx@linutronix.de wrote:
>> >
>> > The commits in tip right now are:
>> >
>> >   cc6c98485f8e ("RISC-V: Move to the new GENERIC_IRQ_MULTI_HANDLER handler")
>> >   caacdbf4aa56 ("genirq: Add CONFIG_GENERIC_IRQ_MULTI_HANDLER")
>> >
>> > I surely can revert them, but I don't see how they would break arm or
>> > anything else.
>>
>> If GENERIC_IRQ_MULTI_HANDLER is set via randconfig then set_handle_irq() is
>> pulled in from the generic code, which conflicts with the definitions in arm,
>> arm64, and openrisc.  The RISC-V commit depends on the genirq one.
>
> Two ways to fix that:
>
>  - Rename set_handle_irq() in tip:irq/core and then convert the rest of the
>    tree over. A few more files touched, but nothing harmful
>
>  - Make GENERIC_IRQ_MULTI_HANDLER depend on !IRQ_MULTI_HANDLER. That should
>    cure it as well

I have a patch set that does the second one, but it's done in a manner that 
assumes the partial patch set got merged.  Let me just send it out...
