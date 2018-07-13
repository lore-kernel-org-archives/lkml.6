Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A20ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84C2214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W7Ds9c1e";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SRZbKckk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84C2214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387978AbeGMBqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 21:46:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58208 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387916AbeGMBqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 21:46:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8FE2E60B72; Fri, 13 Jul 2018 01:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531445644;
        bh=kxlr6AQTxvSp7Xi2YApJ0KHXD1mMqpQjyvxG9zGbDZo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W7Ds9c1eFBBBJtMhK5uMAEI/NiV2xFaYVHeORrVOtdZ4nxxD5m0FvMzExNfRX+dEo
         iyfxo+CT/taVYPnK2fPvZhFUH2kWaR+9CydEF/kI9B0IRzcowcprEkGzEXTgeSjxCE
         o4ORSWrp5fOBFzbp5Z4QWLlwFCK2eSLMJH2C2ZZY=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6542560227;
        Fri, 13 Jul 2018 01:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531445643;
        bh=kxlr6AQTxvSp7Xi2YApJ0KHXD1mMqpQjyvxG9zGbDZo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SRZbKckksZ+eaBYpa/vsprZP6Ht/GUKbWfNBPJibpjHTeFWHfnsD9+OY6G8P4ur6H
         RyTceI0e9UhIBIHI0aANRAj2zihdJ7kYSyTHiITIL155/nypADvBCwGPJKzitsG4ec
         xfGFLwaeYNM/Ak7nBKzNbjUB840CwKumZS58IwZ8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6542560227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        sboyd@kernel.org, dianders@chromium.org, mka@chromium.org
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <20180702102853.GI18211@sirena.org.uk>
 <9bbfb628-018d-2d89-257b-9cc4e716cb46@codeaurora.org>
 <20180712165457.GI10369@sirena.org.uk>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <c6919357-6c3b-1f69-4d51-2ed2ddd2c942@codeaurora.org>
Date:   Thu, 12 Jul 2018 18:34:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180712165457.GI10369@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 09:54 AM, Mark Brown wrote:
> On Mon, Jul 09, 2018 at 04:44:14PM -0700, David Collins wrote:
>> On 07/02/2018 03:28 AM, Mark Brown wrote:
>>> On Fri, Jun 22, 2018 at 05:46:14PM -0700, David Collins wrote:
>>>> +static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int mode)
>>>> +{
>>>> +	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
>>>> +		[RPMH_REGULATOR_MODE_RET]  = REGULATOR_MODE_STANDBY,
>>>> +		[RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
>>>> +		[RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_INVALID,
>>>> +		[RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
>>>> +	};
> 
>>> Same here, based on that it looks like auto mode is a good map for
>>> normal.
> 
>> LDO type regulators physically do not support AUTO mode.  That is why I
>> specified REGULATOR_MODE_INVALID in the mapping.
> 
> The other question here is why this is even in the table if it's not
> valid (I'm not seeing a need for the MODE_COUNT define)?

I thought that having a table would be more concise and easier to follow.
I can change this to a switch case statement.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
