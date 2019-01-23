Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B3BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C086C20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548240869;
	bh=uSX6wdt9waP9K4u3d7fz6mjVyR0FQDgQ1AV7QQ/HQm4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ijGC4X2jWq2ArNXeqUP2LrKahToXUfoXilQ5QOR++1nMuqb2KIoH6WVJCRYKpniZd
	 ceizXX2G6uc8mkowKMUgx4jRBeOhS+1kszJyWNt7QEf6DstFje6iXe6Oc6VsjORkyb
	 oUdsAgJ4aPLmOq/o+lhoH8NsB6+66/L7j6ANkN2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbfAWKy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:54:28 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43547 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfAWKy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:54:28 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so1398152oie.10;
        Wed, 23 Jan 2019 02:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=px02LkENgu1f5T4rR04KN0O9r8/RVGgCr626rw5O2Oo=;
        b=fHfbT+S+JjEIJVN3G0z+UCuIyMl6RsOIZxMvGr4D1Lqbj5OFkvFk4XaB9oDHky6+gn
         W18XNUy8ZjmRWdCylF8g88T/I1pLhXWrC6P24oJn5XMjIm7HQ+PbFu31cDzFqUbfgBkT
         7BNsj0+zvbg5iN2NwjhLbEqllM87oXj9uMKkywgnl2ibRyFf3/Cck9f6CdmX2PyyH9RB
         pZTeN50jejqbSsRvV45+U+UULcx+CMglZAJRHChG3++cMA5P+7uXErmI2On8Q4s4FAFD
         7qIed8hpd+KeDEkbxFrVyPWXsu/UAnJL9vcpYK3TNbaryYmZOeg+cQwzURio+wowKvYT
         Fs3g==
X-Gm-Message-State: AJcUukeh+PI5UURv3zXb1GUaa2XXqp1W7YM3U5YTOb4VlwNqwG4Xi7E6
        Jh8hl6CkEKpwcOcQKuhya2ZGGmjcz0yPDRjodDc=
X-Google-Smtp-Source: ALg8bN4tVw67qegqyGImoVH7sx8nHQJSKBWNofC53hdHde+kHWUj1Ee44/Cop8ndAWseemLzqWjYFX7tF7FU9LB77Ss=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr1031225oix.246.1548240867005;
 Wed, 23 Jan 2019 02:54:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548084260.git.amit.kucheria@linaro.org>
 <3f3e38e55c2de4b730fd7c6aa30c125f3a6a8704.1548084260.git.amit.kucheria@linaro.org>
 <20190123103451.ap5vws3kj2ch4uba@vireshk-i7> <CAP245DWTyaOFhS3SYwAmLGpczQo9JR+gsDbGdHAnoxpTWayjgg@mail.gmail.com>
In-Reply-To: <CAP245DWTyaOFhS3SYwAmLGpczQo9JR+gsDbGdHAnoxpTWayjgg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Jan 2019 11:54:15 +0100
Message-ID: <CAJZ5v0hhjDpSgizMazsbXiOyEhycyVihdMmsT_i7eAQ7K6vqAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] thermal: cpu_cooling: Require thermal core to be
 compiled in
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:53 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Wed, Jan 23, 2019 at 4:04 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 21-01-19, 21:10, Amit Kucheria wrote:
> > > The CPU cooling driver (cpu_cooling.c) allows the platform's cpufreq
> > > driver to register as a cooling device and cool down the platform by
> > > throttling the CPU frequency. In order to be able to auto-register a
> > > cpufreq driver as a cooling device from the cpufreq core, we need access
> > > to code inside cpu_cooling.c which, in turn, accesses code inside
> > > thermal core.
> > >
> > > CPU_FREQ is a bool while THERMAL is tristate.  In some configurations
> > > (e.g. allmodconfig), CONFIG_THERMAL ends up as a module while
> > > CONFIG_CPU_FREQ is compiled in. This leads to following error:
> > >
> > > drivers/cpufreq/cpufreq.o: In function `cpufreq_offline':
> > > cpufreq.c:(.text+0x407c): undefined reference to `cpufreq_cooling_unregister'
> > > drivers/cpufreq/cpufreq.o: In function `cpufreq_online':
> > > cpufreq.c:(.text+0x70c0): undefined reference to `of_cpufreq_cooling_register'
> > >
> > > Given that platforms using CPU_THERMAL usually want it compiled-in so it
> > > is available early in boot, make CPU_THERMAL depend on THERMAL being
> > > compiled-in instead of allowing it to be a module.
> > >
> > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  drivers/thermal/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > index 30323426902e..58bb7d72dc2b 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -152,6 +152,7 @@ config CPU_THERMAL
> > >       bool "generic cpu cooling support"
> > >       depends on CPU_FREQ
> > >       depends on THERMAL_OF
> > > +     depends on THERMAL=y
> > >       help
> > >         This implements the generic cpu cooling mechanism through frequency
> > >         reduction. An ACPI version of this already exists
> >
> > Please remove all Kconfig crap, which gets fixed with this, as well in
> > this patch itself. Like:
>
> OK, I planned to if/when this series was accepted. Will send out a patch.

You can make it part of this series, though.
