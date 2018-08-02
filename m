Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6696DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185A421564
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fubUGFY3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TCFlWNIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185A421564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeHBU7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:59:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40764 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeHBU7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:59:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 50EDA60AFF; Thu,  2 Aug 2018 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533236828;
        bh=VArxtrapZOKxMGM7BQqMAckucFRHf6zVKZHq/vgEL1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fubUGFY3lMPnd5UHbPKZr36/hBX29QuFk+RTbik1P+ABkOHnmsfzFRoAlOxolboim
         jQ398fW9hwX3VPxi0BEt8CyEDQcjO3OIxe/WxGYdqOLl2zNVLp+mCiJ7MdTHLsOZoP
         oqL/6Nkby+/9QriCtbE0x0raUnD+cmLxyAjibaqw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 74554602B7;
        Thu,  2 Aug 2018 19:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533236827;
        bh=VArxtrapZOKxMGM7BQqMAckucFRHf6zVKZHq/vgEL1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TCFlWNIC5fxLjZf4fjr/Ux4oyb/b4AoYEJl76aq340lq6kFUPRcv+uaRymim+WOU4
         Qh0oJEYJeGKZ+qGlee7/hiYy2bdfADhQuKJS2j8qaEnZAzK7uRiR78OhWE0FcY2/qd
         e5LfTNX/UliVXC14rz5CkF7c/kpW5vTPskloqCfI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Aug 2018 12:07:07 -0700
From:   skannan@codeaurora.org
To:     myungjoo.ham@samsung.com
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add devfreq driver for interconnect
 bandwidth voting
In-Reply-To: <20180802101341epcms1p53ee79776dbcbeaf6f1e7910b20095220@epcms1p5>
References: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
 <CGME20180802005759epcas4p4a68d50e61c8425124a993de1917021a2@epcms1p5>
 <20180802101341epcms1p53ee79776dbcbeaf6f1e7910b20095220@epcms1p5>
Message-ID: <e7bd0cbc4131f597a1fb68af1cfd1a67@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-02 03:13, MyungJoo Ham wrote:
>> This driver registers itself as a devfreq device that allows devfreq
>> governors to make bandwidth votes for an interconnect path. This 
>> allows
>> applying various policies for different interconnect paths using 
>> devfreq
>> governors.
>> 
> 
> First of all, the name, "devfreq_icbw", is not appropriate for a
> devfreq device driver. It confuses; it looks like a part of the
> framework itself.
> 
>> diff --git a/drivers/devfreq/devfreq_icbw.c 
>> b/drivers/devfreq/devfreq_icbw.c
>> new file mode 100644
>> index 0000000..231fb21
>> --- /dev/null
>> +++ b/drivers/devfreq/devfreq_icbw.c
>> @@ -0,0 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2013-2014, 2018, The Linux Foundation. All rights 
>> reserved.
>> + */
>> +
>> +#define pr_fmt(fmt) "icbw: " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/mutex.h>
>> +#include <linux/devfreq.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of.h>
>> +#include <linux/interconnect.h>
> 
> Where can I find this file?

Sorry, meant to mention this in the email specific portion of the commit 
text. This is on top of the interconnect framework series that Georgi 
has been working on. linux-pm should have those patches.


>> +
>> +struct dev_data {
>> +	struct icc_path *path;
>> +	u32 cur_ab;
>> +	u32 cur_pb;
>> +	unsigned long gov_ab;
>> +	struct devfreq *df;
>> +	struct devfreq_dev_profile dp;
>> +};
>> +
>> +static int icbw_target(struct device *dev, unsigned long *freq, u32 
>> flags)
>> +{
>> +	struct dev_data *d = dev_get_drvdata(dev);
>> +	int ret;
>> +	u32 new_pb = *freq, new_ab = d->gov_ab;
>> +
>> +	if (d->cur_pb == new_pb && d->cur_ab == new_ab)
>> +		return 0;
>> +
>> +	dev_dbg(dev, "BW KBps: AB: %u PB: %u\n", new_ab, new_pb);
>> +
>> +	ret = icc_set(d->path, new_ab, new_pb);
> 
> I'm not sure if icc_set is available.

Yeah, it's available on that patch series.

-Saravana
