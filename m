Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbeCXEas (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 00:30:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeCXEar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 00:30:47 -0400
Date: Fri, 23 Mar 2018 21:30:44 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: adobriyan@gmail.com, mhocko@kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180324043044.GA22733@bombadil.infradead.org>
References: <1521851771-108673-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521851771-108673-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So, introduce a new rwlock in mm_struct to protect the concurrent access
> to arg_start|end and env_start|end.

I don't think an rwlock makes much sense here.  There is almost no
concurrency on the read side, and an rwlock is more expensive than
a spinlock.  Just use a spinlock.
