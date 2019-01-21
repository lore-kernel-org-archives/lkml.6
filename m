Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B698C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93AC2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548111183;
	bh=LLn7e6zngS8l+68LE/uuWH1EcdVIXOlTC2hJcz3KRII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YfjUH1X1+X5pQk/FHuYNb8d3AmUNn6uBc98Gd2NmjWXebS8PPhhePMZBw54dRabeE
	 p/DL6nnMiQAkB0UL9A/3/4nDriwnJQ/ALlcXky7KSWlnJ1zz3ch5KYtk2nY7ielNcP
	 tZw4WDnDcfoyvvX7fyseo2F2HkfWQanLIjYhSvjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfAUWxB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:53:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39163 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfAUWxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:53:01 -0500
Received: by mail-oi1-f193.google.com with SMTP id i6so15861471oia.6;
        Mon, 21 Jan 2019 14:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RE1kbIAbegVn9X8HfrM9/6EPqvEelSy8K4+3x3//ZGA=;
        b=mjm5nflTcdpDGXRf0TxD3olIbRmygcHCnLyTdZKg/OwyOiL9nHwNTPAQRCxULR4lsL
         FZICFySAY9j7U15ioQLjzZapb280SeUGjd7hHB4cMILbt4ZAuru1Yq5Led3UVxkOehF6
         jwOEMO794YZbhlZGxgJfcpaS/HEsF2KCB6fDJQpAPTiapm7THHefTOBxwVs8jZi/dqzw
         AsKzeyvq2NXLkBadDNk12aYUgqZpjoLJC3R53C7k+Eb0N8YUsp1SnAXMtVOV90Jkh5kW
         Vioj/9bXzrCvE0WaLUY/8ag9HE9aDq1f8mMR++KQl36at8PdH55ii0D0FAUhnEbLYbeA
         T3UA==
X-Gm-Message-State: AJcUukc3F+CDbFKcwzKI6I68GWM87Acq4ILakQ8re7E/4CAAAKwcZZlm
        8g6Ov7J2ifBBljUw07Q7wuPkzNwRK2Lb2ki6W40=
X-Google-Smtp-Source: ALg8bN4ZXdNgr4WBsQib7vp5nJYKT3yx3ddIDIZD86zhCHZywvmLKEmm+u4Bnb9svCFap7u5XJK+VFSzvLTd6Lpzo38=
X-Received: by 2002:aca:368a:: with SMTP id d132mr7106897oia.193.1548111179893;
 Mon, 21 Jan 2019 14:52:59 -0800 (PST)
MIME-Version: 1.0
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
 <20190117221628.GA21979@roeck-us.net> <20190118104215.GA13168@linaro.org>
 <CAKfTPtD9fu06sw8=MvjwfQfJoQHb0kT3un9=kdw+WZj+rbVUZg@mail.gmail.com>
 <CAJZ5v0gFpK3Kqyf=RM+160A3RAQYPs3c3EgxmNH7ZceEaujEUw@mail.gmail.com>
 <9ff86048-fca5-11b9-174c-f0a9338dd231@roeck-us.net> <CAKfTPtA_xfTt9KUAR+P=XAhXXyTdQn5ASm8GRcgnYxFFZT5ADg@mail.gmail.com>
In-Reply-To: <CAKfTPtA_xfTt9KUAR+P=XAhXXyTdQn5ASm8GRcgnYxFFZT5ADg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Jan 2019 23:52:46 +0100
Message-ID: <CAJZ5v0j+Tp5xeBXsrYRn65QDYZgemWbhqm4maCqJuyNGVJ1drQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        "Intel graphics driver community testing & development" 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 4:17 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 18 Jan 2019 at 13:08, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 1/18/19 3:05 AM, Rafael J. Wysocki wrote:
> > > On Fri, Jan 18, 2019 at 11:53 AM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > >>
> > >> On Fri, 18 Jan 2019 at 11:42, Vincent Guittot
> > >> <vincent.guittot@linaro.org> wrote:
> > >>>
> > >>> Hi Guenter,
> > >>>
> > >>> Le Thursday 17 Jan 2019 à 14:16:28 (-0800), Guenter Roeck a écrit :
> > >>>> On Fri, Dec 21, 2018 at 11:33:56AM +0100, Vincent Guittot wrote:
> > >>>>> From: Thara Gopinath <thara.gopinath@linaro.org>
> > >>>>>
> > >>>>> This patch replaces jiffies based accounting for runtime_active_time
> > >>>>> and runtime_suspended_time with ktime base accounting. This makes the
> > >>>>> runtime debug counters inline with genpd and other pm subsytems which
> > >>>>> uses ktime based accounting.
> > >>>>>
> > >>>>> timekeeping is initialized before pm_runtime_init() so ktime_get() will
> > >>>>> be ready before first call. In fact, timekeeping_init() is called early
> > >>>>> in start_kernel() which is way before driver_init() (and that's when
> > >>>>> devices can start to be initialized) called from rest_init() via
> > >>>>> kernel_init_freeable() and do_basic_setup().
> > >>>>>
> > >>>> This is not (always) correct. My qemu "collie" boot test fails with this
> > >>>> patch applied. Reverting the patch fixes the problem. Bisect log attached.
> > >>>>
> > >>>
> > >>> Can you try the patch below ?
> > >>> ktime_get_mono_fast_ns() has the advantage of being init with dummy clock so
> > >>> it can be used at early_init.
> > >>
> > >> Another possibility would be delay the init of the gpiochip
> > >
> > > Well, right.
> > >
> > > Initializing devices before timekeeping doesn't feel particularly
> > > robust from the design perspective.
> > >
> > > How exactly does that happen?
> > >
> >
> > With an added 'initialized' flag and backtrace into the timekeeping code,
> > with the change suggested earlier applied:
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 0 at kernel/time/timekeeping.c:453 ktime_get_mono_fast_ns+0x114/0x12c
> > Timekeeping not initialized
> > CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc2-next-20190117-dirty #2
> > Hardware name: Sharp-Collie
> > Backtrace:
> > [<c000dce8>] (dump_backtrace) from [<c000df78>] (show_stack+0x18/0x1c)
> >   r7:00000009 r6:00000000 r5:c065ba90 r4:c06d3e54
> > [<c000df60>] (show_stack) from [<c0588930>] (dump_stack+0x20/0x28)
> > [<c0588910>] (dump_stack) from [<c0018ae8>] (__warn+0xcc/0xf4)
> > [<c0018a1c>] (__warn) from [<c0018b5c>] (warn_slowpath_fmt+0x4c/0x6c)
> >   r8:df407b08 r7:00000000 r6:c0c01550 r5:c065bad8 r4:c06dd028
> > [<c0018b14>] (warn_slowpath_fmt) from [<c0069e2c>] (ktime_get_mono_fast_ns+0x114/0x12c)
> >   r3:00000000 r2:c065bad8
> >   r5:00000000 r4:df407b08
> > [<c0069d18>] (ktime_get_mono_fast_ns) from [<c03c7810>] (pm_runtime_init+0x38/0xb8)
> >   r9:c06c9a5c r8:df407b08 r7:00000000 r6:c0c01550 r5:00000000 r4:df407b08
> > [<c03c77d8>] (pm_runtime_init) from [<c03b6a34>] (device_initialize+0xb0/0xec)
> >   r7:00000000 r6:c0c01550 r5:00000000 r4:df407b08
> > [<c03b6984>] (device_initialize) from [<c0366d30>] (gpiochip_add_data_with_key+0x9c/0x884)
> >   r7:00000000 r6:c06fca34 r5:00000000 r4:00000000
> > [<c0366c94>] (gpiochip_add_data_with_key) from [<c06b9708>] (sa1100_init_gpio+0x40/0x98)
> >   r10:dfffcd60 r9:c06c9a5c r8:c06dd020 r7:c06dd028 r6:ffffffff r5:00000000
> >   r4:c06fca34
> > [<c06b96c8>] (sa1100_init_gpio) from [<c06ae58c>] (sa1100_init_irq+0x2c/0x3c)
> >   r7:c06dd028 r6:ffffffff r5:c0713300 r4:c06e1070
> > [<c06ae560>] (sa1100_init_irq) from [<c06aab1c>] (init_IRQ+0x20/0x28)
> >   r5:c0713300 r4:00000000
> > [<c06aaafc>] (init_IRQ) from [<c06a7cd0>] (start_kernel+0x254/0x4cc)
> > [<c06a7a7c>] (start_kernel) from [<00000000>] (  (null))
> >   r10:0000717f r9:6901b119 r8:c0000100 r7:00000092 r6:0000313d r5:00000053
> >   r4:c06a7330
> > ---[ end trace 91e1bd00dd7cce32 ]---
>
> Does it means that only the pm_runtime_init is done before
> timekeeping_init() but no update_pm_runtime_accounting() ?

This platform calls device_initialize(), via sa1100_init_irq(), from
init_IRQ() which is in the start_kernel() code path before
timekeeping_init().  That's the initialization of structure fields
alone.

Runtime PM really cannot be used legitimately before driver_init(),
because it needs bus types to be there at least.

> In this case, we can keep using ktimeçget in
> update_pm_runtime_accounting() and find a solution to deal with
> early_call of pm_runtime_init()

Given the above, I think that initializing accounting_timestamp in
pm_runtime_init() to anything different from 0 is a mistake.

Note that update_pm_runtime_accounting() ignores the delta value if
power.disable_depth is not zero anyway, so it really should be
sufficient to update accounting_timestamp when enabling runtime PM -
and I'm not sure why it is not updated in pm_runtime_enable() for that
matter (that looks like a bug to me).
