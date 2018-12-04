Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A31C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CB020850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CB020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeLDIDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:03:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41915 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:03:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so13976925ljb.8;
        Tue, 04 Dec 2018 00:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fgPj/u/cz0JV2Wgf14qUC+gVFxhWVypKSVSkLhduCpo=;
        b=B0jWIo/Rp+QLGShIQrW/gLhQkySAyK2GYCHQLtJ3YP3M72V2COC5klR/8tr9D+jS11
         vVzs7ic4IJqPgjsmGRSjsO6Z1K4k+jSPYbNKBAI2rjbXblcu7KrBWSKw4scgz3NH2Usg
         Lcv/jurdnWe39/WNhcx+07FVLsTM7iHmIWd8iJJ7tg2Jh6DxtZSsXln8Ruw5WCc/zynn
         al+PpuTURKKGK8MUyvfvdgpzvHhKZObtZHW5LVSJBTREO7P1KlKax7pMpjFBlV6DybOa
         ztdrJLQI2BZyl7fV9DhoJaeVLeOOEbQsqj/MiMnmsgDl8u0iofPDXlYpSehPFm7jZYgh
         YLYQ==
X-Gm-Message-State: AA+aEWZ6WLiUODKR95WOoVY8/12t675tpGlrqhBpjvIkH+SaysPZ8ig2
        rdhhIHxEZdDAaCw5STYON6E=
X-Google-Smtp-Source: AFSGD/XzR8al4PJv1hjBQ6E90ofwrr0mxzqNq5Rj8cjmq74JEG21KXDsbLsLtgg7X1mpy6ks0z5cRw==
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr12121391lji.30.1543910621825;
        Tue, 04 Dec 2018 00:03:41 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c22sm2808778lfd.88.2018.12.04.00.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 00:03:41 -0800 (PST)
Date:   Tue, 4 Dec 2018 10:03:38 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     mazziesaccount@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, andy.gross@linaro.org,
        david.brown@linaro.org, pavel@ucw.cz, andrew.smirnov@gmail.com,
        pombredanne@nexb.com, sjhuang@iluvatar.ai, akshu.agrawal@amd.com,
        djkurtz@chromium.org, rafael.j.wysocki@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/9] clkdev: add managed clkdev lookup registration
Message-ID: <20181204080338.GB31204@localhost.localdomain>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
 <b6c5c110c482ff6a6b2378ab3518bd31c6233872.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
 <20181203180612.GM30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203180612.GM30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

Thanks for the review. I do appreciate this. I'll send out v6 where I'll
have these fixed =)

On Mon, Dec 03, 2018 at 06:06:12PM +0000, Russell King - ARM Linux wrote:
> > +static int devm_clk_match_clkdev(struct device *dev, void *res, void *data)
> > +{
> > +	struct clk_lookup **l = res;
> > +
> > +	if (!l || !*l) {
> > +		WARN_ON(!l || !*l);
> 
> How can "l" be NULL here?  How can *l be NULL?

I really don't know if there is any "sane" way to end up having the
devres data NULLed. I admit I looked an example on how others had
implemented the match. These checks were present in devm_clk_match
and devm_regmap_irq_chip_match so I assumed there is a way to end up
having NULL there. Thus I played safe. OTOH it seems that for example
devm_hwmon_match does omit these checks and I really don't see right
away why the dr->data would be NULL. So I'll remove the check.

Br,
	Matti Vaittinen

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
