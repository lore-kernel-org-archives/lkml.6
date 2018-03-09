Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-955397-1520613360-3-6275772001675727813
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520613360; b=XLDrr465tu+ps1K6wj17N19FMvHqQS01+9eJaL7ReFf7u+I
    wmmpvaoZKOg197hyku/a66smRKD2hMPph2pVBy8Uzj+lFGMaFvbEfqfVyk43rehP
    HZzcpsKGywyb/WkAgYxV/Jud8WHU2XYT5pB0OveLDFFhfbKUPSjIXI1PgFTSxXz0
    wE45g47F3aA5Zfjh4KrMbsr43pCRJl4gpUjSjOWvTQbqP/ACMuEnO65uay6YCgdd
    oqcMTbsN7dZV/s/XRuLbRU2Akh9HlwpkuC4s2cUM527dY6/zJLG+Rv+wF2yeywhY
    lFcN+A68T0Taq2wc0sIzSzzLs/a2Vei9uYhWaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520613360; bh=EmlplyfM8URZMZa6YEmMmm3GV2
    0y+WOj0NWDM/suQUE=; b=Zy/+cZs3HDcsVPaek9kacobNLpIjpyLYIIymv+MH2H
    w6pMHM4KOgUwYfQkY8ldcjHwvQ4BP7gwnlLBSveax4YYpW8j0k64Bx2MD/fdVcFM
    PmW5piOTvE43a7KS8gA1MujeV+E8qzrGT1DAN5wdX1bivzKreTejcHoqc0az+c8Y
    xh10gQFDPQksRC/dNT0j95+B23L1xaBNkEKF0FDkLrElGN8k4z2mBZ63L3DL84JZ
    UiSCCUMKXx4+jPL/1c1Rglyco+eX4XREiTDvfZYkzNEMz/r8l3WWRIt1XSBIp/hr
    kkRsGySb6HXkFPWrLjVplXncyNMork4HC/D3NAimehqA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeCIQf4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 11:35:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:43988 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeCIQf4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Mar 2018 11:35:56 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,446,1515484800";
   d="scan'208";a="210270627"
Date: Fri, 9 Mar 2018 09:35:54 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] loop: Fix lost writes caused by missing flag
Message-ID: <20180309163554.GA485@linux.intel.com>
References: <20180212230558.5546-1-ross.zwisler@linux.intel.com>
 <20180309002048.GA22835@linux.intel.com>
 <81204608-a436-c16b-6846-947573e6ee3c@kernel.dk>
 <92dc07f1-dfbd-2449-ce76-502455f56136@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92dc07f1-dfbd-2449-ce76-502455f56136@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 08:38:57AM -0700, Jens Axboe wrote:
> On 3/9/18 8:38 AM, Jens Axboe wrote:
> > On 3/8/18 5:20 PM, Ross Zwisler wrote:
> >> This has gotten Reviewed-by tags from Christoph and Ming Lei.
> >>
> >> Al, are you the right person to merge this?  Or is the correct person Jens,
> >> whom I accidentally didn't include when I sent this out?
> >>
> >> Just wanted to make sure this got merged, and to see whether it was targeting
> >> v4.16 or v4.17.
> > 
> > I'm the right guy, but I don't see patches if I'm not cc'ed on them...
> > I have queued this up for 4.16, thanks.
> 
> I do see patches sent to linux-block as well, but you didn't CC that one
> either.

I figure out who to CC on my patches by using scripts/get_maintainer.pl, and
it didn't know about you or linux-block because drivers/block wasn't covered
in MAINTAINERS.  I'll send a patch to fix this.

As it was I just CC'd the folks involved in the original patch, and that one
went up through Al.

Thanks for picking this up.
