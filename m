Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBF0C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA1321A4A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI5UiR0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfBIRNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:13:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37923 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfBIRNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:13:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so3145715pfi.5;
        Sat, 09 Feb 2019 09:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oGHxNHwrFIZb354YvypnDqpDKg8I+rcsrJjfh36+RdU=;
        b=TI5UiR0TGVCKBVhAkBVHYTuxolCYHci2hqocEnZkpLpdDpxGeI1qxZHTsdRVGVfzPt
         Hp7kirhkoYYXnil7W/tVglxWP8ARAn3NZl9gbidveNZ2irHTalzbXhuiW+5EjnYkzMSw
         Dbf8EW+/njjhwfzbDY4D1kwl2d6RvFoEoqamkbthB1rwmFWI3j4AqwY7buNnAW0vobZJ
         TS1CzIKVCrikjL1x9dG/FQZKA55CQg+pPh3icJ1uQEFkJIRKut7rl3CHU5qmmdevTz3T
         JXdpBLp+V1MAq3w1Lz51nONRRmp1AD9atUDo2xdyiU7+lrKa0241VUf+/UuUoVhxNrNg
         ebYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oGHxNHwrFIZb354YvypnDqpDKg8I+rcsrJjfh36+RdU=;
        b=SuUKx5OL4mprRBbSSpQNk2u1wViohCctovykks0lBLpdt9gUSv5eLA0avs17h+EIQ4
         Z0ikZy5SVHxd22EJTHA4nOkaaMyjWmBzd8JIbtNXLjXaQK8G5pIcDom99KKylAVoCSlk
         5NkJ0y50tR+JoNpbS3pvFLzcrKKtQXRRysbHzRBvCx0+gm27LvxA7JmDfVj9baat1K5Y
         tIEdIlaGSFktCXj1uT5FbYmItjZjvlzZXrMI8OUS0TExCP1EF9mWQXVKUmFgTRb6tKG+
         yT5z3BLz0Wz1t+gXJTl+JRsMd89TaCRrUr1RZkpoj41mncIyRHkcd5mfvHB405svDlGJ
         CWlw==
X-Gm-Message-State: AHQUAubABEplA/6dFnMk+237KOaDfhDSnRAcUCZY7gJPGGMsECsOZmWi
        TME0o8yE699v84YOEo3DRW1ECHi9
X-Google-Smtp-Source: AHgI3IY4lLvXKFqdaiOa68CXtFmrXi6zAkKNHjdsLGOb/fP1xBaHbQjrj/uVXumda5EDVt06lPEXXw==
X-Received: by 2002:a62:5e41:: with SMTP id s62mr28260955pfb.232.1549732393057;
        Sat, 09 Feb 2019 09:13:13 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i71sm3956001pfi.170.2019.02.09.09.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 09:13:12 -0800 (PST)
Date:   Sat, 9 Feb 2019 09:13:10 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] input: misc: pwm-vibra: Stop regulator after
 disabling pwm, not before
Message-ID: <20190209171310.GF197782@dtor-ws>
References: <20190124202732.14723-1-pawel.mikolaj.chmiel@gmail.com>
 <20190124202732.14723-2-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190124202732.14723-2-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 09:27:32PM +0100, Paweł Chmiel wrote:
> This patch fixes order of disable calls in pwm_vibrator_stop.
> Currently when starting device, we first enable vcc regulator and then
> setup and enable pwm. When stopping, we should do this in oposite order,
> so first disable pwm and then disable regulator.
> Previously order was the same as in start.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>

Applied, thank you.

> ---
>  drivers/input/misc/pwm-vibra.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
> index 9df87431d7d4..dbb6d9e1b947 100644
> --- a/drivers/input/misc/pwm-vibra.c
> +++ b/drivers/input/misc/pwm-vibra.c
> @@ -80,14 +80,14 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
>  
>  static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
>  {
> +	if (vibrator->pwm_dir)
> +		pwm_disable(vibrator->pwm_dir);
> +	pwm_disable(vibrator->pwm);
> +
>  	if (vibrator->vcc_on) {
>  		regulator_disable(vibrator->vcc);
>  		vibrator->vcc_on = false;
>  	}
> -
> -	if (vibrator->pwm_dir)
> -		pwm_disable(vibrator->pwm_dir);
> -	pwm_disable(vibrator->pwm);
>  }
>  
>  static void pwm_vibrator_play_work(struct work_struct *work)
> -- 
> 2.17.1
> 

-- 
Dmitry
