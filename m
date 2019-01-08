Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15B7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EC1206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gioYuOC0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aTlD1c/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfAHMet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:34:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45146 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHMet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:34:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AA566606AC; Tue,  8 Jan 2019 12:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546950887;
        bh=rS/4Zn8+qiW7zhhEzHOGjAVsyremPn6L+R2IxwrnbXw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gioYuOC00YrywgnBvBCFEtcRNdJAffWRKN/1Asy+7WYHLBDCgTFHkg3JH5jyEAq8V
         eD/82Xs4pHj6goceQ1Pyb75QWwJrT3/aFUE0dWz/iFkoSSw2iYuh3QpLrdcumm0KTa
         KngYGUs5EeCwXuK4vlGQDwVBXK8UHBT0wig3NUtk=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15D08601D7;
        Tue,  8 Jan 2019 12:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546950886;
        bh=rS/4Zn8+qiW7zhhEzHOGjAVsyremPn6L+R2IxwrnbXw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aTlD1c/HKhUzJ6GciUYMxDaVSKgdYI8ja+MW+KC+6GCZyWISZeIhS7EO+spLjvdMi
         P8Y5e/EnUK+TzVulxeAvo6I/0CxPLZAM/BrtPVE4XcZQCRzFhG0dtD1u9njPAnhsUC
         wdOkp32lUhJ+xA9XNAJXSjNF6lFrlOZvrg/YppbI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15D08601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm845: Add Q6V5 ADSP node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     dianders@chromium.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org,
        linux-remoteproc@vger.kernel.org
References: <1545313174-13481-1-git-send-email-rohitkr@codeaurora.org>
 <1545313174-13481-3-git-send-email-rohitkr@codeaurora.org>
 <20190103235002.GI31596@builder>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <80142100-35db-41d0-5340-dbdbc4c84113@codeaurora.org>
Date:   Tue, 8 Jan 2019 18:04:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190103235002.GI31596@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bjorn for review.

On 1/4/2019 5:20 AM, Bjorn Andersson wrote:
> On Thu 20 Dec 05:39 PST 2018, Rohit kumar wrote:
>
>> This patch adds Q6V5 ADSP remoteproc node for SDM845 SoCs.
>>
> Thanks Rohit, nice to see these things on the list!
>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 96 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 95 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index c0a012f..dfeb3cf 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -13,6 +13,9 @@
>>   #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>> +#include <dt-bindings/soc/qcom,apr.h>
>> +#include <dt-bindings/sound/qcom,q6afe.h>
>> +#include <dt-bindings/sound/qcom,q6asm.h>
>>   
>>   / {
>>   	interrupt-parent = <&intc>;
>> @@ -1691,7 +1694,98 @@
>>   				status = "disabled";
>>   			};
>>   		};
>> -	};
>> +
>> +		adsp_pil: remoteproc@17300000 {
> Please sort nodes by address, then name.

Sure.


>
>> +			compatible = "qcom,sdm845-adsp-pil";
>> +
>> +			reg = <0x17300000 0x410>;
>> +			reg-names = "qdsp6ss";
> reg-names was dropped from the binding (iirc), please omit it here.


Yup. Will remove it in next spin.

>
>> +
>> +			interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
> s/0/GIC_SPI/
okay.
>
>> +				<&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> +				<&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
>> +				<&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
>> +				<&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names = "wdog", "fatal", "ready",
>> +					  "handover", "stop-ack";
>> +
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +				 <&gcc GCC_LPASS_SWAY_CLK>,
>> +				 <&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
>> +				 <&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
>> +				 <&lpasscc LPASS_QDSP6SS_XO_CLK>,
>> +				 <&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
>> +				 <&lpasscc LPASS_QDSP6SS_CORE_CLK>;
>> +
>> +			clock-names = "xo", "sway_cbcr", "lpass_ahbs_aon_cbcr",
>> +				      "lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
>> +				      "qdsp6ss_sleep", "qdsp6ss_core";
>> +
>> +			resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
>> +				 <&aoss_reset AOSS_CC_LPASS_RESTART>;
>> +			reset-names = "pdc_sync", "cc_lpass";
>> +
>> +			qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
>> +
>> +			memory-region = <&pil_adsp_mem>;
>> +
>> +			qcom,smem-states = <&adsp_smp2p_out 0>;
>> +			qcom,smem-state-names = "stop";
>> +
>> +			glink-edge {
> So we will end up duplicating these between the PAS based and non-PAS
> based remoteprocs. I don't have a better idea right now, but this
> deserves some thought.


Yup. Will try to think if we can have some common node for glink-edge.

>> +				compatible = "qcom,glink-smem";
>> +				interrupts = <0 156 IRQ_TYPE_EDGE_RISING>;
> s/0/GIC_SPI/

sure


>
>> +
>> +				label = "lpass";
>> +				qcom,remote-pid = <2>;
>> +				mboxes = <&apss_shared 8>;
>> +				mbox-names = "adsp_smem";
> mbox-names is not a documented property, please omit it.


okay

>
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				apr@4 {
>> +					compatible = "qcom,apr-v2";
>> +					qcom,glink-channels = "apr_audio_svc";
>> +					reg = <APR_DOMAIN_ADSP>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +					q6core {
>> +						compatible = "qcom,q6core";
>> +						reg = <APR_SVC_ADSP_CORE>;
>> +					};
>> +
>> +					q6afe {
>> +						compatible = "qcom,q6afe";
>> +						reg = <APR_SVC_AFE>;
>> +						q6afedai: afedais {
>> +							compatible = "qcom,q6afe-dais";
>> +							#sound-dai-cells = <1>;
>> +							#address-cells = <1>;
>> +							#size-cells = <0>;
>> +						};
>> +					};
>> +
>> +					q6asm {
>> +						compatible = "qcom,q6asm";
>> +						reg = <APR_SVC_ASM>;
>> +						q6asmdai: asmdai{
>> +							compatible = "qcom,q6asm-dais";
>> +							iommus = <&apps_smmu 0x1821 0x0>;
>> +							#sound-dai-cells = <1>;
>> +						};
>> +					};
>> +
>> +					q6adm {
>> +						compatible = "qcom,q6adm";
>> +						reg = <APR_SVC_ADM>;
>> +						q6routing: routing {
>> +							compatible = "qcom,q6adm-routing";
>> +							#sound-dai-cells = <0>;
>> +						};
>> +					};
>> +				};
>> +			};
>> +			status = "disabled";
> Properties must come before subnodes.
Yup, right. Will update in next spin.
>
>> +		};
> Regards,
> Bjorn

Thanks,

Rohit

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

