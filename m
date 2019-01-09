Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEDDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747EF20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HBI7G3cr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="efSATSTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfAIJUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:20:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39480 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbfAIJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:20:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2BD1360A08; Wed,  9 Jan 2019 09:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547025649;
        bh=RashWsKvl2d68JP1rI3JQkblxVNq5Tvc6sKchFtp94I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HBI7G3cr8KlScNehHgZ5pH17zpmphjDL4iuiD6i1v0IS0b+tJNN3Ej+IV5/zElVjK
         lq8P4ymURlJCjrM9OhrCsEIp/4GscnLw6ciKc3q3HH/3Bwvq54hJZ73Ik6Lqbq4a2U
         fUjUtiIp/HEy0PctYPoWh9Xvod5G0RQsPRggUROE=
Received: from [10.79.128.18] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD0DE608CF;
        Wed,  9 Jan 2019 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547025648;
        bh=RashWsKvl2d68JP1rI3JQkblxVNq5Tvc6sKchFtp94I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=efSATSTnkQhu9756Eop6viLLfuhkWFvQqns+CwWHWfdVYrJm3r5QsS1Hazq2KJbzM
         mFimkgvb1MM44CYIhwz3bVZfEv50fGJHgDjhGhlxeQTqg0cRR19Lrh7YGPYCAbmN1S
         QrI6N88eS1IujuKaeehEDOc2jLvrkJ7bYY/KeGW4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD0DE608CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v10 1/9] dt-bindings: opp: Introduce opp-level bindings
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     andy.gross@linaro.org, robh@kernel.org, sboyd@kernel.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com
References: <20190109090420.8100-1-rnayak@codeaurora.org>
 <20190109090420.8100-2-rnayak@codeaurora.org>
 <20190109090912.ciq4uzo5sjghyms2@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <d48db4fd-0b6b-8963-048d-3304b850e28c@codeaurora.org>
Date:   Wed, 9 Jan 2019 14:50:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190109090912.ciq4uzo5sjghyms2@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2019 2:39 PM, Viresh Kumar wrote:
> On 09-01-19, 14:34, Rajendra Nayak wrote:
>> On some SoCs (especially from Qualcomm and MediaTek) an OPP
>> node needs to describe an additional level/corner value
>> that is then communicated to a remote microprocessor by the CPU, which
>> then takes some actions (like adjusting voltage values across variousi
>> rails) based on the value passed.
>>
>> Add opp-level as an additional property in the OPP node and describe it
>> in the OPP bindings document.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/opp/opp.txt | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>> index c396c4c0af92..e83fb7cbfd58 100644
>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>> @@ -129,6 +129,11 @@ Optional properties:
>>   - opp-microamp-<name>: Named opp-microamp property. Similar to
>>     opp-microvolt-<name> property, but for microamp instead.
>>   
>> +- opp-level: On some SoC platforms an OPP node can describe a positive value
>> +  representing a corner/level that's communicated with a remote microprocessor
>> +  (usually called the power manager) which then translates it into a certain
>> +  voltage on a voltage rail.
>> +
> 
> This binding is generic enough and doesn't have anything to do with a
> remote mp and so such statements should be avoided in here. And then
> Linux can use it the way it wants.
> 
> Maybe just say that it describes the performance level of the device.
> That's all.

Sure, does this seem fine?

- opp-level: A value representing the performance level of the device,
   expressed as a 32-bit big-endian integer.

I assume the changelog mentioning the motivation behind adding this is fine?

> 
>>   - clock-latency-ns: Specifies the maximum possible transition latency (in
>>     nanoseconds) for switching to this OPP from any other OPP.
>>   
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
