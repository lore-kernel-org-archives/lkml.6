Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B55C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D9620989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfAUTMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:12:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:46228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727159AbfAUTMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:12:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4221DAC3F;
        Mon, 21 Jan 2019 19:12:12 +0000 (UTC)
Date:   Mon, 21 Jan 2019 11:12:02 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jack@suse.de" <jack@suse.de>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, willy@infradead.org
Subject: Re: [PATCH 6/6] drivers/IB,core: reduce scope of mmap_sem
Message-ID: <20190121191202.xygjopuuifyepd63@linux-r8p5>
Mail-Followup-To: Jason Gunthorpe <jgg@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jack@suse.de" <jack@suse.de>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, willy@infradead.org
References: <20190121174220.10583-1-dave@stgolabs.net>
 <20190121174220.10583-7-dave@stgolabs.net>
 <20190121183218.GK25149@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190121183218.GK25149@mellanox.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Jason Gunthorpe wrote:

>On Mon, Jan 21, 2019 at 09:42:20AM -0800, Davidlohr Bueso wrote:
>> ib_umem_get() uses gup_longterm() and relies on the lock to
>> stabilze the vma_list, so we cannot really get rid of mmap_sem
>> altogether, but now that the counter is atomic, we can get of
>> some complexity that mmap_sem brings with only pinned_vm.
>>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>> ---
>>  drivers/infiniband/core/umem.c | 41 ++---------------------------------------
>>  1 file changed, 2 insertions(+), 39 deletions(-)
>
>I think this addresses my comment..
>
>Considering that it is almost all infiniband, I'd rather it go it go
>through the RDMA tree with an ack from mm people? Please advise..

Yeah also Cc'ing Willy who I forgot to add for v2.

>
>Thanks,
>Jason
