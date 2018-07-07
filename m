Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BE7C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176152175C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7vm0t12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176152175C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754399AbeGGQrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 12:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754364AbeGGQrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 12:47:46 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0316D21076;
        Sat,  7 Jul 2018 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530982065;
        bh=ko5vAFmSHu4haAqxU6N9B94xdX1YtPxnC3v89NX6WcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K7vm0t12A7IC4tZHpimfYPR8t/LbiGYsrtdp+/xZBl+zsIaC9705gEjnBLeiengYo
         CcnCBd9FnFVDLWJinmAjLoAGYgP7cWZPG70QC0CbK8lpa/Wzmj49iZBOLlDomlzVk5
         zsu8KdNJ64Va2kiC0soB9Jhylb4YJ3/7j0ButQA8=
Date:   Sat, 7 Jul 2018 17:47:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Silvan Murer <silvan.murer@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: remove redundant pointer chip_info and
 spi_dev_id
Message-ID: <20180707174740.47c25742@archlinux>
In-Reply-To: <20180702101359.16461-1-colin.king@canonical.com>
References: <20180702101359.16461-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Jul 2018 11:13:59 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointers chip_info and spi_dev_id are being assigned but are never used
> hence they are redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'chip_info' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Huh, I wonder how we ended up with that being left behind? 
Not that I wonder enough to actually look ;)

Thanks and good to get rid of these 'interesting'
corners :)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ltc2632.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index cca278eaa138..28e9b7656b20 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -87,12 +87,7 @@ static int ltc2632_read_raw(struct iio_dev *indio_dev,
>  			    int *val2,
>  			    long m)
>  {
> -	struct ltc2632_chip_info *chip_info;
> -
>  	const struct ltc2632_state *st = iio_priv(indio_dev);
> -	const struct spi_device_id *spi_dev_id = spi_get_device_id(st->spi_dev);
> -
> -	chip_info = (struct ltc2632_chip_info *)spi_dev_id->driver_data;
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_SCALE:

