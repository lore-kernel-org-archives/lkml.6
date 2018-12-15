Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAB8C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8102A2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbeLOKvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 05:51:15 -0500
Received: from verein.lst.de ([213.95.11.211]:52700 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbeLOKvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 05:51:15 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DBB9168D80; Sat, 15 Dec 2018 11:51:12 +0100 (CET)
Date:   Sat, 15 Dec 2018 11:51:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     zhangjun <openzhangj@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>, hch@lst.de,
        bfoster@redhat.com, Dave Chinner <david@fromorbit.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, n-horiguchi@ah.jp.nec.com,
        mgorman@techsingularity.net, aarcange@redhat.com,
        willy@infradead.org, linux@dominikbrodowski.net,
        linux-mm@kvack.org, Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH] fix page_count in ->iomap_migrate_page()
Message-ID: <20181215105112.GC1575@lst.de>
References: <1544766961-3492-1-git-send-email-openzhangj@gmail.com> <1618433.IpySj692Hd@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618433.IpySj692Hd@blindfold>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, for iomap we got a patch to just increment the page count when
setting the private data, and it finally got merged into mainline after
a while.

Not that it totally makes sense to me, but it is what it is.  It would
just be nice if set_page_private took care of it and we had a
clear_page_private to undo it, making the whole scheme at lot more
obvious.
