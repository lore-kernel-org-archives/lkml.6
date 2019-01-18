Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C2AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EE72087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="htjKPRRp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RyJsqdoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfARMIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:08:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38966 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfARMIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:08:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 65E3760866; Fri, 18 Jan 2019 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547813314;
        bh=AuMRxhZnW/nS9eRSCZAqfikgkQPIMNT9WIGr/bfc/9E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=htjKPRRpfAc1Oad8zywhO2EaiL5tiW6O3ijvs6HP/Jh9AM2S4vpED0vP/52ZdjYe/
         GDn57/tGpOITcmkaEEn/vl/9iM5spvAVkaGzbXQ9759k9vkCNB4JqNHVnR/cAZEnbk
         3w0K3ehXwrH8ykX5Gq/X5B8NeBRmtG9eTHcvYQT8=
Received: from [10.79.129.0] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A60A604B4;
        Fri, 18 Jan 2019 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547813313;
        bh=AuMRxhZnW/nS9eRSCZAqfikgkQPIMNT9WIGr/bfc/9E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RyJsqdoN9iVzcLxty4zNLVr/WfkiC4ROoAcFZRDF16dm/mWHS/GPDy933RZYSdk64
         4e0YyUEtXXiNX8bgjX4c5CHyg+xjFxzVhsFm6ptgkOoMLIEbHs2vjHpvsgspX0btfg
         7JV0zX9h1mc2B837GMkb9x3Yh+OyBd8jhhykxfYs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A60A604B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv2 2/4] arm64: dts: qcom: msm8996: Add Coresight support
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
        david.brown@linaro.org, vivek.gautam@codeaurora.org,
        dianders@chromium.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com
Cc:     rnayak@codeaurora.org, sibis@codeaurora.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <cover.1547798966.git.saiprakash.ranjan@codeaurora.org>
 <552e408950525b1bac39d05b8b4f2ae1975397e0.1547798966.git.saiprakash.ranjan@codeaurora.org>
 <1311e78a-21f6-6470-7861-39b3499974ce@arm.com>
 <6543ad5c-bbcf-b3ec-332c-115e8e3d0825@codeaurora.org>
 <1b7d4c2f-98f7-4b80-4e32-6e0fe5c906ce@arm.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <7a82a0c1-a449-f062-0cc3-944102472fb0@codeaurora.org>
Date:   Fri, 18 Jan 2019 17:38:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1b7d4c2f-98f7-4b80-4e32-6e0fe5c906ce@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 1/18/2019 5:34 PM, Suzuki K Poulose wrote:
> If you would like to use the scatter-gather mode, you must specify it
> explicitly. We have had some other boards with broken scatter-gather
> mode integration which causes mysterious issues when used. So we have
> a white-list approach for enabling the scatter-gather mode in the driver.
> 
> So, if you have tested to make sure that the mode works fine with a recent
> kernel version (v4.19 onwards), you may want to add the property.
> 
> Suzuki
> 

Will add scatter-gather and post v3 soon for both SDM845 and MSM8996.

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
