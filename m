Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AD0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5247B20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlA7on3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfBFMoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:44:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33449 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfBFMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:44:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id h22so1734035wmb.0;
        Wed, 06 Feb 2019 04:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hlvdYYOfL6ehCQai+lTJvgtWJnFUdDi5mj/8Y2nP4RE=;
        b=jlA7on3QeOM7dEx37X3Ohe6EySnzMPCJZcj0pdcWrM395P6EL13IBjRk63LlPRO0N0
         rSTU+iYV25J051ixUsrf1X3uBiBg1qUclnnoIYWLJhY7urXDNHhFFrEjyqOuhmEbG1nr
         FS/qyPmJzzGt5GLdyeytdBG/D9RJWHO8KarD0sG8dzL9TL0GR5rgfey2mf2T/G6cNlWM
         YMG+xOnzhh/6u5vqi3iddgZtSbWJGmb/Uq7kRHxbXGNz2gOBP13OIpF8iZBRKtgOipSQ
         UWGTwfxIFxSqbWXwbZU0FiGaW1Z+sXafoIHQcae2M91+xrLlNr3MdXozzQV4LqZBXKa6
         niAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hlvdYYOfL6ehCQai+lTJvgtWJnFUdDi5mj/8Y2nP4RE=;
        b=Qn+Ud+EQmyPSIHQwn8/RfC/eC8btDPubIsfOJt+rxs6ZIdqsT6dQW6QHstay/Itxzf
         vqGWwd31UcdQ5mE46QrDw9yFfJBnkDPBytBSOe8fpZeOFczk6aQHDg6VXv+q4WcCTEsU
         TxLVfyuCTyMZsYiHXDjHcyy2D0yHNs7ttZDT/XCyLDR0++spqIgsP027nU+0lRFvolD6
         U83zLYY9ULz5pmvHpTO4gd77kH4l9Y+GOeMi6YRPs1IrOsKdXdd+Xfwhl5a18xnUAlfe
         rwtAb3aozIbghAbRkhV73LxWTkNw4SHfeQi5IWpFzHy1vIqR6csZTO7YJzZBLUghuGZa
         h8YA==
X-Gm-Message-State: AHQUAuaMCdsfM2ge9J5g+Fee7GioIzzjIR0q87Gu86KKlaaViMSmrTah
        35d921i/Jj+GItToVcSAlzM=
X-Google-Smtp-Source: AHgI3IZNDW51tDYuakz2WMiSQGf+ROa3dAL20dlNGc9oOjE/6tZF5cAfLPs6wN9igHxfgpypH4bg0A==
X-Received: by 2002:a1c:2d42:: with SMTP id t63mr3242686wmt.9.1549457084369;
        Wed, 06 Feb 2019 04:44:44 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id n15sm13590929wrt.21.2019.02.06.04.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 04:44:43 -0800 (PST)
Date:   Wed, 6 Feb 2019 13:44:42 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH v5 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190206124442.GG21676@ulmo>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eMnpOGXCMazMAbfp"
Content-Disposition: inline
In-Reply-To: <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eMnpOGXCMazMAbfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 05:13:19PM +0530, Yash Shah wrote:
[...]
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
[...]
> +static void pwm_sifive_update_clock(struct pwm_sifive_ddata *pwm,
> +				    unsigned long rate)
> +{
> +	/* (1 << (16+scale)) * 10^9/rate = real_period */
> +	unsigned long scale_pow =
> +			(pwm->approx_period * (u64)rate) / NSEC_PER_SEC;

I think you need another div64_ul() for this one to fix the linker error
that the 0-day builder was pointing out.

Thierry

--eMnpOGXCMazMAbfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa1roACgkQ3SOs138+
s6Ho7w/44E8oDkjBRAR5L9470vsccMPAjzx4g2A7RH4LgdftIUAZcBK6SO0hlwHQ
5Obv6Zz5m0W0RF8MkaVyIdtgLUfnEMSTSz3JMT3aDCZ6SvJttXthHoGuzNgEM1U2
zJJS/zw0Rkw1uDfIwlYU/A2dxa5pye5w/9XymmQfA2+1dUvEMtvDQLwg8sCxV7Kt
xxmZ/xkogqT15Dlez28duZ5qW9IHRBixx6ihoCEUgFF91tC/ZUAcnq3ouBuesAsf
5uuwgW86CUXYo7fqjwHObMVjqbAXTQOaXcr00pYsBRXD+KRfgHtYp6mGDeabXOa2
70wvWfzFGVama3PK6eUH/9pZ0Bl1HBZbn5L9PFHSxexsakZnLDKzeiuwdYLbBC6T
wTN+tekJhBZf/o286YsObORPMkjpQ8AYAtAnlMHsOLdiLJROPU+AMw9qnjQgOk54
4CfFuntAA9zJg+DaObAHuDlrU83pa71wSWytGSdgDjpvcmCtt7D30BuIvnIjp9D/
apsnqQRQY6jKtd5G76AQaGuhShJIoPFRJI4zRTjZ1UlGwA0isbIvqiU6R4iH4/v4
Y03Pcr1JBYn/adGE8v3PH+z0vuF3jrrVZ4sUdKWtErT99q/PdxK6pqYnoami1IFt
gMQmQrsiH8XfRde6dE1kf0ebvKwTe9IrbtR2HTEXhcnd4ieBGg==
=YYF2
-----END PGP SIGNATURE-----

--eMnpOGXCMazMAbfp--
