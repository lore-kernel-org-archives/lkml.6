Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15579C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDBC2174A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDBC2174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeHHOik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:38:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41228 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeHHOik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:38:40 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 68CBDCC1;
        Wed,  8 Aug 2018 12:19:13 +0000 (UTC)
Date:   Wed, 8 Aug 2018 14:19:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/15] staging: fbtft: Fixes some lines long lines
 (>80) - Style
Message-ID: <20180808121910.GB20272@kroah.com>
References: <cover.1533686201.git.leobras.c@gmail.com>
 <3c7753c1fb1fdb476b825231659b3cf193e3d720.1533686201.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c7753c1fb1fdb476b825231659b3cf193e3d720.1533686201.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 09:28:42PM -0300, Leonardo Brás wrote:
> Trying to keep the code in the 80-char line limit.
> 
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> 
> diff --git a/drivers/staging/fbtft/fb_ssd1306.c b/drivers/staging/fbtft/fb_ssd1306.c
> index 9276be499303..f5e0ec1c01dc 100644
> --- a/drivers/staging/fbtft/fb_ssd1306.c
> +++ b/drivers/staging/fbtft/fb_ssd1306.c
> @@ -184,7 +184,8 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
>  		for (y = 0; y < yres / 8; y++) {
>  			*buf = 0x00;
>  			for (i = 0; i < 8; i++)
> -				*buf |= (vmem16[(y * 8 + i) * xres + x] ? 1 : 0) << i;
> +				*buf |= (vmem16[(y * 8 + i) * xres + x] ?
> +					 1 : 0) << i;
>  			buf++;
>  		}
>  	}
> diff --git a/drivers/staging/fbtft/fb_ssd1331.c b/drivers/staging/fbtft/fb_ssd1331.c
> index 383e197cf56a..e2b3ba82d01f 100644
> --- a/drivers/staging/fbtft/fb_ssd1331.c
> +++ b/drivers/staging/fbtft/fb_ssd1331.c
> @@ -74,7 +74,8 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
>  		for (i = 0; i < len; i++)
>  			buf[i] = (u8)va_arg(args, unsigned int);
>  		va_end(args);
> -		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par, par->info->device, u8, buf, len, "%s: ", __func__);
> +		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par, par->info->device,
> +				  u8, buf, len, "%s: ", __func__);
>  	}
> 
>  	va_start(args, len);
> diff --git a/drivers/staging/fbtft/fb_st7735r.c b/drivers/staging/fbtft/fb_st7735r.c
> index 9670a8989b91..c8e94f388ce5 100644
> --- a/drivers/staging/fbtft/fb_st7735r.c
> +++ b/drivers/staging/fbtft/fb_st7735r.c
> @@ -130,8 +130,10 @@ static int set_var(struct fbtft_par *par)
> 
>  /*
>   * Gamma string format:
> - * VRF0P VOS0P PK0P PK1P PK2P PK3P PK4P PK5P PK6P PK7P PK8P PK9P SELV0P SELV1P SELV62P SELV63P
> - * VRF0N VOS0N PK0N PK1N PK2N PK3N PK4N PK5N PK6N PK7N PK8N PK9N SELV0N SELV1N SELV62N SELV63N
> + * VRF0P VOS0P PK0P PK1P PK2P PK3P PK4P
> + *	       PK5P PK6P PK7P PK8P PK9P SELV0P SELV1P SELV62P SELV63P
> + * VRF0N VOS0N PK0N PK1N PK2N PK3N PK4N
> + *	       PK5N PK6N PK7N PK8N PK9N SELV0N SELV1N SELV62N SELV63N

Some lines should stay long, please use common sense.  checkpatch is a
guide, not a hard/fast rule.

greg k-h
