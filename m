Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2542AC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C266321A8D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6QIuTQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C266321A8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeHIPO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:14:57 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46076 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIPO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:14:57 -0400
Received: by mail-qt0-f194.google.com with SMTP id y5-v6so6258486qti.12;
        Thu, 09 Aug 2018 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jYV4d+FTbfzaAnmLf/sqNFCeD44X02d+ak0b9cdNaf0=;
        b=G6QIuTQO4UXE36Exm0q3+zBfOOTpsabY1LlGNM1Jscs3bcuDzX2/exVbGmDvESj9qu
         o3N7nGV67NBhi0uBKNbO47nB8KwGrohD4zBo399U5+anh5GmoXSWczCmjyLY98OHU56T
         SqqBZYOIRPzatjp3uCghzv6nTl9U2+RMmaRbPA0tJ2wV1zgXfAMWvqpPOanycBLdbZsy
         EFmVB4wGhnCtff4h8Ti6XrueF8+TdiXneVMjVK9tHVrGM7BbzXBTEMDRgf4o/PGZxxWM
         KawqoaDoqazoBL88fv5pfe8KmsCSs+gFULO3kIUL9GiM/5RjPz38E6WKKup8lct8zNPK
         +3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jYV4d+FTbfzaAnmLf/sqNFCeD44X02d+ak0b9cdNaf0=;
        b=XY+YJlTh1xTDdnjfy0orRudEb1bLwxyBYidxU331hoVN2ymWzJgx7fcJDNmhJ9arEL
         kgMi/80L2Ml8gOZVuzl9sV19ssKsPMkFKcsMD6cfogSJxpyirLRQoISE0M8nXTnttUrA
         nas8T6Bm3euh6MX5A7hKwD7PnaLGCwAuF/No4hEGn0rHNuTgthA02jfO9UYM5mzli5BQ
         ZF0s7Guz0MGChCSeHgjZ9USpMFcGJu0yV5WFP97egSmPUst6/XC9GEWCvg9sOvjxNRCp
         EQYfb5F7SmnA2ahahWyHbu12yUC4s3xSmDZFb33c+9cWbLHOQa17a0GmP/COJJSuufBw
         JBGA==
X-Gm-Message-State: AOUpUlEvSlan6mYM9phsh+bP1H+IXKtPSIOIJGt5wv3J96yaTufHMLzV
        lOg52ryy5Z+d6rkbbnK7goZ/jzvRy8A=
X-Google-Smtp-Source: AA+uWPwactbOWyakgtqwDIDudHa483fQ15+P2tFEtHvm4ekULPfjlhmD1sXt82523iECxMNfJUWtwQ==
X-Received: by 2002:a0c:9408:: with SMTP id h8-v6mr1647713qvh.135.1533819009799;
        Thu, 09 Aug 2018 05:50:09 -0700 (PDT)
Received: from [192.168.44.96] (107.sub-174-204-8.myvzw.com. [174.204.8.107])
        by smtp.gmail.com with ESMTPSA id m15-v6sm4857638qki.44.2018.08.09.05.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 05:50:09 -0700 (PDT)
Subject: Re: [PATCH 5/8] arm64: dts: tegra186: Add SDMMC4 DQS trim value
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-6-git-send-email-avienamo@nvidia.com>
 <20180809114922.GN21639@ulmo> <20180809150226.64657f56@dhcp-10-21-25-168>
 <03fc6726-25ff-20de-d271-ebae19b753c7@gmail.com>
 <20180809153732.4c91e425@dhcp-10-21-25-168>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <66f8381b-7c57-d88b-6e75-e9df7843f93c@gmail.com>
Date:   Thu, 9 Aug 2018 08:50:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809153732.4c91e425@dhcp-10-21-25-168>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2018 08:37 AM, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 08:23:16 -0400
> Peter Geis <pgwipeout@gmail.com> wrote:
> 
>> On 08/09/2018 08:02 AM, Aapo Vienamo wrote:
>>> On Thu, 9 Aug 2018 13:49:22 +0200
>>> Thierry Reding <thierry.reding@gmail.com> wrote:
>>>    
>>>> On Tue, Aug 07, 2018 at 05:00:01PM +0300, Aapo Vienamo wrote:
>>>>> Add the HS400 DQS trim value for Tegra186 SDMMC4.
>>>>>
>>>>> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>>>> index 6e9ef26..9e07bc6 100644
>>>>> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>>>> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>>>> @@ -313,6 +313,7 @@
>>>>>    		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
>>>>>    		nvidia,default-tap = <0x5>;
>>>>>    		nvidia,default-trim = <0x9>;
>>>>> +		nvidia,dqs-trim = <63>;
>>>>>    		status = "disabled";
>>>>>    	};
>>>>>        
>>>>
>>>> Isn't this technically dependent on the board layout and as such would
>>>> belong in the board DTS file? Or does this value work on all existing
>>>> Tegra186 platforms?
>>>
>>> This value is specified as part of the controller initialization
>>> sequence in the TRM. I've understood that this (and other tap and trim)
>>> value(s) are used for compensating the propagation delay differences
>>> that are caused by the internal SoC layout.
>>>
>>>    -Aapo
>>> --
>>
>> The Tegra2 and Tegra3 TRMs also specify recommended DQS values, and I am
>> working on at least one device that differs in the platform data from
>> the default value.
>> I see that you mentioned this is for the newer devices that support
>> HS200/HS400 modes, but does it enable setting DQS on older devices?
> 
> I can't find any mention of _SDMMC_ DQS trimmer on Tegra2, Tegra3 or
> Tegra124 TRMs. As far as I can tell, programming the DQS trimmer value
> is only required by HS400 signaling on Tegra210 and Tegra186.
> 
>   -Aapo
> 
Apologies, I was referring to the default Tap/Trim values.
DQS found it's way into my brain from the memory controller.
