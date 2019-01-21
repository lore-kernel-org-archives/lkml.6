Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CD2C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FBF20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfAURPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:15:22 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:59810 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfAURPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:15:21 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 6E6A213F85F;
        Mon, 21 Jan 2019 18:15:06 +0100 (CET)
Subject: Re: [RFC PATCH v2 2/4] arm64: dts: qcom: msm8998: Add UFS nodes
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <88e04336-723f-c157-0384-c5054a73e0a4@free.fr>
 <d183a99d-6fd7-8b06-3f22-a26415cf4967@free.fr>
 <8dd04fdc-a5ad-420f-5224-641a71b3176c@codeaurora.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <9aba81b6-e202-019c-f0f3-60c07935fa43@free.fr>
Date:   Mon, 21 Jan 2019 18:15:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8dd04fdc-a5ad-420f-5224-641a71b3176c@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2019 16:36, Jeffrey Hugo wrote:

> On 1/16/2019 3:56 AM, Marc Gonzalez wrote:
>
>> Add host controller and PHY DT nodes.
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> ---
>> TODO: check whether the driver uses the 'resets' prop
>> ---
>>   arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 20 +++++++
>>   arch/arm64/boot/dts/qcom/msm8998.dtsi     | 63 +++++++++++++++++++++++
>>   2 files changed, 83 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
>> index 50e9033aa7f6..cd1c9e84eab7 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
>> @@ -257,3 +257,23 @@
>>   	pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
>>   	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
>>   };
>> +
>> +&ufshc {
>> +	vdd-hba-fixed-regulator;
> 
> Since we are not specifying the vdd anymore, I suspect this should be 
> dropped.  Do you know of any reason why we'd still need it?

Will drop in v3.

>> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> index 6f4f4b79853b..36fd2e614464 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> @@ -711,6 +711,69 @@
>>   			redistributor-stride = <0x0 0x20000>;
>>   			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>>   		};
>> +
>> +		ufshc: ufshc@1da4000 {
>> +			compatible = "qcom,msm8998-ufshc", "qcom,ufshc",
>> +				     "jedec,ufs-2.0";
>> +			reg = <0x1da4000 0x2500>;
> 
> Bjorn would like it if reg addresses are full width, ie 0x01da4000

Will tweak in v3.

>> +		ufsphy: phy@1da7000 {
>> +			compatible = "qcom,sdm845-qmp-ufs-phy";
> 
> We should make an 8998 compatible.  Also, don't you have phy changes 
> since the init sequence differs between 845 and 8998?

Will create a specific binding.
I don't have any PHY changes, I just used the 845 init sequence.
I tested this by using the 845 init sequence downstream.

However, no point in sending v3 until someone comments on patches 3 and 4 :-)

Patch 4 needs to become a real patch.

Regards.
