Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84A5C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F7A2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g5YFbe4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F7A2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeLIGbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:31:53 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42538 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeLIGbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:31:52 -0500
Received: by mail-io1-f66.google.com with SMTP id x6so6404144ioa.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 22:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VYu6tGi5YHdaHIiuxnJsy/LdL1ZCxJKL70zFcV89SWc=;
        b=g5YFbe4WvNjJIz3Fyr26TVuI6Nu9ncfe4j86IWDvzZ2PY/sw4UcmCKhUGM1k4lbFDC
         lLJX/eNPBLh1arSO+ZV2MLZcfKNfya4zkM6A0RDPM6kjZW8ekWP5D7jOzBzjdoQlZ3uH
         4qgD+Xlbrr3DENXU4GAsFdypZzjpYespqWBj29IkjZINSnVxwYm6QId63of9VTpOSWnk
         +Oc2LzCWldiMUphZ1pAX+Cz3Z7O3tgvraaFk27ijHMi9hgWyTwtLTvSUCYuPUROJgvNZ
         5ZSzp10maWWEsQw7V7ZoqjAMA46a8LA+8Bv+KbqXhuu0aomHe5/ORsFrZUNGyNGnHiEj
         jUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VYu6tGi5YHdaHIiuxnJsy/LdL1ZCxJKL70zFcV89SWc=;
        b=juGO+nBudaSSTGF1kZxvpAhg1MbBQvgmHPhXkI54Ez2jzBotQQn3NuSvZQT+sz9XoH
         KJa4tOR9DskyO3tkS1oP7eNjaMXIiKHNKgFwtfPwORdGhPaqtwFmRft9mPO1QRHYWXdZ
         7M2cYZBvLpNtGVib/wAJkmh0BRxzrPV/STjwvxQ/WojKytck/UQUb6Vdg4XdzIZilGv3
         Mn5t6QaiVkkFji4Ebmcc4k0+6fQDatGTHNWp0R1nMCTC02dch5Rplz+Hbdn1fiPI4ZYA
         muw5z98R88YaMrtw2oPpO0Ou9LNGRwyYiLNAtlPvZeMu04mlyOe0yhO7vN0jTnJPegXl
         Ii2A==
X-Gm-Message-State: AA+aEWbsW+NUJ//1FXyhdxtLkXLjsNCsQoHRa6+MpAxWOxYyQjFO7oSf
        BcpGfyDjV1RsjlEw9J4jCSfcssv9jmg=
X-Google-Smtp-Source: AFSGD/WgarRS5HDgE2vIhdsoVw1Z5BMPZJpm1c3F9gAbc447FiaUYTwIADYMxTaKUFX40QdGMqkhFA==
X-Received: by 2002:a5d:8941:: with SMTP id b1mr6038239iot.136.1544337111426;
        Sat, 08 Dec 2018 22:31:51 -0800 (PST)
Received: from [192.168.1.238] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id w16sm4380798ita.38.2018.12.08.22.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 22:31:50 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] nvme: default to 0 poll queues
From:   Jens Axboe <axboe@kernel.dk>
X-Mailer: iPhone Mail (16C5050a)
In-Reply-To: <4ad5653b-1cd4-a770-2290-ca032eeb7072@roeck-us.net>
Date:   Sat, 8 Dec 2018 23:31:48 -0700
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7D155CA-8DA8-4DF2-BBC2-14E6AF436F24@kernel.dk>
References: <20181209004953.GA11638@roeck-us.net> <fa7aabad-774b-4e5b-686f-3696762291c1@kernel.dk> <4ad5653b-1cd4-a770-2290-ca032eeb7072@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 8, 2018, at 11:22 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
>> On 12/8/18 9:38 PM, Jens Axboe wrote:
>>> On 12/8/18 5:49 PM, Guenter Roeck wrote:
>>> Hi,
>>>=20
>>>> On Mon, Nov 19, 2018 at 08:18:24AM -0700, Jens Axboe wrote:
>>>> We need a better way of configuring this, and given that polling is
>>>> (still) a bit niche, let's default to using 0 poll queues. That way
>>>> we'll have the same read/write/poll behavior as 4.20, and users that
>>>> want to test/use polling are required to do manual configuration of the=

>>>> number of poll queues.
>>>>=20
>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>=20
>>> This patch results in a boot stall when booting parisc (hppa) images
>>> from nvme in qemu.
>>>=20
>>> ...
>>> Fusion MPT SAS Host driver 3.04.20
>>> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>>> rcu:    (detected by 0, t=3D5252 jiffies, g=3D141, q=3D22)
>>> rcu: All QSes seen, last rcu_sched kthread activity 5252 (-66742--71994)=
, jiffies_till_next_fqs=3D1, root ->qsmask 0x0
>>> kworker/u8:3    R  running task        0    85      2 0x00000004
>>> Workqueue: nvme-reset-wq nvme_reset_work
>>> Backtrace:
>>>  [<10190d20>] show_stack+0x28/0x38
>>>  [<101dd1e0>] sched_show_task.part.3+0xc4/0x144
>>>  [<101dd290>] sched_show_task+0x30/0x38
>>>  [<10221e18>] rcu_check_callbacks+0x760/0x7a4
>>>=20
>>> rcu: rcu_sched kthread starved for 5252 jiffies! g141 f0x2 RCU_GP_WAIT_FQ=
S(5) ->state=3D0x0 ->cpu=3D0
>>> rcu: RCU grace-period kthread stack dump:
>>> rcu_sched       R  running task        0    10      2 0x00000000
>>> Backtrace:
>>>  [<10995b1c>] __schedule+0x214/0x648
>>>  [<10995f94>] schedule+0x44/0xa8
>>>  [<1099a7c4>] schedule_timeout+0x114/0x1a0
>>>  [<10220e70>] rcu_gp_kthread+0x744/0x968
>>>  [<101d5438>] kthread+0x154/0x15c
>>>  [<1019501c>] ret_from_kernel_thread+0x1c/0x24
>>>=20
>>> [ continued ]
>>>=20
>>> This is only seen in SMP configurations; non-SMP configurations are ok.
>>> Reverting the patch fixes the problem. v4.20-rcX and earlier kernels
>>> also boot without problems.
>>>=20
>>> For reference, here is the qemu command line. This is with qemu 3.0.
>>>=20
>>> qemu-system-hppa -kernel vmlinux -no-reboot \
>>>    -snapshot \
>>>    -device nvme,serial=3Dfoo,drive=3Dd0 \
>>>    -drive file=3Drootfs.ext2,if=3Dnone,format=3Draw,id=3Dd0 \
>>>    -append 'root=3D/dev/nvme0n1 rw rootwait panic=3D-1 console=3DttyS0,1=
15200 ' \
>>>    -nographic -monitor null
>>>=20
>>> Please let me know if you need additional information.
>> Hmm, I think the queue reduction case has a logic error. Actually there
>> are two bugs:
>> 1) Ensure we don't keep overwriting the queue count we ask for
>> 2) Don't include poll_queues in the vectors we need
>> Untested... And not super pretty. But does this work for you?
>=20
> It solves the boot problem on parisc/hppa. I didn't test with any other ar=
chitectures.
> Should I run a complete test sequence ?

That=E2=80=99d be great, thanks.=20


