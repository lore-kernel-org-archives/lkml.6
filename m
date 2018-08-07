Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D6EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C878C2174B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vUaHCvCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C878C2174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389527AbeHGQoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:44:23 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33119 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388135AbeHGQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:44:23 -0400
Received: by mail-io0-f196.google.com with SMTP id z20-v6so14181067iol.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MtqP3cvkF6xw2x6kLUXAhugtSQrzwzYnq0/e1Emmf0o=;
        b=vUaHCvCvq6mQMg2+IkSWtZL225uPzRhxJgNTISf7kMVN3F7yssZ85luzCgG6FK2yuz
         Uq2zo3JrBC8AQQ4IfEXyyerPoxwmmbWUR8ZHqa7em/REExBCkZKzCqG+K+1jES95FkQK
         GsHw/E45ubIxsx0jBnebuUNRLZzXgIWQqCVcUaw/MTWUgLAer4fId6v6+iEOKxiRuhol
         agyCDMv2osBKGGu6TI74wFJAznOSKvkrTwILoBwnR5ekRwMXUnL2eSj7LZz/a/tKS5lx
         g0bMD4ASdjDD6k8+MbGMe26ZG9bOFhxy32qXZgB/mg5kIn8vfe2PXID/uthGqdjUMBDQ
         YdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MtqP3cvkF6xw2x6kLUXAhugtSQrzwzYnq0/e1Emmf0o=;
        b=am9bu+G4xk9vcT9zc2fd+xj2ro9WN8Re2RThD6L4nbt/9UObyaq05k0vFy/XFDlLZS
         YHqsH7s8DtjfMqgzbUxdyBoek4pc4syWbQ4I7DlxtB/t/CqOgqdOvErD4Ye3NMOO92ul
         LjTY03WlVPUVc/V2UYx7nXIlEUp4IFS3pGiyRtfeJZPcU/WkIXem5lHYQ4j3vgPKrhzc
         BTU3qgkNW+wrA+WX01gLfXdNqb8fSIqI7tEYudBKCSOMMzZSOZfCDYQ0sjrMlHqjAXki
         RnVf7nJth6wN4c0X4kIleh+mEmS/uJ9lcgeI3/jrBr1LW4v2I7AQL8I1F23ybqMCkQKH
         aVOw==
X-Gm-Message-State: AOUpUlFoLlAPUOGweOAufNRONLvpjKdsOLSQs24F2Z9QG/yb2TjvBj8c
        N/zrqGX4GuVQS8bY1uH7lJZ14A==
X-Google-Smtp-Source: AAOMgpe55rqKX1DwW6xkH9sGVN99DfOGGNlwYRwMBPRdTyE66bnq/7tawj7bdCy0wByHvybR/YKS2w==
X-Received: by 2002:a5e:9611:: with SMTP id a17-v6mr18171121ioq.213.1533652187113;
        Tue, 07 Aug 2018 07:29:47 -0700 (PDT)
Received: from [192.168.1.55] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o67-v6sm519426iod.66.2018.08.07.07.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 07:29:45 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: Avoid lock contention and thundering herd issue
 in wbt_wait
From:   Jens Axboe <axboe@kernel.dk>
To:     Anchal Agarwal <anchalag@amazon.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     fllinden@amazon.com, msw@amazon.com, sblbir@amazon.com
References: <20180731213410.GA35291@kaos-source-ops-60001.pdx1.amazon.com>
 <df2a0476-d9d1-c6c9-6553-f459e890ce8b@kernel.dk>
 <20180801170603.GA32864@kaos-source-ops-60001.pdx1.amazon.com>
 <a9871e54-83bf-7557-2d2f-99e006ceadcf@kernel.dk>
Message-ID: <9265896d-3f02-ff2f-8e02-3aca775f4087@kernel.dk>
Date:   Tue, 7 Aug 2018 08:29:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <a9871e54-83bf-7557-2d2f-99e006ceadcf@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/18 4:09 PM, Jens Axboe wrote:
> On 8/1/18 11:06 AM, Anchal Agarwal wrote:
>> On Wed, Aug 01, 2018 at 09:14:50AM -0600, Jens Axboe wrote:
>>> On 7/31/18 3:34 PM, Anchal Agarwal wrote:
>>>> Hi folks,
>>>>
>>>> This patch modifies commit e34cbd307477a
>>>> (blk-wbt: add general throttling mechanism)
>>>>
>>>> I am currently running a large bare metal instance (i3.metal)
>>>> on EC2 with 72 cores, 512GB of RAM and NVME drives, with a
>>>> 4.18 kernel. I have a workload that simulates a database
>>>> workload and I am running into lockup issues when writeback
>>>> throttling is enabled,with the hung task detector also
>>>> kicking in.
>>>>
>>>> Crash dumps show that most CPUs (up to 50 of them) are
>>>> all trying to get the wbt wait queue lock while trying to add
>>>> themselves to it in __wbt_wait (see stack traces below).
>>>>
>>>> [    0.948118] CPU: 45 PID: 0 Comm: swapper/45 Not tainted 4.14.51-62.38.amzn1.x86_64 #1
>>>> [    0.948119] Hardware name: Amazon EC2 i3.metal/Not Specified, BIOS 1.0 10/16/2017
>>>> [    0.948120] task: ffff883f7878c000 task.stack: ffffc9000c69c000
>>>> [    0.948124] RIP: 0010:native_queued_spin_lock_slowpath+0xf8/0x1a0
>>>> [    0.948125] RSP: 0018:ffff883f7fcc3dc8 EFLAGS: 00000046
>>>> [    0.948126] RAX: 0000000000000000 RBX: ffff887f7709ca68 RCX: ffff883f7fce2a00
>>>> [    0.948128] RDX: 000000000000001c RSI: 0000000000740001 RDI: ffff887f7709ca68
>>>> [    0.948129] RBP: 0000000000000002 R08: 0000000000b80000 R09: 0000000000000000
>>>> [    0.948130] R10: ffff883f7fcc3d78 R11: 000000000de27121 R12: 0000000000000002
>>>> [    0.948131] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
>>>> [    0.948132] FS:  0000000000000000(0000) GS:ffff883f7fcc0000(0000) knlGS:0000000000000000
>>>> [    0.948134] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [    0.948135] CR2: 000000c424c77000 CR3: 0000000002010005 CR4: 00000000003606e0
>>>> [    0.948136] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> [    0.948137] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> [    0.948138] Call Trace:
>>>> [    0.948139]  <IRQ>
>>>> [    0.948142]  do_raw_spin_lock+0xad/0xc0
>>>> [    0.948145]  _raw_spin_lock_irqsave+0x44/0x4b
>>>> [    0.948149]  ? __wake_up_common_lock+0x53/0x90
>>>> [    0.948150]  __wake_up_common_lock+0x53/0x90
>>>> [    0.948155]  wbt_done+0x7b/0xa0
>>>> [    0.948158]  blk_mq_free_request+0xb7/0x110
>>>> [    0.948161]  __blk_mq_complete_request+0xcb/0x140
>>>> [    0.948166]  nvme_process_cq+0xce/0x1a0 [nvme]
>>>> [    0.948169]  nvme_irq+0x23/0x50 [nvme]
>>>> [    0.948173]  __handle_irq_event_percpu+0x46/0x300
>>>> [    0.948176]  handle_irq_event_percpu+0x20/0x50
>>>> [    0.948179]  handle_irq_event+0x34/0x60
>>>> [    0.948181]  handle_edge_irq+0x77/0x190
>>>> [    0.948185]  handle_irq+0xaf/0x120
>>>> [    0.948188]  do_IRQ+0x53/0x110
>>>> [    0.948191]  common_interrupt+0x87/0x87
>>>> [    0.948192]  </IRQ>
>>>> ....
>>>> [    0.311136] CPU: 4 PID: 9737 Comm: run_linux_amd64 Not tainted 4.14.51-62.38.amzn1.x86_64 #1
>>>> [    0.311137] Hardware name: Amazon EC2 i3.metal/Not Specified, BIOS 1.0 10/16/2017
>>>> [    0.311138] task: ffff883f6e6a8000 task.stack: ffffc9000f1ec000
>>>> [    0.311141] RIP: 0010:native_queued_spin_lock_slowpath+0xf5/0x1a0
>>>> [    0.311142] RSP: 0018:ffffc9000f1efa28 EFLAGS: 00000046
>>>> [    0.311144] RAX: 0000000000000000 RBX: ffff887f7709ca68 RCX: ffff883f7f722a00
>>>> [    0.311145] RDX: 0000000000000035 RSI: 0000000000d80001 RDI: ffff887f7709ca68
>>>> [    0.311146] RBP: 0000000000000202 R08: 0000000000140000 R09: 0000000000000000
>>>> [    0.311147] R10: ffffc9000f1ef9d8 R11: 000000001a249fa0 R12: ffff887f7709ca68
>>>> [    0.311148] R13: ffffc9000f1efad0 R14: 0000000000000000 R15: ffff887f7709ca00
>>>> [    0.311149] FS:  000000c423f30090(0000) GS:ffff883f7f700000(0000) knlGS:0000000000000000
>>>> [    0.311150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [    0.311151] CR2: 00007feefcea4000 CR3: 0000007f7016e001 CR4: 00000000003606e0
>>>> [    0.311152] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> [    0.311153] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> [    0.311154] Call Trace:
>>>> [    0.311157]  do_raw_spin_lock+0xad/0xc0
>>>> [    0.311160]  _raw_spin_lock_irqsave+0x44/0x4b
>>>> [    0.311162]  ? prepare_to_wait_exclusive+0x28/0xb0
>>>> [    0.311164]  prepare_to_wait_exclusive+0x28/0xb0
>>>> [    0.311167]  wbt_wait+0x127/0x330
>>>> [    0.311169]  ? finish_wait+0x80/0x80
>>>> [    0.311172]  ? generic_make_request+0xda/0x3b0
>>>> [    0.311174]  blk_mq_make_request+0xd6/0x7b0
>>>> [    0.311176]  ? blk_queue_enter+0x24/0x260
>>>> [    0.311178]  ? generic_make_request+0xda/0x3b0
>>>> [    0.311181]  generic_make_request+0x10c/0x3b0
>>>> [    0.311183]  ? submit_bio+0x5c/0x110
>>>> [    0.311185]  submit_bio+0x5c/0x110
>>>> [    0.311197]  ? __ext4_journal_stop+0x36/0xa0 [ext4]
>>>> [    0.311210]  ext4_io_submit+0x48/0x60 [ext4]
>>>> [    0.311222]  ext4_writepages+0x810/0x11f0 [ext4]
>>>> [    0.311229]  ? do_writepages+0x3c/0xd0
>>>> [    0.311239]  ? ext4_mark_inode_dirty+0x260/0x260 [ext4]
>>>> [    0.311240]  do_writepages+0x3c/0xd0
>>>> [    0.311243]  ? _raw_spin_unlock+0x24/0x30
>>>> [    0.311245]  ? wbc_attach_and_unlock_inode+0x165/0x280
>>>> [    0.311248]  ? __filemap_fdatawrite_range+0xa3/0xe0
>>>> [    0.311250]  __filemap_fdatawrite_range+0xa3/0xe0
>>>> [    0.311253]  file_write_and_wait_range+0x34/0x90
>>>> [    0.311264]  ext4_sync_file+0x151/0x500 [ext4]
>>>> [    0.311267]  do_fsync+0x38/0x60
>>>> [    0.311270]  SyS_fsync+0xc/0x10
>>>> [    0.311272]  do_syscall_64+0x6f/0x170
>>>> [    0.311274]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>>>
>>>> In the original patch, wbt_done is waking up all the exclusive
>>>> processes in the wait queue, which can cause a thundering herd
>>>> if there is a large number of writer threads in the queue. The
>>>> original intention of the code seems to be to wake up one thread
>>>> only however, it uses wake_up_all() in __wbt_done(), and then
>>>> uses the following check in __wbt_wait to have only one thread
>>>> actually get out of the wait loop:
>>>>
>>>> if (waitqueue_active(&rqw->wait) &&
>>>>             rqw->wait.head.next != &wait->entry)
>>>>                 return false;
>>>>
>>>> The problem with this is that the wait entry in wbt_wait is
>>>> define with DEFINE_WAIT, which uses the autoremove wakeup function.
>>>> That means that the above check is invalid - the wait entry will
>>>> have been removed from the queue already by the time we hit the
>>>> check in the loop.
>>>>
>>>> Secondly, auto-removing the wait entries also means that the wait
>>>> queue essentially gets reordered "randomly" (e.g. threads re-add
>>>> themselves in the order they got to run after being woken up).
>>>> Additionally, new requests entering wbt_wait might overtake requests
>>>> that were queued earlier, because the wait queue will be
>>>> (temporarily) empty after the wake_up_all, so the waitqueue_active
>>>> check will not stop them. This can cause certain threads to starve
>>>> under high load.
>>>>
>>>> The fix is to leave the woken up requests in the queue and remove
>>>> them in finish_wait() once the current thread breaks out of the
>>>> wait loop in __wbt_wait. This will ensure new requests always
>>>> end up at the back of the queue, and they won't overtake requests
>>>> that are already in the wait queue. With that change, the loop
>>>> in wbt_wait is also in line with many other wait loops in the kernel.
>>>> Waking up just one thread drastically reduces lock contention, as
>>>> does moving the wait queue add/remove out of the loop.
>>>>
>>>> A significant drop in lockdep's lock contention numbers is seen when
>>>> running the test application on the patched kernel.
>>>
>>> I like the patch, and a few weeks ago we independently discovered that
>>> the waitqueue list checking was bogus as well. My only worry is that
>>> changes like this can be delicate, meaning that it's easy to introduce
>>> stall conditions. What kind of testing did you push this through?
>>>
>>> -- 
>>> Jens Axboe
>>>
>> I ran the following tests on both real HW with NVME devices attached
>> and emulated NVME too:
>>
>> 1. The test case I used to reproduce the issue, spawns a bunch of threads 
>>    to concurrently read and write files with random size and content. 
>>    Files are randomly fsync'd. The implementation is a FIFO queue of files. 
>>    When the queue fills the test starts to verify and remove the files. This 
>>    test will fail if there's a read, write, or hash check failure. It tests
>>    for file corruption when lots of small files are being read and written 
>>    with high concurrency.
>>
>> 2. Fio for random writes with a root NVME device of 200GB
>>   
>>   fio --name=randwrite --ioengine=libaio --iodepth=1 --rw=randwrite --bs=4k 
>>   --direct=0 --size=10G --numjobs=2 --runtime=60 --group_reporting
>>   
>>   fio --name=randwrite --ioengine=libaio --iodepth=1 --rw=randwrite --bs=4k
>>   --direct=0 --size=5G --numjobs=2 --runtime=30 --fsync=64 --group_reporting
>>   
>>   I did see an improvement in the bandwidth numbers reported on the patched
>>   kernel. 
>>
>> Do you have any test case/suite in mind that you would suggest me to 
>> run to be sure that patch does not introduce any stall conditions?
> 
> One thing that is always useful is to run xfstest, do a full run on
> the device. If that works, then do another full run, this time limiting
> the queue depth of the SCSI device to 1. If both of those pass, then
> I'd feel pretty good getting this applied for 4.19.

Did you get a chance to run this full test?

-- 
Jens Axboe

