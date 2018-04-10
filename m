Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeDJBlz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:41:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751543AbeDJBly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:41:54 -0400
Date: Mon, 9 Apr 2018 18:41:53 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/3] mm: restructure memfd code
Message-ID: <20180410014153.GB31282@bombadil.infradead.org>
References: <20180409230505.18953-1-mike.kravetz@oracle.com>
 <20180409230505.18953-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409230505.18953-4-mike.kravetz@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 04:05:05PM -0700, Mike Kravetz wrote:
> +/*
> + * We need a tag: a new tag would expand every radix_tree_node by 8 bytes,
> + * so reuse a tag which we firmly believe is never set or cleared on shmem.
> + */
> +#define SHMEM_TAG_PINNED        PAGECACHE_TAG_TOWRITE

Do we also firmly believe it's never used on hugetlbfs?
