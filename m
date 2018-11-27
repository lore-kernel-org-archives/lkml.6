Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640A1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E46421104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAhrMOIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E46421104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeK0PBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 10:01:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39372 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbeK0PBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 10:01:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so8649207pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 20:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xjSKOjprZfgE13dg/nCPDqaYaS17OcldV3iZ/BRDES0=;
        b=UAhrMOIzDjxqhEDYPaEoiC37Fdb8L9kZ3nLZwck/X0re46e9MaSjg4k4EYPdMsC9VW
         FuweqeBf2BYzn0fQApRKqTx1vVSAgXeScod3VkQDsxrp+JQ9NqHei0ZKQUKOHaUB7tq3
         c1ekRcd6bR95jnAjnjYP008vkV+yXSzjcpIrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xjSKOjprZfgE13dg/nCPDqaYaS17OcldV3iZ/BRDES0=;
        b=M0JDufjyBg6ot1dKe/1ZEkLgzLAImafHutqRe3qgk+wH/D7zDImIBXsg5YK25A5PDE
         cSRvL7XSeAMZ6+EIyThZjrXDfOalQJvXYWd3AmkbiAeiqsVhooO2wejbVIgetat+gXma
         rnO9XpbjmFxntdzEkUvAPtBOwx4WK0T/J9yJUrrbhfnOpJ92fyItoDsTevbr+voh8K9R
         Lyd6JwstVhNJyKxvAT2NkvZ3ix2skemKMkt/+dhEeUeHMygwt+vI9USU1IPt5W5eiTAS
         1ivM5I939s8F7B3mhHT8CF3glDY0O5ZYj+p6lNkZQLORQ6ePtsLUYnrZuAnYuj8hZ/Yo
         Ytww==
X-Gm-Message-State: AA+aEWY/PySudJiitMj7TdKS59St1MMFMYeAWHeeanUYSuBCrPEOoVhn
        wvUGR1M8tXb0CNATrRXkiVoK/w==
X-Google-Smtp-Source: AFSGD/V1R3IdlMEp8wb16WPTKOQjvIL4Af5xGHUHbM6HnMyMwFnih70fK8pOD8blA50EocXur7mFSQ==
X-Received: by 2002:a17:902:7686:: with SMTP id m6mr31438684pll.179.1543291505558;
        Mon, 26 Nov 2018 20:05:05 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id h8sm2421453pfo.162.2018.11.26.20.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 20:05:04 -0800 (PST)
Date:   Tue, 27 Nov 2018 09:35:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OPP: remove some duplicated includes
Message-ID: <20181127040502.rzj2rdy3jxre5bck@vireshk-i7>
References: <20181126131838.30891-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126131838.30891-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-11-18, 08:18, Yangtao Li wrote:
> Some header files are included twice.It's unnecessary,
> so just remove them.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/opp/core.c          | 2 --
>  drivers/opp/cpu.c           | 1 -
>  drivers/opp/debugfs.c       | 2 --
>  drivers/opp/of.c            | 1 -
>  drivers/opp/opp.h           | 1 -
>  drivers/opp/ti-opp-supply.c | 1 -
>  6 files changed, 8 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2c2df4e4fc14..31fc2cbb9d1f 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -15,9 +15,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/errno.h>
> -#include <linux/err.h>
>  #include <linux/slab.h>
> -#include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
> diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
> index ab6d07e78945..778ac771ce93 100644
> --- a/drivers/opp/cpu.c
> +++ b/drivers/opp/cpu.c
> @@ -15,7 +15,6 @@
>  
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> -#include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index e6828e5f81b0..05670aeebecd 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -11,8 +11,6 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/debugfs.h>
> -#include <linux/device.h>
> -#include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/limits.h>
>  #include <linux/slab.h>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 5a4b47958073..ea510e350682 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -15,7 +15,6 @@
>  
>  #include <linux/cpu.h>
>  #include <linux/errno.h>
> -#include <linux/device.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/slab.h>
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 9c6544b4f4f9..558c5e638d97 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -20,7 +20,6 @@
>  #include <linux/list.h>
>  #include <linux/limits.h>
>  #include <linux/pm_opp.h>
> -#include <linux/notifier.h>
>  
>  struct clk;
>  struct regulator;
> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
> index 3f4fb4dbbe33..b1d7442960e3 100644
> --- a/drivers/opp/ti-opp-supply.c
> +++ b/drivers/opp/ti-opp-supply.c
> @@ -13,7 +13,6 @@
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/notifier.h>
>  #include <linux/of_device.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>

AFAICT, none of these files have included any of the files twice directly. Yes,
they may have included some .h files (like opp.h) which may have included files
like err.h, etc. But that is fine. Each file in kernel should normally include
all its dependencies directly and should avoid depending on other .h files to do
so.

For example, kernel.h includes so many .h files, like types.h, etc. Should all
files that include kernel.h stop including types.h directly? What will happen if
kernel.h stops including types.h in future? Many other files will stop building,
because they indirectly depended on kernel.h which is incorrect in my opinion.

-- 
viresh
