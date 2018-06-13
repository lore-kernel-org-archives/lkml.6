Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3B536C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BBB2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DzXRgw8v";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HT6mRboV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BBB2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935879AbeFMW2M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:28:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935256AbeFMW2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:28:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A2476074D; Wed, 13 Jun 2018 22:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528928890;
        bh=5frBymXh7v2Dqbz8eNK0T5idHS0QY05opr3Tsc6dkyc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DzXRgw8v5WBGhrrf15crk+/rnyk2KrxqZ+WWNN4gu6dqpjAhhCHgZhc2GT8Nu2yDX
         XSEa3uMsTz7tVbr0tD3vB7Yfig14EArsokP2x/Eq0Xuh3j9DPXemV0LzKM9/fFgH1e
         leL80dPh3rhkdaC63P9aNZsGeJ3YE25u0yh5zjvA=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F6EA602BC;
        Wed, 13 Jun 2018 22:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528928889;
        bh=5frBymXh7v2Dqbz8eNK0T5idHS0QY05opr3Tsc6dkyc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HT6mRboVGF51OOPzcWL42iGm0vPtzbSVr0mIM01iadPOxiyVzhJ8/tBfFNYhQOsSq
         ZlIWmGEBOQ7f4TcRBbYiudeb8VIkjklkBpI18bE3IyBnpvns74ewAHBN2mDV07tD1R
         iHbYz1m1vMkrkiOdhRTwhlBL0T8YueorXZQSM0M0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F6EA602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v3 7/7] soc: qcom: rpmpd/rpmhpd: Add a max vote on all
 corners at init
To:     Rajendra Nayak <rnayak@codeaurora.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180612044052.4402-1-rnayak@codeaurora.org>
 <20180612044052.4402-8-rnayak@codeaurora.org>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <414598de-00a1-9ce7-3a7e-4a95fd1bd35d@codeaurora.org>
Date:   Wed, 13 Jun 2018 15:28:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180612044052.4402-8-rnayak@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rajendra,

On 06/11/2018 09:40 PM, Rajendra Nayak wrote:
> As we move from no clients/consumers in kernel voting on corners,
> to *some* voting and some not voting, we might end up in a situation
> where the clients which remove votes can adversly impact others

s/adversly/adversely/

> who still don't have a way to vote.
> 
> To avoid this situation, have a max vote on all corners at init.
> This should/can be removed once we have all clients moved to
> be able to vote/unvote for themselves.

This change seems like a hack.  Do you intend for it to be merged and then
later reverted in Linus's tree?  Could it instead be implemented in a way
that does not require reverting and instead is enabled by some DT
property?  Alternatively, could this feature be added to the power domain
core since it is relatively generic?


> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/soc/qcom/rpmhpd.c | 12 +++++++++++-
>  drivers/soc/qcom/rpmpd.c  |  9 +++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 7083ec1590ff..3c753d33aeee 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -329,7 +329,7 @@ static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>  
>  static int rpmhpd_probe(struct platform_device *pdev)
>  {
> -	int i, ret;
> +	int i, ret, max_level;
>  	size_t num;
>  	struct genpd_onecell_data *data;
>  	struct rpmhpd **rpmhpds;
> @@ -390,6 +390,16 @@ static int rpmhpd_probe(struct platform_device *pdev)
>  		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
>  
>  		data->domains[i] = &rpmhpds[i]->pd;
> +
> +		/*
> +		 * Until we have all consumers voting on corners
> +		 * just vote the max corner on all PDs
> +		 * This should ideally be *removed* once we have
> +		 * all (most) consumers being able to vote
> +		 */
> +		max_level = rpmhpds[i]->level_count - 1;
> +		rpmhpd_set_performance(&rpmhpds[i]->pd, rpmhpds[i]->level[max_level]);
> +		rpmhpd_power_on(&rpmhpds[i]->pd);

Clearly these calls will result in max level requests being sent for all
power domains at probe time.  However, it isn't clear that this will
actually help at runtime in these two cases:

1. A consumer enables and then disables a power domain.
	- It seems like the PD would just be disabled in this case.

2. A consumer sets a non-max performance state of a power domain.
	- It seems like the PD would just be set to the new lower
	  performance state since the max vote isn't known to the
	  PD core for aggregation purposes.

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
