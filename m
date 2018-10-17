Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2609DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05462152A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o36TRvwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05462152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeJQVcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:32:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38192 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQVcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:32:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id v7-v6so24360801ljg.5;
        Wed, 17 Oct 2018 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dw64niDSnj97iLNlblqfTmDQ2TX+GOT3HuOSk5TTDnU=;
        b=o36TRvwLzV8NCNJ8wkqf16yRBDzVfaJ836rWa2pr7h9M3BYdsqXJxVGWhWrJaCXbjd
         4xca471F6O031MkdsR2an26PNywi24NhF3HLUKA9TgUvm0FrooM35UqrEwls75ZSfF3t
         uW3mDth+pplSkTIxSyDOHhqtppC++Gw05l+b5bEX29I7FMqUw5T+jVM8J+VW5WxQWes/
         ZA92qDJCI1Q4zIl9cEjLRxSZnvdRL0XGiGvehH2MffFFtKUa/XZEbRoxVqvEs7zhuQt1
         +bURKfxoWWH5EZz2z44SXhlIlWCldrH6Hsgy03z2adG8gLhL2kjkvHZBuVM1kbmMz8uW
         edAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dw64niDSnj97iLNlblqfTmDQ2TX+GOT3HuOSk5TTDnU=;
        b=KdKoXkynIrOsCAEbcUWPhLW+qDS0Qq+TFp0CnsEKjx/shQwdKyB/YO5titPGDWZ9ig
         W80TzApKbmHFl8WhxqcwXRveUioJdEIEnFpchaAORHV8nGAgW7NHnfJlj+Reyzdehhc4
         rzko9ZZ1RXe01kuW5aDGhSNskKSNmGh7/Pq0UwiEnwz6HO5BjWJr3o4mcPLx/ZsKbO3o
         DGjuCkzdI0DrYsoNBcCZImRtxbjbCuBOHF2NK2fGSZPQrUXUlM0exqoEo8vkp107rls3
         rDidKMbE3+HSOw5R06Npa7ybvIufZol8BSE7XXkP1DxW7e37EDDzWrhzm7lAqrUD8U5G
         TOjg==
X-Gm-Message-State: ABuFfojOtXWBktlem5/lLjgoNlrXhhuoL5mEo5MFBBE23D+bKvf4I3kV
        PcEIMfaVBugjH+OaxqpYyMBoE7Pt
X-Google-Smtp-Source: ACcGV63og7+8LUvI0u+C/DRv20xPg3eMzz2DqyXkqkiJaQPigaAhOE/jbsIDb0RaCn29Cv8XizihCg==
X-Received: by 2002:a2e:9247:: with SMTP id v7-v6mr16553869ljg.24.1539783390206;
        Wed, 17 Oct 2018 06:36:30 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id f81-v6sm3888973lfi.50.2018.10.17.06.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:36:29 -0700 (PDT)
Subject: Re: [PATCH v1 05/11] dt-bindings: regulator: Change
 regulator-coupled-max-spread property
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>
References: <20181005153638.1886-1-digetx@gmail.com>
 <20181005153638.1886-6-digetx@gmail.com> <20181017132501.GA19385@bogus>
 <6e9e90a1-0580-cc20-f7f9-69fefae0b3dd@gmail.com>
 <CAL_JsqKiMVNB+d3n_HJ_Mq+6wi95DS6GvZ=u0vdyAKm9E4jkdQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d12256f8-d0f6-ba13-e43b-67ac3a1ac25c@gmail.com>
Date:   Wed, 17 Oct 2018 16:36:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKiMVNB+d3n_HJ_Mq+6wi95DS6GvZ=u0vdyAKm9E4jkdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 4:33 PM, Rob Herring wrote:
> On Wed, Oct 17, 2018 at 8:32 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> On 10/17/18 4:25 PM, Rob Herring wrote:
>>> On Fri, Oct 05, 2018 at 06:36:32PM +0300, Dmitry Osipenko wrote:
>>>> Redefine binding for regulator-coupled-max-spread property in a way that
>>>> max-spread values are defined per regulator couple instead of defining
>>>> single max-spread for the whole group of coupled regulators.
>>>>
>>>> With that change the following regulators coupling configuration will be
>>>> possible:
>>>>
>>>> regA: regulatorA {
>>>>      regulator-coupled-with = <&regB &regC>;
>>>>      regulator-coupled-max-spread = <100000 300000>;
>>>> };
>>>>
>>>> regB: regulatorB {
>>>>      regulator-coupled-with = <&regA &regC>;
>>>>      regulator-coupled-max-spread = <100000 200000>;
>>>> };
>>>>
>>>> regC: regulatorC {
>>>>      regulator-coupled-with = <&regA &regB>;
>>>>      regulator-coupled-max-spread = <300000 200000>;
>>>> };
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
>>>> index a7cd36877bfe..9b525b657fca 100644
>>>> --- a/Documentation/devicetree/bindings/regulator/regulator.txt
>>>> +++ b/Documentation/devicetree/bindings/regulator/regulator.txt
>>>> @@ -76,8 +76,9 @@ Optional properties:
>>>>  - regulator-coupled-with: Regulators with which the regulator
>>>>    is coupled. The linkage is 2-way - all coupled regulators should be linked
>>>>    with each other. A regulator should not be coupled with its supplier.
>>>> -- regulator-coupled-max-spread: Max spread between voltages of coupled regulators
>>>> -  in microvolts.
>>>> +- regulator-coupled-max-spread: Array of maximum spread between voltages of
>>>> +  coupled regulators in microvolts, each value in the array relates to the
>>>> +  corresponding couple specified by the regulator-coupled-with property.
>>>
>>> Is this in use already? How is a single entry handled?
>>
>> No, it is not in use yet. Only some of the prerequisite patches were applied.
> 
> Please make that clear in the commit message.

Okay.
