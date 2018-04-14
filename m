Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbeDNHCi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 03:02:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:34962 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbeDNHCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 03:02:35 -0400
Subject: Re: INFO: rcu detected stall in shrink_dcache_parent
To: syzbot <syzbot+8e4a81166025b5b7fa66@syzkaller.appspotmail.com>,
        viro@zeniv.linux.org.uk
References: <000000000000f0c26d0569b5e8da@google.com>
 <0000000000009073b80569bd89a1@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <dc939a9c-80ef-ef8f-4e02-a46dbb736e89@I-love.SAKURA.ne.jp>
Date: Sat, 14 Apr 2018 16:02:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0000000000009073b80569bd89a1@google.com>
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
