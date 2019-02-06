Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EF5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B93218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sdg2xeNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfBFKfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:35:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37224 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbfBFKfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:35:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id t33so7254131qtt.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 02:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WTp6d8wsUfkoz8M0kDuucmaRryRkSf8iLwvoCDmhouw=;
        b=Sdg2xeNRtEdn94o0HSifbZrzFlosAaI8xj3YL9SZyW8LDNOb0cDT3ok7hN9rP1n6We
         HqhPWZAtYUETgV8WqXZCREfapsIXe8/etpTAEDlLo3AWlxppkQJz5eoWZnVhOg+J3jqE
         dZBHjOtakb8nVC8yemxsF+47D0nHcxYWct7xowIaBTCHrSwfphoefKSI4jM0GkFOTrOs
         0Zkv5NdViHHKfQ1ImmQQ9+vmaKRdVUOWEZonk1CCHZEqo9Im4pi9C//jw8kyDF8plRmz
         82W7IrrBM0VYjpJK+G+WwKyqmH6aqET3d40ywikpgOvTPj5gBicPTh89ajKuL6mihm+5
         Zn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WTp6d8wsUfkoz8M0kDuucmaRryRkSf8iLwvoCDmhouw=;
        b=kIVUCZ/zBDQC3oa++7erKANzkVN6HKZ9tcQjV819Vh6/S46ZkxV9sgv/k1LNyWjQGS
         P2kwTDxggFRaBAq/XxysGCkIehJxPqq0bIb7wOwOB/PqtWidnrac3u1/2/PSTpLPVCgy
         FqOVRdeWZ8L+h52fvYlr+Fajr1RzKyL26HkIDjtfiRXuWASbFXXUvgkgAzBtM3sZ3nqO
         A7QNU1qjU4gVzEhBFuAqv/b0F3yJii+f8BWSsdoOhq8cJJRCkN39wtF8OzrrOgmW7p5U
         JdtvmqL137aPwojjyCBwB6kNvb0+Fqsk9tEGC/kLagDp4Tsl/5jTry2Py+IfF3jzidEw
         5Ing==
X-Gm-Message-State: AHQUAub/n8rAvPFjpQwYAH8inhV0ifZKBd0k0zW3K+0IECZxD2XI35Of
        gzRut82xB2IQJYPBraOMBAacm2RLHjcl4pEIX5WIQA==
X-Google-Smtp-Source: AHgI3Ib821MV4JMfJDVXPIrcQO/IjsB/Y7o8nZe9Wa50Vlnp2J8kZprYtK2UBOZwENZnyw+FtKLnow+4E4zyeyoMIyo=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr7192666qts.144.1549449353192;
 Wed, 06 Feb 2019 02:35:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548093127.git.amit.kucheria@linaro.org>
 <6a21a9ee7663e1b32d8ea81ac5e51d187aed25fb.1548093127.git.amit.kucheria@linaro.org>
 <20190123021251.GJ261387@google.com> <20190124233528.GA81583@google.com> <20190125222051.GF81583@google.com>
In-Reply-To: <20190125222051.GF81583@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 6 Feb 2019 16:05:41 +0530
Message-ID: <CAP245DUy5pe9KQrEX_5iiHg9RtLPHyZcygy6fkrLgsJQYak-_g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] arm64: dts: sdm845: wireup the thermal trip points
 to cpufreq
To:     Matthias Kaehlcke <mka@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 3:50 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > >                   trips {
> > > > -                         cpu_alert0: trip0 {
> > > > +                         cpu0_alert1: trip-point@0 {
> > > >                                   temperature =3D <75000>;
> > >
> > > In my observations a 'switch on/threshold' temperature of 75 degrees
> > > leads to aggressive throttling with IPA when the temperature is above
> > > this threshold:
> > >
> > > [  716.760804] cpu_cooling_ratelimit: 31 callbacks suppressed
> > > [  716.760836] cpu cpu4: Cooling state set to 10. New max freq =3D 19=
20000
> > > [  716.773390] power_allocator_ratelimit: 15 callbacks suppressed
> > > [  716.773405] thermal thermal_zone5: Controlling power: control_temp=
=3D95000 last_temp=3D73500, curr_temp=3D75200 total_requested_power=3D39025=
 total_granted_power=3D18654
> > > [  749.609336] cpu_cooling_ratelimit: 45 callbacks suppressed
> > > [  749.609371] cpu cpu4: Cooling state set to 11. New max freq =3D 18=
43200
> > > [  749.624300] power_allocator_ratelimit: 24 callbacks suppressed
> > > [  749.624323] thermal thermal_zone5: Controlling power: control_temp=
=3D95000 last_temp=3D70800, curr_temp=3D77200 total_requested_power=3D40136=
 total_granted_power=3D17402
> > > [  780.152633] cpu_cooling_ratelimit: 41 callbacks suppressed
> > > [  780.152666] cpu cpu4: Cooling state set to 11. New max freq =3D 18=
43200
> > > [  780.165247] power_allocator_ratelimit: 21 callbacks suppressed
> > > [  780.165261] thermal thermal_zone5: Controlling power: control_temp=
=3D95000 last_temp=3D64800, curr_temp=3D76900 total_requested_power=3D39719=
 total_granted_power=3D1759
> > >
> > > (the logs come from a local patch in our tree:
> > > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/ec1=
c501a8093fed44a6697a5913ef2765f518e1f)
> > >
> > > At this point I don't have a clear idea what would be a reasonable
> > > value for the 'switch on/threshold' temperature, but probably it
> > > should to be higher than 75 degrees, at least with IPA. If there is
> > > no reasonable common configuration for different thermal governors I
> > > guess we'll have to target a commonly used governor and systems
> > > using other 'incompatible' governors need to override the config in
> > > their <board>.dtsi.
> >

Thanks for the elaborate testing and for sharing the numbers. This is
very useful information.

> > On my system I don't see a significant delta in core temperatures for
> > 'threshold' temperatures of 80, 85 or 90=C2=B0C. However Dhrystone
> > performance goes up by ~8% when changing the trip point from 80 to
> > 85=C2=B0C. For a switch from 85 to 90=C2=B0C I see a ~2% performance de=
lta. For
> > all trip points the average core temperatures are ~80=C2=B0C (silver) a=
nd
> > ~85=C2=B0C (gold). Interestingly I observed the highest average
> > temperatures with the trip point at 80=C2=B0C (repeated measurements we=
re
> > taken for different temperatures).
> >
> > Supposedly LMH throttling is disabled in the firmware I used for
> > these tests, however data suggests that it is still active
> > (temperature doesn't rise beyond 95=C2=B0C, even without throttling in
> > Linux; Dhrystone performance drops when raising the temperature beyond
> > 95=C2=B0C with a heat gun. I will do some more testing when I get my ha=
nds
> > on a FW that effectively disables LMH (or raises the threshold to
> > something like 105=C2=B0C).
> >
> > From the data collected so far I'd suggest a 'threshold' temperature
> > of 90=C2=B0C or if that seems to high 85=C2=B0C. Behavior might be diff=
erent
> > with other thermal governors or without LMH throttling..
>
> Some more data from measurements with different trips points, for the
> IPA and the Fair Share governors, LMH throttling was enabled:
>
>                         IPA
>         Dhrystone       Temp Silver     Temp Gold
> 75      6M              78.4            84.9
> 80      6.21M           81.4            89.8
> 85      6.74M           81.7            88.2
> 90      6.88M           79.4            84.6
>
>                         Fair Share
>         Dhrystone       Temp Silver     Temp Gold
> 75      6.63M           80.1            88.5
> 80      6.71M           80.1            88.5
> 85      6.77M           81.1            87.8
> 90      7.12M           81.2            87.8

Interesting that you get more MIPs out of fair share governor when
compared to IPA across the board. What devices were providing energy
cost information (dynamic-power-coefficient) to the IPA engine? Just
CPU and GPU? Can you point me to those patches in gerrit?

> Within this range the 'threshold' temperature doesn't seem to have a
> large impact on the average CPU temperature. There is a bit of
> fluctuation between individual measurements, I wouldn't be surprised
> if the outliers of Temp Gold for 75 and 90=C2=B0C converged more with the
> other values with some more measurements.
>
> I learned how to effectively disable LMH throttling, however with that
> it was fairly easy to have the CPUs overheat, even with throttling in
> Linux. If it is feasible at all to run with LMH disabled some more
> actions will be needed (e.g. attaching a heatsink or interrupt support
> for thermal sensors instead of polling, ...).

Given that LMH kicks in at 95 and IPA manages to maintain temperatures
in the ballpark of 80-90 regardless of the trip point value, I agree
that we should move the 1st trip point to 90. This will give maximum
performance. So in "threshold" and "target" terms 90 becomes the
threshold. And since LMH kicks in at 95, I've left it as the target
trip.

These should be sane defaults for upstream and any device can override
those numbers in their board file.

Thanks again for your thorough review.

Regards,
Amit
