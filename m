Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9CEC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009D92184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbfAKOet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:34:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389952AbfAKOem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:34:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCEB52175E;
        Fri, 11 Jan 2019 14:34:41 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88DBF4100;
        Fri, 11 Jan 2019 14:34:41 +0000 (UTC)
Date:   Fri, 11 Jan 2019 09:34:40 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Xiao Ni <xni@redhat.com>,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 4.4 72/88] block: dont deal with discard limit in
 blkdev_issue_discard()
Message-ID: <20190111143440.GB10601@redhat.com>
References: <20190111131045.137499039@linuxfoundation.org>
 <20190111131058.120784730@linuxfoundation.org>
 <20190111142539.GA10601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111142539.GA10601@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 11 Jan 2019 14:34:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11 2019 at  9:25am -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Fri, Jan 11 2019 at  9:08am -0500,
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Ming Lei <ming.lei@redhat.com>
> > 
> > commit 744889b7cbb56a64f957e65ade7cb65fe3f35714 upstream.
> 
> Hi Greg,
> 
> Please also pick up this commit:
> 89f5fa47476eda56402e29fff3c5097f5c2a1e19 ("dm: call blk_queue_split() to
> impose device limits on bios")
> 
> Thanks,
> Mike

But.. looking closer, since you're backporting to 4.4, to even have DM
be able to use bio_split() you'll need these 3 commits too:

18a25da84354c6bb655320de6072c00eda6eb602 ("dm: ensure bio submission follows a depth-first tree walk")
8dd601fa8317243be887458c49f6c29c2f3d719f ("dm: correctly handle chained bios in dec_pending()")
f21c601a2bb319ec19eb4562eadc7797d90fd90e ("dm: use bio_split() when splitting out the already processed bio")

Mike
