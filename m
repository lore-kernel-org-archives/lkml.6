Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A6FC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 20:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C070E20855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 20:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcdC4IsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfBBUHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 15:07:40 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44611 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfBBUHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 15:07:40 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so8705949iod.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 12:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aaO1/J9H8D6K96lmy2ZTnkecW4P++/o/2IyBLh6Kh7o=;
        b=DcdC4IsBm/Im1eScrB9lJezTskieg8KgABX/WGqN4WP9vg9lPJpAaxImhOWynVZpK+
         PAS7aOAwHGY6szenYWPUv5hXeFcAGrfNIxy0GMYmD4RDHxD4+c8XIqIORCAaXouSG+b3
         AbEIONcK5KiHA1/6ne7DtO4Q4lu0s6z3i3LOkygjrJPC5mE5Tp3ZjboIlLgIgRhBtSqg
         ivc4WsyVL8cam/gPEZtm+16xmlBUwmDu9LdnEiaowhVTE77HyjbMVMlFmgw5+Ds3sTiC
         dE9WpSdAOsmH4xLfUdj/cFwg+e+Pbdb0Fs96nOQxNS7J2cpcRxpAdABv3QZIZoKlJhVJ
         cI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aaO1/J9H8D6K96lmy2ZTnkecW4P++/o/2IyBLh6Kh7o=;
        b=IO3v71+vZmx4IkI5FsWSjTe0HIxCbLkgSux8bsdI2HpllOOwaOm6wIycsTX5P5RVYD
         XAZpRMBpiAjgoIBeg2N91Hnqy1RR4Gwf8HNIA2xfLkEVmvs1h+uM0fF8XDfmuiI85i+O
         iPSa/11UCjJGzdUjjcIpPFBGdfKs6tes5aRX3RP+uenNcou9DAU6fAYVW+fEQznoJTIQ
         NDfA0CZiQ7/D3WHZpTlhiy77/h1b8fSvLMw9LCE02q65Wgai8shxqvVKgPPTmsueBmdN
         2TVsX2evZl0cBsz0o8GJ/EqbP3inxsQglU0C6w1UNvUAiHmZ+8BuxBM7mJCTCSupetK9
         sFvg==
X-Gm-Message-State: AHQUAua820HmY+ZocOLIF1EdSQjYnRnjdTzdaSs0tZqpwSHHySfnsgyj
        BGMkF2yZ77O/bC6lMlk49uI=
X-Google-Smtp-Source: AHgI3IYVT1b4DKE49MWJ1k0/SoalItNeGTNpZZS7lRJRjGUAv9OiAc9bm0gaXsZiO9z1Dn3lFtiJwg==
X-Received: by 2002:a6b:f319:: with SMTP id m25mr3782741ioh.30.1549138058751;
        Sat, 02 Feb 2019 12:07:38 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id f4sm4354671iop.70.2019.02.02.12.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 12:07:38 -0800 (PST)
Date:   Sat, 2 Feb 2019 15:07:35 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Message-ID: <20190202200735.GA2637@ubu-Virtual-Machine>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <PU1P153MB0169EB8CFC0A69407A8AE2C2BF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190122064246.GA28613@ubu-Virtual-Machine>
 <PU1P153MB01696D28CDDC098307EBD5AFBF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190128195845.GA3723@ubu-Virtual-Machine>
 <PU1P153MB01699B96311157EA9DF515E6BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190131151958.GT3973@sasha-vm>
 <DM5PR2101MB091847B2B68D7F9F2050CE45D7910@DM5PR2101MB0918.namprd21.prod.outlook.com>
 <20190131174707.GA2055@ubu-Virtual-Machine>
 <PU1P153MB0169227534F832C2DAEC02B4BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169227534F832C2DAEC02B4BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 06:24:24PM +0000, Dexuan Cui wrote:
> > From: Kimberly Brown <kimbrownkd@gmail.com>
> > Sent: Thursday, January 31, 2019 9:47 AM
> > ...
> > 2) Prevent a deadlock that can occur between the proposed mutex_lock()
> > call in the vmbus_chan_attr_show() function and the sysfs/kernfs functions.
> Hi Kim,
> Can you please share more details about the deadlock? 
> It's unclear to me how the deadlock happens.
>

Hi Dexuan,

I encountered the deadlock by:
1) Adding a call to msleep() before acquiring the mutex in
vmbus_chan_attr_show()
2) Opening a hv_netvsc subchannel's sysfs file
3) Removing hv_netvsc while the sysfs file is opening

Here's the lockdep output:

[  164.167699] hv_vmbus: unregistering driver hv_netvsc

[  164.171660] ======================================================
[  164.171661] WARNING: possible circular locking dependency detected
[  164.171663] 5.0.0-rc1+ #58 Not tainted
[  164.171664] ------------------------------------------------------
[  164.171666] kworker/0:1/12 is trying to acquire lock:
[  164.171668] 00000000664f9893 (kn->count#43){++++}, at: kernfs_remove+0x23/0x40
[  164.171676]
               but task is already holding lock:
[  164.171677] 000000007b9e8443 (&vmbus_connection.channel_mutex){+.+.}, at: vmbus_onoffer_rescind+0x1ae/0x210 [hv_vmbus]
[  164.171686]
               which lock already depends on the new lock.

[  164.171687]
               the existing dependency chain (in reverse order) is:
[  164.171688]
               -> #1 (&vmbus_connection.channel_mutex){+.+.}:
[  164.171694]        __mutex_lock+0x65/0x9b0
[  164.171696]        mutex_lock_nested+0x1b/0x20
[  164.171700]        vmbus_chan_attr_show+0x3f/0x90 [hv_vmbus]
[  164.171703]        sysfs_kf_seq_show+0xa4/0x130
[  164.171705]        kernfs_seq_show+0x2d/0x30
[  164.171708]        seq_read+0xe2/0x410
[  164.171711]        kernfs_fop_read+0x14e/0x1a0
[  164.171714]        __vfs_read+0x3a/0x1a0
[  164.171716]        vfs_read+0x91/0x140
[  164.171718]        ksys_read+0x58/0xc0
[  164.171721]        __x64_sys_read+0x1a/0x20
[  164.171724]        do_syscall_64+0x65/0x1b0
[  164.171727]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  164.171728]
               -> #0 (kn->count#43){++++}:
[  164.171732]        lock_acquire+0xa3/0x180
[  164.171734]        __kernfs_remove+0x278/0x300
[  164.171737]        kernfs_remove+0x23/0x40
[  164.171739]        sysfs_remove_dir+0x51/0x60
[  164.171741]        kobject_del.part.7+0x13/0x40
[  164.171743]        kobject_put+0x6a/0x1a0
[  164.171748]        hv_process_channel_removal+0xfe/0x180 [hv_vmbus]
[  164.171752]        vmbus_onoffer_rescind+0x20a/0x210 [hv_vmbus]
[  164.171756]        vmbus_onmessage+0x5f/0x150 [hv_vmbus]
[  164.171760]        vmbus_onmessage_work+0x22/0x30 [hv_vmbus]
[  164.171763]        process_one_work+0x291/0x5c0
[  164.171765]        worker_thread+0x34/0x400
[  164.171767]        kthread+0x124/0x140
[  164.171770]        ret_from_fork+0x3a/0x50
[  164.171771]
               other info that might help us debug this:

[  164.171772]  Possible unsafe locking scenario:

[  164.171773]        CPU0                    CPU1
[  164.171775]        ----                    ----
[  164.171776]   lock(&vmbus_connection.channel_mutex);
[  164.171777]                                lock(kn->count#43);
[  164.171779]                                lock(&vmbus_connection.channel_mutex);
[  164.171781]   lock(kn->count#43);
[  164.171783]
                *** DEADLOCK ***

[  164.171785] 3 locks held by kworker/0:1/12:
[  164.171786]  #0: 000000002128b29f ((wq_completion)"events"){+.+.}, at: process_one_work+0x20f/0x5c0
[  164.171790]  #1: 0000000041d2602c ((work_completion)(&ctx->work)){+.+.}, at: process_one_work+0x20f/0x5c0
[  164.171794]  #2: 000000007b9e8443 (&vmbus_connection.channel_mutex){+.+.}, at: vmbus_onoffer_rescind+0x1ae/0x210 [hv_vmbus]
[  164.171799]
               stack backtrace:
[  164.171802] CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.0.0-rc1+ #58
[  164.171804] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v3.0 03/02/2018
[  164.171809] Workqueue: events vmbus_onmessage_work [hv_vmbus]
[  164.171811] Call Trace:
[  164.171816]  dump_stack+0x8e/0xd5
[  164.171819]  print_circular_bug.isra.37+0x1e7/0x1f5
[  164.171822]  __lock_acquire+0x1427/0x1490
[  164.171826]  ? sched_clock+0x9/0x10
[  164.171830]  lock_acquire+0xa3/0x180
[  164.171832]  ? lock_acquire+0xa3/0x180
[  164.171835]  ? kernfs_remove+0x23/0x40
[  164.171838]  __kernfs_remove+0x278/0x300
[  164.171840]  ? kernfs_remove+0x23/0x40
[  164.171843]  kernfs_remove+0x23/0x40
[  164.171846]  sysfs_remove_dir+0x51/0x60
[  164.171848]  kobject_del.part.7+0x13/0x40
[  164.171850]  kobject_put+0x6a/0x1a0
[  164.171855]  hv_process_channel_removal+0xfe/0x180 [hv_vmbus]
[  164.171859]  vmbus_onoffer_rescind+0x20a/0x210 [hv_vmbus]
[  164.171863]  vmbus_onmessage+0x5f/0x150 [hv_vmbus]
[  164.171868]  vmbus_onmessage_work+0x22/0x30 [hv_vmbus]
[  164.171870]  process_one_work+0x291/0x5c0
[  164.171874]  worker_thread+0x34/0x400
[  164.171877]  kthread+0x124/0x140
[  164.171879]  ? process_one_work+0x5c0/0x5c0
[  164.171881]  ? kthread_park+0x90/0x90
[  164.171884]  ret_from_fork+0x3a/0x50

==========================================================================


> > I've identified two possible solutions to the deadlock:
> > 
> > 1) Add a new mutex to the vmbus_channel struct which protects changes to
> > "channel->state". Use this new mutex in vmbus_chan_attr_show() instead of
> > "vmbus_connection.channel_mutex".
> > 
> > 2) Use "vmbus_connection.channel_mutex" in vmbus_chan_attr_show() as
> > originally proposed, and acquire it with mutex_trylock(). If the mutex
> > cannot be acquired, return -EINVAL.
> It looks more like a workaround. IMO we should try to find a real fix. :-)
>  

Good point. I think that the root cause of the deadlock problem is that
the calls to free_channel() in hv_process_channel_removal() are within a
section that's locked with vmbus_connection.channel_mutex. So, first, I
need to determine whether free_channel() needs to be called within the
locked section.

If free_channel() does need to be called within the locked section, then
there's no way to prevent the possibility of a deadlock when
vmbus_connection.channel_mutex is used in vmbus_chan_attr_show(). A
different solution, such as a new mutex to protect changes to
"channel->state", is necessary.

If free_channel() does not need to be in the locked section, then we may
be able to restructure the functions to prevent the deadlock.

I see that there was a race condition problem when
hv_process_channel_removal() was called on an already freed channel
(fixed in commit 192b2d78722f, "Fix bugs in rescind handling"), so I
suspect that free_channel() needs to stay in the locked section.


> > I'm leaning towards (2), using mutex_trylock().
> > "vmbus_connection.channel_mutex"
> > appears to be used only when a channel is being opened or closed, so
> > vmbus_chan_attr_show() should be able to acquire the mutex when the
> > channel is in use.
> > 
> > If anyone has suggestions, please let me know.
> > 
> > Thanks,
> > Kim
> 
> Thanks,
> -- Dexuan
