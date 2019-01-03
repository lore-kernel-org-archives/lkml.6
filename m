Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F74C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C9B217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBuB+iF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbfACQsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:48:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45252 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfACQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:48:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so34147060wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fmbSboZHFWhp/uT/+ryl+tQKCOAPQCLqZmbVT0XJNGc=;
        b=UBuB+iF5JClrhSkikhN13WRh86RFgFE/8tU/lfmNZRugQQc8PGwl+v5wQjhrf3VieC
         BgVbz/KvD6MIm0sO9atKwqe/HqnjrlnxHbseGdnhgx3zhoECLQrfM3UDZOxg4BQMdpJl
         BniE27MmAtjyKhMur7hjt7LuMNcVpJiAoCBZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fmbSboZHFWhp/uT/+ryl+tQKCOAPQCLqZmbVT0XJNGc=;
        b=JimBGBZAS+6Vqh71e34NOk5cPdZNKZxgF6B6znUiQVghX8e80XTK2PQB4wNGf7SjrF
         +gmhTU/1hlto8rLTBc1X3gKTp36UYIRjbAJTFTRoWyEtlC8ZtfxeqLdj0P4dE4nvxpe/
         pr8vlBjLBz9xzXVxzATugJ9WyJrp6iuhfh1uXvp7qxRL4RNVaMiV9H2OZFY25YbCeZ2D
         ORaW804w71GDe34hOt1MvKD5niQcaCf39gRV9IBoq5203CUdPD0pqWEuIHUigXNvgzc2
         gQjQgOjSpKlZ6eV/7zYA2SFu/s92AXdACI6Zpo2OXMcL6jHlZy4HNhak76VvxYn26C2b
         QZjA==
X-Gm-Message-State: AJcUukfZ0AwdJAm5+wc3NvMarJS+shOZWiP0qzdyl3Ov+WVINXdFdksQ
        FW/gzowHFKQhuMnhE04IenZ3rQ==
X-Google-Smtp-Source: ALg8bN5TSm4IHF2kDqn66noJtwPFDeYxYD1bHTvZqmROvK7O/F/EE06XsTg64WOZ7hTMP05YV42soQ==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr39453058wrd.20.1546534107648;
        Thu, 03 Jan 2019 08:48:27 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s1sm67391354wro.9.2019.01.03.08.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 08:48:26 -0800 (PST)
Date:   Thu, 3 Jan 2019 16:48:23 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: (adp8870) fix a missing check for
 adp8870_write
Message-ID: <20190103164823.sfehxd6mkwaxiaxf@holly.lan>
References: <20181225062109.66943-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181225062109.66943-1-kjlu@umn.edu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 12:21:09AM -0600, Kangjie Lu wrote:
> adp8870_write() may fail. This fix checks if adp8870_write fails, and if
> so, returns its error code.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/video/backlight/adp8870_bl.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
> index 8d50e0299578..79901fb4fcd1 100644
> --- a/drivers/video/backlight/adp8870_bl.c
> +++ b/drivers/video/backlight/adp8870_bl.c
> @@ -811,9 +811,14 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
>  		if (!ret) {
>  			reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
>  			reg_val |= (val - 1) << CFGR_BLV_SHIFT;
> -			adp8870_write(data->client, ADP8870_CFGR, reg_val);
> -		}
> -		mutex_unlock(&data->lock);
> +			ret = adp8870_write(data->client,
> +					ADP8870_CFGR, reg_val);
> +			if (ret) {
> +				mutex_unlock(&data->lock);
> +				return ret;
> +			}
> +		}	else
> +			mutex_unlock(&data->lock);

Please don't unbalance the lock paths. Instead check the value of ret *after*
the existing mutex unlock (which will also means that the failed
adp8870_read() isn't silently ignored).

Also there's not much point in fixing this site without also fixing the
missing return checks on adp8870_set_bits() and adp8870_clr_bits() in
the same function.


Daniel.


>  	}
>  
>  	return count;
> -- 
> 2.17.2 (Apple Git-113)
> 
