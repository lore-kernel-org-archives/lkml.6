Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755441AbeDCLlY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:41:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755135AbeDCLlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:41:22 -0400
Date: Tue, 3 Apr 2018 04:41:17 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] mm: Add free()
Message-ID: <20180403114117.GA5832@bombadil.infradead.org>
References: <20180322195819.24271-1-willy@infradead.org>
 <20180322195819.24271-4-willy@infradead.org>
 <1e95ce64-828b-1214-a930-1ffaedfa00b8@rasmusvillemoes.dk>
 <20180323143435.GB5624@bombadil.infradead.org>
 <20180403085059.GB3926@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403085059.GB3926@amd>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 10:50:59AM +0200, Pavel Machek wrote:
> > gcc already does some nice optimisations around free().  For example, it
> > can eliminate dead stores:
> 
> Are we comfortable with that optimalization for kernel?
> 
> us: "Hey, let's remove those encryption keys before freeing memory."
> gcc: :-).
> 
> us: "Hey, we want to erase lock magic values not to cause confusion
> later."
> gcc: "I like confusion!"
> 
> Yes, these probably can be fixed by strategic "volatile" and/or
> barriers, but...

Exactly, we should mark those sites explicitly with volatile so that 
they aren't dead stores.
