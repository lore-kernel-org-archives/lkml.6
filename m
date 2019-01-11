Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A650C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6652B2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391897AbfAKPGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:06:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389267AbfAKPGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:06:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCD337AE8B;
        Fri, 11 Jan 2019 15:06:06 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CC8860920;
        Fri, 11 Jan 2019 15:06:06 +0000 (UTC)
Date:   Fri, 11 Jan 2019 10:06:05 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ming Lin <ming.l@ssi.samsung.com>,
        Christoph Hellwig <hch@lst.de>, Xiao Ni <xni@redhat.com>,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 4.4 72/88] block: dont deal with discard limit in
 blkdev_issue_discard()
Message-ID: <20190111150605.GA10771@redhat.com>
References: <20190111131045.137499039@linuxfoundation.org>
 <20190111131058.120784730@linuxfoundation.org>
 <20190111142539.GA10601@redhat.com>
 <20190111143514.GA8530@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111143514.GA8530@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 11 Jan 2019 15:06:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11 2019 at  9:35am -0500,
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Jan 11, 2019 at 09:25:39AM -0500, Mike Snitzer wrote:
> > On Fri, Jan 11 2019 at  9:08am -0500,
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Ming Lei <ming.lei@redhat.com>
> > > 
> > > commit 744889b7cbb56a64f957e65ade7cb65fe3f35714 upstream.
> > 
> > Hi Greg,
> > 
> > Please also pick up this commit:
> > 89f5fa47476eda56402e29fff3c5097f5c2a1e19 ("dm: call blk_queue_split() to
> > impose device limits on bios")
> 
> That's going to be hard as the dependancy for that patch is not here in
> 4.4.y, and this patch itself isn't even in anything older than 4.19.y.

Right, I quickly replied to this thread with followup of the 3 prereq
patches needed to get 89f5fa47476 to apply.

> So why add it here to 4.4.y only?

Because you're looking to pull in a commit into 4.4 that causes problems
elsewhere.
 
> Can you send the needed patch series to the stable@ mailing list for the
> different stable trees if this needs to get into them?

I'll try to get to that, but it is low priority for me.  And in the
meantime.. DM will be broken in 4.4 if you take 744889b7cb.. wheeeee.

Mike
