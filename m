Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADB1C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0300C214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFHg6W42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0300C214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeIWMjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 08:39:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40450 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeIWMjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 08:39:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id o2-v6so405852wmh.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 23:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t9FpwINqwV+0p6yIykgWy4H8DNo21Ic8pF3k2EWwHtY=;
        b=lFHg6W42KKrChOckjjN5Wap8Lv0ywaFvbRPjT0b3z2mY54XpCB4V/ZPzMpu6/ptg17
         UuOuhqzyspGYWJqVJghb91kc9UOqaupFtQM/PBAsc1CefjhZIGvTIZZbZf22Cn1R/796
         /nCvMJScBaKZvw0NeBMcasA/yYtokBcvkyy3A5oZBJm5+94iUU2dBhcTUxCYKqHOe18o
         rce8o8zbme72khV4Mx7FC1tHit6gwTJeI0PXemZxysq49aqSNfOtfSY6G8oV9QkS5uwo
         8DfT6l6qkBX5FSo9XpMsn5EfJvLUhiWMYkxM2fy4HRpivkG094ZB7WGePqNDvLY/FSn+
         9WPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t9FpwINqwV+0p6yIykgWy4H8DNo21Ic8pF3k2EWwHtY=;
        b=graCQG8idnRszG4/9+/b4VrRvi4FFl4bgPfznm2ZKN7unpzxyMTvcOL4efVOhXnvEO
         dKAx1mhvGRPU6eOYcka67xI2Wf0k7RCUinfSVeTcbIUhoIavCliixGMNPh96Dmq9ZoUZ
         4uFumimFRYmljsUTxn5Nw8+LDkY1D7R5b4lr8gYSHwU/S7y4skh/fePri8yROKfmR354
         rslZhIrnmjJHfeP/gp5pjejiaul+EJbt7qo5ReK+H42KALEG4y9tIEp6nZiA1844Rfdv
         0ITAp2SuiSfOMta+JAS+jRTZwpFikaTOddTRqfr50O8/tECY1HinEWBCmJlz9nCBhXpQ
         /EdQ==
X-Gm-Message-State: ABuFfog0EFoAcG/dctDqlTIkwiPxofUZoDakr/LiuPmnQaZ0qcyIchth
        VglgQSwOMhuFRchKQAmnzAs16pszdQ0=
X-Google-Smtp-Source: ANB0VdbPj2c+SjkkM+amQRNPYjKlzpHmaf8yhRy9S4ue2vwTSr++wp6Xmwcgy+QBu28eqF8IcIHwYg==
X-Received: by 2002:a1c:dc45:: with SMTP id t66-v6mr3387744wmg.148.1537685004709;
        Sat, 22 Sep 2018 23:43:24 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h17-v6sm26878113wrq.73.2018.09.22.23.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 23:43:23 -0700 (PDT)
Date:   Sat, 22 Sep 2018 23:43:22 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtlwifi: Use proper enumerated types for Wi-Fi
 only interface
Message-ID: <20180923064322.GA12338@flashbox>
References: <20180921221202.20448-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921221202.20448-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 03:12:02PM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
> 
> drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c:1264:34: warning:
> implicit conversion from enumeration type 'enum btc_chip_interface' to
> different enumeration type 'enum wifionly_chip_interface'
> [-Wenum-conversion]
>                 wifionly_cfg->chip_interface = BTC_INTF_PCI;
>                                              ~ ^~~~~~~~~~~~
> drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c:1267:34: warning:
> implicit conversion from enumeration type 'enum btc_chip_interface' to
> different enumeration type 'enum wifionly_chip_interface'
> [-Wenum-conversion]
>                 wifionly_cfg->chip_interface = BTC_INTF_USB;
>                                              ~ ^~~~~~~~~~~~
> drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c:1270:34: warning:
> implicit conversion from enumeration type 'enum btc_chip_interface' to
> different enumeration type 'enum wifionly_chip_interface'
> [-Wenum-conversion]
>                 wifionly_cfg->chip_interface = BTC_INTF_UNKNOWN;
>                                              ~ ^~~~~~~~~~~~~~~~
> 3 warnings generated.
> 
> Use the values from the correct enumerated type, wifionly_chip_interface.
> 
> BTC_INTF_UNKNOWN = WIFIONLY_INTF_UNKNOWN = 0
> BTC_INTF_PCI = WIFIONLY_INTF_PCI = 0
> BTC_INTF_USB = WIFIONLY_INTF_USB = 0
> 

I have sent a v2 making these values correct.

I will make sure the '--in-reply-to' option in the future.

Nathan

> Link: https://github.com/ClangBuiltLinux/linux/issues/171
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c b/drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c
> index 4d1f9bf53c53..85a7490e6bbd 100644
> --- a/drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c
> +++ b/drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c
> @@ -1261,13 +1261,13 @@ bool exhalbtc_initlize_variables_wifi_only(struct rtl_priv *rtlpriv)
>  
>  	switch (rtlpriv->rtlhal.interface) {
>  	case INTF_PCI:
> -		wifionly_cfg->chip_interface = BTC_INTF_PCI;
> +		wifionly_cfg->chip_interface = WIFIONLY_INTF_PCI;
>  		break;
>  	case INTF_USB:
> -		wifionly_cfg->chip_interface = BTC_INTF_USB;
> +		wifionly_cfg->chip_interface = WIFIONLY_INTF_USB;
>  		break;
>  	default:
> -		wifionly_cfg->chip_interface = BTC_INTF_UNKNOWN;
> +		wifionly_cfg->chip_interface = WIFIONLY_INTF_UNKNOWN;
>  		break;
>  	}
>  
> -- 
> 2.19.0
> 
