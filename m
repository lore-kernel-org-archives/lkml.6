Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C657C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F69120866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HNBPXw9j";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HNBPXw9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F69120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeILNbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:31:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53314 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeILNbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:31:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AFCBD60997; Wed, 12 Sep 2018 08:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536740866;
        bh=6trXrBsBnm3F620cCr2ocw2hXd+YCJSrpeKawB8zXdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNBPXw9jbEWUZASNhqD90N4MahhKF+O94N2QjIjBp54dZS7KwfbzkfIv/stkmV/cn
         nqFEqzhPGINmMTrOfJ7xt5pBjEQZu2CuWnVYO8xnO5qzLHqdFKVBzmlyxO/hLeX+Qi
         1CZM+DhWNXTjhOvGOIWUZ3ziHC9R+gIXOtiRa1Q4=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28D1260594;
        Wed, 12 Sep 2018 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536740866;
        bh=6trXrBsBnm3F620cCr2ocw2hXd+YCJSrpeKawB8zXdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNBPXw9jbEWUZASNhqD90N4MahhKF+O94N2QjIjBp54dZS7KwfbzkfIv/stkmV/cn
         nqFEqzhPGINmMTrOfJ7xt5pBjEQZu2CuWnVYO8xnO5qzLHqdFKVBzmlyxO/hLeX+Qi
         1CZM+DhWNXTjhOvGOIWUZ3ziHC9R+gIXOtiRa1Q4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28D1260594
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Wed, 12 Sep 2018 13:57:40 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add new idle interval timing for
 discard and gc paths
Message-ID: <20180912082740.GB22939@codeaurora.org>
References: <1536551252-24256-1-git-send-email-stummala@codeaurora.org>
 <5d74d46b-8141-f048-9c0a-459c82b2c449@kernel.org>
 <20180911220958.GC55456@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911220958.GC55456@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 03:09:58PM -0700, Jaegeuk Kim wrote:
> On 09/11, Chao Yu wrote:
> > On 2018/9/10 11:47, Sahitya Tummala wrote:
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index abf9256..6070681 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -1093,6 +1093,8 @@ enum {
> > >  enum {
> > >  	CP_TIME,
> > >  	REQ_TIME,
> > > +	DISCARD_TIME,
> > > +	GC_TIME,
> > >  	MAX_TIME,
> > >  };
> > >  
> > > @@ -1347,14 +1349,35 @@ static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
> > >  	sbi->last_time[type] = jiffies;
> > >  }
> > >  
> > > -static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
> > > +static inline bool f2fs_time_over_cp(struct f2fs_sb_info *sbi)
> 
> I don't see why we need this separately.

Yes, not really required. I will update it.

> 
> > > +{
> > > +	unsigned long interval = sbi->interval_time[CP_TIME] * HZ;
> > > +
> > > +	return time_after(jiffies, sbi->last_time[CP_TIME] + interval);
> > > +}
> > > +
> > > +static inline bool f2fs_time_over_req(struct f2fs_sb_info *sbi, int type)
> > > +{
> > > +	unsigned long interval = sbi->interval_time[type] * HZ;
> > > +
> > > +	return time_after(jiffies, sbi->last_time[REQ_TIME] + interval);
> > > +}
> > > +
> > > +static inline unsigned int f2fs_get_wait_time(struct f2fs_sb_info *sbi,
> > > +						int type)
> 
> f2fs_time_to_wait()?

Sure.

> > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > index 5c8d004..c0bafea 100644
> > > --- a/fs/f2fs/gc.c
> > > +++ b/fs/f2fs/gc.c
> > > @@ -83,8 +83,10 @@ static int gc_thread_func(void *data)
> > >  		if (!mutex_trylock(&sbi->gc_mutex))
> > >  			goto next;
> > >  
> > > -		if (!is_idle(sbi)) {
> > > -			increase_sleep_time(gc_th, &wait_ms);
> > > +		if (!is_idle(sbi, GC_TIME)) {
> > > +			wait_ms = f2fs_get_wait_time(sbi, GC_TIME);
> > 
> > It seems this patch changes the method of increasing wait_ms here, if device is
> > busy, we may wake up GC thread earlier than before, not sure we should do this.
> > 
> > To Jaegeuk, how do you think of this?
> 
> Yes, please let us discuss this in another patch.

Sure, I will submit this in another patch for discussion.

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
