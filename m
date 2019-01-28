Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DDEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CC82148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfA1VK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:10:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49380 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfA1VK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:10:58 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E77252863;
        Mon, 28 Jan 2019 21:10:57 +0000 (UTC)
Date:   Mon, 28 Jan 2019 13:10:56 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, dledford@redhat.com,
        jack@suse.de, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>,
        Christoph Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/6] mm: make mm->pinned_vm an atomic64 counter
Message-Id: <20190128131056.101a126f222929318bb2ea83@linux-foundation.org>
In-Reply-To: <20190123183353.GA15768@ziepe.ca>
References: <20190121174220.10583-1-dave@stgolabs.net>
        <20190121174220.10583-2-dave@stgolabs.net>
        <20190123183353.GA15768@ziepe.ca>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 11:33:53 -0700 Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Jan 21, 2019 at 09:42:15AM -0800, Davidlohr Bueso wrote:
> > Taking a sleeping lock to _only_ increment a variable is quite the
> > overkill, and pretty much all users do this. Furthermore, some drivers
> > (ie: infiniband and scif) that need pinned semantics can go to quite
> > some trouble to actually delay via workqueue (un)accounting for pinned
> > pages when not possible to acquire it.
> > 
> > By making the counter atomic we no longer need to hold the mmap_sem
> > and can simply some code around it for pinned_vm users. The counter
> > is 64-bit such that we need not worry about overflows such as rdma
> > user input controlled from userspace.
> 
> I see a number of MM people Reviewed-by this so are we good to take
> this in the RDMA tree now?

Please do.
