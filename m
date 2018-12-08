Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC5FC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FEF2081F
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="Wjux+sY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FEF2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeLHSQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:16:29 -0500
Received: from [80.88.177.70] ([80.88.177.70]:49188 "EHLO mail2.kuutio.org"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeLHSQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:16:28 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Dec 2018 13:16:25 EST
Received: from localhost (localhost [127.0.0.1])
        by mail2.kuutio.org (Postfix) with ESMTP id DD77C4D1F52;
        Sat,  8 Dec 2018 20:10:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        content-language:content-transfer-encoding:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:subject:subject:received
        :received; s=dkim; t=1544292620; x=1546884621; bh=ISF+5f/AoxEDNR
        J4LOo2Q2wzVBCYB8ohIes4y7Oq+JA=; b=Wjux+sY7Rg+mzfVjNMTeTd0Z6LvZiw
        Zq3FyM8NB3MEzAuGA/wbpV3mNXh/qt/i+agHSIKyUmwk9Pe/FQmDNaA2TtJRzGNX
        ARSrrPK7F2ACQvw4WB41FkSzmc95NLX0dklL5/YZCzcokRQDZpWuuXAwHDrPj85H
        S3tWZ8g0dtiv87kuDQgxGq1sx5vA+q0A3wFUrcHE3cE0hROD+pEk8M9eWiYxETTC
        bhmqPT+SvLa2rZa2PH0GFSvC5dlY10RuFJiGS4zQkAbvfWLk5n9rlXWkyCw1Vq7R
        LiLjsUvzAjxcTxsihyYsDXvAgNhDRq3xTVyMSpx8DKu04rR/rsXh2+5PXLswE/gj
        IcH7NhfjUMkTTwdDJF7lFXyZPUuNfUTZSDsfTibLr4UZTzi/u7BJ7kFXrInsB0Vo
        GxFK3Mialf7HEurX9Cdp/vPclA6l567PEVIZAyv3zYtkomX07Ce66uS57mDrvsfy
        nLkGGKKpqXHPnTXbba40Q2HHiP5WTerVRrXp9rbre9m6uuQlt1RzXI7ks0KVswfl
        Oa/1BucDIwVjPG6+SuPscPgZhDhju+HbcTTDrzWcJkoKRwLugRyfcLxtcIXaJkXK
        H+Ah08nqjjICvRn7sg9R+4LwW3LWc4zhtn25ky3qnwbMQDR1raBo3r+idYWe//1D
        Ql8t/aBTzsSUI=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail2.kuutio.org ([127.0.0.1])
        by localhost (mail2.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id DfuJmsqxJ0pY; Sat,  8 Dec 2018 20:10:20 +0200 (EET)
Received: from hiekka.kuutio.org (unknown [IPv6:2001:998:13:e1::beef])
        by mail2.kuutio.org (Postfix) with ESMTPSA id 0A6174D1F51;
        Sat,  8 Dec 2018 20:10:20 +0200 (EET)
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net> <20181207164011.GI26661@dell>
From:   =?UTF-8?Q?Oskari_Lemmel=c3=a4?= <oskari@lemmela.net>
Message-ID: <25d04cec-e52e-f36a-4a96-f04810d662f8@lemmela.net>
Date:   Sat, 8 Dec 2018 20:10:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181207164011.GI26661@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 12/7/18 6:40 PM, Lee Jones wrote:
> On Tue, 20 Nov 2018, Oskari Lemmela wrote:
>
>> Parts of the AXP803 are compatible with their counterparts on the AXP813.
>> These include the GPIO, ADC, AC and battery power supplies.
>>
>> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
>> ---
>>   drivers/mfd/axp20x.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index dfc3cff1d08b..e415b967d38c 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -728,11 +728,26 @@ static const struct mfd_cell axp288_cells[] = {
>>   
>>   static const struct mfd_cell axp803_cells[] = {
>>   	{
>> +		.name		= "axp20x-gpio",
>> +		.of_compatible	= "x-powers,axp813-gpio",
>> +	}, {
>>   		.name			= "axp221-pek",
>>   		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
>>   		.resources		= axp803_pek_resources,
>>   	},
>>   	{	.name			= "axp20x-regulator" },
>> +	{
>> +		.name		= "axp813-adc",
>> +		.of_compatible	= "x-powers,axp813-adc",
>> +	}, {
>> +		.name		= "axp20x-battery-power-supply",
>> +		.of_compatible	= "x-powers,axp813-battery-power-supply",
>> +	}, {
>> +		.name		= "axp20x-ac-power-supply",
>> +		.of_compatible	= "x-powers,axp813-ac-power-supply",
>> +		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
>> +		.resources	= axp20x_ac_power_supply_resources,
>> +	},
>>   };
> My OCD-dar is going crazy.
>
> Why haven't you used the same alignment as is already there?
>
> If it starts to run over 80-chars then bring the others back.
>
> Also why is there a single liner shoved in the middle of the
> multi-line entries?  Please move the singles to the top or the
> bottom.
>
I sent patch set v8 which contains ChenYu's re-align patch and
this patch rebased top of it.

Re-align patch will make number of whitespaces consistent in axp20x.c

Thanks,
Oskari


