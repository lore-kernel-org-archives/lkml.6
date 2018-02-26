Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeBZAQf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 19:16:35 -0500
Received: from koef.zs64.net ([212.12.50.230]:34337 "EHLO koef.zs64.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbeBZAQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 19:16:33 -0500
Date: Sun, 25 Feb 2018 19:00:48 -0500
From: Martin Cracauer <cracauer@cons.org>
To: linux-kernel@vger.kernel.org
Subject: userfaultfd(2) Write Protect / struct uffdio_writeprotect
Message-ID: <20180226000048.GA40481@cons.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi.

What is the status of the remaining work for userfaultfd(2), the write
protect support? I am talking about 'struct uffdio_writeprotect' and
friends.  This helps with my garbage collection work, and there are
virtual machine folks who want to use it for live migration.  Right
now I'm using a SIGSEGV handler, nobody wants that.

It is in the aa tree:
git://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git

I think I am missing the commits to master between Sept 7, 2017 and
Sept 20, 2017.  Merging from aa to mainline seems to have stopped at
that point.

Anybody knows what the merging status is? I have some free cycles at
this time, however it looks like I'll be taking a full-time job soon.
I'd love to see it in before I get distracted.

More detail:

The write support in userfaultfd(2) helps me with garbage collection.
I was waiting for it to show up in mainline while I was at Google, to
then change SBCL's GC for ITA's search engine QPX to it.  That never
happened before I left Google, and I cannot expect testers inside to
run a custom kernel for benchmarking my changes.  Tech info is here:

https://www.cons.org/cracauer/cracauer-userfaultfd.html

https://medium.com/@MartinCracauer/generational-garbage-collection-write-barriers-write-protection-and-userfaultfd-2-8b0e796b8f7f

I have not, but can, connect to various virtual machine people to find
out why they aren't complaining about the lack of this.  Maybe they
have an alternative that I could use as well?

Anybody else here who has a use case for this?

I'm happy to give more details.

Martin
-- 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Martin Cracauer <cracauer@cons.org>   http://www.cons.org/cracauer/
