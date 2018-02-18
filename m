Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeBRSD2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 13:03:28 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58442 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeBRSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 13:03:27 -0500
Date: Sun, 18 Feb 2018 19:03:37 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yuriy Vostrikov <delamonpansie@gmail.com>
cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: linux acpi (thunderbolt? bug)
In-Reply-To: <CABbc0=QZY8d_Kyd5hX5X99S60ANrncPSk785FpZTAJS+C9_tDQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1802181901520.1549@nanos.tec.linutronix.de>
References: <CABbc0=RMYWGN0L=z_Y=FuZJUDzD5NVa2XBTVnmpZxX5tnk3-5g@mail.gmail.com> <alpine.DEB.2.21.1802141306360.1292@nanos.tec.linutronix.de> <alpine.DEB.2.21.1802150948530.1673@nanos.tec.linutronix.de>
 <CABbc0=QZY8d_Kyd5hX5X99S60ANrncPSk785FpZTAJS+C9_tDQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018, Yuriy Vostrikov wrote:
> On 15 February 2018 at 11:52, Thomas Gleixner <tglx@linutronix.de> wrote:
> > Can you please take snapshots from:
> >
> >     /proc/interrupts
> >     /sys/kernel/debug/irq/*
> >
> > right after boot, after the unplug, before suspend and after resume?
> >
> 
> Apparently, timing is important: problem manifests if the laptop goes
> to sleep shortly after unplug.
> If there is some delay between unplugging and sleeping, then there is
> no problem.
> I'm attaching tar.gz with two runs: run-1 with the problem and run-2
> without. Dumps include output
> of dmesg in time of making a snapshot.
> 
> Hope this clarifies the situation a bit.

Yes. I finally wrapped my brain around it and I can reproduce now after
understanding the root cause. I have no fix yet, but I should have
something for you to test tomorrow.

Thanks for providing all the info.

       tglx
