Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B3A2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S1muNHap";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S1muNHap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfBYMsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:48:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53958 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfBYMsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:48:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 556FA60E3E; Mon, 25 Feb 2019 12:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551098895;
        bh=CbX5ty2CBjMnl3Q5uuiREuZAo4LBn3G2lvAwnZIXYL0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S1muNHapFf3A0NseBQtib6WEgxdu5P88BqqrdwMGMDYVcqD7bF7cMKXhDxGHXz+r0
         Z1+KX9t5/umvHm/5nit/b+TuWQBFIARYJ3Fp7aILOEKJr1VbD3zSQoTDtozExqJQuc
         lrv+oQ7jpXhgkWH6KsXWA+n3RRBeqi+HLVp7UZgA=
Received: from [192.168.0.107] (unknown [106.51.20.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E95E160AA2;
        Mon, 25 Feb 2019 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551098895;
        bh=CbX5ty2CBjMnl3Q5uuiREuZAo4LBn3G2lvAwnZIXYL0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S1muNHapFf3A0NseBQtib6WEgxdu5P88BqqrdwMGMDYVcqD7bF7cMKXhDxGHXz+r0
         Z1+KX9t5/umvHm/5nit/b+TuWQBFIARYJ3Fp7aILOEKJr1VbD3zSQoTDtozExqJQuc
         lrv+oQ7jpXhgkWH6KsXWA+n3RRBeqi+HLVp7UZgA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E95E160AA2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 0/3] RPMPD for QCS404
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190221064434.2760-1-bjorn.andersson@linaro.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <c4b2a60c-80a5-8491-38fb-1fed3dee2e8a@codeaurora.org>
Date:   Mon, 25 Feb 2019 18:18:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190221064434.2760-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/21/2019 12:14 PM, Bjorn Andersson wrote:
> Reworkd the macros of the rpmpd driver and add qcs404 power domains, then add
> this to the dts.

For the entire series,

Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>

> 
> Bjorn Andersson (3):
>    soc: qcom: rpmpd: Modify corner defining macros
>    soc: qcom: rpmpd: Add QCS404 corners
>    arm64: dts: qcom: qcs404: Add rpmpd node
> 
>   .../devicetree/bindings/power/qcom,rpmpd.txt  |  1 +
>   arch/arm64/boot/dts/qcom/qcs404.dtsi          | 35 +++++++++++
>   drivers/soc/qcom/rpmpd.c                      | 63 +++++++++++++------
>   include/dt-bindings/power/qcom-rpmpd.h        |  9 +++
>   4 files changed, 88 insertions(+), 20 deletions(-)
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
