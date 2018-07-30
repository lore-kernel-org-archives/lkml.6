Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C914913F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CC920881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOmufWUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CC920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbeG3N7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:59:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46351 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeG3N7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:59:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id h14-v6so12670478wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 05:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KGqOZiprmRitZfeDxITIbhozE2rQRz9bgMXdsN8/dss=;
        b=GOmufWURJnYYSkQbjXf48vDziWAwvGHDTdKtz46HS//QNN1Vr4IRKMaFDwoj6CSffR
         s3SAZnXvqFSSzwdn5WW3l7CSS6VftcNun/YNYJur7AZds8FqRSgRf6Qd2VpLp68m6F1y
         +yCnnyk0Ol8hLKvorjFo3CBPWJQbcLv8C/W9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KGqOZiprmRitZfeDxITIbhozE2rQRz9bgMXdsN8/dss=;
        b=iMt/oxu4hSInjf/ekXJ5iw7Egwl4ys/lExzzK1F649JZxEudVWE9Rt0kkzgXo/4SfO
         udR2tqZTwi2bhzmPXumm6kOAe5A/OJbBchkLRPecihi0i9q/dHQrYMLv7gExn7DLIUvn
         YM5YyDj++ZjrN1CnXeeriIBPxVCMdaHIPrd+nrqOPZ3ref7Bmg6pX14Y3c/2sWbw6Ckl
         YQres/Jmh7HpDwDiUZUy2J+d43XZFnANQmz4sSrflHhlVJYMMtlZGFQNSKAox4+Beh2d
         EULL1Lr5Vv9NvFA0xOfGkcreS8DJTj2YUORegceF8cOn+Yyfu/VlTmBmb5IbQW8KJwY+
         s0yQ==
X-Gm-Message-State: AOUpUlH3cxa073x7+iKt4l922tH/quvgbTBQSthqFghYeAN0mnfqMfrr
        oM+LqcsSDwd8DiLjTshWCgYhow==
X-Google-Smtp-Source: AAOMgpdhEGuP9PsBT7u/3PisxduVesN6uCkhKZgvbFSKMx4IwFbcd8VVhFYXWbddAXL1yaUnk3bniQ==
X-Received: by 2002:adf:a0f3:: with SMTP id n48-v6mr18168157wrn.23.1532953503556;
        Mon, 30 Jul 2018 05:25:03 -0700 (PDT)
Received: from [192.168.0.22] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id a14-v6sm13000568wmb.44.2018.07.30.05.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 05:25:02 -0700 (PDT)
Subject: Re: [GIT PULL] timers for 4.19
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>
References: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
 <alpine.DEB.2.21.1807301310470.2518@nanos.tec.linutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f911e983-82b5-96f0-d6ee-2725016d38db@linaro.org>
Date:   Mon, 30 Jul 2018 14:24:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807301310470.2518@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2018 13:11, Thomas Gleixner wrote:
> On Thu, 26 Jul 2018, Daniel Lezcano wrote:
>>
>> Hi Thomas, Ingo,
>>
>> here are the changes for the timers for 4.19:
>>
>>  - Add a less accurate but always-on clocksource for the sprd platform
>> (Baoling Wang)
>>
>>  - Add the system timer for the new mediatek platforms (Stanley Chu)
>>
>>  - Change the cpumask to cpu_possible_mask (Sudeep Holla)
>>
>> Thanks !
>>
>>   -- Daniel
>>
>>
>> The following changes since commit e5af5ff34cf037ac7bb70976161427dc40bf4a96:
>>
>>   Merge tag 'fortglx/4.19/time-part2' of
>> https://git.linaro.org/people/john.stultz/linux into timers/core
>> (2018-07-20 06:43:05 +0200)
>>
>> are available in the git repository at:
>>
>>   ssh://git@git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.19
> 
>  git://git.linaro.....
> 
> worked slightly better than the ssh URL.....

Ah ... yes :)

Thanks for fixing this

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

