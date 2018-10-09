Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0E4C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EB9214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Sr8Dn5XV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Sr8Dn5XV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EB9214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJIXh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:37:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40466 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIXh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:37:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AB1BD6063F; Tue,  9 Oct 2018 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539101984;
        bh=oFpBGcPd1+rBBtioyji4zTjENOEaaQ/T3PVFVq9vvhA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sr8Dn5XVobhudTwV9jPi1TZumPvkAKOmOgwBJJ/3ybMbcIizyLmfd96LoF/k21rzF
         r89zsNljgGCNWREnF+dJCe+6TzpSQoWYlF6i4DyDX4qbm+P8rM/pSoaAd7GMdHw4xN
         SgfsIPdwpDvTqPCEn5ppAbBcPkpwdAC4p74dmTcg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 104B36063F;
        Tue,  9 Oct 2018 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539101984;
        bh=oFpBGcPd1+rBBtioyji4zTjENOEaaQ/T3PVFVq9vvhA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sr8Dn5XVobhudTwV9jPi1TZumPvkAKOmOgwBJJ/3ybMbcIizyLmfd96LoF/k21rzF
         r89zsNljgGCNWREnF+dJCe+6TzpSQoWYlF6i4DyDX4qbm+P8rM/pSoaAd7GMdHw4xN
         SgfsIPdwpDvTqPCEn5ppAbBcPkpwdAC4p74dmTcg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Oct 2018 21:49:44 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v3 4/6] remoteproc: qcom: q6v5-pil: Add custom dump
 function for modem
In-Reply-To: <20181008064505.GO12063@builder>
References: <20180727152003.11663-1-sibis@codeaurora.org>
 <20180727152003.11663-5-sibis@codeaurora.org>
 <20181008064505.GO12063@builder>
Message-ID: <ab7ccaf06b92de38224202f3ca16749b@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review !

On 2018-10-08 12:15, Bjorn Andersson wrote:
> On Fri 27 Jul 08:20 PDT 2018, Sibi Sankar wrote:
>> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c 
>> b/drivers/remoteproc/qcom_q6v5_pil.c
> [..]
>> +static void qcom_q6v5_dump_segment(struct rproc *rproc, void *ptr, 
>> size_t len,
>> +								   void *priv)
>> +{
>> +	int ret = 0;
>> +	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
>> +	static u32 pending_mask;
> 
> I dislike that this is a static variable. And it tracks the segments
> that has already been dumped, i.e. the !pending.
> 
>> +
>> +	/* Unlock mba before copying segments */
>> +	if (!qproc->mba_loaded)
>> +		ret = q6v5_mba_load(qproc);
>> +
>> +	if (!ptr || ret)
>> +		memset(priv, 0xff, len);
>> +	else
>> +		memcpy(priv, ptr, len);
>> +
>> +	pending_mask++;
> 
> This is a "count" and not a "mask".
> 

will rename it to count in the next re-spin. We can implement this as
a mask as well, the only disadvantage I see in that case is the need
for another flag to determine if mba is loaded since the mask for the
first segment may not be zero (the first segment may not be valid).

> I can see a few different cases where one would like to be able to pass
> custom data/information from the segment-registration to the dump
> function. So how about adding a "void *priv" to the dump segment.
> 
> For this particular case we could typecast segment->priv to an unsigned
> long (as this is always the same size) and use that as a bitmask, which
> we use to update pending_mask.
> 

sure will do the same

>> +	if (pending_mask == qproc->valid_mask) {
>> +		if (qproc->mba_loaded)
>> +			q6v5_mba_reclaim(qproc);
>> +		pending_mask = 0;
>> +	}
> 
> I think it would be cleaner to reset pending_mask in the start 
> function,
> and then return early in this function when we have dumped all the
> segments.
> 
> If so can pending_mask == 0 and pending_mask == all be the triggers for
> loading and reclaiming the mba? So we don't have two different trackers
> for this?
> 

with the private data stored per dump segment this becomes much simpler 
:)

>> +}
>> +
> 
> Regards,
> Bjorn

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
