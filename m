Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3398102-1523889683-2-1343630328501725043
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523889681; b=WfkueiQ9yS60Bw7BoW4pE/8J9wxiSg9UjAamh0B513n7YgOD3x
    Vj9kBPTo50EiD5EufRhZomLsY8Oh2jzr/L3yuHjPdRWYAXqrVqgXr4ECia7/GnXG
    LKcPPmwe4n1LtAgixJsZulKvBU6mpBdeAyIWHSi0WVHSxd7avZjZJ5X/HcXJ1u0b
    muD/qofYCEVr0gd9YjyvORpAQmHwuNBFxydya2BdazDPOfp54uK47Vs6WKccn7SA
    HtyoT79e9g8OiO78sSfsyd1DNT/ynXIYd8Mq0LQ5v+7O/8bgDsscxFqcCxW7ezXC
    R0gJ+lGsjjpF/eGAQUti4WSE0aMTzb/o/MQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523889681; bh=L1eDSOEaGOnXydeRqY9Yrs5cOO3vBM
    qdgwJ6xmI36K8=; b=EQ32AxBF7DMqDjrIBd3GOq0nh4cokGiVuGnuIY9x9v/kt/
    0JtShWRlrPAXwsylnH3RvjBh/8+CQvoXhEz5+retNu6cN5hPuX/0+5gYHQj6teDP
    aHQoJQCcaWvBg6jiGvlHjq3laYMJDLbmJdM/iqYFdc83E8R8oPYR1aJ98frSWLqz
    vSR5IHt+ADiEyWX1WGLH5w5f6xxUydPLM+gw3HIFYoMML+SPP8/E3N4RJP04MCvZ
    ac81fK9xTr3lWf7MxpCZrOiEmre7Hj3zsN7wEKeqn+iNPvx68q2r0Pd4M9gzTIgM
    7fosmzG7SchEFjUbzjztalCuWUtaeIdhxVyLJsoA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL3647KuLvwEpVUptDk+QG8trkSJPgr6ZXoll5XYliTdMqLpqESmiz9KNY1SVgd/mUhznr3iKvhn8HAOIrjuwoYwdiYls5YvOUSuk9zS4I/jUJ8KM1I2
    7lGF4YbAfjwWSl2omyQnHFIJx8S3fweeUNdE4ptdSxskelToO2iVdGynhrUV+YoL4kTOhF2iaknmpzowhO5mhWK0Pam4GvcrhVdR000Pdi8SXf5UpQONFAwI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=D19gQVrFAAAA:8 a=iox4zFpeAAAA:8 a=gqUpdahPSzbiZuHnz74A:9
    a=ZOLDnZxNIvJkZWbh:21 a=ek3MM_dPPQhRP4_G:21 a=CjuIK1q_8ugA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeDPOkp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 10:40:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:56438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbeDPOkn (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 10:40:43 -0400
Date: Mon, 16 Apr 2018 16:40:41 +0200
From: Jan Kara <jack@suse.cz>
To: Guillaume Morin <guillaume@morinfr.org>
Cc: Pavlos Parissis <pavlos.parissis@gmail.com>,
        stable@vger.kernel.org, decui@microsoft.com, jack@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: kernel panics with 4.14.X versions
Message-ID: <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 16-04-18 15:25:50, Guillaume Morin wrote:
> Fwiw, there have been already reports of similar soft lockups in
> fsnotify() on 4.14: https://lkml.org/lkml/2018/3/2/1038
>
> We have also noticed similar softlockups with 4.14.22 here.

Yeah.
 
> On 16 Apr 13:54, Pavlos Parissis wrote:
> >
> > Hi all,
> > 
> > We have observed kernel panics on several master kubernetes clusters, where we run
> > kubernetes API services and not application workloads.
> > 
> > Those clusters use kernel version 4.14.14 and 4.14.32, but we switched everything
> > to kernel version 4.14.32 as a way to address the issue.
> > 
> > We have HP and Dell hardware on those clusters, and network cards are also different,
> > we have bnx2x and mlx5_core in use.
> > 
> > We also run kernel version 4.14.32 on different type of workloads, software load
> > balancing using HAProxy, and we don't have any crashes there.
> > 
> > Since the crash happens on different hardware, we think it could be a kernel issue,
> > but we aren't sure about it. Thus, I am contacting kernel people in order to get some
> > hint, which can help us to figure out what causes this.
> > 
> > In our kubernetes clusters, we have instructed the kernel to panic upon soft lockup,
> > we use 'kernel.softlockup_panic=1', 'kernel.hung_task_panic=1' and 'kernel.watchdog_thresh=10'.
> > Thus, we see the stack traces. Today, we have disabled this, later I will explain why.
> > 
> > I believe we have two discint types of panics, one is trigger upon soft lockup and another one
> > where the call trace is about scheduler("sched: Unexpected reschedule of offline CPU#8!)
> > 
> > 
> > Let me walk you through the kernel panics and some observations.
> > 
> > The followin series of stack traces are happening when one CPU (CPU 24) is stuck for ~22 seconds.
> > watchdog_thresh is set to 10 and as far as I remember softlockup threshold is (2 * watchdog_thresh),
> > so it makes sense to see the kernel crashing after ~20seconds.
> > 
> > After the stack trace, we have the output of sar for CPU#24 and we see that just before the
> > crash CPU utilization for system level went to 100%. Now let's move to another panic.
> > 
> > [373782.361064] watchdog: BUG: soft lockup - CPU#24 stuck for 22s! [kube-apiserver:24261]
> > [373782.378225] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag dccp tcp_diag udp_diag
> > inet_diag unix_diag cfg80211 rfkill dell_rbu 8021q garp mrp xfs libcrc32c loop x86_pkg_temp_thermal
> > intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
> > pcbc aesni_intel vfat fat crypto_simd glue_helper cryptd intel_cstate intel_rapl_perf iTCO_wdt ses
> > iTCO_vendor_support mxm_wmi ipmi_si dcdbas enclosure mei_me pcspkr ipmi_devintf lpc_ich sg mei
> > ipmi_msghandler mfd_core shpchp wmi acpi_power_meter netconsole nfsd auth_rpcgss nfs_acl lockd grace
> > sunrpc ip_tables ext4 mbcache jbd2 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
> > fb_sys_fops sd_mod ttm crc32c_intel ahci libahci mlx5_core drm mlxfw mpt3sas ptp libata raid_class
> > pps_core scsi_transport_sas
> > [373782.516807]  dm_mirror dm_region_hash dm_log dm_mod dax
> > [373782.531739] CPU: 24 PID: 24261 Comm: kube-apiserver Not tainted 4.14.32-1.el7.x86_64 #1
> > [373782.549848] Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.4.3 01/17/2017
> > [373782.567486] task: ffff882f66d28000 task.stack: ffffc9002120c000
> > [373782.583441] RIP: 0010:fsnotify+0x197/0x510
> > [373782.597319] RSP: 0018:ffffc9002120fdb8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff10
> > [373782.615308] RAX: 0000000000000000 RBX: ffff882f9ec65c20 RCX: 0000000000000002
> > [373782.632950] RDX: 0000000000028700 RSI: 0000000000000002 RDI: ffffffff8269a4e0
> > [373782.650616] RBP: ffffc9002120fe98 R08: 0000000000000000 R09: 0000000000000000
> > [373782.668287] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > [373782.685918] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [373782.703302] FS:  000000c42009f090(0000) GS:ffff882fbf900000(0000) knlGS:0000000000000000
> > [373782.721887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [373782.737741] CR2: 00007f82b6539244 CR3: 0000002f3de2a005 CR4: 00000000003606e0
> > [373782.755247] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [373782.772722] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [373782.790043] Call Trace:
> > [373782.802041]  vfs_write+0x151/0x1b0
> > [373782.815081]  ? syscall_trace_enter+0x1cd/0x2b0
> > [373782.829175]  SyS_write+0x55/0xc0
> > [373782.841870]  do_syscall_64+0x79/0x1b0
> > [373782.855073]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Can you please run RIP through ./scripts/faddr2line to see where exactly
are we looping? I expect the loop iterating over marks to notify but better
be sure.

How easily can you hit this? Are you able to run debug kernels / inspect
crash dumps when the issue occurs? Also testing with the latest mainline
kernel (4.16) would be welcome whether this isn't just an issue with the
backport of fsnotify fixes from Miklos.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
