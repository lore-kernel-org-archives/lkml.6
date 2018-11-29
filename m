Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BC1C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E882146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E882146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeK3JvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:51:00 -0500
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:34813 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726425AbeK3Ju7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:50:59 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 30 Nov 2018 09:13:53 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gSV2G-0006kf-56; Fri, 30 Nov 2018 09:43:52 +1100
Date:   Fri, 30 Nov 2018 09:43:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     sashal@kernel.org, stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Luis R. Chamberlain" <mcgrof@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 52/68] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181129224352.GN19305@dastard>
References: <20181129055559.159228-1-sashal@kernel.org>
 <20181129055559.159228-52-sashal@kernel.org>
 <20181129121922.GL19305@dastard>
 <CAOQ4uxha4-DhcHQwvWbWuh5QXcDKYJ_b7HVGtT23D_gtkqkQ0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxha4-DhcHQwvWbWuh5QXcDKYJ_b7HVGtT23D_gtkqkQ0A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:36:50PM +0200, Amir Goldstein wrote:
> > Same again - what's the test plan for these cherry-picked data
> > corruption fixes?
> >
> 
> Dave,
> 
> Just to check if we are on the same page, if this was the test plan:
> https://www.spinics.net/lists/linux-xfs/msg20639.html
> 
> Would "no regressions from baseline" have been sufficient to validate
> those specific patches are solid for stable?

No, not in this case, because fsx in fstests only does 100k ops at
most - it's a smoke test. This isn't sufficient to regression test
fixes that, in some cases, took hundreds of millions of fsx ops to
expose.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
