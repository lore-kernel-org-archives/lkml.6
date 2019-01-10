Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CC6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA51206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NlzPkN+f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PDunOwZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfAJE72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:59:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49106 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfAJE71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:59:27 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B42136079B; Thu, 10 Jan 2019 04:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547096366;
        bh=0Sv+vQYiq+r2Uti0vsESec2TG5QC92SR4T8SPWjwMQc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NlzPkN+f4N0b8j04D0AgKqTpfJDH8PDOxIJZ66OilhJWLM3RQoC22XWMB6c4e8hhn
         4+k4MtBUVEUHPbrV5XsKm/kSbxtaxnDMKRWpzg/P5qZj9DXjKZRmyxT72pFD5WAX1c
         LI4JS/31Rw0f45WPrqHPATIXwKgdV4ZzdSoeBdac=
Received: from [10.79.129.145] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D17E260265;
        Thu, 10 Jan 2019 04:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547096365;
        bh=0Sv+vQYiq+r2Uti0vsESec2TG5QC92SR4T8SPWjwMQc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PDunOwZu1lPW4RFPViFoRu5ZTgrsTquSUnT5xN0PN1FsSFpEiwURUlkAmEtsyXtiQ
         BecBFBCSI2k+ECC8aZkRo/Gf8Ish+L72dPgYOHrva1DDpYwAHoiOudAQRHrgp0SLgk
         TvfBoPrq301/ZTE8JDbmcyUJ8atn0qFNhMCEeYUc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D17E260265
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v2 3/7] soc: qcom: Add AOSS QMP genpd provider
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190106080915.4493-1-bjorn.andersson@linaro.org>
 <20190106080915.4493-4-bjorn.andersson@linaro.org>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <b9c970f1-2c2e-6e4f-acad-838054db14db@codeaurora.org>
Date:   Thu, 10 Jan 2019 10:29:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190106080915.4493-4-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 1/6/2019 1:39 PM, Bjorn Andersson wrote:
> The AOSS QMP genpd provider implements control over power-related
> resources related to low-power state associated with the remoteprocs in
> the system as well as control over a set of clocks related to debug
> hardware in the SoC.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Drop compatible, as the QMP DT node is flattened
> - Correct size of send
> 

Thanks for the patch. I tested QDSS functionality with this on SDM845
and it works fine. Also posted the patch for the same here:
  - https://lore.kernel.org/patchwork/patch/1030510/

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
