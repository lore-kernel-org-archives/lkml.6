Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932201AbeBKUJm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 15:09:42 -0500
Received: from casper.infradead.org ([85.118.1.10]:40556 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932158AbeBKUJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 15:09:35 -0500
Date: Sun, 11 Feb 2018 12:09:28 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] mm/huge_memory.c: reorder operations in
 __split_huge_page_tail()
Message-ID: <20180211200928.GA4680@bombadil.infradead.org>
References: <4f64569f-b8ce-54f8-33d9-0e67216bb54c@yandex-team.ru>
 <151835937752.185602.5640977700089242532.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151835937752.185602.5640977700089242532.stgit@buzz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 05:29:37PM +0300, Konstantin Khlebnikov wrote:
> +	/*
> +	 * Finally unfreeze refcount. Additional pin to radix tree.
> +	 */
> +	page_ref_unfreeze(page_tail, 1 + (!PageAnon(head) ||
> +					  PageSwapCache(head)));

Please say "Additional pin from page cache", not "radix tree".
