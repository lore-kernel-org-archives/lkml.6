Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9309FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401CA208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSvhwcaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401CA208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965093AbeFNXOg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:14:36 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43342 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964948AbeFNXOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:14:35 -0400
Received: by mail-pg0-f67.google.com with SMTP id a14-v6so3583109pgw.10;
        Thu, 14 Jun 2018 16:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O0a5a+NrRphdLyHsmzCx9LGSyODcgS3E5WSqyZ+Xtcg=;
        b=eSvhwcajbZH1dTzbH00LEobmU3xkTvbXjwXXiTnblRYHN35GD1DnmTRTvxcG5TT3+I
         6RuJt6vBwM6SNErVrpJUc6yNt7mi7jQD5FJYD9rh7CziiVkgDvWNB8rV/HyvOioV4EPf
         KOt6Mx8W/eYGVs3xT4FuRThUS1+Umih2eU9pBpAFbw4ZkXnNJN6Y8itK6t/w8zWrEJns
         NM8fiM00pvjbWBFNk4OKRW8j8H1NMOw6NOg0eA/vvoqFTEoq8BSdZlTBDsW3s2ddD5RZ
         yknPSdXN5OfbHlgejDiuWV11iHOOufeoJSW+LnuBNTLuWdue9ZKbipj8uAPUd0FNlny6
         ZcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O0a5a+NrRphdLyHsmzCx9LGSyODcgS3E5WSqyZ+Xtcg=;
        b=iPiv78uoBuP2u1YfxzrR6E09cuWVxBm+H/i5NQsxCtOW8JTw3lb+zJhG2gKLv3DPgM
         RZVBVNc0nonh4H3+RRY/i0/C7MyAwvdNie3T3iIfmFPglA1WZPZLVhfU3u7xV537SHiZ
         sp91tf+J0BbR05NTR53sri+3P0IxN3Zvw7FDT9LfPj6MPtKFgcW1K4waWOzc9eEgUeA6
         6VTZD2pFS32HyJGImzake2F85DQX76rme/PC+ZuIoD3aPvZ2cgGYmvp13iAi0BPj/SiE
         RHkLsa+nnjjX2YtVYXXsr4z8xmwqvriAjOeTzz8SVqIEKVMyfhJTJ+LTlVb/3IRRVXTl
         CWGQ==
X-Gm-Message-State: APt69E1LCrDpGI0W6dZGUwTTxyeZf4s6Qb0cWsxwObS9KATV7Kd+erhV
        lRoXVcxflGx59JuYWgi72QV0lxB8QzjdgvZcU8i8RYC/
X-Google-Smtp-Source: ADUXVKK8CA6ROiUGLFZThwPUv4J4vPUjRkBVVQTYcTJXuAF39Mbr/OjSqRKOSfupd5t5AScVJS4z3DBha3FUA4REeU8=
X-Received: by 2002:a65:42c2:: with SMTP id l2-v6mr3948522pgp.237.1529018074484;
 Thu, 14 Jun 2018 16:14:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:284f:0:0:0:0 with HTTP; Thu, 14 Jun 2018 16:14:13
 -0700 (PDT)
In-Reply-To: <20180614172441.GE24762@mellanox.com>
References: <20180613234947.15767-1-xiyou.wangcong@gmail.com>
 <20180614053446.GB18426@mtr-leonro.mtl.com> <CAM_iQpXxHk+yFqqK-Hezsc83_mKfbUXr4=jjNnik5DwGscRKUA@mail.gmail.com>
 <20180614070108.GD18426@mtr-leonro.mtl.com> <20180614142448.GC24762@mellanox.com>
 <CAM_iQpWz9b01ksW_OUHgr1=pf-bNsq_TxoNCQxuDdhUXfvoyOQ@mail.gmail.com> <20180614172441.GE24762@mellanox.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 14 Jun 2018 16:14:13 -0700
Message-ID: <CAM_iQpXFmqcCQWkyGPmev5LrPpDoEc=wpXQVDWJx2UQWPhwb2g@mail.gmail.com>
Subject: Re: [PATCH] infiniband: fix a subtle race condition
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 10:24 AM, Jason Gunthorpe <jgg@mellanox.com> wrote:
> On Thu, Jun 14, 2018 at 10:03:09AM -0700, Cong Wang wrote:
>> On Thu, Jun 14, 2018 at 7:24 AM, Jason Gunthorpe <jgg@mellanox.com> wrote:
>> >
>> > This was my brief reaction too, this code path almost certainly has a
>> > use-after-free, and we should fix the concurrency between the two
>> > places in some correct way..
>>
>> First of all, why use-after-free could trigger an imbalance unlock?
>> IOW, why do we have to solve use-after-free to fix this imbalance
>> unlock?
>
> The issue syzkaller hit is that accessing ctx->file does not seem
> locked in any way and can race with other manipulations of ctx->file.
>
> So.. for this patch to be correct we need to understand how this
> statement:
>
>    f = ctx->file
>
> Avoids f becoming a dangling pointer - and without locking, my


It doesn't, because this is not the point, this is not the cause
of the unlock imbalance either. syzbot didn't report use-after-free
or a kernel segfault here.


> suspicion is that it doesn't - because missing locking around
> ctx->file is probably the actual bug syzkaller found.

Does my patch make it lockless or dangling? Apparently no.

Before my patch:

        mutex_lock(&ctx->file->mut);

After my patch:

        cur_file = ctx->file;
        mutex_lock(&cur_file->mut);

The deference is same as before, it was lockless and it is lockless
after my patch.

Look at the assembly code *without* my patch:

ffffffff819354f0:       49 8b 7c 24 78          mov    0x78(%r12),%rdi
ffffffff819354f5:       48 89 c3                mov    %rax,%rbx
ffffffff819354f8:       31 f6                   xor    %esi,%esi
ffffffff819354fa:       e8 d8 dd 40 00          callq
ffffffff81d432d7 <mutex_lock_nested>

Apparently the pointer is dereferenced before lock.

What difference does my patch make?

ffffffff819354f2:       4d 8b 74 24 78          mov    0x78(%r12),%r14
ffffffff819354f7:       48 89 c3                mov    %rax,%rbx
ffffffff819354fa:       31 f6                   xor    %esi,%esi
ffffffff819354fc:       4c 89 f7                mov    %r14,%rdi
ffffffff819354ff:       e8 9b df 40 00          callq
ffffffff81d4349f <mutex_lock_nested>
...
ffffffff8193567d:       4c 89 f7                mov    %r14,%rdi
ffffffff81935680:       e8 98 dd 40 00          callq
ffffffff81d4341d <mutex_unlock>


The %r14 here is the whole point of my patch.


>
> If this is not the case, then add a comment explaining how f's
> lifetime is OK.
>
> Otherwise, we need some kind of locking and guessing we need to hold a
> kref for f?


I agree with you, but again, this is not necessary for unlock
imbalance.


>
>> Third of all, the use-after-free I can see (race with ->close) exists
>> before my patch, this patch doesn't make it better or worse, nor
>> I have any intend to fix it.
>
> I'm not sure that race exists, there should be something that flushes
> the WQ on the path to close... (though I have another email that
> perhaps that is broken, sigh)
>

This is not related to my patch, but to convince you, let me explain:

struct ucma_file is not refcnt'ed, I know you cancel the work in
rdma_destroy_id(), but after ucma_migrate_id() the ctx has already
been moved to the new file, for the old file, it won't cancel the
ctx flying with workqueue. So, I think the following use-after-free
could happen:


ucma_event_handler():
cur_file = ctx->file; // old file

ucma_migrate_id():
lock();
list_move_tail(&ctx->list, &new_file->ctx_list);
ctx->file = new_file;
unlock();

ucma_close():
// retrieve old file via filp->private_data
// the loop won't cover the ctx moved to the new_file
kfree(file);

ucma_event_handler():
// continued from above
lock(&cur_file->mux); // already freed!


This is _not_ the cause of the unlock imbalance, and is _not_ expected
to solve by patch either.
