Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64B1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B8020857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B8020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbeGZTKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:10:51 -0400
Received: from verein.lst.de ([213.95.11.211]:37535 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730764AbeGZTKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:10:51 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D614E68D60; Thu, 26 Jul 2018 19:56:43 +0200 (CEST)
Date:   Thu, 26 Jul 2018 19:56:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: linux-next: build failure after merge of the block tree
Message-ID: <20180726175643.GA10765@lst.de>
References: <20180726145624.13a604ed@canb.auug.org.au> <20180726084833.GA23310@lst.de> <a65a6023-a527-b9c6-0d78-a175d47f55cf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a65a6023-a527-b9c6-0d78-a175d47f55cf@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 10:48:21AM -0700, Jens Axboe wrote:
> >>  	inline_page_count = num_pages(port->inline_data_size);
> >>  	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
> >> -				cm_id->device->attrs.max_sge) - 1;
> >> +				cm_id->device->attrs.max_send_sge) - 1;
> > 
> > This should be max_recv_sge.
> 
> Why do we even have this conflicts to begin with?

Because the nvme code added a new user of max_sges while the RDMA tree
split it into two separate fields.  We discussed this a while ago when
the issue came up.
