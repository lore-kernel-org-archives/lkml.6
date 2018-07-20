Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24CDECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73A120652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73A120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbeGTMD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:03:56 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15142 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeGTMDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:03:55 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b51c4710000>; Fri, 20 Jul 2018 04:16:01 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 20 Jul 2018 04:16:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 20 Jul 2018 04:16:06 -0700
Received: from [10.21.132.122] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 20 Jul
 2018 11:16:06 +0000
Subject: Re: [PATCH v3 5/7] dt-bindings: Add Tegra PMC pad configuration
 bindings
To:     Aapo Vienamo <avienamo@nvidia.com>, Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1531396813-6581-1-git-send-email-avienamo@nvidia.com>
 <1531396813-6581-6-git-send-email-avienamo@nvidia.com>
 <20180716154309.GA16477@rob-hp-laptop>
 <20180717152318.3608e3f9@dhcp-10-21-25-168>
 <CAL_JsqL1F0RF_6=ho0pa7Uh4AUsyvFRDGM50gN4=6_+MwBfGYQ@mail.gmail.com>
 <20180717183020.5ab9bfa6@dhcp-10-21-25-168>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <cb67ced4-eef8-abb5-5706-3282a55edbb2@nvidia.com>
Date:   Fri, 20 Jul 2018 12:16:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717183020.5ab9bfa6@dhcp-10-21-25-168>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Linus ...

On 17/07/18 16:30, Aapo Vienamo wrote:

...

>>>>> +Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
>>>>> +
>>>>> +The values accepted by power-source property are
>>>>> +TEGRA_IO_PAD_VOLTAGE_1V8 and TEGRA_IO_PAD_VOLTAGE_3V3, which are defined
>>>>> +in dt-bindings/pinctrl/pinctrl-tegra-io-pad.h.  
>>>>
>>>> You need to list out what properties the child nodes can have.
>>>>
>>>> power-source needs a vendor prefix.  
>>>
>>> Isn't it a generic pinctrl property?  
>>
>> I don't know offhand. Doesn't look like it if you have custom values.
> 
> It's listed under "Supported generic properties" in
> pinctrl-bindings.txt. The convention seems to be not to add a vendor
> prefix even though such custom macro values are used. The property is
> currently used by qcom,pmic-gpio, qcom,pmic-mpp, and renesas,pfc-pinctrl.
> I could not find a bindings document describing it with a vendor prefix.
Looking at other users of the 'power-source' property it is not clear to
me if the values should/can be vendor specific or not. I see cases where
some people use definitions and others use actual voltages. 

Linus, any recommendations here?

Cheers
Jon	

-- 
nvpublic
