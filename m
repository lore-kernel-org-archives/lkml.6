Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D70DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DF32083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DF32083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeGZKAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:00:39 -0400
Received: from verein.lst.de ([213.95.11.211]:35377 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbeGZKAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:00:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 62A3068D64; Thu, 26 Jul 2018 10:48:33 +0200 (CEST)
Date:   Thu, 26 Jul 2018 10:48:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build failure after merge of the block tree
Message-ID: <20180726084833.GA23310@lst.de>
References: <20180726145624.13a604ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726145624.13a604ed@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 02:56:24PM +1000, Stephen Rothwell wrote:
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 86121a7a19b2..8c30ac7d8078 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -891,7 +891,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
>  
>  	inline_page_count = num_pages(port->inline_data_size);
>  	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
> -				cm_id->device->attrs.max_sge) - 1;
> +				cm_id->device->attrs.max_send_sge) - 1;

This should be max_recv_sge.
