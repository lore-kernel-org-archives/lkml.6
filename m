Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34C1C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796D220839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lBtv3np9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O2nQRM9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796D220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeILHWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 03:22:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54390 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeILHWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 03:22:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3AAA160912; Wed, 12 Sep 2018 02:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536718804;
        bh=JDHtearcuCTxjqbOVoeXcpTUwd5A8cSLPtqqDHt7EpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBtv3np9NXwfT3xV5b08/H2YljiSxkOx2Jd0Qd0ndHNhHfhtLL8LbzWOGLlek+7Tr
         4ghZfzG5298chy9VkwpNynwjB02ggIb/Ej8v5JrZuJjWwhHNlokgPmreQ4JSrhWt+l
         7A0db28ScF8BRpElDzSV3XmE3N8uAcT/Nhuqtu/0=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F3FD607DD;
        Wed, 12 Sep 2018 02:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536718803;
        bh=JDHtearcuCTxjqbOVoeXcpTUwd5A8cSLPtqqDHt7EpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2nQRM9cYBTUkj3GdU2GK5Q86vmTzGY0FhwZK4kFAMB9MvlgzV2dP6vJTPPsdnk5T
         thxtKnRkF2Y6Qt/uqpWH26IlZiUM7JyWjYB89ckAeVo1M+BIGwrWmvykeGwkejUDSj
         OOxpeRRlp8ft5UfOa1jwxQcxG6er/5fVmNtRqDxc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F3FD607DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 11 Sep 2018 20:20:02 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Raju P L S S S N <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org
Subject: Re: [PATCH v2 1/6] drivers: qcom: rpmh-rsc: return if the controller
 is idle
Message-ID: <20180912022002.GH15710@codeaurora.org>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
 <1532685889-31345-2-git-send-email-rplsssn@codeaurora.org>
 <20180911223910.GH22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180911223910.GH22824@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11 2018 at 16:39 -0600, Matthias Kaehlcke wrote:
>Hi Raju/Lina,
>
>On Fri, Jul 27, 2018 at 03:34:44PM +0530, Raju P L S S S N wrote:
>> From: Lina Iyer <ilina@codeaurora.org>
>>
>> Allow the controller status be queried. The controller is busy if it is
>> actively processing request.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> ---
>> Changes in v2:
>>      - Remove unnecessary EXPORT_SYMBOL
>> ---
>>  drivers/soc/qcom/rpmh-internal.h |  1 +
>>  drivers/soc/qcom/rpmh-rsc.c      | 20 ++++++++++++++++++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
>> index a7bbbb6..4ff43bf 100644
>> --- a/drivers/soc/qcom/rpmh-internal.h
>> +++ b/drivers/soc/qcom/rpmh-internal.h
>> @@ -108,6 +108,7 @@ struct rsc_drv {
>>  int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
>>  			     const struct tcs_request *msg);
>>  int rpmh_rsc_invalidate(struct rsc_drv *drv);
>> +bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv);
>>
>>  void rpmh_tx_done(const struct tcs_request *msg, int r);
>>
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index 33fe9f9..42d0041 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -496,6 +496,26 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
>>  }
>>
>>  /**
>> + *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
>> + *
>> + *  @drv: The controller
>> + *
>> + *  Returns true if the TCSes are engaged in handling requests.
>> + */
>> +bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
>> +{
>> +	int m;
>> +	struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
>> +
>> +	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
>> +		if (!tcs_is_free(drv, m))
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>
>This looks racy, tcs_write() could be running simultaneously and use
>TCSes that were seen as free by _is_idle(). This could be fixed by
>holding tcs->lock (assuming this doesn't cause lock ordering problems).
>However even with this tcs_write() could run right after releasing the
>lock, using TCSes and the caller of _is_idle() would consider the
>controller to be idle.

We could run this without the lock, since we are only reading a status.
Generally, this function is called from the idle code of the last CPU
and no CPU or active TCS request should be in progress, but if it were,
then this function would let the caller know we are not ready to do
idle. If there were no requests that were running at that time we read
the registers, we would not be making one after, since we are already
in the idle code and no requests are made there.

I understand, how it might appear racy, the context of the callling
function helps resolve that.

-- Lina

