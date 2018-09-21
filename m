Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9FBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195E2206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i83SGbJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195E2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbeIUHXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:23:47 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37436 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeIUHXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:23:47 -0400
Received: by mail-it1-f196.google.com with SMTP id h20-v6so285136itf.2;
        Thu, 20 Sep 2018 18:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l5WnN2AI9yz/lsrheTNIrO3YaqSu64/jyt0xdb7dyPE=;
        b=i83SGbJEq0I1L4GZj/oUHAptyy33xWIEB0j/WWAfWOL8CgKDLkNt8TE95NXD3NKECM
         iVf3ck9552E5z9zHgETBVWZCwmHxb0vllZv2fhqyHo37i+c6KsckrNQ5e8jMuec6BOXT
         AqjiW0tZzMpMxxbm/+6EKEx01+dK8ks4PZxcNKsT5ExptUcTuDsDSm3+kLqB2AMarGGv
         IgXJlyxXoZ0yBEkT+liptkxiv4so9lA7tP3lYNVPzsafsu4lr4J5xAy/+yNLY1YBxXBe
         dN86rJwpBYq0GuBuHziUmLYXKUR848T1wmxEdqsRP4oGqAp9ftX+NdN7cAaOnBuWoIv6
         gRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l5WnN2AI9yz/lsrheTNIrO3YaqSu64/jyt0xdb7dyPE=;
        b=mSLYnzi69hUhLXH3qTX2uzBi1u0xdrYRbkJY+rlAC3+EA6lcz1OKKXMpfU3xApjIpM
         73NcsX0qiTBZyEUXMS1jAoZnY2BbDBfTkGCRVd9J1d/SlGbho1nFdJbB6Ow9fM6k5jTZ
         2/0cE5uS6hs2s2GUl6xXjWERkmjw3THquBH4gQEbP8kKPjLg+98Ye64oF5+yoah1YzMV
         IzOxVGw1rx36xsa98/HP40QpfRZ3MsiAkkeUbKRfTaCY4NJrklBykrrWPwQ06kzT0gMo
         NfSIL8O+pOiRcVjCtoF9pAAI5zoxGVQ0x/538kyfIAT2ewmbIxfwx9BphS5CiTIn9jUz
         b8kA==
X-Gm-Message-State: APzg51BeqhtqrKaI7rkbpdvmn26XjkkmAElpgHQqDKDHS6M0dVz3qT/n
        ji4efGEQg9JBQ7XiaCDP9g==
X-Google-Smtp-Source: ANB0VdZG0tewGRXu6siXefkIaIF5NK6rYQFQcYZtByNysnvKNBR9ge5XJSop5RUb9JAJjbKjTEoRUw==
X-Received: by 2002:a24:9d41:: with SMTP id f62-v6mr930959itd.151.1537493844480;
        Thu, 20 Sep 2018 18:37:24 -0700 (PDT)
Received: from r (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id z26-v6sm8647857ioc.41.2018.09.20.18.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 18:37:23 -0700 (PDT)
Date:   Thu, 20 Sep 2018 21:37:21 -0400
From:   r yang <decatf@gmail.com>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: bh1750: Add device tree support
Message-ID: <20180921013721.GA4268@r>
References: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
 <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
 <20180919192238.GA19391@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919192238.GA19391@arch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 09:22:39PM +0200, Tomasz Duszynski wrote:
> Comments inline.
> 
> On Sat, Sep 15, 2018 at 01:42:14PM -0400, ryang wrote:
> > Add device tree support for ROHM BH1750 series ambient light sensors.
> >
> > Signed-off-by: ryang <decatf@gmail.com>
> > ---
> >  drivers/iio/light/bh1750.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> > index a814828e69f5..50b599abb383 100644
> > --- a/drivers/iio/light/bh1750.c
> > +++ b/drivers/iio/light/bh1750.c
> > @@ -315,9 +315,19 @@ static const struct i2c_device_id bh1750_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, bh1750_id);
> >
> > +static const struct of_device_id bh1750_of_match[] = {
> > +	{ .compatible = "rohm,bh1710", },
> > +	{ .compatible = "rohm,bh1715", },
> > +	{ .compatible = "rohm,bh1721", },
> > +	{ .compatible = "rohm,bh1750", },
> > +	{ .compatible = "rohm,bh1751", },
> > +	{ }
> > +};
> > +
> 
> Hmm, I believe this should be exported additionally using
> MODULE_DEVICE_TABLE(of, bh1750_of_match). Otherwise module loading
> will not work as expected.
> 
> Moreover, we can do without DT and if you want to avoid
> warning about unused variables you may consider enclosing everything
> with:
> 
> #ifdef CONFIG_OF
> ...
> #endif

The reason for this DT patch is because I've ported the Samsung Galaxy
Tab 10.1 to the mainline kernel. The device is working on the Tegra
platform with the right DTS file. Some peripherals on this device have
existing drivers such as this one which only need the DT bindings for
it be usuable.

> 
> >  static struct i2c_driver bh1750_driver = {
> >  	.driver = {
> >  		.name = "bh1750",
> > +		.of_match_table = of_match_ptr(bh1750_of_match),
> >  		.pm = BH1750_PM_OPS,
> 
> I've recently simplified setting pm ops so this would not apply to
> iio/togreg cleanly.
> 

Does this mean I should wait until that is merged before submitting a V2
patch?

> >  	},
> >  	.probe = bh1750_probe,
> > --
> > 2.17.1
> >
