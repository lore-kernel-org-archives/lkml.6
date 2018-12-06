Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C47C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3147421479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aV8VZGLv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A0sN6HL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3147421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbeLFWIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:08:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeLFWIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:08:09 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 62D17616D6; Thu,  6 Dec 2018 22:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544134088;
        bh=oxUE6oTeSELGXzu6IsKLsX14JbJ6dn8xZAFYCWdFlJw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aV8VZGLvGxz6aGKP4Ri7Y4Qhv0Tnw1Xa8eaoeWZlX1FhDuFLjOkabJKdnfe4YWcpb
         01eIIrWOvMPsHOPiN2BSyEkCxtHHAmC9Rw8eNT1XR2D4fdEfWbW1k8OUFrssG2qmup
         rk9/as2Y9LdV56z2t9h5eMjtdtOGCUDbw93Rz2Xs=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A5A9616A0;
        Thu,  6 Dec 2018 22:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544134087;
        bh=oxUE6oTeSELGXzu6IsKLsX14JbJ6dn8xZAFYCWdFlJw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A0sN6HL+9HRNOglpSz3gzOGMfzlWW0Y5hBOxLetRenk/GWUXrDLST8QZfVJqHCMmB
         mBV/YVwGRCNV4SnLkth8YcL16a/KHEPnjIP0Ao4r1bxDK/ABbwXVNgDtc0e93JHtC8
         0/9rOmGzcghRJ6YToe3as3p4GbWEC5zKEC+VfK1o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A5A9616A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] clk: qcom: smd: Add support for MSM8998 rpm clocks
To:     Stephen Boyd <sboyd@kernel.org>, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, marc.w.gonzalez@free.fr,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1544130666-32252-1-git-send-email-jhugo@codeaurora.org>
 <154413331679.88331.15909045605070653326@swboyd.mtv.corp.google.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <05485272-a117-b8e5-e7c5-d0dd8cc8fef4@codeaurora.org>
Date:   Thu, 6 Dec 2018 15:08:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154413331679.88331.15909045605070653326@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2018 2:55 PM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2018-12-06 13:11:06)
>> Add rpm smd clocks, PMIC and bus clocks which are required on MSM8998
>> for clients to vote on.
>>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   .../devicetree/bindings/clock/qcom,rpmcc.txt       |  1 +
>>   drivers/clk/qcom/clk-smd-rpm.c                     | 62 ++++++++++++++++++++++
>>   include/dt-bindings/clock/qcom,rpmcc.h             |  6 +++
>>   3 files changed, 69 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
>> index 87b4949..16c4293 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
>> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
>> @@ -17,6 +17,7 @@ Required properties :
>>                          "qcom,rpmcc-apq8064", "qcom,rpmcc"
>>                          "qcom,rpmcc-msm8996", "qcom,rpmcc"
>>                          "qcom,rpmcc-qcs404", "qcom,rpmcc"
>> +                       "qcom,rpmcc-msm8998", "qcom,rpmcc"
> 
> Can you keep this sorted on the first compatible?

No problem, that's a quick fix.  Same with the ordering nit below.

> 
>>   
>>   - #clock-cells : shall contain 1
>>   
> 
> Rob may prefer this file is split from the driver part into a different
> patch.
> 
>> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
>> index d3aadae..269304e 100644
>> --- a/drivers/clk/qcom/clk-smd-rpm.c
>> +++ b/drivers/clk/qcom/clk-smd-rpm.c
>> @@ -655,11 +655,73 @@ static int clk_smd_rpm_enable_scaling(struct qcom_smd_rpm *rpm)
>>          .num_clks = ARRAY_SIZE(qcs404_clks),
>>   };
>>   
>> +/* msm8998 */
>> +DEFINE_CLK_SMD_RPM(msm8998, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);
>> +DEFINE_CLK_SMD_RPM(msm8998, cnoc_clk, cnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 2);
>> +DEFINE_CLK_SMD_RPM(msm8998, ce1_clk, ce1_a_clk, QCOM_SMD_RPM_CE_CLK, 0);
>> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, div_clk1, div_clk1_a, 0xb);
>> +DEFINE_CLK_SMD_RPM(msm8998, ipa_clk, ipa_a_clk, QCOM_SMD_RPM_IPA_CLK, 0);
>> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, bb_clk1, bb_clk1_a, 1);
>> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, bb_clk2, bb_clk2_a, 2);
>> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, bb_clk3_pin, bb_clk3_a_pin, 3);
>> +DEFINE_CLK_SMD_RPM(msm8998, mmssnoc_axi_rpm_clk, mmssnoc_axi_rpm_a_clk,
>> +                  QCOM_SMD_RPM_MMAXI_CLK, 0);
>> +DEFINE_CLK_SMD_RPM(msm8998, aggre1_noc_clk, aggre1_noc_a_clk,
>> +                  QCOM_SMD_RPM_AGGR_CLK, 1);
>> +DEFINE_CLK_SMD_RPM(msm8998, aggre2_noc_clk, aggre2_noc_a_clk,
>> +                  QCOM_SMD_RPM_AGGR_CLK, 2);
>> +DEFINE_CLK_SMD_RPM_QDSS(msm8998, qdss_clk, qdss_a_clk,
>> +                       QCOM_SMD_RPM_MISC_CLK, 1);
>> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk1, rf_clk1_a, 4);
>> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk2_pin, rf_clk2_a_pin, 5);
>> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk3, rf_clk3_a, 6);
>> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk3_pin, rf_clk3_a_pin, 6);
>> +static struct clk_smd_rpm *msm8998_clks[] = {
>> +       [RPM_SMD_SNOC_CLK] = &msm8998_snoc_clk,
>> +       [RPM_SMD_SNOC_A_CLK] = &msm8998_snoc_a_clk,
>> +       [RPM_SMD_CNOC_CLK] = &msm8998_cnoc_clk,
>> +       [RPM_SMD_CNOC_A_CLK] = &msm8998_cnoc_a_clk,
>> +       [RPM_SMD_CE1_CLK] = &msm8998_ce1_clk,
>> +       [RPM_SMD_CE1_A_CLK] = &msm8998_ce1_a_clk,
>> +       [RPM_SMD_DIV_CLK1] = &msm8998_div_clk1,
>> +       [RPM_SMD_DIV_A_CLK1] = &msm8998_div_clk1_a,
>> +       [RPM_SMD_IPA_CLK] = &msm8998_ipa_clk,
>> +       [RPM_SMD_IPA_A_CLK] = &msm8998_ipa_a_clk,
>> +       [RPM_SMD_BB_CLK1] = &msm8998_bb_clk1,
>> +       [RPM_SMD_BB_CLK1_A] = &msm8998_bb_clk1_a,
>> +       [RPM_SMD_BB_CLK2] = &msm8998_bb_clk2,
>> +       [RPM_SMD_BB_CLK2_A] = &msm8998_bb_clk2_a,
>> +       [RPM_SMD_BB_CLK3_PIN] = &msm8998_bb_clk3_pin,
>> +       [RPM_SMD_BB_CLK3_A_PIN] = &msm8998_bb_clk3_a_pin,
>> +       [RPM_SMD_MMAXI_CLK] = &msm8998_mmssnoc_axi_rpm_clk,
>> +       [RPM_SMD_MMAXI_A_CLK] = &msm8998_mmssnoc_axi_rpm_a_clk,
>> +       [RPM_SMD_AGGR1_NOC_CLK] = &msm8998_aggre1_noc_clk,
>> +       [RPM_SMD_AGGR1_NOC_A_CLK] = &msm8998_aggre1_noc_a_clk,
>> +       [RPM_SMD_AGGR2_NOC_CLK] = &msm8998_aggre2_noc_clk,
>> +       [RPM_SMD_AGGR2_NOC_A_CLK] = &msm8998_aggre2_noc_a_clk,
>> +       [RPM_SMD_QDSS_CLK] = &msm8998_qdss_clk,
>> +       [RPM_SMD_QDSS_A_CLK] = &msm8998_qdss_a_clk,
>> +       [RPM_SMD_RF_CLK1] = &msm8998_rf_clk1,
>> +       [RPM_SMD_RF_CLK1_A] = &msm8998_rf_clk1_a,
>> +       [RPM_SMD_RF_CLK2_PIN] = &msm8998_rf_clk2_pin,
>> +       [RPM_SMD_RF_CLK2_A_PIN] = &msm8998_rf_clk2_a_pin,
>> +       [RPM_SMD_RF_CLK3] = &msm8998_rf_clk3,
>> +       [RPM_SMD_RF_CLK3_A] = &msm8998_rf_clk3_a,
>> +       [RPM_SMD_RF_CLK3_PIN] = &msm8998_rf_clk3_pin,
>> +       [RPM_SMD_RF_CLK3_A_PIN] = &msm8998_rf_clk3_a_pin,
>> +};
>> +
>> +static const struct rpm_smd_clk_desc rpm_clk_msm8998 = {
>> +       .clks = msm8998_clks,
>> +       .num_clks = ARRAY_SIZE(msm8998_clks),
>> +};
>> +
>>   static const struct of_device_id rpm_smd_clk_match_table[] = {
>>          { .compatible = "qcom,rpmcc-msm8916", .data = &rpm_clk_msm8916 },
>>          { .compatible = "qcom,rpmcc-msm8974", .data = &rpm_clk_msm8974 },
>>          { .compatible = "qcom,rpmcc-msm8996", .data = &rpm_clk_msm8996 },
>>          { .compatible = "qcom,rpmcc-qcs404",  .data = &rpm_clk_qcs404  },
>> +       { .compatible = "qcom,rpmcc-msm8998", .data = &rpm_clk_msm8998 },
> 
> And this sorted too.
> 
>>          { }
>>   };
>>   MODULE_DEVICE_TABLE(of, rpm_smd_clk_match_table);


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
