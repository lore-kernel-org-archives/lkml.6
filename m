Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E5FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49660208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8RU/rOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfAJUGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:06:33 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35721 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfAJUGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:06:33 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so7806177vsc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 12:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68T555WDqXLn90hSuXoCLW5RPWTwZhByOAockeVOL0E=;
        b=I8RU/rOrlgWqEjf/Wb51uk7WymdmVzJcL5BRprIAmvT651pP6l6tUvUOv9FnzHPbCm
         CM28XD3r5OsdIB3mLBT+lWYWreVq9UmcaKPho6mjyQiEL9KpIsScCSTNxGG7noM9na1p
         BoUe+Xp92/CWtneHKicDSUPYCkpnNUc2vSP00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68T555WDqXLn90hSuXoCLW5RPWTwZhByOAockeVOL0E=;
        b=ocMCQbsLw/yQXpFbZxCHnuoHj8UNCbWJI9R8re5CCn9GDFGfkp9DNebOC3I8CqRAgx
         ML73DZU17V2Yv31TSegtM+lpW7Qs2CMGf0PEYV5rddGihZqXb7XHJd1qri+ZGH8quyQc
         RX026aNt6SP3NObmTw7M1k8aFFanpUVMNNslDUHrvYePx9Qi0Qw3njSN2TIihZysOAgJ
         R1H3TAb6/9jjBnLhxd2i/Al2uyqCAxvGSXQzVvXYKRcWhqF8wPtaR0l/8yPYtbuNzmIo
         FRgeVMZLaNn5Uts8EGC589tfcoYLIdkKxyYgzX2qFS0HIGivO83YqkkI5Bsuxdjn4ekI
         yrzQ==
X-Gm-Message-State: AJcUukeAwniD9Dtjz+qbMAiZDQm9t59o1YOyXEAgoCi+vVrehHPAbYL3
        IIKGtJKaXnX3X6rCxJnwrC+T4PDXHZ2TXUmfGPt2Qw==
X-Google-Smtp-Source: ALg8bN5bITkSssF0f4QUvo3HUr0qWtJSutryeIPaJdmK7PqA16Bwkc0Ml54bMhRB/F3yw9FtyU8KOhB9B4sVfyeF8Fw=
X-Received: by 2002:a67:4711:: with SMTP id u17mr4896912vsa.27.1547150791191;
 Thu, 10 Jan 2019 12:06:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <041258d65883df964890249a24d2a4788c419304.1547078153.git.amit.kucheria@linaro.org>
 <154708018331.15366.11574628155253134835@swboyd.mtv.corp.google.com>
In-Reply-To: <154708018331.15366.11574628155253134835@swboyd.mtv.corp.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 11 Jan 2019 01:36:20 +0530
Message-ID: <CAHLCerOVyOUvvXHRQFpn29=ycy4VZHocsNdHbcR4ZK4RfGq49A@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] arm64: dts: sdm845: Increase alert trip point to
 95 degrees
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
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

On Thu, Jan 10, 2019 at 5:59 AM Stephen Boyd <swboyd@chromium.org> wrote:
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

These values are meant to be safe values for silicon operation as
characterised[1] by the HW team. So I'd consider them a more than just
default values. It also gives future boards a safe starting point.

IMHO it would be better to have the characterized values merged
upstream and if really required, those values can be tweaked in the
board-specific DTS.

[1] Caveat: The characterisation probably focused on mobile devices
and might change depending on form-factor, active cooling and heat
dissipation design but those differences should only impact the skin
temperature, not the operation of the SoC itself.
