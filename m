Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C102C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18CB207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18CB207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeJXTui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:50:38 -0400
Received: from verein.lst.de ([213.95.11.211]:49851 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbeJXTui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:50:38 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E253068C8D; Wed, 24 Oct 2018 13:22:53 +0200 (CEST)
Date:   Wed, 24 Oct 2018 13:22:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, tom.leiming@gmail.com,
        hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] block: fix the DISCARD request merge
Message-ID: <20181024112253.GA18207@lst.de>
References: <1540350450-15208-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540350450-15208-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	/*
> -	 * not contiguous
> -	 */
> -	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
> -		return NULL;
> -

As suggested previously I think we want something like blk_try_merge
and its return values here.  Maybe a blk_try_req_merge that takes
requests instead of bios.
