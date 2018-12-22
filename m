Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F85C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C39D21A4B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545499748;
	bh=faTOkyHoSxtRC5mOWzbDqVgzvo91S99q++LO8u+WawY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tj2JUgGo4QX1xFxGe+ZBzGAYC9EBQCaCWRAE4YeIHGWXTokEVAaq3YNwC3IBVc3zg
	 SovmwowLJLWvaln8jb+1SgJumpxwzecUIk/e1XEmRpvRQF1c53eIluRYQw049XUYTS
	 KaOSNT20sZ3RShZpKq4HmhvYId7bHez93cNQ7mC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391402AbeLVR3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:29:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeLVR3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:29:07 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01BAB219D6;
        Sat, 22 Dec 2018 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545499746;
        bh=faTOkyHoSxtRC5mOWzbDqVgzvo91S99q++LO8u+WawY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TX8PnhFRAsnxngXrrPQEDxbyi0zzR5ZfVITNlkDPWH6xyDJrvdK+aA27ewdl2EUEW
         Owa5UqRuZhwOvrI3/4xQulSsQ6nVqlTxcxqx/qQhNjTuLui2aDAPTvJ7Zbsmn2P9MY
         3LbUFVNV9x+gbruMiSYdAwq2RwGE0hKt9QLZ2Is8=
Date:   Sat, 22 Dec 2018 17:28:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: ad7192: replaced bool in struct
Message-ID: <20181222172859.6d3b84ae@archlinux>
In-Reply-To: <1545434786-15220-1-git-send-email-indigoomega021@gmail.com>
References: <1545434786-15220-1-git-send-email-indigoomega021@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 15:26:26 -0800
Amir Mahdi Ghorbanian <indigoomega021@gmail.com> wrote:

> Replaced bool in struct with unsigned int bitfield to conserve space and
> more clearly define size of varibales
> 
> Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Hi Amir,

I'm a bit in two minds on this one.  It's not a size critical structure
and the advantage of bools is they make it clear the thing really is
true or false.

Another element here is that this is a platform data structure and unless
we have users in the kernel tree, the chances that we'll maintain it's
existence at all as we look to move this driver out of staging is very
small!

So slightly marginal advantage to the change on a structure that I certainly
hope is shortly going away!

Sorry, but I'm not convinced and won't be applying it.

If you want to work on this driver though that would be great and I'm happy
to do a review of it to highlight what other elements need cleaning up.
Just say on the list and either I'll take a look or one of our other
reviewers will.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7192.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
> index 7433a43..7d3e62f 100644
> --- a/drivers/staging/iio/adc/ad7192.h
> +++ b/drivers/staging/iio/adc/ad7192.h
> @@ -35,13 +35,13 @@ struct ad7192_platform_data {
>  	u16		vref_mv;
>  	u8		clock_source_sel;
>  	u32		ext_clk_hz;
> -	bool		refin2_en;
> -	bool		rej60_en;
> -	bool		sinc3_en;
> -	bool		chop_en;
> -	bool		buf_en;
> -	bool		unipolar_en;
> -	bool		burnout_curr_en;
> +	unsigned int	refin2_en : 1;
> +	unsigned int	rej60_en : 1;
> +	unsigned int	sinc3_en : 1;
> +	unsigned int	chop_en : 1;
> +	unsigned int	buf_en : 1;
> +	unsigned int	unipolar_en : 1;
> +	unsigned int	burnout_curr_en : 1;
>  };
>  
>  #endif /* IIO_ADC_AD7192_H_ */

