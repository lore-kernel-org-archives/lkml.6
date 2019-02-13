Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8C4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D567A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392670AbfBMW3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:29:13 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47228 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391946AbfBMW3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:29:13 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 39C88146E;
        Wed, 13 Feb 2019 22:29:12 +0000 (UTC)
Date:   Wed, 13 Feb 2019 14:29:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-Id: <20190213142911.f4447df2b30cc8ced2a1bb82@linux-foundation.org>
In-Reply-To: <20190213172518.50d4fec7@canb.auug.org.au>
References: <20190213172518.50d4fec7@canb.auug.org.au>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 17:25:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Andrew,
> 
> After merging the akpm-current tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> fs/io_uring.c: In function 'io_async_list_note':
> fs/io_uring.c:931:16: error: 'VM_MAX_READAHEAD' undeclared (first use in this function); did you mean 'VM_MAYREAD'?
>     max_pages = VM_MAX_READAHEAD >> (PAGE_SHIFT - 10);
>                 ^~~~~~~~~~~~~~~~
>                 VM_MAYREAD
> 
> Caused by commit
> 
>   4c416502dae2 ("mm: Refactor readahead defines in mm.h")
> 
> interacting with commit
> 
>   6eff5fa16a2e ("io_uring: allow workqueue item to handle multiple buffered requests")
> 
> from the block tree.
> 

Thanks.  I'll fix mm-refactor-readahead-defines-in-mmh.patch and shall
stage it after the block tree so everything lands nicely.

