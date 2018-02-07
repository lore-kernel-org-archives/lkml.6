Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754972AbeBGR3Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:29:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754693AbeBGR3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:29:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59422172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 7 Feb 2018 12:29:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christopher Lameter <cl@linux.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com,
        rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
Message-ID: <20180207122910.1a91a48e@gandalf.local.home>
In-Reply-To: <20180207171936.GA12446@bombadil.infradead.org>
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
        <20180207021703.GC3617@linux.vnet.ibm.com>
        <20180207042334.GA16175@bombadil.infradead.org>
        <alpine.DEB.2.20.1802071040570.22131@nuc-kabylake>
        <20180207120949.62fa815f@gandalf.local.home>
        <20180207171936.GA12446@bombadil.infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2018 09:19:36 -0800
Matthew Wilcox <willy@infradead.org> wrote:

> > Please no, I hate subtle internal decisions like this. It makes
> > debugging much more difficult, when allocating dynamic sized variables.
> > When something works at one size but not the other.  
> 
> You know we already have kvmalloc()?

Yes, and the name suggests exactly what it does. It has both "k" and
"v" which tells me that if I use it it could be one or the other.

But a generic "malloc" or "free" that does things differently depending
on the size is a different story.

-- Steve
