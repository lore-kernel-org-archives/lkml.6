Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3E5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B354320869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEnQ8zdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B354320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeIGPh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:37:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40476 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbeIGPh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:37:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so14523613wrw.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IBSgg7a9TDwtOz5DqSdl2tuPIzZdulETr6wlrSL4Xug=;
        b=nEnQ8zdGyhBfQlm60PqH1PRrk3B+TDTkDBpXechoJuC1tEh7GX1mVA1KMjK7h/KGyt
         Bs9jGuZ2chzr22XMfEYOdOzEY0Tz+OPIM2qhPEbpf8P50l+kW4aB91bEmKmQ3YoM26rv
         WMhBiayIyT5eObO+FeVB+BfVReUeu3RfqCFPF97WtrZ5cW9NisPPfLrkC+9cKw0a/rgV
         qkiGc9XnA2gJPiqhzpr/448FKU3NsUxVckLr+R3QV+rH8hN3F+gyYfi+E0sxy5zKW8MU
         vgDymSnZYGDcuD3QMHg4puYjAS8mduRik+gpJkivIOxhxAqjF9oSlJo+64Uwt0FlBsIJ
         BcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IBSgg7a9TDwtOz5DqSdl2tuPIzZdulETr6wlrSL4Xug=;
        b=Iy7eMm6rhPXDpbNj03FmxLEatPnFTwuf4g+QextDVbw3vNZ1GPaLfDbfE6G4gGjnRZ
         TzdbKNOCKMaRI17nuJMXpexVMR/dkh4Q/dN4gc6rbhf6WDd/XCnkwchyYMAbmYIp91q4
         zoUdaWW5Bwuam9q2CNmEW/5gD2J9Jat0Qbu1H7uXqJECL9hzzGRPvTIErsH6T15zPmi8
         I5DUUbVZ78sHC7xafD0iSkNw6VbAEq5SAfQxyTIzj3eWPGSqbnrrUi7JfJSfuqFhj+Ze
         PDELTaZfT4MqZeDZFsATzNaf23lyXpyNSga7tUxyfCZR0RN4uNCA0yiyNmFnRKeniJ5i
         bPKQ==
X-Gm-Message-State: APzg51AiPUFW7EChZo7d1NcKgWJpqSAE3gFKgus7l/2SKqzRDMkPEB/j
        BEA4u+cIaZf9IFIoiY69nQQkFzy7
X-Google-Smtp-Source: ANB0VdYBy0pTH4ut4P8UOxiXJ5TLQgFeFEQxI82PQs03qq8GVq+pFL7KzrOJPUuTmNxXERa5LKnYWg==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr5740849wrm.213.1536317822986;
        Fri, 07 Sep 2018 03:57:02 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:32db:916d:97a2:c4eb? ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id l12-v6sm10003715wrv.29.2018.09.07.03.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:57:02 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] staging: rtl8188eu: remove empty if statement in
 rtw_led.c
To:     Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180905184408.31175-1-straube.linux@gmail.com>
 <20180906103248.oxo655vyfmwgwgj4@mwanda>
 <f0dd985b91258f1990e77a2731a59e007dd8a0e0.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <bc3c8ce3-482e-d326-9d1b-d5534dccd111@gmail.com>
Date:   Fri, 7 Sep 2018 12:57:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <f0dd985b91258f1990e77a2731a59e007dd8a0e0.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/18 12:41 PM, Joe Perches wrote:
> On Thu, 2018-09-06 at 13:32 +0300, Dan Carpenter wrote:
>> Thanks.
>>
>> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Trivial, but these case statement blocks should prefer
> unindented blocks instead of reformatting the test.
> 
> Perhaps similar to the below for each of the cases:

That sounds good to me. I will send a patch with Joe's
suggestions, thanks. It will also solve some lines too
long warnings. :)

So, please do not merge this series.

> ---
>   drivers/staging/rtl8188eu/core/rtw_led.c | 53 ++++++++++++++++----------------
>   1 file changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
> index cbef871a7679..d9c19c1cda16 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_led.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_led.c
> @@ -290,33 +290,34 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
>   		}
>   		break;
>   	case LED_CTL_SITE_SURVEY:
> -		if ((pmlmepriv->LinkDetectInfo.bBusyTraffic) && (check_fwstate(pmlmepriv, _FW_LINKED))) {
> -			;
> -		} else if (!pLed->bLedScanBlinkInProgress) {
> -			if (IS_LED_WPS_BLINKING(pLed))
> -				return;
> -			if (pLed->bLedNoLinkBlinkInProgress) {
> -				del_timer_sync(&pLed->BlinkTimer);
> -				pLed->bLedNoLinkBlinkInProgress = false;
> -			}
> -			if (pLed->bLedLinkBlinkInProgress) {
> -				del_timer_sync(&pLed->BlinkTimer);
> -				 pLed->bLedLinkBlinkInProgress = false;
> -			}
> -			if (pLed->bLedBlinkInProgress) {
> -				del_timer_sync(&pLed->BlinkTimer);
> -				pLed->bLedBlinkInProgress = false;
> -			}
> -			pLed->bLedScanBlinkInProgress = true;
> -			pLed->CurrLedState = LED_BLINK_SCAN;
> -			pLed->BlinkTimes = 24;
> -			if (pLed->bLedOn)
> -				pLed->BlinkingLedState = RTW_LED_OFF;
> -			else
> -				pLed->BlinkingLedState = RTW_LED_ON;
> -			mod_timer(&pLed->BlinkTimer, jiffies +
> -				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> +		if (pmlmepriv->LinkDetectInfo.bBusyTraffic &&
> +		    check_fwstate(pmlmepriv, _FW_LINKED))
> +			break;
> +		if (pLed->bLedScanBlinkInProgress)
> +			break;
> +		if (IS_LED_WPS_BLINKING(pLed))
> +			return;
> +		if (pLed->bLedNoLinkBlinkInProgress) {
> +			del_timer_sync(&pLed->BlinkTimer);
> +			pLed->bLedNoLinkBlinkInProgress = false;
> +		}
> +		if (pLed->bLedLinkBlinkInProgress) {
> +			del_timer_sync(&pLed->BlinkTimer);
> +			pLed->bLedLinkBlinkInProgress = false;
> +		}
> +		if (pLed->bLedBlinkInProgress) {
> +			del_timer_sync(&pLed->BlinkTimer);
> +			pLed->bLedBlinkInProgress = false;
>   		}
> +		pLed->bLedScanBlinkInProgress = true;
> +		pLed->CurrLedState = LED_BLINK_SCAN;
> +		pLed->BlinkTimes = 24;
> +		if (pLed->bLedOn)
> +			pLed->BlinkingLedState = RTW_LED_OFF;
> +		else
> +			pLed->BlinkingLedState = RTW_LED_ON;
> +		mod_timer(&pLed->BlinkTimer, jiffies +
> +			  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
>   		break;
>   	case LED_CTL_TX:
>   	case LED_CTL_RX:
> 
