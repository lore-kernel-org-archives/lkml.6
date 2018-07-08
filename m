Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CCEC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E5D208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c31FduSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E5D208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeGHU70 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 16:59:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44295 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754365AbeGHU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 16:59:25 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so32295092oih.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 13:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sA8BbSVSyVOORYVKyfk4wYA9OJPiuGGxink3IcHB+ss=;
        b=c31FduSrDdjmlknf8FJP3xl9g5cYJtmwbj3xX28MM4fHCZCL+qO8I+YK0fWGWAcqG1
         xbz/Zd4mcI6JqWY9YT86fI7WvEiOpaIq6DBIsR7we2HRhwiIK3mkbvXmL+ebKM2boEV+
         vU1cH2xfUfqhQUH3d9gOCuXBe7NyMjw6paa4GuGlsydFKjDK/pAysrRt3t/1/f2+stGQ
         RqPlMRHWOmK0PaIqtsI8QNdud9EnbfS6s4LOuMUDEyE0NLINNemdS9iiC5i9RhrGIWFA
         6vBhWKiFss8Npvf44qW14KDJOxs97sntpxS34dKfJiWimv37mJ2QzGej2O/JJ/MeCtck
         fOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sA8BbSVSyVOORYVKyfk4wYA9OJPiuGGxink3IcHB+ss=;
        b=punRfl5pSvaXcPLCOHp2Ee+aJQIQy0g9uulTLXg8FvU61AQ/QAvDiTRvsrtPfeKZql
         C6Xxa67MzgkSCR9jfbnhVrrMrU+vOhqTEMCLpKa5Y8fiMheU2oj9QZQtOxI6VkubSOgt
         g051yE8vhjQPPrVY+KZHB8diIk/DI4dFLHUtKVyd35lwk+BOw/KJ3YZYDkZ6JPJAii2f
         3Xycy242v7Iw1u3wUiLS2llRHkgJse1MdIfF17odgAd07oyL6L46DQIgls6RUE1IcsKK
         b+DAK/dtADm99i0CYZdZs26pScWrx+AUF3IzFgaPrVfVJrq6MtsBi4eEc+o+lhETn9SV
         uurw==
X-Gm-Message-State: APt69E26f8QrwXvdDSdyfZZ6Luv4FzKxrxd1ji4uraTc8N9AtrGKJFF+
        e4Hy0FwONuDYhIvkeG4WOXpHEIv3Y4aZO2OPId92TS93
X-Google-Smtp-Source: AAOMgpctgwEyfaYhrVaV+Py0IlC4e3QuxxLXJXDVScb75XAPjRFcqN+qscTV7d4f6ZHPJh8XJnZ5vSH8vzaCh8czNYE=
X-Received: by 2002:aca:4d87:: with SMTP id a129-v6mr22216987oib.256.1531083564632;
 Sun, 08 Jul 2018 13:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <1525881728-4858-1-git-send-email-sudeep.holla@arm.com>
 <CAOi56cUiPX9JYZzZD5isPF3wZwVDenYY-5J39Ch9CFp-eXXtQQ@mail.gmail.com>
 <20180703105357.GC1715@e107155-lin> <CAOi56cW-QsL9gmyF-R9iscZ1M-zM-gJPxcvG=dvB=zrDioZJgA@mail.gmail.com>
 <20180703154459.GA15335@e107155-lin> <alpine.DEB.2.21.1807031805560.1601@nanos.tec.linutronix.de>
 <20180703164823.GB15335@e107155-lin>
In-Reply-To: <20180703164823.GB15335@e107155-lin>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 8 Jul 2018 22:59:13 +0200
Message-ID: <CAFBinCBhBBK1TZnhH1bGrQP5SokaMNrk7C8OcMXaaTcR6_WOTg@mail.gmail.com>
Subject: Re: [PATCH] tick: prefer a lower rating device only if it's CPU local device
To:     sudeep.holla@arm.com, tglx@linutronix.de
Cc:     khilman@baylibre.com, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Jul 3, 2018 at 6:48 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi Thomas,
>
> On Tue, Jul 03, 2018 at 06:08:19PM +0200, Thomas Gleixner wrote:
>
> [...]
>
> > > > / # cat /sys/devices/system/clockevents/broadcast/current_device
> > > > meson6_tick
> > >
> > > OK, it can support broadcast
> > >
> > > > / # cat /sys/devices/system/clockevents/clockevent0/current_device
> > > > dummy_timer
> > > > / # cat /sys/devices/system/clockevents/clockevent1/current_device
> > > > dummy_timer
> > > > / # cat /sys/devices/system/clockevents/clockevent2/current_device
> > > > dummy_timer
> > >
> > > But I can't understand why is dummy_timer the active event source and
> > > not meson6_tick. And you say this is working case ? Looks suspicious.
> >
> > Because if it switches to broadcast mode then the meson timer cannot longer
> > be used as per cpu timer. It's broadcasting to all CPUs via the dummy timer.
>
> Thanks for the explanation. I completely misread the sysfs entry and
> assume clockevent_register failed for meson6 and hence regarded as
> suspicious which is complete non-sense, my bad. Sorry for that.
> I think I now understand the issue.
>
> 1. Juno usecase for which $subject was added as fix:
>
> Two system wide timers(cpumask=possible cpus) with rating 300 and 400.
> When second one with 400 is added, timer with rating 300 is added to
> released list and again added back to main one. In this case both were
> chosen as preferred and that resulted in deadlock.
>
> 2. Meson6 usecase:
>
> When meson6_tick is added, it's set as preferred and dummy_timer is released.
> When it's being added back from the released list, it will be chosen as
> preferred as it's per_cpu resulting in deadlock.
>
> I am not sure how to fix this. Should the fix to my original problem have
> checks for both old and new for per-cpu  to prevent the issue reported on
> Meson6
could you please answer Sudeep's question?

in the meantime I checked Sudpeed's suggestion regarding the TWD
timer: it seems that the Meson8 (Cortex-A9) and Meson8b (Cortex-A5)
SoCs have the ARM TWD (timer watchdog) built-in - Carlo sent a patch
for this a long time ago: [0].
however, I figured out that this doesn't work out-of-the-box anymore:
the TWD seems to be supplied (according to my own tests) by CPU_CLK
div 16 and the interrupt should be IRQ_TYPE_EDGE_RISING
unfortunately we cannot simply add the TWD timer to Meson8 or Meson8b
because this would first require changes to the clock controller
driver (the are currently registered as platform driver, which is too
late for the TWD timer driver)

in other words: we cannot use the TWD timer on the Meson platform in
the v4.18 cycle, so I would prefer a fix of the timer/tick code


Regards
Martin


[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/391928.html
