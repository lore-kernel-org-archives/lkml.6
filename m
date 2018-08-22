Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE94AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780CC214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780CC214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeHVJLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 05:11:18 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:55557 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726696AbeHVJLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 05:11:18 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 22 Aug 2018 14:47:48 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 22 Aug 2018 14:47:48 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Wed, 22 Aug 2018 14:47:31 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH 1/2] workqueue: skip lockdep wq dependency in
 cancel_work_sync()
Message-ID: <20180822054731.GB2414@X58A-UD3R>
References: <20180821120317.4115-1-johannes@sipsolutions.net>
 <20180821120317.4115-2-johannes@sipsolutions.net>
 <20180821160814.GP3978217@devbig004.ftw2.facebook.com>
 <1534871894.25523.34.camel@sipsolutions.net>
 <20180821172711.GR3978217@devbig004.ftw2.facebook.com>
 <1534872621.25523.39.camel@sipsolutions.net>
 <20180821175550.GS3978217@devbig004.ftw2.facebook.com>
 <1534879241.25523.44.camel@sipsolutions.net>
 <20180822024535.GA2414@X58A-UD3R>
 <1534910543.25523.50.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534910543.25523.50.camel@sipsolutions.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 06:02:23AM +0200, Johannes Berg wrote:
> On Wed, 2018-08-22 at 11:45 +0900, Byungchul Park wrote:
> 
> > That should've been adjusted as well when Ingo reverted Cross-release.
> 
> I can't really say.

What do you mean?

> > It would be much easier to add each pair, acquire/release, before
> > wait_for_completion() in both flush_workqueue() and flush_work() than
> > reverting the whole commit.
> 
> The commit doesn't do much more than this though.

That also has named of lockdep_map for wq/work in a better way.

> > What's lacking is only lockdep annotations for wait_for_completion().
> 
> No, I disagree. Like I said before, we need the lockdep annotations on

You seem to be confused. I was talking about wait_for_completion() in
both flush_workqueue() and flush_work(). Without
the wait_for_completion()s, nothing matters wrt what you are concerning.

> the WQ even when we don't actually create/use the completion, so we can
> catch issues even when they don't actually happen.

This is obviously true.

Byungchul

> 
> johannes
