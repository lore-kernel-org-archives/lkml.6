Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeDJVB2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 17:01:28 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50805 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDJVB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 17:01:26 -0400
To: ebiederm@xmission.com
Cc: syzbot+9369930ca44f29e60e2d@syzkaller.appspotmail.com,
        serge@hallyn.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org
Subject: Re: KASAN: null-ptr-deref Read in xattr_getsecurity
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <0000000000008d2e0d05697a693d@google.com>
        <9d192497-8b1e-ca8d-0ed8-b3324ee1e361@I-love.SAKURA.ne.jp>
        <87o9irw2ad.fsf@xmission.com>
In-Reply-To: <87o9irw2ad.fsf@xmission.com>
Message-Id: <201804110600.CCF73450.FFOOQtSFOLHMVJ@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Wed, 11 Apr 2018 06:00:44 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:
> 
> > From 904d07a6eb014f3df0c5a1ebfcfd4323276a9a76 Mon Sep 17 00:00:00 2001
> > From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Date: Tue, 10 Apr 2018 15:15:16 +0900
> > Subject: [PATCH] commoncap: Handle memory allocation failure.
> >
> > syzbot is reporting NULL pointer dereference at xattr_getsecurity() [1],
> > for cap_inode_getsecurity() is returning sizeof(struct vfs_cap_data) when
> > memory allocation failed. Return -ENOMEM if memory allocation failed.
> >
> > [1] https://syzkaller.appspot.com/bug?id=a55ba438506fe68649a5f50d2d82d56b365e0107
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Tetsuo I can pick this up, or do you have preferred path for getting
> this change merged?

I don't have preferred path. You can pick this up. Thanks.
