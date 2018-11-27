Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D9620873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MvcgEyoC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MvcgEyoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D9620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbeK0VsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:48:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeK0VsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:48:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E307A60B26; Tue, 27 Nov 2018 10:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543315842;
        bh=JHXmpc9pZZWjpQrjJVns+Bmv0GHdc/G3EcsSaxBXjZc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MvcgEyoCbIQrJXnSTdONzS859vBVdVNk7VuWOCPk8+fXVxUA24TOK2R7K264jIsGn
         ioMlsqseue1lJg1eKirCbbx1cOECMbBteFKGR84bAG86wJYXczfYt89lrA1BSQ13xm
         y518jHsvd7pSGJbiHa2Pjf2lZl6f56QtHt0qEVMM=
Received: from [10.79.128.28] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 959AC6079C;
        Tue, 27 Nov 2018 10:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543315842;
        bh=JHXmpc9pZZWjpQrjJVns+Bmv0GHdc/G3EcsSaxBXjZc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MvcgEyoCbIQrJXnSTdONzS859vBVdVNk7VuWOCPk8+fXVxUA24TOK2R7K264jIsGn
         ioMlsqseue1lJg1eKirCbbx1cOECMbBteFKGR84bAG86wJYXczfYt89lrA1BSQ13xm
         y518jHsvd7pSGJbiHa2Pjf2lZl6f56QtHt0qEVMM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 959AC6079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 3/3] soc: qcom: Add AOSS QMP genpd provider
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20181112080557.22698-1-bjorn.andersson@linaro.org>
 <20181112080557.22698-4-bjorn.andersson@linaro.org>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <e8b74746-23a4-67fe-9b6d-060f77a0a043@codeaurora.org>
Date:   Tue, 27 Nov 2018 16:20:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181112080557.22698-4-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 11/12/2018 1:35 PM, Bjorn Andersson wrote:
> The AOSS QMP genpd provider implements control over power-related
> resources related to low-power state associated with the remoteprocs in
> the system as well as control over a set of clocks related to debug
> hardware in the SoC.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

One more issue is that amba bus probe fails and coresight(qdss) does not
work with these because of clocks being modeled as power-domain.

Below is the log snippet:

[    4.580715] coresight-etm4x: probe of 7040000.etm failed with error -2
[    4.588087] coresight-etm4x: probe of 7140000.etm failed with error -2
[    4.595407] coresight-etm4x: probe of 7240000.etm failed with error -2
[    4.602796] coresight-etm4x: probe of 7340000.etm failed with error -2
[    4.610108] coresight-etm4x: probe of 7440000.etm failed with error -2
[    4.617453] coresight-etm4x: probe of 7540000.etm failed with error -2
[    4.624831] coresight-etm4x: probe of 7640000.etm failed with error -2
[    4.632190] coresight-etm4x: probe of 7740000.etm failed with error -2

This is because Amba bus probe has amba_get_enable_pclk() which gets
apb_pclk and returns error if it can't get that clk.

Just for testing, I ignored amba_get_enable_pclk() in probe and
coresight seems to work fine.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
