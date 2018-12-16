Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E8CC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CC921836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544961071;
	bh=c+3NK1u6yCkOjGJrCq0Az5/AOVr8DtjZ0KI+vPXg6J8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PA62QGXUvtZSmbc5vhF9/PJpeGk5H7uqhKNnxcWy7IxlGgXeUbkhB7rbUweaNxIt1
	 A1B1RLUVW+JwGULdvmymDNf4YwGjDThOHDzuskCegtBkdp/DXX5RPZSox6lFTxMYzc
	 TyXiT2Z7suUbCBfFLlGSAvyJRMAL7PviDdALVYnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbeLPLvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 06:51:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730066AbeLPLvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 06:51:10 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8FAD217FB;
        Sun, 16 Dec 2018 11:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544961069;
        bh=c+3NK1u6yCkOjGJrCq0Az5/AOVr8DtjZ0KI+vPXg6J8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vJPxJ0TQRCh0Uy0OQXNfn09XSqyHZMdWcJbbRzCdKEtoYYbF+Pd2vRs8sEk1Ftayh
         PAi3O4SC3psJYkQZ3+ShtHnM0kmn1gw/01aSA6Fy7aYzNafnXmblFgLbeib1V9NY5x
         Qx48oTuB0OJlP+rjNPF1o1/1Zg9d1kjuhL3rFNrE=
Date:   Sun, 16 Dec 2018 11:51:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] staging: iio: adt7316: use correct variable in
 DAC_internal_Vref read
Message-ID: <20181216115104.7df89614@archlinux>
In-Reply-To: <20181212005503.28054-8-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
        <20181212005503.28054-8-jeremyfertic@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 17:54:59 -0700
Jeremy Fertic <jeremyfertic@gmail.com> wrote:

> The dac internal vref settings are part of the ldac config register rather
> than the dac config register. Change the variable being used so the read
> returns the correct result.
> 
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
Is this a follow through from the earlier 'correcting' the register
addresses?  Looks like it to me, so should really have been in that
same patch.

Oh well, it's staging and horribly broken so let's ignore that ;)

It's separated enough from the earlier patches that I will apply it now
though.  Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Again I have added a do not backport note as far too much chance of
it going wrong.

Jonathan


> ---
>  drivers/staging/iio/addac/adt7316.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 77ef3c209b67..98101a7157d2 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -1056,10 +1056,10 @@ static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
>  
>  	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
>  		return sprintf(buf, "0x%x\n",
> -			(chip->dac_config & ADT7516_DAC_IN_VREF_MASK) >>
> +			(chip->ldac_config & ADT7516_DAC_IN_VREF_MASK) >>
>  			ADT7516_DAC_IN_VREF_OFFSET);
>  	return sprintf(buf, "%d\n",
> -		       !!(chip->dac_config & ADT7316_DAC_IN_VREF));
> +		       !!(chip->ldac_config & ADT7316_DAC_IN_VREF));
>  }
>  
>  static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,

