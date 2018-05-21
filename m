Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeEUMuF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:50:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:55431 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbeEUMuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:50:03 -0400
Date: Mon, 21 May 2018 14:50:00 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+9a44753ac327c557796a@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: WARNING in ext4_set_page_dirty
Message-ID: <20180521125000.hlgdsvlzlr7xw3bx@quack2.suse.cz>
References: <089e0825cec8180a2b0568c4ee1d@google.com>
 <0000000000003a8d73056cb11ca3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003a8d73056cb11ca3@google.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 20-05-18 23:07:02, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    771c577c23ba Linux 4.17-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=108c9f37800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
> dashboard link: https://syzkaller.appspot.com/bug?extid=9a44753ac327c557796a
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1655584f800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15134357800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9a44753ac327c557796a@syzkaller.appspotmail.com
> 
> WARNING: CPU: 0 PID: 4577 at fs/ext4/inode.c:3894
> ext4_set_page_dirty+0x28d/0x330 fs/ext4/inode.c:3894
> Kernel panic - not syncing: panic_on_warn set ...

Looking at the reproducer, this is the issue we have been speaking about at
LSF/MM - direct IO read dirties pages after writeback has written them out
and so we don't expect them to be dirtied. If someone told me I would not
believe this is possible to hit by fuzzing ;) Good job from the syzkaller
guys!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
