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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB58C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FCF214C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lat0Q/m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FCF214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeIWMkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 08:40:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36335 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeIWMkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 08:40:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so13789205edq.3;
        Sat, 22 Sep 2018 23:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+aASfUH4P9hk54OhxTyjz/Fmh3PnRmgcc6bV888S9zA=;
        b=Lat0Q/m6tMFBjlo0tekH/a9GJwTxkQG0VZR/20AOILMqdPRiM4xdFZVQd3qw27hXuF
         H7z7+9kZGOb10AdLjMPIpOvS2+205aso8OSODxXQurh8pD9TIGwjU2g2o3gO0CZCiVtd
         ZV/CaKl7/V9W+k1ely6uWWCBgURwXXQofzTgvscyB5sFq5LCGd35mqsjKIfHsmJ7/PNo
         MWDRWn8VE41DLUFyDJURQ2n7j93DWejjN0rJgK81REmutfxlOetUv2841EH/4cKu8Wyv
         yQqVE3z7QBZfKq/AhW5Sp9vBVmOeqT2hVC/IZ2OnTmtHzyrnCip/3/5R9Ry0e5QCiTPQ
         esAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+aASfUH4P9hk54OhxTyjz/Fmh3PnRmgcc6bV888S9zA=;
        b=QtXOvudsoG59215aOanfwDAkuKCWJljNdzB9QWHe5ZJ+E6i9LXYBmtGf9khdiFPMKz
         WUE95S4GaYtCxAW687TexQvyYnC9wauWV8Vmw6n/ZJ6NO2yVa3hgSwNvL+h+70qBsOXr
         9C6QkABp5/ITB520dRfL5x+N5Jo0WqmwQeKxKfaIuRGWDV5xF8Irk9UjYVQT7ler9ya+
         n37WFA1rfEkKJpaU8m+DWFFvjaVrFmiAEdOiQOQ+z9cGZcgSKvoDkPSVGbONgeGVnAl2
         1IDQNHFq9Tcj/HuiulS8hT9aQMYdbsXph4bzRsBFPxcwyUvRbQI8IXF9caVpK/XVsehi
         79Pw==
X-Gm-Message-State: ABuFfogo3OR1ls6tMaNb+6LyeZkjzufrJqAfYNH5vEO11Gfrus7QEiaO
        ZY+vMuDdZfhOE5AmTldOTFM=
X-Google-Smtp-Source: ACcGV63qvCZUjHpekrJsGPKBdhbTCmLFy2L2SznXy4s/RIrQ0FHn7l2F5Ni7Oo53CueM/jBlf2E7aw==
X-Received: by 2002:a50:e68c:: with SMTP id z12-v6mr8136483edm.275.1537685021351;
        Sat, 22 Sep 2018 23:43:41 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id d11-v6sm5232367edo.39.2018.09.22.23.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 23:43:40 -0700 (PDT)
Date:   Sat, 22 Sep 2018 23:43:39 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtlwifi: btcoex: Use proper enumerated types for Wi-Fi
 only interface
Message-ID: <20180923064339.GB12338@flashbox>
References: <20180921220824.18344-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921220824.18344-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 03:08:24PM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
> 
> drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c:1327:34:
> warning: implicit conversion from enumeration type 'enum
> btc_chip_interface' to different enumeration type 'enum
> wifionly_chip_interface' [-Wenum-conversion]
>                 wifionly_cfg->chip_interface = BTC_INTF_PCI;
>                                              ~ ^~~~~~~~~~~~
> drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c:1330:34:
> warning: implicit conversion from enumeration type 'enum
> btc_chip_interface' to different enumeration type 'enum
> wifionly_chip_interface' [-Wenum-conversion]
>                 wifionly_cfg->chip_interface = BTC_INTF_USB;
>                                              ~ ^~~~~~~~~~~~
> drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c:1333:34:
> warning: implicit conversion from enumeration type 'enum
> btc_chip_interface' to different enumeration type 'enum
> wifionly_chip_interface' [-Wenum-conversion]
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

> Link: https://github.com/ClangBuiltLinux/linux/issues/135
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  .../net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c   | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
> index b026e80940a4..6fbf8845a2ab 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
> @@ -1324,13 +1324,13 @@ bool exhalbtc_initlize_variables_wifi_only(struct rtl_priv *rtlpriv)
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
