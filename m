Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4041C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28276213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28276213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJJEiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:38:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:17964 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeJJEiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:38:12 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w99LJJAc059072;
        Wed, 10 Oct 2018 06:19:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Wed, 10 Oct 2018 06:19:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w99LJEYw059053
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 10 Oct 2018 06:19:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180928090939.GE1160@jagdpanzerIV>
 <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
 <20180929105151.GA1392@tigerII.localdomain>
 <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
 <20181001023721.GA6409@jagdpanzerIV>
 <880ef52f-dff7-af91-5353-f63513265ffe@i-love.sakura.ne.jp>
 <20181002063851.GF598@jagdpanzerIV>
 <5a958a1b-a986-014a-5908-816e0a3ef4ff@i-love.sakura.ne.jp>
 <20181008160310.ldwryudzkvp5de3b@pathway.suse.cz>
 <3ce1695b-9c47-40cc-602b-7c5ffb593024@i-love.sakura.ne.jp>
 <20181009145229.3lv5vl2ypz5i45cq@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a4a2ecae-3c47-db1f-8124-4d2d0ab8b91c@i-love.sakura.ne.jp>
Date:   Wed, 10 Oct 2018 06:19:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009145229.3lv5vl2ypz5i45cq@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/09 23:52, Petr Mladek wrote:
> On Tue 2018-10-09 05:48:33, Tetsuo Handa wrote:
>> On 2018/10/09 1:03, Petr Mladek wrote:
>>> On Mon 2018-10-08 19:31:58, Tetsuo Handa wrote:
>>>>   A structure named "struct printk_buffer" is introduced for buffering
>>>>   up to LOG_LINE_MAX bytes of printk() output which did not end with '\n'.
>>>>
>>>>   A caller is allowed to allocate/free "struct printk_buffer" using
>>>>   kzalloc()/kfree() if that caller is in a location where it is possible
>>>>   to do so.
>>>>
>>>>   A macro named "DEFINE_PRINTK_BUFFER()" is defined for allocating
>>>>   "struct printk_buffer" from the stack memory or in the .bss section.
>>>>
>>>>   But since sizeof("struct printk_buffer") is nearly 1KB, it might not be
>>>>   preferable to allocate "struct printk_buffer" from the stack memory.
>>>>   In that case, a caller can use best-effort buffering mode. Two functions
>>>>   get_printk_buffer() and put_printk_buffer() are provided for that mode.
>>>>
>>>>   get_printk_buffer() tries to assign a "struct printk_buffer" from
>>>>   statically preallocated array. It returns NULL if all static
>>>>   "struct printk_buffer" are in use.
>>>>
>>>>   put_printk_buffer() flushes and releases the "struct printk_buffer".
>>>>   put_printk_buffer() must match corresponding get_printk_buffer() as with
>>>>   rcu_read_unlock() must match corresponding rcu_read_lock().
>>>
>>> One problem with this API is when it is used in more complicated code
>>> and put_printk_buffer() is not called in some path. I mean leaking.
>>> We might get out of buffers easily.
>>
>> Then, as an debugging config option for statically preallocated buffers,
>> we could record how get_printk_buffer() was called, like lockdep records
>> where a lock was taken.
> 
> Another solution might be to store some timestamp (jiffies?) into
> struct printk_buffer when a new message is added. Then we could flush
> stalled buffers in get_printk_buffer() with some warning.

I don't think it will work. What the threshold should be? It is possible that
a thread spends very long time (many seconds for e.g. SysRq-t) between
get_printk_buffer() and put_printk_buffer(). Therefore, the threshold will
have to be very very long. As soon as we reach out of statically preallocated
buffers, we need to fallback to unbuffered printk() before such threshold
elapses.

> 
> Unfortunately, it might be unsafe to put the stalled buffers.
> Well, it might be safe if there is a lock less access. I wonder
> if we could reuse the printk_safe code here.
> 
> Anyway, I would like to have a solution before we add the new
> API into the kernel. We would need it sooner or later anyway.
> And I would like to be sure that the API is sane.

If we worry about get_printk_buffer() without corresponding put_printk_buffer(),
we will also need to worry about a "struct printk_buffer" returned by
get_printk_buffer() is by error shared by multiple threads. We will have to
complicate buffered_printk() by using cmpxchg() & retry logic, but the output is
after all mixed as with simply fallback to unbuffered printk() does.

Do you think that adding cmpxchg() & retry logic to this API generates better
result than simple fallback? buffered_printk() does not add a new locking dependency
is a good point of this API. Showing the backtrace (by enabling a debug kernel config
option for this API) will be sufficient.

