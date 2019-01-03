Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90270C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CC520815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kvR2/2Tx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VmuJ7zLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfACRss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:48:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34466 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbfACRss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:48:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 345BC607B9; Thu,  3 Jan 2019 17:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546537727;
        bh=QuLCUhkulCISAG5fqjlHoZ5RuqBUIiu+npW3Rt9cLxc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kvR2/2TxQ/S4+KzGCfSvQMwWl+Yy8DiU4FlK3ch6TThuNKS4vKMqwLPKHCZwtXgfw
         QV/qjLJZ4hGHZo+kid8Okh2t+phQCUSPjHq/+V0B2/d+n/PQZH9J+E1H0Gqx23SAuk
         1EFBf5d+oB4xRAvc2tMd6ps440iAoYk6iOuDetiI=
Received: from [192.168.1.130] (unknown [183.83.163.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 952666022B;
        Thu,  3 Jan 2019 17:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546537726;
        bh=QuLCUhkulCISAG5fqjlHoZ5RuqBUIiu+npW3Rt9cLxc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VmuJ7zLz1m/VsObGQYGAKGjI6lZMUWjZKY1gDdaU8lt1eFja3OPrejKX0oaHPsOVU
         fXR9Oo0drtrZHyea3qEpVEYCM2W1TJSqRgDaNm2BaasdBpKdKzixun0kAtgqtDhHdk
         jSvA3JIvJd0Nnbc99n506HTcsoGh4CcBi1qItJBY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 952666022B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
Subject: Re: [PATCH 2/3] soc: qcom: Add AOSS QMP communication driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181112080557.22698-1-bjorn.andersson@linaro.org>
 <20181112080557.22698-3-bjorn.andersson@linaro.org>
 <ce0d4d55-464c-1502-9dc1-b3a495c86aee@codeaurora.org>
 <20181226202830.GE9704@minitux>
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
Message-ID: <49070dc1-2201-1ea7-b9b6-f98663e2cfd2@codeaurora.org>
Date:   Thu, 3 Jan 2019 23:18:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181226202830.GE9704@minitux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/27/2018 1:58 AM, Bjorn Andersson wrote:
> On Tue 20 Nov 04:22 PST 2018, Arun Kumar Neelakantam wrote:
>
> Thanks for the review Arun.
>
>> On 11/12/2018 1:35 PM, Bjorn Andersson wrote:
> [..]
>>> +int qmp_send(struct qmp *qmp, const void *data, size_t len)
>>> +{
>>> +	int ret;
>>> +
>>> +	if (WARN_ON(len + sizeof(u32) > qmp->size)) {
>>> +		dev_err(qmp->dev, "message too long\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (WARN_ON(len % sizeof(u32))) {
>>> +		dev_err(qmp->dev, "message not 32-bit aligned\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	mutex_lock(&qmp->tx_lock);
>>> +
>>> +	if (!qmp_message_empty(qmp)) {
>>> +		dev_err(qmp->dev, "mailbox left busy\n");
>>> +		ret = -EINVAL;
>> should it be -EBUSY ?
> That makes more sense.
>
>> And qmp_messge_empty will be done either by remote if it process the data
>> else by this driver in TIMEOUT case, so does we need this check for every TX
>> ? I think we can just reset to Zero once in open time.
> Didn't think about that, should we really make the QMP link ready again
> when we get a timeout? Can we expect that the firmware of the remote
> side is ready to serve future messages?
>
>
> Should we keep this check and remove the writel() below?
I prefer we can just remove this check and keep writel() below same as 
down stream.
>
>>> +		goto out_unlock;
>>> +	}
>>> +
>>> +	/* The message RAM only implements 32-bit accesses */
>>> +	__iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
>>> +			 data, len / sizeof(u32));
>>> +	writel(len, qmp->msgram + qmp->offset);
>>> +	qmp_kick(qmp);
>>> +
>>> +	ret = wait_event_interruptible_timeout(qmp->event,
>>> +					       qmp_message_empty(qmp), HZ);
>>> +	if (!ret) {
>>> +		dev_err(qmp->dev, "ucore did not ack channel\n");
>>> +		ret = -ETIMEDOUT;
>>> +
>>> +		writel(0, qmp->msgram + qmp->offset);
>>> +	} else {
>>> +		ret = 0;
>>> +	}
>>> +
>>> +out_unlock:
>>> +	mutex_unlock(&qmp->tx_lock);
>>> +
>>> +	return ret;
>>> +}
> Regards,
> Bjorn
