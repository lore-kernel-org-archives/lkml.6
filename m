Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeBFPta (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751424AbeBFPtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:49:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B2E21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 6 Feb 2018 10:49:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] rcu: Transform kfree_rcu() into kvfree_rcu()
Message-ID: <20180206104919.0bc1734d@gandalf.local.home>
In-Reply-To: <52fe3917-cf72-d512-8422-d53bacf40113@virtuozzo.com>
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
        <151791238553.5994.4933976056810745303.stgit@localhost.localdomain>
        <20180206093451.0de5ceeb@gandalf.local.home>
        <52fe3917-cf72-d512-8422-d53bacf40113@virtuozzo.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018 18:06:33 +0300
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:


> There are kfree_rcu() and vfree_rcu() defined below, and they will give
> compilation error if someone tries to implement one more primitive with
> the same name.

Ah, I misread the patch. I was thinking you were simply replacing
kfree_rcu() with kvfree_rcu(), but now see the macros added below it.


> 
> We may add a comment, but I'm not sure it will be good if people will use
> unpaired brackets like:
> 
> 	obj = kmalloc(..)
> 	kvfree_rcu(obj,..)
> 
> after they read such a commentary that it works for both vmalloc and kmalloc.
> After this unpaired behavior distribute over the kernel, we won't be able
> to implement some debug on top of this defines (I'm not sure it will be really
> need in the future, but anyway).
> 
> Though, we may add a comment forcing use of paired bracket. Something like:
> 
> /**
>   * kvfree_rcu() - kvfree an object after a grace period.
>     This is a primitive for objects allocated via kvmalloc*() family primitives.
>     Do not use it to free kmalloc() and vmalloc() allocated objects, use kfree_rcu()
>     and vfree_rcu() wrappers instead.
> 
> How are you about this?

Never mind, I missed the adding of kfree_rcu() at the bottom, and was
thinking that we were just using kvfree_rcu() for everything.

That's what I get for looking at patches before my first cup of
coffee ;-)

If you want to add a comment, feel free, but taking a second look, I
don't feel it is necessary.

-- Steve
