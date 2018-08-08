Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0FBC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68B42174A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68B42174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeHHOlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:41:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41258 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHHOlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:41:50 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 79F87CC1;
        Wed,  8 Aug 2018 12:22:22 +0000 (UTC)
Date:   Wed, 8 Aug 2018 14:22:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/15] staging: fbtft: Fixes some defines styles -
 Style
Message-ID: <20180808122219.GC20272@kroah.com>
References: <cover.1533686201.git.leobras.c@gmail.com>
 <cb5b3900e97e3b295dda63b5d8b29d6fed669893.1533686201.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb5b3900e97e3b295dda63b5d8b29d6fed669893.1533686201.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 09:29:25PM -0300, Leonardo Brás wrote:
> Fixing some styles as recommended by checkpatch.pl.
> 
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c  | 10 ++++++----
>  drivers/staging/fbtft/fbtft-core.c |  6 ++++--
>  drivers/staging/fbtft/fbtft.h      |  4 ++--
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 8ce1ff9b6c2a..20d94712cc84 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -60,11 +60,13 @@ void func(struct fbtft_par *par, int len, ...)                                \
>  out:									      \
>  	va_end(args);                                                         \
>  }                                                                             \
> -EXPORT_SYMBOL(func);
> +EXPORT_SYMBOL(func)

why did you change this line?

>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> -define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +#define no_modf /*No modifier*/

Ick ick ick, no.

> +
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, no_modf);
> +define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16);
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, no_modf);



>  
>  void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
>  {
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index 64f69d1a3029..8b79353c722a 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -275,6 +275,7 @@ void fbtft_unregister_backlight(struct fbtft_par *par)
>  		par->info->bl_dev = NULL;
>  	}
>  }
> +EXPORT_SYMBOL(fbtft_unregister_backlight);

You are doing a lot of different things all in one patch, please break
this up into one patch per logical thing.

thanks,

greg k-h
