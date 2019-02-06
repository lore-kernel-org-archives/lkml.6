Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85493C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D76020844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MlE6awYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfBFTeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:34:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37113 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfBFTeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:34:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so3346796pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 11:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E4rlGPsemzimm83Oy1pMjkFO/GjD1tiIiWOtIFgZnMY=;
        b=MlE6awYGU0hMb6wFObsCBhZiAHGQH8HtNAo+2yML80lx/YyyR8/xDcxvSOyIHNSAFm
         UmTxkZiPZpTfhZRU33jfkrPoWCrk1Z+19zxVnwmuaeUQcaNrLY1NqIAxIWz4W1oJ+oG8
         xAUpcWl6A6j6hqaq/POv94B9mY1uycM/77wZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E4rlGPsemzimm83Oy1pMjkFO/GjD1tiIiWOtIFgZnMY=;
        b=P1s90jGE5d09K1EdgPARpw1XfrtNiONt7xWaug03yHBmIldl4zY9hzT3xldEe+qixb
         gwGHzjUrY+uqJ6YAIF/TzacIwnT3ot2H0FuuyLUlX8BtFgUdVVZVgArjQ4d6wYSUUQga
         YEwGEGliz7+4lxT3kukY/dguytHFkn/I9Jl1OArfTtjjLWVb+ZgH7v4dIZtZxK8+2Y57
         U85yb44mfsXi2PMiAfZWEh/XeYlj9l1bA++G71xG60m7zKPrrdqlesDSCEz/FRp7uZPm
         G3wVwwtrLniwmaaJqF62dp2+WL4/BluixHXluvtmXqV7FoLf3D/c8ppqo9LQjpeZJxt5
         LKpg==
X-Gm-Message-State: AHQUAubjMbvkP9JqbputrqcYFRhPNkXHCdD8XDZ1EIhnAlDSoaDgmxPr
        8qQHU3WRFI3aBPLWRk20AW8tPGBgmxw=
X-Google-Smtp-Source: AHgI3IZ6JNL0EXO/h23MDyqZ9Nj/nc9on0zrmewKPPbAIqmaArj1N2eVuMeH3HrVBVcx5dY4e8KfpA==
X-Received: by 2002:a62:3241:: with SMTP id y62mr12107719pfy.178.1549481683219;
        Wed, 06 Feb 2019 11:34:43 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p12sm6644188pfj.81.2019.02.06.11.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 11:34:42 -0800 (PST)
Date:   Wed, 6 Feb 2019 11:34:41 -0800
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
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] arm64: dts: sdm845: wireup the thermal trip
 points to cpufreq
Message-ID: <20190206193441.GJ117604@google.com>
References: <cover.1548093127.git.amit.kucheria@linaro.org>
 <6a21a9ee7663e1b32d8ea81ac5e51d187aed25fb.1548093127.git.amit.kucheria@linaro.org>
 <20190123021251.GJ261387@google.com>
 <20190124233528.GA81583@google.com>
 <20190125222051.GF81583@google.com>
 <CAP245DUy5pe9KQrEX_5iiHg9RtLPHyZcygy6fkrLgsJQYak-_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP245DUy5pe9KQrEX_5iiHg9RtLPHyZcygy6fkrLgsJQYak-_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:05:41PM +0530, Amit Kucheria wrote:
> On Sat, Jan 26, 2019 at 3:50 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > > >                   trips {
> > > > > -                         cpu_alert0: trip0 {
> > > > > +                         cpu0_alert1: trip-point@0 {
> > > > >                                   temperature = <75000>;
> > > >
> > > > In my observations a 'switch on/threshold' temperature of 75 degrees
> > > > leads to aggressive throttling with IPA when the temperature is above
> > > > this threshold:
> > > >
> > > > [  716.760804] cpu_cooling_ratelimit: 31 callbacks suppressed
> > > > [  716.760836] cpu cpu4: Cooling state set to 10. New max freq = 1920000
> > > > [  716.773390] power_allocator_ratelimit: 15 callbacks suppressed
> > > > [  716.773405] thermal thermal_zone5: Controlling power: control_temp=95000 last_temp=73500, curr_temp=75200 total_requested_power=39025 total_granted_power=18654
> > > > [  749.609336] cpu_cooling_ratelimit: 45 callbacks suppressed
> > > > [  749.609371] cpu cpu4: Cooling state set to 11. New max freq = 1843200
> > > > [  749.624300] power_allocator_ratelimit: 24 callbacks suppressed
> > > > [  749.624323] thermal thermal_zone5: Controlling power: control_temp=95000 last_temp=70800, curr_temp=77200 total_requested_power=40136 total_granted_power=17402
> > > > [  780.152633] cpu_cooling_ratelimit: 41 callbacks suppressed
> > > > [  780.152666] cpu cpu4: Cooling state set to 11. New max freq = 1843200
> > > > [  780.165247] power_allocator_ratelimit: 21 callbacks suppressed
> > > > [  780.165261] thermal thermal_zone5: Controlling power: control_temp=95000 last_temp=64800, curr_temp=76900 total_requested_power=39719 total_granted_power=1759
> > > >
> > > > (the logs come from a local patch in our tree:
> > > > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/ec1c501a8093fed44a6697a5913ef2765f518e1f)
> > > >
> > > > At this point I don't have a clear idea what would be a reasonable
> > > > value for the 'switch on/threshold' temperature, but probably it
> > > > should to be higher than 75 degrees, at least with IPA. If there is
> > > > no reasonable common configuration for different thermal governors I
> > > > guess we'll have to target a commonly used governor and systems
> > > > using other 'incompatible' governors need to override the config in
> > > > their <board>.dtsi.
> > >
> 
> Thanks for the elaborate testing and for sharing the numbers. This is
> very useful information.
> 
> > > On my system I don't see a significant delta in core temperatures for
> > > 'threshold' temperatures of 80, 85 or 90°C. However Dhrystone
> > > performance goes up by ~8% when changing the trip point from 80 to
> > > 85°C. For a switch from 85 to 90°C I see a ~2% performance delta. For
> > > all trip points the average core temperatures are ~80°C (silver) and
> > > ~85°C (gold). Interestingly I observed the highest average
> > > temperatures with the trip point at 80°C (repeated measurements were
> > > taken for different temperatures).
> > >
> > > Supposedly LMH throttling is disabled in the firmware I used for
> > > these tests, however data suggests that it is still active
> > > (temperature doesn't rise beyond 95°C, even without throttling in
> > > Linux; Dhrystone performance drops when raising the temperature beyond
> > > 95°C with a heat gun. I will do some more testing when I get my hands
> > > on a FW that effectively disables LMH (or raises the threshold to
> > > something like 105°C).
> > >
> > > From the data collected so far I'd suggest a 'threshold' temperature
> > > of 90°C or if that seems to high 85°C. Behavior might be different
> > > with other thermal governors or without LMH throttling..
> >
> > Some more data from measurements with different trips points, for the
> > IPA and the Fair Share governors, LMH throttling was enabled:
> >
> >                         IPA
> >         Dhrystone       Temp Silver     Temp Gold
> > 75      6M              78.4            84.9
> > 80      6.21M           81.4            89.8
> > 85      6.74M           81.7            88.2
> > 90      6.88M           79.4            84.6
> >
> >                         Fair Share
> >         Dhrystone       Temp Silver     Temp Gold
> > 75      6.63M           80.1            88.5
> > 80      6.71M           80.1            88.5
> > 85      6.77M           81.1            87.8
> > 90      7.12M           81.2            87.8
> 
> Interesting that you get more MIPs out of fair share governor when
> compared to IPA across the board. What devices were providing energy
> cost information (dynamic-power-coefficient) to the IPA engine? Just
> CPU and GPU? Can you point me to those patches in gerrit?

Only the CPUs provide energy cost information, the GPU isn't fully
hooked up in our tree yet. The cause of the delta could be that for
temperatures < 'target' Fair Share only uses the performance states
specified in 'threshold' for throttling (currently only the boost
frequency), while IPA may use the full range of states  of the
'target' trip point.

You can find the patches/configuration here:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+log/refs/sandbox/dianders/190130-wip-tree

arch/arm64/boot/dts/qcom/sdm845.dtsi
arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi

> > Within this range the 'threshold' temperature doesn't seem to have a
> > large impact on the average CPU temperature. There is a bit of
> > fluctuation between individual measurements, I wouldn't be surprised
> > if the outliers of Temp Gold for 75 and 90°C converged more with the
> > other values with some more measurements.
> >
> > I learned how to effectively disable LMH throttling, however with that
> > it was fairly easy to have the CPUs overheat, even with throttling in
> > Linux. If it is feasible at all to run with LMH disabled some more
> > actions will be needed (e.g. attaching a heatsink or interrupt support
> > for thermal sensors instead of polling, ...).
> 
> Given that LMH kicks in at 95 and IPA manages to maintain temperatures
> in the ballpark of 80-90 regardless of the trip point value, I agree
> that we should move the 1st trip point to 90. This will give maximum
> performance. So in "threshold" and "target" terms 90 becomes the
> threshold. And since LMH kicks in at 95, I've left it as the target
> trip.
> 
> These should be sane defaults for upstream and any device can override
> those numbers in their board file.

Sounds good, thanks!

FYI, since I mentioned this earlier: a small heatsink on the SoC
makes a huge difference, with that I didn't encounter thermal
shutdowns during my (limited) tests with LMH disabled. Temperatures
were only slightly higher than with LMH throttling, so it might be
feasible to raise the LMH threshold and only use it as last resort.

Cheers

Matthias
