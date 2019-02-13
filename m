Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416E6C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110B72190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="orYKLCJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389855AbfBMKeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:34:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42617 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389557AbfBMKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:34:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so1848313wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 02:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LieBVVVdKyP95R11D2/eV7vtBd1PQludtrUBXGSu3nM=;
        b=orYKLCJUmA96E1zSha13AuODx2x5fQdXLKXU8d50AMbg+kdqmzUM+qFpsuP/dlCjdc
         QyfdBvRL9B+WQ5KonUOwh+qqI3cT9A5znkCjaTB5XnvPQ152e7wiE7fzRDcU9AnaR1Xw
         7hBCRh+0fFJsBLyZP9nD3Fs3398b8P2Lfk2vkaYsJWmIT/7eNVEWNBsEQHG0P4CtP94G
         zSXks0IWEi6abI0382kHkp/Kmut8gXu9Wz4OesAITTKmOIt2E23lY9pxFpK47/e1nRBh
         x1rCYqSBqtZWDPphniqxZ99zShFjiFzeMAM4iS/lFKgjfCiKdLlLECLhQmi5Hk2qKlcc
         IzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LieBVVVdKyP95R11D2/eV7vtBd1PQludtrUBXGSu3nM=;
        b=Kti2DavPhAvOvIXQaPxtGvQ8eTYjTC01kGcR1o2VecnpemgL4gep/7UKI3b+hIVojc
         Kty7HjuIf3HhJjVeAJnTz49eVFaMpjZ5mq15QR9DX6SCpY11/KbjM/Ceum3CDXmz6XjL
         Xir18+G4MhDrfQO5U/pu9stpamAEc3RtMP9z0t88VeKO+D+B7Sp9uQevQF2iLEeSo3++
         TDz4qU9bxykdCovEqJ29sMiH8JBxIeT+/epo2F+QCOiqPJ6FXa74p3NigWvwPpBiqnzL
         NzvbWkQRL71IhAoIUCMyJtq38ehZCTrMxuyTI7yEcLufLO+Y5EEPRYgoUbRiAYS68QXN
         j3rA==
X-Gm-Message-State: AHQUAubWGeBl6HPgpHsm4LQ8HQebAUmP8/QwqvjmTM7p3TE2xtafa/5z
        uHIjoXWPa5F03/ZZdGEZ7Xk0kGbSQfk=
X-Google-Smtp-Source: AHgI3IZ9gdzX+Ei5Qdffvbq/TjBcqttowzcjuLbJBczHgzdJ7VS4+1MlY1pwpNqAwF2hvmdofluffA==
X-Received: by 2002:a5d:42c3:: with SMTP id t3mr6261626wrr.232.1550054060836;
        Wed, 13 Feb 2019 02:34:20 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id e9sm27785424wrc.56.2019.02.13.02.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 02:34:20 -0800 (PST)
Subject: Re: [PATCH 0/4] Add nvmem support on STM32
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, robh+dt@kernel.org,
        alexandre.torgue@st.com
Cc:     mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        lionel.debieve@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
 <4aaa83b2-35a6-e2c2-a3f4-6579b5d67038@st.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <46a59513-a322-1e14-41b5-ecbd4c478286@linaro.org>
Date:   Wed, 13 Feb 2019 10:34:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4aaa83b2-35a6-e2c2-a3f4-6579b5d67038@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/02/2019 10:15, Fabrice Gasnier wrote:
> On 1/30/19 5:38 PM, Fabrice Gasnier wrote:
>> Non volatile memory area is available on STM32. It contains various
>> factory programmed information such as unique device ID, analog calibration...
>> This patchset adds NVMEM support to access these data.
> 
> Hello,
> 
> Gentle reminder for this new driver review
Nvmem provider driver itself looks fine for me, but I am unable to take 
this as 5.1 material, as I normally take nvmem patches which are 
reviewed and ready before rc5.

dt bindings patch needs an ack from DT maintainers.

Thanks,
srini
> 
> Best Regards,
> Fabrice
> 
>>
>> Fabrice Gasnier (4):
>>    dt-bindings: nvmem: Add STM32 factory-programmed romem
>>    nvmem: Add driver for STM32 factory-programmed read only mem
>>    nvmem: stm32: add support for STM32MP15 BSEC to control OTP data
>>    ARM: dts: stm32: Add romem and temperature calibration on stm32mp157c
>>
>>   .../devicetree/bindings/nvmem/st,stm32-romem.txt   |  31 ++++
>>   arch/arm/boot/dts/stm32mp157c.dtsi                 |  13 ++
>>   drivers/nvmem/Kconfig                              |  10 +
>>   drivers/nvmem/Makefile                             |   2 +
>>   drivers/nvmem/stm32-romem.c                        | 202 +++++++++++++++++++++
>>   5 files changed, 258 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
>>   create mode 100644 drivers/nvmem/stm32-romem.c
>>
