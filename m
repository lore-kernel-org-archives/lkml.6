Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E72CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3CA20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCPRRdiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3CA20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbeG0T4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:56:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43031 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbeG0T4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:56:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id v13-v6so3694161pgr.10;
        Fri, 27 Jul 2018 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RhZSiEFN6VyaUkgQiJeGt7q8ya3y2Bqra4/HxQzdM2Q=;
        b=hCPRRdiKLhDWtAIG6R3uDdhFV7LT+aS7Efai/KtwNIgOKsWYBc/+zzcs+y+PmAhfDC
         /wEEzBGKQ4IhCxFkAo5BL9d+qPBT0MnGp1GYwWRz+Rpuym3hZQkK8IsOm4U+V/IyqtXV
         YzB3FrmlvtPCajPbEDt9+b00OqDidoRvQV/sviseffX5FXiit99KD3VVzwBRnoeDRe3n
         PYMBhZ3l+udgPrDdE09rDewWoCU1+tIiv+X46B5H1ad5QahK7XMIRM5N0Kt4i7d+u0sB
         F0Fh4RzVsjz3E3RxrsJLK723il29rEoGdnSdHWV7GAxmvawBAsuZbGMrFZOYE5wurzBQ
         Zf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RhZSiEFN6VyaUkgQiJeGt7q8ya3y2Bqra4/HxQzdM2Q=;
        b=S5m1tT+VT4ljfCo0SHeGhQUf/UQYjBoayqcC3oUZIm0wHOLX55QONWzDBpHO97/+Ke
         bII1a/0Ki/CI08Ff6HhJ3osYcd7Iw4wlTOHrpumDe9X9zDPPyB9tGug+mBH+DcWv5h6Q
         xjB/h/LYa71U7sLonkSDGQ5SyOGTgyM9cHZyVBf3fMbcKqNh0D6RKQDTJuKoWTZosj19
         9h5UEKE1iUU41yFTlXTbeUF1fn0y+wO9UhL078WEt7RXyszzPfwof7sqRP5PIMREQua8
         m1kutHLvSuGePaIiqIRbSx4hd02fyYn5LZSrxu/jpLELwscCiypLH14f3/6irEa3Vx8Z
         244A==
X-Gm-Message-State: AOUpUlHB0e1uemyWO0JoKI4qevfqA3VwLWFaqsulKocddep8RSuQiJQK
        m0rObuMN76SbuFdaGjQ0qQ4=
X-Google-Smtp-Source: AAOMgpeF0Zuj5rIhnmRdXlICYfBnEfdUqTnvw5nqpym/pfNl3z7YqsrpXHBbr1q9mPOGP1n0lL2CFQ==
X-Received: by 2002:a63:4506:: with SMTP id s6-v6mr7324605pga.422.1532716419974;
        Fri, 27 Jul 2018 11:33:39 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id 137-v6sm3033668pfu.121.2018.07.27.11.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 11:33:38 -0700 (PDT)
Date:   Fri, 27 Jul 2018 11:33:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     arvind.yadav.cs@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: misc: powermate: Replace GFP_ATOMIC with
 GFP_KERNEL in powermate_alloc_buffers()
Message-ID: <20180727183337.GC72640@dtor-ws>
References: <20180727021723.709-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727021723.709-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:17:23AM +0800, Jia-Ju Bai wrote:
> powermate_alloc_buffers() is never called in atomic context.
> It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thank you.

> ---
>  drivers/input/misc/powermate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
> index 5c8c79623c87..e8de3aaf9f63 100644
> --- a/drivers/input/misc/powermate.c
> +++ b/drivers/input/misc/powermate.c
> @@ -277,7 +277,7 @@ static int powermate_input_event(struct input_dev *dev, unsigned int type, unsig
>  static int powermate_alloc_buffers(struct usb_device *udev, struct powermate_device *pm)
>  {
>  	pm->data = usb_alloc_coherent(udev, POWERMATE_PAYLOAD_SIZE_MAX,
> -				      GFP_ATOMIC, &pm->data_dma);
> +				      GFP_KERNEL, &pm->data_dma);
>  	if (!pm->data)
>  		return -1;
>  
> -- 
> 2.17.0
> 

-- 
Dmitry
