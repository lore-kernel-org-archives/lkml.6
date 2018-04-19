Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeDVIVg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 04:21:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39235 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeDVIVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 04:21:34 -0400
X-Google-Smtp-Source: AIpwx4+WH26gupAl0RGvjeC7qS8X8H+UkzGW+uRi4daHQOnMo2j5J87Etucr6thuKmAX9QCd+zrRkg==
Date: Thu, 19 Apr 2018 12:05:12 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>, viro@zeniv.linux.org.uk,
        nyc@holomorphy.com, mike.kravetz@oracle.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: introduce ST_HUGE flag and set it to tmpfs and
 hugetlbfs
Message-ID: <20180419090512.apnalks6s5z63lqq@node.shutemov.name>
References: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180418102744.GA10397@infradead.org>
 <73090d4b-6831-805b-8b9d-5dff267428d9@linux.alibaba.com>
 <20180419082810.GA8624@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419082810.GA8624@infradead.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 01:28:10AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 18, 2018 at 11:18:25AM -0700, Yang Shi wrote:
> > Yes, thanks for the suggestion. I did think about it before I went with the
> > new flag. Not like hugetlb, THP will *not* guarantee huge page is used all
> > the time, it may fallback to regular 4K page or may get split. I'm not sure
> > how the applications use f_bsize field, it might break existing applications
> > and the value might be abused by applications to have counter optimization.
> > So, IMHO, a new flag may sound safer.
> 
> But st_blksize isn't the block size, that is why I suggested it.  It is
> the preferred I/O size, and various file systems can report way
> larger values than the block size already.

I agree. This looks like a better fit.

-- 
 Kirill A. Shutemov
