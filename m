Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98409C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5629A2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsRQNof9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5629A2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbeJ2SOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:14:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33631 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbeJ2SOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:14:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id y140-v6so9058175wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Ryyv70ahBSTrniPtr8AorZI1dVLIPv4vB8Beo1l9ig=;
        b=KsRQNof9zvU3jMC5RuMvbBviu2GPbvkDnErjF74fq7ODiHpwuiNgq87mVncUUKXpeD
         SbDQA4shSQ+g36sFkpE0qRv7XRqD9aMBg4WtvZ+7WezJ1umbkkfkCClD6fch6u6HTX8D
         pNXR4MUNFDQfgzinc6cw5VRaM+oClqO3vhfww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Ryyv70ahBSTrniPtr8AorZI1dVLIPv4vB8Beo1l9ig=;
        b=tJNgpmtKDKB4XfSfW5Cyy0sCen1h/stJr+a8/hg0kyBchxguQHWFrajF3U5OF3XNiT
         rGrYL1JRcLWM4dRxaq1S55VevOweMw0ujs8TD2rOIP9RXUMyrZIBVEJh0k2Sft1A67Sh
         Sf907UXG6POGgH/gkQrEdP+pQmeIQ8vJxexcXOlNaWWFsvMaWAb+4WnU1BsGGDvq/D9x
         PkS+nreyVUx71uOgFdJ9tbv7YRDwp1o8OV2Ln+f1iArcUCJUYbJHvm2M9SBojPhkzqnv
         1CP5ON8geraccsgsgZeE79wM/5bjWftCb2uAyBKZhcS600k1BvofIh7PDkGieDnT+CZz
         bF+A==
X-Gm-Message-State: AGRZ1gIPpC1IzbUsdYsXOq9MwxKhQnoWQ+xc0Sx/Es2adqV1pw4mEbX1
        SYokDljmGZ8o56YX2ag8ovh2XfXsIOc=
X-Google-Smtp-Source: AJdET5ecvGlbau/2ISfFWv9pMx0krL+Yv0jdgvP9vIukwOhDVPGhAbdIyvmwT8XpB+RSOLivIOLqxQ==
X-Received: by 2002:a1c:ee8d:: with SMTP id j13-v6mr13181400wmi.125.1540805219979;
        Mon, 29 Oct 2018 02:26:59 -0700 (PDT)
Received: from [192.168.0.40] (75.25.136.77.rev.sfr.net. [77.136.25.75])
        by smtp.googlemail.com with ESMTPSA id y64-v6sm8756886wmy.35.2018.10.29.02.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 02:26:59 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: arm: Fix cpu capacity mismatch in example
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     catalin.marinas@arm.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <138600f5d504b41202a29a1e130a7aa4e51f1925.1540451976.git.viresh.kumar@linaro.org>
 <80206cb7-b550-1cf6-abf4-e4b17de4cdb5@linaro.org>
 <20181026041107.4hofhlcubbo5claq@vireshk-i7>
 <d4d6af05-61f1-4123-c2dc-4ee0946f79e8@linaro.org>
 <20181029063450.3o3ay7pazik5tgne@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1297c984-789f-0298-c3b8-8668f5b898de@linaro.org>
Date:   Mon, 29 Oct 2018 10:26:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181029063450.3o3ay7pazik5tgne@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2018 07:34, Viresh Kumar wrote:
> On 26-10-18, 10:30, Daniel Lezcano wrote:
>> On 26/10/2018 06:11, Viresh Kumar wrote:
>>> On 25-10-18, 14:04, Daniel Lezcano wrote:
>>>> I think it is actually correct. The example is confusing on what the
>>>> numbers are. IIUC, it is:
>>>>
>>>> (after normalizing)
>>>>
>>>> dhrystone result on big CPU is 1024 at 1100MHz
>>>> dhrystone result on little CPU is 446 at 850MHz
>>>>
>>>> We have to scale the result of the little for 1100MHz in order to compare.
>>>>
>>>> 1100/850 = 1.294
>>>>
>>>> dhrystone result on little CPU is 446 * 1.294 = 577 at 1100MHz
>>>>
>>>> So we put the normalized values 1024 and 577. The arch_topology will
>>>> scale 577 back to 446 as it will compute the max capacity based on the
>>>> max freq which is 850MHz.
>>>>
>>>> The *final* capacities are 1024 for cluster0 and 446 for cluster1 (read
>>>> the cpu max capacity, the ones showed in the sysfs).
>>>>
>>>> Did I miss something ?
>>>
>>> No. What about making it more clear in the example to save the next idiot (like
>>> me) from wasting time :)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
>>> index 9b5685a1d15d..d061e6575bde 100644
>>> --- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
>>> +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
>>> @@ -61,7 +61,10 @@ mhz values (normalized w.r.t. the highest value found while parsing the DT).
>>>  Example 1 (ARM 64-bit, 6-cpu system, two clusters):
>>>  capacities-dmips-mhz are scaled w.r.t. 1024 (cpu@0 and cpu@1)
>>>  supposing cluster0@max-freq=1100 and custer1@max-freq=850,
>>> -final capacities are 1024 for cluster0 and 446 for cluster1
>>> +final capacities are 1024 for cluster0 and 446 for cluster1.
>>> +Note that the values mentioned below in the example (1024 and 578)
>>> +aren't normalized based on max frequency of each cluster and that is
>>> +left for the operating system to do.
>>
>> Yes, it will help but if you want to make things even more clear, I
>> suggest to elaborate the text a bit and give the numbers above to
>> explain (1100/850=1.294, 446 * 1.294 = 577, ...)
> 
> I didn't wanted to explain way too much, but how about this..
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> index 9b5685a1d15d..84262cdb8d29 100644
> --- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> @@ -59,9 +59,11 @@ mhz values (normalized w.r.t. the highest value found while parsing the DT).
>  ===========================================
>  
>  Example 1 (ARM 64-bit, 6-cpu system, two clusters):
> -capacities-dmips-mhz are scaled w.r.t. 1024 (cpu@0 and cpu@1)
> -supposing cluster0@max-freq=1100 and custer1@max-freq=850,
> -final capacities are 1024 for cluster0 and 446 for cluster1
> +The capacities-dmips-mhz or DMIPS/MHz values (scaled to 1024)
> +are 1024 and 578 for cluster0 and cluster1. Further normalization
> +is done by the operating system based on cluster0@max-freq=1100 and
> +custer1@max-freq=850, final capacities are 1024 for cluster0 and
> +446 for cluster1 (576*850/1100).

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

