Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88461C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D37B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nVitqS0E";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nVitqS0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D37B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936092AbeFRTGm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:06:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44030 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936042AbeFRTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:06:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A481B607EB; Mon, 18 Jun 2018 19:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529348799;
        bh=CY1NtlJ2zcM5iw2pEQNmZiSpcZhtKFrGyjHsX1Bh2CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVitqS0E/4jxE6CKuHQICks9uvV81CwO3XcZkeydTdegh+XXV5kF7FnE6Ix1BcqH3
         93OhVCOQoE1kLUB/DDNXXiTtEj/rgwHZNAVgYEcTHUa9yqKDCQD66obJtQpUL0hg6W
         Xsw6Ut/9hjmrvfXzj0a8nOUjzHbmCXP2mCBQuQrU=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CFFC860227;
        Mon, 18 Jun 2018 19:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529348799;
        bh=CY1NtlJ2zcM5iw2pEQNmZiSpcZhtKFrGyjHsX1Bh2CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVitqS0E/4jxE6CKuHQICks9uvV81CwO3XcZkeydTdegh+XXV5kF7FnE6Ix1BcqH3
         93OhVCOQoE1kLUB/DDNXXiTtEj/rgwHZNAVgYEcTHUa9yqKDCQD66obJtQpUL0hg6W
         Xsw6Ut/9hjmrvfXzj0a8nOUjzHbmCXP2mCBQuQrU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFFC860227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 18 Jun 2018 13:06:37 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Raju P L S S S N <rplsssn@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v11 04/10] drivers: qcom: rpmh: add RPMH helper functions
Message-ID: <20180618190637.GG21724@codeaurora.org>
References: <1529329040-2606-1-git-send-email-rplsssn@codeaurora.org>
 <1529329040-2606-5-git-send-email-rplsssn@codeaurora.org>
 <20180618163945.GE21724@codeaurora.org>
 <CAD=FV=W_tKb2n2x9AY4T_17Q_KJcu9wsfFv4vio08W76t0d00A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=W_tKb2n2x9AY4T_17Q_KJcu9wsfFv4vio08W76t0d00A@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18 2018 at 12:33 -0600, Doug Anderson wrote:
>Lina,
>
>On Mon, Jun 18, 2018 at 9:39 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>>> +/**
>>>  * struct rsc_drv: the Direct Resource Voter (DRV) of the
>>>  * Resource State Coordinator controller (RSC)
>>>  *
>>> @@ -52,6 +78,7 @@ struct tcs_group {
>>>  * @tcs:        TCS groups
>>>  * @tcs_in_use: s/w state of the TCS
>>>  * @lock:       synchronize state of the controller
>>> + * @ctrl:       controller to handle cases like batch requests
>>
>> This is not only for batch requests.
>> This is handle to the DRV's client. @client might be a better name than
>> @ctrlr.
>
>The name "ctrlr" also matches the name of the structure.  Are you
>suggesting also renaming "struct rpmh_ctrlr" to "struct rpmh_client",
>or you think they should be different names?
>
Just the name of the variable. I was just a nice to have. I wouldn't
block for this though.

I also got a couple Bot reported issues on this and the previous
revision that I have sent to Raju. He is planning to the post the v12
tomorrow his time after fixing them. If you can wait until then, I would
recommend picking up the v12 instead of this.

Thanks,
Lina

>I'm advocating that we should land this patch series to unblock
>everything.  Hopefully you agree that's OK and if we want to change
>the name of this we can do it in a future patch.  Let me know if you
>disagree.  ...if others agree that the series should land and you
>really want the name change, I'm happy to post up a version of the
>series with the fix to help move things along...
>
>
>-Doug
