Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC2CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C1F20818
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfBDVxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:53:36 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:62225 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbfBDVxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:53:36 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 05 Feb 2019 08:23:33 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gqmBI-0000Oz-UL; Tue, 05 Feb 2019 08:53:33 +1100
Date:   Tue, 5 Feb 2019 08:53:32 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: allow disabling xfs tracepoints via Kconfig
Message-ID: <20190204215332.GB14116@dastard>
References: <20190204212035.9919-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204212035.9919-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:20:35PM +0100, Rasmus Villemoes wrote:
> linux/tracepoints.h allows individual subsystems to disable their
> tracepoints. Add such a knob for xfs. Disabling XFS_TRACEPOINTS
> reduces the resident size of xfs.ko by about a third, or ~350 KiB.

Ok, now we can't debug typical problems on live production systems
if tracepoints are turned off on the user/distro kernels.  So under
what circumstances would we ever want to turn off tracepoints on
XFS?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
