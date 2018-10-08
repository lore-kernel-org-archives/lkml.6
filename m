Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57BBC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68EC21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHowESdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68EC21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJIDnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeJIDnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:43:40 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0CA920C0A;
        Mon,  8 Oct 2018 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539030608;
        bh=vNNVEUAsU1mpYP0bbMHSzkzwO7ZjBsl7QcouGusttEY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FHowESdvogsINoumRvrav6PGzPgk3rF35mvkjGHtn0NGGVAeJrms6RmhV1tkKgvE3
         Lqy3Wc4KIKVQa18BITzM6K0AGFy9k8cgatrVuNhIX2Gzuy2Yg4WuVUh1JAVDZM03bk
         QrctrgP0cqtmQ1vlIIYXtfFGj3gbdJ+wlyTEVoxw=
Date:   Mon, 8 Oct 2018 21:30:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Thierry Escande <thierry.escande@collabora.com>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Mark expected switch
 fall-throughs
Message-ID: <20181008213004.033e2b29@archlinux>
In-Reply-To: <20181008172332.GA29816@embeddedor.com>
References: <20181008172332.GA29816@embeddedor.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 19:23:32 +0200
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1397962 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Hi,

I'll be honest I'm lost on what the intent of this code actually is...

Gwendal - why do we have a loop with this odd switch statement
in it.  Superficially I think we might as well drop the switch
and pull those assignments out of the loop.   However, perhaps
I'm missing something!

Thanks,

Jonathan

> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 063e89e..d609654 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -385,8 +385,10 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>  		switch (i) {
>  		case X:
>  			ec_accel_channels[X].scan_index = Y;
> +			/* fall through */
>  		case Y:
>  			ec_accel_channels[Y].scan_index = X;
> +			/* fall through */
>  		case Z:
>  			ec_accel_channels[Z].scan_index = Z;
>  		}

