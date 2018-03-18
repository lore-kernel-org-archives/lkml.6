Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753721AbeCRMA0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:00:26 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:46313 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbeCRMAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:00:23 -0400
X-Google-Smtp-Source: AG47ELv4dYul0UripD1upoDJTCtSn6QE+v4MgaIPzDOr/GlLWH5rzZuXxqnkeVVUuJkHGMeu0pLUY2OVt0Vt7phMK2g=
MIME-Version: 1.0
In-Reply-To: <20180318110416.30b45043@archlinux>
References: <CAB3L5ow-gf0Z7NCRW1V0v+spRF553zx=J_pwc5m5YXxW4S27Lg@mail.gmail.com>
 <a1ceed29-158a-5ba8-6b05-cddd043baef8@infradead.org> <20180318110416.30b45043@archlinux>
From: Srishti Sharma <srishtishar@gmail.com>
Date: Sun, 18 Mar 2018 17:30:22 +0530
Message-ID: <CAB3L5owZTL2wBNzS4XRB9zEKfHOqMDM-AkA-t804XdT_Gszhcg@mail.gmail.com>
Subject: Re: Unknown symbols in module (iio)
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 4:34 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
> On Sat, 17 Mar 2018 13:42:24 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
>
>> [adding linux-iio mailing list]
>>
>> Hi,
>>
>> It's always a good idea to include the kernel version in a problem report.
>>
>>
>> On 03/05/2018 03:17 AM, Srishti Sharma wrote:
>> > Hello,
>> > I was trying to work with the iio dummy driver, and when I try to load
>> > the iio_dummy_evgen.ko module I am getting unknown symbols found in
>> > module error on running modprobe.
>> >
>> > These variables are unknown
>> > iio_bus_type                >>> in industrialio-core
>> > irq_sim_init                >>> in iio_dummy_evgen
>> > irq_sim_fini                >>> same
>> > irq_sim_fire                >>> same
>> > irq_sim_fini                >>> [duplicate]
>>
>> I tested this using Linux 4.16-rc5.  As long as I manually load all
>> modules in the needed order, they will all load with no symbol problems.
>>
>>
>> > All of these variables are present in the Module.symvers file in the
>> > /lib/modules/<kernel version>/build directory. The kernel and the
>> > modules versions match. I ran make clean, make, and make
>> > modules_install before trying to load them. I am unable to figure out
>> > the problem. Where I might be going wrong any ideas ?
>>
>> Were you expecting some module autoloading based on their internal
>> dependencies?  If so, maybe someone on the linux-iio mailing list
>> could comment on that.
>>
>>
> Hi Randy,
>
> Thanks for following up on this. Looks like Srishti followed this
> with an email to the linux-iio list.  I sent a quick reply but haven't
> heard back yet.
>
> https://marc.info/?l=linux-iio&m=152024876720954&w=2
>
> Superficially I was guessing that Srishti had missed the fact that irqsim
> is built into the kernel rather than as a module, so a reboot would have
> been required as well.
>
> Srishti, if you do try a message on multiple lists, please do it by
> replying to the original thread and cc'ing the new one.  That way we save
> time by avoiding duplication of efforts on different lists.
> (at least I am assuming you sent it to one list then the other?)

Hey,
I am sorry for the late reply, the solution Jonathan had proposed i.e;
reinstalling the kernel after configuring it for loading the required
modules worked for me, Thank you so much.

Regards,
Srishti

>
> Thanks,
>
> Jonathan
