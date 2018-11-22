Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2382AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D989820684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQfPrGyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D989820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437503AbeKWBQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:16:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36632 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395565AbeKWBQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:16:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so9493602wrr.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1YRFiyvEsEFnRxZMcNpvmnGLAbo2St3c1P1NYx+nhYU=;
        b=hQfPrGytI4s4blVwdrClsyVTrL2F8NzvQNmSBz8210K7cHOlyAT1NOfKsMJC2FAlbO
         6yHe4YdtsBZlZ7zDU9eA8PMj5n8Rg/1Kj/+SJ+AV3v/TIgQ/Osk6Tn/OBmnUNNC1ZFHv
         WDIng+ZQKN0f+TlRu7BOenYPgD0jLwDcofPwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1YRFiyvEsEFnRxZMcNpvmnGLAbo2St3c1P1NYx+nhYU=;
        b=pYyH0ER5ZRhukNFmuLCPo9MECEJ7F8vBNC31bdw4/hDQtOHw7FWWt/V3UUoe5LtY5A
         r4YtPMDm2sJ6oKTgig6e/QVVkKpTQFjE4L4o/qwHkEsbJlmSMx8vXpXSOKQHj2/7Z8Ff
         W96pKrllMdwmtxcpVOPKZ8lq+ENJ6kHwFfVZy+iEpG2tAsGp4UAbGdWaytzuGZSlAH8q
         Z4YaDPN3eULCUrJGsN0Nnu6Q5AlUOys2FyCEKVRpaUaP96BlHp6DK0UIkpKyaQ8AR8mj
         MPO/vzVlJOeuZ6rZ6sq2OqHH9Kj53qFxcYYhFUgrpdBcfmVTisedd228SZVH8sHVGaNS
         j9fw==
X-Gm-Message-State: AA+aEWbHrU1RfbDwz3VkT0zxHgkE3jEy/fGvX76Xjg+6aNXmotTiIraR
        g/t5V6/a0CmzwlgeuDaxWLJVI2Emat0=
X-Google-Smtp-Source: AFSGD/UJ0hs+/yMuC2IeY+C3t6OB3EwKl/rmLqgowuK7N3ZU200VnywyOLKaaqXRk2Tq2+WgAK9BvA==
X-Received: by 2002:adf:891a:: with SMTP id s26mr9867964wrs.44.1542897426853;
        Thu, 22 Nov 2018 06:37:06 -0800 (PST)
Received: from [192.168.0.40] (44.65.136.77.rev.sfr.net. [77.136.65.44])
        by smtp.googlemail.com with ESMTPSA id b18sm22694511wrw.83.2018.11.22.06.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 06:37:06 -0800 (PST)
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <20181120131853.19710-1-tiny.windzz@gmail.com>
 <5ea4da1e-65de-ddc3-5ca6-eb83c2347930@linaro.org>
 <CAEExFWsOh1gixoC4bbSkbawC-ybz1YUA-tmw5FW5W-GFyFGs7Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <54a66dbf-df0a-8cec-cb60-0603a52dad99@linaro.org>
Date:   Thu, 22 Nov 2018 15:37:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEExFWsOh1gixoC4bbSkbawC-ybz1YUA-tmw5FW5W-GFyFGs7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 15:33, Frank Lee wrote:
> On Thu, Nov 22, 2018 at 10:26 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 20/11/2018 14:18, Yangtao Li wrote:
>>> use of_node_put() to release the refcount.
>>>
>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>>
>> Applied, thanks!
> Hi Daniel：
> 
> This patch is a bit small, I will resend。

What do you mean by 'small' ?

>> --
>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

