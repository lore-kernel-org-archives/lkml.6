Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A4FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9783C20657
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNViYEPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfAJHBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:01:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34144 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfAJHBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:01:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so4908866pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 23:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3X7FWpHmTVcpHXfgsAheG4ZiQ9OG79ixvLWK46B7wSw=;
        b=XNViYEPWf8Ouq/4k2irBaaEcoqwsVhgKIY45nC1h2Bm8Yz4QELiRbOjf+D961Quc3R
         VBZRqtiAMKQJSpuoVMF4g2UzrHIFRKvzBkXtQy/KMToUErbaVt8FMX3Q0OKRM7mKU5r/
         tQuwR8MMlEfBunUgdj7RNnx62fA11dqUYIwVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3X7FWpHmTVcpHXfgsAheG4ZiQ9OG79ixvLWK46B7wSw=;
        b=MbZEFk1Pk8KakIZUn5t1AdhMO1w+B4f3hqj8zk4abPxSZJ6cE7FO1TyY13+HPpDEyQ
         nYJmxbGsk/dKqUrn9MXn3vbVm7h/LWwXr3/Zbg7B9VO88R1M69K/7Jv7u+Zl5A3XfoU7
         f6lXtC4uEBiAD0jNMFqAhFbgRpL+r9X/jsy6MCnX916KRpJgpjxVSGoRzc385EFRKvZA
         HyM1JusJlr9mdxa2C2hfqt7lHnvdqAzdMPLjlPGHKpljij5sF64SaHjX+ue1r1Ibipsx
         qGc3CqzQTgYmgvBkQYd8XWOFfz0VZbRjWhlrcKUZhr3cKDVNVL53iU2GtmR2t3F6TTW4
         q9Vw==
X-Gm-Message-State: AJcUukcbvdUfadQGzZk3Sl4yLYfllBVD/s/BNg1wrGuX96kRkXXisGO7
        tMqyXIUnaRRYr1CBCm9mqhpKJA==
X-Google-Smtp-Source: ALg8bN7vWeNi5PBVQFiiWICw8G/6yLGRvwYizy2YCiPR4JORhVVenJWjrAlcK2J1duvFSb80jtdz5Q==
X-Received: by 2002:a65:62da:: with SMTP id m26mr8407142pgv.278.1547103689853;
        Wed, 09 Jan 2019 23:01:29 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id i5sm15187414pfg.34.2019.01.09.23.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 23:01:29 -0800 (PST)
Date:   Thu, 10 Jan 2019 12:31:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/4] cpufreq: s5pv210: Defer probe if getting regulators
 fail
Message-ID: <20190110070127.ymukpnbabjr5n5fe@vireshk-i7>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-4-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108200509.30494-4-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-19, 21:05, Paweł Chmiel wrote:
> There is possibility, that when probing driver, regulators are not yet
> initialized. In this case we should return EPROBE_DEFER and wait till
> they're initialized, since they're required currently for cpufreq driver
> to work. Also move regulator initialization code at beginning of probe,
> so we can defer as fast as posibble.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 33 +++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index f51697f1e0b3..2d0e4dc7ede7 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -594,6 +594,26 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>  	 * this whole driver as soon as S5PV210 gets migrated to use
>  	 * cpufreq-dt driver.
>  	 */
> +	arm_regulator = regulator_get(NULL, "vddarm");
> +	if (PTR_ERR(arm_regulator) == -EPROBE_DEFER) {
> +		pr_dbg("vddarm regulator not ready, defer\n");
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(arm_regulator)) {
> +		pr_err("failed to get regulator vddarm\n");
> +		return PTR_ERR(arm_regulator);
> +	}

The only difference between the two cases is pr_dbg vs pr_err, its
ugly that we have to add special code for that :(

Maybe write it as:

        if (IS_ERR(arm_regulator)) {
                if (PTR_ERR(arm_regulator) == -EPROBE_DEFER)
                        pr_dbg...
                else
                        pr_err
                return PTR_ERR(arm_regulator);
        }

> +
> +	int_regulator = regulator_get(NULL, "vddint");
> +	if (PTR_ERR(int_regulator == -EPROBE_DEFER) {

Does this even compile ?

> +		regulator_put(arm_regulator);
> +		pr_dbg("vddint regulator not ready, defer\n");
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(int_regulator)) {
> +		regulator_put(arm_regulator);
> +		pr_err("failed to get regulator vddint\n");
> +		return PTR_ERR(int_regulator);
> +	}
> +
>  	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
>  	if (!np) {
>  		pr_err("%s: failed to find clock controller DT node\n",
> @@ -633,19 +653,6 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	arm_regulator = regulator_get(NULL, "vddarm");
> -	if (IS_ERR(arm_regulator)) {
> -		pr_err("failed to get regulator vddarm\n");
> -		return PTR_ERR(arm_regulator);
> -	}
> -
> -	int_regulator = regulator_get(NULL, "vddint");
> -	if (IS_ERR(int_regulator)) {
> -		pr_err("failed to get regulator vddint\n");
> -		regulator_put(arm_regulator);
> -		return PTR_ERR(int_regulator);
> -	}
> -
>  	register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
>  
>  	return cpufreq_register_driver(&s5pv210_driver);
> -- 
> 2.17.1

-- 
viresh
