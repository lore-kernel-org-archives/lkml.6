Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76305C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2A7208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfMlm384"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2A7208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbeKOC6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:58:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44395 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbeKOC6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:58:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id b81-v6so7700721pfe.11;
        Wed, 14 Nov 2018 08:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cktP2JyDWtD24IeJWjBeXS5qQ8POIqfhV8gUzVyoxYo=;
        b=ZfMlm384368bWrAXMR4hfaTbPOtaxaSkmFgAaBbhrkWINXab1cawrhVEjTRqh07e0m
         dIH/tIoJWmQdnpQqG7qb+gjvw36zACOsmwXS2S5xs8ZuTV6LGbdHM5ccPPcBXR07cGMl
         DtbH4TthLUE0lz2T0yZJ+49tsGhYfk6EhWgEJqnhH8gY1vadeWixtpoj6aHS1GcUtkg2
         Ae9NFLS6C/I1m0oHiEp9QduSByBDv/tmg0Y/eDCZhlEn4iaoEpO4IywaJovXWdzdUKsU
         2bQ3bkkZoXAolYlxe6pPZEcLSI6GkkZH/FIRy+Zv8frmLiBipH6JSWVrpGjdPioKzyh6
         WvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cktP2JyDWtD24IeJWjBeXS5qQ8POIqfhV8gUzVyoxYo=;
        b=t0TkQxZ7F6KFFwdkUS/D9HHIF2NCJqykJL46srmIw/75NQW0ItO2he6RwKwcYWbuXF
         Am9N9b7e3Zd2XUTQumqAXcT3NnXyznA0lLuBJe+LTzXE96FQICK+mbXK76LnhRYl9N6W
         vPzmgcSQXU406AXjBL6lmLypjTvGKfZYQkTAh9jHCA7dqUM+JJKcHx8XhcM9F7ZSrhQ+
         FoNnGN8obfc5eORetascvgnbq8e5Y1EK+8yqCyOzKDCd5k/llFwOrSPfWaxEeWXzDB6P
         QKbrUh6IqciD236MPbk6mAhZ3zsImKE4jReh0aYIimo7yqPqb/0L5xgep79vENS8P+8I
         wV1g==
X-Gm-Message-State: AGRZ1gIQusDBMytM/YFXbQsbnl5agYc34f38WWuVE6CHyFuskVHfQ45y
        xcksDUUqdpVPa50FlhmW5MM=
X-Google-Smtp-Source: AJdET5clZPLtQZUjlf6JJxtq+M6gT2akJ1PqxRZWfpWArA4e4d6lnbkX7kVcNZj8hzu7++4fjofCEA==
X-Received: by 2002:a62:a99:: with SMTP id 25mr2661487pfk.121.1542214495485;
        Wed, 14 Nov 2018 08:54:55 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id c7-v6sm29915527pfh.25.2018.11.14.08.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 08:54:54 -0800 (PST)
Date:   Wed, 14 Nov 2018 22:24:47 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] staging: iio: ad7816: Add device tree table.
Message-ID: <20181114163323.GB16316@nishad>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
 <209172d47d8d14c1244556e5f05bbd6455b4de04.1541733949.git.nishadkamdar@gmail.com>
 <c2dd05ea2893315e848bcf48af5e51b415d7a22c.camel@analog.com>
 <20181111123802.212a8b79@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111123802.212a8b79@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 12:38:02PM +0000, Jonathan Cameron wrote:
> On Fri, 9 Nov 2018 08:11:57 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> 
> > On Fri, 2018-11-09 at 13:08 +0530, Nishad Kamdar wrote:
> > > Add device tree table for matching vendor ID.  
> > 
> > One comment inline for this.
> > 
> > Thanks
> > Alex
> > 
> > > 
> > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > ---
> > >  drivers/staging/iio/adc/ad7816.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/staging/iio/adc/ad7816.c
> > > b/drivers/staging/iio/adc/ad7816.c
> > > index a2fead85cd46..b8a9149fbac1 100644
> > > --- a/drivers/staging/iio/adc/ad7816.c
> > > +++ b/drivers/staging/iio/adc/ad7816.c
> > > @@ -422,6 +422,12 @@ static int ad7816_probe(struct spi_device *spi_dev)
> > >  	return 0;
> > >  }
> > >  
> > > +static const struct of_device_id ad7816_of_match[] = {
> > > +	{ .compatible = "adi,ad7816", },  
> > 
> > I think you also need to add:
> > +	{ .compatible = "adi,ad7817", },
> > +	{ .compatible = "adi,ad7818", },
> > 
> 
> Yes, please add all parts to the dt binding.
> Particularly as they are functionally different in this case!
> 
> Please send a v4 for just this patch as the rest have now been
> applied.
> 
> Thanks,
> 
> 
> Jonathan
> 
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, ad7816_of_match);
> > > +
> > >  static const struct spi_device_id ad7816_id[] = {
> > >  	{ "ad7816", ID_AD7816 },
> > >  	{ "ad7817", ID_AD7817 },
> > > @@ -434,6 +440,7 @@ MODULE_DEVICE_TABLE(spi, ad7816_id);
> > >  static struct spi_driver ad7816_driver = {
> > >  	.driver = {
> > >  		.name = "ad7816",
> > > +		.of_match_table = of_match_ptr(ad7816_of_match),
> > >  	},
> > >  	.probe = ad7816_probe,
> > >  	.id_table = ad7816_id,  
>

Ok. I'll do that.

Thanks for the reivew.

regards,
Nishad
