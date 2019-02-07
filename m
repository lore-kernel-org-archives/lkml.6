Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F9DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091B72175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dI+yN7iP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfBGEjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:39:44 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40905 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfBGEjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 23:39:43 -0500
Received: by mail-vs1-f67.google.com with SMTP id z3so5919905vsf.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 20:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VIWcfGJ9HqSjnf0Rkmp4jFSnWAeUZsDouu8IzsH8u40=;
        b=dI+yN7iPH6HDpzoWqfVOV5OIAIZbQrgZE3LkqJK1qbfxeAzXlJRXkR58wGpLC3jty+
         4LUy/JA2lWlz1C2mfVfjZTcyKFbRFmN8kLjcIVlZLTyQGBnFKIW9Aeo52rm9OtuOUsLU
         BuoD4QO4R0M1yIf/RpqILBs/p9hEd7p9cVQeX55aEZ2wjMid1ztQIs7s5eAKseCvz28L
         kGTIYCuM/E3+w9GrARQJc0cE7Ie5QUw0ngou2W7EJgHCVIWG/IXJzmeMvKsWHyeG4Xq9
         Bd1rU2clzauOvjc/mZ0mwHF4gvOUJCQd4F8ZLWH4tftyXGLhshZbVqLqhEX/o7fhFnnJ
         tpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VIWcfGJ9HqSjnf0Rkmp4jFSnWAeUZsDouu8IzsH8u40=;
        b=I3Pzgs5UCo+r6vdiiJdvcTEPuGZFqhhRT80yIXi+GJ1e+tD6hRToZcod3I1Vj4b9RU
         jlEI20fdFz4w5ogxa0zEDKQhVIO5hpYMDeyf1wxnnj2PzgQLLPGI+bIU6XWCuIxbUOCx
         tXs7y8IEa2vuHFDF3NNwpG1s2RLKhFxpBK96zYOM6fWKt4iXPXbsggmaAVdfxgKeYG2/
         bbALVQMFCQPJhve9GAmj6mPskPvbWCfKGaesZgIDYnmJQB7YfPOFKkrnT23s4gFMGNMz
         mwKekiss+Fk1IrCThn0JYUxP1hsVAxA971Wz8ggasRcmMRSFV+hCBnMqkk7B/R7AvCxK
         nnBg==
X-Gm-Message-State: AHQUAuako0p53UnZhRMjuSDRoTEBOgG/E4G8orBskFarBuA/2SjWQKMq
        zFVuxoQzpd/dupxvAwI8/tjTPuNBnvFaUjElY4B6FQ==
X-Google-Smtp-Source: AHgI3IbShnJmY1hdGhwMcQtMdO0VG8ptle8VwGrF2jOXvc/nE00FYbKF2xydzMnprkU7rr/loH0Q4+V39Pb7JO/RNyU=
X-Received: by 2002:a67:7ed8:: with SMTP id z207mr5627174vsc.159.1549514381776;
 Wed, 06 Feb 2019 20:39:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548093127.git.amit.kucheria@linaro.org>
 <6a21a9ee7663e1b32d8ea81ac5e51d187aed25fb.1548093127.git.amit.kucheria@linaro.org>
 <20190123021251.GJ261387@google.com> <20190124233528.GA81583@google.com>
 <20190125222051.GF81583@google.com> <CAP245DUy5pe9KQrEX_5iiHg9RtLPHyZcygy6fkrLgsJQYak-_g@mail.gmail.com>
 <20190206193441.GJ117604@google.com> <20190207015727.GK117604@google.com>
In-Reply-To: <20190207015727.GK117604@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 7 Feb 2019 10:09:29 +0530
Message-ID: <CAHLCerP+ao3perRN7_ttr0Qkx81oOAxufpYBvWRUJ04zG2Fisg@mail.gmail.com>
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

On Thu, Feb 7, 2019 at 7:27 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Wed, Feb 06, 2019 at 11:34:41AM -0800, Matthias Kaehlcke wrote:
> > On Wed, Feb 06, 2019 at 04:05:41PM +0530, Amit Kucheria wrote:
> > > On Sat, Jan 26, 2019 at 3:50 AM Matthias Kaehlcke <mka@chromium.org> =
wrote:
> > > > > > >                   trips {
> > > > > > > -                         cpu_alert0: trip0 {
> > > > > > > +                         cpu0_alert1: trip-point@0 {
> > > > > > >                                   temperature =3D <75000>;
> > > > > >
> > > > > > In my observations a 'switch on/threshold' temperature of 75 de=
grees
> > > > > > leads to aggressive throttling with IPA when the temperature is=
 above
> > > > > > this threshold:
> > > > > >
> > > > > > [  716.760804] cpu_cooling_ratelimit: 31 callbacks suppressed
> > > > > > [  716.760836] cpu cpu4: Cooling state set to 10. New max freq =
=3D 1920000
> > > > > > [  716.773390] power_allocator_ratelimit: 15 callbacks suppress=
ed
> > > > > > [  716.773405] thermal thermal_zone5: Controlling power: contro=
l_temp=3D95000 last_temp=3D73500, curr_temp=3D75200 total_requested_power=
=3D39025 total_granted_power=3D18654
> > > > > > [  749.609336] cpu_cooling_ratelimit: 45 callbacks suppressed
> > > > > > [  749.609371] cpu cpu4: Cooling state set to 11. New max freq =
=3D 1843200
> > > > > > [  749.624300] power_allocator_ratelimit: 24 callbacks suppress=
ed
> > > > > > [  749.624323] thermal thermal_zone5: Controlling power: contro=
l_temp=3D95000 last_temp=3D70800, curr_temp=3D77200 total_requested_power=
=3D40136 total_granted_power=3D17402
> > > > > > [  780.152633] cpu_cooling_ratelimit: 41 callbacks suppressed
> > > > > > [  780.152666] cpu cpu4: Cooling state set to 11. New max freq =
=3D 1843200
> > > > > > [  780.165247] power_allocator_ratelimit: 21 callbacks suppress=
ed
> > > > > > [  780.165261] thermal thermal_zone5: Controlling power: contro=
l_temp=3D95000 last_temp=3D64800, curr_temp=3D76900 total_requested_power=
=3D39719 total_granted_power=3D1759
> > > > > >
> > > > > > (the logs come from a local patch in our tree:
> > > > > > https://chromium.googlesource.com/chromiumos/third_party/kernel=
/+/ec1c501a8093fed44a6697a5913ef2765f518e1f)
> > > > > >
> > > > > > At this point I don't have a clear idea what would be a reasona=
ble
> > > > > > value for the 'switch on/threshold' temperature, but probably i=
t
> > > > > > should to be higher than 75 degrees, at least with IPA. If ther=
e is
> > > > > > no reasonable common configuration for different thermal govern=
ors I
> > > > > > guess we'll have to target a commonly used governor and systems
> > > > > > using other 'incompatible' governors need to override the confi=
g in
> > > > > > their <board>.dtsi.
> > > > >
> > >
> > > Thanks for the elaborate testing and for sharing the numbers. This is
> > > very useful information.
> > >
> > > > > On my system I don't see a significant delta in core temperatures=
 for
> > > > > 'threshold' temperatures of 80, 85 or 90=C2=B0C. However Dhryston=
e
> > > > > performance goes up by ~8% when changing the trip point from 80 t=
o
> > > > > 85=C2=B0C. For a switch from 85 to 90=C2=B0C I see a ~2% performa=
nce delta. For
> > > > > all trip points the average core temperatures are ~80=C2=B0C (sil=
ver) and
> > > > > ~85=C2=B0C (gold). Interestingly I observed the highest average
> > > > > temperatures with the trip point at 80=C2=B0C (repeated measureme=
nts were
> > > > > taken for different temperatures).
> > > > >
> > > > > Supposedly LMH throttling is disabled in the firmware I used for
> > > > > these tests, however data suggests that it is still active
> > > > > (temperature doesn't rise beyond 95=C2=B0C, even without throttli=
ng in
> > > > > Linux; Dhrystone performance drops when raising the temperature b=
eyond
> > > > > 95=C2=B0C with a heat gun. I will do some more testing when I get=
 my hands
> > > > > on a FW that effectively disables LMH (or raises the threshold to
> > > > > something like 105=C2=B0C).
> > > > >
> > > > > From the data collected so far I'd suggest a 'threshold' temperat=
ure
> > > > > of 90=C2=B0C or if that seems to high 85=C2=B0C. Behavior might b=
e different
> > > > > with other thermal governors or without LMH throttling..
> > > >
> > > > Some more data from measurements with different trips points, for t=
he
> > > > IPA and the Fair Share governors, LMH throttling was enabled:
> > > >
> > > >                         IPA
> > > >         Dhrystone       Temp Silver     Temp Gold
> > > > 75      6M              78.4            84.9
> > > > 80      6.21M           81.4            89.8
> > > > 85      6.74M           81.7            88.2
> > > > 90      6.88M           79.4            84.6
> > > >
> > > >                         Fair Share
> > > >         Dhrystone       Temp Silver     Temp Gold
> > > > 75      6.63M           80.1            88.5
> > > > 80      6.71M           80.1            88.5
> > > > 85      6.77M           81.1            87.8
> > > > 90      7.12M           81.2            87.8
> > >
> > > Interesting that you get more MIPs out of fair share governor when
> > > compared to IPA across the board. What devices were providing energy
> > > cost information (dynamic-power-coefficient) to the IPA engine? Just
> > > CPU and GPU? Can you point me to those patches in gerrit?
> >
> > Only the CPUs provide energy cost information, the GPU isn't fully
> > hooked up in our tree yet. The cause of the delta could be that for
> > temperatures < 'target' Fair Share only uses the performance states
> > specified in 'threshold' for throttling (currently only the boost
> > frequency), while IPA may use the full range of states  of the
> > 'target' trip point.
>
> I saw that in v4 you allow all performance state to be used for

Yes, I found during my testing that I got better convergence at the
threshold temperature when I allowed the entire range of operating
points with almost no decrease in MIPs.

> throttling at the 'threshold' temperature. With this configuration
> I get:
>
>                Dhrystone      Temp Silver    Temp Gold
>
> Fair Share     7.29M          81.4           87.7
>
> IPA            7.14M          81.7           88.3
>
>
> I have no good sense why we are seeing more MIPs for IPA than with the
> previous configuration. As for earlier tests the values are the
> average from 4 runs.

I suspect that EAS task placement might be at work here. Were your
test threads locked to CPUs or were they free to be scheduled around?

> In any case it seems like a reasonable default configuration with the
> data we have at this point.

Thanks for your thorough reviews to get this point. Will you send out
the patches to add support for IPA at some point?

Regards,
Amit
