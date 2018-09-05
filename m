Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0282C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735FF20652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LSPODK3u";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LSPODK3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735FF20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeIEW6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:58:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeIEW6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:58:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C6D2C606AC; Wed,  5 Sep 2018 18:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536172004;
        bh=9Ks23OwVNByBOZE0dvBwGZK5oy8Cb9rG/KDmGsD/AyI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LSPODK3u7b6gykUv5gVDYPvMjfTXWGILM0WokQoT3TlI6pALl2elIzsES/J/gOHNB
         irKawHjdN2lwkYkS7UVJ9RaZUiNSY4MRqWw02LDTDR/aZMxizEeiSwhlTz+NoQl5iM
         00ufu/J5ai6tC4S1K0AuYJtUcb7FpaFtpOzN/CIY=
Received: from [192.168.225.247] (unknown [49.33.224.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0926960558;
        Wed,  5 Sep 2018 18:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536172004;
        bh=9Ks23OwVNByBOZE0dvBwGZK5oy8Cb9rG/KDmGsD/AyI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LSPODK3u7b6gykUv5gVDYPvMjfTXWGILM0WokQoT3TlI6pALl2elIzsES/J/gOHNB
         irKawHjdN2lwkYkS7UVJ9RaZUiNSY4MRqWw02LDTDR/aZMxizEeiSwhlTz+NoQl5iM
         00ufu/J5ai6tC4S1K0AuYJtUcb7FpaFtpOzN/CIY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0926960558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: Introduce QCOM LPASS clock
 bindings
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
References: <1533298874-22863-1-git-send-email-tdas@codeaurora.org>
 <1533298874-22863-2-git-send-email-tdas@codeaurora.org>
 <153540448713.129321.8622050618939041593@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <47adf305-f649-dca6-e45e-51c7b418d418@codeaurora.org>
Date:   Wed, 5 Sep 2018 23:56:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153540448713.129321.8622050618939041593@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for the review comments.

On 8/28/2018 2:44 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-08-03 05:21:13)
>> Add device tree bindings for Low Power Audio subsystem clock controller for
>> Qualcomm Technology Inc's SDM845 SoCs.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   .../devicetree/bindings/clock/qcom,gcc.txt         |  2 ++
>>   .../devicetree/bindings/clock/qcom,lpasscc.txt     | 33 ++++++++++++++++++++++
>>   include/dt-bindings/clock/qcom,gcc-sdm845.h        |  2 ++
>>   include/dt-bindings/clock/qcom,lpass-sdm845.h      | 16 +++++++++++
>>   4 files changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
>>   create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
>> index 664ea1f..e452abc 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
>> @@ -32,6 +32,8 @@ be part of GCC and hence the TSENS properties can also be
>>   part of the GCC/clock-controller node.
>>   For more details on the TSENS properties please refer
>>   Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>> +- qcom,lpass-protected : Indicate GCC to be able to access the
>> +                       lpass gcc clock branches.
> 
> This doesn't parse well for me. Maybe something like:
> 
> 'Indicate that the LPASS clock branches within GCC are unusable due to
> firmware access control restrictions'?
> 

Sure, will update in the next series.

>>
>>   Example:
>>          clock-controller@900000 {
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
>> new file mode 100644
>> index 0000000..062e413
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
>> @@ -0,0 +1,33 @@
>> +Qualcomm LPASS Clock Controller Binding
>> +-----------------------------------------------
>> +
>> +Required properties :
>> +- compatible           : shall contain "qcom,sdm845-lpasscc"
>> +- #clock-cells         : from common clock binding, shall contain 1.
>> +- reg                  : shall contain base register address and size,
>> +                         in the order
>> +                       Index-0 maps to LPASS_CC register region
>> +                       Index-1 maps to LPASS_QDSP6SS register region
>> +- qcom,lpass-protected : Boolean property to indicate to GCC clock controller
>> +                        for the lpass GCC clocks.
> 
> Why is this here?
> 

Yes, I kept it to make sure it is marked in GCC clock driver too. May be 
should remove it.

>> +
>> +Optional properties :
>> +- reg-names    : register names of LPASS domain
>> +                "lpass_cc", "lpass_qdsp6ss".
>> +
>> +Example:
>> +
>> +The below node has to be defined in the cases where the LPASS peripheral loader
>> +would bring the subsystem out of reset.
>> +
>> +       lpasscc: clock-controller {
>> +               compatible = "qcom,sdm845-lpasscc";
>> +               reg = <0x17014000 0x1f004>, <0x17300000 0x200>;
>> +               reg-names = "lpass_cc", "lpass_qdsp6ss";
>> +               #clock-cells = <1>;
>> +       };
>> +
>> +       gcc: clock-controller@100000 {
>> +               compatible = "qcom,gcc-sdm845";
>> +               qcom,lpass-protected;
>> +       };

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
