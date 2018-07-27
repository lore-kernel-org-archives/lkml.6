Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569EEC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD9120673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWhwBpiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD9120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbeG0Txu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:53:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41031 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388836AbeG0Txu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:53:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id y10-v6so2007204pfn.8;
        Fri, 27 Jul 2018 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PLc9u440K7eobh8q4fBsLr8R5Di2X7fS6eZHvJgSEoM=;
        b=dWhwBpiE6UvwmG8njpByLfGiewV9ShLasUPZQVzCr2qyngbzXG1yD9aAgy0qfsDsLG
         ds8fc9BSZMildOIlV+ciDCoUf0rkxL8wyC4h1FK7WclsMXnjhJpg4KRSoHEAJDSzAXkD
         MFn9g0Wb0pqrDYAND2JX5SHlQJZ+Wl0EW6eIY1x9pmrWptprTnm1bHLj7H8GonsPaORf
         MRTDmPFLm8p2m7CPSOjEH0cesB8YEv3EZY2rnwhNYr/2JdL42FLpH+kt6LbaxFWVQSRh
         YwuN2+1S8XLzgh5HRQ+aZcPlc7D6PUcnRHf9h5JMazFq6HrZiXrU6ttjbX5m/7V3WTvd
         aYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PLc9u440K7eobh8q4fBsLr8R5Di2X7fS6eZHvJgSEoM=;
        b=VXF99QxfdxWDmgk5HlPSl/1BrIA9QbqwzrKokWlrlr8wyTySS8H5JSNCJ1/fWuQmzJ
         kBMtl8riqRRNhHV1izvIhvPspQF3HkDvx98iGK6dwO1rq/9GMinbrJVDDbuOd4PDiJoJ
         MTWV9p5scWDqT3oJMQcGriz7+FJnwATf5KH5OO/hYuKmNPj6G8bNtFS7wU/DhI7kgua5
         f9meFey5g4erUvt9kpEA+lrx1eLJAmILLjt5EbjXHsSxcVsPt4xdZqC8FFcZe+EeJk4g
         rg2HeL878G673PXoxshRHBPMkWVf/5JpCu9gHs6qiWsMH6nFOKCenkTjXESyPYebq1Se
         Z19Q==
X-Gm-Message-State: AOUpUlGdbWt7vDQVp4tdXvUS1ADvCAsc9X6Bi4T+PUBPzmJductHt1+n
        eSpZSriGX56u4LwbHpWzF84=
X-Google-Smtp-Source: AAOMgpf4uqJ99i2W0SP/r/7/uAtQZHF2vpvJBl0uJlTADy08ZHDnQVRUrQ0E0M1jYFUugZWbligLcQ==
X-Received: by 2002:a63:524e:: with SMTP id s14-v6mr7211279pgl.35.1532716244642;
        Fri, 27 Jul 2018 11:30:44 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id g20-v6sm6802754pfo.94.2018.07.27.11.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 11:30:43 -0700 (PDT)
Date:   Fri, 27 Jul 2018 11:30:41 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     rydberg@bitmath.org, gregkh@linuxfoundation.org, andi@etezian.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: touchscreen: wdt87xx_i2c: Replace mdelay() with
 msleep() in wdt87xx_resume()
Message-ID: <20180727183041.GA72640@dtor-ws>
References: <20180727023216.1467-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727023216.1467-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:32:16AM +0800, Jia-Ju Bai wrote:
> wdt87xx_resume() is never called in atomic context.
> It calls mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/wdt87xx_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
> index 20f7f3902757..166edeb77776 100644
> --- a/drivers/input/touchscreen/wdt87xx_i2c.c
> +++ b/drivers/input/touchscreen/wdt87xx_i2c.c
> @@ -1142,7 +1142,7 @@ static int __maybe_unused wdt87xx_resume(struct device *dev)
>  	 * The chip may have been reset while system is resuming,
>  	 * give it some time to settle.
>  	 */
> -	mdelay(100);
> +	msleep(100);
>  
>  	error = wdt87xx_send_command(client, VND_CMD_START, 0);
>  	if (error)
> -- 
> 2.17.0
> 

-- 
Dmitry
