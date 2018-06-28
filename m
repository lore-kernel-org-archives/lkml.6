Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9DEC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E8E26BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G9CATWeV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AXNDXngh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E8E26BEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932183AbeF1E3Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:29:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38752 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeF1E3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:29:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5EE8E60B10; Thu, 28 Jun 2018 04:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530160161;
        bh=oH3tVrkCh2K9U3RVXnxovw8YTaIOuNgBmc91Am+/iKI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G9CATWeVBgd64liLTb0ewbNBSaWx4ewrxWbua2MfT6ghfFZiQfgVfglc43XFSyinH
         LvySKIXRjetAczSyHJMbksAHHfbTloZlvhUE3gCSNFCjzJaoU5toMM6hfgH9qt2iAR
         VDkGqNno1qFHjDgpjXmBBa2RTucaeMtoBQ8zEBJ8=
Received: from [10.201.3.39] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AD5216071C;
        Thu, 28 Jun 2018 04:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530160160;
        bh=oH3tVrkCh2K9U3RVXnxovw8YTaIOuNgBmc91Am+/iKI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AXNDXnghfhlL3fzluz37iMnqKkhLRom7+F8yZYRUMaVMvgsJ/FeyqZcCmMBI2r2Sg
         4EmKFZXn532aL3f4fJw3xP4wNj76Uzkb8JnsVdzuopsuBxv+L/7xMH3WE0XYqfHVnb
         1UjEwnHKAjzxgn7UAtY8j/d479jSiqaEAZyW65Ac=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD5216071C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v10 00/14] Krait clocks + Krait CPUfreq
To:     Thierry Escande <thierry.escande@linaro.org>
Cc:     robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk,
        ctatlor97@gmail.com
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
 <a58c2d2c-64d1-7223-dc98-8f749397375d@linaro.org>
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <410263b4-9434-ed49-626d-2a14efe350f0@codeaurora.org>
Date:   Thu, 28 Jun 2018 09:59:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a58c2d2c-64d1-7223-dc98-8f749397375d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On 6/27/2018 3:01 PM, Thierry Escande wrote:
> Hi Sricharan,
> 
> On 19/06/2018 15:45, Sricharan R wrote:
>> Sricharan R (2):
>>    clk: qcom: Add safe switch hook for krait mux clocks
>>    dt-bindings: cpufreq: Document operating-points-v2-krait-cpu
>>
>> Stephen Boyd (12):
>>    ARM: Add Krait L2 register accessor functions
>>    clk: qcom: Add support for High-Frequency PLLs (HFPLLs)
>>    clk: qcom: Add HFPLL driver
>>    dt-bindings: clock: Document qcom,hfpll
>>    clk: qcom: Add MSM8960/APQ8064's HFPLLs
>>    clk: qcom: Add IPQ806X's HFPLLs
>>    clk: qcom: Add support for Krait clocks
>>    clk: qcom: Add KPSS ACC/GCC driver
>>    dt-bindings: arm: Document qcom,kpss-gcc
>>    clk: qcom: Add Krait clock controller driver
>>    dt-bindings: clock: Document qcom,krait-cc
>>    cpufreq: Add module to register cpufreq on Krait CPUs
> 
> Tested on apq8064 (db600c).
> 
> Tested-By: Thierry Escande <thierry.escande@linaro.org>
> 

  Thanks for testing this !!
  I Will try to merge the kryo cpu-freq and this one if that looks neat.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
