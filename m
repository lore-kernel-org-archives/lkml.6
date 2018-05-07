Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeEGLLr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:11:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeEGLLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 07:11:44 -0400
Date: Mon, 7 May 2018 04:11:42 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 1/3] vfs: dedpue: return s64
Message-ID: <20180507111142.GA18116@bombadil.infradead.org>
References: <20180507082108.28186-1-mszeredi@redhat.com>
 <20180507082108.28186-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507082108.28186-2-mszeredi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 10:21:06AM +0200, Miklos Szeredi wrote:
> f_op->dedupe_file_range() gets a u64 length to dedup and returns an ssize_t
> actual length deduped.  This breaks badly on 32bit archs since the returned
> length will be truncated and possibly overflow into the sign bit (xfs and
> ocfs2 are affected, btrfs limits actual length to 16MiB).
> 
> Returning s64 should be good, since clone_verify_area() makes sure that the
> supplied length doesn't overflow.

Why s64 rather than loff_t?  Particularly since the next patch turns
the paramters into loff_t.
