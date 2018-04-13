Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeDMVPe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:15:34 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:47090 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDMVPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:15:32 -0400
X-Google-Smtp-Source: AIpwx4+HIL7SDacmDmpRlwLGesqh6LZ0nHNzlIZ6rcvUzZmIUq4lqfUuJiTW9Mav0B92pEFxp701wA==
Date: Fri, 13 Apr 2018 14:15:30 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Khazhismel Kumykov <khazhy@google.com>
cc: nborisov@suse.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>, Jeff Mahoney <jeffm@suse.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fs/dcache.c: re-add cond_resched() in
 shrink_dcache_parent()
In-Reply-To: <20180413202823.204377-1-khazhy@google.com>
Message-ID: <alpine.DEB.2.21.1804131415190.214710@chino.kir.corp.google.com>
References: <20180413181350.88831-1-khazhy@google.com> <20180413202823.204377-1-khazhy@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Apr 2018, Khazhismel Kumykov wrote:

> shrink_dcache_parent may spin waiting for a parallel shrink_dentry_list.
> In this case we may have 0 dentries to dispose, so we will never
> schedule out while waiting for the parallel shrink_dentry_list to
> complete.
> 
> Tested that this fixes syzbot reports of stalls in shrink_dcache_parent()
> 
> Fixes: 32785c0539b7 ("fs/dcache.c: add cond_resched() in shrink_dentry_list()")
> Reported-by: syzbot+ae80b790eb412884ca77@syzkaller.appspotmail.com
> 
> Cc: Nikolay Borisov <nborisov@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>
> Cc: Jeff Mahoney <jeffm@suse.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

Acked-by: David Rientjes <rientjes@google.com>
