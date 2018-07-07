Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BADC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9B92154E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmIX5La7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9B92154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932790AbeGGRBm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 13:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932546AbeGGRBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 13:01:40 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E95021527;
        Sat,  7 Jul 2018 17:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530982900;
        bh=z3CcsOlCf4/BFq2buJ34PWN0o/+l94Oo5E4/2vHKSs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jmIX5La77nwGz9nLwSiWTs7GR8ayIUo8Ig/RtX7+27qY+ZAnOLwuNji/kt/jTvg+R
         2KRFilkUdO2d/diw40CGLP+JhwDOJxAs2LL4SAvBtlqAHalOPEbis5+0qronxbCe0O
         EDMnXyj0FxuS6N4ibvdeFVIEOHVp0PByV0hK3Pn8=
Date:   Sat, 7 Jul 2018 18:01:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:imu:adis: Mark expected switch fall-throughs
Message-ID: <20180707180135.01ac79e9@archlinux>
In-Reply-To: <20180703193550.GA12565@embeddedor.com>
References: <20180703193550.GA12565@embeddedor.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 14:35:50 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to hopefully ignore!

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index ad6f91d..c771ae6 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -81,9 +81,11 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
>  		adis->tx[9] = (value >> 24) & 0xff;
>  		adis->tx[6] = ADIS_WRITE_REG(reg + 2);
>  		adis->tx[7] = (value >> 16) & 0xff;
> +		/* fall through */
>  	case 2:
>  		adis->tx[4] = ADIS_WRITE_REG(reg + 1);
>  		adis->tx[5] = (value >> 8) & 0xff;
> +		/* fall through */
>  	case 1:
>  		adis->tx[2] = ADIS_WRITE_REG(reg);
>  		adis->tx[3] = value & 0xff;
> @@ -167,6 +169,7 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
>  		adis->tx[2] = ADIS_READ_REG(reg + 2);
>  		adis->tx[3] = 0;
>  		spi_message_add_tail(&xfers[1], &msg);
> +		/* fall through */
>  	case 2:
>  		adis->tx[4] = ADIS_READ_REG(reg);
>  		adis->tx[5] = 0;

