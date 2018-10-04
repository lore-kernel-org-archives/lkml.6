Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B635C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E37920684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gO0c81DQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FrXjyX3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E37920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJDSye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:54:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33688 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJDSye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:54:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1B14B60C8C; Thu,  4 Oct 2018 12:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538654496;
        bh=8Ga/4yLMbU/+1RUDe+Xy96polwRYsZDxnOQjF9Ha1TY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gO0c81DQ+NFAmND7mUydWfrWQKyk1ptplCe/SN343npm+ED4IWKKQwESFRiQ5YWZt
         IiaSJMYhoB1LdcnoiER51964rwDA1QeNo2haX4uxsz4SNwPDkTmvEv7TXmXBvomMoX
         /6ZRj5xYn6wrUJXo/osL9TBRYu7d6S8iFh2knbJ8=
Received: from [192.168.225.247] (unknown [49.33.236.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8BFB60C62;
        Thu,  4 Oct 2018 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538654495;
        bh=8Ga/4yLMbU/+1RUDe+Xy96polwRYsZDxnOQjF9Ha1TY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FrXjyX3cBg1AxaLAnwW9bfpg8T2rBOwukdD3rnGCJfD+6J8pTBEbCn0Xh1V/SG9SQ
         +OWnWfTztXgb1MtndJdYVjo8o9ZlqjXICwwdhNYvzQg3WVkj/Iahu4mMwG8QZQBCtV
         Q0lQnNZ3P/Dj9NIi9NHIcA7wfP3WFxCvMNI9SyCY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8BFB60C62
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v5 2/2] clk: qcom: Add lpass clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
References: <1537266338-18661-1-git-send-email-tdas@codeaurora.org>
 <1537266338-18661-3-git-send-email-tdas@codeaurora.org>
 <153816066933.119890.2976485722156069351@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <66fc65d8-92ec-f32c-6edb-ad4952695395@codeaurora.org>
Date:   Thu, 4 Oct 2018 17:31:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153816066933.119890.2976485722156069351@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/29/2018 12:21 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-09-18 03:25:38)
>> @@ -3469,6 +3495,8 @@ enum {
>>          [GCC_QSPI_CORE_CLK_SRC] = &gcc_qspi_core_clk_src.clkr,
>>          [GCC_QSPI_CORE_CLK] = &gcc_qspi_core_clk.clkr,
>>          [GCC_QSPI_CNOC_PERIPH_AHB_CLK] = &gcc_qspi_cnoc_periph_ahb_clk.clkr,
>> +       [GCC_LPASS_Q6_AXI_CLK] = NULL,
>> +       [GCC_LPASS_SWAY_CLK] = NULL,
>>   };
>>   
>>   static const struct qcom_reset_map gcc_sdm845_resets[] = {
>> @@ -3583,6 +3611,13 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
>>          if (ret)
>>                  return ret;
>>   
>> +       if (of_property_read_bool(pdev->dev.of_node, "qcom,lpass-protected")) {
> 
> Shouldn't this be negated? So that we only add the clks when lpass isn't
> protected?
>

I was of the opinion to add the flag only when LPASS clocks are 
required. But I am fine negating it too.

>> +               gcc_sdm845_clocks[GCC_LPASS_Q6_AXI_CLK] =
>> +                       &gcc_lpass_q6_axi_clk.clkr;
>> +               gcc_sdm845_clocks[GCC_LPASS_SWAY_CLK] =
>> +                       &gcc_lpass_sway_clk.clkr;
>> +       }
>> +
>>          return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
