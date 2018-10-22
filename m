Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC72DC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BF720779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BF720779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeJVR03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:26:29 -0400
Received: from verein.lst.de ([213.95.11.211]:35130 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeJVR03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:26:29 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9741168BE1; Mon, 22 Oct 2018 11:08:49 +0200 (CEST)
Date:   Mon, 22 Oct 2018 11:08:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk,
        martin.petersen@oracle.com, tom.leiming@gmail.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] block: fix the DISCARD request merge
Message-ID: <20181022090849.GA19053@lst.de>
References: <1540045777-10290-1-git-send-email-jianchao.w.wang@oracle.com> <20181022090601.GA21171@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022090601.GA21171@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 05:06:02PM +0800, Ming Lei wrote:
> 
> The above may be changed to 'if (blk_try_merge(req) == ELEVATOR_DISCARD_MERGE)'
> or sort of in future, which may has document benefit at least, since
> ELEVATOR_DISCARD_MERGE means multi-segment discard merge.

I like that idea, and we should do it for the respin
