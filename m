Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754773AbeBGRT6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:19:58 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:58857 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754528AbeBGRT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:19:57 -0500
Date: Wed, 7 Feb 2018 09:19:36 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christopher Lameter <cl@linux.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com,
        rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
Message-ID: <20180207171936.GA12446@bombadil.infradead.org>
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
 <20180207021703.GC3617@linux.vnet.ibm.com>
 <20180207042334.GA16175@bombadil.infradead.org>
 <alpine.DEB.2.20.1802071040570.22131@nuc-kabylake>
 <20180207120949.62fa815f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207120949.62fa815f@gandalf.local.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 12:09:49PM -0500, Steven Rostedt wrote:
> > Maybe lets implement malloc(), free() and realloc() in the kernel to be
> > consistent with user space use as possible? Only use the others
> > allocation variants for special cases.
> 
> They would need to drop the GFP part and default to GFP_KERNEL.

Yes, exactly.

> > So malloc would check allocation sizes and if < 2* PAGE_SIZE use kmalloc()
> > otherwise vmalloc().
> 
> Please no, I hate subtle internal decisions like this. It makes
> debugging much more difficult, when allocating dynamic sized variables.
> When something works at one size but not the other.

You know we already have kvmalloc()?
