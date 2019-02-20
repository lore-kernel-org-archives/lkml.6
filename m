Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC700C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D2220859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfBTWW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:22:57 -0500
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:37355 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbfBTWW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:22:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1F41618224D6E;
        Wed, 20 Feb 2019 22:22:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: girls60_365b2667a3c4d
X-Filterd-Recvd-Size: 2648
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 Feb 2019 22:22:53 +0000 (UTC)
Message-ID: <68f8ea8165f4a87cd1c99c14f2d1cc3ecdd54ed3.camel@perches.com>
Subject: Re: [PATCH 5/5] iio:potentiostat:lmp91000: add '\n' on dev_err
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lucas Oshiro <lucasseikioshiro@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
Date:   Wed, 20 Feb 2019 14:22:52 -0800
In-Reply-To: <20190220094921.6777d6f8@archlinux>
References: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
         <20190218172236.7781-6-lucasseikioshiro@gmail.com>
         <d5d88a5acc984554240047944cb3071371025085.camel@perches.com>
         <20190220094921.6777d6f8@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-20 at 09:49 +0000, Jonathan Cameron wrote:
> On Mon, 18 Feb 2019 13:01:23 -0800 Joe Perches <joe@perches.com> wrote:
> > On Mon, 2019-02-18 at 14:22 -0300, Lucas Oshiro wrote:
> > > Add missing '\n' at the end of dev_err message on line 215.  
> > []
> > > diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c  
> > []
> > > @@ -212,7 +212,7 @@ static int lmp91000_read_config(struct lmp91000_data *data)
> > >  	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
> > >  	if (ret) {
> > >  		if (!of_property_read_bool(np, "ti,external-tia-resistor")) {
> > > -			dev_err(dev, "no ti,tia-gain-ohm defined");
> > > +			dev_err(dev, "no ti,tia-gain-ohm defined\n");  
> > 
> > Perhaps a copy/paste error as the test is for
> > external-tia-resistor and not tia-gain-ohm
> > 
> It is an odd construct, but I think this is correct.  What it is actually
> saying is that, given that we don't have an external resistor, we care
> that the tia-gain-ohm isn't set (otherwise it wouldn't matter).
> 
> From the docs
>   - ti,external-tia-resistor: if the property ti,tia-gain-ohm is not defined this
>     needs to be set to signal that an external resistor value is being used.
> 
> So, it might be ideal to say that tia-gain-ohm is not defined and we do
> not have an external resistor specified.
> 
> So not wrong, but could be more informative!  So perhaps a follow up patch
> to tidy that up would be good.

Then thanks in advance for doing that.
cheers, Joe

