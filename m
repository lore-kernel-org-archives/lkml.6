Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Wp5nHdhwGFvcJgAAmS7hNA
	; Wed, 06 Jun 2018 23:40:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A6030608B8; Wed,  6 Jun 2018 23:40:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HTTUeX5x"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 15ED5607E4;
	Wed,  6 Jun 2018 23:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15ED5607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeFFXki (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:40:38 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44379 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbeFFXkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:40:35 -0400
Received: by mail-qt0-f196.google.com with SMTP id l33-v6so8301743qta.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 16:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xk+NkLY/tYvRceupbqjKdLSqHxBih+xExZQw/sB9tME=;
        b=HTTUeX5xIZTO+5t8R4prDKwujuqUdYupd2wXWUVnfosCWQ+jlY243ow39L0C3LgUAP
         v9lsyrjxB4F0O2/opd9cW4TW2qXB765itk3bobZ7z7rXZAlx/h1iFnT44Fv4R2R32JV0
         TOWhvuVLrlL0UNqrs8q+B1zKI9Tc2Q1/yQ88U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xk+NkLY/tYvRceupbqjKdLSqHxBih+xExZQw/sB9tME=;
        b=F7h6EV2o33KPDl8nBndM8f94kCjNVY4pTp4+3AYiHgAJsfoy8TEkYEC6b/ZzIwTGSG
         rCo3vq4X9IlbgKqtSn/gi8fbbnCYn/x+tA+l5t1u8tn283eMUwreqKjqLEtjome/HEL7
         2RhuEVfAqyVhviK4KjdRS1sGNF/HvZcTubwypIgX6r2Mq8UmY0btsvSsAUQiytQDAvOK
         VfkTb9MjsCrnJB8cUgM+eX7uB1r5hfv3cIuRz3JGYiWyh5s+cUBR3BxZmYs9peOfaKJD
         IM57iGBkISsphIoPsWaQsjktoLYHW4QZTjnDSWOoWGpoyqok33w7i5zP+BZoq3Bhd8SD
         PrMw==
X-Gm-Message-State: APt69E3XEMBOGxz8jq8DFy5D2p5kZOXdRlvJpm5HKzet+oVFSX724nOk
        ymrGwt3oL5Y0dFegdZCT85sYIQ==
X-Google-Smtp-Source: ADUXVKIkWEZTzqbWK2X91Klv8dcS4st8cx7ZBnqL2ENhRC4ovEnvT5vIuolKMW83BwjyfF1HJXgCug==
X-Received: by 2002:aed:3d92:: with SMTP id i18-v6mr4910968qtf.149.1528328434748;
        Wed, 06 Jun 2018 16:40:34 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id w6-v6sm12412838qtj.71.2018.06.06.16.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 16:40:33 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] Enhance support for the SP805 WDT
To: Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <e3f657f1-bd7e-cadb-9cfe-dee6cf8c1668@gmail.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <79188fe9-1da3-94d2-ee1f-0c04d3aa9225@broadcom.com>
Date: Wed, 6 Jun 2018 16:40:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e3f657f1-bd7e-cadb-9cfe-dee6cf8c1668@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On 6/6/2018 12:29 PM, Florian Fainelli wrote:
> On 05/28/2018 11:01 AM, Ray Jui wrote:
>> This patch series enhances the support for the SP805 watchdog timer.
>> First of all, 'timeout-sec' devicetree property is added. In addition,
>> support is also added to allow the driver to reset the watchdog if it
>> has been detected that watchdot has been started in the bootloader. In
>> this case, the driver will initiate the ping service from the kernel
>> watchdog subsystem, before a user mode daemon takes over. This series
>> also enables SP805 in the default ARM64 defconfig
>>
>> This patch series is based off v4.17-rc5 and is available on GIHUB:
>> repo: https://github.com/Broadcom/arm64-linux.git
>> branch: sp805-wdt-v4
>>
>> Changes since v3:
>>   - Improve description of 'timeout-sec' in the binding document, per
>> recommendation from Guenter Roeck
>>
>> Changes since v2:
>>   - Fix indent and format to make them consistent within arm,sp805.txt
>>
>> Changes since v1:
>>   - Consolidate two duplicated SP805 binding documents into one
>>   - Slight change of the wdt_is_running implementation per discussion
>>
>> Ray Jui (6):
>>    Documentation: DT: Consolidate SP805 binding docs
>>    Documentation: DT: Add optional 'timeout-sec' property for sp805
>>    watchdog: sp805: add 'timeout-sec' DT property support
>>    watchdog: sp805: set WDOG_HW_RUNNING when appropriate
>>    arm64: dt: set initial SR watchdog timeout to 60 seconds
>>    arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG
> 
> I can take the last two patches and Guenter would take the first 4 or
> would you want to proceed differently?
> 

It looks like we still need to figure out how to proceed based on 
discussions with Rob and Guenter on 1/6?

Thanks,

Ray
