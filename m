Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeCRLEX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 07:04:23 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:38028 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeCRLET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 07:04:19 -0400
Date: Sun, 18 Mar 2018 11:04:16 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Srishti Sharma <srishtishar@gmail.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: Unknown symbols in module (iio)
Message-ID: <20180318110416.30b45043@archlinux>
In-Reply-To: <a1ceed29-158a-5ba8-6b05-cddd043baef8@infradead.org>
References: <CAB3L5ow-gf0Z7NCRW1V0v+spRF553zx=J_pwc5m5YXxW4S27Lg@mail.gmail.com>
        <a1ceed29-158a-5ba8-6b05-cddd043baef8@infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Mar 2018 13:42:24 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> [adding linux-iio mailing list]
> 
> Hi,
> 
> It's always a good idea to include the kernel version in a problem report.
> 
> 
> On 03/05/2018 03:17 AM, Srishti Sharma wrote:
> > Hello,
> > I was trying to work with the iio dummy driver, and when I try to load
> > the iio_dummy_evgen.ko module I am getting unknown symbols found in
> > module error on running modprobe.
> > 
> > These variables are unknown
> > iio_bus_type		>>> in industrialio-core
> > irq_sim_init		>>> in iio_dummy_evgen
> > irq_sim_fini		>>> same
> > irq_sim_fire		>>> same
> > irq_sim_fini		>>> [duplicate]  
> 
> I tested this using Linux 4.16-rc5.  As long as I manually load all
> modules in the needed order, they will all load with no symbol problems.
> 
> 
> > All of these variables are present in the Module.symvers file in the
> > /lib/modules/<kernel version>/build directory. The kernel and the
> > modules versions match. I ran make clean, make, and make
> > modules_install before trying to load them. I am unable to figure out
> > the problem. Where I might be going wrong any ideas ?  
> 
> Were you expecting some module autoloading based on their internal
> dependencies?  If so, maybe someone on the linux-iio mailing list
> could comment on that.
> 
> 
Hi Randy,

Thanks for following up on this. Looks like Srishti followed this
with an email to the linux-iio list.  I sent a quick reply but haven't
heard back yet.

https://marc.info/?l=linux-iio&m=152024876720954&w=2

Superficially I was guessing that Srishti had missed the fact that irqsim
is built into the kernel rather than as a module, so a reboot would have
been required as well.

Srishti, if you do try a message on multiple lists, please do it by
replying to the original thread and cc'ing the new one.  That way we save
time by avoiding duplication of efforts on different lists.
(at least I am assuming you sent it to one list then the other?)

Thanks,

Jonathan
