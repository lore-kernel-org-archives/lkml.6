Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429C5C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB2D2088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2szqLf9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB2D2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeJGXuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 19:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbeJGXuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 19:50:09 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4F28206B2;
        Sun,  7 Oct 2018 16:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538930539;
        bh=IwYNJAirhlmodu5hp+XsVP5bFcvJPmOV/t8rIL0ZKLs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2szqLf9Gyl47glk7XI/efL4yMF/bBp7EG6a3kzKTMFgnTNPn7NfpsxqJdfUfRSThh
         T/VtVyi+dJg4lwHgTQuDvxEzFi1DUdjRVn4n9TEA9wRsH9GqPqrVHuDwlhjiYvKnsw
         opk/kEMFqB883tmft4R8kVc1gnwbyFSmCV/SSWws=
Date:   Sun, 7 Oct 2018 17:42:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad2s1210: fix 'assignment operator' style
 checks
Message-ID: <20181007174214.2ecf61ee@archlinux>
In-Reply-To: <CAHd-oW7Xpr-+1SuxsjduFhrRqh7TcGTqmJ22A7W7Oqk8o2E1Kg@mail.gmail.com>
References: <CAHd-oW7Xpr-+1SuxsjduFhrRqh7TcGTqmJ22A7W7Oqk8o2E1Kg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018 22:24:26 -0300
Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:

> This patch fixes all "Assignment operator '=' should be on the previous
> line" checks found in ad2s1210.c by checkpatch.pl.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Hi Matheus,

Good change, but unfortunately your email client as converted
tabs into spaces so it cannot be applied.   Try git am 
with this email and you'll see what I mean.
See Documentation/process/email-clients.rst for some hints on this.

Looking forward to V2 with that fixed!

Thanks,

Jonathan
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c
> b/drivers/staging/iio/resolver/ad2s1210.c
> index ac13b99bd9cb..d4b1c2c010f2 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -301,8 +301,8 @@ static ssize_t ad2s1210_store_control(struct device *dev,
>              "ad2s1210: write control register fail\n");
>          goto error_ret;
>      }
> -    st->resolution
> -        = ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> +    st->resolution =
> +        ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
>      if (st->pdata->gpioin) {
>          data = ad2s1210_read_resolution_pin(st);
>          if (data != st->resolution)
> @@ -363,8 +363,8 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
>          dev_err(dev, "ad2s1210: setting resolution fail\n");
>          goto error_ret;
>      }
> -    st->resolution
> -        = ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> +    st->resolution =
> +        ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
>      if (st->pdata->gpioin) {
>          data = ad2s1210_read_resolution_pin(st);
>          if (data != st->resolution)

