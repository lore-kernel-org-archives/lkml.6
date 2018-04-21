Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeDUJH2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 05:07:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeDUJH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 05:07:26 -0400
Date: Sat, 21 Apr 2018 02:07:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] mm,tcp: provide mmap_hook to solve lockdep
 issue
Message-ID: <20180421090722.GA11998@infradead.org>
References: <20180420155542.122183-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420155542.122183-1-edumazet@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 08:55:38AM -0700, Eric Dumazet wrote:
> This patch series provide a new mmap_hook to fs willing to grab
> a mutex before mm->mmap_sem is taken, to ensure lockdep sanity.
> 
> This hook allows us to shorten tcp_mmap() execution time (while mmap_sem
> is held), and improve multi-threading scalability. 

Missing CC to linu-fsdevel and linux-mm that will have to decide.

We've rejected this approach multiple times before, so you better
make a really good argument for it.

introducing a multiplexer that overloads a single method certainly
doesn't help making that case.
