Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F40BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB2F20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB2F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLFRkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:40:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeLFRkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:40:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2BF112D80D;
        Thu,  6 Dec 2018 17:40:46 +0000 (UTC)
Received: from localhost (ovpn-200-34.brq.redhat.com [10.40.200.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE42051F09;
        Thu,  6 Dec 2018 17:40:28 +0000 (UTC)
Date:   Thu, 6 Dec 2018 18:40:27 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?= =?UTF-8?B?cmdlbnNlbg==?= 
        <toke@toke.dk>, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, brouer@redhat.com
Subject: Re: [PATCH] dma-mapping: bypass indirect calls for dma-direct
Message-ID: <20181206184027.291947c3@redhat.com>
In-Reply-To: <20181206153720.10702-2-hch@lst.de>
References: <20181206153720.10702-1-hch@lst.de>
        <20181206153720.10702-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 06 Dec 2018 17:40:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Dec 2018 07:37:20 -0800
Christoph Hellwig <hch@lst.de> wrote:

> Avoid expensive indirect calls in the fast path DMA mapping
> operations by directly calling the dma_direct_* ops if we are using
> the directly mapped DMA operations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/dma-direct.h  |  17 -----
>  include/linux/dma-mapping.h | 138 +++++++++++++++++++++++++++++++-----
>  kernel/dma/direct.c         |  13 ++--
>  3 files changed, 127 insertions(+), 41 deletions(-)

Hi Christoph,

Is this patch to be applied on top of the other (41) patches I just
tested with my XDP forward workload?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
