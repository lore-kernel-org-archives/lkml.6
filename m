Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1970493-1523973757-2-15607955117066425860
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
    1523973756; b=lDRBdsalOvRySLSlXag3V1AQmjiuG8QzRYGw2k8tSAeC613wPy
    IvqWls1vtrfka1k+b1ho7sj8T2zsEgfdmkFKkhk4z66YZOKHQT6Py6k7bDZqx4iR
    043GD6U+107WfUj0kx0/DLW88d8SpsIZpSq+9F6DwGduJawpQ/reJPoJ2v6o5Cfv
    W7xBtU7gjBgIIpD7LyDLkWbcSYuCV8PeHm4C1kGYlUg2d+ZdWV2opVVIs23JwfFF
    CPPkzSzS+tqDLzAzVT6mzA6NpCwH3B8u1Opj+4aSddgOWeckoYt67Ba9MQ7x2N6Z
    a4IogVh6DLycpvJw9Hgg17A4EafMo1zr2Ziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523973756; bh=T/BkVoPJmXIjYKli2KZ9EeUbQe3Fbi
    U5zVdxTXtxN/M=; b=SZAfsoRtt0nKHAxr4Fub18tPSqaGt00CZdAzNa7eoslcLT
    RT2ihUAyQpuAj3xyzuMpqgxUbjhYfOLK4nMOx1fu4Qa30b0jHmL0sROqbrS4OxOL
    tnkKINRp+n9YNCHsf/q9uWKg77W1O94pkI++EdJLO5ZxhsTiTI/3ZSqr79oqb74y
    oktztyUg+GDn/X74JV2LOzeqyl2y2O5+GVoKO7Ir0XTCGwnrDhiAM0DcV3CRlc6S
    Tdy20TMV6gwQfDxwlkTi+lstwyXr8v1w3ekBBRPIeomx+Q4g0985K1FeW4HT1jr+
    wocIWVLdF2tK5A59xBFUcGwmdIgRKSl3P8GE1vRQ==
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
X-CM-Envelope: MS4wfK/NcvtVGDjhRQKBFzWUjfs7FiGEENVnMWp4BhnA/bfk0rJ/LkSo9maRQ7H3mK/RJuVJ4ySb9AD5ITtyGsoVGGSP7UWd4U9vx2SZcbxT4mLe6icyPhKL
    aEqNmqR2C+gCjaw8ujeNB/KXOFluxUVC0UYVuPkX7TpMDz8uiH5lgS6HjIZZ6kgtqPBneAttV9xqsMTTOpT3ZG+8CtvALSK5CP2AR+sZvfYqstJWJIeFPR/T
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=NEAV23lmAAAA:8 a=D19gQVrFAAAA:8 a=iox4zFpeAAAA:8 a=Sq2z3dAKVs5DyvwRcG0A:9
    a=CjuIK1q_8ugA:10 a=W4TVW4IDbPiebHqcZpNg:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeDQOCe (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 10:02:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:51107 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751857AbeDQOCe (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 10:02:34 -0400
Date: Tue, 17 Apr 2018 16:02:31 +0200
From: Jan Kara <jack@suse.cz>
To: Pavlos Parissis <pavlos.parissis@gmail.com>
Cc: Jan Kara <jack@suse.cz>, mszeredi@redhat.com, amir73il@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: kernel 4.14.x crash around fsnotify_mark_connector
Message-ID: <20180417140231.75fi4ek2q77qilta@quack2.suse.cz>
References: <e7323798-3175-3d27-fdd1-349f1422cb26@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7323798-3175-3d27-fdd1-349f1422cb26@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 17-04-18 12:39:32, Pavlos Parissis wrote:
> In one of our production servers where we run kernel version 4.14.32, I noticed
> the following:

OK, I was looking into this for some time and couldn't find a problem in
4.14.32 code. Can you try running a kernel with CONFIG_DEBUG_SLAB and
CONFIG_DEBUG_PAGEALLOC enabled to hopefully catch the problem earlier?
Thanks!

								Honza

> 
> ----
> [138630.417246] cache_from_obj: Wrong slab cache. fsnotify_mark_connector but
> object is from kmalloc-2048(361:anycast-healthchecker.service)
> [138630.477075] ------------[ cut here ]------------
> [138630.500028] WARNING: CPU: 14 PID: 26002 at mm/slab.h:377
> kmem_cache_free+0x133/0x1c0
> [138630.538130] Modules linked in: netconsole binfmt_misc sctp_diag sctp dccp_diag
> dccp tcp_diag udp_diag inet_diag unix_diag cfg80211 rfkill 8021q garp mrp xfs loop
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel crypto_simd
> glue_helper cryptd iTCO_wdt intel_cstate hpwdt hpilo iTCO_vendor_support sg
> intel_rapl_perf ipmi_si pcspkr ioatdma shpchp lpc_ich i2c_i801 ipmi_devintf dca
> mfd_core wmi ipmi_msghandler nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables
> ext4 mbcache jbd2 i2c_algo_bit sd_mod drm_kms_helper syscopyarea sysfillrect
> sysimgblt fb_sys_fops ttm bnx2x serio_raw mdio libcrc32c crc32c_intel hpsa ptp drm
> scsi_transport_sas pps_core dm_mirror dm_region_hash dm_log dm_mod dax
> [138630.871763] CPU: 14 PID: 26002 Comm: kworker/u66:3 Not tainted
> 4.14.32-1.el7.x86_64 #1
> [138630.910864] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/25/2017
> [138630.943498] Workqueue: events_unbound fsnotify_connector_destroy_workfn
> [138630.976569] task: ffff88203b62ae80 task.stack: ffffc90008a20000
> [138631.005895] RIP: 0010:kmem_cache_free+0x133/0x1c0
> [138631.029230] RSP: 0018:ffffc90008a23e20 EFLAGS: 00010246
> [138631.055217] RAX: 000000000000007c RBX: ffff882000000000 RCX: 0000000000000000
> [138631.091346] RDX: 0000000000000000 RSI: ffff88203f3969d8 RDI: ffff88203f3969d8
> [138631.127139] RBP: ffffc90008a23e38 R08: 0000000000000001 R09: 000000000000057d
> [138631.162575] R10: ffff88102b906cf0 R11: ffff88102b913ea0 R12: ffff88103f579980
> [138631.198018] R13: ffff88203bd57c00 R14: ffff88203bd63f00 R15: ffffffff82128388
> [138631.233371] FS:  0000000000000000(0000) GS:ffff88203f380000(0000)
> knlGS:0000000000000000
> [138631.273426] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [138631.301980] CR2: 0000000003600fd8 CR3: 000000000200a006 CR4: 00000000003606e0
> [138631.338783] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [138631.374525] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [138631.409797] Call Trace:
> [138631.422387]  fsnotify_connector_destroy_workfn+0x68/0x80
> [138631.448516]  process_one_work+0x15c/0x380
> [138631.468352]  worker_thread+0x4d/0x3e0
> [138631.486705]  kthread+0x10c/0x140
> [138631.503091]  ? max_active_store+0x80/0x80
> [138631.523217]  ? __kthread_parkme+0x70/0x70
> [138631.543338]  ? do_syscall_64+0x79/0x1b0
> [138631.562518]  ret_from_fork+0x35/0x40
> [138631.580199] Code: 4c 3b a7 d8 00 00 00 0f 84 11 ff ff ff 48 8b 4f 60 49 8b 54
> 24 60 48 c7 c6 c0 19 c3 81 48 c7 c7 c0 9c e7 81 31 c0 e8 90 a5 eb ff <0f> 0b4c 89
> e7 e9 e9 fe ff ff 65 8b 05 2c 3c de 7e 89 c0 48 0f
> [138631.672489] ---[ end trace 6748d86d682915c2 ]---
> [138631.695691] cache_from_obj: Wrong slab cache. fsnotify_mark_connector but
> object is from kmalloc-2048(361:anycast-healthchecker.service)
> ---
> 
> The kernel was fine and server was responsive.
> A coworker mentioned that it may come from
> https://github.com/torvalds/linux/blob/master/fs/notify/mark.c#L160
> and commit
> 08991e83b728 ("fsnotify: Free fsnotify_mark_connector when there is no mark
> attached") arrived with 4.12-rc1 may be the cause of it.
> 
> I am wondering if it is related to the issue I reported
> https://lkml.org/lkml/2018/4/16/506. But, that issue causes the whole server to
> crash, which is not the case for above kernel dump.
> 
> 
> Cheers,
> Pavlos
> 



-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
