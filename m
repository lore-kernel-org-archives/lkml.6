Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E907BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96AF2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TNfw8Gm8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G6cncKKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbfBOCc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:32:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37034 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387502AbfBOCcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:32:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 17BD2608FD; Fri, 15 Feb 2019 02:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550197966;
        bh=NDg3PhUw2Vr/THPcUDE5xFuZZuswpVtFeqXp6mwLfg8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TNfw8Gm8f8o9X/PMNsTZuwnHQFcFdIQUIFZueWR9TUW66ZST09NC9R7ub/fLsMYHg
         FUa5/HysVJXWEh9rMh0JGrmTiyFUPxt3kuKF4D3/Zrh8+vNwohlQCzVoXT1xvhZ/EP
         +0AqpoCZqgBJQQT1OuZhA0qjWef4McpXg4bT/+C0=
Received: from [10.79.128.185] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FD2A608CC;
        Fri, 15 Feb 2019 02:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550197964;
        bh=NDg3PhUw2Vr/THPcUDE5xFuZZuswpVtFeqXp6mwLfg8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G6cncKKCOQBtuOh0lr8/fUdb5G6zMZHCbTSIqdm7BUX7TLQxNwTjo6QEGgXrqLZV5
         G0UloFj2HnPMDbyzD4rCs57l25/YJcTKYwdzyZ4aCb7w8gfK8idVcU4FdFuBAvg66e
         Kh/ti9o0EjgPHDvX/pmLu/p1uc8/fCjWI1spaVgE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FD2A608CC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] soc: qcom: rpmhpd: Set 'active_only' for active only
 power domains
To:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20190214173633.211000-1-dianders@chromium.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <69c46e02-f6b7-c6b3-5dc1-8c9ecd88b14d@codeaurora.org>
Date:   Fri, 15 Feb 2019 08:02:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214173633.211000-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/14/2019 11:06 PM, Douglas Anderson wrote:
> The 'active_only' attribute was accidentally never set to true for any
> power domains meaning that all the code handling this attribute was
> dead.
> 
> NOTE that the RPM power domain code (as opposed to the RPMh one) gets
> this right.
> 
> Fixes: 279b7e8a62cc ("soc: qcom: rpmhpd: Add RPMh power domain driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks for catching this. I seem to have introduced this bug when I moved
away from using the macros to define these static structs and failed to add
the property :/

Acked-by: Rajendra Nayak <rnayak@codeaurora.org>

> ---
> 
>   drivers/soc/qcom/rpmhpd.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 5741ec3fa814..51850cc68b70 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -93,6 +93,7 @@ static struct rpmhpd sdm845_mx = {
>   
>   static struct rpmhpd sdm845_mx_ao = {
>   	.pd = { .name = "mx_ao", },
> +	.active_only = true,
>   	.peer = &sdm845_mx,
>   	.res_name = "mx.lvl",
>   };
> @@ -107,6 +108,7 @@ static struct rpmhpd sdm845_cx = {
>   
>   static struct rpmhpd sdm845_cx_ao = {
>   	.pd = { .name = "cx_ao", },
> +	.active_only = true,
>   	.peer = &sdm845_cx,
>   	.parent = &sdm845_mx_ao.pd,
>   	.res_name = "cx.lvl",
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
