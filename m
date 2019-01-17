Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40225C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28A020856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qa570Oy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfAQIHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:07:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40848 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfAQIHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:07:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so9874866wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6GpzpoTRuuOQm2evl1u6wA5mrPeXBcvBBOJth5XGMeg=;
        b=Qa570Oy7vvclWTXX6TYWtVEhgWaODzJQSDOaw09NYC1ZWkkugEfXzCeL5I8haThiyo
         hOYWueb2M4BlLPEIPRD1dVIuz2EFn1rP22SwLiNx0aFct4bKNdAQlBIYnsDPHjKuM5Ry
         b7AHmNatWGreEVwg14CputLkG00X9AWMdjV24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6GpzpoTRuuOQm2evl1u6wA5mrPeXBcvBBOJth5XGMeg=;
        b=BEv3M5lGo7nClUemUHzUsKyJ6rafTBVCNgo2DuBjoN9S7uHFepWQg+Vt03GNdaci7s
         8SoYrWlJsNwTZGVwJVsVnqPCnqeHEXkqt2EZXO3oagCdsY4LxhBptw5KDYlQc2k12f0U
         G67CE0YzQoMMgz7XqCeqVWNgowIdAEJj4rE8HycZluwLhk4WnVMivrDbUUK1iT5DkoBt
         tMqkme88GYAkNhbk0ekW1c7aoLufbU71gbQXHTUMNkZPBlYbhAz3YpmLjjOwuBi+1n5Z
         d9RHK9EYDq7Nxhbep39aOu34KKaHWS2yVDeFUclZtoNVfmsCcAS+Amp6TNvp9l4a4xh5
         ZQXQ==
X-Gm-Message-State: AJcUukdnBgG/CRHDlSxfGjlwxRgmLioW5YwO6WELsCgo80vM4lpN6GDb
        AUMnmUPwWoU3IVvhWgeHu3R/1Q==
X-Google-Smtp-Source: ALg8bN4MIiwAaFe5hmyr8ALbm8jgnrbaekeNEikw/kwdfDo08nivBuzg0/S8BAWWUEymbsZFhzJZ7w==
X-Received: by 2002:adf:f101:: with SMTP id r1mr11142693wro.32.1547712465718;
        Thu, 17 Jan 2019 00:07:45 -0800 (PST)
Received: from dell ([2.27.35.149])
        by smtp.gmail.com with ESMTPSA id 10sm47962891wmy.40.2019.01.17.00.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 00:07:44 -0800 (PST)
Date:   Thu, 17 Jan 2019 08:07:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: tps65218.c: Add input voltage options
Message-ID: <20190117080743.GI23399@dell>
References: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1547453794-18770-3-git-send-email-Christian.Hohnstaedt@wago.com>
 <20190116141336.GG23399@dell>
 <20190117055436.GA4213@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190117055436.GA4213@wago.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019, Christian Hohnstaedt wrote:

> On Wed, Jan 16, 2019 at 02:13:36PM +0000, Lee Jones wrote:
> > On Mon, 14 Jan 2019, Christian Hohnstaedt wrote:
> > 
> > > These options apply to all regulators in this chip.
> > > 
> > > ti,strict-supply-voltage-supervision:
> > >   Set STRICT flag in CONFIG1
> > > ti,under-voltage-limit-microvolt:
> > >   Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
> > > ti,under-voltage-hyst-microvolt:
> > >   Select 200mV or 400mV UVLOHYS in CONFIG2
> > > 
> > > Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> > > Tested-by: Keerthy <j-keerthy@ti.com>
> > > Reviewed-by: Keerthy <j-keerthy@ti.com>
> > > ---
> > >  drivers/mfd/tps65218.c       | 89 ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/tps65218.h |  4 ++
> > >  2 files changed, 93 insertions(+)
> > 
> > This looks like regulator code.
> > 
> > Why aren't you placing it into the regulator driver?
> 
> This code manages properties of the chip, affecting all regulators.
> 
> The regulator-driver has no hook to be called once for the chip.
> Even if I put this code into the regulator driver file,
> I will have to call it from here.
> 
> This would introduce a dependency from the mfd to the regulator code.

Sounds reasonable.  Thanks for the explanation.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
