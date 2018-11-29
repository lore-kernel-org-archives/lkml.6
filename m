Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F2FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFB620989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbWJtWxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFB620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbeK3Dpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:45:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34928 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729218AbeK3Dpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:45:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so1179903pgs.2;
        Thu, 29 Nov 2018 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wvuj5phS+65e2e0XJ3PsiwSsJXk2zry6FxKDNmUOpkw=;
        b=fbWJtWxDu/bHFvP62TYrG2/FMK+RJ7LXuHeOAaPc1JzTH0FhfvR2/AjYLXL98voFDZ
         OMrEjythFo3F6lI7vkC79darUlFhvlgftAx+zWZYz+MLLgTViM4TxzBEF2WvAhUDT+Kr
         IuiYxab032rvUV96FSogMGquPpPxc0zghxCUEslF/rSmZweHy/YktN6CyHtKqWoBh0sH
         rBBgURz630IlZHr/nsCcV5ZczfY/L+9z5w5LTw7VZzZlX8FbHPOZB8ssI5/R71tnvJAD
         HmmA38N+hPhsxOSvuPVN7j+XqoBDgjLaCyEEbj0hAry2eIeuQZNGY/VpjZ8wFz/0d3QQ
         rIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wvuj5phS+65e2e0XJ3PsiwSsJXk2zry6FxKDNmUOpkw=;
        b=bIoVRnwhVJC9z20zYoD+NRWsLlrKuqu5h7xGhCn7Rh1o00fHZufxj7xs45oAc+YbRG
         TZn6S5xObcDUyGqIR90XyGj6nd1iDg2CbdqImjqVGdt1zmZsWTYiat1O+LYg5G34DOeB
         iluUya40tORfYT6yLMgD1wMfPCW+komxoG+gjF6KBr78H+FrJrcRHFVJ+lrcvqp5N34j
         ThWxlJ9XOCQHQv9x4Wkxgf5bMLcyWsHSjq0saVzLvf6JKKxCCNzdG/kEyK835VW8IrCN
         Nl0gbDUDJo/B06M+cTQme1mh811GI0ebM5DF3E8ORfq94lp7VKGbUQ/D6OMHeZkY9PFH
         BDDA==
X-Gm-Message-State: AA+aEWbsqmqB2sJLqNFihamxbSU/KWCadtuPqU3vs/Uy7uY1NGEPlQHn
        NO9qAhAYri/VEwrXq1XCkNY2EHDV
X-Google-Smtp-Source: AFSGD/WCn4aVax4RCdmO68lLRE/gPE1PZVdojN3GJziYPxNuBleIFkTQIL4g8U/Wmg8q6fQKTvHX5A==
X-Received: by 2002:a63:e655:: with SMTP id p21mr1807455pgj.70.1543509582413;
        Thu, 29 Nov 2018 08:39:42 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id o8sm9932411pfa.42.2018.11.29.08.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 08:39:41 -0800 (PST)
Date:   Thu, 29 Nov 2018 08:39:39 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     thierry.reding@gmail.com, daniel.lezcano@linaro.org,
        linux-tegra@vger.kernel.org, rui.zhang@intel.com,
        srikars@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] thermal: tegra: remove unnecessary warnings
Message-ID: <20181129163938.GA2045@localhost.localdomain>
References: <1543486183-2868-1-git-send-email-wni@nvidia.com>
 <1543486183-2868-2-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543486183-2868-2-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Thu, Nov 29, 2018 at 06:09:41PM +0800, Wei Ni wrote:
> Convert warnings to info as not all platforms may
> have all the thresholds and sensors enabled.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index ed28110a3535..55cc1f2f6a45 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -550,7 +550,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>  
>  	ret = tz->ops->get_crit_temp(tz, &temperature);
>  	if (ret) {
> -		dev_warn(dev, "thermtrip: %s: missing critical temperature\n",
> +		dev_info(dev, "thermtrip: %s: missing critical temperature\n",

I am mostly ok with your change in direction. But are you sure this is a
good thing? What about in the case that you have a platform that have
the crit temp and you really failed to .get_crit_temp()?

>  			 sg->name);
>  		goto set_throttle;
>  	}
> @@ -569,7 +569,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>  set_throttle:
>  	ret = get_hot_temp(tz, &trip, &temperature);
>  	if (ret) {
> -		dev_warn(dev, "throttrip: %s: missing hot temperature\n",
> +		dev_info(dev, "throttrip: %s: missing hot temperature\n",
>  			 sg->name);
>  		return 0;
>  	}
> @@ -600,7 +600,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>  	}
>  
>  	if (i == THROTTLE_SIZE)
> -		dev_warn(dev, "throttrip: %s: missing throttle cdev\n",
> +		dev_info(dev, "throttrip: %s: missing throttle cdev\n",
>  			 sg->name);
>  
>  	return 0;
> -- 
> 2.7.4
> 
