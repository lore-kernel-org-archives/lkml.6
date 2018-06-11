Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OUsTAwATHltwWwAAmS7hNA
	; Mon, 11 Jun 2018 06:13:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0ACE7607E4; Mon, 11 Jun 2018 06:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528697600;
	bh=V0x3fsNFRk1ecLGxKR8QL8HMxJQco2PWl5AFb/4GoS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bwetVGneDLCz7wE/wMJx4gPA6Zqqj/2W7DmANOCnVpC8dE8RzF0NCdRUXGICfNLIs
	 RgHn35UOyNLB9AzwibuKiuYilCcCbdYKamCwkPDBy2HWkaGu/Dq+nVfK78UVaXs7m1
	 sdMZd0ib+62qSM+MMr88gAOgOj7AagOCQz0vLAm8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6C57D60792;
	Mon, 11 Jun 2018 06:13:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RK+D/4oX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A9bdI6fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C57D60792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932344AbeFKGNS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:13:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55284 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753929AbeFKGNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:13:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A535260791; Mon, 11 Jun 2018 06:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528697595;
        bh=V0x3fsNFRk1ecLGxKR8QL8HMxJQco2PWl5AFb/4GoS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RK+D/4oXMFQ4X+dcij+ju9dh9Yvr/MscspjIOwxrZl6v8EqNv0VQTzmk08p7tLwG+
         t0lxhxcMhDSOPk3edKFKWJq6PJRe0MDXu0VxRzGFbmZo9cQqfnhjadUN2ppEUQQX9U
         nN82mLWfrdyKRNQdmLqkNOG8kZWk2p60z01Aqn8k=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CC22F605A5;
        Mon, 11 Jun 2018 06:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528697594;
        bh=V0x3fsNFRk1ecLGxKR8QL8HMxJQco2PWl5AFb/4GoS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A9bdI6fv/+bgtX/XtV98toYKr/zxVSzrTzcr4m73j/vLAuJTQbsFNgF2evDUJnorm
         Zvel10F9Eju2uGkLk1LSw/GvtHQd+CO3GbLFGKLTFhl4H20TKoNYhBebQC6r/0FG4F
         EFbDKFEuFV7CM2zSJdpcn8iAm+K1sWg/kSP2vuw0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Jun 2018 11:43:14 +0530
From: Amit Nischal <anischal@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: Enable clocks which needs to be always on
 for SDM845
In-Reply-To: <152787098620.144038.15158473245010154723@swboyd.mtv.corp.google.com>
References: <1527574066-27237-1-git-send-email-anischal@codeaurora.org>
 <152787098620.144038.15158473245010154723@swboyd.mtv.corp.google.com>
Message-ID: <4e8c1a6f04a54634cb6718b0c59dc59e@codeaurora.org>
X-Sender: anischal@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-01 22:06, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-05-28 23:07:46)
>> There are certain clocks which needs to be always enabled for system
>> operation. Remove support for such clocks from the clock driver and
>> enable them explicitly gcc driver probe. Also fix the target name in
>> kernel configuration description for SDM845 gcc driver.
> 
> This is why we have CLK_IS_CRITICAL.
> 
>> 
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
>> ---
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index fc3edd1..79e9144 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -231,7 +231,7 @@ config SDM_GCC_845
>>         select QCOM_GDSC
>>         depends on COMMON_CLK_QCOM
>>         help
>> -         Support for the global clock controller on msm8998 devices.
>> +         Support for the global clock controller on SDM845 devices.
>>           Say Y if you want to use peripheral devices such as UART, 
>> SPI,
>>           I2C, USB, UFS, SDDC, PCIe, etc.
>> 
> 
> This can be its own patch.
> 

Thanks for fixing above as this is already in the clk-next branch
under commit "77122d".

>> diff --git a/drivers/clk/qcom/gcc-sdm845.c 
>> b/drivers/clk/qcom/gcc-sdm845.c
>> index e78e6f5..b40aafc 100644
>> --- a/drivers/clk/qcom/gcc-sdm845.c
>> +++ b/drivers/clk/qcom/gcc-sdm845.c
>> @@ -3433,9 +3327,16 @@ static int gcc_sdm845_probe(struct 
>> platform_device *pdev)
>>         regmap_update_bits(regmap, 0x09ffc, 0x3, 0x3);
>>         regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
>> 
>> -       /* Enable CPUSS clocks */
>> -       regmap_update_bits(regmap, 0x48190, BIT(0), 0x1);
>> -       regmap_update_bits(regmap, 0x52004, BIT(22), 0x1);
>> +       /* Enable clocks which are required to be always ON */
>> +       regmap_update_bits(regmap, 0xb004, BIT(0), BIT(0));
>> +       regmap_update_bits(regmap, 0xb008, BIT(0), BIT(0));
>> +       regmap_update_bits(regmap, 0xb00c, BIT(0), BIT(0));
>> +       regmap_update_bits(regmap, 0xb028, BIT(0), BIT(0));
>> +       regmap_update_bits(regmap, 0xb02c, BIT(0), BIT(0));
>> +       regmap_update_bits(regmap, 0xb030, BIT(0), BIT(0));
>> +       regmap_update_bits(regmap, 0x48190, BIT(0), BIT(0));
>> +       regmap_update_bits(regmap, 0x52004, BIT(22), BIT(22));
>> +       regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
> 
> Let's do CLK_IS_CRITICAL flag instead. That has the added benefit of
> checking to make sure the halt bit toggles correctly so the clks are
> verified to be enabled.
> 

I will submit the next patch for all above-listed clocks with
CLK_IS_CRITICAL flag.

>> 
>>         return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
>>  }
>> diff --git a/include/dt-bindings/clock/qcom,gcc-sdm845.h 
>> b/include/dt-bindings/clock/qcom,gcc-sdm845.h
>> index aca6126..6330c3f 100644
>> --- a/include/dt-bindings/clock/qcom,gcc-sdm845.h
>> +++ b/include/dt-bindings/clock/qcom,gcc-sdm845.h
>> @@ -13,185 +13,178 @@
>>  #define GCC_AGGRE_USB3_PRIM_AXI_CLK                            3
>>  #define GCC_AGGRE_USB3_SEC_AXI_CLK                             4
>>  #define GCC_BOOT_ROM_AHB_CLK                                   5
>> -#define GCC_CAMERA_AHB_CLK                                     6
> 
> Don't do this. Things should only be added to here, not removed or
> reshuffled.
> 
>> -#define GCC_CAMERA_AXI_CLK                                     7
>> -#define GCC_CAMERA_XO_CLK                                      8
>> -#define GCC_CE1_AHB_CLK                                               
>>  9
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
