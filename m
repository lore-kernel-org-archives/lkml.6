Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0668C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D552173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="q9cYzqb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D552173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeI1POc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:14:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35120 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbeI1POc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:14:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id r191-v6so4411311lff.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z+fjqcvq5k4pB+CcSjnXj7pBbIH7Wk2+6VvynKkXzgE=;
        b=q9cYzqb/rLq8Zj5OuI2+3PuRGy3E7sbO/5DT+2Hzn3B3m3G59cgYzyBt0fLczbv2PR
         Zc7VGwm/yz6FPblQT/DpEXnPUkoXuN4dcJCE/GKr6rEcw3fhZH3AVsQij9/7Y+vxMB9V
         JYf7ZLdFIn0rKTa6/CXYhlShOR65nbvbI3Hp53nKhNRZCh/EcxM3xhStlexoK9KZe1uk
         fivT+pL8aRhg655vdhuwg0Q/W+e/VgFW7esbW/p1/nDT954cnt1SLKgo1rstoWHWKQO/
         JdPew2OydEcMghxouelqRcl1ceobxPknZSmXDNlZCLpsEJS2YAf3dWohZU5W0A0QFbew
         uH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z+fjqcvq5k4pB+CcSjnXj7pBbIH7Wk2+6VvynKkXzgE=;
        b=sVU537BQJEDE11OvabtC4pHwL+rdqYnJbXvZZMF+vE1ezPlIPXe3rLTvJbFoIuxhhV
         I7Xs9+MPVdFCHDAgDtI4cnu98X5RwOktzDKFz27aVR2Qi0ODIUWzwYw9M7A8bU8x68gK
         4oTbSi8fEIMyhDSEIgJfiTwe8lC/ZDAMXjJO8ONXEwQTsKSsykX74f0w2eDeYfgcl1Ya
         FEA508C8QzLeUQRwiw2tayh7sVj6W6i3DD30R8HaBwg+z/4Oh75IlcTwARU3OVAo0HER
         Tn+aA1c71e8aHgYqjJ7pXtCLU1id8ZEVEEPLPgYl2wJMGGoxkBxg5+kU3Yt5K2Af8r9m
         XIsw==
X-Gm-Message-State: ABuFfog79hMEH8Zu7JKY2OQkpBVrJRltaKmMLf+qUNnOOFW5eNFbtGLQ
        td+kNP2bcZhGsemtevzNHGVHOA==
X-Google-Smtp-Source: ACcGV60QZ2gzPxz2zALYxzsuK1VP9u+Nb9/wLlbyoXrPn0qLMT4H0GYGWuB04wtcLngmj2XRqz5A7g==
X-Received: by 2002:a19:dd0e:: with SMTP id u14-v6mr10179928lfg.109.1538124707181;
        Fri, 28 Sep 2018 01:51:47 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id r83-v6sm925556lfi.60.2018.09.28.01.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 01:51:46 -0700 (PDT)
Date:   Fri, 28 Sep 2018 10:51:45 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] thermal: rcar_thermal: Prevent hardware access
 during system suspend
Message-ID: <20180928085145.GB24305@bigcity.dyn.berto.se>
References: <20180927113235.30354-1-geert+renesas@glider.be>
 <20180927113235.30354-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927113235.30354-2-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your patch.

On 2018-09-27 13:32:33 +0200, Geert Uytterhoeven wrote:
> On r8a7791/koelsch, sometimes the following message is printed during
> system suspend:
> 
>     rcar_thermal e61f0000.thermal: thermal sensor was broken
> 
> This happens if the workqueue runs while the device is already
> suspended.  Fix this by using the freezable system workqueue instead,
> cfr. commit 51e20d0e3a60cf46 ("thermal: Prevent polling from happening
> during system suspend").
> 
> Fixes: e0a5172e9eec7f0d ("thermal: rcar: add interrupt support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/rcar_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 78f932822d381c9d..ea132e122b174757 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -434,8 +434,8 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
>  	rcar_thermal_for_each_priv(priv, common) {
>  		if (rcar_thermal_had_changed(priv, status)) {
>  			rcar_thermal_irq_disable(priv);
> -			schedule_delayed_work(&priv->work,
> -					      msecs_to_jiffies(300));
> +			queue_delayed_work(system_freezable_wq, &priv->work,
> +					   msecs_to_jiffies(300));
>  		}
>  	}
>  
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
