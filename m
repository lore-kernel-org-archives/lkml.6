Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDD5C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E39E20869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfBBKpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:45:38 -0500
Received: from colin.muc.de ([193.149.48.1]:41134 "HELO mail.muc.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
        id S1726540AbfBBKpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:45:38 -0500
Received: (qmail 85520 invoked by uid 3782); 2 Feb 2019 10:45:36 -0000
Received: from acm.muc.de (p4FE15063.dip0.t-ipconnect.de [79.225.80.99]) by
        colin.muc.de (tmda-ofmipd) with ESMTP;
        Sat, 02 Feb 2019 11:45:33 +0100
Received: (qmail 1124 invoked by uid 1000); 2 Feb 2019 10:44:04 -0000
Date:   Sat, 2 Feb 2019 10:44:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, 34235@debbugs.gnu.org,
        Eli Zaretskii <eliz@gnu.org>,
        Alex Branham <alex.branham@gmail.com>,
        Paul Eggert <eggert@cs.ucla.edu>
Subject: Re: 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94 (posix-timers: Fix
        division by zero bug). Problems with glibc.
Message-ID: <20190202104404.GA1067@ACM>
References: <20190201214700.GA4950@ACM>
        <alpine.DEB.2.21.1902012301310.8200@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902012301310.8200@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
From:   Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Thomas.

Thanks for such a rapid reply!

On Fri, Feb 01, 2019 at 23:04:48 +0100, Thomas Gleixner wrote:
> Hello Alan,

> On Fri, 1 Feb 2019, Alan Mackenzie wrote:
> > 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94
> > posix-timers: Fix division by zero bug
> > Committed: 2018-12-17 17:35:45 +0100

> > With this patch in place I am seeing problems with glibc's function
> > timer_create.  I am an Emacs maintainer, and saw these problems whilst
> > investigating Emacs bug #34235 "27.0.50; lisp profiler does not work".

> > Emacs's profiler fails in kernel 4.19.13, but works in a version of
> > 4.19.13 with the patch reversed, otherwise unchanged.  My current version
> > of glibc is 2.27-r6 (I think the "-r6" comes from Gentoo, my distro).

> Please upgrade to 4.19.19. The issue should be fixed there with the
> backported variant of

>    93ad0fc088c5 ("posix-cpu-timers: Unbreak timer rearming")

> Commit 21c0d1621b8d4b in 4.19.19

I've just built and installed Linux 4.19.19, and it does indeed solve
the Emacs profiler bug, #34235.  :-)

I see that the patch has been installed in 4.20.6, 4.19.19, and 4.14.97.
Are there any plans to install it into 4.9.x, the other live long term
support branch?  The reason I ask is to make an entry into Emacs's
PROBLEMS file, telling users and distributions which kernel versions to
upgrade to.

> Thanks,

> 	tglx

-- 
Alan Mackenzie (Nuremberg, Germany).
