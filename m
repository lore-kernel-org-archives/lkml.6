Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B85C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6862520844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLFt7jmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6862520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388566AbeGYCdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:33:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45218 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388468AbeGYCdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:33:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so4090929pgq.12;
        Tue, 24 Jul 2018 18:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wSYMbmQOq0ldFH/jCYnPG3IXkyS/SX7hJyGMcbYXKLA=;
        b=WLFt7jmh4vXmajvVhVto4FKTFw2srQ2y3tt3xf/hlPfF5MnKpzb2d+fFUF3g/1ufB4
         qC5qilwMK+hp1dmNwOdAoy2fKIuE2xs+72UeABFWZamqAZj04+zw4e1wWnVOKdvLkeLg
         rxpCa1TEDCS/sSEF7KYVw5peC0CvcZQL7GoX43tLkOQIOQ+ZJLOKratQdaI+ayxBRAzz
         dBrIdNb1jm4+JkjDiNB+T6ThgdfWiwvYLIQ/3NlLqzVEs4p2vOZQA7sUHtkNDPhOGuSB
         LNP8RkSNUjHJ0PomDkvIHxML1kFkzPqdEznoeH+s8AkC9BO5zU4bFuiY0QHuBqhaGt+J
         8B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wSYMbmQOq0ldFH/jCYnPG3IXkyS/SX7hJyGMcbYXKLA=;
        b=iZC/Wngfc2bElGXGVGmQJseb3LAJyJ9lMsMetoKHoWiO1HEwRi73y5jIBuuJ5XXRcJ
         e3ZOrw9hyFIL5u3upRlqpLfEcMupiZBf1a3fHS0NH6cT6SzMzF7APP5Rdr8em29fc773
         IHudtA1PfYi3ZlkNzIwIPMoQttv9IukQ4hxRKqeQApl6JtCkdf5iHCwBYD93dvPJAFAm
         ePFl+4CbYleOqepMIt9D9/zO2mW3KbxZbKffUrxYpWhsjHo/1IcmR73eCZG6/lVd48WP
         M8IdQRRPFL0Oa31TFSHHlx6KLq1obP0yJTuJLjtkk3Y6xRt133IwcOTHOL57C47Rkvre
         USbw==
X-Gm-Message-State: AOUpUlHs7l5YUx5Xfj/WIHKgEuTjDverOdJ42td+B39IC1DKJrCVynon
        /DGCYL6bh2sO/drnhqHViFPLTVXX
X-Google-Smtp-Source: AAOMgpc34DGDuaGkZLGfB5SD70+ETERo4C8OjJzdFffHdnihufL2qUt6dswV8OA55Hu7VPi/JH4smA==
X-Received: by 2002:a63:f18:: with SMTP id e24-v6mr18629825pgl.320.1532481853052;
        Tue, 24 Jul 2018 18:24:13 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j1-v6sm40558754pfk.125.2018.07.24.18.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 18:24:12 -0700 (PDT)
Subject: Re: [tip:x86/timers] sched/clock: Enable sched clock early
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com,
        linux-tip-commits@vger.kernel.org
References: <20180719205545.16512-24-pasha.tatashin@oracle.com>
 <tip-857baa87b6422bcfb84ed3631d6839920cb5b09d@git.kernel.org>
 <20180724195215.GA22496@roeck-us.net>
 <CAGM2reayvBs8rs6yHZYV9SvPz-tsNG_Ux8ypHguLLagiS2SkuA@mail.gmail.com>
 <CAGM2rebX7dq_ejNuSotV_0gJZY6pqro-KteXz9zzhDkjtSxaOw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ddb6bc3d-b764-3115-ebc7-54c70c967f24@roeck-us.net>
Date:   Tue, 24 Jul 2018 18:24:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGM2rebX7dq_ejNuSotV_0gJZY6pqro-KteXz9zzhDkjtSxaOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 05:36 PM, Pavel Tatashin wrote:
> On Tue, Jul 24, 2018 at 4:22 PM Pavel Tatashin
> <pasha.tatashin@oracle.com> wrote:
>>
>> On Tue, Jul 24, 2018 at 3:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> Hi,
>>>
>>> On Thu, Jul 19, 2018 at 03:33:21PM -0700, tip-bot for Pavel Tatashin wrote:
>>>> Commit-ID:  857baa87b6422bcfb84ed3631d6839920cb5b09d
>>>> Gitweb:     https://git.kernel.org/tip/857baa87b6422bcfb84ed3631d6839920cb5b09d
>>>> Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
>>>> AuthorDate: Thu, 19 Jul 2018 16:55:42 -0400
>>>> Committer:  Thomas Gleixner <tglx@linutronix.de>
>>>> CommitDate: Fri, 20 Jul 2018 00:02:43 +0200
>>>>
>>>> sched/clock: Enable sched clock early
>>>>
>>>> Allow sched_clock() to be used before schec_clock_init() is called.  This
>>>> provides a way to get early boot timestamps on machines with unstable
>>>> clocks.
>>>>
>>>
>>> This patch causes a regression when running a qemu emulation with
>>> arm:integratorcp.
>>
>> Thank you for the report. I will study it.
>>
>>>
>>> ...
>>> Console: colour dummy device 80x30
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 0 at kernel/time/sched_clock.c:180
>>> sched_clock_register+0x44/0x278
>>> Modules linked in:
>>> CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc6-next-20180724 #1
>>> Hardware name: ARM Integrator/CP (Device Tree)
>>> [<c0010cb4>] (unwind_backtrace) from [<c000dc24>] (show_stack+0x10/0x18)
>>> [<c000dc24>] (show_stack) from [<c03ffb94>] (dump_stack+0x18/0x24)
>>> [<c03ffb94>] (dump_stack) from [<c001a000>] (__warn+0xc8/0xf0)
>>> [<c001a000>] (__warn) from [<c001a13c>] (warn_slowpath_null+0x3c/0x4c)
>>> [<c001a13c>] (warn_slowpath_null) from [<c052367c>] (sched_clock_register+0x44/0x278)
>>> [<c052367c>] (sched_clock_register) from [<c05238d8>] (generic_sched_clock_init+0x28/0x88)
>>> [<c05238d8>] (generic_sched_clock_init) from [<c0521a00>] (sched_clock_init+0x54/0x74)
>>> [<c0521a00>] (sched_clock_init) from [<c0519c18>] (start_kernel+0x310/0x3e4)
>>> [<c0519c18>] (start_kernel) from [<00000000>] (  (null))
>>> ---[ end trace 08080eb81afa002c ]---
>>> sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns
>>> ...
>>>
>>> A complete boot log is available at
>>> http://kerneltests.org/builders/qemu-arm-next/builds/979/steps/qemubuildcommand/logs/stdio
>>>
>>> Unfortunately, reverting the patch results in conflicts, so I am unable
>>> to confirm that it is the only culprit.
>>>
>>>  From the context and from looking into the patch, it appears that this
>>> can happen in any system if CONFIG_HAVE_UNSTABLE_SCHED_CLOCK is not
>>> enabled.
> 
> Do you have a complete config, and also qemu args that were used? I
> have tried defconfig arm, and run in qemu, could not reproduce the
> problem.
> 

integrator_defconfig+CONFIG_DEVTMPFS=y+CONFIG_DEVTMPFS_MOUNT=y

Qemu command line is
	qemu-system-arm -M integratorcp  -m 128 \
	-kernel arch/arm/boot/zImage -no-reboot \
	-initrd busybox-armv4.cpio \
	--append "rdinit=/sbin/init console=ttyAMA0,115200" \
	-serial stdio -monitor null -nographic \
	-dtb arch/arm/boot/dts/integratorcp.dtb

The scripts and files used are available from git@github.com:groeck/linux-build-test.git.
qemu is version 2.12.

Guenter

> Thank you,
> Pavel
> 
>>>
>>> Bisect log is attached.
>>>
>>> Guenter
>>>
>>> ---
>>> # bad: [3946cd385042069ec57d3f04240def53b4eed7e5] Add linux-next specific files for 20180724
>>> # good: [d72e90f33aa4709ebecc5005562f52335e106a60] Linux 4.18-rc6
>>> git bisect start 'HEAD' 'v4.18-rc6'
>>> # good: [f5fa891e325acf096c0f79e1d1b922002e251e5a] Merge remote-tracking branch 'crypto/master'
>>> git bisect good f5fa891e325acf096c0f79e1d1b922002e251e5a
>>> # good: [cb6471f6bcfdacbeef9c23ba9dac00e67bd3c3a4] Merge remote-tracking branch 'spi/for-next'
>>> git bisect good cb6471f6bcfdacbeef9c23ba9dac00e67bd3c3a4
>>> # bad: [6b5bfa57bf4553d051be65d85d021465041406d8] Merge remote-tracking branch 'char-misc/char-misc-next'
>>> git bisect bad 6b5bfa57bf4553d051be65d85d021465041406d8
>>> # bad: [675a67e9ef3c041999f412cb75418d2b0def3854] Merge remote-tracking branch 'rcu/rcu/next'
>>> git bisect bad 675a67e9ef3c041999f412cb75418d2b0def3854
>>> # good: [e78b01a51131f25fc2d881bc43001575c129069c] Merge branch 'perf/core'
>>> git bisect good e78b01a51131f25fc2d881bc43001575c129069c
>>> # good: [4e581bce514f4107ce84525f0f75f89c92b4140e] Merge branch 'x86/cpu'
>>> git bisect good 4e581bce514f4107ce84525f0f75f89c92b4140e
>>> # good: [20fa22e90e54e2d21cace7ba083598531670f7cf] Merge branch 'x86/pti'
>>> git bisect good 20fa22e90e54e2d21cace7ba083598531670f7cf
>>> # good: [4763f03d3d186ce8a1125844790152d76804ad60] x86/tsc: Use TSC as sched clock early
>>> git bisect good 4763f03d3d186ce8a1125844790152d76804ad60
>>> # good: [5f9ef44c7d1c59d0eda1d86e31d981bdffe2a725] tools/memory-model: Rename litmus tests to comply to norm7
>>> git bisect good 5f9ef44c7d1c59d0eda1d86e31d981bdffe2a725
>>> # bad: [fc3d25e1c8f6a9232530db02a1072033e22e0fe3] Merge branch 'x86/timers'
>>> git bisect bad fc3d25e1c8f6a9232530db02a1072033e22e0fe3
>>> # bad: [46457ea464f5341d1f9dad8dd213805d45f7f117] sched/clock: Use static key for sched_clock_running
>>> git bisect bad 46457ea464f5341d1f9dad8dd213805d45f7f117
>>> # bad: [857baa87b6422bcfb84ed3631d6839920cb5b09d] sched/clock: Enable sched clock early
>>> git bisect bad 857baa87b6422bcfb84ed3631d6839920cb5b09d
>>> # good: [5d2a4e91a541cb04d20d11602f0f9340291322ac] sched/clock: Move sched clock initialization and merge with generic clock
>>> git bisect good 5d2a4e91a541cb04d20d11602f0f9340291322ac
>>> # first bad commit: [857baa87b6422bcfb84ed3631d6839920cb5b09d] sched/clock: Enable sched clock early
> 

