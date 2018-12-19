Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A391C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27F120811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QvMS/y8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeLSWcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:32:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42899 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbeLSWcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:32:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so10485325pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:user-agent:to:references:cc
         :from:in-reply-to:message-id:subject:date;
        bh=zEFywTJZsRkcxT1AcNZEO8Usk7ex33GyxYyswIy1kL8=;
        b=QvMS/y8q5krt9BA/rjhFN7/GZm3yQGwg2ED/WOAGxkh8MDLQso8AV9Tw7ZgvW+NpBa
         WDEMKf8gSNmpfTmz+Mwy9WRnuhZyGpH5uQq4vFLlDwL+2idyfE+MNnRTm0x3KpzOSkyG
         RCLo7Jj0xAmxiBBBcr36rcmrznK3PqrgqWE20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :user-agent:to:references:cc:from:in-reply-to:message-id:subject
         :date;
        bh=zEFywTJZsRkcxT1AcNZEO8Usk7ex33GyxYyswIy1kL8=;
        b=QGvYGJn4g1XgA7wAae0T/54MlLIBtvMlo5425tnE5FuQLYI0W7NktEZftDH2iqLXYy
         yc2ULv7nxi5EpdA53CuBZet+Z4xtgM+0UjFQv5qM8GvhNfj1l/TyrBevckfMfSr41Ofu
         NFxnmwtkAy18rLiikEpl4HlHEdUMfnTRSsbDhwkh6kJcSJg1lT0OkPy6shmGgSMZiRm6
         UuJiSPAgawtt6OqCCN0579ancUJnf02x3QVn/DM5qCPQsN7+e23Yg+xvY0OnNt9DR716
         506ZYOLXy8KMubhi4Uohmh15cS6Unlqd0WYc3/+VZV+roXEn48L70ts+omq2rBKb26d6
         vWZw==
X-Gm-Message-State: AA+aEWZGiSoQXn63PTvD75v/uHBNWFujGELg8UQ6USfvRuffMzR5Eo9n
        KGQX9qY6glUhPlJk2CfgzK5JRQ==
X-Google-Smtp-Source: AFSGD/WsagMM1GAbSGyx+PWOi+/NeTyWWapQIJp/PxTdIxtKD8afK9xUbzY7bcuV/V1tr39uYn3Xsw==
X-Received: by 2002:a63:1157:: with SMTP id 23mr21155226pgr.245.1545258740641;
        Wed, 19 Dec 2018 14:32:20 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l19sm43063809pfi.71.2018.12.19.14.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 14:32:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
User-Agent: alot/0.8
To:     Matthias Kaehlcke <mka@chromium.org>
References: <20181204224234.62619-1-mka@chromium.org> <20181204224234.62619-5-mka@chromium.org> <154445707953.17204.10100324387384439759@swboyd.mtv.corp.google.com> <20181219222222.GA261387@google.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181219222222.GA261387@google.com>
Message-ID: <154525873917.79149.9742850766307036349@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v4 4/8] drm/msm/dsi: 14nm PHY: Get ref clock from the DT
Date:   Wed, 19 Dec 2018 14:32:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-12-19 14:22:22)
> On Mon, Dec 10, 2018 at 07:51:19AM -0800, Stephen Boyd wrote:
> > Quoting Matthias Kaehlcke (2018-12-04 14:42:30)
> > > diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c b/drivers/gpu=
/drm/msm/dsi/pll/dsi_pll_14nm.c
> > > index 71fe60e5f01f1..032bf3e8614bd 100644
> > > --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
> > > +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
> > > @@ -40,7 +40,6 @@
> > > =20
> > >  #define NUM_PROVIDED_CLKS              2
> > > =20
> > > -#define VCO_REF_CLK_RATE               19200000
> > >  #define VCO_MIN_RATE                   1300000000UL
> > >  #define VCO_MAX_RATE                   2600000000UL
> > > =20
> > > @@ -139,6 +138,7 @@ struct dsi_pll_14nm {
> > >         /* protects REG_DSI_14nm_PHY_CMN_CLK_CFG0 register */
> > >         spinlock_t postdiv_lock;
> > > =20
> > > +       struct clk *vco_ref_clk;
> >=20
> > Is there any need to keep it in the struct? Or just get the clk, find
> > the rate, and then put the clk and call pll_14nm_postdiv_register()?
>=20
> I suppose you mean passing the clock name to pll_14nm_register()?

Yes, whatever makes it possible to avoid storing the pointer in the
struct.

>=20
> Is putting the clock really needed or preferable, or is it just fine
> to auto-put it when the device is deleted?

Up to you. If you don't have a need for the clk anymore it seems fine to
just put the clk and be done.=20

