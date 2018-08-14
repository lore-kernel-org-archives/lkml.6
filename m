Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538E9C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B97D2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0EFZJqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B97D2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbeHNQSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:18:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41969 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeHNQSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:18:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id y10-v6so9245406pfn.8;
        Tue, 14 Aug 2018 06:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qUXm/uUKSBWA5M6rAMUMK1dSUSPsIfW4166W8GZVDKE=;
        b=l0EFZJqkVf3OzW6Wzz/8OaILiIhquCDx152hLke/WP4nKA/0bZDUz0aQ6uVzpGx9Xv
         VAiZa3a3rjkwnenGH8P3J0CI8UdexuTwm1YfASz2kWvdSiE5YqCrCN2PRIf6P3Jc9LI2
         U7N196ITENqSs8cjASJJ2SSptOvrD+Aw2hQXBttT0un/VqG0lSeW2GNkbg56wjD/lg0V
         oKNHKEj8qkRu2PCyZmM5rHy3XB2vk6nYjJfBPs0OlMFog6M9E/1cuXkqiF53167Zm8Vg
         ccHOqTyi2iD7Es/KH9DB22nG0ooBtljgvtKTx62bTtdnPaKMdRIT0/kJiOTn5XrfZFf6
         1tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qUXm/uUKSBWA5M6rAMUMK1dSUSPsIfW4166W8GZVDKE=;
        b=hW43XZoJigyC0Zwqirgpf5FlqVvXGG++iHQOfYKgp5ixsIfKfM2S5s7kmz4X6KvPd/
         qasUvuvEZE+4hiki1yopsK/XztWTuANC4tyitTarZVL6GaaNYrJ8mTzQF7Hats+CRZf8
         A5I+9TJ05uFhFCkLE4swI2YNOvFOBiYaErtqtqUlSoDaORtnNRPSx79d+Pw+dHZk2t2U
         v0XmCYMd1AOA0vH8hmBeHVZSqxn0SK+O+jpl00XIOKFqNitlmxeoqVw8gy54NczGdGjR
         ji8Z/ofLL7n80ceM5aGdZjKv4sEqxGOHa52eMOwM6gMfPK957EVhpc46A1c1PNVtGGvc
         4j4g==
X-Gm-Message-State: AOUpUlF3F2mq+R0B8MykIDmwa1/RqCyAV2jErN/cTJ6XqZxHY/Xc6rJc
        DuKGo7nLnQZhDsKAK67vBxxsnY+D
X-Google-Smtp-Source: AA+uWPzbk1c5WZF9p7Sx2O/yX9/l09+JfGDYP4XF+CnwOEr2F+syavvwiRQghdo/SPbTj/v+eawD5g==
X-Received: by 2002:a63:65c2:: with SMTP id z185-v6mr20819484pgb.276.1534253460345;
        Tue, 14 Aug 2018 06:31:00 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 1-v6sm49355477pfk.134.2018.08.14.06.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 06:30:59 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] watchdog: hpwdt: Claim NMI from iLO
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
 <1533755607-71418-3-git-send-email-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e3fcd8e8-abdf-6626-2a54-52de089bde5c@roeck-us.net>
Date:   Tue, 14 Aug 2018 06:30:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533755607-71418-3-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 12:13 PM, Jerry Hoemann wrote:
> The hwpdt driver is overloaded for handling both the iLO
> watchdog and the explicit "Generate NMI to System" virutal
> button.  Hence NMI handler needs to claim NMI resulting
> from the virutal button.
> 
> Claim if iLO generated accommodating firmware that might
> set wrong bit.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index fae9364..bb41714 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -162,7 +162,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>   	if (ilo5 && ulReason == NMI_UNKNOWN && !mynmi)
>   		return NMI_DONE;
>   
> -	if (ilo5 && !pretimeout)
> +	if (ilo5 && !pretimeout && !mynmi)
>   		return NMI_DONE;
>   
>   	hpwdt_stop();
> 

