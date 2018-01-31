Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932102AbeAaKJO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 05:09:14 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:52077 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932075AbeAaKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 05:09:11 -0500
X-Google-Smtp-Source: AH8x227v4pfbZyd0Jju02CleZ4xWVvz4abPzpaxqThPGgNrXxU9DYL084atf+L94Cq8GBmybl6RFgg==
Date: Wed, 31 Jan 2018 10:09:06 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/8] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Message-ID: <20180131100906.qdfas2zfoidmbh2b@oak.lan>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-5-git-send-email-daniel.lezcano@linaro.org>
 <20180124163441.7sqq7qny66d6sqrz@oak.lan>
 <02e80d2c-3672-f7e2-dfb2-aed3efc84759@linaro.org>
 <20180125105715.sae3nwvz7u32v4va@oak.lan>
 <b6181a0e-1e64-f343-1f68-ec22e69eac94@linaro.org>
 <20180126121609.qfahclcdamii7a27@oak.lan>
 <301b5fe7-472e-6291-2880-4202de657de8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301b5fe7-472e-6291-2880-4202de657de8@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 02:25:58PM +0100, Daniel Lezcano wrote:
> > Perhaps I should have distinguished more between runtime-meaning-boot-time
> > and runtime-meaning-full-system-operation. To be clear none of my
> > comments are about being able to enable/disable idle injection on a
> > fully running system. It is the impact on multi-platform binaries that
> > attracted my attention.
> > 
> > 
> >> I prefer to keep simple self-encapsulated feature code and make it
> >> evolve to something better instead of sending a blowing patch series
> >> taking into account all possible combinations. Choosing the strategy at
> >> compile time may be look restrictive but we can live with that without
> >> problem and iteratively do the change until the choice becomes the
> >> default strategy selection option.
> > 
> > You won't find me arguing against iterative improvement. However I
> > did observe that the idle injection code consists almost exclusively 
> > of new lines of code. Thus I don't understand why this new code 
> > interferes with cpufreq cooling to the point that the existing cooling
> > options must compiled out of the kernel before we can exploit it.
> > 
> > I can see the combo code does have tentacles in more places but even so
> > I have the same question. What prevents the existing cooling strategy
> > from being compiled at the same time.
> > 
> > You appear to be saying that there's not yet enough infrastructure to
> > decide which type of cooler to instantiate[1] so its OK to hack around
> > the decision by forcing it to be made it at compile time. Even if we
> > want to force a decision by some means, is compile time really the best
> > point to do that?
> 
> For the moment, yes. We are backward compatible, there is no change with
> the current feature.
> 
> I don't see really the point of being so afraid with this compilation
> option, it is not the first time we have compile time code which
> migrates to runtime code. The important thing is we don't break the
> existing.

I guess its because the code that implements the cooling devices doesn't
look like there is any conflict preventing them being enabled at the
same time except. There isn't even that much problem choosing between
cpufreq-only and cpuidle-only during instatiation (preferring cpufreq
for the benefit of existing platforms) although I can see that we cannot
choose between cpufreq-only and combo without extending the DT bindings.


> Having the runtime selection is the objective after improving the CPU
> cooling devices. But this is far from being trivial and will need a
> rework of the cooling device / framework (and the changes grouped in a
> separate patch series).

I guess if I'm in a minority of one then I can agree to disagree at
this point. I don't like build-time only features (for all the distro
centric reasons I've already mentioned) but I'm not that heavily
invested... and look forward to seeing runtime selection implemented.


Daniel.
