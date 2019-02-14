Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1112C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704F92177E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550139144;
	bh=YXtmQ5Rw/QnO2bzLMWGH5cDi05aarrOJoMlOia/mhgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uQiZOQCaF8syg+0/fIWujqHxBmyfLqRJRe7hou8uPudIRTcc7+TrkCw6LMq79to0J
	 PaECa4UOkyJOMSaCuPdoHq7bgeDnrR5Z10i1hgqkIP38+5VBPDr11EPCMbT/Tfc9t6
	 vNFD4Xw7oRcYVEo66vFXebP7pZIFiWQdDSqiiUP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406442AbfBNKMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:12:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37901 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfBNKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:12:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id j19so3927419ljg.5;
        Thu, 14 Feb 2019 02:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qxerFGMWahyMCWOq0ia4/lTLwF5vmBx2M/yvwTR9Wc=;
        b=ToUuIXgxpQaYke7WsWiBKxBpKvvqxdOPIZLb4WZBfJnDMzKF0mziMHG703aqI/WBCo
         1IR92SL4CO6lKR6rgPPh2y3mRigLwJdo381TSghZ4YCK0L2+39/az87v18g0CFi7KliK
         eGnND3jTOkcxAvnIeldseHXkEkDek4lKhDk1/Ys7iQYxtzoDDpETg+pRoqidpwDSwsFV
         595AQm8/DbbiNgiryyh9uknHBczLX/cV2BjXKIZZHv5++BE/5DiotELkvqGOlQEWwD6R
         rhM0kv8uHEowSSeaLP78UgCC4PRumT3FJp2n8rPhWx+m5paGg8rBlSHZ6fnmvcdzosxv
         n6SA==
X-Gm-Message-State: AHQUAubQZ2xjB/JKOypj3bZ2BMC0+q2fY4fnJRC/L+DepXGqwSg+jQr7
        twSE5ufip5ahk9wpbkeOFxs=
X-Google-Smtp-Source: AHgI3IYMjxeC+55ZGGeACmD0LbPG9pfvF4TuCOWHxIs4cmGHsYI2wF62bBVZRN6uQumAO8+1FXUkow==
X-Received: by 2002:a2e:8719:: with SMTP id m25-v6mr1947042lji.121.1550139140032;
        Thu, 14 Feb 2019 02:12:20 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id p14sm382839lfk.16.2019.02.14.02.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 02:12:19 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1guE04-0002MM-OH; Thu, 14 Feb 2019 11:12:12 +0100
Date:   Thu, 14 Feb 2019 11:12:12 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Loys Ollivier <lollivier@baylibre.com>, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/4] gnss: add driver for mediatek receivers
Message-ID: <20190214101212.GJ28278@localhost>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
 <1550070569-18588-5-git-send-email-lollivier@baylibre.com>
 <20190214100019.GA4197@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214100019.GA4197@Red>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:00:19AM +0100, Corentin Labbe wrote:
> On Wed, Feb 13, 2019 at 04:09:29PM +0100, Loys Ollivier wrote:
> > Add driver for serial-connected Mediatek-based GNSS receivers.
> > 
> > These devices typically boot transmitting vendor specific NMEA output
> > sequences. The serial port bit rate is read from the device tree
> > "current-speed".
> > 
> > Note that the driver uses the generic GNSS serial implementation and
> > therefore essentially only manages power abstracted into three power
> > states: ACTIVE, STANDBY, and OFF.
> > 
> > For mediatek receivers with a main supply and no enable-gpios, this simply
> > means that the main supply is disabled in STANDBY and OFF (the optional
> > backup supply is kept enabled while the driver is bound).
> > 
> > Note that the timepulse-support is left unimplemented.
> > 
> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>

> > +static int mtk_set_active(struct gnss_serial *gserial)
> > +{
> > +	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
> > +	int ret;
> > +
> > +	ret = regulator_enable(data->vcc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> 
> Hello
> 
> This could be simplified to return regulator_enable(data->vcc);

Indeed, but I prefer this style which clearly separates the error path
from the success path while making the success return value explicit.

> Furthermore, after this simplification, the function seems useless.

Why do you think so? You still need to retrieve the regulator from the
driver data. Sure, this could be folded into mtk_set_power(), but that
would be less ideal if there are more resources that need to be managed
(e.g. an external lna supply).

Thanks,
Johan
