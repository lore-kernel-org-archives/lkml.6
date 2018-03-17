Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeCQUmi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 16:42:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752726AbeCQUmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 16:42:31 -0400
Subject: Re: Unknown symbols in module (iio)
To: Srishti Sharma <srishtishar@gmail.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <CAB3L5ow-gf0Z7NCRW1V0v+spRF553zx=J_pwc5m5YXxW4S27Lg@mail.gmail.com>
Cc: linux-iio@vger.kernel.org
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a1ceed29-158a-5ba8-6b05-cddd043baef8@infradead.org>
Date: Sat, 17 Mar 2018 13:42:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAB3L5ow-gf0Z7NCRW1V0v+spRF553zx=J_pwc5m5YXxW4S27Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-iio mailing list]

Hi,

It's always a good idea to include the kernel version in a problem report.


On 03/05/2018 03:17 AM, Srishti Sharma wrote:
> Hello,
> I was trying to work with the iio dummy driver, and when I try to load
> the iio_dummy_evgen.ko module I am getting unknown symbols found in
> module error on running modprobe.
> 
> These variables are unknown
> iio_bus_type		>>> in industrialio-core
> irq_sim_init		>>> in iio_dummy_evgen
> irq_sim_fini		>>> same
> irq_sim_fire		>>> same
> irq_sim_fini		>>> [duplicate]

I tested this using Linux 4.16-rc5.  As long as I manually load all
modules in the needed order, they will all load with no symbol problems.


> All of these variables are present in the Module.symvers file in the
> /lib/modules/<kernel version>/build directory. The kernel and the
> modules versions match. I ran make clean, make, and make
> modules_install before trying to load them. I am unable to figure out
> the problem. Where I might be going wrong any ideas ?

Were you expecting some module autoloading based on their internal
dependencies?  If so, maybe someone on the linux-iio mailing list
could comment on that.


-- 
~Randy
