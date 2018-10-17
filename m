Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6595DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298E521526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbrOmzod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298E521526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJQV1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:27:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44801 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQV1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:27:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so24318291ljc.11;
        Wed, 17 Oct 2018 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Umqz6DOyuzsy5bU7qljvf/76EaBQ7uBVwGQKg/8R5Q=;
        b=jbrOmzodOOjcEePkcBjp53+r5bqC8RY/9hL4MA/4NnhzRcwSx7U1ltMCVHaC3UwNDy
         53whOc1xnrXejexfRGnXlgc3N7rNmWtbbOvUih82OSnqfHH7rTc5IzKn9RghDTwPvttI
         cRZ2mT5whW/fVWSbaFqS4HiYsCSIQpt+axrzSw44nCDreN1iPciQxysRFgw4wzdqePD9
         Mt6vTpkXaSDcZoZVaKIVEO8REylsmagyod6ln3Ciki57luYQMsyXcuZaOtf96/2HfXDE
         Q1mhsWSH+VknjxIh/caxbShcVZEULJTjyi8Nbuts0yAvS4JATTZalSHn0T4FsiaI9RGq
         IZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Umqz6DOyuzsy5bU7qljvf/76EaBQ7uBVwGQKg/8R5Q=;
        b=ZySV63Fsc7PBRdeEwhvSqbK9o7Uvp04RAo14ORfj0h1kU37JKjgGPXwzLG1QTc/umZ
         iiYwEG/SQf9jzT3jyaqX/uptE7Pl85OxrbTcUllBvDfPf9FR4Yu4k+etDwYtgfJCaQ4J
         NkdfmBDXr1E70XZUI2hvbJlyAD/jTZmx6xMZO5UXqJuRrgBcCBLg8tY/JMQrDy3/l3Du
         AKkj6H4VqmDQ4Mc1CiDKAPFET1Z3+9azXN38NT+MhfPmqbAYSlS7iu+HZ7p/4pn653mi
         wCqfCxXb0AHOTnJAkZNrxoH6gYwoyZlK0SQ/eINVmESLrM+877SZ9khYarsreQ7Mx74e
         QU5w==
X-Gm-Message-State: ABuFfoh2r66+YjsX0JMGAOChnHLvWdSTOGkpDIAFPLSmmg+tdYS3Iesf
        ht+hUa4gsUaQNdO+PQvidytIWgZC
X-Google-Smtp-Source: ACcGV63oeHs7ODIPmZMnmBMw2cSfuea2wBDNVyWcFkogiAAOLO7JBZRlsjiMDt616af6L+OMCmaKXA==
X-Received: by 2002:a2e:1456:: with SMTP id 22-v6mr16730622lju.116.1539783129860;
        Wed, 17 Oct 2018 06:32:09 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id y3-v6sm4079137ljy.95.2018.10.17.06.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:32:09 -0700 (PDT)
Subject: Re: [PATCH v1 05/11] dt-bindings: regulator: Change
 regulator-coupled-max-spread property
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
References: <20181005153638.1886-1-digetx@gmail.com>
 <20181005153638.1886-6-digetx@gmail.com> <20181017132501.GA19385@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6e9e90a1-0580-cc20-f7f9-69fefae0b3dd@gmail.com>
Date:   Wed, 17 Oct 2018 16:32:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181017132501.GA19385@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 4:25 PM, Rob Herring wrote:
> On Fri, Oct 05, 2018 at 06:36:32PM +0300, Dmitry Osipenko wrote:
>> Redefine binding for regulator-coupled-max-spread property in a way that
>> max-spread values are defined per regulator couple instead of defining
>> single max-spread for the whole group of coupled regulators.
>>
>> With that change the following regulators coupling configuration will be
>> possible:
>>
>> regA: regulatorA {
>> 	regulator-coupled-with = <&regB &regC>;
>> 	regulator-coupled-max-spread = <100000 300000>;
>> };
>>
>> regB: regulatorB {
>> 	regulator-coupled-with = <&regA &regC>;
>> 	regulator-coupled-max-spread = <100000 200000>;
>> };
>>
>> regC: regulatorC {
>> 	regulator-coupled-with = <&regA &regB>;
>> 	regulator-coupled-max-spread = <300000 200000>;
>> };
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
>> index a7cd36877bfe..9b525b657fca 100644
>> --- a/Documentation/devicetree/bindings/regulator/regulator.txt
>> +++ b/Documentation/devicetree/bindings/regulator/regulator.txt
>> @@ -76,8 +76,9 @@ Optional properties:
>>  - regulator-coupled-with: Regulators with which the regulator
>>    is coupled. The linkage is 2-way - all coupled regulators should be linked
>>    with each other. A regulator should not be coupled with its supplier.
>> -- regulator-coupled-max-spread: Max spread between voltages of coupled regulators
>> -  in microvolts.
>> +- regulator-coupled-max-spread: Array of maximum spread between voltages of
>> +  coupled regulators in microvolts, each value in the array relates to the
>> +  corresponding couple specified by the regulator-coupled-with property.
> 
> Is this in use already? How is a single entry handled?

No, it is not in use yet. Only some of the prerequisite patches were applied. 

Initially single entry was supposed to be re-used by all of regulator couples. Now single entry describes a single couple only.
