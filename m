Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4152C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5B1206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FvdIPB0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfAIXXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:23:22 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45088 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfAIXXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:23:22 -0500
Received: by mail-vs1-f68.google.com with SMTP id x28so5854472vsh.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 15:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEobjsRjQW1Qhb95tY/P1G513nyuu7ZvoRPJF9hVBOk=;
        b=FvdIPB0CTV3eVi4wj7UdAvdLzn0tbdt+GI8h2s0RG0JRxvf9dqrrlvjvIp4xUbcqki
         p8684iGmy2Rekvw0VM/06/Q/CLjZB8DsBCBjrKoS2ddnN4l8GR/iDIWK+r5DsG5s5ASy
         aACN8iPzA7SYFj+faMO1FkyXxSL6fVgT5HwG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEobjsRjQW1Qhb95tY/P1G513nyuu7ZvoRPJF9hVBOk=;
        b=Dl1l7TYRaprf2tBb85K0fzBm0AmM7oxPBVHmdnosyIM4Ro/YzoPa6Xx0K+OsCspTZO
         JtjXpvfAYxr/aSOVibU894E/7Xz/e+ie6kwnd4vGuXVtLsk84yfB9gs0Fzr9vfYnL+hR
         3b8SrZPI7Czwe5wRyppTS6xM78s4wxo99/03Nv7nn1p/nVNWnK+RUkHeTKO4PtVE97XW
         oLIKMS6ByyVJM/v7JXVZXHhUh0/1IBVdggWkORYwyFrtzba9A1vBbCr3zP23hEXvOf8D
         nI9hK/FHL+zPaK6SWFRFBb2oRsz2+0yshqGptpnWpftaZ2zmwLdX6yIKWxxrcIHk/Mxd
         2vVg==
X-Gm-Message-State: AJcUukc/NjertfWpMgiUZxKRFFavMQqI1TOH7XhOwvUXumz9jub0nvwm
        HeHH6rM5y6zzRan/rhxLsbChMuM9Jaw=
X-Google-Smtp-Source: ALg8bN7dzAbDsbf4ObqSmf2z3PqBSU1EgZdTPPkSDGgmgD9A/eRIU4pBpUWfoCAmSL+oMMkrDaVDNg==
X-Received: by 2002:a67:7106:: with SMTP id m6mr3394391vsc.67.1547076200482;
        Wed, 09 Jan 2019 15:23:20 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id r8sm22646671uan.0.2019.01.09.15.23.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 15:23:20 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id t17so5876535vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 15:23:20 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr3363306vsj.144.1547075892583;
 Wed, 09 Jan 2019 15:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20181208170216.32555-1-georgi.djakov@linaro.org> <20181208170216.32555-7-georgi.djakov@linaro.org>
In-Reply-To: <20181208170216.32555-7-georgi.djakov@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 9 Jan 2019 15:18:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xg5Sz029_UjuDg-ms05Ez+riv8qr0FLWkvg6axPYbZ_g@mail.gmail.com>
Message-ID: <CAD=FV=Xg5Sz029_UjuDg-ms05Ez+riv8qr0FLWkvg6axPYbZ_g@mail.gmail.com>
Subject: Re: [PATCH v12 6/7] arm64: dts: sdm845: Add interconnect provider DT nodes
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        maxime.ripard@bootlin.com,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Dec 8, 2018 at 9:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Add RSC (Resource State Coordinator) provider
> dictating network-on-chip interconnect bus performance
> found on SDM845-based platforms.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0a31a5..b3cd256a154e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1324,6 +1324,11 @@
>                                 compatible = "qcom,sdm845-rpmh-clk";
>                                 #clock-cells = <1>;
>                         };
> +
> +                       rsc_hlos: interconnect {
> +                               compatible = "qcom,sdm845-rsc-hlos";
> +                               #interconnect-cells = <1>;
> +                       };

It would have been convenient if this patch had also added an include above:

#include <dt-bindings/interconnect/qcom,sdm845.h>

...while the include isn't technically needed by this patch, all the
patches that want to actually _use_ the interconnect will need to add
the #include and then you get to some fun fights about who has to add
the include in which patch.  For instance these two patches won't
compile:

* https://lkml.kernel.org/r/1545373748-1416-1-git-send-email-jshekhar@codeaurora.org
* https://lkml.kernel.org/r/20181220173026.3857-4-jcrouse@codeaurora.org

...because neither of them happened to add the include.  Maybe they
were both assuming someone else would do it?


If nobody else wants to, I'm happy to post a patch to add that include
myself and it can be applied atop this one.  ...or if this patch needs
to spin for some other reason maybe you could add it into this patch
directly?

-Doug
