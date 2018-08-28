Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C042DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428842087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsspPom5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428842087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeH2Aa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:30:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46240 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeH2Aa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:30:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id a108-v6so2733991wrc.13;
        Tue, 28 Aug 2018 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G+A+K40XdK+l9Obs2EooWbLOTs6QBLllS8qbbxu4G+A=;
        b=RsspPom5cZbeBu8X+Z54eNmu5GFCEu/TK2SeL+3hnhWa0W83vnoqd7qQo+I5bzGEiJ
         9EV/7dZPwoery+we84VqgBth1jn3XgsO7BpHNwv5u0/LS8Nw/5FPcyT68/TB11pUbhjo
         JYSVnqRZEv8R9VvRvSWvpOePQfimZkmnVak8qlwFvJSJEkIPtBScpvPs1HZfFoNS7Btn
         bSedCe3f/cs6gg725cZgq2zuctb1EHgXiUiiXFDOpMoBwG8aeB7hivpiGwDsoqPhRNZF
         mZPGD7BwI3BJdyGUv1DpUBcn9vZTirI3MXZaQqTUtS0Ml5tRYAhm/XqQOmajrhr77ng7
         98YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G+A+K40XdK+l9Obs2EooWbLOTs6QBLllS8qbbxu4G+A=;
        b=evuHitkfiQ82bAALhjmwt3M9HTjyFospVXGzY86+sDdnkHIexLxRD+Mep8LqxzbjMh
         exqOsBdpdU3B/2xRNS33CXcOIPz50+TBG6KlxJGC/DDlv6rNI2tYq4+xnWCVl37PLroF
         blDV0Ef5zt0ADu5b80hFj3itVdsgcj8n9xPPkrw71hJea6SPezF7tEx3XPMkPyG4Eoz8
         YamXdBzdZC63DlqRdQrS/uiBrsd+24cxXdZGzQKSkcwL6BsOG3W1oITkq7HQSZDKwnLg
         Qgj+mYWYV34WCbOanVol+4gir2HUL2T3F2cpg4dTeubLMa3xrDuNIZH26kCn6IQJoTp0
         pQfw==
X-Gm-Message-State: APzg51Apl/3YvDh90O9pJBiN4qMu8twYputOJfA7TXZwshFNUIDfL3ZB
        vSSTwOhfCq5Rb7mzXjlda9hKgnQE
X-Google-Smtp-Source: ANB0VdZ5zl4KviJfPmT6tUFZByIQQIIKy1t9TBACv/xfvzcKH0wm05SuIgwkVfOVC8Cg5av9TD1oww==
X-Received: by 2002:adf:a292:: with SMTP id s18-v6mr2378366wra.100.1535488626443;
        Tue, 28 Aug 2018 13:37:06 -0700 (PDT)
Received: from [192.168.1.18] (bla118.neoplus.adsl.tpnet.pl. [83.28.194.118])
        by smtp.gmail.com with ESMTPSA id u40-v6sm4024420wrc.43.2018.08.28.13.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 13:37:05 -0700 (PDT)
Subject: Re: [PATCH] leds: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@iki.fi>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-25-robh@kernel.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <5e5ea614-5242-eabc-2e4a-aa20432a4a12@gmail.com>
Date:   Tue, 28 Aug 2018 22:37:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828015252.28511-25-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On 08/28/2018 03:52 AM, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Sakari Ailus <sakari.ailus@iki.fi>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-leds@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/leds/leds-as3645a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/leds/leds-as3645a.c b/drivers/leds/leds-as3645a.c
> index f883616d9e60..98a69b1a43f9 100644
> --- a/drivers/leds/leds-as3645a.c
> +++ b/drivers/leds/leds-as3645a.c
> @@ -529,7 +529,7 @@ static int as3645a_parse_node(struct as3645a *flash,
>  		strlcpy(names->flash, name, sizeof(names->flash));
>  	else
>  		snprintf(names->flash, sizeof(names->flash),
> -			 "%s:flash", node->name);
> +			 "%pOFn:flash", node);
>  
>  	rval = of_property_read_u32(flash->flash_node, "flash-timeout-us",
>  				    &cfg->flash_timeout_us);
> @@ -573,7 +573,7 @@ static int as3645a_parse_node(struct as3645a *flash,
>  		strlcpy(names->indicator, name, sizeof(names->indicator));
>  	else
>  		snprintf(names->indicator, sizeof(names->indicator),
> -			 "%s:indicator", node->name);
> +			 "%pOFn:indicator", node);
>  
>  	rval = of_property_read_u32(flash->indicator_node, "led-max-microamp",
>  				    &cfg->indicator_max_ua);
> 

Applied.

-- 
Best regards,
Jacek Anaszewski
