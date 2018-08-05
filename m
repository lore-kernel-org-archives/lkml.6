Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18D9C4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 01:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71077217CE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 01:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHbVWlpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71077217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeHEDQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 23:16:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35224 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHEDQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 23:16:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so5123084pfh.2;
        Sat, 04 Aug 2018 18:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qqZ1GEmAV0Ml37ELjktstcbZK/d3mqLlWepI+0uwFTA=;
        b=uHbVWlpYM8eJiSFNDwlHj+MhcjqBjO+LeQV6Yb+cX7Jz4LCzu+O2jCnR29ZWOBvDNP
         bOE7SDKAEPGXbNrQ1CQjYkKB6J/SIQCfnY98Vi17z2aDoRf48nZCllUi0rQujBr6F41h
         bKOC3CSWAZfMJdEu4/GU9MAPyC2+17XoEqxKDC+ikj9C+G7gHeirioLMRHxDepCstG5p
         HgVTPIz9LxEEj8Xft7VGeabR00QPa8/BIMA8ih9xbunrWRlXvtrYZKJ+MyEHaEXLtcoW
         HOJet8dHTEKekQ8qPKsjPuc5Vwlp3c0EMFyqw4lMHWAmgjKxDruNo3dWBWueesy9JsGx
         +P5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qqZ1GEmAV0Ml37ELjktstcbZK/d3mqLlWepI+0uwFTA=;
        b=Wg+RPa2UAGZyQlAPN6UKF36fxMXdh67QEbjRnW4f8SIFGM/zUONstC6aITXxrVmik+
         Iqub33dlmWRDTAJrLvjAUV6XHFBp8SBUanl0b7pb/cxp+MDHUeikz+BT81P29gxkmcXM
         ZU+8GQ7oZi6kLjMMslBjno2o+M7zdKcFHI36G09LSzYLD6tR60xSCd4/BwZhJJrkpCJ+
         aU3rAUT0oQ4WD8RsTUJUbwAwF7/xmMffFPEW9mIt5L+vbGn0Ncmw+1QA4JYzHuTI5yBf
         iS/MPSxXUqpggiKGjYLEJ4I1U6gD2kAX6zNCyK29DArLU8FC/FcNDISY+fNMHsVy6bGP
         HHMQ==
X-Gm-Message-State: AOUpUlFJxAO+K3+1aFE/dv2gxxSGnwnNlmRtYp+Fr6QX++Tez89rrPh0
        oCdkKO/60HNY3kunN8LnS1G173Ya
X-Google-Smtp-Source: AAOMgpdnYJkFonEgh/3ONtyTWgNmi1rtPjYPhoc+CMvo1TZO+zl/G31OlPSHItpo6rvtZ0Z/vY7j2w==
X-Received: by 2002:a63:2c8e:: with SMTP id s136-v6mr9139724pgs.390.1533431601910;
        Sat, 04 Aug 2018 18:13:21 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d191-v6sm13159697pfg.172.2018.08.04.18.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 18:13:21 -0700 (PDT)
Subject: Re: [PATCH 3/4] watchdog: hpwdt: Display module parameters.
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-4-git-send-email-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ba07e5f3-282f-0417-236d-57289d33f56c@roeck-us.net>
Date:   Sat, 4 Aug 2018 18:13:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533244541-42310-4-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> Print module parameters when the driver is loaded.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>   drivers/watchdog/hpwdt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 8a85ddd..f098371 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -326,8 +326,9 @@ static int hpwdt_init_one(struct pci_dev *dev,
>   	}
>   
>   	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
> -			", timer margin: %d seconds (nowayout=%d).\n",
> -			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
> +		", timeout : %d seconds (nowayout=%d) pretimeout=%s.\n",
> +		HPWDT_VERSION, hpwdt_dev.timeout, nowayout,
> +		pretimeout ? "on" : "off");
>   
When touching that, you might as well address

WARNING: quoted string split across lines

Why did you add a space before ':' ? Personal preference ?

Guenter

>   	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
>   		ilo5 = true;
> 

