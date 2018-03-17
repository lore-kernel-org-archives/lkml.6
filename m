Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeCQAVc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 20:21:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37734 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeCQAVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 20:21:30 -0400
Date: Sat, 17 Mar 2018 00:21:14 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: syzbot <syzbot+36712f50b0552615bf59@syzkaller.appspotmail.com>
Cc: dasaratharaman.chandramouli@intel.com, dledford@redhat.com,
        ira.weiny@intel.com, jgg@ziepe.ca, leonro@mellanox.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in ucma_connect
Message-ID: <20180317002114.GL30522@ZenIV.linux.org.uk>
References: <f4f5e80792347b0aa7056790643c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f5e80792347b0aa7056790643c@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 04:59:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> e2c15aff5f353ba80bd3bb49840837f65fa5cc43 (Thu Mar 15 18:07:35 2018 +0000)
> Merge tag 'sound-4.16-rc6' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> 
> So far this crash happened 2 times on upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.

May I politely inquire why am I getting Cc on the slew of ucma reports?
My last involvement with that thing that wouldn't have been absolutely
trivial had been back in 2012, and even that had been a conversion of
fget() to fdget() - nowhere near the areas implicated by those.  Anything
more recent would have no impact on the object code - replacement of
POLL{IN,RDNORM} with EPOLL{IN,RDNORM} (equal values on x86) and two
replacements of unsigned int with __poll_t, which is typedefed to
unsigned.

It's not that I've objections against helping to debug that thing (other
than general aversion to drivers/infinibarf), but I'm really curious -
just what got me volunteered from the syzbot POV?

Al, digging through tons of unpleasant code in fs/{config,debug}fs
at the moment...
