Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2AEC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2572405B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GZ+f5FPC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B3XIy7Al"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2572405B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeFVKg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:36:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51554 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbeFVKgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:36:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F390560714; Fri, 22 Jun 2018 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529663784;
        bh=7y7AAtEhg1NPPztWkyAYrWW2du4Xfs0eXX9tfhLu9DY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GZ+f5FPCLzP3q/9Le7MITjPrVIFTaG4Bvtc3h3I7LwdseHa+qOyQ0NImNpljjDxmG
         +ewxyOg517HJpmV8xsCVL6daUeoSOVjN7jm0IveSykUMC/RxJPDqTUXKpsgbb3F7ks
         8Jp3N/fMY+vg0HtVEodjyMcVxQF9ftz+Czi/8P74=
Received: from [10.204.110.13] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3347E604A6;
        Fri, 22 Jun 2018 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529663783;
        bh=7y7AAtEhg1NPPztWkyAYrWW2du4Xfs0eXX9tfhLu9DY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B3XIy7AlCBu1ercfR06rwpAg6cxHxeimbsJGByiYAALyif0YlbTZN2udlndpc09X9
         HU9h29O8JXsOhAK+QXn3eYq9NL4L26VFOmxIGeL9e1r1qyQfm7zyW0ituvsqUCbPPV
         z1iW6ykoMPSbml1fognsNVHGnVAxHDeGidPB3f2U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3347E604A6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v2 2/2] ASoC: qcom: add sdm845 sound card
 support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod <vkoul@kernel.org>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-3-git-send-email-rohitkr@codeaurora.org>
 <20180621123503.GD27187@vkoul-mobl>
 <46f1a6af-a180-2568-d203-87323379c2fd@linaro.org>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <58db39ee-d2a7-1cdf-c7e2-eea020c8a2c6@codeaurora.org>
Date:   Fri, 22 Jun 2018 16:06:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <46f1a6af-a180-2568-d203-87323379c2fd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/2018 8:39 PM, Srinivas Kandagatla wrote:
>
>
> On 21/06/18 13:35, Vinod wrote:
>> And this one is generic DT parsing and seems quite similar to one in 
>> apq8096.c
>> Can we move these into a lib and use them instead of duplicating.
> I totally agree with Vinod, We should probably come up with a library 
> functions something like common.c so that we do not duplicate code.
> This code is going be exactly same for most of the SoCs using qdsp.
>
Sure, I will add a new file, qcom_snd_common.c, which will have these 
common functions and will update apq8096 and sdm845 machine driver to use
APIs exposed by qcom_snd_common.c

> thanks,
> srini
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Regards,
Rohit

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

