Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD06BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A5C20C0B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsSoJQKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A5C20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeHBJYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:24:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35415 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeHBJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:24:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so1340435wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 00:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gGpCWQp622tPfAGbA7D+Yk7ji/hRWJL8J0+9oW63TWY=;
        b=jsSoJQKIivZTnhdRKaeAZPL6yjiGpVD79T2ku4Z7ujqppEeRUlbdzeRHYb/A7c9hFY
         a9YbWOuY1zN97m4AZCSPXWInjQi7cBmtRveWfoOXEPQbRM6u+7nB28AsNLH68wk+beUU
         e6GmGw3Bft2hjz/dnPJUhbPNWjfNzEMFrfSUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gGpCWQp622tPfAGbA7D+Yk7ji/hRWJL8J0+9oW63TWY=;
        b=IDPkk4RyYEJYM3cbMOs6zYY1tcOrlkmBRRJta/LXHCp2BRLlSHhFE8zow23QLRHN0+
         wwO5HHX154bbjHVAAnQNWFvtw3UoArcJBMR/xTkpkWafbPBBDFStp50wABos234T9cl5
         bJgDG28vZgLyzyOz2Okpq7Lm1r6I5hHCZ14am2so/TAK0a1WTNW8cMUermVSHpvdUL9y
         S2qsGrSMeBAa0xhsx+p/mnw3KO6nvpKb8OduKCaTvRfdCUvk9wumqLUs80Fg92uJMKqD
         6yfJIPethlawKBbI14pnT7iXxpw5MwfhUVKAy+69cuigzjMINnafNqURN1nnxBOWfo8P
         cWxw==
X-Gm-Message-State: AOUpUlGJVy0+2RkK1jOjq91zhAKIy9qaaEHfYIcmsJ088jd60Eus8TqC
        V3vfneEDfehKVHbEwe02DTkL9w==
X-Google-Smtp-Source: AAOMgpdloEU1F/KVYmdv2d0VDKeaqyRSWcvLFxbRoye421L9yJIshs20Dwt5jqbUV9JMFeMaPVyp/Q==
X-Received: by 2002:a1c:99c2:: with SMTP id b185-v6mr1023741wme.15.1533195297260;
        Thu, 02 Aug 2018 00:34:57 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id z14-v6sm1216704wrr.71.2018.08.02.00.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 00:34:56 -0700 (PDT)
Subject: Re: [PATCH v2 03/10] mfd: wcd9335: add wcd irq support
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod <vkoul@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-4-srinivas.kandagatla@linaro.org>
 <20180731204536.GA7241@rob-hp-laptop>
 <d31d8f54-18b0-118f-eb25-7b92d5bf9842@linaro.org>
 <CAL_JsqJqCvWBqCfiS7dQMSzJ_FZDtAMJ8OQZvdGSJhsX0eYr6w@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <292fb788-fa5a-8106-efbb-e1fa825f5697@linaro.org>
Date:   Thu, 2 Aug 2018 08:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJqCvWBqCfiS7dQMSzJ_FZDtAMJ8OQZvdGSJhsX0eYr6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review,

On 01/08/18 23:17, Rob Herring wrote:
> On Wed, Aug 1, 2018 at 2:57 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> Thanks for the review,
>>
>> On 31/07/18 21:45, Rob Herring wrote:
>>> On Fri, Jul 27, 2018 at 01:17:59PM +0100, Srinivas Kandagatla wrote:
>>>> WCD9335 supports two lines of irqs INTR1 and INTR2.
>>>> Multiple interrupts are muxed via these lines.
>>>> INTR1 consists of all possible interrupt sources like:
>>>> Ear OCP, HPH OCP, MBHC, MAD, VBAT, and SVA
>>>> INTR2 is a subset of first interrupt sources like MAD, VBAT, and SVA
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>>    drivers/mfd/Makefile                |   2 +-
>>>>    drivers/mfd/wcd9335-core.c          |   9 ++
>>>>    drivers/mfd/wcd9335-irq.c           | 172 ++++++++++++++++++++++++++++++++++++
>>>>    include/dt-bindings/mfd/wcd9335.h   |  43 +++++++++
>>>
>>> I'm confused why these are defined here. The binding for the wc9335 is
>>> not an interrupt-controller.
>>
>> I can move this defines to include/linux/mfd/wcd9335/wcd9335.h as there
>> are no active users for this, but I  was hoping that these can be used
>> in DT in future.
>>
>> WCD9335 is an interrupt controller too. It muxes multiple interrupts via
>> a gpio line interrupt.
>>
>> I did mention this in the bindings.
> 
> Then the header belongs in the binding patch.
> 
> I don't recall child nodes being defined though and you don't need to
> be a interrupt-controller (in DT) without them.

Sure, I will fix it in next version.

Thanks,
srini
> 
> Rob
> 
