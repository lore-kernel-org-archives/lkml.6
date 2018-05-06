Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeEFCYe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 22:24:34 -0400
Received: from imap.thunk.org ([74.207.234.97]:43318 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751832AbeEFCYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 22:24:31 -0400
Date: Sat, 5 May 2018 22:24:28 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: syzbot <syzbot+a9a45987b8b2daabdc88@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller@googlegroups.com
Subject: Re: kernel panic: EXT4-fs (device loop0): panic forced after error
Message-ID: <20180506022428.GQ29205@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        syzbot <syzbot+a9a45987b8b2daabdc88@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller@googlegroups.com
References: <000000000000019f50056b7f0890@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000019f50056b7f0890@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 05:57:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> EXT4-fs error (device loop0): ext4_iget:4756: inode #2: comm
> syz-executor909: root inode unallocated
> Kernel panic - not syncing: EXT4-fs (device loop0): panic forced after error

I don't get why syzbot considers this a bug.  It created a corrupted
file system, mounted it as root, and said file system had the flag
which says, "panic if you find a file system corruption".

In what world is this a security bug?  There's a *reason* why I've
always said people who want to containers to be allowed to mount
arbitrary file systems controlled by potentially malicious container
users are insane....

I could mark this as a one-off invalid bug, but if syzkaller is going
to be generating classes of corrupted file systems like this, and are
going to be complaing about how this causes the kernel to crash, then
we have a fundamental syzkaller BUG.

					- Ted
