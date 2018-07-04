Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368D8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E452D241C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajzEM+0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E452D241C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933756AbeGDIXx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:23:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46746 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932346AbeGDIXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:23:50 -0400
Received: by mail-wr0-f195.google.com with SMTP id s11-v6so4390047wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+rRTXHxPnBDaVWWBt1XrYHWL3ONVEAF5XBrStZsR7Yg=;
        b=ajzEM+0NeZYMTVMjWVPYP3dctzeWVynLvvuzAFid4b2Pljvheok3XnCNPSxK067QQs
         1mAAW8UrgWfGe8i7fDsDuQjk2GzApBp8m8N3dCT6xcL3yhGwstbTDpewTvAfAQ0K6Ihg
         MWzGo2ap/vz4hh6c0G/MlNT3iu9J5aTObOdBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+rRTXHxPnBDaVWWBt1XrYHWL3ONVEAF5XBrStZsR7Yg=;
        b=bAAjueEro2/NWsNDeBeIKqXYRLiXtZz6Qwn+h97hgAeyx/rEWOODlkhOSNWPxpm5ao
         RLDQcHcrx1n3bN5H+FE4U7Ms0BMnGRknIEj/Hl92yZ+dQRoaXOIt6hkYTcUAGFkucL+c
         Gd4MzSPApmHC2Q+X3AbRltjUZ4/Qgl7HcPoF1vVN3+Ul+ltlFFQTf512RNr3jGK/FYmb
         IBTdK3SB45FdG1LlCe4/RTI3Jr/Uo7IUxGOeKjrOLq23zkKjUPNxVTtc6H46jXJLTG7h
         ooN9VkFg8YI+T0cLmrhGRvdaKsMPu911ixPc/YvYl2TBiaGDPAp5B2puGJH8UHyi4Nbd
         9Z1w==
X-Gm-Message-State: APt69E2ZMTiKB/QDIFDfRtrlGSoBjlOQ0jSbssZedOYmFKDMqMSevpXM
        bacejhWMDQnA7gQUvLIEpkC4GA==
X-Google-Smtp-Source: AAOMgpfbh7IiUUAZa1Pw/bmJf8votO81OwXYqfAHmA7NnEShgWnDvghVGIZa1hTMKPZt3A5hZQ/W2g==
X-Received: by 2002:adf:ed52:: with SMTP id u18-v6mr799499wro.262.1530692629487;
        Wed, 04 Jul 2018 01:23:49 -0700 (PDT)
Received: from [192.168.8.101] ([37.173.188.193])
        by smtp.googlemail.com with ESMTPSA id 136-v6sm6774214wmr.18.2018.07.04.01.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 01:23:48 -0700 (PDT)
Subject: Re: [PATCH 0/2] Allwinner A64 timer workaround
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Rutland <Mark.Rutland@arm.com>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
 <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <24b78819-5e3f-431f-3987-f7409742ef07@linaro.org>
Date:   Wed, 4 Jul 2018 10:23:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2018 10:16, Marc Zyngier wrote:
> On 03/07/18 19:42, Samuel Holland wrote:
>> On 07/03/18 10:09, Marc Zyngier wrote:
>>> On 11/05/18 03:27, Samuel Holland wrote:
>>>> Hello,
>>>>
>>>> Several people (including me) have experienced extremely large system
>>>> clock jumps on their A64-based devices, apparently due to the architectural
>>>> timer going backward, which is interpreted by Linux as the timer wrapping
>>>> around after 2^56 cycles.
>>>>
>>>> Investigation led to discovery of some obvious problems with this SoC's 
>>>> architectural timer, and this patch series introduces what I believe is
>>>> the simplest workaround. More details are in the commit message for patch
>>>> 1. Patch 2 simply enables the workaround in the device tree.
>>>
>>> What's the deal with this series? There was a couple of nits to address, and 
>>> I was more or less expecting a v2.
>>
>> I got reports that people were still occasionally having clock jumps after
>> applying this series, so I wanted to attempt a more complete fix, but I haven't
>> had time to do any deeper investigation. I think this series is still beneficial
>> even if it's not a complete solution, so I'll come back with another patch on
>> top of this if/once I get it fully fixed.
>>
>> I'll prepare a v2 with a bounded loop. Presumably, 3 * (max CPU Hz) / (24MHz
>> timer) ≈ 150 should be a conservative iteration limit?
> 
> Should be OK.
> 
> Maxime: How do you want to deal with the documentation aspect? We need
> an erratum number, but AFAIU the concept hasn't made it into the silicom
> vendor's brain yet. Any chance you could come up with something that
> uniquely identifies this?
> 
>> Also, does this make sense to CC to stable?
> 
> Probably not, as the HW never worked, so it is not a regression.

If the patches fix a bug which already exist, it makes sense to
propagated the fix back to the stable versions.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

