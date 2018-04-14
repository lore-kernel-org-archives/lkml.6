Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbeDNHC2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 03:02:28 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:33079 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeDNHC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 03:02:27 -0400
Subject: Re: INFO: rcu detected stall in do_raw_spin_unlock
To: syzbot <syzbot+1218790c9dd8ec245b16@syzkaller.appspotmail.com>,
        viro@zeniv.linux.org.uk
References: <000000000000f3d5500569b5e84b@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Message-ID: <c1eaf369-ff58-fdb2-51d8-8f983f51e0b1@I-love.SAKURA.ne.jp>
Date: Sat, 14 Apr 2018 16:02:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <000000000000f3d5500569b5e84b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Infinite loop inside shrink_dcache_parent() due to lack of cond_resched().
I can reproduce this issue by running the reproducer on one CPU (using "taskset -c 0").
Reverting commit 32785c0539b7e96f ("fs/dcache.c: add cond_resched() in shrink_dentry_list()")
solves this issue.

#syz dup: INFO: rcu detected stall in d_walk
