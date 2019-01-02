Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451B1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19791218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfABMJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 07:09:14 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:50151 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbfABMJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 07:09:13 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x02C8tJ9068966;
        Wed, 2 Jan 2019 21:08:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Wed, 02 Jan 2019 21:08:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x02C8t6h068962
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 2 Jan 2019 21:08:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: WARNING: lock held when returning to user space in grab_super
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan@huawei.com>
References: <000000000000638c1b057e787822@google.com>
Cc:     syzbot <syzbot+87b93137e0280beaeba1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <a6e8d929-3765-ad70-0f7c-942b68d7b25c@I-love.SAKURA.ne.jp>
Date:   Wed, 2 Jan 2019 21:08:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <000000000000638c1b057e787822@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Tejun.

[ 1100.561812] FAULT_INJECTION: forcing a failure.
[ 1100.561812] name failslab, interval 1, probability 0, space 0, times 0
[ 1100.625231] CPU: 1 PID: 29677 Comm: syz-executor0 Not tainted 4.20.0+ #396
[ 1100.632289] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[ 1100.641646] Call Trace:
[ 1100.644355]  dump_stack+0x1d3/0x2c6
[ 1100.662152]  should_fail.cold.4+0xa/0x17
[ 1100.709512]  __should_failslab+0x124/0x180
[ 1100.713784]  should_failslab+0x9/0x14
[ 1100.717604]  kmem_cache_alloc+0x2c4/0x730
[ 1100.721784]  __d_alloc+0xc8/0xb90
[ 1100.755462]  d_alloc+0x96/0x380
[ 1100.775659]  d_alloc_parallel+0x15a/0x1f40
[ 1100.852877]  __lookup_slow+0x1e6/0x540
[ 1100.864887]  lookup_slow+0x57/0x80
[ 1100.868448]  lookup_one_len_unlocked+0xf1/0x100
[ 1100.876873]  kernfs_node_dentry+0x1c7/0x2d0
[ 1100.881215]  cgroup_do_mount+0x1b1/0x330
[ 1100.899627]  cgroup_mount+0xb6d/0xd30
[ 1100.937317]  mount_fs+0xae/0x31d
[ 1100.940710]  vfs_kern_mount.part.35+0xdc/0x4f0
[ 1100.957015]  do_mount+0x581/0x31f0
[ 1100.998447]  ksys_mount+0x12d/0x140
[ 1101.002098]  __x64_sys_mount+0xbe/0x150
[ 1101.006095]  do_syscall_64+0x1b9/0x820

[ 1101.127520] WARNING: lock held when returning to user space!
[ 1101.133310] 4.20.0+ #396 Not tainted
[ 1101.137004] ------------------------------------------------
[ 1101.142780] syz-executor0/29677 is leaving the kernel with locks still held!
[ 1101.149944] 1 lock held by syz-executor0/29677:
[ 1101.154599]  #0: 00000000ec5f6915 (&type->s_umount_key#43){++++}, at: grab_super+0xcc/0x400

According to commit 633feee310de6b6c ("cgroup: refactor mount path and
clearly distinguish v1 and v2 paths"), cgroup_do_mount() is failing to
do full teardown steps for kernfs_mount() (deactivate_locked_super() ?)
when kernfs_node_dentry() failed.

+       if (!IS_ERR(dentry) && ns != &init_cgroup_ns) {
+               struct dentry *nsdentry;
+               struct cgroup *cgrp;

-       if (is_v2) {
-               if (data) {
-                       pr_err("cgroup2: unknown option \"%s\"\n", (char *)data);
-                       put_cgroup_ns(ns);
-                       return ERR_PTR(-EINVAL);
-               }
-               cgrp_dfl_visible = true;
-               root = &cgrp_dfl_root;
-               cgroup_get(&root->cgrp);
-               goto out_mount;
+               mutex_lock(&cgroup_mutex);
+               spin_lock_irq(&css_set_lock);
+
+               cgrp = cset_cgroup_from_root(ns->root_cset, root);
+
+               spin_unlock_irq(&css_set_lock);
+               mutex_unlock(&cgroup_mutex);
+
+               nsdentry = kernfs_node_dentry(cgrp->kn, dentry->d_sb);
+               dput(dentry);
+               dentry = nsdentry;
        }

+       if (IS_ERR(dentry) || !new_sb)
+               cgroup_put(&root->cgrp);
+
+       return dentry;
+}

