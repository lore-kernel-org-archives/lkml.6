Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965491AbeBMRNL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:13:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965158AbeBMRNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:13:08 -0500
Date: Tue, 13 Feb 2018 07:16:08 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: dcache: Avoid livelock between d_alloc_parallel and
 __d_add
Message-ID: <20180213151608.GA17791@bombadil.infradead.org>
References: <1518526731-26546-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518526731-26546-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 12:58:51PM +0000, Will Deacon wrote:
> This patch resolves the livelock by not taking hlist_bl_lock in
> d_alloc_parallel if the sequence counter is odd, since any subsequent
> masked comparison with i_dir_seq will fail anyway.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

I wonder whether it makes sense to turn i_dir_seq into a seqcount_t,
which would give us the lockdep checking as well.
