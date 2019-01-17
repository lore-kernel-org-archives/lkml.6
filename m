Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575FCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E29B20868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/eHqSaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfAQURI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:17:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33088 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbfAQURH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:17:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so1897295wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NmfhQLcizwgYhnzBNmceH8gReZHIlQyVocW7LLwjve4=;
        b=s/eHqSaLDNY8QU7QLvhhLiJYf0yO5SyxEssVjvvKGAsuXrhoId2gvrBoLZR8UWvQYE
         hv+TFaeE1tej7lB89hLEbNB54HXO1Lnb9dhoe46FulzLcxGXm7G8I9mvcHB9B+WdUyp6
         Cp6eYuVxX78Wv3kOQDuS78QLOuRABRoHgLwozEGIwDho8qKbV1iGKyvut2oMB0pvCNzc
         h0QZNsVwQawRoivQji8cZ40XlP2v3jtf1oXuKahndqDo71VMFZIIiwSAl9vSeVbdGm5l
         CtBFIB6AUJR7WCUbpAIKbDZoe22Lg/RJO8vnCPm0cLh72zyhXYkGlA3UijObI6bCC+yX
         M6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NmfhQLcizwgYhnzBNmceH8gReZHIlQyVocW7LLwjve4=;
        b=K5cWJf1m4vEb1upoC4Zifu00onYqjZyeQxaOTnx6soxm9MxdyviTlBDdi3TAUF4yZo
         /HCsBOd2ugba5NNfIY2koAW/kF2PZFDu0MOu8YkL2/lz3fbf74HBkiSu51i8eiGTsrR3
         fWvWs4oHoiTBYxu08cYIHUJIVeNbtSCg1s4fL80K4O3V84N92Lx6u/Xr5UV8Y3nG67Gv
         iRvkorzUn9O3VoPmGPRCNq2v2Ia7Y/E0maCcLVnHnhZZqi35Unt2j3Bm36hENYBBysmc
         xMzB+fP8s333HB//ZwECHj5tYuYPYOZDJ9WasIU0rSwqRqVeYnhjcQ9rIny+JuqijfWM
         bQcQ==
X-Gm-Message-State: AJcUuke7S62nNPxlSPJIgvK0MNWuAKLQCrHGTl3jqIiKbT70WDMbmi7a
        JE/dqrytGkmsqvThqxmguRAEkOy3Zgw=
X-Google-Smtp-Source: ALg8bN6Z6Xz9jBwuiUNlgLaKVAGESinXVuQDdKxhNL1mwBU3CZRxmfdmeyTBXQyFKyEPOOAet1i/lQ==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr13335501wmi.10.1547756225201;
        Thu, 17 Jan 2019 12:17:05 -0800 (PST)
Received: from ?IPv6:2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba? ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id k128sm52000405wmd.37.2019.01.17.12.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 12:17:04 -0800 (PST)
Subject: Re: [PATCH 2/2] staging: rtl8188eu: cleanup indenting issue in
 mlme_linux.c
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190117192301.17579-1-straube.linux@gmail.com>
 <20190117192301.17579-2-straube.linux@gmail.com>
 <174b4234659bfbb4f5a072f2928301da9cce67d8.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <6eac568c-307b-9ff1-6a0e-c1bcbdcacfe1@gmail.com>
Date:   Thu, 17 Jan 2019 21:16:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <174b4234659bfbb4f5a072f2928301da9cce67d8.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 8:44 PM, Joe Perches wrote:
> On Thu, 2019-01-17 at 20:23 +0100, Michael Straube wrote:
>> Cleanup indenting issue reported by checkpatch.
>> CHECK: Alignment should match open parenthesis
> []
>> diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
> []
>> @@ -52,9 +52,8 @@ void rtw_reset_securitypriv(struct adapter *adapter)
>>   		memset((unsigned char *)&adapter->securitypriv, 0, sizeof(struct security_priv));
>>   
>>   		/*  Restore the PMK information to securitypriv structure for the following connection. */
>> -		memcpy(&adapter->securitypriv.PMKIDList[0],
>> -			    &backup_pmkid[0],
>> -			    sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
>> +		memcpy(&adapter->securitypriv.PMKIDList[0], &backup_pmkid[0],
>> +		       sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
> 
> Hi.
> 
> Please try not to blindly follow checkpatch messages but
> please do try to make the code more readable.
> 
> Just below this block is another block with a temporary
> that uses &adapter->securitypriv.
> 
> How about hoisting the temporary and using that?
> 

Hi.

I will keep that in mind and try to be more attentive.
Thanks for the hints.

> Something like:
> ---
>   drivers/staging/rtl8188eu/os_dep/mlme_linux.c | 32 +++++++++++++--------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
> index d5ceb3beabbc..320a0be2af3d 100644
> --- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
> +++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
> @@ -39,31 +39,31 @@ void rtw_reset_securitypriv(struct adapter *adapter)
>   	u8	backup_index = 0;
>   	u8	backup_counter = 0x00;
>   	u32	backup_time = 0;
> +	struct security_priv *psec_priv = &adapter->securitypriv;
>   
> -	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
> +	if (psec_priv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
>   		/* 802.1x */
>   		/*  We have to backup the PMK information for WiFi PMK Caching test item. */
>   		/*  Backup the btkip_countermeasure information. */
>   		/*  When the countermeasure is trigger, the driver have to disconnect with AP for 60 seconds. */
> -		memcpy(&backup_pmkid[0], &adapter->securitypriv.PMKIDList[0], sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
> -		backup_index = adapter->securitypriv.PMKIDIndex;
> -		backup_counter = adapter->securitypriv.btkip_countermeasure;
> -		backup_time = adapter->securitypriv.btkip_countermeasure_time;
> -		memset((unsigned char *)&adapter->securitypriv, 0, sizeof(struct security_priv));
> +		memcpy(backup_pmkid, psec_priv->PMKIDList,
> +		       sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
> +		backup_index = psec_priv->PMKIDIndex;
> +		backup_counter = psec_priv->btkip_countermeasure;
> +		backup_time = psec_priv->btkip_countermeasure_time;
> +
> +		memset(psec_priv, 0, sizeof(*psec_priv));
>   
>   		/*  Restore the PMK information to securitypriv structure for the following connection. */
> -		memcpy(&adapter->securitypriv.PMKIDList[0],
> -			    &backup_pmkid[0],
> -			    sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
> -		adapter->securitypriv.PMKIDIndex = backup_index;
> -		adapter->securitypriv.btkip_countermeasure = backup_counter;
> -		adapter->securitypriv.btkip_countermeasure_time = backup_time;
> -		adapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
> -		adapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
> +		memcpy(psec_priv->PMKIDList, backup_pmkid,
> +		       sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
> +		psec_priv->PMKIDIndex = backup_index;
> +		psec_priv->btkip_countermeasure = backup_counter;
> +		psec_priv->btkip_countermeasure_time = backup_time;
> +		psec_priv->ndisauthtype = Ndis802_11AuthModeOpen;
> +		psec_priv->ndisencryptstatus = Ndis802_11WEPDisabled;
>   	} else {
>   		/* reset values in securitypriv */
> -		struct security_priv *psec_priv = &adapter->securitypriv;
> -
>   		psec_priv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
>   		psec_priv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
>   		psec_priv->dot11PrivacyKeyIndex = 0;
> 
> 
