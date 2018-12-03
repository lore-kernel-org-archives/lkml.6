Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=BUG6152_INVALID_DATE_TZ_ABSURD,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,L_SPAM_TOOL_13,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B7C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D7320851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D7320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mageia.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbeLCVho convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:37:44 -0500
Received: from mx1.yrkesakademin.fi ([85.134.45.194]:49318 "EHLO
        mx1.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCVho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:37:44 -0500
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2018 16:37:42 EST
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
To:     Sasha Levin <sashal@kernel.org>, Dave Chinner <david@fromorbit.com>
CC:     Greg KH <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        <linux-fsdevel@vger.kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
 <20181129060110.159878-25-sashal@kernel.org> <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com> <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com> <20181130101441.GA213156@sasha-vm>
 <20181130215005.GP19305@dastard> <20181201074909.GC213156@sasha-vm>
 <20181202232302.GT19305@dastard> <20181203092241.GC235790@sasha-vm>
From:   Thomas Backlund <tmb@mageia.org>
Message-ID: <2de96c1b-c375-8eed-f934-df5cbcdcd5cc@mageia.org>
Date:   Mon, 3 Dec 2018 23:22:46 +0159
MIME-Version: 1.0
In-Reply-To: <20181203092241.GC235790@sasha-vm>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-WatchGuard-Spam-ID: str=0001.0A0C020E.5C05A227.003D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.194
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den 2018-12-03 kl. 11:22, skrev Sasha Levin:

> 
> This is a case where theory collides with the real world. Yes, our QA is
> lacking, but we don't have the option of not doing the current process.
> If we stop backporting until a future data where our QA problem is
> solved we'll end up with what we had before: users stuck on ancient
> kernels without a way to upgrade.
> 

Sorry, but you seem to be living in a different "real world"...

People stay on "ancient kernels" that "just works" instead of updating
to a newer one that "hopefully/maybe/... works"


> With the current model we're aware that bugs sneak through, but we try
> to deal with it by both improving our QA, and encouraging users to do
> their own extensive QA. If we encourage users to update frequently we
> can keep improving our process and the quality of kernels will keep
> getting better.

And here you want to turn/force users into QA ... good luck with that.

In reality they wont "update frequently", instead they will stop
updating when they have something that works... and start ignoring
updates as they expect something "to break as usual" as they actually
need to get some real work done too...


> 
> We simply can't go back to the "enterprise distro" days.
> 

Maybe so, but we should atleast get back to having "stable" or
"longterm" actually mean something again...

Or what does it say when distros starts thinking about ignoring
(and some already do) stable/longterm trees because there is
_way_ too much questionable changes coming through, even overriding
maintainers to the point where they basically state "we dont care
about monitoring stable trees anymore, as they add whatever they want
anyway"...

And pretending that every fix is important enough to backport,
and saying if you dont take everything you have an "unsecure" kernel
wont help, as reality has shown from time to time that backports
can/will open up a new issue instead for no good reason

Wich for distros starts to mean, switch back to selectively taking fixes
for _known_ security issues are considered way better choice

End result, no-one cares about -stable trees -> no-one uses them -> a
lot of wasted work for nothing...

--
Thomas


