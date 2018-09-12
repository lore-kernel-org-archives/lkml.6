Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2600C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8154B20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ck0Lt2GO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AYuhKCAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8154B20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeILHYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 03:24:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbeILHYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 03:24:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 52132608C1; Wed, 12 Sep 2018 02:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536718926;
        bh=rdu6P+RtGeTxImILfFKjcn4ZQYhNbV03QwlhXS8+3/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ck0Lt2GO1gBdGvWis5zogpGMU2PMHhD5Bkzlg8VNzJjuEwLKuhcidjBwJNTvRVz79
         iZ54zzI/myYf4YxHprKGGGwBJUbkSrCXh248A7qHz9nEnaSsxAHjpirGU4tBZqtOeH
         VOCuBm2BaVyg1VQFN4cQ8MwLaFQKfuR8yhD+34i0=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E9ED607DD;
        Wed, 12 Sep 2018 02:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536718925;
        bh=rdu6P+RtGeTxImILfFKjcn4ZQYhNbV03QwlhXS8+3/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYuhKCAIYnhENCS857LfgFYr5anmGSWQ43wFxJYl9lLD608a6hgk5CYKzD7j0cQns
         2t+9O29TaM7vjZ6VeFlhlUIqQxlzBPTc9khLvlZ8NuPiZPwFfWvQ9HXmk/T1M0C2xz
         Z+VdqkXF2xt8bM803lJtcZinSqFIjNpP78L5FYVQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E9ED607DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 11 Sep 2018 20:22:04 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Raju P L S S S N <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org
Subject: Re: [PATCH v2 3/6] drivers: qcom: rpmh: disallow active requests in
 solver mode
Message-ID: <20180912022204.GI15710@codeaurora.org>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
 <1532685889-31345-4-git-send-email-rplsssn@codeaurora.org>
 <20180911230203.GI22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180911230203.GI22824@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11 2018 at 17:02 -0600, Matthias Kaehlcke wrote:
>Hi Raju/Lina,
>
>On Fri, Jul 27, 2018 at 03:34:46PM +0530, Raju P L S S S N wrote:
>> From: Lina Iyer <ilina@codeaurora.org>
>>
>> Controllers may be in 'solver' state, where they could be in autonomous
>> mode executing low power modes for their hardware and as such are not
>> available for sending active votes. Device driver may notify RPMH API
>> that the controller is in solver mode and when in such mode, disallow
>> requests from platform drivers for state change using the RSC.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> ---
>>  drivers/soc/qcom/rpmh-internal.h |  2 ++
>>  drivers/soc/qcom/rpmh.c          | 59 ++++++++++++++++++++++++++++++++++++++++
>>  include/soc/qcom/rpmh.h          |  5 ++++
>>  3 files changed, 66 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
>> index 4ff43bf..6cd2f78 100644
>> --- a/drivers/soc/qcom/rpmh-internal.h
>> +++ b/drivers/soc/qcom/rpmh-internal.h
>> @@ -72,12 +72,14 @@ struct rpmh_request {
>>   * @cache_lock: synchronize access to the cache data
>>   * @dirty: was the cache updated since flush
>>   * @batch_cache: Cache sleep and wake requests sent as batch
>> + * @in_solver_mode: Controller is busy in solver mode
>>   */
>>  struct rpmh_ctrlr {
>>  	struct list_head cache;
>>  	spinlock_t cache_lock;
>>  	bool dirty;
>>  	struct list_head batch_cache;
>> +	bool in_solver_mode;
>>  };
>>
>>  /**
>> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>> index 2382276..0d276fd 100644
>> --- a/drivers/soc/qcom/rpmh.c
>> +++ b/drivers/soc/qcom/rpmh.c
>> @@ -5,6 +5,7 @@
>>
>>  #include <linux/atomic.h>
>>  #include <linux/bug.h>
>> +#include <linux/delay.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/jiffies.h>
>>  #include <linux/kernel.h>
>> @@ -75,6 +76,50 @@ static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
>>  	return &drv->client;
>>  }
>>
>> +static int check_ctrlr_state(struct rpmh_ctrlr *ctrlr, enum rpmh_state state)
>> +{
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	/* Do not allow setting active votes when in solver mode */
>> +	spin_lock_irqsave(&ctrlr->cache_lock, flags);
>> +	if (ctrlr->in_solver_mode && state == RPMH_ACTIVE_ONLY_STATE)
>> +		ret = -EBUSY;
>> +	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * rpmh_mode_solver_set: Indicate that the RSC controller hardware has
>> + * been configured to be in solver mode
>> + *
>> + * @dev: the device making the request
>> + * @enable: Boolean value indicating if the controller is in solver mode.
>> + *
>> + * When solver mode is enabled, passthru API will not be able to send wake
>> + * votes, just awake and active votes.
>> + */
>> +int rpmh_mode_solver_set(const struct device *dev, bool enable)
>> +{
>> +	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
>> +	unsigned long flags;
>> +
>> +	for (;;) {
>> +		spin_lock_irqsave(&ctrlr->cache_lock, flags);
>> +		if (rpmh_rsc_ctrlr_is_idle(ctrlr_to_drv(ctrlr))) {
>> +			ctrlr->in_solver_mode = enable;
>
>As commented on '[v2,1/6] drivers: qcom: rpmh-rsc: return if the
>controller is idle', this seems potentially
>racy. _is_idle() could report the controller as idle, even though some
>TCSes are in use (after _is_idle() visited them).
>
>Additional locking may be needed or a comment if this situation should
>never happen on a sane system (I don't know enough about RPMh and its
>clients to judge if this is the case).
Hmm.. Forgot that we call from here. May be a lock might be helpful.

-- Lina
