Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422C6C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C7021479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549101653;
	bh=4Xv75aPPdIsDZA8K4EHTacleU6uyrEHJTd0XYAMasU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nqi9lvNwJccQbyH3QYuuj5/fqOVL5Z/brlarSuxU4QuzYdtkFpAc8AdRHXngU7JKr
	 MSYaoBqnD+Il4JHUsdJ4EmxFeB4a2+ENdOcq+BLBE129KdeVOQZLDykuYanV9/zQbx
	 yJ9Y1tvWBPjRJyhhMBGHe38pVwOvUCRJMJRf2dLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfBBKAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:00:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfBBKAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:00:51 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F7692084C;
        Sat,  2 Feb 2019 10:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549101650;
        bh=4Xv75aPPdIsDZA8K4EHTacleU6uyrEHJTd0XYAMasU0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KMLa09a34FEne62cxGLRH24bpAhmCGvSoOQKRUl3SxKNUMyISh38GvD5pZSirnz5J
         g43DQsxfWlKuFeIiK3zdKQlzrtNrXFZtoZw4qxxvoY8TIlbIiNUvj351ueDyC2uRE+
         G/0DtdkwmJG+cj83yCo5sZPYIzT2EJN2dHRqC9l0=
Date:   Sat, 2 Feb 2019 10:00:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     LSO <lucasseikioshiro@gmail.com>
Cc:     Joe Perches <joe@perches.com>, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
Subject: Re: [PATCH] iio:potentiostat:lmp91000: solve codestyle WARNINGs and
 CHECKs
Message-ID: <20190202100044.678a9a9c@archlinux>
In-Reply-To: <d2c70e04-f20c-6847-9740-d883c327c55f@gmail.com>
References: <20190129183656.15656-1-lucasseikioshiro@gmail.com>
        <a8ae5209f676171a97cae7211411e7ced3ebefbc.camel@perches.com>
        <d2c70e04-f20c-6847-9740-d883c327c55f@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 12:29:11 -0200
LSO <lucasseikioshiro@gmail.com> wrote:

> Thanks for the review!
> 
> On 29/01/2019 20:48, Joe Perches wrote:
> > On Tue, 2019-01-29 at 16:36 -0200, Lucas Oshiro wrote:  
> >> Solve most of the checkpatch.pl WARNINGs and CHECKs on lmp9100.c. They
> >> are the following:
> >>
> >> lmp91000.c:116: CHECK: Unnecessary parentheses around 'state != channel'
> >> lmp91000.c:116: CHECK: Unnecessary parentheses around 'channel == LMP91000_REG_MODECN_TEMP'
> >> lmp91000.c:214: CHECK: braces {} should be used on all arms of this statement
> >> lmp91000.c:216: CHECK: Unbalanced braces around else statement
> >> lmp91000.c:258: WARNING: line over 80 characters
> >> lmp91000.c:279: CHECK: Please don't use multiple blank lines  
> > 
> > Some will say this is too many things to do at once.
> > I think it's mostly fine, but there are a few nits
> > that also could use fixing.

Always a case of personal judgement.
I agree that this one 'just' falls on the side of not too many things for one
patch.  If there had been a few more items then it would have been too much.

I would also have been happy with it broken out.  If I had been spinning
it myself, I would have done it as 3 patches in pairs from your list
above with the last one grouping the white space changes.

The test inversion below is also stretching beyond simple style
so probably should be broken out.

> >   
> >> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c  
> > []  
> >> @@ -211,9 +211,9 @@ static int lmp91000_read_config(struct lmp91000_data *data)
> >>   
> >>   	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
> >>   	if (ret) {
> >> -		if (of_property_read_bool(np, "ti,external-tia-resistor"))
> >> +		if (of_property_read_bool(np, "ti,external-tia-resistor")) {
> >>   			val = 0;
> >> -		else {
> >> +		} else {
> >>   			dev_err(dev, "no ti,tia-gain-ohm defined");
> >>   			return ret;
> >>   		}  
> > 
> > This could use inverting the test
> > 
> > 	if (ret) {
> > 		if (!of_property_read_bool(...)) {
> > 			dev_err(dev, "no ti,ti-gain-ohm defined\n");
> > 			return ret;
> > 		}
> > 		val = 0;
> > 	}
> >  
> Thanks for the suggestion, I'll do that in the next version.
> 
> > Also the dev_err is missing a '\n' termination  
> 
> My aim in this patch was only solve style problems, but I
> can put that missing '\n' too. Do you think it could be done
> in the same commit or it's a better idea do it in another
> commit and send both as a patchset?

Separate commit given as you say it's not style and this one has
enough different things in it already!

Thanks,

Jonathan

> > 
> >   

