Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F86C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D475D2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9s71S3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D475D2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756270AbeFSHSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:18:33 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33046 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756012AbeFSHSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:18:31 -0400
Received: by mail-pg0-f67.google.com with SMTP id e11-v6so8748173pgq.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 00:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3RWS3T59xP49kvGCNi7Rt/Vh7Nxj3G7hLDKkzd6bYfk=;
        b=I9s71S3G5WiVubEugqJ01iyRacoHiJOJ2AuRbkVWaj/hSKNKsCZjjr+xJwyHkR2ym2
         ADXcUwALtmFGI/zNxUbkesoIqeOaVdMVvtlPBY0N/aGQrQGCCbQa0f/TuiorViD3rmpy
         t/xP4nG5M+4G1alSeM9T986LHeFNGJ1b6yOIa6P2rY+06NbPGdLwIUQUi3gQw/IccuSO
         WxxM+XxVko85D6Pr+G12iq6MZ4jGpEkKo7M+W2WOJALOEi9DfO4X7TB6Ek7KFhmzgxJE
         Rh1b0zpKc1j18fIpSz1+XaOuFnxANTfI0dQLKFgOsFTaa1ZD1JAwcZgk77n9Cu9Un65L
         ulMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3RWS3T59xP49kvGCNi7Rt/Vh7Nxj3G7hLDKkzd6bYfk=;
        b=Ohw0Blz+JFgK2jX9K9RgIh0dtWXo3f9Bd/ATcAzNWUJypPYOcBSVLS0xEYwsYdCMe4
         NUKsE1NCU+hPhr8OEFW9tXMqMCfSoQrADT7dUeSQLx6Cx3Q8LZNCynNa5z7BILqA1Tmt
         POHslcG7Sh1+OYYb3SCZMo68Uy8siHxk3kX9BnTjJRrQGw4U+RF7Bbsl0ipG0lmPHJyt
         rm9ddKXw9NP4VEm5e6fG2zXJzJrAdJtj/g1lSYrNjUtWuSIqQgT4A1M9IUm9UK3kwws5
         FMKYY7hfisiroLuxho5FK9+QhGJafa08cd/ygEyIt4jgZ4Kr72PlSCjrXICpkbrKtJ0U
         mvNw==
X-Gm-Message-State: APt69E2KnMiKwtD5m5ro6FGrsAg+5WXcRUK8m+S4D5vgwcltj1+dVIBX
        NddSNVPxbJMYP3IgkzyYkOY=
X-Google-Smtp-Source: ADUXVKLvKbUC5tovSRmZGzdro02MNc4/azIM4c8nbd00y6aa0SryWH0Dyl0PFuwzAjmuBC0Q9yGEZg==
X-Received: by 2002:a62:968f:: with SMTP id s15-v6mr16828645pfk.191.1529392710991;
        Tue, 19 Jun 2018 00:18:30 -0700 (PDT)
Received: from kahja.local (c-73-231-184-107.hsd1.ca.comcast.net. [73.231.184.107])
        by smtp.gmail.com with ESMTPSA id o66-v6sm30475556pfi.157.2018.06.19.00.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 00:18:30 -0700 (PDT)
Date:   Tue, 19 Jun 2018 00:18:29 -0700
From:   Quytelda Kahja <quytelda@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        y2038@lists.linaro.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Arushi Singhal <arushisinghal19971997@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove get_monotonic_boottime()
Message-ID: <20180619071828.e3ahbyprthi6i6t4@kahja.local>
References: <20180618150717.1066151-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618150717.1066151-1-arnd@arndb.de>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm fairly sure this doesn't matter functionally (yet), but perhaps
'notify_timestamp' should be updated to an 's64' type since ktime_to_us()
returns a signed type?

That note aside, I think this is good.

On Mon, Jun 18, 2018 at 05:06:50PM +0200, Arnd Bergmann wrote:
> get_monotonic_boottime() is deprecated because it uses the
> old 'timespec' structure. This replaces one of the last callers
> with a call to ktime_get_boottime, which also simplifies it
> a bit by avoiding a double conversion.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 02178e25fbb8..73fc3a742f74 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -233,13 +233,6 @@ static int rtw_ieee80211_channel_to_frequency(int chan, int band)
>  	return 0; /* not supported */
>  }
>
> -static u64 rtw_get_systime_us(void)
> -{
> -	struct timespec ts;
> -	get_monotonic_boottime(&ts);
> -	return ((u64)ts.tv_sec*1000000) + ts.tv_nsec / 1000;
> -}
> -
>  #define MAX_BSSINFO_LEN 1000
>  struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wlan_network *pnetwork)
>  {
> @@ -331,7 +324,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
>
>  	notify_channel = ieee80211_get_channel(wiphy, freq);
>
> -	notify_timestamp = rtw_get_systime_us();
> +	notify_timestamp = ktime_to_us(ktime_get_boottime());
>
>  	notify_interval = le16_to_cpu(*(__le16 *)rtw_get_beacon_interval_from_ie(pnetwork->network.IEs));
>  	notify_capability = le16_to_cpu(*(__le16 *)rtw_get_capability_from_ie(pnetwork->network.IEs));
> --
> 2.9.0
>
