Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC4BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8802B219C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lpnbbxRK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X/1m/k7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8802B219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeHHSE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:04:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52552 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeHHSE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:04:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 06EE660B1A; Wed,  8 Aug 2018 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533743052;
        bh=ywGP3+ZeEtCS3vvUb8AByxCAhCTN2UO77m0U/ifIcNk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lpnbbxRKnfTsqJN6iiEcGaOhiCYdeG+8YkCG0MTN95RVCtfVPgwXp8+7N3nfLfO8r
         K/dm8d0J/MiQ35TcXH7NHlRBdjgUZBgJ4D5o0lg3mLGlAm3XIE2IOUurZE6p7OZ5Xe
         iJOfBgQUiYj/dmN63gGzyeKVWIQD2Vv/Zq6Peuvw=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E57B6044E;
        Wed,  8 Aug 2018 15:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533743050;
        bh=ywGP3+ZeEtCS3vvUb8AByxCAhCTN2UO77m0U/ifIcNk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X/1m/k7pxEQCFceD/wYtqj/eNvxfbxQvJe88tWtw8r/9olZhj/r6v+RG2Ymbqu2y6
         U9ryrqNmRxai26/5FFJJKLzqDv8JSr566lz7KGGEA7JKh4xx9QAhT7qq/nTed2T+Gg
         xt1or/Gh8r3V2FAvzr+eliYt1zDqXVJu0St4SLyM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E57B6044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add PDC reset binding for SDM845
 SoCs
To:     Rob Herring <robh@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        ilina@codeaurora.org, jcrouse@codeaurora.org
References: <20180727152811.15258-1-sibis@codeaurora.org>
 <1533026547.3444.4.camel@pengutronix.de>
 <28f34ddf-03b2-0baa-c04f-15e546ef3f75@codeaurora.org>
 <20180807181659.GA20659@rob-hp-laptop>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <ca959e6f-b1b0-8fdf-2c40-0b49a4cf06e6@codeaurora.org>
Date:   Wed, 8 Aug 2018 21:14:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180807181659.GA20659@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
Thanks for the review

On 08/07/2018 11:46 PM, Rob Herring wrote:
> On Tue, Jul 31, 2018 at 06:27:24PM +0530, Sibi S wrote:
>> Hi Philipp,
>> Thanks for the review!
>>
>> On 07/31/2018 02:12 PM, Philipp Zabel wrote:
>>> Hi Sibi,
>>>
>>> On Fri, 2018-07-27 at 20:58 +0530, Sibi Sankar wrote:
>>>> Add SDM845 PDC (Power Domain Controller) reset controller binding
>>>>
>>>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>>>> ---
>>>>    .../bindings/reset/qcom,pdc-reset.txt         | 52 +++++++++++++++++++
>>>>    include/dt-bindings/reset/qcom,sdm845-pdc.h   | 20 +++++++
>>>>    2 files changed, 72 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
>>>>    create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
>>>> new file mode 100644
>>>> index 000000000000..85e159962e08
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
>>>> @@ -0,0 +1,52 @@
>>>> +PDC Reset Controller
>>>> +======================================
>>>> +
>>>> +This binding describes a reset-controller found on PDC-Global(Power Domain
>>>> +Controller) block for Qualcomm Technologies Inc SDM845 SoCs.
>>>> +
>>>> +Required properties:
>>>> +- compatible:
>>>> +	Usage: required
>>>> +	Value type: <string>
>>>> +	Definition: must be:
>>>> +		    "qcom,sdm845-pdc-global"
>>>> +
>>>> +- reg:
>>>> +	Usage: required
>>>> +	Value type: <prop-encoded-array>
>>>> +	Definition: must specify the base address and size of the register
>>>> +	            space.
>>>> +
>>>> +- #reset-cells:
>>>> +	Usage: required
>>>> +	Value type: <uint>
>>>> +	Definition: must be 1; cell entry represents the reset index.
>>>> +
>>>> +Example:
>>>> +
>>>> +pdc_reset: reset-controller@b2e0000 {
>>>
>>> Is this really just a reset controller?
>>>
>>> The name makes it sound like a driver binding to this should also
>>> provide pm_genpd and the binding should probably call this a power-
>>> controller: Documentation/devicetree/bindings/power/power_domain.txt.
>>>
>>
>> The PDC-global reg space which is a part of PDC-wrapper reg space seems
>> to be only used for the reset lines.
>>
>> Couple of other drivers use other parts of the PDC-wrapper reg space:
>> https://patchwork.kernel.org/patch/10223701/ (PDC-Interrupt controller)
>> https://patchwork.kernel.org/patch/10255767/ (GMU-PDC incorrectly tries
>> to occupy the entire pdc-wrapper reg space)
>>
>> since it couldn't be logically mapped into pdc-interrupt driver, it had
>> to be included as a separate reset driver.
> 
> You can't have overlapping regions in DT (well, you can because we have
> to work-around existing DTs that do, but you shouldn't).
> 
> A single node can be multiple providers such as interrupt controller and
> reset controller. It's an OS problem to split that into multiple
> drivers.
>   

There will be no overlaps. Jordan will be changing the dt binding of
gmu_pdc so that there is no overlap I guess. What I meant to say is that
pdc-global is a separate reg-space and currently has no other
functionality other than exposing the reset lines.

>>>> +	compatible = "qcom,sdm845-pdc-global";
>>>> +	reg = <0xb2e0000 0x20000>;
>>>
>>> This looks like this is the register space of the complete PDC, not just
>>> the reset register?
>>>
>>
>> The entire register space was chosen because it is only used for its
>> reset lines (had a good look at the downstream kernel and had a conversation
>> with Lina) and to ensure break backward compatibility for
>> the for the dt entry if the reg-space was used for other purposes in
>> the future.
> 
> Why do you want to ensure breaking backwards compatibility?
>

Similar to the AOSS reset driver which had a unused clock part, this
driver also exposes a reg space of which only reset lines are used.

> Rob
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
