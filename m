Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0683AC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E7520659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KPb+9j16";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ApNvNCmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E7520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbeIGDJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:09:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49006 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeIGDJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:09:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 638D06029D; Thu,  6 Sep 2018 22:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536273097;
        bh=wR04+f4Fc/Bwj57JlbTjkLiGK3lT1+KRkjYu6+0g5Xk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KPb+9j16d/PUSeClI3pi2PNsbeUPEt4KD8kmmDabBgIKe1QBZGG1Z5PGwI832s0UV
         ly2YZ6ItbJluQxn4hqnKcXxtxMKNT7qQFPKDS4/BhvOEhVYMFFDst/Q0s12CA8LlOU
         y/NNAwuI2kyu+BNgfsCXSw28/eud5Zz/lK9INxak=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DCEC9601D9;
        Thu,  6 Sep 2018 22:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536273096;
        bh=wR04+f4Fc/Bwj57JlbTjkLiGK3lT1+KRkjYu6+0g5Xk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ApNvNCmHXxhmaqkecEgHpwNWqk+6SkqT5XW5Az6YyGEVs6XkHnCQ00/mjEdv32G7l
         lRKpFNvqqSjaCYhIM31hRBYH66y/59QY0hGuW2apVe8Hxo5IeBv/OOlgXS12/lYpWt
         psNdf5HyFstCZRSHLU6fEQnMDKSvqGbfg30tZsnI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Sep 2018 15:31:36 -0700
From:   vnkgutta@codeaurora.org
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Borislav Petkov <bp@alien8.de>, evgreen@chromium.org,
        robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH v4 3/4] drivers: edac: Add EDAC driver support for QCOM
 SoCs
In-Reply-To: <105f8339-61bc-072e-0498-ed44470a5fb8@codeaurora.org>
References: <1536103345-1919-1-git-send-email-vnkgutta@codeaurora.org>
 <1536103345-1919-4-git-send-email-vnkgutta@codeaurora.org>
 <105f8339-61bc-072e-0498-ed44470a5fb8@codeaurora.org>
Message-ID: <5d8f92b480e1b53e7e04da965d44f7ea@codeaurora.org>
X-Sender: vnkgutta@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-06 05:38, Sai Prakash Ranjan wrote:
> On 9/5/2018 4:52 AM, Venkata Narendra Kumar Gutta wrote:
>> +static const struct of_device_id qcom_llcc_edac_match_table[] = {
>> +	{ .compatible = "qcom,llcc-edac" },
>> +	{ },
>> +};
>> +
>> 
> Hi Venkata,
> 
> Devicetree binding for llcc is updated, but what about this compatible?

Does it need documentation too? I was not sure if I should add 
documentation for this or not!

> 
> Regards,
> Sai
