Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE384C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CC420873
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CC420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeJ2Ade (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 20:33:34 -0400
Received: from verein.lst.de ([213.95.11.211]:49428 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbeJ2Ade (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 20:33:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E6D7D67358; Sun, 28 Oct 2018 16:48:35 +0100 (CET)
Date:   Sun, 28 Oct 2018 16:48:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, tom.leiming@gmail.com,
        hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] block: fix the DISCARD request merge
Message-ID: <20181028154835.GA3061@lst.de>
References: <1540641134-21485-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540641134-21485-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 07:52:14PM +0800, Jianchao Wang wrote:
> +enum elv_merge blk_try_req_merge(struct request *req, struct request *next)
> +{
> +	if (blk_discard_mergable(req))
> +		return ELEVATOR_DISCARD_MERGE;
> +	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
> +		return ELEVATOR_BACK_MERGE;
> +
> +	return ELEVATOR_NO_MERGE;

The empty line here look a little odd, but if that is the only thing
I can nitpick about it must be great, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
