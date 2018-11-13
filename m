Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8400EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478EF22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="kL6yimb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478EF22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbeKMLuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:50:12 -0500
Received: from imap.thunk.org ([74.207.234.97]:48572 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbeKMLuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XIn5Dgny0xYzOOoOoJt1WdTT0OEV52cEf6stnqD+ET4=; b=kL6yimb56sf2jPJN3wnmtIw+1w
        PBUN2tCSiHTijSFrGS58+SvUKfbCiuCGM1ZqaS5LMjiMS+N5XvdQqOrm5L+ryjf2jAV8zkJyXsD23
        nAD10DPouRxXOnRLJlqZPc4GS487golQhbmtuVgDDwc5xSXsYS65t+mmxxAqfzX8FYJY=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gMNu7-00059z-Oq; Tue, 13 Nov 2018 01:54:11 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 652537A47B7; Mon, 12 Nov 2018 20:54:10 -0500 (EST)
Date:   Mon, 12 Nov 2018 20:54:10 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Joe Perches <joe@perches.com>, Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfs: Remove noinline from #define STATIC
Message-ID: <20181113015410.GB30750@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Joe Perches <joe@perches.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <7302f4a13c1cbf62b07f636878ce25fcca84b6c4.camel@perches.com>
 <6420cf91-89c8-a876-7a0d-25ab8ba428b8@sandeen.net>
 <20181112214515.GN19305@dastard>
 <bd3806ccc911989c7ef1fed9e8d26a4a5ad347a9.camel@perches.com>
 <20181113011804.GP19305@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113011804.GP19305@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 12:18:05PM +1100, Dave Chinner wrote:
> I'm not interested in making code fast if distro support engineers
> can't debug problems on user systems easily. Optimising for
> performance over debuggability is a horrible trade off for us to
> make because it means users and distros end up much more reliant on
> single points of expertise for debugging problems. And that means
> the majority of the load of problem triage falls directly on very
> limited resources - the core XFS development team. A little bit of
> thought about how to make code easier to triage and debug goes a
> long, long way....

So at least in my experience, if the kernels are compiled with
CONFIG_DEBUG_INFO and/or CONFIG_DEBUG_INFO_REDUCED,
scripts/decode_stracktrace.sh seems to do a very nice job with inlined
functions.  Now, ext4 generally only has about 3 or 4 nested inlines,
and so I don't know how it works with 20 or 30 nested inlined
functions, so perhaps this is not applicable for XFS.

But it perhaps toolchain technology has advanced since the Irix days
such that it's no longer as necessary to force the non-inlining of
functions for easing debugging?

					- Ted




