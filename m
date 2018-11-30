Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3388C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7C120660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7C120660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeLAJAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:00:51 -0500
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:33767 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725749AbeLAJAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:00:51 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 01 Dec 2018 08:20:06 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gSqfl-0008It-D6; Sat, 01 Dec 2018 08:50:05 +1100
Date:   Sat, 1 Dec 2018 08:50:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181130215005.GP19305@dastard>
References: <20181129060110.159878-1-sashal@kernel.org>
 <20181129060110.159878-25-sashal@kernel.org>
 <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
 <20181130101441.GA213156@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130101441.GA213156@sasha-vm>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 05:14:41AM -0500, Sasha Levin wrote:
> On Fri, Nov 30, 2018 at 09:22:03AM +0100, Greg KH wrote:
> >On Fri, Nov 30, 2018 at 09:40:19AM +1100, Dave Chinner wrote:
> >>I stopped my tests at 5 billion ops yesterday (i.e. 20 billion ops
> >>aggregate) to focus on testing the copy_file_range() changes, but
> >>Darrick's tests are still ongoing and have passed 40 billion ops in
> >>aggregate over the past few days.
> >>
> >>The reason we are running these so long is that we've seen fsx data
> >>corruption failures after 12+ hours of runtime and hundreds of
> >>millions of ops. Hence the testing for backported fixes will need to
> >>replicate these test runs across multiple configurations for
> >>multiple days before we have any confidence that we've actually
> >>fixed the data corruptions and not introduced any new ones.
> >>
> >>If you pull only a small subset of the fixes, the fsx will still
> >>fail and we have no real way of actually verifying that there have
> >>been no regression introduced by the backport.  IOWs, there's a
> >>/massive/ amount of QA needed for ensuring that these backports work
> >>correctly.
> >>
> >>Right now the XFS developers don't have the time or resources
> >>available to validate stable backports are correct and regression
> >>fre because we are focussed on ensuring the upstream fixes we've
> >>already made (and are still writing) are solid and reliable.
> >
> >Ok, that's fine, so users of XFS should wait until the 4.20 release
> >before relying on it?  :)
> 
> It's getting to the point that with the amount of known issues with XFS
> on LTS kernels it makes sense to mark it as CONFIG_BROKEN.

Really? Where are the bug reports?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
