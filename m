Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EAEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 11:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FBA2171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 11:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbeLOLRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 06:17:05 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:50016 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbeLOLRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 06:17:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 09DD36083243;
        Sat, 15 Dec 2018 12:17:03 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8o5zfAokYdiR; Sat, 15 Dec 2018 12:17:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A98C76083257;
        Sat, 15 Dec 2018 12:17:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K_Ja8IUe_iaq; Sat, 15 Dec 2018 12:17:02 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id A90A06083243;
        Sat, 15 Dec 2018 12:17:01 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Christoph Hellwig <hch@lst.de>
Cc:     zhangjun <openzhangj@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>, bfoster@redhat.com,
        Dave Chinner <david@fromorbit.com>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        n-horiguchi@ah.jp.nec.com, mgorman@techsingularity.net,
        aarcange@redhat.com, willy@infradead.org,
        linux@dominikbrodowski.net, linux-mm@kvack.org,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH] fix page_count in ->iomap_migrate_page()
Date:   Sat, 15 Dec 2018 12:17:01 +0100
Message-ID: <140465544.WOeLnmPe7Q@blindfold>
In-Reply-To: <20181215105112.GC1575@lst.de>
References: <1544766961-3492-1-git-send-email-openzhangj@gmail.com> <1618433.IpySj692Hd@blindfold> <20181215105112.GC1575@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 15. Dezember 2018, 11:51:12 CET schrieb Christoph Hellwig:
> FYI, for iomap we got a patch to just increment the page count when
> setting the private data, and it finally got merged into mainline after
> a while.
> 
> Not that it totally makes sense to me, but it is what it is.  It would
> just be nice if set_page_private took care of it and we had a
> clear_page_private to undo it, making the whole scheme at lot more
> obvious.

Yeah, UBIFS will go the same route. I have already a patch prepared
which increments the page count when UBIFS sets PG_private.

Thanks,
//richard



