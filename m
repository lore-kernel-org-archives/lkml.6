Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeDQXXA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 19:23:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeDQXW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 19:22:59 -0400
Date: Tue, 17 Apr 2018 16:22:48 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: viro@zeniv.linux.org.uk, nyc@holomorphy.com, mike.kravetz@oracle.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: introduce ST_HUGE flag and set it to tmpfs and
 hugetlbfs
Message-ID: <20180417232248.GA27631@bombadil.infradead.org>
References: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 05:08:13AM +0800, Yang Shi wrote:
> When applications use huge page on hugetlbfs, it just need check the
> filesystem magic number, but it is not enough for tmpfs. So, introduce
> ST_HUGE flag to statfs if super block has SB_HUGE set which indicates
> huge page is supported on the specific filesystem.

Hm.  What's the plan for communicating support for page sizes other
than PMD page sizes?  I know ARM has several different page sizes,
as do PA-RISC and ia64.  Even x86 might support 1G page sizes through
tmpfs one day.
