Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0E3C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EB020864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bcHph/oO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V0RmQZpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EB020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392705AbeKVS3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:29:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46956 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbeKVS3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:29:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F51260B11; Thu, 22 Nov 2018 07:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542873051;
        bh=DL/rLUi8S+WT9gcHLql2HFGK3HLTNw5thi8Hy2t89mQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bcHph/oO1A1ePdw0l9XPcSmRx0TejK3BqroDXh9T71ilUXTGeBgnCbLWP04b1PVV1
         JXeDT6OfePskMea630eQ81eZc5Gth9ruvxiZFqo7XdysOVGVKSYu/a23q/RXiyxDXk
         cd9hz+0nfhW5idjUWOwj4KpM1oKJ9E2PQiv2gFvE=
Received: from [192.168.225.247] (unknown [49.33.186.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2DFC86022B;
        Thu, 22 Nov 2018 07:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542873050;
        bh=DL/rLUi8S+WT9gcHLql2HFGK3HLTNw5thi8Hy2t89mQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V0RmQZpG0SrMM3+N0mbc9Ng2lynRbnVSRk60uOzs27ckZpyD9Id01rjzpw48QPg0E
         Y3oTNgrVHK5vjGltUQRUtTibENFqrONAuiP2bmSVGwjUN8ulNyDPA67Dmd5KirrEvP
         zpPWHc55NtPlZTlbTV1141SceVDnmYXP2X4bLpMk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DFC86022B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v9 2/2] clk: qcom: Add lpass clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
References: <1541814256-23254-1-git-send-email-tdas@codeaurora.org>
 <1541814256-23254-3-git-send-email-tdas@codeaurora.org>
 <154282725690.88331.797718066164707366@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <b95df0d3-8504-0eef-c0f3-0ff2e4176b69@codeaurora.org>
Date:   Thu, 22 Nov 2018 13:20:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154282725690.88331.797718066164707366@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 11/22/2018 12:37 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-11-09 17:44:16)
>> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
>> index f133b7f..ba8ff99 100644
>> --- a/drivers/clk/qcom/gcc-sdm845.c
>> +++ b/drivers/clk/qcom/gcc-sdm845.c
>> @@ -3153,6 +3153,34 @@ enum {
>>          },
>>   };
>>
>> +static struct clk_branch gcc_lpass_q6_axi_clk = {
>> +       .halt_reg = 0x47000,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0x47000,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "gcc_lpass_q6_axi_clk",
>> +                       .flags = CLK_IS_CRITICAL,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch gcc_lpass_sway_clk = {
>> +       .halt_reg = 0x47008,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0x47008,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "gcc_lpass_sway_clk",
>> +                       .flags = CLK_IS_CRITICAL,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>>   static struct gdsc pcie_0_gdsc = {
>>          .gdscr = 0x6b004,
>>          .pd = {
>> @@ -3453,6 +3481,8 @@ enum {
>>          [GCC_QSPI_CORE_CLK_SRC] = &gcc_qspi_core_clk_src.clkr,
>>          [GCC_QSPI_CORE_CLK] = &gcc_qspi_core_clk.clkr,
>>          [GCC_QSPI_CNOC_PERIPH_AHB_CLK] = &gcc_qspi_cnoc_periph_ahb_clk.clkr,
>> +       [GCC_LPASS_Q6_AXI_CLK] = &gcc_lpass_q6_axi_clk.clkr,
>> +       [GCC_LPASS_SWAY_CLK] = &gcc_lpass_sway_clk.clkr,
> 
> Sigh, more coordination with sdm845 mtp problems here due to the
> clks being protected by firmware. I guess I can just merge this and the
> mtp dts bits will land in Andy's tree during the same merge window? Or I
> may need to take the dts bits for this into clk tree so that the broken
> time is only between two commits.
> 
>>   };
>>
>>   static const struct qcom_reset_map gcc_sdm845_resets[] = {
>> diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpasscc-sdm845.c
>> new file mode 100644
>> index 0000000..2ef7f2a
>> --- /dev/null
>> +++ b/drivers/clk/qcom/lpasscc-sdm845.c
>> @@ -0,0 +1,192 @@
> [...]
>> +
>> +static const struct of_device_id lpass_cc_sdm845_match_table[] = {
>> +       { .compatible = "qcom,sdm845-lpasscc" },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, lpass_cc_sdm845_match_table);
> 
> Move this down to the before the driver structure please.
> 

Would do it in the next patch.

>> +
>> +static int lpass_cc_sdm845_probe(struct platform_device *pdev)
>> +{
>> +       const struct qcom_cc_desc *desc;
>> +       int ret;
>> +
>> +       lpass_regmap_config.name = "cc";
>> +       desc = &lpass_cc_sdm845_desc;
>> +
>> +       ret = lpass_clocks_sdm845_probe(pdev, 0, desc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       lpass_regmap_config.name = "qdsp6ss";
>> +       desc = &lpass_qdsp6ss_sdm845_desc;
>> +
>> +       return lpass_clocks_sdm845_probe(pdev, 1, desc);
>> +}
>> +
>> +static struct platform_driver lpass_cc_sdm845_driver = {
>> +       .probe          = lpass_cc_sdm845_probe,
>> +       .driver         = {
>> +               .name   = "sdm845-lpasscc",
>> +               .of_match_table = lpass_cc_sdm845_match_table,
>> +       },
>> +};
>> +
>> +static int __init lpass_cc_sdm845_init(void)
>> +{
>> +       return platform_driver_register(&lpass_cc_sdm845_driver);
>> +}
>> +subsys_initcall(lpass_cc_sdm845_init);
>> +
>> +static void __exit lpass_cc_sdm845_exit(void)
>> +{
>> +       platform_driver_unregister(&lpass_cc_sdm845_driver);
>> +}
>> +module_exit(lpass_cc_sdm845_exit);
>> +
>> +MODULE_LICENSE("GPL v2");
> 
> MODULE_DESCRIPTION?
> 
Would add it in the next patch.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
