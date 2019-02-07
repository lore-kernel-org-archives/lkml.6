Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC310C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A697A21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ersh8gdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfBGTKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:10:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40913 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfBGTKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:10:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so343202pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 11:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GDyDUOIcjmBkpfiK+JedZK3SsaFBaz0AaXS81rd9Svc=;
        b=ersh8gdXZOLiRS1fsEnT01jRJXpF7LjhtHTEXIhYnC9nAPQmrXBEvh4J8PPyGMhkzG
         5RNb7+WMP+0R+d7JUy8nCvZeeOPIE0bzhwysXQXBOCTGbZ5Jk8I+d4b0tLZHUWLOgLR3
         VDjBmoBk2/giwOUVADqsQsKQKSGYBbSbiYBpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GDyDUOIcjmBkpfiK+JedZK3SsaFBaz0AaXS81rd9Svc=;
        b=A/pRzBqsV2PCa2CoymU3iQxvSTSeD4Dl5E/0hnbWzJBt3BpOKNSb9956bByZKCugsC
         8ZKMLbh6lcxCOKB3wDdUuN2G3FRQcxdb1kycKUW9HIdUkLMk2hTpukcHd6b4Xu559N4z
         grsyhx5/W1ItIJx0G6lH3zlJOUxtKWSv7bWzblI2F1Sw+jLr1dqq9geVIh+ra8/TIjJ2
         qQ6yPhdRcfNJyNN5vvXntDEK2JP1KXvXOw+UFgCaLHiwsD1aoPPz4w1EHr/dCVIJLiw3
         P3MaP7yoRfUYpl66rE2OH/cJ3kIbCvNdpDQ3gqipcR+q1sgO6COmhosdTMmC5olHpAoQ
         /OuQ==
X-Gm-Message-State: AHQUAuZ8E0b/FJ93UMrCJcPGwBx9qOzRkeMWtuiruXhg5UuFGkZHhXVv
        54NfxohcOPgXFC6M4i7VfNja+g==
X-Google-Smtp-Source: AHgI3IZCoKnav/+3zKI5vOWVlBgS3p1NNBOm2ACGrMGjcAHi5OJCYdjc4jIRjPeXNBBimj2tIOLHRg==
X-Received: by 2002:aa7:8a17:: with SMTP id m23mr5857999pfa.258.1549566616471;
        Thu, 07 Feb 2019 11:10:16 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d16sm11428578pgj.21.2019.02.07.11.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 11:10:15 -0800 (PST)
Date:   Thu, 7 Feb 2019 11:10:13 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 1/1] arm64: dts: sdm845: wireup the thermal trip
 points to cpufreq
Message-ID: <20190207191013.GM117604@google.com>
References: <cover.1548093127.git.amit.kucheria@linaro.org>
 <6a21a9ee7663e1b32d8ea81ac5e51d187aed25fb.1548093127.git.amit.kucheria@linaro.org>
 <20190123021251.GJ261387@google.com>
 <20190124233528.GA81583@google.com>
 <20190125222051.GF81583@google.com>
 <CAP245DUy5pe9KQrEX_5iiHg9RtLPHyZcygy6fkrLgsJQYak-_g@mail.gmail.com>
 <20190206193441.GJ117604@google.com>
 <20190207015727.GK117604@google.com>
 <CAHLCerP+ao3perRN7_ttr0Qkx81oOAxufpYBvWRUJ04zG2Fisg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHLCerP+ao3perRN7_ttr0Qkx81oOAxufpYBvWRUJ04zG2Fisg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 10:09:29AM +0530, Amit Kucheria wrote:
> On Thu, Feb 7, 2019 at 7:27 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Wed, Feb 06, 2019 at 11:34:41AM -0800, Matthias Kaehlcke wrote:
> > > On Wed, Feb 06, 2019 at 04:05:41PM +0530, Amit Kucheria wrote:
> > > > On Sat, Jan 26, 2019 at 3:50 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > > > > > >                   trips {
> > > > > > > > -                         cpu_alert0: trip0 {
> > > > > > > > +                         cpu0_alert1: trip-point@0 {
> > > > > > > >                                   temperature = <75000>;
> > > > > > >
> > > > > > > In my observations a 'switch on/threshold' temperature of 75 degrees
> > > > > > > leads to aggressive throttling with IPA when the temperature is above
> > > > > > > this threshold:
> > > > > > >
> > > > > > > [  716.760804] cpu_cooling_ratelimit: 31 callbacks suppressed
> > > > > > > [  716.760836] cpu cpu4: Cooling state set to 10. New max freq = 1920000
> > > > > > > [  716.773390] power_allocator_ratelimit: 15 callbacks suppressed
> > > > > > > [  716.773405] thermal thermal_zone5: Controlling power: control_temp=95000 last_temp=73500, curr_temp=75200 total_requested_power=39025 total_granted_power=18654
> > > > > > > [  749.609336] cpu_cooling_ratelimit: 45 callbacks suppressed
> > > > > > > [  749.609371] cpu cpu4: Cooling state set to 11. New max freq = 1843200
> > > > > > > [  749.624300] power_allocator_ratelimit: 24 callbacks suppressed
> > > > > > > [  749.624323] thermal thermal_zone5: Controlling power: control_temp=95000 last_temp=70800, curr_temp=77200 total_requested_power=40136 total_granted_power=17402
> > > > > > > [  780.152633] cpu_cooling_ratelimit: 41 callbacks suppressed
> > > > > > > [  780.152666] cpu cpu4: Cooling state set to 11. New max freq = 1843200
> > > > > > > [  780.165247] power_allocator_ratelimit: 21 callbacks suppressed
> > > > > > > [  780.165261] thermal thermal_zone5: Controlling power: control_temp=95000 last_temp=64800, curr_temp=76900 total_requested_power=39719 total_granted_power=1759
> > > > > > >
> > > > > > > (the logs come from a local patch in our tree:
> > > > > > > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/ec1c501a8093fed44a6697a5913ef2765f518e1f)
> > > > > > >
> > > > > > > At this point I don't have a clear idea what would be a reasonable
> > > > > > > value for the 'switch on/threshold' temperature, but probably it
> > > > > > > should to be higher than 75 degrees, at least with IPA. If there is
> > > > > > > no reasonable common configuration for different thermal governors I
> > > > > > > guess we'll have to target a commonly used governor and systems
> > > > > > > using other 'incompatible' governors need to override the config in
> > > > > > > their <board>.dtsi.
> > > > > >
> > > >
> > > > Thanks for the elaborate testing and for sharing the numbers. This is
> > > > very useful information.
> > > >
> > > > > > On my system I don't see a significant delta in core temperatures for
> > > > > > 'threshold' temperatures of 80, 85 or 90°C. However Dhrystone
> > > > > > performance goes up by ~8% when changing the trip point from 80 to
> > > > > > 85°C. For a switch from 85 to 90°C I see a ~2% performance delta. For
> > > > > > all trip points the average core temperatures are ~80°C (silver) and
> > > > > > ~85°C (gold). Interestingly I observed the highest average
> > > > > > temperatures with the trip point at 80°C (repeated measurements were
> > > > > > taken for different temperatures).
> > > > > >
> > > > > > Supposedly LMH throttling is disabled in the firmware I used for
> > > > > > these tests, however data suggests that it is still active
> > > > > > (temperature doesn't rise beyond 95°C, even without throttling in
> > > > > > Linux; Dhrystone performance drops when raising the temperature beyond
> > > > > > 95°C with a heat gun. I will do some more testing when I get my hands
> > > > > > on a FW that effectively disables LMH (or raises the threshold to
> > > > > > something like 105°C).
> > > > > >
> > > > > > From the data collected so far I'd suggest a 'threshold' temperature
> > > > > > of 90°C or if that seems to high 85°C. Behavior might be different
> > > > > > with other thermal governors or without LMH throttling..
> > > > >
> > > > > Some more data from measurements with different trips points, for the
> > > > > IPA and the Fair Share governors, LMH throttling was enabled:
> > > > >
> > > > >                         IPA
> > > > >         Dhrystone       Temp Silver     Temp Gold
> > > > > 75      6M              78.4            84.9
> > > > > 80      6.21M           81.4            89.8
> > > > > 85      6.74M           81.7            88.2
> > > > > 90      6.88M           79.4            84.6
> > > > >
> > > > >                         Fair Share
> > > > >         Dhrystone       Temp Silver     Temp Gold
> > > > > 75      6.63M           80.1            88.5
> > > > > 80      6.71M           80.1            88.5
> > > > > 85      6.77M           81.1            87.8
> > > > > 90      7.12M           81.2            87.8
> > > >
> > > > Interesting that you get more MIPs out of fair share governor when
> > > > compared to IPA across the board. What devices were providing energy
> > > > cost information (dynamic-power-coefficient) to the IPA engine? Just
> > > > CPU and GPU? Can you point me to those patches in gerrit?
> > >
> > > Only the CPUs provide energy cost information, the GPU isn't fully
> > > hooked up in our tree yet. The cause of the delta could be that for
> > > temperatures < 'target' Fair Share only uses the performance states
> > > specified in 'threshold' for throttling (currently only the boost
> > > frequency), while IPA may use the full range of states  of the
> > > 'target' trip point.
> >
> > I saw that in v4 you allow all performance state to be used for
> 
> Yes, I found during my testing that I got better convergence at the
> threshold temperature when I allowed the entire range of operating
> points with almost no decrease in MIPs.
> 
> > throttling at the 'threshold' temperature. With this configuration
> > I get:
> >
> >                Dhrystone      Temp Silver    Temp Gold
> >
> > Fair Share     7.29M          81.4           87.7
> >
> > IPA            7.14M          81.7           88.3
> >
> >
> > I have no good sense why we are seeing more MIPs for IPA than with the
> > previous configuration. As for earlier tests the values are the
> > average from 4 runs.
> 
> I suspect that EAS task placement might be at work here. Were your
> test threads locked to CPUs or were they free to be scheduled around?

The tasks where pinned to CPUs.

It could also be that my previous tests just hit a series of lower
performance runs, there is some level of fluctuation. Temperatures
for both clusters were also lower than with lower 'threshold'
temperatures, which a priori isn't expected.

> > In any case it seems like a reasonable default configuration with the
> > data we have at this point.
> 
> Thanks for your thorough reviews to get this point. Will you send out
> the patches to add support for IPA at some point?

I currently don't have plans to work on this personally, I believe
Quentin Perret has this on his radar. Quentin, please correct me if
I'm wrong, I'm not intending to 'volunteer' you ;-)
