Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B245C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0649D21839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544962424;
	bh=XhWhnNHTn2Vpvxc8LckiNf7lGuU9SIZbT0GJOu6jBmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1vA8jDB6Uhx9zA7/GPeclx0RGFUaW/ImS2ovE6KWCmvLb9tB3Pn8/u7tcYijv53ag
	 fzJVz+2hou0ksIavvF/LmM50ZBqPTMyfWNUOyOJHOifA2zOYG0mZ9ilRzomHwpaIW6
	 cTX8/rrQDqbCied8cGyhHaF/smQMeXRsLvmp9vDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbeLPMNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 07:13:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbeLPMNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 07:13:42 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D456E2086C;
        Sun, 16 Dec 2018 12:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544962421;
        bh=XhWhnNHTn2Vpvxc8LckiNf7lGuU9SIZbT0GJOu6jBmw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a05GuDIsZoTiGqCgzuvqg6jTKOP6jMB3G/xzMolreknziQNt5vwLZaM0nVXmS4LMU
         vNAB3w1SZJnvRtnLBpRjehaLPCOm9VSW+qFelgTTQKs5lys6/MkcqpI8ZywayPOxeO
         +qBS8upu//yq+YTp6ZkUn5mHQ62MNnafis0TC1xE=
Date:   Sun, 16 Dec 2018 12:13:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 1/3] staging: iio: ad5933: change regulator binging for
 vref
Message-ID: <20181216121336.3f31b532@archlinux>
In-Reply-To: <06caedbbe394a76feedbc77edb0df2c6109217bd.1544292845.git.marcelo.schmitt1@gmail.com>
References: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
        <06caedbbe394a76feedbc77edb0df2c6109217bd.1544292845.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2018 16:19:08 -0200
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Set a single voltage regulator for all voltage references.
> Remove voltage reference value from default platafrom data struct.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> Co-Developed-by: Gabriel Capella <gabriel@capella.pro>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 9e52384f5370..730bc397a26b 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -91,7 +91,6 @@
>  
>  struct ad5933_platform_data {
>  	unsigned long			ext_clk_hz;
> -	unsigned short			vref_mv;
>  };
>  
>  struct ad5933_state {
> @@ -113,7 +112,6 @@ struct ad5933_state {
>  };
>  
>  static struct ad5933_platform_data ad5933_default_pdata  = {
> -	.vref_mv = 3300,
>  };
>  
>  #define AD5933_CHANNEL(_type, _extend_name, _info_mask_separate, _address, \
> @@ -691,7 +689,7 @@ static void ad5933_work(struct work_struct *work)
>  static int ad5933_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> -	int ret, voltage_uv = 0;
> +	int ret;
>  	struct ad5933_platform_data *pdata = dev_get_platdata(&client->dev);
>  	struct ad5933_state *st;
>  	struct iio_dev *indio_dev;
> @@ -718,12 +716,12 @@ static int ad5933_probe(struct i2c_client *client,
>  		dev_err(&client->dev, "Failed to enable specified VDD supply\n");
>  		return ret;
>  	}
> -	voltage_uv = regulator_get_voltage(st->reg);
> +	ret = regulator_get_voltage(st->reg);
> +
> +	if (ret < 0)
> +		goto error_disable_reg;
>  
> -	if (voltage_uv)
> -		st->vref_mv = voltage_uv / 1000;
> -	else
> -		st->vref_mv = pdata->vref_mv;
> +	st->vref_mv = ret / 1000;
>  
>  	if (pdata->ext_clk_hz) {
>  		st->mclk_hz = pdata->ext_clk_hz;

