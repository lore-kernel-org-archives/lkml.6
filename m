Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C8BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4C921532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4C921532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbeIUSxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:53:50 -0400
Received: from verein.lst.de ([213.95.11.211]:38043 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbeIUSxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:53:50 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E5C5768AEF; Fri, 21 Sep 2018 15:05:04 +0200 (CEST)
Date:   Fri, 21 Sep 2018 15:05:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
Message-ID: <20180921130504.GA22551@lst.de>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com> <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8ij0zot.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 03:04:18PM +0200, Vitaly Kuznetsov wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > On Wed, Sep 19, 2018 at 05:15:43PM +0800, Ming Lei wrote:
> >> 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
> >> yes, is it a stable rule?
> >
> > This is the assumption in a lot of the kernel, so I think if somethings
> > breaks this we are in a lot of pain.
> 
> It seems that SLUB debug breaks this assumption. Kernel built with
> 
> CONFIG_SLUB_DEBUG=y
> CONFIG_SLUB=y
> CONFIG_SLUB_DEBUG_ON=y

Looks like we should fix SLUB debug then..
