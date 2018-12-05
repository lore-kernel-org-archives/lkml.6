Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E2FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF8E20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIHfsf+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF8E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbeLESg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:36:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55951 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeLESg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:36:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so14266691wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SlcixkDg39GCe2yH6nHy2lFv3vD2jjZEP3UwtHVHMmY=;
        b=jIHfsf+mmVq3mkigjVbWqb07tZZx5BLfZlPqEea0FJJ60ka4pVqBWJrJaPCJqOjPVe
         F4f5MscgG5MVGd3qgzEJbfgM4GV6woeU3BGUyu8uMDwRFMuH4uJJxKxV3Ocgzc7GUN6O
         VgbpOt86QWyBfXoyTdvU1bJNf8xdVdbZUb1HQrZxwiReX5B6DPm1aSAauOKCxasBiYzd
         aswFqkCoVRXf6FL8F7YqiZm8EC97WPPioBZTfb9KPmX3ZQ0NtPkYufr1Kno1zYOEsDly
         /ySaIx8ckrtnc5UevGPm+zIvP62p+lQu7+wfAT6NvBumW92Zv/YNRGaI1vUKjGdH38YD
         ueEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SlcixkDg39GCe2yH6nHy2lFv3vD2jjZEP3UwtHVHMmY=;
        b=C7GrkSAXds97VT+4iXuRWPU29iVgVOUSOWazUawD60l4nEWFFHJifalUmxm8vnftHr
         ZnJ02eqNb4tZVrYxPCdr+MPtGQhfsE7nt3C0dc2jlUhgT+YPyKlSxb9+2wyJz9DkgNlH
         tIHKXDrU9cBDzVSr9Q1QQoPCyrueBaHcZXS620byDzMPfYe7BSiuaMdZRUZe/Y5CP9rl
         jaLF+0xrz4q8v8xYMTuFv8lzQsASsg9kAzupWbbphk43InKYJVA4Tb1hkNGSIOvuFL/u
         jMWtBam9f7YfmV1FLKhKPhj8YN+iuV7a6oJflMbZiH8CICz89dorZXam8tqInwxSOyRu
         rt4Q==
X-Gm-Message-State: AA+aEWbqenK6FFfBEFb0PrCONkNv4C3Q0+8gq7DAdUKgJ3nb9LkzUoFX
        AENANXDRl73ajtBvl99d1sAVYiNE
X-Google-Smtp-Source: AFSGD/WW4/G6x6c+eI5JzIqt+aWUohy/ONGlI06+yM0mBoRtkriyqjDr5Wxkw/Z3yI6n97WWi7Lr0g==
X-Received: by 2002:a1c:cbc7:: with SMTP id b190mr18176917wmg.13.1544035016017;
        Wed, 05 Dec 2018 10:36:56 -0800 (PST)
Received: from ?IPv6:2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba? ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id s9sm19622604wrw.26.2018.12.05.10.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:36:55 -0800 (PST)
Subject: Re: [PATCH 10/12] staging: rtl8188eu: correct indentation in
 update_wireless_mode()
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181205170247.5401-1-straube.linux@gmail.com>
 <20181205170247.5401-10-straube.linux@gmail.com>
 <3799b30191f457cfec945ccc0b91bccf6dd7c63c.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <829c7d0b-22ce-cb47-89a5-e6398508a841@gmail.com>
Date:   Wed, 5 Dec 2018 19:36:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <3799b30191f457cfec945ccc0b91bccf6dd7c63c.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 6:37 PM, Joe Perches wrote:
> On Wed, 2018-12-05 at 18:02 +0100, Michael Straube wrote:
>> Correct indentation in update_wireless_mode() to clear a checkpatch
>> warning. WARNING: Statements should start on a tabstop
> []
>> diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> []
>> @@ -1442,7 +1442,7 @@ void update_wireless_mode(struct adapter *padapter)
>>   
>>   	if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
>>   		update_mgnt_tx_rate(padapter, IEEE80211_CCK_RATE_1MB);
>> -	 else
>> +	else
>>   		update_mgnt_tx_rate(padapter, IEEE80211_OFDM_RATE_6MB);
>>   }
> .
> gcc generally emits smaller code by using a single
> call and a ternary.

Good to know, thank you.

> 
> $ size drivers/staging/rtl8188eu/core/rtw_wlan_util.o*
>     text	   data	    bss	    dec	    hex	filename
>    14974	     36	      0	  15010	   3aa2	drivers/staging/rtl8188eu/core/rtw_wlan_util.o.new
>    14990	     36	      0	  15026	   3ab2	drivers/staging/rtl8188eu/core/rtw_wlan_util.o.old
> ---
>   drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> index 24918223499b..acad30f53f5d 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> @@ -1440,10 +1440,9 @@ void update_wireless_mode(struct adapter *padapter)
>   
>   	rtw_hal_set_hwreg(padapter, HW_VAR_RESP_SIFS,  (u8 *)&SIFS_Timer);
>   
> -	if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
> -		update_mgnt_tx_rate(padapter, IEEE80211_CCK_RATE_1MB);
> -	 else
> -		update_mgnt_tx_rate(padapter, IEEE80211_OFDM_RATE_6MB);
> +	update_mgnt_tx_rate(padapter,
> +			    pmlmeext->cur_wireless_mode & WIRELESS_11B ?
> +			    IEEE80211_CCK_RATE_1MB : IEEE80211_OFDM_RATE_6MB);
>   }
>   
>   void update_bmc_sta_support_rate(struct adapter *padapter, u32 mac_id)
> 
> 
