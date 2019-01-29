Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38EEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01802147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfA2OPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:15:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:38948 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbfA2OPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:15:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0EEA4AE72;
        Tue, 29 Jan 2019 14:15:04 +0000 (UTC)
Date:   Tue, 29 Jan 2019 06:14:45 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     akpm@linux-foundation.org, dledford@redhat.com, jack@suse.de,
        ira.weiny@intel.com, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/6] drivers/IB,qib: do not use mmap_sem
Message-ID: <20190129141445.kch4jxr2ps62ohcw@linux-r8p5>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>, akpm@linux-foundation.org,
        dledford@redhat.com, jack@suse.de, ira.weiny@intel.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dennis.dalessandro@intel.com,
        mike.marciniszyn@intel.com, Davidlohr Bueso <dbueso@suse.de>
References: <20190121174220.10583-1-dave@stgolabs.net>
 <20190121174220.10583-4-dave@stgolabs.net>
 <20190128233140.GA12530@ziepe.ca>
 <20190129044607.GL25106@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190129044607.GL25106@ziepe.ca>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019, Jason Gunthorpe wrote:

>.. and I'm looking at some of the other conversions here.. *most
>likely* any caller that is manipulating rlimit for get_user_pages
>should really be calling get_user_pages_longterm, so they should not
>be converted to use _fast?

Yeah this was something that crossed my mind could come up when I
first sent the series. I'll send a v3 where I leave the gup() calls
alone for rdma drivers; and we can at least convert the mmap_sem to
reader.

Thanks,
Davidlohr
