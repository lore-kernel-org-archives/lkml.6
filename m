Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F6FC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4745420815
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HHPeTCmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeLRP3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:29:04 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36869 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeLRP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:29:04 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so4776785iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/EqxXLPNuG+pYUcOI24Scjn0TlAIbGPDff7dYdIyAY=;
        b=HHPeTCmrzxvyQc0FaA6OBu4PGjuYnDX/bz2ds8z4KbOZcMci3PqBySc01k0QoP90B4
         GvDV265A9iCuQHJ+HAYh72jwZQvBUi0TpUkwPFyIQNczLkfOdiLJ0dRdj+Rhxt7+AJt8
         oCyPaTGczl8KxHFrsgpVyMubzFu2qQ+8VL6IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/EqxXLPNuG+pYUcOI24Scjn0TlAIbGPDff7dYdIyAY=;
        b=kIQth2cMMCIeHgs8BLsVAmdUcips5eKddtZ4EMea7Q3SLer/nuTxAtB/3WMzqZSPin
         jy52btJkwDMCqaq1ggrxundZbUBlwUGMtEA4hp9XT5rY2GGrY2GjXBgrn2JBTQPIv19g
         w4hjkisrhdZ+PBCqGGni79Yitdkt/ZfiIGNAmV8Aj8aoBMt0QYb0YokKViEWhcCWjR6s
         L6DYMZF9aF8Co0N51PWVFzEVV+VHS7EEj9DPTwZQYVfOu1hF9Iv8Fx1/NhzlD1LpLg0n
         wZAp0PM3ccnuRmV9lpfj2CwM0RSuFfOCDKPO0tJ9XJxmFBOzZG3caSqD8xpUozmqYOJq
         mphA==
X-Gm-Message-State: AA+aEWZa3F02xVaPkGAPOofg0znPNfL8qbBGxKLF3zASYPufzdmzSoAc
        fuEzUElbRGct9Q2LYNwmcX3Jqwu5c1dgBOo0i+TacA==
X-Google-Smtp-Source: AFSGD/X9yZd+A05H/fXKGE0JNZ8ViU/SZnwqn0N1KKqSg/Y5U0VvzoCHgixQT2zD0Jv5nqXFDC6baQzPRffnrVDSntg=
X-Received: by 2002:a24:10cb:: with SMTP id 194mr3338404ity.173.1545146943081;
 Tue, 18 Dec 2018 07:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20181218113320.4856-1-jagan@amarulasolutions.com> <20181218152122.4zj6wgbukhrl6ly6@flea>
In-Reply-To: <20181218152122.4zj6wgbukhrl6ly6@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 18 Dec 2018 20:58:22 +0530
Message-ID: <CAMty3ZA4xXVLKx-yj+2_iJ700+yTLesjEAgS8Wu2i8otPScpaw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] media/sun6i: Allwinner A64 CSI support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 8:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Dec 18, 2018 at 05:03:14PM +0530, Jagan Teki wrote:
> > This series support CSI on Allwinner A64.
> >
> > Tested 640x480, 320x240, 720p, 1080p resolutions UYVY8_2X8 format.
> >
> > Changes for v4:
> > - update the compatible string order
> > - add proper commit message
> > - included BPI-M64 patch
> > - skipped amarula-a64 patch
> > Changes for v3:
> > - update dt-bindings for A64
> > - set mod clock via csi driver
> > - remove assign clocks from dtsi
> > - remove i2c-gpio opendrian
> > - fix avdd and dovdd supplies
> > - remove vcc-csi pin group supply
> >
> > Note: This series created on top of H3 changes [1]
> >
> > [1] https://patchwork.kernel.org/cover/10705905/
>
> You had memory corruption before, how was this fixed?

Memory corruption observed with default 600MHz on 1080p. It worked
fine on BPI-M64 (with 300MHz)
