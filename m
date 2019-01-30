Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC440C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E2F20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548876748;
	bh=aLq7oWXUe7idudxmOpD7HzdA31Y2BNVqSUUduhs3tOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qGOqu8qSo+bl8X1rGlbLqM//XCcbluWRTtbr/nwoRs3KlwsXuTwkkOPO7K4d7F+8N
	 QjRkMzhntWQNR58et3AQl28Yf45pZOLZiry3AAtqsHJSD21e7XXwyBkuJuO4wj/xMZ
	 CZCfXVpePkiyh2InHHtpkhJEDcUTwM8s7wVmg4VI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbfA3Tc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:32:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387587AbfA3Tc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:32:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94C5B2087F;
        Wed, 30 Jan 2019 19:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548876746;
        bh=aLq7oWXUe7idudxmOpD7HzdA31Y2BNVqSUUduhs3tOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jfVjnCYRVvGZLC5DV7rcFZ4u8v1OVsRY2UHmFBuvfKs/VDdGxrd68+fqlGAhDWxCB
         be5nQm0G9a4KlwDYAKmgAMF/r4vwoAL/gaZKUzHM3GYcqvwLZ9ifkBnNeIqgouBrWY
         KEtRsp3okKC460ZK+2ou/8qioV3S3t/His7twV3I=
Date:   Wed, 30 Jan 2019 20:32:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, ltp@lists.linux.it,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        chrubis <chrubis@suse.cz>
Subject: Re: [PATCH 4.14 00/68] 4.14.97-stable review
Message-ID: <20190130193223.GA20667@kroah.com>
References: <20190129113131.751891514@linuxfoundation.org>
 <CA+G9fYvh6axRDLWpR3_ozw46JUknsYgEjvYOZfQEUbhroHPVTA@mail.gmail.com>
 <CAOQ4uxiZ2ZPfcVNSX64ZD_JqQuBwz45_WAoNjpYEhfvTuHgZHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiZ2ZPfcVNSX64ZD_JqQuBwz45_WAoNjpYEhfvTuHgZHQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 08:49:34PM +0200, Amir Goldstein wrote:
> On Wed, Jan 30, 2019 at 2:55 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > On Tue, 29 Jan 2019 at 17:19, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 4.14.97 release.
> > > There are 68 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Thu Jan 31 11:31:10 UTC 2019.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.97-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Results from Linaro’s test farm.
> > No regressions on arm64, arm, x86_64, and i386.
> >
> > NOTE:
> > -----
> > LTP upgrade to 20190115 and fanotify01, fanotify09 and readahead02 tests failed
> >
> > fanotify01 failed on hikey and dragonboard410c arm64 boards all kernel versions
> > fanotify01.c:256: FAIL: got event: mask=2 (expected 20) pid=2756 fd=9
> > https://bugs.linaro.org/show_bug.cgi?id=4261
> >
> > fanotify09 failed on arm64 devices running 4.14 version kernel
> > fanotify09.c:202: FAIL: first group got more than 2 events (72 > 48)
> > https://bugs.linaro.org/show_bug.cgi?id=4271
> >
> 
> fanotify09 was added a new regression test case for commit
>   b469e7e47c8a: fanotify: fix handling of events on child sub-directory
> 
> That commit was backported to v4.19. As I wrote in "backport hint", the bug
> exists in older kernels, but fix does not apply cleanly to older kernels.

If someone were to provide a tested backport to 4.14 and older, I'll be
glad to queue it up (hint hint hint...)

thanks,

greg k-h
