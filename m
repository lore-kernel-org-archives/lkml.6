Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86331C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B372175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxSWDdMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBGEgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:36:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39610 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfBGEgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 23:36:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id f132so1927643pfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 20:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RsXSbB+Bjl+cSk9pwJ6L5xDb66kE12kgkww+d+U/sWs=;
        b=jxSWDdMnFuRUNbyCsSvxMKbdmGu33k4J4gU9igkwLne+o1ComGaKf31ZPIvt4yvUCk
         PZsagSqKTOW+Itj58/M6Co1pw+8XmSdwKmi74oqRlPbeFbTALSqJGzldQCfaL+lnzXQT
         jYM9rG2L7u4MnEgb+6WcIholSNpgvm/KSW3jzH5QwFOfRqqYSHfEmZKU3d+kZpzwEtv1
         DGyGH+dA6hyF5/bn8cQ6OsRQbWKQGcBTZbE/ibMQiznHKuFFcPePgbCr67ZQMZ7XCXWz
         AA6D54JiDJIJ9N2tUqVyueRcdyHFd5RyJ3a/U6NpA61Qii0nQ7Fto8orkQ+PsIfNtDAl
         SxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RsXSbB+Bjl+cSk9pwJ6L5xDb66kE12kgkww+d+U/sWs=;
        b=IM/z5dPiOsWThYW355o4lUH1IBwPyOlriEZbaYbKO20WEiadZ0zjAwnxFQ6nSNs7mt
         wk5FdeRrOfwvFA4mQ1uZyxrAleXQi/NjN5ucZU3yoAygWeDLfEScN/IVhYHbKD95a/zT
         FsDZ8QyALwrDMQODr3NEfRoAVW2rZxCzA/Xt72nV2xuaEdsRmmF9QwrUMYZLR65xavat
         S5rwTT1BscCfLbzFlraINZpQrAsQPpvKhEAwApzAJjo8SENym9bSgHG1d0c+5a9wJi/M
         oaGVy+ceTFkyw16RKLbIQqW5DNGfreS0/I1IVfd9duYTeLg4XwsRn5xn3NEmTzn03/Ga
         iZoQ==
X-Gm-Message-State: AHQUAuY984tUFavySooOtX5dr7o223DZSI6BBq416T1OCbOPq6gtI/mc
        V46RUWWst/WxMZRsQ5Tfr5a/1A==
X-Google-Smtp-Source: AHgI3Ia3Va5ooa3J/3btynNGsO33ZRUhsUzQ7Ac2pTOMXShH4o8Hj4yjIWx33kWnxN/9ngMQB3ZonQ==
X-Received: by 2002:a63:f241:: with SMTP id d1mr13194289pgk.2.1549514173610;
        Wed, 06 Feb 2019 20:36:13 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id v184sm12093970pfb.182.2019.02.06.20.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 20:36:12 -0800 (PST)
Date:   Thu, 7 Feb 2019 10:06:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Quentin Perret <quentin.perret@arm.com>,
        Taniya Das <tdas@codeaurora.org>, CK Hu <ck.hu@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] cpufreq: mediatek: Register an Energy Model
Message-ID: <20190207043610.dy5nf5e3vujtmzgn@vireshk-i7>
References: <20190206185004.54779-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206185004.54779-1-mka@chromium.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-02-19, 10:50, Matthias Kaehlcke wrote:
> Try and register an Energy Model from mediatek-cpufreq to allow
> interested subsystems like the task scheduler to use the provided
> information.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - register the EM after setting the cpumask
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index eb8920d398181..5250df762814e 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -465,6 +465,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>  	policy->driver_data = info;
>  	policy->clk = info->cpu_clk;
>  
> +	dev_pm_opp_of_register_em(policy->cpus);
> +
>  	return 0;
>  }

Applied it after rebasing over the change in cpufreq/arm/linux-next
branch. Thanks.

-- 
viresh
