Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC90CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F7420874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JIWm5JHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbfAJROh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:14:37 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36287 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfAJROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:14:37 -0500
Received: by mail-vs1-f68.google.com with SMTP id v205so7474493vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vy7pN6aDzFrDAzH1p4yOc3Z4zZXfqcqoGwMPJMXmmLM=;
        b=JIWm5JHTv7uv3F9kiaXoFZdazgwTJf9+6BMPBtupiq6d0P41Jn0QQ/RmiJuB+/54c+
         j8JcnzizAU0YqPGWQU0AisDLpQmeclmBoF/ghS2HUm4rnafrWP6x8sQ1neEulWuU9Fyp
         VCwtjbHcCUt5fHF/O5E/e84tkE8ChQOnvoqDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vy7pN6aDzFrDAzH1p4yOc3Z4zZXfqcqoGwMPJMXmmLM=;
        b=Inql/VjQhKGk6bZea2/5V3BcBlh3LBlj7DZFFDggV5k60iBLb9WYJT8GFudxOq1UI2
         zsKoQi7iekyH3dRcwgbUgGAXLg5XhOX76YmhZRBNd9nyaTH/wM11ApXlu4te0J00bl76
         bhpxQnak+IgnKu8lNPvnZcHR93osDL6J7HNrFYytZd9cuQGlbu+wYON2AGrq4OQCH9+H
         SQk1wIrHiSnVO0/SkzqjIVTWFssdEM5qv8UAeAUErGafyKKCspIN3d1udeHw10KDaPOi
         IYdSjCxvBW1+JjCUtk6bfAQBiv3MoUQPxt/zeElQVB1m5Dg2W+VmIzLt1Yw505OvqC9x
         7Y7g==
X-Gm-Message-State: AJcUukdPBlRJFRZQj4pQLNsLrHD7dR/ED8b26VkNSi8JvQtR3bABCICu
        ZpESSWG6c62RNNFceWOREbWZX2DenYg=
X-Google-Smtp-Source: ALg8bN4IAO9OjLNCqk/TqNDxRvuJwKjw5fZ35ZFXt/txsXfwI3sUfNxcb68CrLjn96NA2ZhQRIuh9A==
X-Received: by 2002:a67:3509:: with SMTP id c9mr4560621vsa.33.1547140475418;
        Thu, 10 Jan 2019 09:14:35 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id k200sm29434492vke.9.2019.01.10.09.14.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 09:14:34 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id p74so7499181vsc.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:14:34 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr4635027vsj.144.1547140473614;
 Thu, 10 Jan 2019 09:14:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <041258d65883df964890249a24d2a4788c419304.1547078153.git.amit.kucheria@linaro.org>
 <154708018331.15366.11574628155253134835@swboyd.mtv.corp.google.com>
In-Reply-To: <154708018331.15366.11574628155253134835@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Jan 2019 09:14:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V8WM68Rrsc6adnV6Q9c1N8hoH2TzNLWUsuWg33d7ZpOg@mail.gmail.com>
Message-ID: <CAD=FV=V8WM68Rrsc6adnV6Q9c1N8hoH2TzNLWUsuWg33d7ZpOg@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] arm64: dts: sdm845: Increase alert trip point to
 95 degrees
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 9, 2019 at 4:29 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-01-09 16:00:55)
> > 75 degrees is too aggressive for throttling the CPU. After speaking to
> > Qualcomm engineers, increase it to 95 degrees.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++--------
>
> Is the plan that these are some defaults that would be adjusted by board
> variants? Just curious why we have anything in here and don't punt it
> all to each board dts file.

My preference would be that the SoC device tree file should contain
thermal numbers that are important to pay attention to for the safety
/ proper operation of the SoC.  ...then individual boards could (if
they needed to) override with lower values to control, for instance,
skin temperature.

From experience with previous boards, if you've got enough an off-SoC
thermistors then those are the ones you'd want to monitor to control
skin temperature.  It's OK if the SoC spikes up quite high as long as
that heat has somewhere to go (like a heat pipe).  The sensors that
are part of Amit's patch are on-chip.

...if you've got a board without external thermistors and are using
the SoC's on-chip sensors as a proxy for the heat in the overall
system then you might want to lower your values in the board device
tree file.  You won't be able to have as many short term spikes, but
that's what you gotta do without the extra sensors.


Sound sane?

-Doug
