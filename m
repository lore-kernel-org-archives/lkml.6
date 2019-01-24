Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CEAC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DE421855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548317592;
	bh=zIFyEVk+OOLJ3T81K+kmIntCYfEmg5hzBFCaTuOdNks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BSKQdi5yYQfCy3/5mj4XMINwnwyLyziCAO0zqQfeWzhnlwqjMiCL2Ua0eeFltFRNz
	 WJxzHdvvJoko6A9EyRfu76QGn4DyVJ2l1Ea4+JfAb+sf2COpBg/Qcj9pPhGwBZd8k9
	 qJRP0frT6vyU5mbCaLtL0g/8RyzCvzySRnz/qhSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfAXINK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:13:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbfAXINJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:13:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD04421855;
        Thu, 24 Jan 2019 08:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548317589;
        bh=zIFyEVk+OOLJ3T81K+kmIntCYfEmg5hzBFCaTuOdNks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3rjkytqa8PQLJdm1QPBvdG5jxNsrKQu/SCa7595/0FffzGampxpYVuCALP5tqPp9
         rIkFBtk2UlbQvoBytxMnC7BkAe7IiUdalarkRA3woRsebl7zS7YXr9rpcqxvjakzjk
         NDJihY8T+AWZ6Gc8TWsiuDDU+b5tYWTBspkNJkDc=
Date:   Thu, 24 Jan 2019 09:13:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Sasha Levin <sashal@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] mm, oom: fix use-after-free in oom_kill_process
Message-ID: <20190124081306.GA1344@kroah.com>
References: <20190123225747.8715120856@mail.kernel.org>
 <CALvZod5h7fSoZTA+3bDTn93JuFgY=SUGEq=gpDYE8rdSfuNcPQ@mail.gmail.com>
 <201901232335.x0NNZRWw042364@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201901232335.x0NNZRWw042364@www262.sakura.ne.jp>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 08:35:27AM +0900, Tetsuo Handa wrote:
> Shakeel Butt wrote:
> > > How should we proceed with this patch?
> > >
> > 
> > We do want to backport this patch to stable kernels. However shouldn't
> > we wait for this patch to be applied to Linus's tree first.

Yes we will.

> But since Andrew Morton seems to be offline since Jan 11, we don't know
> when this patch will arrive at Linus's tree.

That's fine, we can wait :)

greg k-h
