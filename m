Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF77ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D2120869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/5cU9md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D2120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJUW4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 18:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbeJUW4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 18:56:12 -0400
Received: from archlinux (unknown [176.12.107.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 459F920843;
        Sun, 21 Oct 2018 14:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540132899;
        bh=3eDa5B++H1fW88d7NG8ptydCNoC4j6UBp3amn2wM1Hk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W/5cU9md5eyh4PFYH9vdlShYb+1cQm+Bh4/IYsKtJgeI98XSh9PLiz9OkIX3UIhyM
         utt96HK6WnTl7hH+V5/+eHs79LFRSgscm0lyZr1k/tAaJ/GNIlqoOtDIMrKVMIVkNw
         yU3+gxAcHsBZcHwoZY64liISIr04mXpQ5P22E7IA=
Date:   Sun, 21 Oct 2018 15:41:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2] Staging iio: adc: Match parenthesis alignment
Message-ID: <20181021154133.44cf95ab@archlinux>
In-Reply-To: <20181018013147.15352-1-marcelo.schmitt1@gmail.com>
References: <20181018013147.15352-1-marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 22:31:47 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Change close parenthesis alignment to match respective open parenthesis at
> iio/drivers/staging/iio/adc/ad7606.c line 379.
> This makes the file more compliant with the preferred coding style for the
> linux kernel.
Hi Marcelo,

Nice cleanup and applied to the togreg branch of iio.git and pushed
out as testing for the autobuilders to play with it.
(basically this lets 0-day run a whole bunch of build tests on
it before I push it out in a form that others can rely on not changing)

Patch naming is one of those things that is very inconsistent
in different areas of the kernel.   I take the view that if I'm going
to be fussy I'll fix it up myself when applying if that is the only
thing I'm otherwise going to comment on.

However, definite preference for the name of the driver being in there
somewhere!  When I saw this description I thought we were looking
at a cleanup of the whole directory rather than the single driver
you have here.

Thanks,

Jonathan


> 
> Signed-of-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7606.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index 0b728b6ea135..230faae38c12 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -376,7 +376,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
>  		return 0;
>  
>  	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
> -			GPIOD_OUT_LOW);
> +						    GPIOD_OUT_LOW);
>  	return PTR_ERR_OR_ZERO(st->gpio_os);
>  }
>  

