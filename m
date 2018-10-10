Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5CAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B36720870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LWzZqOPb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f+hb05Ej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B36720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeJJVIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:08:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38464 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeJJVIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:08:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A011B60C81; Wed, 10 Oct 2018 13:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539179194;
        bh=+ADWDA8+00heqYqUb/9q8E280RX/exX+vp9O/wlWzu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LWzZqOPbOkNDuFlNOMtk8FTuzeb6YE70/zG3QtcgBVeZCnmY4wEQlCSJA0omwRS9C
         1l4EzELv9sAjYcGORgeJOxNr6Fm4X+NNu3x8/P6yvRorbEK88vxxY2HgLdbckA2q+9
         ax4D+BOGx8g7UNjrnT58dsOjt77kePtdrQ19hDiY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0C19A60C89;
        Wed, 10 Oct 2018 13:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539179193;
        bh=+ADWDA8+00heqYqUb/9q8E280RX/exX+vp9O/wlWzu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f+hb05EjHcQct7mEMZxlv0BiGrSavNim4FprJVu8RQu8MzcTpWavguV1aBnG2NiAG
         sQxSBgLpyFO7L76FXdWyHpWUrwK988oZD7Vg/vtNIDeZuue/c708J0rYO2cmvYsjwv
         CdZNakmfV9+M0BKAVe+2fbuPpzJfllDoZLjnvCiE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Oct 2018 21:46:33 +0800
From:   cang@codeaurora.org
To:     Doug Anderson <dianders@chromium.org>
Cc:     subhashj@codeaurora.org, Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, venkatg@codeaurora.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] scsi: ufs: make UFS Tx lane1 clock optional
In-Reply-To: <CAD=FV=Xg4UtkJxvVQ2_ky+6-XnM=FvXcnc8xb=uhHeiP5bdFiw@mail.gmail.com>
References: <1538973275-5961-1-git-send-email-cang@codeaurora.org>
 <CAD=FV=Xg4UtkJxvVQ2_ky+6-XnM=FvXcnc8xb=uhHeiP5bdFiw@mail.gmail.com>
Message-ID: <36c6c1a95ff396ac108501f9fe76ef65@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Really thank you for your review.

On 2018-10-10 05:56, Doug Anderson wrote:
> Hi,
> 
> On Sun, Oct 7, 2018 at 9:34 PM Can Guo <cang@codeaurora.org> wrote:
>> 
>> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>> 
>> The UFS Tx lane1 clock could be muxed, hence keep it optional by 
>> ignoring
>> it if it is not provided in device tree.
> 
> Thanks for the updated commit message.  This makes much more sense now! 
>  :-)
> 
> 

Yeah, sorry for making you guys confused. My bad previously.

>> @@ -113,10 +110,10 @@ static void ufs_qcom_disable_lane_clks(struct 
>> ufs_qcom_host *host)
>>         if (!host->is_lane_clks_enabled)
>>                 return;
>> 
>> -       if (host->hba->lanes_per_direction > 1)
>> +       if (host->tx_l1_sync_clk)
>>                 clk_disable_unprepare(host->tx_l1_sync_clk);
> 
> I don't believe you need the "if".  A NULL clock is by definition OK
> to enable / disable which is designed to make optional clocks easier
> to deal with.
> 
> 

You are right, I checked the implemention, clock enable/disable func 
would
bail out if clk is NULL just as your comments.

>>         clk_disable_unprepare(host->tx_l0_sync_clk);
>> -       if (host->hba->lanes_per_direction > 1)
>> +       if (host->rx_l1_sync_clk)
>>                 clk_disable_unprepare(host->rx_l1_sync_clk);
> 
> optional: Technically this part of the patch wasn't actually needed,
> right?  "rx_l1_sync_clk" is not optional so that means that
> "rx_l1_sync_clk" should be non-NULL exactly when lanes_per_direction >
> 1.
> 
> ...but actually I'm fine with keeping this part of your patch for
> symmetry.  Especially since you can leverage the
> clk_disable_unprepare(NULL) to simplify your code.  Please mention in
> your commit message that this is a cleanup and just for symmetry.
> Probably also remove the "if" tests that are guarding
> ufs_qcom_host_clk_enable().
> 
> 

Sure, got it.

>>         clk_disable_unprepare(host->rx_l0_sync_clk);
>> 
>> @@ -141,24 +138,21 @@ static int ufs_qcom_enable_lane_clks(struct 
>> ufs_qcom_host *host)
>>         if (err)
>>                 goto disable_rx_l0;
>> 
>> -       if (host->hba->lanes_per_direction > 1) {
>> +       if (host->rx_l1_sync_clk) {
> 
> Similar: the above change isn't required but I'm OK if you want to
> make this change for symmetry / to cleanup clock handling.  Please
> mention in your commit message.
> 
> 

Sure, shall do so.

>> +       /* The tx lane1 clk could be muxed, hence keep this optional 
>> */
>> +       if (host->tx_l1_sync_clk)
>> +               ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
>> +                                        host->tx_l1_sync_clk);
> 
> If "host->tx_l1_sync_clk" is provided then you should still check the
> return value of ufs_qcom_host_clk_enable(), right?  ...so please leave
> the error path here.
> 
> 

Yeah... you are right.

>> @@ -174,23 +168,33 @@ static int ufs_qcom_init_lane_clks(struct 
>> ufs_qcom_host *host)
>> 
>>         err = ufs_qcom_host_clk_get(dev,
>>                         "rx_lane0_sync_clk", &host->rx_l0_sync_clk);
>> -       if (err)
>> +       if (err) {
>> +               dev_err(dev, "%s: failed to get rx_lane0_sync_clk, err 
>> %d",
>> +                               __func__, err);
> 
> nit: including "__func__" in dev_xxx() calls is discouraged.  The
> "dev_xxx" calls already print the device name and the string within a
> given device driver should be unique enough so __func__ just adds crap
> to the logs.  If you really feel that __func__ adds something for you,
> try posting up a patch to make all "dev_err" functions include
> __func__.  ...but I think you'd probably be rejected.
> 
> suggestion: you'd save a few lines of code and simplify your probe if
> you just passed an "optional" bool to the ufs_qcom_host_clk_get() that
> controlled the printout.
> 
> 

Good idea!

>> -               err = ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
>> -                       &host->tx_l1_sync_clk);
>> +               /* The tx lane1 clk could be muxed, hence keep this 
>> optional */
>> +               ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
>> +                                       &host->tx_l1_sync_clk);
> 
> To be technically correct you should actually check the error value
> returned by ufs_qcom_host_clk_get().  Specifically figure out what the
> error value is when "tx_lane1_sync_clk" isn't specified and check for
> that.
> 
> ...one reason this matters is -EPROBE_DEFER.  In theory devm_clk_get()
> could return -EPROBE_DEFER.  In such a case you'd want to exit the
> probe, not continue on.  It's also just good coding practice to handle
> just the error you want though so that if the function returned some
> other failing case you'd propagate it down instead of eating it.
> 
> If you passed "optional" to ufs_qcom_host_clk_get() as suggested above
> you could put this error-code checking in ufs_qcom_host_clk_get() and
> return 0 from that function if an optional clock was found to not
> exist.
> 
> -Doug

I think I understand it. Thanks a lot for the thorough review and 
suggestions.

-Can Guo
