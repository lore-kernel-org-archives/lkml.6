Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA5AC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB04B21A50
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB04B21A50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kwaak.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbeHFQdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:33:46 -0400
Received: from gw-fsck-sorbs.kwaak.net ([84.245.27.153]:44997 "EHLO
        mail.kwaak.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbeHFQdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:33:46 -0400
Received: from [192.168.0.44] (port=56627 helo=shell3.kwaak.net)
        by mail.kwaak.net with esmtp (Exim 4.50)
        id 1fmgQi-0001Pj-7S; Mon, 06 Aug 2018 16:24:17 +0200
Received: from ard by shell3.kwaak.net with local (Exim 4.80)
        (envelope-from <ard@kwaak.net>)
        id 1fmgQg-0001Pe-9p; Mon, 06 Aug 2018 16:24:14 +0200
Date:   Mon, 6 Aug 2018 16:24:14 +0200
From:   ard <ard@kwaak.net>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/3] scsi: fcoe: memleak fixes
Message-ID: <20180806142414.GB23827@kwaak.net>
References: <20180731134603.20089-1-jthumshirn@suse.de>
 <20180806092503.6ed56kukj2i236qt@linux-x5ow.site>
 <20180806132234.GA23827@kwaak.net>
 <20180806132725.ihbi5rxvkuuppajr@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806132725.ihbi5rxvkuuppajr@linux-x5ow.site>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.168.0.44 (failed)
X-Kwaak-Spam-Score: -2.6
X-kwaak-MailScanner: Found to be clean
X-kwaak-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.304,
        required 5, autolearn=not spam, BAYES_00 -2.60,
        DNS_FROM_AHBL_RHSBL 0.29)
X-MailScanner-From: ard@kwaak.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Mon, Aug 06, 2018 at 03:27:25PM +0200, Johannes Thumshirn wrote:
> On Mon, Aug 06, 2018 at 03:22:34PM +0200, ard wrote:
> > Ahh, yeah, sorry.
> > I did test them.
> > I can't say I see a regression.
> > I also can't say I see progress, although it feels like there is
> > a tad less leaking.
> > For that I need to do some statistics.
> > 
> > But for now I ack that it does not regress further.
> 
> From what I've seen in your kmemleak reports, it wasn't only
> libfc/fcoe that was leaking memory.
> 
> So kmemleak reports are welcome (especially if they confirm libfc/fcoe
> is clean now ;-)).
I've updated the ticket:
https://github.com/hardkernel/linux/issues/360#issuecomment-410721997
dmesg (with full debugging):
https://github.com/hardkernel/linux/files/2262858/dmesg-2018-08-06.txt
and kmemleak:
https://github.com/hardkernel/linux/files/2262861/kmemleak-2018-08-06.txt

I'll have to take a good look at the what and why.
I'm gonna git clean -x -d and rebuild the kernel, because this is
weird.

This is the tree I build:
https://github.com/ardje/linux/tree/gb-4.14-fcoe-patch
So vanilla linux-4.14 with the patch set:
https://github.com/ardje/linux/commit/747bf04057a99be5b01f768654cfd61bc9f4fc6c
Meh, I should try to use git for patching.

I will spam some printk's later on, just to check which flows are
followed (if the git clean doesn't reveal some problem, although
I can't imagine).

Regards,
Ard

-- 
.signature not found
