Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDF3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98D820855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZENfctOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfBULLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:11:54 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46285 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBULLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:11:53 -0500
Received: by mail-qt1-f195.google.com with SMTP id z25so9230776qti.13;
        Thu, 21 Feb 2019 03:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aVwn8ge9f9Ch8p1eVZTrxfHIAdGEnz5mn50MzfkUZv0=;
        b=ZENfctOE7ShArqr2hKza6MTkYR03odEq21IjdxQ+hE5SjYR7Fog/MhmaYmZDkOGrOS
         us3mlvGvh9Mzt6lNJMToXDt8qcAZyOmNLFVzwLcc68hZ3AkCq4CGL3Zrz6nbzWm9K0f5
         DQwEEIpUP84iQ8Qe7lApqb01HmAnKgSDi/iokHO9MKRoLqowb8TVTQ2bFXZ7eJckFOeu
         BIfglB3mXK8VGByyvviLB5p9eZDnmcP3zo95zMNAIO+gut4KpuIP5CdIv/XCdP1DY39A
         DpGb7Asb6FSjjwPujIkz9GdJKrfo6I35MzUzFeD/zFTlP6WaXA3m+KxjusIpZu3mlZ09
         hrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aVwn8ge9f9Ch8p1eVZTrxfHIAdGEnz5mn50MzfkUZv0=;
        b=M4F5kKpZGS0KfPpPFjmE9I72VL9rpNeQVO4Zk3IikN9qm/1i50BXTr69+jkbeLy2T+
         LrhY6ku+sUdi+70Fm5VK5bWH7uSoZZeXiC/IlYRkWcQiIC2/RvUnt1yijTlhRgble1bx
         kc9i8MoSBwoPJwv28LqHtbVSd7B26jY3/ePgInve0aQ+Df9I03JTr/OaZWOBV1lmlZ5O
         c5wewYJaj5hKiAFdri+EB2hYoc7qMmBRJ8OaJwVRPGgTPLUr9uRKNXnnLOdcC1SHRADm
         RcC5hs0P2pB9JZVFFtXDL/S5Y05rpnGCy6wQL90jcahIWnWOwvYjKoKAA/7YfTJkqVER
         ZXnQ==
X-Gm-Message-State: AHQUAuYXQHuPloExiYDdp+EODzC9LFdAGlV4iIjn53ALbCGqE4vGM/Z6
        1PSYQD5XUCQpmoRujTehQ2sqrTzFVfM=
X-Google-Smtp-Source: AHgI3IYdYYBLU0kBMX1UsU7BqIRidaiXSrcojtjKB12QTLmTmVZfKE05d42B4bETnfBOB7FsfeKz0w==
X-Received: by 2002:ac8:3209:: with SMTP id x9mr31395403qta.315.1550747511609;
        Thu, 21 Feb 2019 03:11:51 -0800 (PST)
Received: from [192.168.0.171] (189.26.190.168.dynamic.adsl.gvt.net.br. [189.26.190.168])
        by smtp.gmail.com with ESMTPSA id y21sm2096739qth.90.2019.02.21.03.11.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:11:50 -0800 (PST)
Subject: Re: [PATCH] Input: uinput - Allow uinput_request to be interrupted
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Martin Kepplinger <martink@posteo.de>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)" 
        <linux-input@vger.kernel.org>
References: <20190218004305.339758-1-marcos.souza.org@gmail.com>
 <20190218142110.GA23087@casa> <20190218201544.GA192977@dtor-ws>
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Message-ID: <dd48a489-fb13-fa66-a002-783d547e90c9@gmail.com>
Date:   Thu, 21 Feb 2019 08:11:27 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190218201544.GA192977@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 2/18/19 5:15 PM, Dmitry Torokhov wrote:
> On Mon, Feb 18, 2019 at 03:21:10PM +0100, Rodrigo Rivas Costa wrote:
>> On Sun, Feb 17, 2019 at 09:42:52PM -0300, Marcos Paulo de Souza wrote:
>>> -	if (!wait_for_completion_timeout(&request->done, 30 * HZ)) {
>>> +	if (!wait_for_completion_interruptible_timeout(&request->done,
>>> +							30 * HZ)) {
>>>   		retval = -ETIMEDOUT;
>>>   		goto out;
>>>   	}
>> Now this function can succeed or fail because of ETIMEDOUT or an
>> interrupt. I think you should return -EINTR or maybe -ESYSRESTART if
>> interrupted.
> Rodrigo, you are right. Marcos, could you please send updated patch that
> returns different error code for timeout vs interrupt condition?

Sure. But now I found another issue: If we start fftest and press 
Ctrl-C, it works (as Rodrigo and we all tested), but if we press -1 
(Stopping effects), it gets stuck in the same old way. Now I'm running 
lockdep and trying to fix this missing case (lockdep added bellow).

This lockdep warning is shown before the fftest can even allow the user 
to choose between his available options or press -1.

>
> I dropped the patch for now.
>
> Thanks.
[   11.528465] WARNING: possible circular locking dependency detected 
[37/7926]
[   11.530419] 5.0.0-rc7+ #5 Not tainted
[   11.531368] ------------------------------------------------------
[   11.533295] fftest/200 is trying to acquire lock:
[   11.534713] 000000006528ddcb (&newdev->mutex){+.+.}, at: 
uinput_request_submit+0x10a/0x320 [uinput]
[ 11.536939]
[   11.536939] but task is already holding lock:
[   11.538338] 000000004113875e (&ff->mutex){+.+.}, at: 
input_ff_upload+0xa6/0x250
[ 11.540114]
[   11.540114] which lock already depends on the new lock.
[ 11.540114]
[ 11.541966]
[   11.541966] the existing dependency chain (in reverse order) is:
[ 11.543765]
[   11.543765] -> #3 (&ff->mutex){+.+.}:
[   11.544982] input_ff_flush+0x23/0x60
[   11.545933] input_flush_device+0x3b/0x60
[   11.546985]        evdev_flush+0x54/0x60
[   11.547974]        filp_close+0x25/0x70
[   11.548849]        __x64_sys_close+0x19/0x40
[   11.549838]        do_syscall_64+0x4b/0x180
[   11.550853]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   11.552584]
[   11.552584] -> #2 (&dev->mutex#2){+.+.}:
[   11.554077]        input_register_handle+0x25/0xc0
[   11.555228]        kbd_connect+0x44/0x90
[   11.556141]        input_attach_handler+0x73/0xb0
[   11.557222]        input_register_device+0x438/0x4b0
[   11.558383]        acpi_button_add+0x179/0x470
[   11.559392]        acpi_device_probe+0x43/0x110
[   11.560432]        really_probe+0x1c4/0x2d0
[   11.561334]        driver_probe_device+0x4a/0xe0
[   11.562286]        __driver_attach+0xb0/0xc0
[   11.563165]        bus_for_each_dev+0x74/0xc0
[   11.564159]        bus_add_driver+0x194/0x210
[   11.565142]        driver_register+0x56/0xe0
[   11.566157]        do_one_initcall+0x58/0x2ae
[   11.567095]        kernel_init_freeable+0x1ca/0x256
[   11.568176]        kernel_init+0x5/0x100
[   11.569032]        ret_from_fork+0x3a/0x50
[   11.569898]
[   11.569898] -> #1 (input_mutex){+.+.}:
[   11.571027]        input_register_device+0x3e6/0x4b0
[   11.572116]        uinput_ioctl_handler.isra.9+0x557/0x980 [uinput]
[   11.573509]        do_vfs_ioctl+0xa0/0x6e0
[   11.574395]        ksys_ioctl+0x6b/0x80
[   11.575234]        __x64_sys_ioctl+0x11/0x20
[   11.576161]        do_syscall_64+0x4b/0x180
[   11.577085]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   11.578281]
[   11.578281] -> #0 (&newdev->mutex){+.+.}:
[   11.579436]        __mutex_lock+0x7d/0x9a0
[   11.580381]        uinput_request_submit+0x10a/0x320 [uinput]
[   11.581590]        uinput_dev_upload_effect+0x76/0xb0 [uinput]
[   11.582893]        input_ff_upload+0x1c0/0x250
[   11.583853]        evdev_ioctl_handler+0x388/0xbd0
[   11.584926]        do_vfs_ioctl+0xa0/0x6e0
[   11.586208]        ksys_ioctl+0x6b/0x80
[   11.587292]        __x64_sys_ioctl+0x11/0x20
[   11.588254]        do_syscall_64+0x4b/0x180
[   11.589221]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   11.590424]
[   11.590424] other info that might help us debug this:
[   11.590424]
[   11.592162] Chain exists of:
[   11.592162]   &newdev->mutex --> &dev->mutex#2 --> &ff->mutex
[   11.592162]
[   11.594156]  Possible unsafe locking scenario:
[   11.594156]
[   11.595456]        CPU0                    CPU1
[   11.596452]        ----                    ----
[   11.597377]   lock(&ff->mutex);
[   11.598004] lock(&dev->mutex#2);
[   11.599163] lock(&ff->mutex);
[   11.600282]   lock(&newdev->mutex);
[   11.600982]
[   11.600982]  *** DEADLOCK ***
[   11.600982]
[   11.602144] 2 locks held by fftest/200:
[   11.602915]  #0: 000000006ae3e58b (&evdev->mutex){+.+.}, at: 
evdev_ioctl_handler+0x48/0xbd0
[   11.604581]  #1: 000000004113875e (&ff->mutex){+.+.}, at: 
input_ff_upload+0xa6/0x250
[   11.606110]
[   11.606110] stack backtrace:
[   11.606982] CPU: 0 PID: 200 Comm: fftest Not tainted 5.0.0-rc7+ #5
[   11.608140] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.11.0-0-g63451fc-prebuilt.qemu-project.org 04/01/2014
[   11.610344] Call Trace:
[   11.610827]  dump_stack+0x67/0x9b
[   11.611470]  print_circular_bug.isra.35+0x1ce/0x1db
[   11.612392]  __lock_acquire+0x15e4/0x1650
[   11.613188]  ? _raw_spin_unlock_irq+0x24/0x30
[   11.614045]  ? lock_acquire+0xa7/0x1b0
[   11.614793]  lock_acquire+0xa7/0x1b0
[   11.615489]  ? uinput_request_submit+0x10a/0x320 [uinput]
[   11.616526]  ? uinput_request_submit+0x10a/0x320 [uinput]
[   11.617562]  __mutex_lock+0x7d/0x9a0
[   11.618243]  ? uinput_request_submit+0x10a/0x320 [uinput]
[   11.619234]  ? vprintk_emit+0xec/0x260
[   11.620271]  ? printk+0x4d/0x69
[   11.621158]  ? uinput_request_submit+0x10a/0x320 [uinput]
[   11.622464]  uinput_request_submit+0x10a/0x320 [uinput]
[   11.623587]  uinput_dev_upload_effect+0x76/0xb0 [uinput]
[   11.624788]  ? find_held_lock+0x2d/0x90
[   11.625633]  input_ff_upload+0x1c0/0x250
[   11.626524]  evdev_ioctl_handler+0x388/0xbd0
[   11.627439]  do_vfs_ioctl+0xa0/0x6e0
[   11.628215]  ksys_ioctl+0x6b/0x80
[   11.628967]  __x64_sys_ioctl+0x11/0x20
[   11.629734]  do_syscall_64+0x4b/0x180
[   11.630483]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   11.631508] RIP: 0033:0x7f2d99a76467
[   11.632220] Code: b3 66 90 48 8b 05 31 4a 2c 00 64 c7 00 26 00 00 00 
48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 01 4a 2c 00 f7 d8 64 89 01 48
[   11.635876] RSP: 002b:00007ffe1ab6fbd8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[   11.637355] RAX: ffffffffffffffda RBX: 00007ffe1ab6fc50 RCX: 
00007f2d99a76467
[   11.638766] RDX: 00007ffe1ab6fd10 RSI: 0000000040304580 RDI: 
0000000000000003
[   11.640177] RBP: 0000000000000003 R08: 00007f2d99d3d880 R09: 
00007f2d99f47500
[   11.641679] R10: 000055c75edf2140 R11: 0000000000000246 R12: 
000055c75edf1a80
[   11.643211] R13: 00007ffe1ab6feb0 R14: 0000000000000000 R15: 
0000000000000000

>
