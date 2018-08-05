Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D940C4646F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 01:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28319217CE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 01:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7B3jniI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28319217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeHEDLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 23:11:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40108 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHEDLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 23:11:46 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so4133871plp.7;
        Sat, 04 Aug 2018 18:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z7/d9QsSO8rmxknN/wp79Hyf8FpWQ7HSDDH1+fcZ4C4=;
        b=j7B3jniI3P9cSDbqUd3uxKAlSo9KUErGE2EUBW6fGxJyRJmblMnOWK3PL+FLgQhSLS
         uk1eEnn2tNCc/yMt2Winnj27EZH4BOUKlq4EqRU5JhizUpZmw8uOaeYmfCelykrW+7W4
         qAAeSff+g9F6x+A9WpL4M9+nvFsZm+WDS3zZGZYDAP8hpQjwMLkwBQnyKhhtW3FUbKPA
         yCj9d/WXee5m42W5oM2+EMm6tjnp86c8l7EyKXyRmPw5AyEtCOoOQ4n90jF9esf8KeUB
         ywHKBsSDlLtdJsnvHLPmLQIGOs6B/4neNIhSkcJuLnNsbjSjZY5QWvtwufQeKG6PWoq5
         srDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z7/d9QsSO8rmxknN/wp79Hyf8FpWQ7HSDDH1+fcZ4C4=;
        b=FMbmhC3Gaq9ojsH/UAxJQBEcrQQY4Ek9U9H/BRCm0QYXDIpurC2hoxXY+Zz2Q66jht
         eCItzDEIyVlyFQo7U6E65jaf3ceOOMEwjKUd+Gqiondjd2Jee8jSA7bri3UyJZMtWdIu
         S4jnIeXq28DqhgdP3WbkeW5Kt7R18j/o8DaijLBo5e8RZ9TZC/uykegJAuu+MNuUKCAT
         +6dz9+wspaDR9PemyH7AL4w63bTDJItdSbMGPl3SVJf/wIqCQThWgXLpWASVQGV1IYq5
         uN7roA25SH5+dsEfj6Jf06jwsb176Sut5vS15V7l8HLpneUvGCIM2/NWFuq/gxGcxGhp
         T/FA==
X-Gm-Message-State: AOUpUlHvye0CGws4STeurzDF963Hq/kVB544GYTPwYDf71rD+75QdUKn
        QEgJBDsLPVWEOYiuyfwPvzQfNmC3
X-Google-Smtp-Source: AAOMgpfn46TMscasYyLm0IQ17RH2MN8hGzm7ofCEpBkcxODBkqnKeSMXU5CexYybeHvTJl9xqwywBQ==
X-Received: by 2002:a17:902:7683:: with SMTP id m3-v6mr8704664pll.255.1533431347084;
        Sat, 04 Aug 2018 18:09:07 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i62-v6sm12974573pge.66.2018.08.04.18.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 18:09:06 -0700 (PDT)
Subject: Re: [PATCH 2/4] watchdog: hpwdt: Claim NMI from iLO
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-3-git-send-email-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b4de8a19-00c6-fcca-2414-197056ef27bc@roeck-us.net>
Date:   Sat, 4 Aug 2018 18:09:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533244541-42310-3-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> The hwpdt driver is overloaded for handling both the iLO
> watchdog and the explicit "Generate NMI to System" virutal
> button.
> 
> Claim the iLO NMI virtual button even if we are not claiming
> the iLO watchdog pretimeout.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Guess you know what you are doing here.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 369022d..8a85ddd 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -162,7 +162,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>   	if (ilo5 && ulReason == NMI_UNKNOWN && !mynmi)
>   		return NMI_DONE;
>   
> -	if (ilo5 && !pretimeout)
> +	if (ilo5 && !pretimeout && !(mynmi & 0x4))
>   		return NMI_DONE;
>   
>   	hpwdt_stop();
> 

