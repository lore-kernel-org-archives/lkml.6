Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uHVuCaWmGFvsfAAAmS7hNA
	; Thu, 07 Jun 2018 03:29:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0BB58607F7; Thu,  7 Jun 2018 03:29:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOKuGcYW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7895060115;
	Thu,  7 Jun 2018 03:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7895060115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753607AbeFGD3i (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 23:29:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42528 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752566AbeFGD3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 23:29:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id w10-v6so8351926wrk.9;
        Wed, 06 Jun 2018 20:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u5pd3GnSyv3gQQFQNCkgvMQ1hlaCAMNj24UkWSKZhcY=;
        b=sOKuGcYWCA1bjZoBdcwIrLTs5+aywZxg6sshq/anUvefxrid3yfJDGnxc4hUvmPblU
         C3+6OgokE2fC1ZQVtqPrcTa2Dk3kTndheREvcsDdrs3Ojo5LZNNvZaSm1Id3bHJZ+OUf
         lAx8Ffpvjv22/gtmtyBC8Pl46jbwYtOClc1GHqp6+vdAcSk9z4/d0RD+64cGXEzjIYHT
         tFOctwcrE7FIViUBXQxDonQOBDVxBxpfO7fmeDCtgIALjl744O8rUWuBc5znfmB8RU0n
         +jq3AJN5Ii0P9fQkZocmWU0gWeje0Ec4Zz+ZYWXODB/dhbvxocsrTegXx1q5n1OrLNe6
         UX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u5pd3GnSyv3gQQFQNCkgvMQ1hlaCAMNj24UkWSKZhcY=;
        b=QWFZm7yaPF5A7XFjjz+cDVqqlrhsdg1qF4K1AuW1t9/Hq/u5PXikbwG5Vm2Un1Op2b
         9PaEnmyvmONLQ96aJZWDeMQQ57vetH2zGaRe69douG/VWeDU1Kxb6OFKnJWEBUTn90f5
         dgqkzSI4JS2860u/HkJLS33mKAAh6REIcb5xcjYA3k3KVrNYjpmHp252NFu7kfJCHOBO
         jktpgXllHx9Tpj/Im5wtIUTO1aFstWnOpdPHDT2RwlEiupLIKoYehqd5Fwdlx9ngHw1Q
         wH26fgVB0GYf4wBqUcH8kxlY6LnalNTovs3xRvQgK93fTM1Mo+Z6ATOgbRIIXj6S3F4s
         3ppA==
X-Gm-Message-State: APt69E2f3mGXFJydoSzG1MknF13SanEH0N+vhyt9SOr9jMOBVXHEaSJ2
        WR1DYuzUNwDbixOa+5qMYZQaHZBcpmaCLxv/R1g=
X-Google-Smtp-Source: ADUXVKL1mC4iYNYCTjytlAaV8eEYbfwLCOSvQAIh1uSU5XgBkUd1cUyKrZpTYHsd2T64ku4ALLFIFD6RL0nPVD3gf+c=
X-Received: by 2002:adf:c7c3:: with SMTP id y3-v6mr95307wrg.230.1528342173932;
 Wed, 06 Jun 2018 20:29:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:97c5:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 20:29:32 -0700 (PDT)
In-Reply-To: <20180605004128.GA28826@ming.t460p>
References: <25708e84-6f35-04c3-a2e4-6854f0ed9e78@I-love.SAKURA.ne.jp>
 <dc9862c7-ec16-8b11-04e4-422b435d41ef@kernel.dk> <201806050027.w550RfJl010157@www262.sakura.ne.jp>
 <20180605004128.GA28826@ming.t460p>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 7 Jun 2018 11:29:32 +0800
Message-ID: <CACVXFVNcJ+tC6RUT+JUA3iw+STB+q4P_u+AvoOSrt04zEw8TZA@mail.gmail.com>
Subject: Re: INFO: task hung in blk_queue_enter
To: Ming Lei <ming.lei@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        alan.christopher.jenkins@gmail.com,
        syzbot+c4f9cebf9d651f6e54de@syzkaller.appspotmail.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "=Oleksandr Natalenko" <oleksandr@natalenko.name>,
        martin@lichtvoll.de, Hannes Reinecke <hare@suse.com>,
        syzkaller-bugs@googlegroups.com,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 8:41 AM, Ming Lei <ming.lei@redhat.com> wrote:
> On Tue, Jun 05, 2018 at 09:27:41AM +0900, Tetsuo Handa wrote:
>> Jens Axboe wrote:
>> > On 6/1/18 4:10 AM, Tetsuo Handa wrote:
>> > > Tetsuo Handa wrote:
>> > >> Since sum of percpu_count did not change after percpu_ref_kill(), this is
>> > >> not a race condition while folding percpu counter values into atomic counter
>> > >> value. That is, for some reason, someone who is responsible for calling
>> > >> percpu_ref_put(&q->q_usage_counter) (presumably via blk_queue_exit()) is
>> > >> unable to call percpu_ref_put().
>> > >> But I don't know how to find someone who is failing to call percpu_ref_put()...
>> > >
>> > > I found the someone. It was already there in the backtrace...
>> > >
>> >
>> > Ahh, nicely spotted! One idea would be the one below. For this case,
>> > we're recursing, so we can either do a non-block queue enter, or we
>> > can just do a live enter.
>> >
>>
>> While "block: don't use blocking queue entered for recursive bio submits" was
>> already applied, syzbot is still reporting a hung task with same signature but
>> different trace.
>>
>> https://syzkaller.appspot.com/text?tag=CrashLog&x=1432cedf800000
>> ----------------------------------------
>> [  492.512243] INFO: task syz-executor1:20263 blocked for more than 120 seconds.
>> [  492.519604]       Not tainted 4.17.0+ #83
>> [  492.523793] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  492.531787] syz-executor1   D23384 20263   4574 0x00000004
>> [  492.537443] Call Trace:
>> [  492.540041]  __schedule+0x801/0x1e30
>> [  492.580958]  schedule+0xef/0x430
>> [  492.610154]  blk_queue_enter+0x8da/0xdf0
>> [  492.716327]  generic_make_request+0x651/0x1790
>> [  492.765680]  submit_bio+0xba/0x460
>> [  492.793198]  submit_bio_wait+0x134/0x1e0
>> [  492.801891]  blkdev_issue_flush+0x204/0x300
>> [  492.806236]  blkdev_fsync+0x93/0xd0
>> [  492.813620]  vfs_fsync_range+0x140/0x220
>> [  492.817702]  vfs_fsync+0x29/0x30
>> [  492.821081]  __loop_update_dio+0x4de/0x6a0
>> [  492.825341]  lo_ioctl+0xd28/0x2190
>> [  492.833442]  blkdev_ioctl+0x9b6/0x2020
>> [  492.872146]  block_ioctl+0xee/0x130
>> [  492.880139]  do_vfs_ioctl+0x1cf/0x16a0
>> [  492.927550]  ksys_ioctl+0xa9/0xd0
>> [  492.931036]  __x64_sys_ioctl+0x73/0xb0
>> [  492.934952]  do_syscall_64+0x1b1/0x800
>> [  492.963624]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> [  493.212768] 1 lock held by syz-executor1/20263:
>> [  493.217448]  #0: 00000000956bf5a3 (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2190
>> ----------------------------------------
>>
>> Is it OK to call [__]loop_update_dio() between blk_mq_freeze_queue() and
>> blk_mq_unfreeze_queue(), for vfs_fsync() from __loop_update_dio() is calling
>> blk_queue_enter() after blk_mq_freeze_queue() started blocking blk_queue_enter()
>> by caling atomic_inc_return() and percpu_ref_kill() ?
>>
>
> The vfs_fsync() isn't necessary in loop_update_dio() since both
> generic_file_write_iter() and generic_file_read_iter() can handle
> buffered io vs dio well.
>
> I will send one patch to remove the vfs_sync() later.

Hi Tetsuo,

The issue might be fixed by removing this vfs_sync(), but I'd like to
understand the idea behind since vfs_sync() shouldn't have caused
any IO to this loop queue.

I also tried to do the test via the following c syzbot, but can't reproduce
it yet after running it for several hours.

https://syzkaller.appspot.com/x/repro.c?id=4727023951937536

Could you share us how you reproduce it?

Thanks,
Ming Lei
