Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754174AbeDJOeq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:34:46 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:13700 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753258AbeDJOep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:34:45 -0400
To: viro@ZenIV.linux.org.uk
Cc: syzbot+7a1cff37dbbef9e7ba4c@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, dhowells@redhat.com, ebiederm@xmission.com,
        ebiggers3@gmail.com, gs051095@gmail.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        pasha.tatashin@oracle.com, riel@redhat.com, rppt@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, wangkefeng.wang@huawei.com
Subject: Re: KASAN: use-after-free Read in alloc_pid
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <94eb2c06406c59cccc0568c527c2@google.com>
        <000000000000a45f6f05697f173b@google.com>
In-Reply-To: <000000000000a45f6f05697f173b@google.com>
Message-Id: <201804102333.BCC87582.MFHFOQFOOJLVtS@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Tue, 10 Apr 2018 23:33:41 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot wrote:
> syzbot has found reproducer for the following crash on upstream commit
> c18bb396d3d261ebbb4efbc05129c5d354c541e4 (Tue Apr 10 00:04:10 2018 +0000)
> Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
> syzbot dashboard link:  
> https://syzkaller.appspot.com/bug?extid=7a1cff37dbbef9e7ba4c
> 
While we are waiting for

  rpc_pipefs: fix double-dput()
  rpc_pipefs: deal with early sget() failures
  kernfs: deal with early sget() failures
  procfs: deal with early sget() failures
  orangefs_kill_sb(): deal with allocation failures
  nfsd_umount(): deal with early sget() failures
  nfs: avoid double-free on early sget() failures
  jffs2_kill_sb(): deal with failed allocations
  hypfs_kill_super(): deal with failed allocations

in https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=for-linus ,
I think the patch at

  WARNING in kill_block_super
  https://syzkaller.appspot.com/bug?id=588996a25a2587be2e3a54e8646728fb9cae44e7

is better.
