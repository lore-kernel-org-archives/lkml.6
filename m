Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A8AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99F221773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550656348;
	bh=j8GiWdTrnDJPHmV7leWtmNUgsY8cNOh8pxNO06m8gsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FLhRTMBDZNu3FJtbSf5cy5pLdtrwpw0n1kbT5AHvIqCbXUQlPN3AJwrAQQRxBJjau
	 dqCrbXDPwQB1pIq8pGdj1okg5no8mPZGbdRu0FJbLQnuBpMoFtd/wcIAKLN4e3fcx+
	 l7ukNLZbrVA2pONxjr9GkynY1MaB9DTydjezMlHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfBTJw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfBTJw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:52:27 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1522089F;
        Wed, 20 Feb 2019 09:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550656346;
        bh=j8GiWdTrnDJPHmV7leWtmNUgsY8cNOh8pxNO06m8gsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2PTKxnvBdDg2iiWiB2vYYYtYURNWy5HjXZhahrpp4L4NyyfhPbhi9hMwCZ1CVgrMv
         /OPTNbgydhBshltWjqwXpbxQNii+FN9gtKdi4XbQoFkD3MXLNVuGJ8x948yxqqUYmK
         PZwwJ4aDHQLHBB9HQ40lJ2wmxlYwjpFd6cwshpoo=
Date:   Wed, 20 Feb 2019 09:52:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
Subject: Re: [PATCH 4/5] iio:potentiostat:lmp91000: invert if statement
Message-ID: <20190220095219.2f1efa85@archlinux>
In-Reply-To: <20190218172236.7781-5-lucasseikioshiro@gmail.com>
References: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
        <20190218172236.7781-5-lucasseikioshiro@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 14:22:35 -0300
Lucas Oshiro <lucasseikioshiro@gmail.com> wrote:

> Invert if statement arms in line 214, in order to make the code cleaner
> 
> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>

Given this undoes one of the earlier changes, please merge them.

Jonathan

> ---
>  drivers/iio/potentiostat/lmp91000.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index 6dba26121a62..7229ef59590a 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -211,12 +211,11 @@ static int lmp91000_read_config(struct lmp91000_data *data)
>  
>  	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
>  	if (ret) {
> -		if (of_property_read_bool(np, "ti,external-tia-resistor")) {
> -			val = 0;
> -		} else {
> +		if (!of_property_read_bool(np, "ti,external-tia-resistor")) {
>  			dev_err(dev, "no ti,tia-gain-ohm defined");
>  			return ret;
>  		}
> +		val = 0;
>  	}
>  
>  	ret = -EINVAL;

