Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3552EC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0179F2183E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544961402;
	bh=wRo6MfWNWIVIeuJnIM/mBHk1CwnjH0efsZsYNtZTRqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IcOmJ5dUL8KtGhGBC3YhkYt54GL5Ypb54DXhLldoXn/4CtSfATCQPPQJ02oO7f0v5
	 Y+CM27l7w3BTADfUDwdsSsmCx1/Eyq54QJGChCFPlHhWTbfUOxfEDp0NiqPtMdh1tU
	 OzDQkwI83PbXodYulOR1RtVah8xeruZJL2MmDgCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbeLPL4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 06:56:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730066AbeLPL4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 06:56:40 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91BB8217FB;
        Sun, 16 Dec 2018 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544961399;
        bh=wRo6MfWNWIVIeuJnIM/mBHk1CwnjH0efsZsYNtZTRqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=POcIgo1j9lku81lTxXwSREAzAc/Kdo/Q9vYfAsov48lPVACBKwFZltfFqtHtjfj0Y
         Ac6UhaW/sneYa2kqgCjc0Nmg0aAE6xJZm6c7zTJPUOP6oZje10DPpxtZUZRPtLdQwl
         UKIUd9JsTv+TA8L9YGll7YdI9Uc2mAxpo/z7Z2dk=
Date:   Sun, 16 Dec 2018 11:56:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] staging: iio: adt7316: remove dac vref buffer
 bypass from adt751x
Message-ID: <20181216115634.2e75aa75@archlinux>
In-Reply-To: <20181212005503.28054-10-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
        <20181212005503.28054-10-jeremyfertic@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 17:55:01 -0700
Jeremy Fertic <jeremyfertic@gmail.com> wrote:

> The option to allow the external vref to bypass the reference buffer is
> only available for adt7316/7/8. Remove the attributes for adt751x as
> well as the chip->id checks from the show and store functions.
> 
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
Another good little cleanup, well separated from the other bits so
applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 3348fdf08f2e..bca599d8c51c 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -964,9 +964,6 @@ static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
> -		return -EPERM;
> -
>  	return sprintf(buf, "%d\n",
>  		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_AB));
>  }
> @@ -981,9 +978,6 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
>  	u8 dac_config;
>  	int ret;
>  
> -	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
> -		return -EPERM;
> -
>  	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_AB);
>  	if (buf[0] == '1')
>  		dac_config |= ADT7316_VREF_BYPASS_DAC_AB;
> @@ -1009,9 +1003,6 @@ static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
> -		return -EPERM;
> -
>  	return sprintf(buf, "%d\n",
>  		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_CD));
>  }
> @@ -1026,9 +1017,6 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
>  	u8 dac_config;
>  	int ret;
>  
> -	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
> -		return -EPERM;
> -
>  	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_CD);
>  	if (buf[0] == '1')
>  		dac_config |= ADT7316_VREF_BYPASS_DAC_CD;
> @@ -1713,8 +1701,6 @@ static struct attribute *adt7516_attributes[] = {
>  	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
>  	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
>  	&iio_dev_attr_update_DAC.dev_attr.attr,
> -	&iio_dev_attr_DA_AB_Vref_bypass.dev_attr.attr,
> -	&iio_dev_attr_DA_CD_Vref_bypass.dev_attr.attr,
>  	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
>  	&iio_dev_attr_VDD.dev_attr.attr,
>  	&iio_dev_attr_in_temp.dev_attr.attr,

