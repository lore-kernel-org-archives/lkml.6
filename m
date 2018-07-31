Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F76FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DDB208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iJ0DImCG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M1jLrwK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DDB208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbeGaOhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:37:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35748 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732113AbeGaOhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:37:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 289F9606CF; Tue, 31 Jul 2018 12:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533041857;
        bh=PqStXg5KVRUUKM0Pgvagz/9Tbg985i/fbThJMEeyIKA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iJ0DImCGoZ7gFgkW6fTn4xxd1Iwqp8Tq6N3vieJP559KJPdob1Av6QwcZ5Q6OqfTr
         r2kXZ2Nif3PpQamIl3gFP2B+t+aoqR5RH8nKg5OL1ctuNy5VI+mRVsAMdxGiXHRx1A
         y5di+3/LnkQ/LnacJyDd+j5G+dv0pDGMzk/gGR04=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B850160264;
        Tue, 31 Jul 2018 12:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533041856;
        bh=PqStXg5KVRUUKM0Pgvagz/9Tbg985i/fbThJMEeyIKA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M1jLrwK4mcpyyhNqbIBWJdYpfxKtIsWkYCd9KDmiOFAiYlDx8HNEnPxp8ZwqlDCyj
         8rjQEVIFiCNWiEc2AruNHacEBJmWa8Sbe5Hq0U9Zwtfh47tRR1ati64ElDO7Ae28EQ
         xPspyYGl4NTD+/HDPR5vddfl3djtNAq9URebtiFE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B850160264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add PDC reset binding for SDM845
 SoCs
To:     Philipp Zabel <p.zabel@pengutronix.de>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        ilina@codeaurora.org
References: <20180727152811.15258-1-sibis@codeaurora.org>
 <1533026547.3444.4.camel@pengutronix.de>
From:   Sibi S <sibis@codeaurora.org>
Message-ID: <28f34ddf-03b2-0baa-c04f-15e546ef3f75@codeaurora.org>
Date:   Tue, 31 Jul 2018 18:27:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1533026547.3444.4.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,
Thanks for the review!

On 07/31/2018 02:12 PM, Philipp Zabel wrote:
> Hi Sibi,
> 
> On Fri, 2018-07-27 at 20:58 +0530, Sibi Sankar wrote:
>> Add SDM845 PDC (Power Domain Controller) reset controller binding
>>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>   .../bindings/reset/qcom,pdc-reset.txt         | 52 +++++++++++++++++++
>>   include/dt-bindings/reset/qcom,sdm845-pdc.h   | 20 +++++++
>>   2 files changed, 72 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
>>   create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
>>
>> diff --git a/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
>> new file mode 100644
>> index 000000000000..85e159962e08
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
>> @@ -0,0 +1,52 @@
>> +PDC Reset Controller
>> +======================================
>> +
>> +This binding describes a reset-controller found on PDC-Global(Power Domain
>> +Controller) block for Qualcomm Technologies Inc SDM845 SoCs.
>> +
>> +Required properties:
>> +- compatible:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: must be:
>> +		    "qcom,sdm845-pdc-global"
>> +
>> +- reg:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: must specify the base address and size of the register
>> +	            space.
>> +
>> +- #reset-cells:
>> +	Usage: required
>> +	Value type: <uint>
>> +	Definition: must be 1; cell entry represents the reset index.
>> +
>> +Example:
>> +
>> +pdc_reset: reset-controller@b2e0000 {
> 
> Is this really just a reset controller?
> 
> The name makes it sound like a driver binding to this should also
> provide pm_genpd and the binding should probably call this a power-
> controller: Documentation/devicetree/bindings/power/power_domain.txt.
> 

The PDC-global reg space which is a part of PDC-wrapper reg space seems
to be only used for the reset lines.

Couple of other drivers use other parts of the PDC-wrapper reg space:
https://patchwork.kernel.org/patch/10223701/ (PDC-Interrupt controller)
https://patchwork.kernel.org/patch/10255767/ (GMU-PDC incorrectly tries
to occupy the entire pdc-wrapper reg space)

since it couldn't be logically mapped into pdc-interrupt driver, it had
to be included as a separate reset driver.

>> +	compatible = "qcom,sdm845-pdc-global";
>> +	reg = <0xb2e0000 0x20000>;
> 
> This looks like this is the register space of the complete PDC, not just
> the reset register?
> 

The entire register space was chosen because it is only used for its
reset lines (had a good look at the downstream kernel and had a 
conversation with Lina) and to ensure break backward compatibility for
the for the dt entry if the reg-space was used for other purposes in
the future.

>> +	#reset-cells = <1>;
>> +};
>> +
>> +PDC reset clients
>> +======================================
>> +
>> +Device nodes that need access to reset lines should
>> +specify them as a reset phandle in their corresponding node as
>> +specified in reset.txt.
>> +
>> +For list of all valid reset indicies see
>> +<dt-bindings/reset/qcom,sdm845-pdc.h>
>> +
>> +Example:
>> +
>> +modem-pil@4080000 {
>> +	...
>> +
>> +	resets = <&pdc_reset PDC_MODEM_SYNC_RESET>;
>> +	reset-names = "pdc_restart";
>> +
>> +	...
>> +};
>> diff --git a/include/dt-bindings/reset/qcom,sdm845-pdc.h b/include/dt-bindings/reset/qcom,sdm845-pdc.h
>> new file mode 100644
>> index 000000000000..53c37f9c319a
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/qcom,sdm845-pdc.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_RESET_PDC_SDM_845_H
>> +#define _DT_BINDINGS_RESET_PDC_SDM_845_H
>> +
>> +#define PDC_APPS_SYNC_RESET	0
>> +#define PDC_SP_SYNC_RESET	1
>> +#define PDC_AUDIO_SYNC_RESET	2
>> +#define PDC_SENSORS_SYNC_RESET	3
>> +#define PDC_AOP_SYNC_RESET	4
>> +#define PDC_DEBUG_SYNC_RESET	5
>> +#define PDC_GPU_SYNC_RESET	6
>> +#define PDC_DISPLAY_SYNC_RESET	7
>> +#define PDC_COMPUTE_SYNC_RESET	8
>> +#define PDC_MODEM_SYNC_RESET	9
>> +
>> +#endif
> 
> regards
> Philipp
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
