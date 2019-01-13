Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3BFC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 12:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826BF2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 12:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV7Wi/KD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfAMMye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 07:54:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34042 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfAMMye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 07:54:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so8899745plz.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 04:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8/Q4l1jgysTNdOIsGe3KhRDq4zDNW7A/D6UCubA34L0=;
        b=YV7Wi/KDN8ptVezMge/+EsoIpkARkBAhR/EnTVbNVgmuojPJ9ANvw9EuZmd4WBGioF
         3d43z9xkIe6Rt880tiqs2Fe3NbtYqqwcD74l0AD31n31mFtZhdbZ9jgBjhlbocyQwX3p
         eCEiYTm6HZfIffpKXWQngfDPtGYhIZiFOwADYG0JTPyKPRwEIeKZZvgheZSU93JNMKDC
         iYdstAuhsVWVEkitodKQ93MYY5dJSEVbbJAedXQu7LSAHtno1bxb5PaRXCMzt3lso3F+
         Tmv+Ei7wlOuOPLcyG+Tbd8mjhf52OyDC7Ph/wPYLX+oTcVPfMSgOffbMLs22e+c6pihZ
         /oDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8/Q4l1jgysTNdOIsGe3KhRDq4zDNW7A/D6UCubA34L0=;
        b=dBe4sY+C1PHd0FYtx/QOCwzHQV3duXcnsm1+52hj2SVFOVr9P+bi/6S0FSyfTV9i7K
         2sUATtTt1MCpKoZcXvOKPOng4Kk9uaiO1xjN2l93NA3dl3cZUoJxhMGJSdLubBk2BP8y
         mc7Vlut+HcUX9+/0a5Rcck7OFnBOnWgCz8M7HZS5O7sgx7yE2ItqYKE3dZCpyRytQ0Az
         aDbuYOgjIkyzb1Hs/j3bCmh90knFmx3ALSJ5vXPjADD5+wskmLj3KHwEV/rT5jDUigxH
         Nri4RUzLov6KBURNrEoVVTE9ZkBAX1SNvZpYK1HejkRQa0N6B8KkOK8wAY3knwws8AXM
         2atg==
X-Gm-Message-State: AJcUukd+KTH30oxo0lAFtJvAmE5CCVciedQl1UT4yDwOpTXKYKkD4BXZ
        wJWz2ISm5R/dLbLCCK2mCB8=
X-Google-Smtp-Source: ALg8bN7UVnzUV1kwxUxKctpNrag+av8g7/wA8jtAUPSfpmlsncZ4Ymg2TSHgBzs2KhaAuGlUQLs1MQ==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr20763234plb.226.1547384073265;
        Sun, 13 Jan 2019 04:54:33 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id z191sm105834313pgd.74.2019.01.13.04.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 04:54:32 -0800 (PST)
Date:   Sun, 13 Jan 2019 18:24:25 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] staging: greybus: arche-apb-ctrl.c: Switch to the
 gpio descriptor interface
Message-ID: <20190113125424.GB16542@nishad>
References: <cover.1547141413.git.nishadkamdar@gmail.com>
 <0f65372f6f223244f7125d074816d5da9e513a8b.1547141413.git.nishadkamdar@gmail.com>
 <20190111084134.GC3383@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111084134.GC3383@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 09:41:34AM +0100, Johan Hovold wrote:
> On Thu, Jan 10, 2019 at 11:21:04PM +0530, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated old non-descriptor
> > interface while continuing to ignore gpio flags from device tree in
> > functions "deassert_reset()" and "assert_reset()" for now.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v5:
> >  - Change the commit message.
> >  - Restore the names of the gpio device-tree properties without
> >    the "-gpio" suffix.
> > Changes in v4:
> >  - Use gpiod_set_raw_value() for deassert_reset() and
> >    assert_reset() as gpiod_set_value() will change the
> >    sematics of these calls by taking any gpio flags
> >    into account.
> >  - Remove some unnecesssary line breaks.
> >  - Restore 'spi_en' gpio check in fw_flashing_seq()
> >    as it is currently optional.
> > Changes in v3:
> >  - Add this patch in a patchset.
> > Changes in v2:
> >  - Resolved compilation errors.
> > ---
> 
> Also looks good now. You can add my
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> 
> Found one really minor nit below, which doesn't really need to be fixed,
> but since you may need to update the third patch, you might as well
> consider this too.
> 
Ok, I'll do that.
> >  	/* It's not mandatory to support power management interface */
> > -	apb->pwroff_gpio = of_get_named_gpio(np, "pwr-off-gpios", 0);
> > -	if (apb->pwroff_gpio < 0) {
> > -		dev_err(dev, "failed to get power off gpio\n");
> > -		return apb->pwroff_gpio;
> > -	}
> > -	ret = devm_gpio_request_one(dev, apb->pwroff_gpio,
> > -				    GPIOF_IN, "pwroff_n");
> > -	if (ret) {
> > -		dev_err(dev, "Failed requesting pwroff_n gpio %d\n",
> > -			apb->pwroff_gpio);
> > +	apb->pwroff = devm_gpiod_get_optional(dev, "pwr-off",
> > +					      GPIOD_IN);
> 
> Looks like you don't need to break the above statement any more either.
> 
> > +	if (IS_ERR(apb->pwroff)) {
> > +		ret = PTR_ERR(apb->pwroff);
> > +		dev_err(dev, "Failed requesting pwroff_n GPIO: %d\n", ret);
> >  		return ret;
> >  	}
> >  
> >  	/* Do not make clock mandatory as of now (for DB3) */
> > -	apb->clk_en_gpio = of_get_named_gpio(np, "clock-en-gpio", 0);
> > -	if (apb->clk_en_gpio < 0) {
> > -		dev_warn(dev, "failed to get clock en gpio\n");
> > -	} else if (gpio_is_valid(apb->clk_en_gpio)) {
> > -		ret = devm_gpio_request_one(dev, apb->clk_en_gpio,
> > -					    GPIOF_OUT_INIT_LOW, "apb_clk_en");
> > -		if (ret) {
> > -			dev_warn(dev, "Failed requesting APB clock en gpio %d\n",
> > -				 apb->clk_en_gpio);
> > -			return ret;
> > -		}
> > +	apb->clk_en = devm_gpiod_get_optional(dev, "clock-en",
> > +					      GPIOD_OUT_LOW);
> 
> Same here?
> 
Ok, I'll do that.

Thanks and regards,
Nishad
> > +	if (IS_ERR(apb->clk_en)) {
> > +		ret = PTR_ERR(apb->clk_en);
> > +		dev_err(dev, "Failed requesting APB clock en GPIO: %d\n", ret);
> > +		return ret;
> >  	}
> 
> Johan
