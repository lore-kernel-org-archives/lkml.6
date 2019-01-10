Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F36AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E540A20685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vS4joWGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfAJRmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:42:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38059 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbfAJRmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:42:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so5631794pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x61sy6HVH2OoeCOp7/7V95HtWOrjyuhDwclVga2jBBg=;
        b=vS4joWGT20fy2/cLZ6UPT+x1qCrSRMQUELhlwaH++WxIx2ekWxH2q4D77joK/vLtC/
         m5Oaubp9y3k4oHKS5nR2tL00TfP2RIAE/uu1o8lxNYmioXhHFp+1ePpy0JHrL6gJARzF
         8DE8x8+I/RSURnU9rSHR4ry/bUXqxpd1rYEnlcWYV0jfs6N7gJdztdWDlgRwqlS3qoNm
         odcpWtnQ8BaRAXPxm4ncyLSE7sQsXTtZjiduXTwCLZmsUXGVETxUC/DI3ZRHXGPxPy/g
         TY0gUdOQyhOOC2t3DsJ3m+iuKCxi+F5XYIJDmB3iKNkXYCASfzGA/Y3NzRY00wJTzB0L
         LKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x61sy6HVH2OoeCOp7/7V95HtWOrjyuhDwclVga2jBBg=;
        b=T51FkWMnqZWYI4Bu9ij6ULnwPHkY42++nkOpHmh3RQSmy1VM0cheRwSSTvBvaAV0IP
         MZO3+Mz186p/zRTCHhmahIysA15GE5z0XVZjRNa2dQv152KOtkSXL0BPhG3u8ziVmoyN
         MSSi1uB9/Wu3ymJHtAhfbOOpPnzMbDw6AlkvZ0wFdwMvctzefeJQxMQ56Qgzei9+DW3A
         sWkoiJjrIRxPfQT2SXbnpKtf6KLocqdZy7v7pPvd7jxoM56vqP+KwjqayE1Ho1MdE70H
         rpq9kqjEHxnbhmNYGBJc+jWkkVg0OQavHf8BH728DJK1GxfbphYgvymfFqbF8GwSH5if
         ckQw==
X-Gm-Message-State: AJcUukcAP4cMvuwe7ZGkiOsDRby1kf/jhW/dchk4RcBtUA96xNLwto+n
        nJzDDDx9FEDS3wpwkoPyJtk=
X-Google-Smtp-Source: ALg8bN6qNHwmdVCTmQo8EbG0IGSBZu9KO+dfe4RD/vsXlRsVS9SuUgvpMULXV3qHAQqi0qK75PA0lQ==
X-Received: by 2002:a63:6a05:: with SMTP id f5mr10073569pgc.72.1547142124257;
        Thu, 10 Jan 2019 09:42:04 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id 24sm323667680pfl.32.2019.01.10.09.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:42:03 -0800 (PST)
Date:   Thu, 10 Jan 2019 23:11:56 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, nishadkamdar@gmail.com
Subject: Re: [PATCH v4 3/4] staging: greybus: arche-apb-ctrl.c: Switch to the
 gpio descriptor interface
Message-ID: <20190110174155.GC24566@nishad>
References: <cover.1545488665.git.nishadkamdar@gmail.com>
 <54ba56b6b071ba48ca06713a108ccfb542c5d2e5.1545488665.git.nishadkamdar@gmail.com>
 <20190109113043.GK14782@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109113043.GK14782@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:30:43PM +0100, Johan Hovold wrote:
> On Sat, Dec 22, 2018 at 08:22:09PM +0530, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated old non-descriptor
> > interface.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v4:
> >  - Use gpiod_set_raw_value() for deassert_reset() and
> >    assert_reset() as gpiod_set_value() will change the
> >    sematics of these calls by taking any gpio flags
> >    into account.
> 
> Please also mention this in the commit message (i.e. that we continue to
> ignore gpio flags from device tree for now).
> 
Ok, I'll do that.
> >  - Remove some unnecesssary line breaks.
> >  - Restore 'spi_en' gpio check in fw_flashing_seq()
> >    as it is currently optional.
> > Changes in v3:
> >  - Add this patch in a patchset.
> > Changes in v2:
> >  - Resolved compilation errors.
> > ---
> 
> > @@ -75,11 +74,10 @@ static int coldboot_seq(struct platform_device *pdev)
> >  		return 0;
> >  
> >  	/* Hold APB in reset state */
> > -	assert_reset(apb->resetn_gpio);
> > +	assert_reset(apb->resetn);
> >  
> > -	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING &&
> > -	    gpio_is_valid(apb->spi_en_gpio))
> > -		devm_gpio_free(dev, apb->spi_en_gpio);
> > +	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING && apb->spi_en)
> > +		devm_gpiod_put(dev, apb->spi_en);
> >  
> >  	/* Enable power to APB */
> >  	if (!IS_ERR(apb->vcore)) {
> > @@ -101,13 +99,13 @@ static int coldboot_seq(struct platform_device *pdev)
> >  	apb_bootret_deassert(dev);
> >  
> >  	/* On DB3 clock was not mandatory */
> > -	if (gpio_is_valid(apb->clk_en_gpio))
> > -		gpio_set_value(apb->clk_en_gpio, 1);
> > +	if (apb->clk_en)
> > +		gpiod_set_value(apb->clk_en, 1);
> >  
> >  	usleep_range(100, 200);
> >  
> >  	/* deassert reset to APB : Active-low signal */
> > -	deassert_reset(apb->resetn_gpio);
> > +	deassert_reset(apb->resetn);
> >  
> >  	apb->state = ARCHE_PLATFORM_STATE_ACTIVE;
> >  
> > @@ -136,25 +134,25 @@ static int fw_flashing_seq(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > -	if (gpio_is_valid(apb->spi_en_gpio)) {
> > +	if (apb->spi_en) {
> >  		unsigned long flags;
> >  
> >  		if (apb->spi_en_polarity_high)
> > -			flags = GPIOF_OUT_INIT_HIGH;
> > +			flags = GPIOD_OUT_HIGH;
> >  		else
> > -			flags = GPIOF_OUT_INIT_LOW;
> > +			flags = GPIOD_OUT_LOW;
> >  
> > -		ret = devm_gpio_request_one(dev, apb->spi_en_gpio,
> > -					    flags, "apb_spi_en");
> > -		if (ret) {
> > -			dev_err(dev, "Failed requesting SPI bus en gpio %d\n",
> > -				apb->spi_en_gpio);
> > +		apb->spi_en = devm_gpiod_get(dev, "gb,spi-en-gpio", flags);
> 
> I just noticed that you change the name of the device-tree property here
> (and later in apb_ctrl_get_devtree_data()). How is that expected to
> work without breaking current systems? This will be unavoidable at some
> point, but must not be snuck into a patch like this without any comment.
> Please keep the current names for now.
> 
Ok, I'll do that.
> I do think you need to drop the "-gpio" suffix when requesting the gpio
> though. Please double check to make sure.
> 

Ok, I'll check it.
> Johan

Thanks for the review.

Regards,
Nishad
