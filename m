Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FC2C46471
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C889321567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAls3vmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C889321567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390349AbeIUV0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:26:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47039 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeIUV0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:26:30 -0400
Received: by mail-lf1-f66.google.com with SMTP id q2-v6so1871112lfc.13;
        Fri, 21 Sep 2018 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5es2OfYK9GWNOZTqqkdwxLPD3d6blJgkHW5OzG5WQ6Y=;
        b=oAls3vmZY5rM/eKJx1Lboe91tKKYIxb/Z5VU5xyvkMPLdHOV28fRF273Bt/uFRiJ0T
         xqDTsy8YDVrkUveEqSVKMBEqjoSeIELugJyYyh/8flJ3syzGJFp9BC5gBYh1NZ5Ahlmf
         SG5QnAi0fXqoiEKIWI5vO1o4RW5XtviTQowpm/Xhl6SEm5Y6ZuoKVfO+LVVsH08KQLTr
         WMHvC58f44J22cVBnV7fPBaaKSyubWpvAX66jNOFZUYtW0R7t0++IkgIuktXehEbeV0C
         F6k9cLrgRd0gfl5LxJxLR9jiClFOj970Pb/XGB6yA/Z5NBpjvWiA4jgxKD5nLGsUVl2H
         tGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5es2OfYK9GWNOZTqqkdwxLPD3d6blJgkHW5OzG5WQ6Y=;
        b=NomSaxb+yHsjwamEBlOGHTuq4P5HYlK7m4/PFjtWyzBFDTrJp9KDLrG02WakDwFi/T
         +C/0VAn6qXCU4wm+w8TfL0L3ZhmF7aI60i0elHW6wPl/0guaniGdfQmVIdAMZh3DMafN
         ZfKP5qPwFnnqZMKkyzFYZxOaYp/4d9dn/1eJkDyh77MRRnwuA4mynLhAVXpKBJDxYsJe
         vY3+PvmQ7ZHMRr2BK6cR4Qgn6GolRBZ4jjEOkyp8aHjkirOGXU1I8b4p9j/9i83ga8/S
         aBX0pzm+iFFLISFAmKeSZ8cyXze2vETDu4rG/WiVFRQzAff8YkkdlKzPKL0g5bXPBaG7
         NCdw==
X-Gm-Message-State: APzg51D5LM4Di/3uv9LjrHdGijlJuiuSrulXMW9s0V5JLtn5Qa8a/QAv
        nrBRZ5PFO8wZKS1UmjxPpUo=
X-Google-Smtp-Source: ANB0Vdbplz/b7+keUfMn5+J2Sc8eZn5HzoPCX8gBQQTNiOsWkoGtDyyDizhY/X12HVLzuFHdNNYqmw==
X-Received: by 2002:a19:14d4:: with SMTP id 81-v6mr20957458lfu.26.1537544223540;
        Fri, 21 Sep 2018 08:37:03 -0700 (PDT)
Received: from localhost (89-70-220-78.dynamic.chello.pl. [89.70.220.78])
        by smtp.gmail.com with ESMTPSA id t13-v6sm308196lfd.29.2018.09.21.08.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 08:37:02 -0700 (PDT)
Date:   Fri, 21 Sep 2018 17:34:21 +0200
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     r yang <decatf@gmail.com>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: bh1750: Add device tree support
Message-ID: <20180921153420.GA11850@arch>
References: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
 <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
 <20180919192238.GA19391@arch>
 <20180921013721.GA4268@r>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921013721.GA4268@r>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 09:37:21PM -0400, r yang wrote:
> On Wed, Sep 19, 2018 at 09:22:39PM +0200, Tomasz Duszynski wrote:
> > Comments inline.
> >
> > On Sat, Sep 15, 2018 at 01:42:14PM -0400, ryang wrote:
> > > Add device tree support for ROHM BH1750 series ambient light sensors.
> > >
> > > Signed-off-by: ryang <decatf@gmail.com>
> > > ---
> > >  drivers/iio/light/bh1750.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> > > index a814828e69f5..50b599abb383 100644
> > > --- a/drivers/iio/light/bh1750.c
> > > +++ b/drivers/iio/light/bh1750.c
> > > @@ -315,9 +315,19 @@ static const struct i2c_device_id bh1750_id[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, bh1750_id);
> > >
> > > +static const struct of_device_id bh1750_of_match[] = {
> > > +	{ .compatible = "rohm,bh1710", },
> > > +	{ .compatible = "rohm,bh1715", },
> > > +	{ .compatible = "rohm,bh1721", },
> > > +	{ .compatible = "rohm,bh1750", },
> > > +	{ .compatible = "rohm,bh1751", },
> > > +	{ }
> > > +};
> > > +
> >
> > Hmm, I believe this should be exported additionally using
> > MODULE_DEVICE_TABLE(of, bh1750_of_match). Otherwise module loading
> > will not work as expected.
> >
> > Moreover, we can do without DT and if you want to avoid
> > warning about unused variables you may consider enclosing everything
> > with:
> >
> > #ifdef CONFIG_OF
> > ...
> > #endif
>
> The reason for this DT patch is because I've ported the Samsung Galaxy
> Tab 10.1 to the mainline kernel. The device is working on the Tegra
> platform with the right DTS file. Some peripherals on this device have
> existing drivers such as this one which only need the DT bindings for
> it be usuable.
>

Adding support for DT is fine. Just pointed a figner at two things
that attracted my attention.

> >
> > >  static struct i2c_driver bh1750_driver = {
> > >  	.driver = {
> > >  		.name = "bh1750",
> > > +		.of_match_table = of_match_ptr(bh1750_of_match),
> > >  		.pm = BH1750_PM_OPS,
> >
> > I've recently simplified setting pm ops so this would not apply to
> > iio/togreg cleanly.
> >
>
> Does this mean I should wait until that is merged before submitting a V2
> patch?
>

No need to wait. I guess you should rebase your work on iio/togreg
branch and post v2.

> > >  	},
> > >  	.probe = bh1750_probe,
> > > --
> > > 2.17.1
> > >
