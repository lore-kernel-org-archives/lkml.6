Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E72C04ABA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1ED2214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Eh2ubnVc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HfubV5uK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1ED2214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbeIRP5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:57:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39656 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIRP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:57:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2C39B605BD; Tue, 18 Sep 2018 10:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537266344;
        bh=btgctxqnI2qTRblx9Z+Ecu+u9pBln2m5+X6m1Z1RuG8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Eh2ubnVcTU5trDRMijS1RcpIdnH3XTfSoTPjCJZeCWa+JO38gw6XodrDSXqVHZZCW
         0X9VsJm0fUZSlrnzCE/vIMgzdrzvlAoE943nBH9nmdU+6dTcV/ro6ZKKS8fw2dv4a6
         VrCmaUlp7pQiTzYLFF7E084ldbz6KuhJs8xCVi6w=
Received: from [10.79.174.22] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67E13605BD;
        Tue, 18 Sep 2018 10:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537266342;
        bh=btgctxqnI2qTRblx9Z+Ecu+u9pBln2m5+X6m1Z1RuG8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HfubV5uKpsbVSK4mk38GnEaHheGKkDtt00Ac3V+mV5NHSD2gnSCCPwd8W651WKBZp
         ROxG7spQgt99Py4S+UsU2IKnAi/ypwUzmVPzqfcefyJiaU2JGumW775Dd1TpDhAkve
         PBHuJEsqk9XapcQhHAfW8IatWbtP85enmWIF95cQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67E13605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: Introduce QCOM LPASS clock
 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1536685206-12239-1-git-send-email-tdas@codeaurora.org>
 <1536685206-12239-2-git-send-email-tdas@codeaurora.org>
 <20180917031811.GA11141@bogus>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <e04d9bcf-0559-922c-8d9a-8dacfcd4e814@codeaurora.org>
Date:   Tue, 18 Sep 2018 15:55:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917031811.GA11141@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thanks for the review comments.

On 9/17/2018 8:48 AM, Rob Herring wrote:
> On Tue, Sep 11, 2018 at 10:30:05PM +0530, Taniya Das wrote:
>> Add device tree bindings for Low Power Audio subsystem clock controller for
>> Qualcomm Technology Inc's SDM845 SoCs.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   .../devicetree/bindings/clock/qcom,gcc.txt         |  2 ++
>>   .../devicetree/bindings/clock/qcom,lpasscc.txt     | 31 ++++++++++++++++++++++
>>   include/dt-bindings/clock/qcom,gcc-sdm845.h        |  2 ++
>>   include/dt-bindings/clock/qcom,lpass-sdm845.h      | 16 +++++++++++
>>   4 files changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
>>   create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
>> index 664ea1f..b3ff6e8 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
>> @@ -32,6 +32,8 @@ be part of GCC and hence the TSENS properties can also be
>>   part of the GCC/clock-controller node.
>>   For more details on the TSENS properties please refer
>>   Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>> +- qcom,lpass-protected : Indicate that the LPASS clock branches within GCC are
>> +			 unusable due to firmware access control restrictions.
>>   
>>   Example:
>>   	clock-controller@900000 {
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
>> new file mode 100644
>> index 0000000..d312957
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
>> @@ -0,0 +1,31 @@
>> +Qualcomm LPASS Clock Controller Binding
>> +-----------------------------------------------
>> +
>> +Required properties :
>> +- compatible		: shall contain "qcom,sdm845-lpasscc"
>> +- #clock-cells		: from common clock binding, shall contain 1.
>> +- reg			: shall contain base register address and size,
>> +			  in the order
>> +			Index-0 maps to LPASS_CC register region
>> +			Index-1 maps to LPASS_QDSP6SS register region
>> +
>> +Optional properties :
>> +- reg-names	: register names of LPASS domain
>> +		 "lpass_cc", "lpass_qdsp6ss".
> 
> "cc" and "qdsp6ss" is sufficient.
> 

Sure will update in the next patch series.

>> +
>> +Example:
>> +
>> +The below node has to be defined in the cases where the LPASS peripheral loader
>> +would bring the subsystem out of reset.
>> +
>> +	lpasscc: clock-controller {
> 
> Needs a unit-address.
> 

Yes, my mistake. Missed adding it.

>> +		compatible = "qcom,sdm845-lpasscc";
>> +		reg = <0x17014000 0x1f004>, <0x17300000 0x200>;
>> +		reg-names = "lpass_cc", "lpass_qdsp6ss";
>> +		#clock-cells = <1>;
>> +	};
>> +
>> +	gcc: clock-controller@100000 {
> 
> This needs a reg property.
> 

Sure, will update the same.

>> +		compatible = "qcom,gcc-sdm845";
>> +		qcom,lpass-protected;
>> +	};
> 
>> diff --git a/include/dt-bindings/clock/qcom,gcc-sdm845.h b/include/dt-bindings/clock/qcom,gcc-sdm845.h
>> index b8eae5a..968fa65 100644
>> --- a/include/dt-bindings/clock/qcom,gcc-sdm845.h
>> +++ b/include/dt-bindings/clock/qcom,gcc-sdm845.h
>> @@ -197,6 +197,8 @@
>>   #define GCC_QSPI_CORE_CLK_SRC					187
>>   #define GCC_QSPI_CORE_CLK					188
>>   #define GCC_QSPI_CNOC_PERIPH_AHB_CLK				189
>> +#define GCC_LPASS_Q6_AXI_CLK					190
>> +#define GCC_LPASS_SWAY_CLK					191
>>   
>>   /* GCC Resets */
>>   #define GCC_MMSS_BCR						0
>> diff --git a/include/dt-bindings/clock/qcom,lpass-sdm845.h b/include/dt-bindings/clock/qcom,lpass-sdm845.h
>> new file mode 100644
>> index 0000000..015968e
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/qcom,lpass-sdm845.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
>> +#define _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
>> +
>> +#define LPASS_AUDIO_WRAPPER_AON_CLK			0
>> +#define LPASS_Q6SS_AHBM_AON_CLK				1
>> +#define LPASS_Q6SS_AHBS_AON_CLK				2
>> +#define LPASS_QDSP6SS_XO_CLK				3
>> +#define LPASS_QDSP6SS_SLEEP_CLK				4
>> +#define LPASS_QDSP6SS_CORE_CLK				5
>> +
>> +#endif
>> -- 
>> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
>> of the Code Aurora Forum, hosted by the  Linux Foundation.
>>
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
