Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4962BC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A90215EA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGDvnBdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A90215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932820AbeGGREl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 13:04:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932546AbeGGREk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 13:04:40 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A896621527;
        Sat,  7 Jul 2018 17:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530983080;
        bh=QoyLXulrgtOR3EWZQIpEBi3zJU9phMvFGaqqHWmVxYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oGDvnBdD3TrLJ6xx5PVTjprorBF8bBV5r59cLfhbvqCNDq+IZtZNuwRMtv3O2lmeW
         ZpPScZEhkxJlCg6ojn2fAVb62vpnsw8EAEGCJqraftsw5MUTEfMt2O5StCtdb1Xr2X
         ry/obxpE73tIb22EsdFDbNfqZefG3rkGIYgqbWdE=
Date:   Sat, 7 Jul 2018 18:04:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mma8452: Mark expected switch fall-through
Message-ID: <20180707180435.414b7a95@archlinux>
In-Reply-To: <20180703194436.GA15537@embeddedor.com>
References: <20180703194436.GA15537@embeddedor.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 14:44:36 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Warning level 2 was used in this case: -Wimplicit-fallthrough=2
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to ignore.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mma8452.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index c149c9c..421a0a8 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1547,6 +1547,7 @@ static int mma8452_probe(struct i2c_client *client,
>  	case FXLS8471_DEVICE_ID:
>  		if (ret == data->chip_info->chip_id)
>  			break;
> +		/* else: fall through */
>  	default:
>  		return -ENODEV;
>  	}

