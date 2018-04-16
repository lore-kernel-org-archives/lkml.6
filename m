Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeDPWG5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 18:06:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50234 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeDPWGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 18:06:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A760600ED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
To: Rob Herring <robh@kernel.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org, dianders@chromium.org
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
 <20180416205749.556rbkzaja33oref@rob-hp-laptop>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <aad8e393-01bd-5935-5dd8-d96e54f5aa39@codeaurora.org>
Date: Mon, 16 Apr 2018 15:06:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180416205749.556rbkzaja33oref@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 04/16/2018 01:57 PM, Rob Herring wrote:
> On Fri, Apr 13, 2018 at 07:50:34PM -0700, David Collins wrote:
>> Introduce bindings for RPMh regulator devices found on some
>> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
>> processor within the SoC to make PMIC regulator requests which
>> are aggregated within the RPMh hardware block along with requests
>> from other processors in the SoC to determine the final PMIC
>> regulator hardware state.
>>
>> Signed-off-by: David Collins <collinsd@codeaurora.org>
>> ---
>>  .../bindings/regulator/qcom,rpmh-regulator.txt     | 207 +++++++++++++++++++++
>>  .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 ++++
>> [...]
>> +++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
>> [...]
>> +- vdd_s1-supply
> 
> Use '-' rather than '_' on all these.

I will change this on the next patch set.


>> +- vdd_s2-supply
>> +- vdd_s3-supply
>> +- vdd_s4-supply
>> +- vdd_s5-supply
>> +- vdd_s6-supply
>> +- vdd_s7-supply
>> +- vdd_s8-supply
>> +- vdd_s9-supply
>> +- vdd_s10-supply
>> +- vdd_s11-supply
>> +- vdd_s12-supply
>> +- vdd_s13-supply
>> +- vdd_l1_l27-supply
>> +- vdd_l2_l8_l17-supply
>> +- vdd_l3_l11-supply
>> +- vdd_l4_l5-supply
>> +- vdd_l6-supply
>> +- vdd_l7_l12_l14_l15-supply
>> +- vdd_l9-supply
>> +- vdd_l10_l23_l25-supply
>> +- vdd_l13_l19_l21-supply
>> +- vdd_l16_l28-supply
>> +- vdd_l18_l22-supply
>> +- vdd_l20_l24-supply
>> +- vdd_l26-supply
>> +- vdd_lvs1_lvs2-supply
>> +- vdd_lvs1_lvs2-supply
>> +	Usage:      optional (PM8998 only)
>> +	Value type: <phandle>
>> +	Definition: phandle of the parent supply regulator of one or more of the
>> +		    regulators for this PMIC.
>> +
>> +- vdd_bob-supply
>> +	Usage:      optional (PMI8998 only)
>> +	Value type: <phandle>
>> +	Definition: BOB regulator parent supply phandle
>> +
>> +- vdd_s1-supply
>> +- vdd_s2-supply
>> +- vdd_s3-supply
>> +- vdd_s4-supply
> 
> Listed twice?
> 
>> +	Usage:      optional (PM8005 only)
>> +	Value type: <phandle>
>> +	Definition: phandle of the parent supply regulator of one or more of the
>> +		    regulators for this PMIC.

I listed vdd_s1-supply to vdd_s4-supply here twice because I wanted to
group together the supplies supported by each PMIC.  PM8005 only supports
these 4 regulator supplies.  PM8998 supports these 4 along with many
others.  How else would suggest that I capture this per-PMIC support
information?


>> +===============================
>> +Second Level Nodes - Regulators
>> +===============================
>> +
>> +- qcom,regulator-initial-voltage
>> +	Usage:      optional; VRM regulators only
>> +	Value type: <u32>
>> +	Definition: Specifies the initial voltage in microvolts to request for a
>> +		    VRM regulator.
>> +
>> +- regulator-initial-mode
> 
> Vendor prefix?

No, this does not need a vendor prefix.  The regulator-initial-mode
property is already defined for all regulator devices [1]:

    regulator-initial-mode: initial operating mode. The set of possible
    operating modes depends on the capabilities of every hardware so each
    device binding documentation explains which values the regulator
    supports.

The values supported by the property are hardware specific and thus must
be listed in device specific binding files like this one.  Here is a
previously merged example: [2].

Thanks,
David

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/regulator.txt?h=v4.17-rc1#n59
[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/twl-regulator.txt?h=v4.17-rc1#n60

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
