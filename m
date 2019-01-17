Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FBDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6404A20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuwXGnfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfAQHIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:08:42 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33438 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfAQHIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:08:42 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so4316268plo.0;
        Wed, 16 Jan 2019 23:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=chhrvg54MI90YfaM2WKEa/GdmTxheYiEx0N9RVbWUss=;
        b=VuwXGnfyh/vEhp0oOOySaoFGo+eYY7QMBEij5IpslrHillGBa21VApOjlFwUlte3Wh
         r6mi8lG1hawfSfDQZ6jZoW4GjCwPA3PQ6NSwhU3tQMzFknbFQjD9CXQPlNXhEG4r3kYp
         IUeohfzbHgYWVkvZwgPLywn318FQbSIMKoS3+rh38zLrrwHZqxUv4zlJaoX09202jXf2
         nDB0Vg4QCZi+TLBJ7q8PZaDb255TUMzKfpUoRyTToZilmyUITh80irnhaN5y9zRSk2X5
         3JrhFWMNZ0V72iYJ9/Sbh6OikCj/xUsbbE3g/4XCKaVMlaLK31Zz9HWszG6pD3w8pHu3
         JAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=chhrvg54MI90YfaM2WKEa/GdmTxheYiEx0N9RVbWUss=;
        b=CUYhy5f8wcw5Ys3UrPv8fd7l3mToj/a7p6U/a5rwrZJH77gmnpH3Ahef2xDuiMq/x/
         VSUzoA8dhWGoHJNxMiT+MFxuW7gphzrTIxlyaGSjs3wWoct9diDEfjypua6XeIqNSHE8
         OVwF3X5JKqh4b3BmfOZVJPrZIEpL5xzuD0ey7dbh05PwYyxsyA8+v6Y1vB4p4VDrTzQz
         rdzM3Ak9/ujx4b1/BWaIdokvGqUg1QwQrNs+xxoMs3412bd8oZSrmx3OQMKsbE+884FS
         1bbvLTtvv8APaRGWnmoOFqCWn17GxYt9VL4/GQoB9Nd1uVJk3E9eK6SpAzGy95eUwfDi
         n43w==
X-Gm-Message-State: AJcUukee8oT5tmcERzUP2QAfjWc5q+VasJgD8x1K+bgnso/gcQthup/V
        8eTaPgSutX9XBarN6hpPC8Y=
X-Google-Smtp-Source: ALg8bN45vI739KAKPwsMaJwF3JqWMaG1AKd7ApH/krSRxDyi4Bu1dXEYoklqOwRFetXhqYWUUFFOGg==
X-Received: by 2002:a17:902:4025:: with SMTP id b34mr13946612pld.181.1547708920735;
        Wed, 16 Jan 2019 23:08:40 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id n22sm1444532pfh.166.2019.01.16.23.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 23:08:40 -0800 (PST)
Date:   Wed, 16 Jan 2019 23:08:38 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: Re: [PATCH] input: misc: pwm-vibra: Prevent unbalanced regulator
Message-ID: <20190117070838.GA8109@dtor-ws>
References: <20190116211131.18809-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190116211131.18809-1-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paweł,

On Wed, Jan 16, 2019 at 10:11:31PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> pwm_vibrator_stop disables the regulator, but it can be called from
> multiple places, even when the regulator is already disabled. Fix this
> by using regulator_is_enabled check when starting and stopping device.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/input/misc/pwm-vibra.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
> index 55da191ae550..66677ee770ca 100644
> --- a/drivers/input/misc/pwm-vibra.c
> +++ b/drivers/input/misc/pwm-vibra.c
> @@ -42,10 +42,12 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
>  	struct pwm_state state;
>  	int err;
>  
> -	err = regulator_enable(vibrator->vcc);
> -	if (err) {
> -		dev_err(pdev, "failed to enable regulator: %d", err);
> -		return err;
> +	if (!regulator_is_enabled(vibrator->vcc)) {

I do not think this is correct in case of shared supply, as this checks
global state of regulator. That means that if there is another user, we
may forego enabling regulator here, and that anther user may power it
down and vibrator will stop working.

I think you need a local flag here.

> +		err = regulator_enable(vibrator->vcc);
> +		if (err) {
> +			dev_err(pdev, "failed to enable regulator: %d", err);
> +			return err;
> +		}
>  	}
>  
>  	pwm_get_state(vibrator->pwm, &state);
> @@ -76,7 +78,8 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
>  
>  static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
>  {
> -	regulator_disable(vibrator->vcc);
> +	if (regulator_is_enabled(vibrator->vcc))
> +		regulator_disable(vibrator->vcc);

Looking at this, I wonder if we should not disable PWMs first and the
disable regulator.

>  
>  	if (vibrator->pwm_dir)
>  		pwm_disable(vibrator->pwm_dir);
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
