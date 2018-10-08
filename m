Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72DDC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5721421479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B009+mt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5721421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeJIDfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIDfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:35:46 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B9F20C0A;
        Mon,  8 Oct 2018 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539030136;
        bh=iIIW2k6ORDfVPw75cU/NxO6sfe2KosnQeEiFSgn4Fg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B009+mt6RSNZMICuprqS57pRaSdsFc1eJsJK9m7Af4BPU98Abkc+mwXGnrqZ0gldx
         7wjwNH5oL6fPsKrlrR2at9oxobu67v+vGgbZqZpklMuwteKKKCweVevLAkl1mqLYXP
         kOKrKhqOcsLbzYz6kvx+Mb8NDX9YT+NaU8kbBfbc=
Date:   Mon, 8 Oct 2018 21:22:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2] staging: iio: ad2s1210: fix 'assignment operator'
 style checks
Message-ID: <20181008212211.012a817c@archlinux>
In-Reply-To: <20181008032938.18801-1-matheus.bernardino@usp.br>
References: <20181008032938.18801-1-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Oct 2018 00:29:38 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch fixes all "Assignment operator '=' should be on the previous
> line" checks found in ad2s1210.c with checkpatch.pl.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Great, thanks for sorting this out and coming back with a V2 so quickly.

Applied to the togreg branch of iio.git which is initially pushed out as
testing for the autobuilders to play with it.

We are late in the current kernel cycle, so this will probably not go
upstream until the merge window after the one that will open in a few
weeks time.

Thanks,

Jonathan

> ---
> Changes in v2: In v1, tabs were accidentally converted to whitespaces.
> Now, tabs were preserved.
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index ac13b99bd9cb..d4b1c2c010f2 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -301,8 +301,8 @@ static ssize_t ad2s1210_store_control(struct device *dev,
>  			"ad2s1210: write control register fail\n");
>  		goto error_ret;
>  	}
> -	st->resolution
> -		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> +	st->resolution =
> +		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
>  	if (st->pdata->gpioin) {
>  		data = ad2s1210_read_resolution_pin(st);
>  		if (data != st->resolution)
> @@ -363,8 +363,8 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
>  		dev_err(dev, "ad2s1210: setting resolution fail\n");
>  		goto error_ret;
>  	}
> -	st->resolution
> -		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> +	st->resolution =
> +		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
>  	if (st->pdata->gpioin) {
>  		data = ad2s1210_read_resolution_pin(st);
>  		if (data != st->resolution)

