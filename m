Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754973AbeBOIwD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 03:52:03 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53870 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754967AbeBOIwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 03:52:01 -0500
Date: Thu, 15 Feb 2018 09:52:06 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yuriy Vostrikov <delamonpansie@gmail.com>
cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: linux acpi (thunderbolt? bug)
In-Reply-To: <alpine.DEB.2.21.1802141306360.1292@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1802150948530.1673@nanos.tec.linutronix.de>
References: <CABbc0=RMYWGN0L=z_Y=FuZJUDzD5NVa2XBTVnmpZxX5tnk3-5g@mail.gmail.com> <alpine.DEB.2.21.1802141306360.1292@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018, Thomas Gleixner wrote:
> On Wed, 14 Feb 2018, Yuriy Vostrikov wrote:
> > after sleep 1 time
> > name:   VECTOR
> >  size:   0
> >  mapped: 35
> >  flags:  0x00000041
> > Online bitmaps:        2
> > Global available:    385
> > Global reserved:      12
> > Total allocated:      32
> > System: 41: 0-19,32,50,128,238-255
> >  | CPU | avl | man | act | vectors
> >      0   185     1    18  33-43,46-49,51-53
> >      1   200     1     3  33-37
> 
> The accounting is already screwed. CPU1 claims to have 3 allocated vectors,
> but the allocation bitmap has 5 bits set !?! 
> 
> I have no idea yet how that can happen. Lemme stare into the code some more
> and I came back to you.

Still confused.

Does this happen if you boot w/o the thunderbolt thingy and then do
suspend/resume cycles?

Can you please take snapshots from:

    /proc/interrupts
    /sys/kernel/debug/irq/*

right after boot, after the unplug, before suspend and after resume?

Thanks,

	tglx
