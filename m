Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679A2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1F5213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT0ZtBAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1F5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeK3EQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbeK3EQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:16:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4352C20863;
        Thu, 29 Nov 2018 17:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543511440;
        bh=AHkNUQHUxUlNVBHIjsQ/dWtd4bTT7XdZHSbRLdBX9Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sT0ZtBAxLO8EJKfWp8roacbyh7DWsUjdjsiNMt8Ve7H1lcBoLVriDBagAFcgz94id
         x2o6vrpZ+kpLum5IueNRz3U6kc6HHqNp5cwr5tqkaRUrcoVnxvB9mNc1sCU807l+OC
         XxQEesVp0P6EAqOVhANcIfESJl7ySeTvJHuYo7Do=
Date:   Thu, 29 Nov 2018 18:10:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tigran Aivazian <aivazian.tigran@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+71c6b5d68e91149fc8a4@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 4.19 033/110] bfs: add sanity check at bfs_fill_super()
Message-ID: <20181129171038.GA4651@kroah.com>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135922.602882966@linuxfoundation.org>
 <CAK+_RLmVyVzL3G6++xOxfyEqEHL=bfZZx_Yj-TFNf5a7_oUoXw@mail.gmail.com>
 <20181129160722.GA31919@kroah.com>
 <CAK+_RLnbpu+nYsr8sVpHBVUcATDbqQoeH=+tu=tK1EKTHk6L9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK+_RLnbpu+nYsr8sVpHBVUcATDbqQoeH=+tu=tK1EKTHk6L9A@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 04:55:20PM +0000, Tigran Aivazian wrote:
> On Thu, 29 Nov 2018 at 16:07, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Thu, Nov 29, 2018 at 03:23:00PM +0000, Tigran Aivazian wrote:
> > > Yes, of course I object to it.
> > I can not apply a patch to the stable trees that are not in Linus's tree
> > first.  So there's nothing I can do here with this.
> 
> Ok, we can wait until my patch propagates into Linus' tree, but I
> would have thought it would be a waste of your time to apply a patch
> which is waiting to be inevitably superseded by a different one.

Your patch has to apply on top of the existing one, so there's not an
issue here.

And might as well fix it now, as I can never count on a "future" patch
getting merged.

> I can
> see there are 238 PRs at Linus' tree on github and I am very glad that
> I looked into one of them --- it contained a long comment explaining
> that I should NOT do what I was just about to do, i.e. make a PR
> against Linus' tree! :)

We do not do kernel development on github :)

thanks,

greg k-h
