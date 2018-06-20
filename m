Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC69C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E0320836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXzDxn6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E0320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeFTFaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:30:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38862 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeFTFan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:30:43 -0400
Received: by mail-pl0-f67.google.com with SMTP id d10-v6so1107899plo.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wVEjvg9/auh78Yp7eygOiEd93wKWQFjekJSe/F2LizI=;
        b=VXzDxn6A+FBPFyjpCa8d/BZDqdBFwQemcCUvBoR1VMWTXcAjLx0AWOQOz0xdFalP5M
         fUD88OKlwoQ06dvOS0eTa0/S8sRC1DZDVjBz2MEJkA8N+7hWBCaWe8eoqkcQ8xuwQwMT
         P3KFGgIcQ6aavqC2aC78fiXCPSC0G1cBpxQSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wVEjvg9/auh78Yp7eygOiEd93wKWQFjekJSe/F2LizI=;
        b=ht2CquZKDxgC6wjraBMbnsfgYRWl2Uo9zBzHoj38K2S8JyKpkUDAUX9lM5JGP7rztC
         SFnSMgPs8g0ZgN2uYKLEeVlScQNo/hGzdFXOdv4IyIx4K1GhaKvgrQ5ck1uFN00o4Wzy
         hmERQLmWfRQdFWJSGoTQ/px6cy2hJC9uRVoONArrXco3L6iobRmCC9/HSsPrybKqvhmO
         d0yvpXl+6fG0LaxnSnUqLjgSPTE6hn9hmLsD8/WFmHopM4O/ICmaHc8YG20fbsnhbocd
         EXvoDpNst/p44VslWQ9GjrUUL8ocSWI/xDWGOPkrqiCpX4mpN1RRlyg8qSE6u+KyYmFP
         m/bA==
X-Gm-Message-State: APt69E1q6Q7AzTR+RCpdhbYzyFj+z4oYGnpH1zPZl88CrRWS9+2iuyJy
        ppqyyml7AYRkYbdwJPqRySX95A==
X-Google-Smtp-Source: ADUXVKIeKGOqvOHrNhbNyUgVQqqqIBM3stLR8iIM1uFGL06u2RoZTMcWCRSGJGKW8NFI9NKcc7UKfg==
X-Received: by 2002:a17:902:14b:: with SMTP id 69-v6mr22100964plb.184.1529472642885;
        Tue, 19 Jun 2018 22:30:42 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v13-v6sm2473810pfa.131.2018.06.19.22.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 22:30:42 -0700 (PDT)
Date:   Tue, 19 Jun 2018 22:33:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH V3 6/7] backlight: qcom-wled: add support for short
 circuit handling
Message-ID: <20180620053300.GJ15126@tuxbook-pro>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-7-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529406822-15379-7-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:

> Handle the short circuit interrupt and check if the short circuit
> interrupt is valid. Re-enable the module to check if it goes
> away. Disable the module altogether if the short circuit event
> persists.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 130 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 127 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
[..]
>  struct wled {
>  	const char *name;
>  	struct device *dev;
>  	struct regmap *regmap;
> +	struct mutex lock;	/* Lock to avoid race from ISR */
> +	ktime_t last_short_event;
>  	u16 ctrl_addr;
>  	u16 sink_addr;
>  	u32 brightness;
>  	u32 max_brightness;
> +	u32 short_count;
>  	const int *version;
> +	bool disabled_by_short;
> +	bool has_short_detect;

The use of feature flags, instead of checking the version, like this is
good!

>  
>  	struct wled_config cfg;
>  	int (*wled_set_brightness)(struct wled *wled, u16 brightness);

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
