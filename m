Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C889C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065622082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065622082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeLJFNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:13:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeLJFNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:13:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5288581F09;
        Mon, 10 Dec 2018 05:13:40 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1139A5C1B2;
        Mon, 10 Dec 2018 05:13:39 +0000 (UTC)
Date:   Mon, 10 Dec 2018 00:13:39 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alasdair G Kergon <agk@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the device-mapper tree with the
 block tree
Message-ID: <20181210051338.GA2737@redhat.com>
References: <20181210144322.11a94d25@canb.auug.org.au>
 <1993882e-8af3-9e64-da82-195d0089d5e3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1993882e-8af3-9e64-da82-195d0089d5e3@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 10 Dec 2018 05:13:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09 2018 at 10:55pm -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> On 12/9/18 8:43 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > It appears that there are a series of shared patches between the block
> > and device-mapper trees that are not the same commits.  I assume that the
> > block tree has been rebased, while the device mapper tree that was based
> > (or includes) part of the block tree has not bee rebased (yet).
> 
> Yep that's my fault, due to a stupid mistake I had to rebase the
> block tree. Didn't realize that Mike's tree was based on it. Mike,
> would it be a big issue for you to rebase the dm tree?

No problem, just did it and pushed to linux-dm.git's for-next.
(I was already anticipating rebasing dm's for-next again once the
bio-based percpu in_flight was merged into linux-block, hopefully we can
get that to land)
