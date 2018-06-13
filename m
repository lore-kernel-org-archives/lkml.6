Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EAB0CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D4F208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dAD4JZFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D4F208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964774AbeFMXgT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 19:36:19 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33150 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935589AbeFMXgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 19:36:17 -0400
Received: by mail-qt0-f196.google.com with SMTP id l10-v6so4169128qtj.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9XHJvoOPFw6Ka19HRGxjxJp9ni+vCfAxmEQDyy+2FK0=;
        b=dAD4JZFyvYIgcf7wPcBsH2GHzvRBbCVjTakCbpw8+hC62whh9obJsQUnlSaOUe45/w
         xVUd6sSZZED5YIilVT/O77b10PISZi4sBECsxbIiRcL4Yda+bLVvSqcOnc5I4BILe1nn
         nhqqm7c8nYgddIn20/WrTdRUp8ipCD4AwSX9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9XHJvoOPFw6Ka19HRGxjxJp9ni+vCfAxmEQDyy+2FK0=;
        b=jJPG5n99SNWAM7IGryHleAKLX7nmvZBOwPySyIHIaQuIlXPxGsDdsx60qtsSNZvLu3
         DBj3IszU+1CFqc8Ly2iw0MkiEe+OoT5fQd8giugdQWH7u7qFV68MjL/VLltonXfjLLlO
         N/HVKiQtKxITk7s0uVplqHtIxgFri1yCvrpmd3kWg5Lt4XJfN8kXxsPrg5zvoWYo+e7s
         Ls3ehKZIXNAQe5KqG7N9OxtRBrrlzGxW1+P8dE0qmlxi/8ZOzU8TnkK52DHWHMAuDupA
         ivTRUTqWmwmZXbHv0h28zhBHOiDCL6yiNRJxcxJQ8CYgg18MWlmWxKQN/RKVdBJs5b8s
         v+9g==
X-Gm-Message-State: APt69E32SR4PRk1IvEHpGiwl6V64yfXhwO2VGbz0QxvtKVfygdFiDmWD
        n6JAR1/y4pBqJT5ePjVnXUFOE0m8nNY=
X-Google-Smtp-Source: ADUXVKJUggL+mXt/nfQ+juJrvQHHKM5Qd61WvUKTg1dftdhlYUWl7gGgMWguxz6kElCCnGHdL+Jrrw==
X-Received: by 2002:ac8:2825:: with SMTP id 34-v6mr189864qtq.377.1528932976846;
        Wed, 13 Jun 2018 16:36:16 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m128-v6sm2406317qkd.33.2018.06.13.16.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 16:36:15 -0700 (PDT)
Subject: Re: [PATCH 1/5] ARM: dts: cygnus: Fix I2C controller interrupt type
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
 <1528834891-17807-2-git-send-email-ray.jui@broadcom.com>
 <8c368dbc-f654-ec52-0786-1f318156b8b5@gmail.com>
 <21124af0-f867-56a9-753d-cadfce7d1cf2@broadcom.com>
 <fcb1d93a-3e1a-7020-a104-acc9360855e2@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <74246880-1fe3-b148-d3d1-f2bcd4ee2ed0@broadcom.com>
Date:   Wed, 13 Jun 2018 16:36:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <fcb1d93a-3e1a-7020-a104-acc9360855e2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2018 4:33 PM, Florian Fainelli wrote:
> On 06/13/2018 04:32 PM, Ray Jui wrote:
>>
>>
>> On 6/13/2018 12:49 PM, Florian Fainelli wrote:
>>> On 06/12/2018 01:21 PM, Ray Jui wrote:
>>>> Fix I2C controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
>>>> Cygnus SoC
>>>>
>>>> Fixes: b51c05a331ff ("ARM: dts: add I2C device nodes for Broadcom
>>>> Cygnus")
>>>
>>> This appears to be the only one that is truly needed here, the two
>>> others below probably just moved things around but the offending commit
>>> was already introduced in the above commit.
>>>
>>
>> Okay thanks. Will remove the other two "Fixes" below.
> 
> I can take care of that while applying the patches, no need for you to
> resubmit, for the whole series I mean.
> 

Excellent! Much appreciated!

>>
>>>> Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi
>>>> bus")
>>>> Fixes: 9c5101f7a253 ("ARM: dts: Reorder Cygnus peripherals")
>>>>
>>>
>>> There is no need for an extra line between the last Fixes: tag and your
>>> Signed-off-by tag.
>>>
>>
>> Got it, thanks!
> 
> And that as well.
> 

Thanks again!

Ray
