Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeDKBio (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 21:38:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45472 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeDKBim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 21:38:42 -0400
Date: Wed, 11 Apr 2018 02:38:37 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-mm <linux-mm@kvack.org>, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+5a170e19c963a2e0df79@syzkaller.appspotmail.com>
Subject: Re: Re: WARNING in kill_block_super
Message-ID: <20180411013836.GO30522@ZenIV.linux.org.uk>
References: <6c95e826-4b9f-fb21-b311-830411e58480@I-love.SAKURA.ne.jp>
 <20180411005938.GN30522@ZenIV.linux.org.uk>
 <201804110128.w3B1S6M6092645@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804110128.w3B1S6M6092645@www262.sakura.ne.jp>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 10:28:06AM +0900, Tetsuo Handa wrote:
> Al Viro wrote:
> > On Wed, Apr 04, 2018 at 07:53:07PM +0900, Tetsuo Handa wrote:
> > > Al and Michal, are you OK with this patch?
> > 
> > First of all, it does *NOT* fix the problems with careless ->kill_sb().
> > The fuse-blk case is the only real rationale so far.  Said that,
> > 
> 
> Please notice below one as well. Fixing all careless ->kill_sb() will be too
> difficult to backport. For now, avoid calling deactivate_locked_super() is
> safer.

How will that fix e.g. jffs2?

> [upstream] WARNING: refcount bug in put_pid_ns
> https://syzkaller.appspot.com/bug?id=17e202b4794da213570ba33ac2f70277ef1ce015

Should be fixed by 8e666cb33597 in that series, AFAICS.
