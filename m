Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 66D27C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F25D208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ojn8JssK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XLRCk6P7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F25D208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755243AbeFNSRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:17:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38406 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754713AbeFNSRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:17:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0CDC260132; Thu, 14 Jun 2018 18:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529000257;
        bh=lbgdQTAA7XaFpxyhu8LI9lAueV3nFwpm6jwsxrbapnY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ojn8JssKsVnsZUV/x3imY2arD8Y2oEtbHOmlJfOaN/v5wwTGgX8PqzYtXBUY45L7u
         DFcJ4VXuG113H/drw8zDNXIqUQNMoox6XVKcJ3w2fP4qtaVc8sKC5gl3JXdEqjZJIX
         VHOd7bPWiLMaSt0A31vUpTcUA4c8luJXSku2AfA4=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 005C2602B8;
        Thu, 14 Jun 2018 18:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529000256;
        bh=lbgdQTAA7XaFpxyhu8LI9lAueV3nFwpm6jwsxrbapnY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XLRCk6P7EI40LZEPYH9dHR6hjFRIxNEg/HW89mhA3A7hz0IpTz3e/rldU8ZBl2nLM
         NG/3xGzeV6tG/8IqdqHdxfS3eZ7vKaBCexG3CVUh3FbJsn0OnEvYGhRFIG+RCLG90H
         G4QLj25ATm1Whu8gX2xwoN6OfSEtmcq+4adTEScw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 005C2602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v3 6/7] soc: qcom: Add RPMh Power domain driver
To:     Rajendra Nayak <rnayak@codeaurora.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180612044052.4402-1-rnayak@codeaurora.org>
 <20180612044052.4402-7-rnayak@codeaurora.org>
 <d438946d-3d6f-4436-27c7-3eae4559ec53@codeaurora.org>
 <f6b166ee-538f-c8b7-3be5-57c20a599d47@codeaurora.org>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <bd8999bd-a3ae-b7e2-a805-b31d38571ec6@codeaurora.org>
Date:   Thu, 14 Jun 2018 11:17:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <f6b166ee-538f-c8b7-3be5-57c20a599d47@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rajendra,

On 06/13/2018 11:54 PM, Rajendra Nayak wrote:
> On 06/14/2018 06:02 AM, David Collins wrote:
>> On 06/11/2018 09:40 PM, Rajendra Nayak wrote:
...
>>> +static int rpmhpd_power_off(struct generic_pm_domain *domain)
>>> +{
>>> +	struct rpmhpd *pd = domain_to_rpmhpd(domain);
>>> +	int ret = 0;
>>> +
>>> +	mutex_lock(&rpmhpd_lock);
>>> +
>>> +	if (pd->level[0] == 0)
>>> +		ret = rpmhpd_aggregate_corner(pd, 0);
>>
>> I'm not sure that we want to have the 'pd->level[0] == 0' check,
>> especially when considering aggregation with the peer pd.  I understand
>> its intention to try to keep enable state and level setting orthogonal.
>> However, as it stands now, the final request sent to hardware would differ
>> depending upon the order of calls.  Consider the following example.
>>
>> Initial state:
>> pd->level[0] == 0
>> pd->corner = 5, pd->enabled = true, pd->active_only = false
>> pd->peer->corner = 7, pd->peer->enabled = true, pd->peer->active_only = true
>>
>> Outstanding requests:
>> RPMH_ACTIVE_ONLY_STATE = 7, RPMH_WAKE_ONLY_STATE = 7, RPMH_SLEEP_STATE = 5
>>
>> Case A:
>> 	1. set pd->corner = 6
>> 		--> new value request: RPMH_SLEEP_STATE = 6
>> 		--> duplicate value requests: RPMH_ACTIVE_ONLY_STATE = 7,
>> 			RPMH_WAKE_ONLY_STATE = 7
>> 	2. power_off pd->peer
>> 		--> no requests
> 
> I am not sure why there would be no requests, since we do end up aggregating
> with pd->peer->corner = 0.
> So the final state would be
> 
> RPMH_ACTIVE_ONLY_STATE = max(6, 0) = 6
> RPMH_WAKE_ONLY_STATE = 6
> RPMH_SLEEP_STATE = max(6, 0) = 6

Argh, my example was ruined by a one character typo.  I meant to have:

	Initial state:
	pd->level[0] != 0


>>
>> 	Final state:
>> 	RPMH_ACTIVE_ONLY_STATE = 7
>> 	RPMH_WAKE_ONLY_STATE = 7
>> 	RPMH_SLEEP_STATE = 6
>>
>> Case B:
>> 	1. power_off pd->peer
>> 		--> no requests
> 
> Here it would be again be aggregation based on pd->peer->corner = 0
> so,
> RPMH_ACTIVE_ONLY_STATE = max(5, 0) = 5
> RPMH_WAKE_ONLY_STATE = 5
> RPMH_SLEEP_STATE = max(5, 0) = 5
> 
>> 	2. set pd->corner = 6
>> 		--> new value requests: RPMH_ACTIVE_ONLY_STATE = 6,
>> 		       RPMH_WAKE_ONLY_STATE = 6, RPMH_SLEEP_STATE = 6
>>
>> 	Final state:
>> 	RPMH_ACTIVE_ONLY_STATE = 6
>> 	RPMH_WAKE_ONLY_STATE = 6
>> 	RPMH_SLEEP_STATE = 6
> 
> correct,
> RPMH_ACTIVE_ONLY_STATE = max(6, 0) = 6
> RPMH_WAKE_ONLY_STATE = 6
> RPMH_SLEEP_STATE = max(6, 0) = 6
> 
>>
>> Without the check, Linux would vote for the lowest supported level when
>> power_off is called.  This seems semantically reasonable given that the
>> consumer is ok with the power domain going fully off and that would be the
>> closest that we can get.
> 
> So are you suggesting I replace
> 
>>> +	if (pd->level[0] == 0)
>>> +		ret = rpmhpd_aggregate_corner(pd, 0);
> 
> with
> 
>>> +	ret = rpmhpd_aggregate_corner(pd, pd->level[0]);

Yes, this is the modification that I'm requesting.


> I can see what you said above makes sense but if its
>> Initial state:
>> pd->level[0] != 0
> 
> Was that what you meant?

Yes.


> I can't seem to see any ARC resources on 845 which seem to 
> have a 'pd->level[0] != 0' but looks like thats certainly a
> possibility we need to handle?

The command DB interface for ARC resources was designed to support the
situation of a power domain that could not be fully disabled and is
instead limited to some minimum level.

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
