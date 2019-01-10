Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0BCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20A3208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VX5iQw8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfAJTpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:45:22 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34536 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfAJTpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:45:21 -0500
Received: by mail-vs1-f67.google.com with SMTP id y27so7794682vsi.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 11:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mMSIplNwQtJNKjNPRVZzWV+V5V5FQPvSh1eSXpnARok=;
        b=VX5iQw8UIRvoL7ypX9SBKD8uP6icUnuo4aE39yh5L5grjrzDMy5MdIiTI572TdOrpz
         BaAMlugmP2RFbEKQB8yg/UTI6svzWJQaaDm8Ml4mJ8ccry47dCzOuGbeSk1O8qWxPPvg
         rCq9Q8nk7ixcyo7ttOF+f3pX1WyPbFiBy9uzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMSIplNwQtJNKjNPRVZzWV+V5V5FQPvSh1eSXpnARok=;
        b=POQy9eNdb31xZtANQiWSr5v8kTGDx02HiNVlMueESL7lodcJe5QjO0r6Dds5cW57xd
         UBrFwOeZSzCoffO0WOfG4fG1zu5rxGSK0QfYhZKPmukZbtBRGg1quQOvIcdi9Aax4/Fk
         9iW+5+MeiERm8qhPGMYbYwjTb6ZZwstrTb9kKkJawmf13TmUvmpjnPFKkv36ndZ5/9jX
         CPgwpKJTsgaiSrNEwud3K9aacffplsy6mi79Al3iA/7slZUHPpPm93a9lyEQLtjAqJSX
         4Xj8O24RTkecLRoEekdqzeyLKMz+1HC+vsr1Sc24KEHmmMm/+eqzoRM7hCRWvVZSO+s7
         ABag==
X-Gm-Message-State: AJcUukcDGBpsVvzqa1I6DSgjWi6z+2U4s+q4MgVnIE7xZ8dEHS97kFP1
        9j+w0/nwdOByqg67Fkx+c3c0JR78ca3O3VLGcXFSUg==
X-Google-Smtp-Source: ALg8bN4iz/3GBmTpOivQpjxqEtBFP0L9ZwxZygYFSE/ksMH9lDNKDBMKuDlVso3bXcL9kX64YJGa83ZN41gdrZ9hRRY=
X-Received: by 2002:a67:e34e:: with SMTP id s14mr4649927vsm.95.1547149520367;
 Thu, 10 Jan 2019 11:45:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <041258d65883df964890249a24d2a4788c419304.1547078153.git.amit.kucheria@linaro.org>
 <20190110011533.GV261387@google.com> <20190110021522.GW261387@google.com>
In-Reply-To: <20190110021522.GW261387@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 11 Jan 2019 01:15:09 +0530
Message-ID: <CAHLCerM+p+GkVsR_WuC0xF1oFvj=8cZ+OmU=pMssfZGGs-eS7w@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] arm64: dts: sdm845: Increase alert trip point to
 95 degrees
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 7:45 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Wed, Jan 09, 2019 at 05:15:33PM -0800, Matthias Kaehlcke wrote:
> > Hi Amit,
> >
> > On Thu, Jan 10, 2019 at 05:30:55AM +0530, Amit Kucheria wrote:
> > > 75 degrees is too aggressive for throttling the CPU. After speaking to
> > > Qualcomm engineers, increase it to 95 degrees.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index c27cbd3bcb0a..29e823b0caf4 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -1692,7 +1692,7 @@
> > >
> > >                     trips {
> > >                             cpu_alert0: trip0 {
> > > -                                   temperature = <75000>;
> > > +                                   temperature = <95000>;
> > >                                     hysteresis = <2000>;
> > >                                     type = "passive";
> > >                             };
> > > @@ -1713,7 +1713,7 @@
> > >
> > >                     trips {
> > >                             cpu_alert1: trip0 {
> > > -                                   temperature = <75000>;
> > > +                                   temperature = <95000>;
> > >                                     hysteresis = <2000>;
> > >                                     type = "passive";
> > >                             };
> > > @@ -1734,7 +1734,7 @@
> > >
> > >                     trips {
> > >                             cpu_alert2: trip0 {
> > > -                                   temperature = <75000>;
> > > +                                   temperature = <95000>;
> > >                                     hysteresis = <2000>;
> > >                                     type = "passive";
> > >                             };
> > > @@ -1755,7 +1755,7 @@
> > >
> > >                     trips {
> > >                             cpu_alert3: trip0 {
> > > -                                   temperature = <75000>;
> > > +                                   temperature = <95000>;
> > >                                     hysteresis = <2000>;
> > >                                     type = "passive";
> > >                             };
> > > @@ -1776,7 +1776,7 @@
> > >
> > >                     trips {
> > >                             cpu_alert4: trip0 {
> > > -                                   temperature = <75000>;
> > > +                                   temperature = <95000>;
> > >                                     hysteresis = <2000>;
> > >                                     type = "passive";
> > >                             };
> > > @@ -1797,7 +1797,7 @@
> > >
> > >                     trips {
> > >                             cpu_alert5: trip0 {
> > > -                                   temperature = <75000>;
> > > +                                   temperature = <95000>;
> > >                                     hysteresis = <2000>;
> > >                                     type = "passive";
> > >                             };
> > > @@ -1818,7 +1818,7 @@
> > >
> > >                     trips {
> > >                             cpu_alert6: trip0 {
> > > -                                   temperature = <75000>;
> > > +                                   temperature = <95000>;
> > >                                     hysteresis = <2000>;
> > >                                     type = "passive";
> > >                             };
> > > @@ -1839,7 +1839,7 @@
> > >
> > >                     trips {
> > >                             cpu_alert7: trip0 {
> > > -                                   temperature = <75000>;
> > > +                                   temperature = <95000>;
> > >                                     hysteresis = <2000>;
> > >                                     type = "passive";
> > >                             };
> >
> > The change itself looks good to me, however I wonder if it would be
> > worth to eliminate redundancy and merge the current 8 thermal zones
> > into 2, one for the Silver and one for the Gold cluster (as done by
> > http://crrev.com/c/1381752). There is a single cooling device for
> > each cluster, so it's not clear to me if there is any gain from having
> > a separate thermal zone for each CPU. If it is important to monitor
> > the temperatures of the individual cores this can still be done by
> > configuring the thermal zone of the cluster with multiple thermal
> > sensors.
>
> I see your idea is to have a cooling device per CPU ("arm64: dts:
> sdm845: wireup the thermal trip points to cpufreq" /
> https://lore.kernel.org/patchwork/patch/1030742/), however that
> doesn't work as intended. Only two cpufreq 'devices' are created,
> one for CPU0 and one for CPU4. In consequence cpufreq->ready() only
> runs for these cores and only two cooling devices are
> registered. Since the cores of a cluster all run at the same
> frequency I also doubt if having multiple cooling devices would
> bring any benefits.

I actually only intended for two cooling devices - one for each
frequency domain. I'll clarify it better in the patch description.
