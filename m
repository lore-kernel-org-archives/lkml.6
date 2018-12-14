Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BB4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2081E206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m9t8XbeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeLNQSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:18:52 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42686 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeLNQSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:18:51 -0500
Received: by mail-ua1-f67.google.com with SMTP id d21so2176228uap.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=us4qfc6SvHjg9pBUCZLM1fMnyDfQbUZdTc5sp9evYpw=;
        b=m9t8XbeYWiPp3/acOYHs5BH/NybLQm3D6FQP1BNgqc1ZqOVLWvKZe2jUSvZZprzGOK
         A4TKF0wsxg5zOgM/8TLDzulE7nW8rUutpfOhzD2Vv7iyR1rdIu8poRDAmcwlP4ytqT/p
         TnrsT+VuXpHsFAS2yYpYEV9B21w+iTRzhpc1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=us4qfc6SvHjg9pBUCZLM1fMnyDfQbUZdTc5sp9evYpw=;
        b=YPmJ0g9dIrhx/SuLgChLrwpnk+cibJpDJwrsSVuGUDSMDTZ+msTCpAH4n3RmI5wuhE
         +gBq4oznh2ezcPidc5xmbfq9x1FwedzY8NRQLtgejFYg11PduQyVA73y1U9DvkNMlfak
         5MWWQaHbkJRUSriajCagBg9BbREyj5xcvGnpP4WpYeht/q5FTrzQXY7B4tAZsQAP/t4E
         dSzKjZ5ffdGxkriLjO3WSVAKtZfKwCaoHvXciMbpEBcOr0pjb7zqJ2KRUDBENrM2yNOZ
         ZclqHXzVjQfEAKq49W6Dfb+cJObmeZ7kjnw/1Z53Z9YThOJ1Ls4l5K+7+KpyoJHFn24z
         VO3Q==
X-Gm-Message-State: AA+aEWY3HOHvtagRm5cFOPmeFjOGAULt+ZsFn608LXWKjDngYMiNJg0S
        orAQNtGzY74fv0VWVfreoxhjZgq/Bg0=
X-Google-Smtp-Source: AFSGD/VjmvT4Ija6eceLBHJEpFzOBQeCXml/ayT9zyocijIkc5Fj3I+di4knHRNEfoHuGGRdB2qxZA==
X-Received: by 2002:ab0:6652:: with SMTP id b18mr1694019uaq.46.1544804329934;
        Fri, 14 Dec 2018 08:18:49 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id n15sm2252944uao.18.2018.12.14.08.18.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 08:18:49 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id u19so2183861uae.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:18:48 -0800 (PST)
X-Received: by 2002:ab0:146b:: with SMTP id c40mr1586552uae.9.1544804327990;
 Fri, 14 Dec 2018 08:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20181127085828.17908-1-sibis@codeaurora.org> <CAD=FV=U+LHa0QpPuZhd04=WkMrrM1kBUYhkS9RqSSR6uLijbBA@mail.gmail.com>
 <20181214045218.GJ1578@tuxbook-pro>
In-Reply-To: <20181214045218.GJ1578@tuxbook-pro>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 14 Dec 2018 08:18:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WrvRH6QpaQ67yw2MFz8RP59ozkSfQC4+OAM_8fAbGZuw@mail.gmail.com>
Message-ID: <CAD=FV=WrvRH6QpaQ67yw2MFz8RP59ozkSfQC4+OAM_8fAbGZuw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     sibis@codeaurora.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 13, 2018 at 8:52 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 13 Dec 14:17 PST 2018, Doug Anderson wrote:
> > On Tue, Nov 27, 2018 at 12:58 AM Sibi Sankar <sibis@codeaurora.org> wrote:
> [..]
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index 58870273dbc9..df16ee464872 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -1095,6 +1095,69 @@
> > >                         };
> > >                 };
> > >
> > > +               remoteproc@4080000 {
> > > +                       compatible = "qcom,sdm845-mss-pil";
> > > +                       reg = <0x04080000 0x408>, <0x04180000 0x48>;
> >
> > s/0x04080000/0x4080000 to appease the DT folks.
> >
>
> Andy requests this to be padded to 8 digits, and I've come to really
> appreciate this as it makes sorting much easier.
>
> But perhaps there's a verdict on this?

Hrm.  First I've heard of that.  ...and all of the other addresses in
this file aren't padded to 8 digits.  Ugh.  I could submit a patch to
fix them all (I actually like them padded too) but given the current
number of outstanding patches against sdm845.dtsi it's just going to
cause lots of merge conflicts?

I thought it was general DT practice to always omit leading zeros but
I just searched and it appears that policy only applies to unit
addresses.  Specifically I note that in
<https://lkml.kernel.org/r/20180111060004.9333-1-bjorn.andersson@linaro.org>
Rob H asked you to remove the leading zero from the unit address but
_not_ the "reg".  So I guess padding the reg to 8 digits is OK.

tl;dr: Sure, keep the padding the 8 digits here and eventually we can
fix-up the other nodes when there's not so much churn to sdm845.dtsi
(or maybe Andy can do it himself?)  Sound like a plan?


-Doug
