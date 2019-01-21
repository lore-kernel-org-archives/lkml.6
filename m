Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ADBC2F42E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B9120879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlA7vQH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfAUPRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:17:14 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52302 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbfAUPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:17:13 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so16812796itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0LAxNscqLDNGxd0m1s6+2GJU2qc+4bB2djDBpm8YmLg=;
        b=VlA7vQH7o+aP9hebMP59nf0yu3QwIUeHmxbrOKBjHjGysuyR6hodieHib7uPesF2vG
         imp8jMteV0rikgkFQ6hq+yu/UJ55nJShhDEBnegY43MOR4Iy5G3lptvxNhCmjUJ1o5oP
         SLtLNA1ghiGvQ/80jn/1bv0LtHtwfqZAwC5g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0LAxNscqLDNGxd0m1s6+2GJU2qc+4bB2djDBpm8YmLg=;
        b=AoX/SgcIalCy/utkiqa7GDsexqDmoFAoedvqpGjq4P38yei7zd/oZcRrEnXknKJgVZ
         FTszL+h/7stFwv6itK6RASA0tN8HLsXPFzPKe3la2zf1ohqLNzsW7nZqWRX42rj07Iyv
         x0F4r+pd34UFj2JmqiTy6Xsmj9OshrnkS0NhYgGoKrlt/SL+uCckobqKD2JpszDW87cO
         7ivDEsrUkvA1jxu/xh4QJLdMDGyhZs0AhVusEfRQTEe7Q5/C7UTd2jAAJxPiOtBPXBsw
         cHh0bYhKux5BxqpcJilnzX0lxKPvCrxgnSS6mdLABxZ8P1QyHqQltSajJCsnlFcy2mqO
         nhzQ==
X-Gm-Message-State: AJcUukdXYWQzX1MpHKi9cwLTR3FZDlWMfAbl1nnLOgF3DGOhfCdz4e2q
        c2I332R2AuIj1z4tJx3uDi/ECVueGyFejKbuX630qA==
X-Google-Smtp-Source: ALg8bN6eaYJ1vYOu5ToMA89/qmiTfEuxtwczkiVdTxhGQ1EFFs9FasKl79cwtJGKY5e7NoPGJjtWWxTze7HOqpTlzx0=
X-Received: by 2002:a02:98d2:: with SMTP id c18mr16380882jak.11.1548083831473;
 Mon, 21 Jan 2019 07:17:11 -0800 (PST)
MIME-Version: 1.0
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
 <20190117221628.GA21979@roeck-us.net> <20190118104215.GA13168@linaro.org>
 <CAKfTPtD9fu06sw8=MvjwfQfJoQHb0kT3un9=kdw+WZj+rbVUZg@mail.gmail.com>
 <CAJZ5v0gFpK3Kqyf=RM+160A3RAQYPs3c3EgxmNH7ZceEaujEUw@mail.gmail.com> <9ff86048-fca5-11b9-174c-f0a9338dd231@roeck-us.net>
In-Reply-To: <9ff86048-fca5-11b9-174c-f0a9338dd231@roeck-us.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Jan 2019 16:17:00 +0100
Message-ID: <CAKfTPtA_xfTt9KUAR+P=XAhXXyTdQn5ASm8GRcgnYxFFZT5ADg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 at 13:08, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 1/18/19 3:05 AM, Rafael J. Wysocki wrote:
> > On Fri, Jan 18, 2019 at 11:53 AM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> On Fri, 18 Jan 2019 at 11:42, Vincent Guittot
> >> <vincent.guittot@linaro.org> wrote:
> >>>
> >>> Hi Guenter,
> >>>
> >>> Le Thursday 17 Jan 2019 =C3=A0 14:16:28 (-0800), Guenter Roeck a =C3=
=A9crit :
> >>>> On Fri, Dec 21, 2018 at 11:33:56AM +0100, Vincent Guittot wrote:
> >>>>> From: Thara Gopinath <thara.gopinath@linaro.org>
> >>>>>
> >>>>> This patch replaces jiffies based accounting for runtime_active_tim=
e
> >>>>> and runtime_suspended_time with ktime base accounting. This makes t=
he
> >>>>> runtime debug counters inline with genpd and other pm subsytems whi=
ch
> >>>>> uses ktime based accounting.
> >>>>>
> >>>>> timekeeping is initialized before pm_runtime_init() so ktime_get() =
will
> >>>>> be ready before first call. In fact, timekeeping_init() is called e=
arly
> >>>>> in start_kernel() which is way before driver_init() (and that's whe=
n
> >>>>> devices can start to be initialized) called from rest_init() via
> >>>>> kernel_init_freeable() and do_basic_setup().
> >>>>>
> >>>> This is not (always) correct. My qemu "collie" boot test fails with =
this
> >>>> patch applied. Reverting the patch fixes the problem. Bisect log att=
ached.
> >>>>
> >>>
> >>> Can you try the patch below ?
> >>> ktime_get_mono_fast_ns() has the advantage of being init with dummy c=
lock so
> >>> it can be used at early_init.
> >>
> >> Another possibility would be delay the init of the gpiochip
> >
> > Well, right.
> >
> > Initializing devices before timekeeping doesn't feel particularly
> > robust from the design perspective.
> >
> > How exactly does that happen?
> >
>
> With an added 'initialized' flag and backtrace into the timekeeping code,
> with the change suggested earlier applied:
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/time/timekeeping.c:453 ktime_get_mono_fa=
st_ns+0x114/0x12c
> Timekeeping not initialized
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc2-next-20190117-dirty #2
> Hardware name: Sharp-Collie
> Backtrace:
> [<c000dce8>] (dump_backtrace) from [<c000df78>] (show_stack+0x18/0x1c)
>   r7:00000009 r6:00000000 r5:c065ba90 r4:c06d3e54
> [<c000df60>] (show_stack) from [<c0588930>] (dump_stack+0x20/0x28)
> [<c0588910>] (dump_stack) from [<c0018ae8>] (__warn+0xcc/0xf4)
> [<c0018a1c>] (__warn) from [<c0018b5c>] (warn_slowpath_fmt+0x4c/0x6c)
>   r8:df407b08 r7:00000000 r6:c0c01550 r5:c065bad8 r4:c06dd028
> [<c0018b14>] (warn_slowpath_fmt) from [<c0069e2c>] (ktime_get_mono_fast_n=
s+0x114/0x12c)
>   r3:00000000 r2:c065bad8
>   r5:00000000 r4:df407b08
> [<c0069d18>] (ktime_get_mono_fast_ns) from [<c03c7810>] (pm_runtime_init+=
0x38/0xb8)
>   r9:c06c9a5c r8:df407b08 r7:00000000 r6:c0c01550 r5:00000000 r4:df407b08
> [<c03c77d8>] (pm_runtime_init) from [<c03b6a34>] (device_initialize+0xb0/=
0xec)
>   r7:00000000 r6:c0c01550 r5:00000000 r4:df407b08
> [<c03b6984>] (device_initialize) from [<c0366d30>] (gpiochip_add_data_wit=
h_key+0x9c/0x884)
>   r7:00000000 r6:c06fca34 r5:00000000 r4:00000000
> [<c0366c94>] (gpiochip_add_data_with_key) from [<c06b9708>] (sa1100_init_=
gpio+0x40/0x98)
>   r10:dfffcd60 r9:c06c9a5c r8:c06dd020 r7:c06dd028 r6:ffffffff r5:0000000=
0
>   r4:c06fca34
> [<c06b96c8>] (sa1100_init_gpio) from [<c06ae58c>] (sa1100_init_irq+0x2c/0=
x3c)
>   r7:c06dd028 r6:ffffffff r5:c0713300 r4:c06e1070
> [<c06ae560>] (sa1100_init_irq) from [<c06aab1c>] (init_IRQ+0x20/0x28)
>   r5:c0713300 r4:00000000
> [<c06aaafc>] (init_IRQ) from [<c06a7cd0>] (start_kernel+0x254/0x4cc)
> [<c06a7a7c>] (start_kernel) from [<00000000>] (  (null))
>   r10:0000717f r9:6901b119 r8:c0000100 r7:00000092 r6:0000313d r5:0000005=
3
>   r4:c06a7330
> ---[ end trace 91e1bd00dd7cce32 ]---

Does it means that only the pm_runtime_init is done before
timekeeping_init() but no update_pm_runtime_accounting() ?
In this case, we can keep using ktime=C3=A7get in
update_pm_runtime_accounting() and find a solution to deal with
early_call of pm_runtime_init()

Vincent
>
> Guenter
