Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeBBEug (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 23:50:36 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47284 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeBBEu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 23:50:29 -0500
Date: Fri, 2 Feb 2018 04:50:20 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: syzbot <syzbot+bacbe5d8791f30c9cee5@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, aneesh.kumar@linux.vnet.ibm.com,
        dan.j.williams@intel.com, james.morse@arm.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in get_user_pages_unlocked
Message-ID: <20180202045020.GF30522@ZenIV.linux.org.uk>
References: <001a113f6344393d89056430347d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113f6344393d89056430347d@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 04:58:00PM -0800, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> 7109a04eae81c41ed529da9f3c48c3655ccea741 (Thu Feb 1 17:37:30 2018 +0000)
> Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide
> 
> So far this crash happened 2 times on upstream.
> C reproducer is attached.

Umm...  How reproducible that is?

> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.

Can't reproduce with gcc 5.4.1 (same .config, same C reproducer).

It looks like __get_user_pages_locked() returning with *locked zeroed,
but ->mmap_sem not dropped.  I don't see what could've lead to it and
attempts to reproduce had not succeeded so far...

How long does it normally take for lockdep splat to trigger?
