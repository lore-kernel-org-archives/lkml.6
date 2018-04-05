Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbeDEWdr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 18:33:47 -0400
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:20526 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754094AbeDEWdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 18:33:46 -0400
Date: Fri, 6 Apr 2018 08:32:26 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: WARNING in up_write
Message-ID: <20180405223226.GA729@dastard>
References: <001a1148578c10e4700568e814eb@google.com>
 <CACT4Y+bL_+3ZJLE_1KzGNrz4hi=Si-KKsKLCd09TMD1Ux2jpgg@mail.gmail.com>
 <20180404193504.GA7715@bombadil.infradead.org>
 <20180405032200.GC22358@thunk.org>
 <20180405032454.GD9301@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405032454.GD9301@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 08:24:54PM -0700, Matthew Wilcox wrote:
> On Wed, Apr 04, 2018 at 11:22:00PM -0400, Theodore Y. Ts'o wrote:
> > On Wed, Apr 04, 2018 at 12:35:04PM -0700, Matthew Wilcox wrote:
> > > On Wed, Apr 04, 2018 at 09:24:05PM +0200, Dmitry Vyukov wrote:
> > > > On Tue, Apr 3, 2018 at 4:01 AM, syzbot
> > > > <syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com> wrote:
> > > > > DEBUG_LOCKS_WARN_ON(sem->owner != get_current())
> > > > > WARNING: CPU: 1 PID: 4441 at kernel/locking/rwsem.c:133 up_write+0x1cc/0x210
> > > > > kernel/locking/rwsem.c:133
> > > > > Kernel panic - not syncing: panic_on_warn set ...
> > > 
> > > Message-Id: <1522852646-2196-1-git-send-email-longman@redhat.com>
> > >
> > 
> > We were way ahead of syzbot in this case.  :-)
> 
> Not really ... syzbot caught it Monday evening ;-)

Rather than arguing over who reported it first, I think that time
would be better spent reflecting on why the syzbot report was
completely ignored until *after* Ted diagnosed the issue
independently and Waiman had already fixed it....

Clearly there is scope for improvement here.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
