Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E52C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A01120870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QyvgrCw6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QyvgrCw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A01120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeLLERU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 23:17:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46410 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLLERU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 23:17:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8CEDF60208; Wed, 12 Dec 2018 04:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544588239;
        bh=PWWpoUcq4inn7X1qQXjaRChluKr0PV5bodXjlGDO7fA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QyvgrCw6j8pxlHWAiPalrcgwidnDCqDKZpjuhdDO1OZLl7RcgqUB9do4oW+/6jWK9
         /2iAapDOpXPHexNd4dmCYKNHUZ55sKrF8lLLdXsK8lneMjxj2CHSOr//Ts2lk15Q9u
         6/CmxaLL6kRUKtm1o+WrNFP3BISWn0cnTAip/AdQ=
Received: from [10.79.128.154] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 497E0601B4;
        Wed, 12 Dec 2018 04:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544588239;
        bh=PWWpoUcq4inn7X1qQXjaRChluKr0PV5bodXjlGDO7fA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QyvgrCw6j8pxlHWAiPalrcgwidnDCqDKZpjuhdDO1OZLl7RcgqUB9do4oW+/6jWK9
         /2iAapDOpXPHexNd4dmCYKNHUZ55sKrF8lLLdXsK8lneMjxj2CHSOr//Ts2lk15Q9u
         6/CmxaLL6kRUKtm1o+WrNFP3BISWn0cnTAip/AdQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 497E0601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v6 00/10] Add power domain driver for corners on
 msm8996/sdm845
To:     Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181211094938.25086-1-rnayak@codeaurora.org>
 <154456511414.17204.10860688288502708116@swboyd.mtv.corp.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <24b358b9-6a62-da48-88af-8b2d2bfc31a9@codeaurora.org>
Date:   Wed, 12 Dec 2018 09:47:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <154456511414.17204.10860688288502708116@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/12/2018 3:21 AM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2018-12-11 01:49:28)
>> Changes in v6:
>> * OPP binding updates for qcom,level reviewed by Rob
>> * DT bindings for rpmpd and rpmhpd updated to specify the
>> OPP tables as child nodes of the power-controller itself
>> * Removed some module specific remains from the drivers,
>> now that they can only be built-in
>> * Added a simple_opp_to_performance_state() helper
> 
> Is the idea that it can be squashed into the patches that use it by
> reordering the series? But otherwise left at the end of the series to
> make things simpler to merge without it?

Yes, I left them at the end so its easier to merge. The PM domains change
would need to go via Ulf/Viresh while the SoC drivers using them would
go via Andy. So now its only 09/10 that's dependent on 08/10 and not the
entire series.

