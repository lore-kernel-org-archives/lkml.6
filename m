Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06301C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFBA20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQU0TYmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfAVFI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:08:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41850 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVFI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:08:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so11156064pfi.8;
        Mon, 21 Jan 2019 21:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nLcuqF9YtgkcwdGAUsto4xku4MmEiDcQ6OWiJdPFJ8Y=;
        b=vQU0TYmFdVk2miXhi5xJmurpefju184WSX90R44vPqEMahuUijmDd5j7EWXSvZmvfx
         cSgKeAll4Nlw+Sb3ZpN7Xj2prIWEWi5GLZbdhe7pYFOxJjUvC6GGj19dDyev6m2yAjZV
         gRSLrlBVjGo2Pp8K8WxpDbJTSIWBN+QXsVnlAqkStY68/nFowS7kgcPw3QSAZMenDQnc
         WLV6jQchuMyC7BfDFtRGsm2yoZOQY5kabmxeEfFXAGyDNM7GHdN1UMKltxmHDpNtytDG
         /UBJVNDMBJFj7oVOKmQyYUYBLoksdJ6YVNQFQ/6HAaVCt5LKbHKJ3lAa4fHlumBhcbrK
         UMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nLcuqF9YtgkcwdGAUsto4xku4MmEiDcQ6OWiJdPFJ8Y=;
        b=r8b6sAmXaz0vgQWIB3TyCagoA1j2aZ0h5JCkgUkB7FB1ER9fhc9Du0G9/auktwUooN
         5Kr8oK+UkAzyqC7lodkr6v30IVFhm0+Cg8lIdvk0vEDHq2hnWsBCqA62Jq24Nem/je4I
         r2Htsyc2XWsraFgUpeLjQ/+HJuKK5GuvA+S+8CvWNb7A3GYp4IIYo6CQ4xuGG2pWcRnc
         +MG7YuCllgdes1O4iIBICIVvv5moAlrkT2+JPYW0Lba2KAx/k4zqxqtr0s8H0AWlDIDv
         7wC88veGUr06oDiMMKMZOt6kH5N+cYudFuKDthAIgdjvhrr87qENWIBc5lrapht8Dbu7
         pOew==
X-Gm-Message-State: AJcUukf7+N44FycPM09APbbohSXSTNBLZbdgarAfhyxwcq8Z4GPmsKSg
        0LmfpXjrbZpMyacoa/bGjiEHfx8s
X-Google-Smtp-Source: ALg8bN4Hjc6n2HRJIZYXVQOGp7+Nrb+lbpXpJwdi13B4nIlslydxr0i2mXT1339v0JxKHF0/Q1/ULg==
X-Received: by 2002:a63:40c6:: with SMTP id n189mr13696456pga.355.1548133707679;
        Mon, 21 Jan 2019 21:08:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g2sm17393444pfi.95.2019.01.21.21.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 21:08:26 -0800 (PST)
Subject: Re: [PATCH] soc: qcom: update config dependencies for QCOM_RPMPD
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190118044801.7312-1-rnayak@codeaurora.org>
 <154783318835.169631.6614930101893188915@swboyd.mtv.corp.google.com>
 <df735d42-d208-62c7-ddbc-87ea314c36d1@codeaurora.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <25f46403-e78e-271b-c4d0-13b4623846b3@roeck-us.net>
Date:   Mon, 21 Jan 2019 21:08:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <df735d42-d208-62c7-ddbc-87ea314c36d1@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 6:30 PM, Rajendra Nayak wrote:
> 
> 
> On 1/18/2019 11:09 PM, Stephen Boyd wrote:
>> Quoting Rajendra Nayak (2019-01-17 20:48:01)
>>>   drivers/soc/qcom/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>> index a5d5167c3f16..1ee298f6bf17 100644
>>> --- a/drivers/soc/qcom/Kconfig
>>> +++ b/drivers/soc/qcom/Kconfig
>>> @@ -109,7 +109,7 @@ config QCOM_RPMHPD
>>>   config QCOM_RPMPD
>>>          bool "Qualcomm RPM Power domain driver"
>>
>> Just curious, does it need to be bool for some reason?
> 
> Here's the link to the discussion around it on the v3 patchset of this series
> https://lkml.org/lkml/2018/6/12/111
> 

I think you were missing the implication of "if possible", the implication
being that the driver can now not be used in a multi-platform image, and that
having a bool driver depend on tristate drivers doesn't make much if any sense.

The argument in the exchange is odd - one can not remove any driver as long
there are client drivers / devices attached to it. This is true for all
drivers, not just for this one, and handled quite nicely by the driver core.
Just run "lsmod" and try to remove a driver with any attached users.

Guenter
