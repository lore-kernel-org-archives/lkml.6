Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFB5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3183E208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iNnvwLCV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iNnvwLCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3183E208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbeGIXoT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:44:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60702 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932847AbeGIXoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:44:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DB39860A06; Mon,  9 Jul 2018 23:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531179855;
        bh=NcaTl0FanZpBTixD51Hlm5ivEKYRvUELONPhsq8TpVI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iNnvwLCVIrx554fkToeRLl/TTqBrYcr7MFolDdJ0SR5iLO6Z7tANXsWVCKWB76Uv/
         KiS2QnyVuoHLMsYGS+rKyEwafVzsLhl1aGshfXbmFWQYkR68lUpEVKLIqt01M6aX14
         tjt4wMk4r5OhZfnJ09Ew+IVBLyApO+uypHyZravE=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB387600C1;
        Mon,  9 Jul 2018 23:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531179855;
        bh=NcaTl0FanZpBTixD51Hlm5ivEKYRvUELONPhsq8TpVI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iNnvwLCVIrx554fkToeRLl/TTqBrYcr7MFolDdJ0SR5iLO6Z7tANXsWVCKWB76Uv/
         KiS2QnyVuoHLMsYGS+rKyEwafVzsLhl1aGshfXbmFWQYkR68lUpEVKLIqt01M6aX14
         tjt4wMk4r5OhZfnJ09Ew+IVBLyApO+uypHyZravE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB387600C1
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
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <9bbfb628-018d-2d89-257b-9cc4e716cb46@codeaurora.org>
Date:   Mon, 9 Jul 2018 16:44:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180702102853.GI18211@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 07/02/2018 03:28 AM, Mark Brown wrote:
> On Fri, Jun 22, 2018 at 05:46:14PM -0700, David Collins wrote:
> 
>> --- /dev/null
>> +++ b/drivers/regulator/qcom-rpmh-regulator.c
>> @@ -0,0 +1,746 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
>> +
> 
> Please make the entire header block C++ so it looks intentional.

Sure, I'll change this.

I was trying to follow the guideline that kernel C source files should use
C style comments while at the same time following the SPDX guideline that
C++ style comments are needed for the SPDX line in C source files [1].


>> +	cmd.data = bypassed ? PMIC4_BOB_MODE_PASS : pmic_mode;
> 
> Please just write normal if statements, the ternery operator isn't
> really helping legibility.

I'll change this.


>> +static const int pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
>> +	[REGULATOR_MODE_INVALID] = -EINVAL,
>> +	[REGULATOR_MODE_STANDBY] = PMIC4_LDO_MODE_RETENTION,
>> +	[REGULATOR_MODE_IDLE]    = PMIC4_LDO_MODE_LPM,
>> +	[REGULATOR_MODE_NORMAL]  = -EINVAL,
>> +	[REGULATOR_MODE_FAST]    = PMIC4_LDO_MODE_HPM,
>> +};
> 
> This mapping is really weird, I'd expect one of the modes to correspond
> to the normal operating mode of the regulator.  

My thinking here was to have a consistent mapping for consumers to use
between REGULATOR_MODE_* and physical regulator modes for both LDO and
SMPS type regulators:

REGULATOR_MODE_STANDBY --> Retention (if supported)
REGULATOR_MODE_IDLE    --> Low power mode (if supported)
                           LPM for LDO and PFM for SMPS
REGULATOR_MODE_NORMAL  --> Auto HW switching between low and high power
                           mode (if supported)
REGULATOR_MODE_FAST    --> High power mode
                           HPM for LDO and PWM for SMPS

This allows a consumer to request NORMAL in typical use cases and FAST in
use cases that require low voltage ripple.  If NORMAL is not supported,
then it automatically gets upgraded to FAST by the regulator framework.

I could change it so that REGULATOR_MODE_NORMAL maps to LDO HPM mode.
However, doing so would make it so that REGULATOR_MODE_FAST requests would
fail for LDOs.  Thus, consumers would need to know if their supply is an
LDO or an SMPS (which seems undesirable).

Would it be acceptable to have both NORMAL and FAST map to LDO HPM?


>> +static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int mode)
>> +{
>> +	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
>> +		[RPMH_REGULATOR_MODE_RET]  = REGULATOR_MODE_STANDBY,
>> +		[RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
>> +		[RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_INVALID,
>> +		[RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
>> +	};
> 
> Same here, based on that it looks like auto mode is a good map for
> normal.

LDO type regulators physically do not support AUTO mode.  That is why I
specified REGULATOR_MODE_INVALID in the mapping.


>> +	if (mode >= RPMH_REGULATOR_MODE_COUNT)
>> +		return -EINVAL;
> 
> Why not use ARRAY_SIZE?

I'll change this.


Thanks,
David

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst?h=v4.18-rc4#n74

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
