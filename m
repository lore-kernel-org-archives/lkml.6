Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7440EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BDB20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lGlRHW1V";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Iv6EwZvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BDB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeKSV4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:56:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55300 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbeKSV4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:56:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 18B036022B; Mon, 19 Nov 2018 11:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542627176;
        bh=DcLDtL0ZXB8jT1ITCDvIfjyETQuXgmvEdut3mOgIWVw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lGlRHW1VkO2f4+I3qPpYjunwIWXriOQVHKNjL5XwfPgKWCWpnk0jjaZiCXQkJE9TD
         kw006gYsszz8m9YvE7g89nE4cU6eh7jya61uMqOfztKenmTWxsgb7h6VBDyurJTqCA
         CFtfpKtT9ODosehreCK8nqUQVcE0hgea4qOKc9s8=
Received: from [10.79.168.24] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B8186022B;
        Mon, 19 Nov 2018 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542627175;
        bh=DcLDtL0ZXB8jT1ITCDvIfjyETQuXgmvEdut3mOgIWVw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Iv6EwZvm9ofS7DIXn1eKAxPQjv5RxVOp6lKIUWjMpzH3PdfiQJrDxHG3a/56/u2bH
         XX9fid71vl2TVq4zXgEjpd2+NZrZX20D4Xuo7XG7WZ0eOXIe7RSgjeb2QbxXssKm9V
         61OhSFoWagNIvMWz/l+PBnHi35RBi6a5ckYnAv30=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B8186022B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v3 4/4] clk: qcom: Add graphics clock controller driver
 for SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
 <1534141987-29601-5-git-send-email-anischal@codeaurora.org>
 <154139982787.88331.4428778114927340653@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <d3fef1bb-f18b-cf01-bb21-678cec65eb1b@codeaurora.org>
Date:   Mon, 19 Nov 2018 17:02:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154139982787.88331.4428778114927340653@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 11/5/2018 12:07 PM, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-08-12 23:33:07)
>> +
>> +static int gpu_cc_sdm845_probe(struct platform_device *pdev)
>> +{
>> +       struct regmap *regmap;
>> +       unsigned int value, mask;
>> +       int ret;
>> +
>> +       regmap = qcom_cc_map(pdev, &gpu_cc_sdm845_desc);
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
>> +
>> +       clk_fabia_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
>> +       clk_fabia_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
>> +
>> +       /*
>> +        * Configure gpu_cc_cx_gmu_clk with recommended
>> +        * wakeup/sleep settings
>> +        */
>> +       mask = CX_GMU_CBCR_WAKE_MASK << CX_GMU_CBCR_WAKE_SHIFT;
>> +       mask |= CX_GMU_CBCR_SLEEP_MASK << CX_GMU_CBCR_SLEEP_SHIFT;
>> +       value = 0xf << CX_GMU_CBCR_WAKE_SHIFT | 0xf << CX_GMU_CBCR_SLEEP_SHIFT;
>> +       regmap_update_bits(regmap, 0x1098, mask, value);
>> +
>> +       ret = qcom_cc_really_probe(pdev, &gpu_cc_sdm845_desc, regmap);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Configure clk_dis_wait for gpu_cx_gdsc */
>> +       regmap_update_bits(regmap, 0x106c, CLK_DIS_WAIT_MASK,
>> +                                               8 << CLK_DIS_WAIT_SHIFT);
> 
> Is there a reason this is done after clks are registered? I'd think we
> would want to do it before.
> 

Yes, it could be done before, would move it.

>> +
>> +       /* Set supported range of frequencies for gfx3d clock */
>> +       clk_hw_set_rate_range(&gpu_cc_gx_gfx3d_clk_src.clkr.hw, 180000000,
>> +                                                               710000000);
>> +
>> +       return 0;
>> +}

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
