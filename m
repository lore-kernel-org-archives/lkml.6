Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0DAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794BA214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3SvHWx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794BA214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeIZOVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:21:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46447 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIZOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:21:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id d8-v6so6103756pfo.13;
        Wed, 26 Sep 2018 01:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/m7KNb/ScisxKtxaNhYNgvcrtqIq6lGo9kjSwlatAU=;
        b=M3SvHWx3/KVvfKHAt0ifP6+GjYBQTJM2A8LG4o1JMYYXtePccD65STqL15640hNKi4
         biBuB5DgnMnRO1ZqyIsBjnXeyF4DzGr1mKxZPyRinTyHoGZ6aht387+dB6npyKdfM/xm
         A2a6ttEaaU6fU/aU8E/qvgGDVzgw+SqNN/CcT+EZJecv1dTKfbNqLa4Bub69VdsCDsz7
         0A42rAKQt4p9MbbezncYcEORqjv3Qpov2IUR3RxyHyahkUf5ItaZd9W7HKc1JeOTmGgE
         ++L4xtlaYArrTjWXybKsG7ECLklyYJLiIQGwTlYP5MM7TvdvTEgtrbBI6X3RSa7xYsaJ
         eCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/m7KNb/ScisxKtxaNhYNgvcrtqIq6lGo9kjSwlatAU=;
        b=NeziWGMVB2kveLPwTFb+Qf9gmJPu81YH22jyZ9f0Xv7EpjBta98+n3RjqkjpU5QkLI
         IVd201vK8+9OuHq9s0LvWD9d16a082aOCd+pKiSGsBaLWgdOI0Jdbd0rmnspiRghl8uu
         x96abCHgjc6jnZYwC8AXFmNKCtokj5HPuojoy9NWZMXi79qp8KtnC79zZ7QT1pvfqFBq
         7Ef2TSdr/YlAJoCS8iHBcwlg+fVthzxXYbCKSMVIk7x/6RhEbSFq4harPsEmOKZ/hw5K
         z72C6j0ckx3Cg4vWiB/v/0ULQLoo2hRBE5rAJ/IrbTkjJIYj8WMax7VreeCvaxyAMpTC
         D3xA==
X-Gm-Message-State: ABuFfoiN4Kzp7J3iOg6BFew7vhMhnhQzFB45NY2IigVN3WZBwPEfMPnK
        C4A/Xpti+mjvV3IkOVYhXfE=
X-Google-Smtp-Source: ACcGV62R9qi2RHWqZRMBos1P7BRuqwRdu1bVcRo5/Kptu7OwnLoTMX+PWwrzI06+S14LGW6VBHyhVA==
X-Received: by 2002:a63:4c16:: with SMTP id z22-v6mr4689105pga.312.1537949392654;
        Wed, 26 Sep 2018 01:09:52 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id f81-v6sm16182252pfh.46.2018.09.26.01.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 01:09:52 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:09:45 +0800
From:   Song Qiang <songqiang1304521@gmail.com>
To:     Phil Reid <preid@electromag.com.au>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        rtresidd@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: Add driver support for PNI RM3100
Message-ID: <20180926080752.GA12183@Eros>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
 <20180925031724.21399-2-songqiang1304521@gmail.com>
 <20180925143054.00007fcb@huawei.com>
 <57d8a9d6-c402-068e-0a21-bbd6c20a7816@electromag.com.au>
 <20180926014951.GA7094@Eros>
 <4de691f2-dbc9-6124-efa6-66f2dd7e0f2b@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4de691f2-dbc9-6124-efa6-66f2dd7e0f2b@electromag.com.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:30:34AM +0800, Phil Reid wrote:
> On 26/09/2018 9:49 AM, Song Qiang wrote:
> > On Tue, Sep 25, 2018 at 10:36:54PM +0800, Phil Reid wrote:
> > > On 25/09/2018 9:30 PM, Jonathan Cameron wrote:
> > > > > +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> > > > > +{
> > > > > +	struct iio_poll_func *pf = p;
> > > > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > > > +	struct rm3100_data *data = iio_priv(indio_dev);
> > > > > +	struct regmap *regmap = data->regmap;
> > > > > +	u8 buffer[9];
> > > > > +	int ret;
> > > > > +	int i;
> > > > > +
> > > > > +	mutex_lock(&data->lock);
> > > > > +	ret = rm3100_wait_measurement(data);
> > > > > +	if (ret < 0) {
> > > > > +		mutex_unlock(&data->lock);
> > > > > +		goto done;
> > > > > +	}
> > > > > +
> > > > > +	ret = regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, sizeof(buffer));
> > > > > +	mutex_unlock(&data->lock);
> > > > > +	if (ret < 0)
> > > > > +		goto done;
> > > > > +
> > > > > +	/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for padding. */
> > > > > +	for (i = 0; i < 3; i++)
> > > > > +		memcpy(data->buffer + i * 4, buffer + i * 3, 3);
> > > > Firstly X doesn't need copying.
> > > > Secondly the copy of Y actually overwrites the value of Z
> > > > XXXYYYZZZxxx
> > > > XXXxYYYZZxxx
> > > > XXXxYYYxYZZx
> > > > 
> > > > I think...
> > > > 
> > > > > +
> > > > > +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> > > > > +			iio_get_time_ns(indio_dev));
> > > 
> > > memcpy target is a different buffer so should be ok.
> > > 
> > > But that raises the question of does it need to be?
> > > 'buffer' could be 12 bytes long and just shuffle Z then Y.
> > > Do the unused bytes need to be zeroed? or does libiio mask them anyway?
> > > 
> > > 
> > > 
> > > -- 
> > > Regards
> > > Phil Reid
> > 
> > Hi Phil,
> > 
> > This is interesting, last patch I submitted uses three transactions and
> > shuffles X, Y and Z respectively. You said it should be better to use one
> > transactions, I thought it makes point, and one transaction may reduce
> > IO pressure of the i2c bus. :)
> > And that's not necessary for unused bytes to be zero. I'm not familiar
> > with libiio, actually just been studying it, can't say anything about
> > it.
> > 
> > yours,
> > Song Qiang
> > 
> > 
> G'day Song,
> 
> yes the one transaction suggestion was to reduce pressure on the bus.
> I think also with 3 calls you can up up with other devices taking over
> the i2c / spi bus in between.
> 
> We've got a devkit for this part, but haven't got to wiring it up to our system as yet.
> We're looking at using the i2c interface which could push things at max samplerate, so yes I'm
> keen to see bus pressure reduced as much as possible.
> 
> I was thinking something like the following:
> 
> u8 buffer[12];
> regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, 9);
> 
> buffer[10] = buffer[8]; // or memcpy or some other fancy shuffle code.
> buffer[9]  = buffer[7];
> buffer[8]  = buffer[6];
> 
> buffer[6]  = buffer[5];
> buffer[5]  = buffer[4];
> buffer[4]  = buffer[3];
> 
> iio_push_to_buffers_with_timestamp(indio_dev, buffer, iio_get_time_ns(indio_dev));
> 
> but I'm unsure if this would be needed:
> buffer[7] = 0
> buffer[3] = 0
> 
> What you've got does the job I think.
> 
> I haven't dug into the datasheet in great detail, and my iio knownledge is limited.
> Are you sure the RM3100_CHANNEL scantype endianness is IIO_LE.
> rm3100_read_mag looks to be doing big endian conversion and the datasheet agrees with that.
> 
> 
> -- 
> Regards
> Phil Reid
> 

Hi Phil,

You're absolutely right!
This should be big endian, I think I probably just want something there
when I was writing this code, planned to change it later, but apparently
I've forgotten it...

AFAIK, filling places we do not need with 0 is not needed, we just
extract valid data from valid bit field(24 here).

Both one transaction and three transactions way have their point, but
this is a OS, probably the spiltted one is better, I need some real
thinking about this...

I could have use the same buffer to read from the sensor and send it to
userspace like this:

int i = 0;
ret = regmap_bulk_read(regmap, RM3100_REG_MX2, 9);
if(ret)
	...
/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. */
for (i = 0; i < 2; i++)
	memcpy(buffer + (2 - i) * 4, buffer + (2 - i) * 3), 3);

This code snippet will use the same buffer, actually that's what I was
using the first time. Jonathan must thinks so, from what he commented,
he assumed I was using the same buffer, also what you want.
But I changed this due to Peter's comment, maybe not a big deal, he
suggests to use sizeof(buffer), this makes me use an additional size 9
buffer. I thought this doesn't matter too much, just some additional
space from the stack, but now I think maybe less memory using would be
better...
After all, this length 9 seems like never shouldn't be changed...

yours,
Song Qiang

