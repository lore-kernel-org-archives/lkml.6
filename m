Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8637C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5933C20870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFJs3Qg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5933C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeJ2AnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 20:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbeJ2AnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 20:43:12 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9853E20843;
        Sun, 28 Oct 2018 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540742293;
        bh=GlizhlXbHyOTA60akptwg8UZ73cAKy5W2U3EdHuoUOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OFJs3Qg31ZlY1yH0DADAXXukCF8EZhLiL3sBFGdQ4uFrAfnD/XXiKPdaLynkvMJ+C
         H8ijAo7nl2iEWCA7/gOP5YK2JsRGAds04TJhdfEfZzaW1RcMhlHP28aZrfX2ICazTX
         XlFwP5FrKmwhfwf76qUtRscKRwnooOYfzbq8zgMc=
Date:   Sun, 28 Oct 2018 15:58:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        alexandru.Ardelean@analog.com, stefan.popa@analog.com,
        giuliano.belinassi@usp.br, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/2] staging: iio: ad7780: fix offset read value
Message-ID: <20181028155807.4de0f874@archlinux>
In-Reply-To: <ff71d89625c048601d3e3770ca3b4bcceb2068ac.1540506298.git.renatogeh@gmail.com>
References: <cover.1540506298.git.renatogeh@gmail.com>
        <ff71d89625c048601d3e3770ca3b4bcceb2068ac.1540506298.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 19:30:37 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> Variable val subtracted an uninitialized value on IIO_CHAN_INFO_OFFSET.
> This was fixed by assigning the correct value instead.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>

It obviously doesn't make much difference, but as you are respinning anyway...
Please could you always put fixes at the beginning of a set as it makes it
easier to back port them.  It think this one is simple enough that it is
worth applying to the stable kernels.

(naturally I could do that anyway as the rebase is trivial, so I'm just
encouraging good practice by asking you to do it in v3!)

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7780.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index 27972563bb6a..06700fe554a2 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -100,7 +100,7 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
>  		*val2 = chan->scan_type.realbits - 1;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val -= (1 << (chan->scan_type.realbits - 1));
> +		*val = -(1 << (chan->scan_type.realbits - 1));
>  		return IIO_VAL_INT;
>  	}
>  

