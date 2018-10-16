Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3FBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C417E21470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw+8pwdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C417E21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeJQELE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:11:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37013 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeJQELE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:11:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id u6-v6so8804148plz.4;
        Tue, 16 Oct 2018 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FXvGKmCJTg/crlRepi1xye2mb+DzUC6xLC/WEUC1SsI=;
        b=lw+8pwdJYHzTXZnStQ62STvC+BL3NvPtRGJ4Rtey3seDeHKWRmdl5Sa5QZUDGnp94f
         KJwk8XS8gIW9Xlofq1K7W0P0kiPZ/tYQB7Ne3MuiReACNHO+8I8rUBoYedkc1xgZ2/az
         oRTLinVTtWVsk8zFKht+0ihrFWSLrJEfpZAqR7iY3qJa1mvDtcXwz2yaZklp0OUByvoD
         mki6bop0nFpulOXYDRv/Hv3JbZjm5evYXplq9T3AUYQsf9ATp8/7AeiE98Jd0MWuMarB
         50jcuM6IYHiDfVcISAjRgkcPRTpCB9ZLro7JCfwRJ05jelnv5aobvf1+BdAdTpfCU6oR
         N0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FXvGKmCJTg/crlRepi1xye2mb+DzUC6xLC/WEUC1SsI=;
        b=HcyWqzXip15H6+/+pbgtg+VdPVjedyiKT6RTulVI+kzgFTt8K2ngIk8WPTpIupuErY
         eIUMSQD+JnMfKlXdSw5Yf4Mj0HO6L5hLjL++fApmQ+SvKTdKvqAM6Ehl7OOLpmOoMiE2
         ZypXFJGSLGISSjh29TxtEfcWtCHWr/hMg2ql6n5dgV0DDUllLlnPqvtKgD6RauSamIEa
         pUJ5a5Cml9X4fVtT8NTv1m+V89xVdrOQxduTYq/vNU/ChT+RWKuOZOzS5wUVRG4EnCtK
         YuXSyCHpklpt5zsTEgqupHWBgf3UgceMTtQL5o+o9UIKTtB8UHMH4+BMp6ZhiPbReviS
         9Ncw==
X-Gm-Message-State: ABuFfoi0gOc0eZXm584/XW8DcDm8HVNDQRTneTCPgc58PK+ynV6EWZPM
        AvNLC3PmKkUaVXWDVR0HLpVXCtYYdy0=
X-Google-Smtp-Source: ACcGV63KiCjrh0LUhr15shVFqBsDlhtXrcjJSTkZjYbChRonvbh7Zf9zGGW9eRM3sAf20VLXmcndbQ==
X-Received: by 2002:a17:902:8502:: with SMTP id bj2-v6mr22695380plb.295.1539721137587;
        Tue, 16 Oct 2018 13:18:57 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id s85-v6sm23286001pfi.15.2018.10.16.13.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 13:18:56 -0700 (PDT)
Date:   Tue, 16 Oct 2018 13:18:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] Input: sx8654 - add sx8650 support
Message-ID: <20181016201853.GF230131@dtor-ws>
References: <20181016091653.26896-1-richard.leitner@skidata.com>
 <20181016092248.27288-1-richard.leitner@skidata.com>
 <20181016174838.GD230131@dtor-ws>
 <575f935b-e082-7d19-30c1-4db36ed6114d@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <575f935b-e082-7d19-30c1-4db36ed6114d@skidata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 09:34:26PM +0200, Richard Leitner wrote:
> 
> On 10/16/18 7:48 PM, Dmitry Torokhov wrote:
> > On Tue, Oct 16, 2018 at 11:22:48AM +0200, Richard Leitner wrote:
> > > The sx8654 and sx8650 are quite similar, therefore add support for the
> > > sx8650 within the sx8654 driver.
> > > 
> 
> ...
> 
> > >   /* bits for I2C_REG_CHANMASK */
> > > -#define CONV_X				0x80
> > > -#define CONV_Y				0x40
> > > +#define CONV_X				BIT(7)
> > > +#define CONV_Y				BIT(6)
> > 
> > If you are using BIT() you need to include include/linux/bitops.h
> > 
> > I also would prefer conversion to using BIT() as a separate patch.
> 
> OK. I'll take it out of this patch.
> 
> Should I convert them (and the other #defines where it makes sense) to BIT()
> at all?

Sure as it documents the intent better, I just asked it to be split out
since each patch should solve one particular problem.

> 
> > 
> > >   /* coordinates rate: higher nibble of CTRL0 register */
> > >   #define RATE_MANUAL			0x00
> > > @@ -71,14 +75,110 @@
> > >   /* power delay: lower nibble of CTRL0 register */
> > >   #define POWDLY_1_1MS			0x0b
> > > +/* for sx8650, as we have no pen release IRQ there: timeout in ns following the
> > > + * last PENIRQ after which we assume the pen is lifted.
> > > + */
> > > +#define SX8650_PENIRQ_TIMEOUT		(80 * 1100 * 1000)
> > > +
> > >   #define MAX_12BIT			((1 << 12) - 1)
> > > +#define MAX_I2C_READ_LEN		10 /* see datasheet section 5.1.5 */
> > > +
> > > +/* channel definition */
> > > +#define CH_X				0x00
> > > +#define CH_Y				0x01
> > > +
> > > +struct sx865x_data {
> > > +	u8 cmd_manual;
> > > +	u8 chan_mask;
> > > +	u8 has_irq_penrelease;
> > > +	u8 has_reg_irqmask;
> > > +	irq_handler_t irqh;
> > > +};
> > >   struct sx8654 {
> > >   	struct input_dev *input;
> > >   	struct i2c_client *client;
> > >   	struct gpio_desc *gpio_reset;
> > > +	struct hrtimer timer;
> > 
> > Does this have to be hrtimer? Can regular timer be used?
> 
> I'll check again if it's feasible to reduce the timer delay to something
> below the "normal" jiffy. If not I'll replace the hrtimer with a timer.

That means polling faster than 200HZ in the best case. I think it is too
much.

> 
> > 
> > > +
> > > +	const struct sx865x_data *data;
> > >   };
> > > +static enum hrtimer_restart sx865x_penrelease_timer_handler(struct hrtimer *h)
> > > +{
> > > +	struct sx8654 *ts = container_of(h, struct sx8654, timer);
> > > +
> > > +	input_report_key(ts->input, BTN_TOUCH, 0);
> > > +	input_sync(ts->input);
> > > +	dev_dbg(&ts->client->dev, "penrelease by timer\n");
> > > +
> > > +	return HRTIMER_NORESTART;
> > > +}
> > > +
> 
> ...
> 
> > > @@ -196,10 +312,30 @@ static void sx8654_close(struct input_dev *dev)
> > >   }
> > >   #ifdef CONFIG_OF
> > > +static const struct of_device_id sx8654_of_match[] = {
> > > +	{
> > > +		.compatible = "semtech,sx8650",
> > > +		.data = &sx8650_data,
> > > +	}, {
> > > +		.compatible = "semtech,sx8654",
> > > +		.data = &sx8654_data,
> > > +	}, {
> > > +		.compatible = "semtech,sx8655",
> > > +		.data = &sx8654_data,
> > > +	}, {
> > > +		.compatible = "semtech,sx8656",
> > > +		.data = &sx8654_data,
> > > +	}, {},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, sx8654_of_match);
> > > +
> > >   static int sx8654_get_ofdata(struct sx8654 *ts)
> > >   {
> > >   	struct device *dev = &ts->client->dev;
> > >   	struct device_node *node = dev->of_node;
> > > +	const struct of_device_id *of_id = of_match_device(sx8654_of_match,
> > > +							   dev);
> > 
> > If you use of_device_get_match_data() you do not need to move device
> > table around.
> 
> Thanks for that hint. I haven't known there's something like this ;-)
> 
> > 
> > > +	const struct sx865x_data *data = (struct sx865x_data *)of_id->data;
> > >   	int err;
> > >   	if (!node) {
> 
> ...
> 
> > > @@ -327,6 +466,7 @@ static int sx8654_probe(struct i2c_client *client,
> > >   }
> > >   static const struct i2c_device_id sx8654_id_table[] = {
> > > +	{ "semtech_sx8650", 0 },
> > 
> > Can we add the data here as well?
> 
> Does it generate any benefit if we add it? Who should be using it?

If someone decides to use driver in non-DT environment.

> 
> I found in other drivers that it's used as a fallback when
> of_device_get_match_data() returns NULL... Should I also implement it that
> way?

Yes, that would be good.

Thanks.

-- 
Dmitry
