Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA66C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 07:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2764D20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 07:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJpRg304"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2764D20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbeLIHcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 02:32:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45764 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLIHcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 02:32:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so3746901plm.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 23:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0e487jcKAneWLwmsISpOAksn5Mr0lPH+4uRJd+CKVDQ=;
        b=pJpRg304yi1gpn/xLzCJsEG/ZNlq3SiYRq9VQKaQ3Hbrep0PqvUd64v9FT9AeknZ04
         lKFkZ5smMwIMUtmw8RwX/rOJwJY+W8nXXpQ/ZKnxRRIouVGqL7XChtRZrcVmLPiohB53
         g6Nu/MvF3+dAy2haGbKfiOOv0pmATKAJeMmE567nEFYJGDgOXZl98z828pExS994DQmT
         mw4Rcf1rSNrzhvIB+UljDuiaQZ9erygJ88fFtXq83a/uKRo+imtfHAzXo6J26xS/MinZ
         mA4oa1lYgCJsQDFhlJC8L/fNExacxG5JR5xA4liOeOrOn1lSBtEovaKmCm6C5V9y4DIq
         +WOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0e487jcKAneWLwmsISpOAksn5Mr0lPH+4uRJd+CKVDQ=;
        b=gNsPx0jcUaShTEMjbdNWMVuKunr1zKy8gTaWTSjJEKVzq5W6nnNNooV3MiRjdw5tFm
         zs9ANmS+16RB01MzPwXvK7zm5+KosGaB1ZhIRBSl2Cgl+Tf5W5Iq17HGm/QRPPMof64o
         pU0qHPm1bBTHfJHS5glXIHnYOAC59QPzhNmjefzNuWVBPbmCcK2srVlBwUKFNLXT9R1P
         x4S85MzQOr6ZL9IeM5JONXtKHpZsQDEjTyH3z/S4PlTeJ+cKgRvbF6SDq83XGUC4DAJm
         rBHj6PqqTVpH5klXEktntRyGw0Z62QEQZmPxVW/4Q4hhd7nwQDgXrKig6XbnbW4JYHmm
         Fdag==
X-Gm-Message-State: AA+aEWZO/V8doCAwusyJxIw2Oy3q9X7k9usxzQxWSCFQ9lBcXxthjW/K
        xuZvd6x5RPO8QnrHbprikiqIlVQG
X-Google-Smtp-Source: AFSGD/WSn+g2mi7JVlICzPB+YxweRSA1F7TVMJQhGaU9hIpvAbOtTKlimk9JcucfFTzomayIAf6Y3A==
X-Received: by 2002:a17:902:7481:: with SMTP id h1mr8044275pll.341.1544340729596;
        Sat, 08 Dec 2018 23:32:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q1sm10681010pfb.96.2018.12.08.23.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 23:32:08 -0800 (PST)
Subject: Re: [PATCH] nvme: default to 0 poll queues
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181209004953.GA11638@roeck-us.net>
 <fa7aabad-774b-4e5b-686f-3696762291c1@kernel.dk>
 <4ad5653b-1cd4-a770-2290-ca032eeb7072@roeck-us.net>
 <C7D155CA-8DA8-4DF2-BBC2-14E6AF436F24@kernel.dk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0a6c9479-58b9-5af7-7fb8-880730554e69@roeck-us.net>
Date:   Sat, 8 Dec 2018 23:32:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <C7D155CA-8DA8-4DF2-BBC2-14E6AF436F24@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/18 10:31 PM, Jens Axboe wrote:
> On Dec 8, 2018, at 11:22 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>>> On 12/8/18 9:38 PM, Jens Axboe wrote:
>>>> On 12/8/18 5:49 PM, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>>> On Mon, Nov 19, 2018 at 08:18:24AM -0700, Jens Axboe wrote:
>>>>> We need a better way of configuring this, and given that polling is
>>>>> (still) a bit niche, let's default to using 0 poll queues. That way
>>>>> we'll have the same read/write/poll behavior as 4.20, and users that
>>>>> want to test/use polling are required to do manual configuration of the
>>>>> number of poll queues.
>>>>>
>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>> ---
>>>>
>>>> This patch results in a boot stall when booting parisc (hppa) images
>>>> from nvme in qemu.
>>>>
>>>> ...
>>>> Fusion MPT SAS Host driver 3.04.20
>>>> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>>>> rcu:    (detected by 0, t=5252 jiffies, g=141, q=22)
>>>> rcu: All QSes seen, last rcu_sched kthread activity 5252 (-66742--71994), jiffies_till_next_fqs=1, root ->qsmask 0x0
>>>> kworker/u8:3    R  running task        0    85      2 0x00000004
>>>> Workqueue: nvme-reset-wq nvme_reset_work
>>>> Backtrace:
>>>>   [<10190d20>] show_stack+0x28/0x38
>>>>   [<101dd1e0>] sched_show_task.part.3+0xc4/0x144
>>>>   [<101dd290>] sched_show_task+0x30/0x38
>>>>   [<10221e18>] rcu_check_callbacks+0x760/0x7a4
>>>>
>>>> rcu: rcu_sched kthread starved for 5252 jiffies! g141 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
>>>> rcu: RCU grace-period kthread stack dump:
>>>> rcu_sched       R  running task        0    10      2 0x00000000
>>>> Backtrace:
>>>>   [<10995b1c>] __schedule+0x214/0x648
>>>>   [<10995f94>] schedule+0x44/0xa8
>>>>   [<1099a7c4>] schedule_timeout+0x114/0x1a0
>>>>   [<10220e70>] rcu_gp_kthread+0x744/0x968
>>>>   [<101d5438>] kthread+0x154/0x15c
>>>>   [<1019501c>] ret_from_kernel_thread+0x1c/0x24
>>>>
>>>> [ continued ]
>>>>
>>>> This is only seen in SMP configurations; non-SMP configurations are ok.
>>>> Reverting the patch fixes the problem. v4.20-rcX and earlier kernels
>>>> also boot without problems.
>>>>
>>>> For reference, here is the qemu command line. This is with qemu 3.0.
>>>>
>>>> qemu-system-hppa -kernel vmlinux -no-reboot \
>>>>     -snapshot \
>>>>     -device nvme,serial=foo,drive=d0 \
>>>>     -drive file=rootfs.ext2,if=none,format=raw,id=d0 \
>>>>     -append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0,115200 ' \
>>>>     -nographic -monitor null
>>>>
>>>> Please let me know if you need additional information.
>>> Hmm, I think the queue reduction case has a logic error. Actually there
>>> are two bugs:
>>> 1) Ensure we don't keep overwriting the queue count we ask for
>>> 2) Don't include poll_queues in the vectors we need
>>> Untested... And not super pretty. But does this work for you?
>>
>> It solves the boot problem on parisc/hppa. I didn't test with any other architectures.
>> Should I run a complete test sequence ?
> 
> That’d be great, thanks.
> 

Ok, started.

Guenter


