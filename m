Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB365C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35F421104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="16mNLrts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35F421104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeKKWrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 17:47:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeKKWrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 17:47:36 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F8E9208A3;
        Sun, 11 Nov 2018 12:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541941144;
        bh=s0lMizLlxOx3508/hd+eRGPrs2gCkp+gsYGQb0D0V8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=16mNLrtskDQ9DQg53MwCWh7lnSJCBfg6AsGkWVCmtk+JbIiXzjHGw26SZ3eKM5j60
         OCVmHaWOWxSav6Vl8dFAqN2MV8/34iGTxmmQREjMGokK5hV5is4ozMuP3yHNtkZugF
         qNiqDc3IVom4z2naPsE3Hz9iRLAYE6mmoa83tLyw=
Date:   Sun, 11 Nov 2018 12:58:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: check if ad778x before
 gain update
Message-ID: <20181111125859.7263bc15@archlinux>
In-Reply-To: <77c3b6ee484b077152138cb8e1b7e03295114e54.camel@analog.com>
References: <cover.1541681371.git.giuliano.belinassi@usp.br>
        <762e851dd819f27e3955cb695cd8422d84a19438.1541681371.git.giuliano.belinassi@usp.br>
        <77c3b6ee484b077152138cb8e1b7e03295114e54.camel@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 13:44:17 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Thu, 2018-11-08 at 11:03 -0200, Giuliano Belinassi wrote:
> > Only the ad778x have the 'gain' status bit. Check it before updating
> > through a new variable is_ad778x in chip_info.
> >   
> 
> Looks good.
Alex, formal tags definitely preferred!  It's not as though a
looks good is any less of a review than an Ack, it's just better
hidden as people need to look at mailing list archives...

Jonathan

> 
> Alex
> 
> > Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> > ---
> > Changes in v2:
> > 	- Squashed is_ad778x declaration commit with the ad778x checkage
> > 	- Changed is_ad778x type to bool
> >  
> >  drivers/staging/iio/adc/ad7780.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index 91e016d534ed..9ec2b002539e 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -35,6 +35,7 @@ struct ad7780_chip_info {
> >  	struct iio_chan_spec	channel;
> >  	unsigned int		pattern_mask;
> >  	unsigned int		pattern;
> > +	bool			is_ad778x;
> >  };
> >  
> >  struct ad7780_state {
> > @@ -113,10 +114,12 @@ static int ad7780_postprocess_sample(struct
> > ad_sigma_delta *sigma_delta,
> >  	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
> >  		return -EIO;
> >  
> > -	if (raw_sample & AD7780_GAIN)
> > -		st->gain = 1;
> > -	else
> > -		st->gain = 128;
> > +	if (chip_info->is_ad778x) {
> > +		if (raw_sample & AD7780_GAIN)
> > +			st->gain = 1;
> > +		else
> > +			st->gain = 128;
> > +	}
> >  
> >  	return 0;
> >  }
> > @@ -135,21 +138,25 @@ static const struct ad7780_chip_info
> > ad7780_chip_info_tbl[] = {
> >  		.channel = AD7780_CHANNEL(12, 24),
> >  		.pattern = 0x5,
> >  		.pattern_mask = 0x7,
> > +		.is_ad778x = false,
> >  	},
> >  	[ID_AD7171] = {
> >  		.channel = AD7780_CHANNEL(16, 24),
> >  		.pattern = 0x5,
> >  		.pattern_mask = 0x7,
> > +		.is_ad778x = false,
> >  	},
> >  	[ID_AD7780] = {
> >  		.channel = AD7780_CHANNEL(24, 32),
> >  		.pattern = 0x1,
> >  		.pattern_mask = 0x3,
> > +		.is_ad778x = true,
> >  	},
> >  	[ID_AD7781] = {
> >  		.channel = AD7780_CHANNEL(20, 32),
> >  		.pattern = 0x1,
> >  		.pattern_mask = 0x3,
> > +		.is_ad778x = true,
> >  	},
> >  };
> >    

