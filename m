Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51141C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BC720833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BC720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeIJMVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:21:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34153 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeIJMVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:21:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id c29-v6so16624474lfj.1;
        Mon, 10 Sep 2018 00:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fByjZsMMuenoWVp1AstnTqieplj7+pgo2C4G7EG8Ra0=;
        b=HTCJVsoCn5MJI5L8rNUmb9iDtmslJ6InxhU0f377+Pn0WqRFpO+hTtzUelcugQTHKf
         tsu+eQlOxAjF9YanpSegXDH7f2k+CLympk4TM578o+3zBa9pV/2JQbEAuY+zNIpaO+m4
         5Z8g5RYUTSHkH6vvxVTmjemlNDq0AaQsx4WA2MIdEJwISLDjnlStzHrLz/FuoZlovEcd
         vQBVNByS9ZAFswxSw+PGzNnTLdxgNn/i02Gp40Regtp0XaP/LoY03rEMGjN2gfyNyOSV
         bxlFHxMQL24dXPoMrHrlLJO5xv8ehWXYupIUsVlNFZ9sY4Z9FBYqgAn4THcdQsYF7qxt
         1Qig==
X-Gm-Message-State: APzg51BePmR24V3UL0jwtALpVF/RTabk+ifBGKBxECEcVbJ1Gec+tToN
        Ra3iU+wVJnzfM7rakRoTu3s=
X-Google-Smtp-Source: ANB0VdYsanvRy4v4OD04ocWnqmDL3XGKRLlKJTn6z5cSn/0U5C5YJFoe/MlxCexVSthPbVgNvAoYmA==
X-Received: by 2002:a19:6f0a:: with SMTP id k10-v6mr9248347lfc.143.1536564507913;
        Mon, 10 Sep 2018 00:28:27 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id w18-v6sm2575735ljd.73.2018.09.10.00.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 00:28:27 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:28:18 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     zyw@rock-chips.com, mturquette@baylibre.com, sboyd@kernel.org,
        w.egorov@phytec.de
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Does Rockchip RK808 driver unload work as intended?
Message-ID: <20180910072818.GA2454@localhost.localdomain>
References: <20180907101940.GE2472@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907101940.GE2472@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Sep 07, 2018 at 01:19:40PM +0300, Matti Vaittinen wrote:
> While doing this I hit to Rockchip RK808 driver which seems to utilize
> oarent device (MFD dev) for pretty much all devm releasing. I wonder if
> this is safe? What happens if one tries to remove the RK808 clk module?
> 
> I guess the clk deregistration and cleanups are not ran as parent device
> stays there, right? But is the clk module and clk module code still
> unload? So won't clk operation pointers registered to clk core become
> invalid?
 
Maybe it is a good idea to paste some code and add my thoughts as
comments here.

static int rk808_clkout_probe(struct platform_device *pdev)
{
	/* Get the i2c device "driven by" the parent MFD driver */
        struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
        struct i2c_client *client = rk808->i2c;

	[snip]

	/* Allocate driver provate data using devm - but bind it to MFD
	   device */
	rk808_clkout = devm_kzalloc(&client->dev,
                                    sizeof(*rk808_clkout), GFP_KERNEL);

	[snip]

	/* init clk ops to point operations brought in kernel in this
	   module */
	init.ops = &rk808_clkout1_ops;
        rk808_clkout->clkout1_hw.init = &init;

	[snip]

	/* register clock using devm - bound to parent device again */
        ret = devm_clk_hw_register(&client->dev, &rk808_clkout->clkout1_hw);

	[snip]

/* Omit remove callback => no clk deregistration at module removal */
static struct platform_driver rk808_clkout_driver = {
        .probe = rk808_clkout_probe,
        .driver         = {
                .name   = "rk808-clkout",
        },
};

module_platform_driver(rk808_clkout_driver);


> So can someone please shed some light on this? Is this a bug or am I
> just plain wrong?
> 
