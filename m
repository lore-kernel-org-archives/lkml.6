Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D111CC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9342B2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9342B2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeJBFZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:25:35 -0400
Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:10454 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbeJBFZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:25:35 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail01.adl2.internode.on.net with ESMTP; 02 Oct 2018 08:15:29 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1g76wS-0006gk-Cq; Tue, 02 Oct 2018 08:45:28 +1000
Date:   Tue, 2 Oct 2018 08:45:28 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     James Morris <jmorris@namei.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        TongZhang <ztong@vt.edu>, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
Subject: Re: Leaking Path in XFS's ioctl interface(missing LSM check)
Message-ID: <20181001224528.GI18567@dastard>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
 <20180926013329.GD31060@dastard>
 <20180926192426.472360ea@alans-desktop>
 <20180927013812.GF31060@dastard>
 <20180930151652.6975610c@alans-desktop>
 <20181001002521.GM31060@dastard>
 <20181001160442.47c798bc@alans-desktop>
 <20181001154459.GB5872@magnolia>
 <alpine.LRH.2.21.1810020608090.14406@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1810020608090.14406@namei.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 06:08:16AM +1000, James Morris wrote:
> On Mon, 1 Oct 2018, Darrick J. Wong wrote:
> 
> > If we /did/ replace CAP_SYS_ADMIN checking with a pile of LSM hooks,
> 
> Not sure we'd need a pile of hooks, what about just "read" and "write" 
> storage admin?
> 
> Or even two new capabilities along these lines, which we convert existing 
> CAP_SYS_ADMIN etc. to?

So instead of having hundreds of management ioctls under
CAP_SYS_ADMIN, we'd now have hundreds of non-storage ioctls under
CAP_SYS_ADMIN and hundreds of storage ioctls under
CAP_SYS_STORAGE_ADMIN?

Maybe I'm missing something, but I don't see how that improves the
situation w.r.t. locked down LSM configurations?

Cheers,

Dave.


-- 
Dave Chinner
david@fromorbit.com
