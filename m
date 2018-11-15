Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116F5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1BB2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzO8P3Q9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1BB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbeKPAdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:33:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37369 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeKPAdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:33:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so3152653plr.4;
        Thu, 15 Nov 2018 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kVkvg+WWJdv50V/O5BGKMdMF3dRxWqt3FBxZEn1c6zg=;
        b=RzO8P3Q9ygOX8b+KTOY+m8BO0Hvc+kPvqW/jwL+HamcQ/lJ2oBrBXnjkZuXOVHdHzF
         9bOmS+ACCXOa5dONfju7sNCvVhOO8Bmycvj2QxIHunq8qZr9C30iYWUwd4aBQpG6vNOf
         VfAofsPHDkNC8B3hvKGLAKDXsMtdjVuIFnJrDto65L/5GIr33uZv3RtUKe/cGZ3moRVb
         ZOkbEIg+J8pkVGavd2y/OU5jEQVpwHVqA7QYktSBMvwk/y9mDpWOFkcu7G2m9x/JKERq
         1zlSHxjGaDp7ylySeD3joVYPPrSYH9RpP2y46+FPD9GYYjywOfO7TiE8NzW2/YJey/cW
         TqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kVkvg+WWJdv50V/O5BGKMdMF3dRxWqt3FBxZEn1c6zg=;
        b=YS/1/+84MxpXPAIRh6ABEfyyPEJM2Fdlqqn6drljsZnTF5D/HPndgKeJg4egES/4z3
         tiObG/3bboArWqCxU8qphnS3tE6CtzhmvoaRGxN57xX/xs4hmandwQkwjD8hrdD0ivEA
         RTjn7yc5X8J44bGbUJGHssA4V+JnyvtQpxYMAw8Siuhwe6luDkbzGGTDUviFKMZmQ+5l
         q49FZg3osp4NBWjRL/FG7yE6br9rkLZ1qg0DHYZ2YBAfwSCdW9TCV0Ttg1TdWZp7JFiq
         RsfRTbuKZmJatW6mpoPGNbl1AVRyLO1qZrEI4AR64LnnaPtO5erN2lXapRr87QIeIuiS
         BkNw==
X-Gm-Message-State: AGRZ1gIF+tSn0mGpuX+bKRAOlIXGn9SjMgrB5EiJKsfvwoWKrCJzp5gb
        rJWsCN9Xzgka22Coel39NPE=
X-Google-Smtp-Source: AJdET5dJQFf+kIFL/UvjTzOfNDcJp+1R4Tgniz/tNSmOBOEK0XHP2C22Wg3aot0Bgr1i8HRrQVQTfQ==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33-v6mr6597491plh.268.1542291914587;
        Thu, 15 Nov 2018 06:25:14 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id d11sm13192472pgi.25.2018.11.15.06.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 06:25:13 -0800 (PST)
Date:   Thu, 15 Nov 2018 19:55:06 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 4/4] staging: iio: ad7816: Add device tree table.
Message-ID: <20181115142504.GA4098@nishad>
References: <cover.1542215638.git.nishadkamdar@gmail.com>
 <d2df511b4a84b92925a39b5051932eef4426f18d.1542215638.git.nishadkamdar@gmail.com>
 <4abed67ee07c763151a76cf9e687b6edc6ced5c6.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4abed67ee07c763151a76cf9e687b6edc6ced5c6.camel@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 08:16:03AM +0000, Ardelean, Alexandru wrote:
> On Wed, 2018-11-14 at 23:16 +0530, Nishad Kamdar wrote:
> > Add device tree table for matching vendor ID.
> > 
> 
> This could have been just one patch.
> Something like 
>    [PATCH v4] staging: iio: ad7816: Add device tree table.
> 
> It's no longer a series, because the other patches were applied already.
> 
> I don't think you need to re-spin this [it's up to Jonathan though].
> 
> It's just something to keep in mind for later when re-spinning patches or
> series of patches.
> 
> Alex
>

Ok. I'll keep that in mind.

Thanks for the review.

Regards,
Nishad

> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7816.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7816.c
> > b/drivers/staging/iio/adc/ad7816.c
> > index a2fead85cd46..925f7086bc07 100644
> > --- a/drivers/staging/iio/adc/ad7816.c
> > +++ b/drivers/staging/iio/adc/ad7816.c
> > @@ -422,6 +422,14 @@ static int ad7816_probe(struct spi_device *spi_dev)
> >  	return 0;
> >  }
> >  
> > +static const struct of_device_id ad7816_of_match[] = {
> > +	{ .compatible = "adi,ad7816", },
> > +	{ .compatible = "adi,ad7817", },
> > +	{ .compatible = "adi,ad7818", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad7816_of_match);
> > +
> >  static const struct spi_device_id ad7816_id[] = {
> >  	{ "ad7816", ID_AD7816 },
> >  	{ "ad7817", ID_AD7817 },
> > @@ -434,6 +442,7 @@ MODULE_DEVICE_TABLE(spi, ad7816_id);
> >  static struct spi_driver ad7816_driver = {
> >  	.driver = {
> >  		.name = "ad7816",
> > +		.of_match_table = of_match_ptr(ad7816_of_match),
> >  	},
> >  	.probe = ad7816_probe,
> >  	.id_table = ad7816_id,
