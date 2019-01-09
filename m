Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F76BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AD8206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfAIWqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:46:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfAIWqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:46:07 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6732288308;
        Wed,  9 Jan 2019 22:46:06 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 259C31019633;
        Wed,  9 Jan 2019 22:46:04 +0000 (UTC)
Subject: Re: WARNING: locking bug in lock_downgrade
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        peterz@infradead.org, "mingo@redhat.com" <mingo@redhat.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        syzbot <syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@dominikbrodowski.net, mhocko@suse.com, rientjes@google.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        boqun.feng@gmail.com
References: <00000000000043ae20057b974f14@google.com>
 <f0acc6af-cdd5-0e46-bca5-2e2a9a4c983e@linux.alibaba.com>
 <69273d51-c129-6b0f-35eb-d98655476ff9@redhat.com>
 <d61e0a3e-a71e-9e42-7a56-d6fcfc0f6b63@I-love.SAKURA.ne.jp>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <864e2d6b-f471-cc04-311f-473da43b409a@redhat.com>
Date:   Wed, 9 Jan 2019 17:46:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d61e0a3e-a71e-9e42-7a56-d6fcfc0f6b63@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 09 Jan 2019 22:46:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2019 09:18 AM, Tetsuo Handa wrote:
> On 2018/12/14 4:46, Waiman Long wrote:
>> On 12/12/2018 08:14 PM, Yang Shi wrote:
>>> By looking into lockdep code, I'm not sure if lockdep may get confused
>>> by such sequence or not?
>>>
>>>
>>> Any hint is appreciated.
>>>
>>>
>>> Regards,
>>>
>>> Yang 
>> The warning was printed because hlock->read was set when doing the
>> downgrade_write(). So it is either downgrade_write() was called a second
>> time or a read lock was held originally. It is hard to tell what is the
>> root cause without a reproducer.
>>
>> Cheers,
>> Longman
>>
> Comparing with output from
>
>         struct rw_semaphore *sem = &current->mm->mmap_sem;
>
>         down_write(sem);
>         pr_warn("mmap_sem: count=%ld current=%px, owner=%px\n", atomic_long_read(&sem->count), current, READ_ONCE(sem->owner));
>         /* mmap_sem: count=-4294967295 current=ffff88813095ca80, owner=ffff88813095ca80 */
>         downgrade_write(sem);
>         pr_warn("mmap_sem: count=%ld current=%px, owner=%px\n", atomic_long_read(&sem->count), current, READ_ONCE(sem->owner));
>         /* mmap_sem: count=1 current=ffff88813095ca80, owner=ffff88813095ca83 */
>         up_read(sem);
>         pr_warn("mmap_sem: count=%ld current=%px, owner=%px\n", atomic_long_read(&sem->count), current, READ_ONCE(sem->owner));
>         /* mmap_sem: count=0 current=ffff88813095ca80, owner=0000000000000003 */

The behavior is correct. The current code will leave the reader task
structure pointer in owner even if it is a read lock. You have to look
at bit 0 to know if the owner is a reader or writer.

> what we got with debug printk() patch
>
>   https://syzkaller.appspot.com/text?tag=CrashLog&x=169dbb9b400000
>
>   [ 2580.337550][ T3645] mmap_sem: hlock->read=1 count=-4294967295 current=ffff888050e04140, owner=ffff888050e04140
>   [ 2580.353526][ T3645] ------------[ cut here ]------------
>   [ 2580.367859][ T3645] downgrading a read lock
>   [ 2580.367935][ T3645] WARNING: CPU: 1 PID: 3645 at kernel/locking/lockdep.c:3572 lock_downgrade+0x35d/0xbe0
>   [ 2580.382206][ T3645] Kernel panic - not syncing: panic_on_warn set ...
>
>   https://syzkaller.appspot.com/text?tag=CrashLog&x=1542da4f400000
>
>   [  386.342585][T16698] mmap_sem: hlock->read=1 count=-4294967295 current=ffff8880512ae180, owner=ffff8880512ae180
>   [  386.348586][T16698] ------------[ cut here ]------------
>   [  386.357203][T16698] downgrading a read lock
>   [  386.357294][T16698] WARNING: CPU: 1 PID: 16698 at kernel/locking/lockdep.c:3572 lock_downgrade+0x35d/0xbe0
>   [  386.372148][T16698] Kernel panic - not syncing: panic_on_warn set ...
>
> indicates that lockdep is saying that "current->mm->mmap_sem is held for read"
> while "struct rw_semaphore" is saying that "current->mm->mmap_sem is held for write".
> Something made lockdep confused. Possibly a lockdep bug.
>
It could be a bug in lockdep regarding downgrade. Someone else has
reported similar problem before.

-Longman

