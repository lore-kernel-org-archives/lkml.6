Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F03FC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FABB2146F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkB0Fl8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FABB2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeLBCwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:52:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeLBCwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:52:24 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A80C820673;
        Sat,  1 Dec 2018 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543678777;
        bh=AbFuLxDzc+Oa6euuuOQwP0BVmHwGMTyQRzJYFjbXF8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HkB0Fl8xuOdBNuLRXiRIOaWXqy0rdoxofPWUqNWjiDDPX78FtRljH6KcYpZHwmbvI
         /LXFktHJx0VtJsT+KV3H2VI5z2ya3Ew1gEAVp/OIXmuYVW3N9jxuAZh55Dxp/GI8fQ
         dzSSIjsPwXClV7XLVEC3TsKGGS1Mj8TwMDt/wLEc=
Date:   Sat, 1 Dec 2018 15:39:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: Re: [PATCH v3 6/7] staging:iio:ad2s90: Add comment to device state
 mutex
Message-ID: <20181201153932.45e218f5@archlinux>
In-Reply-To: <20181124002312.6923-7-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
        <20181124002312.6923-7-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 22:23:11 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> From: Victor Colombo <victorcolombo@gmail.com>
> 
> Fix the checkpatch.pl issue:
> "CHECK: struct mutex definition without comment".
> 
> Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Applied, thanks

Jonathan
> ---
> Changes in v3:
>  - none
> 
> Changes in v2:
>  - Patch added in v2
> 
>  drivers/staging/iio/resolver/ad2s90.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 678351dabe6b..a41f5cb10da5 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -22,7 +22,7 @@
>  #define AD2S90_MAX_SPI_FREQ_HZ  830000
>  
>  struct ad2s90_state {
> -	struct mutex lock;
> +	struct mutex lock; /* lock to protect rx buffer */
>  	struct spi_device *sdev;
>  	u8 rx[2] ____cacheline_aligned;
>  };

