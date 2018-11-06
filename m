Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89DFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6542086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bfUOFe76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6542086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbeKGIcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:32:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeKGIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 03:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HBnt7U4EYTj0dSkVCDVwFtgjEbGhHxSp9mEMR2ueqP0=; b=bfUOFe76OwJUiGnugE7rqYjZn
        TqKFXAzyQbBNtDgtNUWGdQXh3v3g87Xi8eSaUsWaQQMx1eWTi3nUhUbrIlYrNwoHo+ChOlQWNlikp
        LPNkmp4GqI8bqE+gNdZ87wU15C14qAxMJSw+KcwfG1SuP2x1Y0ra0UhwcnzC0JaAGswDFe/xJoYzC
        yLQIwj82eAYQ5KhwpCfmDvsph2z2siM4zkEs97mNYIdVY/r0Wv4AtprGgNkd0hT5I1MFSqq1RIgVR
        lBcsbKOXzMu9kIkp7+7seRhc/v2leJW70BVyPAf4XH+KiU4RqGpoOsA15kEP0G2c6lesmTDsHh80Z
        UhIUU9IDQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKAOd-0003dH-Tk; Tue, 06 Nov 2018 23:04:31 +0000
Date:   Tue, 6 Nov 2018 15:04:30 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.20-rc1
Message-ID: <20181106230430.GA10359@fedora.eng.vmware.com>
References: <CAHk-=whDiwASMgw8Q7TNA2MJhf3s=ouK4+_3ioqmobs-yagnkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whDiwASMgw8Q7TNA2MJhf3s=ouK4+_3ioqmobs-yagnkQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2018 at 04:12:45PM -0800, Linus Torvalds wrote:

> 
> Because yes, the merge window is two weeks, but it's two weeks partly
> exactly _because_ people (not just me) sometimes need extra time to
> resolve any possible issues, not because regular everyday pull
> requests should spread out over the whole two weeks. The development
> for things meant for the next release should have been done by the
> time the merge window opens.
> 
> Anyway, let's see. Maybe it won't be needed. It hasn't become a
> problem, it just was starting to feel a bit tight there.

I'm curious what others find to be the cause of hitting the second half
of the merge window. For my part, I have traditionally monitored the
tail end of the RC period waiting for the version tag to land. Other
times, like this time, work and travel get hectic, and I realize later
than I should that it was time to send in the PR.

I imagine many of us have just written notification scripts for version
tags, or emails from you matching certain subject patterns - but for my
part, a more predictable end of the RC period and/or an explicit email
to maintainers listed in the MAINTAINER file would be helpful. Would you
consider adding a step to your git tag process to scan the MAINTAINERS
file and send us a "Ready your PRs!" email with a note about preferring
to get these during the first week wherever possible? This seems like it
could be easily automated, easily filtered by those that might not want
it, and reduces the number of times you have to explain your preference
as new maintainers come and go.

-- 
Darren Hart
VMware Open Source Technology Center
