Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753828AbeEaEPe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:15:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44608 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbeEaEPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:15:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FAEF60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 5/6] soc: qcom: rpmh powerdomain driver
To: Rob Herring <robh@kernel.org>
Cc: viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        collinsd@codeaurora.org
References: <20180525100121.28214-1-rnayak@codeaurora.org>
 <20180525100121.28214-6-rnayak@codeaurora.org>
 <20180531033110.GA19195@rob-hp-laptop>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <9016e169-6c2a-57fd-4461-d5ec1e1aa573@codeaurora.org>
Date: Thu, 31 May 2018 09:45:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180531033110.GA19195@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/31/2018 09:01 AM, Rob Herring wrote:
> On Fri, May 25, 2018 at 03:31:20PM +0530, Rajendra Nayak wrote:
>> The RPMh powerdomain driver aggregates the corner votes from various
>> consumers for the ARC resources and communicates it to RPMh.
>>
>> We also add data for all powerdomains on sdm845 as part of the patch.
>> The driver can be extended to support other SoCs which support RPMh
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  .../devicetree/bindings/power/qcom,rpmhpd.txt |  65 ++++
>>  drivers/soc/qcom/Kconfig                      |   9 +
>>  drivers/soc/qcom/Makefile                     |   1 +
>>  drivers/soc/qcom/rpmhpd.c                     | 360 ++++++++++++++++++
>>  4 files changed, 435 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
>>  create mode 100644 drivers/soc/qcom/rpmhpd.c
>>
>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
>> new file mode 100644
>> index 000000000000..c1fa986c12ee
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
>> @@ -0,0 +1,65 @@
>> +Qualcomm RPMh Powerdomains
>> +
>> +* For RPMh powerdomains, we communicate a performance state to RPMh
>> +which then translates it into a corresponding voltage on a rail
>> +
>> +Required Properties:
>> + - compatible: Should be one of the following
>> +	* qcom,sdm845-rpmhpd: RPMh powerdomain for the sdm845 family of SoC
>> + - power-domain-cells: number of cells in power domain specifier
>> +	must be 1
>> + - operating-points-v2: Phandle to the OPP table for the power-domain.
>> +	Refer to Documentation/devicetree/bindings/power/power_domain.txt
>> +	and Documentation/devicetree/bindings/opp/qcom-opp.txt for more details
>> +
>> +Example:
>> +
>> +	rpmhpd: power-controller {
>> +		compatible = "qcom,sdm845-rpmhpd";
>> +		#power-domain-cells = <1>;
>> +		operating-points-v2 = <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>;
>> +	};
>> +
>> +	rpmhpd_opp_table: opp-table {
>> +		compatible = "operating-points-v2-qcom-level", "operating-points-v2";
>> +
>> +		rpmhpd_opp1: opp@1 {
>> +			qcom-corner = <16>;
> 
> Is it corner or level?

It should be level, I will fix it up when I respin. thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
