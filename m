Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23912C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C430320020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kcUomYB0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aajrbakU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C430320020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754494AbeFTN2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:28:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754453AbeFTN2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:28:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D7C8960227; Wed, 20 Jun 2018 13:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529501322;
        bh=/8JQMhXZ6LdsNiuIxxoVu2bClUHjPPTVjeEXUIgE3ds=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kcUomYB0CcpA0ji1Db77woms5esNYqRJKgmCmFNUDvo7bqu2OZHMX8j2Ob8wcFOfL
         bzLLTK9pS6uJOoIZF9yhCVT7niU6FeEPQggoF0uY55onRq4PjgLWMFCPlo3Vlu7YI8
         rWVGopVAKT5sPyt0Hebdvyq5Mo+oZEv6N6I57ag0=
Received: from [10.206.16.80] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C33E60227;
        Wed, 20 Jun 2018 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529501321;
        bh=/8JQMhXZ6LdsNiuIxxoVu2bClUHjPPTVjeEXUIgE3ds=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aajrbakU5zrp2P8Uq0TpFNcfSftwq/OrKDc+k8CBIEbshD+ycxhs5qZkdsPKR17Au
         CSFMv6YLSdkwcfAtNmhEbzIpXDMbsZvZHKN8Vn0FcuTqNPPUycw2q4ptpe/TVGVpKI
         IT+tRXYAdL3QBbYX3lKHC3yFQhYLS4eCtsM5YH5o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C33E60227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH v12 02/10] dt-bindings: introduce RPMH RSC bindings for
 Qualcomm SoCs
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org, devicetree@vger.kernel.org
References: <1529413893-5520-1-git-send-email-rplsssn@codeaurora.org>
 <1529413893-5520-3-git-send-email-rplsssn@codeaurora.org>
 <20180619225111.GD15126@tuxbook-pro>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <d1590d7e-5997-66c6-d0d2-834703f5f04d@codeaurora.org>
Date:   Wed, 20 Jun 2018 18:58:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619225111.GD15126@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/20/2018 4:21 AM, Bjorn Andersson wrote:
> On Tue 19 Jun 06:11 PDT 2018, Raju P L S S S N wrote:
> 
>> From: Lina Iyer <ilina@codeaurora.org>
>>
>> Add device binding documentation for Qualcomm Technology Inc's RPMH RSC
>> driver. The driver is used for communicating resource state requests for
>> shared resources.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> [rplsssn@codeaurora.org: minor order correction for TCS type]
> 
> In accordance with section 11 of
> Documentation/process/submitting-patches.rst you must to add your
> Signed-off-by tag at the end of this list.
> 
> Same on patch 3.

Sure Bjorn. Thanks for review.


> 
> Regards,
> Bjorn
> 
>> ---
>> Changes in v8:
>> 	- Describe IRQ for all DRVs
>>
>> Changes in v7:
>> 	- Fix example
>>
>> Changes in v6:
>> 	- Address comments from Stephen Boyd
>>
>> Changes in v3:
>> 	- Move to soc/qcom
>> 	- Amend text per Stephen's suggestions
>>
>> Changes in v2:
>> 	- Amend text to describe the registers in reg property
>> 	- Add reg-names for the registers
>> 	- Update examples to use GIC_SPI in interrupts instead of 0
>> 	- Rephrase incorrect description
>>
>> Changes in v3:
>> 	- Fix unwanted capitalization
>> 	- Remove clients from the examples, this doc does not describe
>> 	  them
>> 	- Rephrase introductory paragraph
>> 	- Remove hardware specifics from DT bindings
>> ---
>>   .../devicetree/bindings/soc/qcom/rpmh-rsc.txt      | 137 +++++++++++++++++++++
>>   1 file changed, 137 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
>> new file mode 100644
>> index 0000000..9b86d1e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
>> @@ -0,0 +1,137 @@
>> +RPMH RSC:
>> +------------
>> +
>> +Resource Power Manager Hardened (RPMH) is the mechanism for communicating with
>> +the hardened resource accelerators on Qualcomm SoCs. Requests to the resources
>> +can be written to the Trigger Command Set (TCS)  registers and using a (addr,
>> +val) pair and triggered. Messages in the TCS are then sent in sequence over an
>> +internal bus.
>> +
>> +The hardware block (Direct Resource Voter or DRV) is a part of the h/w entity
>> +(Resource State Coordinator a.k.a RSC) that can handle multiple sleep and
>> +active/wake resource requests. Multiple such DRVs can exist in a SoC and can
>> +be written to from Linux. The structure of each DRV follows the same template
>> +with a few variations that are captured by the properties here.
>> +
>> +A TCS may be triggered from Linux or triggered by the F/W after all the CPUs
>> +have powered off to facilitate idle power saving. TCS could be classified as -
>> +
>> +	ACTIVE  /* Triggered by Linux */
>> +	SLEEP   /* Triggered by F/W */
>> +	WAKE    /* Triggered by F/W */
>> +	CONTROL /* Triggered by F/W */
>> +
>> +The order in which they are described in the DT, should match the hardware
>> +configuration.
>> +
>> +Requests can be made for the state of a resource, when the subsystem is active
>> +or idle. When all subsystems like Modem, GPU, CPU are idle, the resource state
>> +will be an aggregate of the sleep votes from each of those subsystems. Clients
>> +may request a sleep value for their shared resources in addition to the active
>> +mode requests.
>> +
>> +Properties:
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: Should be "qcom,rpmh-rsc".
>> +
>> +- reg:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: The first register specifies the base address of the
>> +		    DRV(s). The number of DRVs in the dependent on the RSC.
>> +	            The tcs-offset specifies the start address of the
>> +	            TCS in the DRVs.
>> +
>> +- reg-names:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: Maps the register specified in the reg property. Must be
>> +	            "drv-0", "drv-1", "drv-2" etc and "tcs-offset". The
>> +
>> +- interrupts:
>> +	Usage: required
>> +	Value type: <prop-encoded-interrupt>
>> +	Definition: The interrupt that trips when a message complete/response
>> +	           is received for this DRV from the accelerators.
>> +
>> +- qcom,drv-id:
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: The id of the DRV in the RSC block that will be used by
>> +		    this controller.
>> +
>> +- qcom,tcs-config:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: The tuple defining the configuration of TCS.
>> +	            Must have 2 cells which describe each TCS type.
>> +	            <type number_of_tcs>.
>> +	            The order of the TCS must match the hardware
>> +	            configuration.
>> +	- Cell #1 (TCS Type): TCS types to be specified -
>> +	            ACTIVE_TCS
>> +	            SLEEP_TCS
>> +	            WAKE_TCS
>> +	            CONTROL_TCS
>> +	- Cell #2 (Number of TCS): <u32>
>> +
>> +- label:
>> +	Usage: optional
>> +	Value type: <string>
>> +	Definition: Name for the RSC. The name would be used in trace logs.
>> +
>> +Drivers that want to use the RSC to communicate with RPMH must specify their
>> +bindings as child nodes of the RSC controllers they wish to communicate with.
>> +
>> +Example 1:
>> +
>> +For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
>> +register offsets for DRV2 start at 0D00, the register calculations are like
>> +this -
>> +DRV0: 0x179C0000
>> +DRV2: 0x179C0000 + 0x10000 = 0x179D0000
>> +DRV2: 0x179C0000 + 0x10000 * 2 = 0x179E0000
>> +TCS-OFFSET: 0xD00
>> +
>> +	apps_rsc: rsc@179c0000 {
>> +		label = "apps_rsc";
>> +		compatible = "qcom,rpmh-rsc";
>> +		reg = <0x179c0000 0x10000>,
>> +		      <0x179d0000 0x10000>,
>> +		      <0x179e0000 0x10000>;
>> +		reg-names = "drv-0", "drv-1", "drv-2";
>> +		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +		qcom,tcs-offset = <0xd00>;
>> +		qcom,drv-id = <2>;
>> +		qcom,tcs-config = <ACTIVE_TCS  2>,
>> +				  <SLEEP_TCS   3>,
>> +				  <WAKE_TCS    3>,
>> +				  <CONTROL_TCS 1>;
>> +	};
>> +
>> +Example 2:
>> +
>> +For a TCS whose RSC base address is 0xAF20000 and is at DRV id of 0, the
>> +register offsets for DRV0 start at 01C00, the register calculations are like
>> +this -
>> +DRV0: 0xAF20000
>> +TCS-OFFSET: 0x1C00
>> +
>> +	disp_rsc: rsc@af20000 {
>> +		label = "disp_rsc";
>> +		compatible = "qcom,rpmh-rsc";
>> +		reg = <0xaf20000 0x10000>;
>> +		reg-names = "drv-0";
>> +		interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
>> +		qcom,tcs-offset = <0x1c00>;
>> +		qcom,drv-id = <0>;
>> +		qcom,tcs-config = <ACTIVE_TCS  0>,
>> +				  <SLEEP_TCS   1>,
>> +				  <WAKE_TCS    1>,
>> +				  <CONTROL_TCS 0>;
>> +	};
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
>>
