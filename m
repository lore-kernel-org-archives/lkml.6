Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48750C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0217420647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0217420647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opengridcomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbeGZTR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:17:28 -0400
Received: from linode.aoot.com ([69.164.194.13]:35946 "EHLO linode.aoot.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388871AbeGZTR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:17:28 -0400
Received: from stevoacer (47-221-137-213.gtwncmta03.res.dyn.suddenlink.net [47.221.137.213])
        by linode.aoot.com (Postfix) with ESMTP id A9B84821C;
        Thu, 26 Jul 2018 12:59:33 -0500 (CDT)
From:   "Steve Wise" <swise@opengridcomputing.com>
To:     "'Christoph Hellwig'" <hch@lst.de>,
        "'Jens Axboe'" <axboe@kernel.dk>
Cc:     "'Stephen Rothwell'" <sfr@canb.auug.org.au>,
        "'Doug Ledford'" <dledford@redhat.com>,
        "'Jason Gunthorpe'" <jgg@mellanox.com>,
        "'Linux-Next Mailing List'" <linux-next@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <20180726145624.13a604ed@canb.auug.org.au> <20180726084833.GA23310@lst.de> <a65a6023-a527-b9c6-0d78-a175d47f55cf@kernel.dk> <20180726175643.GA10765@lst.de>
In-Reply-To: <20180726175643.GA10765@lst.de>
Subject: RE: linux-next: build failure after merge of the block tree
Date:   Thu, 26 Jul 2018 12:59:35 -0500
Message-ID: <00b801d4250a$69e2a9f0$3da7fdd0$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQKoseR149ZceM129HjmJJMloZXPqgF4nzvXANjmRz0DTY8a/6LLuFYA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Thursday, July 26, 2018 12:57 PM
> To: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@lst.de>; Stephen Rothwell
> <sfr@canb.auug.org.au>; Doug Ledford <dledford@redhat.com>; Jason
> Gunthorpe <jgg@mellanox.com>; Linux-Next Mailing List <linux-
> next@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Steve Wise <swise@opengridcomputing.com>
> Subject: Re: linux-next: build failure after merge of the block tree
> 
> On Thu, Jul 26, 2018 at 10:48:21AM -0700, Jens Axboe wrote:
> > >>  	inline_page_count = num_pages(port->inline_data_size);
> > >>  	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
> > >> -				cm_id->device->attrs.max_sge) - 1;
> > >> +				cm_id->device->attrs.max_send_sge) -
1;
> > >
> > > This should be max_recv_sge.
> >
> > Why do we even have this conflicts to begin with?
> 
> Because the nvme code added a new user of max_sges while the RDMA tree
> split it into two separate fields.  We discussed this a while ago when
> the issue came up.

See: https://www.spinics.net/lists/linux-rdma/msg66208.html 

Steve.


