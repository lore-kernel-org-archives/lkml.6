Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeDUKoO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 06:44:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:45290 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeDUKoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 06:44:12 -0400
Subject: Re: KASAN: use-after-free Read in alloc_pid
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot+7a1cff37dbbef9e7ba4c@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Cc: viro@ZenIV.linux.org.uk, akpm@linux-foundation.org,
        dhowells@redhat.com, ebiederm@xmission.com, ebiggers3@gmail.com,
        gs051095@gmail.com, ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        oleg@redhat.com, pasha.tatashin@oracle.com, riel@redhat.com,
        rppt@linux.vnet.ibm.com, wangkefeng.wang@huawei.com
References: <94eb2c06406c59cccc0568c527c2@google.com>
 <000000000000a45f6f05697f173b@google.com>
 <201804102333.BCC87582.MFHFOQFOOJLVtS@I-love.SAKURA.ne.jp>
Message-ID: <12b09710-ddc3-7948-b24e-487c514f028e@I-love.SAKURA.ne.jp>
Date: Sat, 21 Apr 2018 19:43:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201804102333.BCC87582.MFHFOQFOOJLVtS@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/04/10 23:33, Tetsuo Handa wrote:
> syzbot wrote:
>> syzbot has found reproducer for the following crash on upstream commit
>> c18bb396d3d261ebbb4efbc05129c5d354c541e4 (Tue Apr 10 00:04:10 2018 +0000)
>> Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
>> syzbot dashboard link:  
>> https://syzkaller.appspot.com/bug?extid=7a1cff37dbbef9e7ba4c
>>
> While we are waiting for
> 
>   rpc_pipefs: fix double-dput()
>   rpc_pipefs: deal with early sget() failures
>   kernfs: deal with early sget() failures
>   procfs: deal with early sget() failures
>   orangefs_kill_sb(): deal with allocation failures
>   nfsd_umount(): deal with early sget() failures
>   nfs: avoid double-free on early sget() failures
>   jffs2_kill_sb(): deal with failed allocations
>   hypfs_kill_super(): deal with failed allocations
> 
> in https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=for-linus ,
> I think the patch at
> 
>   WARNING in kill_block_super
>   https://syzkaller.appspot.com/bug?id=588996a25a2587be2e3a54e8646728fb9cae44e7
> 
> is better.
> 

OK. The patch was sent to linux.git as commit 8e04944f0ea8b838.

#syz fix: mm,vmscan: Allow preallocating memory for register_shrinker().
