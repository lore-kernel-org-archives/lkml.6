Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbeDSI2W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:28:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeDSI2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:28:19 -0400
Date: Thu, 19 Apr 2018 01:28:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk,
        nyc@holomorphy.com, mike.kravetz@oracle.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: introduce ST_HUGE flag and set it to tmpfs and
 hugetlbfs
Message-ID: <20180419082810.GA8624@infradead.org>
References: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180418102744.GA10397@infradead.org>
 <73090d4b-6831-805b-8b9d-5dff267428d9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73090d4b-6831-805b-8b9d-5dff267428d9@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 11:18:25AM -0700, Yang Shi wrote:
> Yes, thanks for the suggestion. I did think about it before I went with the
> new flag. Not like hugetlb, THP will *not* guarantee huge page is used all
> the time, it may fallback to regular 4K page or may get split. I'm not sure
> how the applications use f_bsize field, it might break existing applications
> and the value might be abused by applications to have counter optimization.
> So, IMHO, a new flag may sound safer.

But st_blksize isn't the block size, that is why I suggested it.  It is
the preferred I/O size, and various file systems can report way
larger values than the block size already.
