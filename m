Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA2C04ABA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFFB218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUnF65pT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbeLXJ6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:58:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38308 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbeLXJ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:58:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so5627576pfi.5;
        Mon, 24 Dec 2018 01:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hiacip2t/PNlbfpK9vt1RKO9qJPkbxewcOq1ocv1leA=;
        b=hUnF65pTY21J5bOKwCoUhs0/RJlA6DJWE2kgsxHP97ZYm39ZspI5elA+zst3zF+NbW
         kCuPf/YL/rJ58rjavbbOoaUrY8X1zN9xkKKp7E4fJcZZI7zESed99bwuGAwBpLULeEJz
         r7ZG5QApdnnyfkBZcKT+vF18hj95EKSh3orSQ4UboR5po/jkcHVe3PnitIENEOQckso3
         jwtQOY7Z80X8SkRUENdiDAhTRB007QZEfR9bUAh0kzlPDNDoinwrYuhsbtXe5hazchu2
         doTpaoHFvqJ4fVn1eOspixDQ5GUkls2VdDIehJ2zl9HgG5OusYZMR8Guf6WPzOpj9hoO
         6k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hiacip2t/PNlbfpK9vt1RKO9qJPkbxewcOq1ocv1leA=;
        b=drWm4/DU1Q+pLECIVctDuJ8zkyMusgHsHKNmU188i66f/ZNQd126GYfNUFWb0OYA3s
         4fiEQk9jos4/rqRARFQnLz1QQ07fP+JA/+FsSrqanE/gexxPchNPCvYVLv+YmwOrlwXd
         m/Tm0XGghehB6r1uVvoBsTdnzllOtAgyzM1ArMVBkju2P4kYWtKY1if2nX+VEyN/nQ7w
         RygPaGt9RxkRk5nRczsK63uS0buNwiiw10GmeyRYk0Zr/w66DAq8f77EoaanVmIKyVH0
         ZBYroYN1gPLmw6Qwu6RRjK9f8cS5VnLZJxeGYwBQzl6+oMaRIqLLK2oxmngnbV8I5Jmy
         KzFA==
X-Gm-Message-State: AJcUukd0WjEgb4NcQ6uevXWZdRAUxDUZIgtN4i0VirZaPTWKyPCo6fK7
        AGCRnZlVifNJkbIL7dYdJW5xpu2i
X-Google-Smtp-Source: ALg8bN6uiWvnsf1uQBMj4U8mivDqcmcA1MN76buZn+vp62V446WqVREQU3QjE1C63oZGM06c55edRA==
X-Received: by 2002:a63:b94c:: with SMTP id v12mr11743094pgo.221.1545645512786;
        Mon, 24 Dec 2018 01:58:32 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id b2sm56118093pfm.3.2018.12.24.01.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 01:58:31 -0800 (PST)
Date:   Mon, 24 Dec 2018 15:28:23 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: ad7192: replaced bool in struct
Message-ID: <20181224095823.GA17061@himanshu-Vostro-3559>
References: <1545434786-15220-1-git-send-email-indigoomega021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545434786-15220-1-git-send-email-indigoomega021@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 03:26:26PM -0800, Amir Mahdi Ghorbanian wrote:
> Replaced bool in struct with unsigned int bitfield to conserve space and
> more clearly define size of varibales
> 
> Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
> ---

There was some discussion on this at Outreachy list:
https://groups.google.com/d/msg/outreachy-kernel/xpQAl-Gn8HA/yqcQRG_qBgAJ

I think unless you post some statistics about 'conserving' space, 
it is unlikely that maintainers will apply it.

This idea was originally given by Linus and that thread of discussion 
is worth reading too.

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
> -- 
> 2.7.4
> 

Goodluck!

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
