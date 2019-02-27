Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD32C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B8521852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD+lbxUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbfB0Hy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 02:54:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36911 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfB0Hy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 02:54:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id a17so13111612ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 23:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOUVDW1u2YJrjevVo2DaHqQ2pWNximO869Q7Q5eCJAo=;
        b=QD+lbxUQ5n6g98Q1zy8O5jY+EDqQ9Xb6DeMgYQXxIn91RuNwsC9b+TynZj8qk1cf+k
         n/JkZiq2vqdKVEZ3DG30Wht3btieEWuJ7dyDS2B92tYFzkQf4je0r9HrTBhB+D2x4N/q
         aV4lOzQa4ripGQIbL86VH5Y9x5lfo4HQxRhIGCBskTUPo1PrQLbp+1841WMgZZpTcc8P
         RurmfE/3PA6bwSDwE5MwCxmywMnytN8pt9BSIMh21GD6h1AoKjzxS/3FxcBSkW2OpVeU
         75fW5r/IcYnUIsD9JdgUWs1zGEOk1bmY/HtIj1S/yF5grqW9uxGa+Wk+IX0Sj8kyMAmJ
         5uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOUVDW1u2YJrjevVo2DaHqQ2pWNximO869Q7Q5eCJAo=;
        b=aCq5wR9HYvheTmv97CzcxiPprOtBHyYti812B2sCzBezOyc2dqgxDCM6MtFDm6dZ66
         cgULtEhZRkFnAVPIGZbljXZglJrepdHKrS1Zs3J7v1BPQ6o9o44mKHBPyrC/xMWOzhUb
         6I0WrVOps/mnjp6EbUNIWaEpFAt/aBxkrcZCdjDnfwRwt3hTZNgFD0/zUVsrDKfw237G
         KbNSsfX73I8Pme+8DlTo0OVXw9v7Yq9IeUL8oOias6ee7GePn6caPgbdRW1qysciUN72
         tYrglfjXMnkdv8hKCsDQUH10xCpUQO5Npaskaa2ycXtah5eq/3oDGMoYZRlBP+n5rFFk
         p30g==
X-Gm-Message-State: APjAAAUHX8YvCvudY2gM+psO1IJknjAE5zNOFOLSq3pxEmeA4zUIxuZ4
        oJsJrJg+nZLD8ryfDCgl5BehSiVGW07XoBmNUVc=
X-Google-Smtp-Source: AHgI3IYi47BtVhydIaEFSS6h6V9/AN4XTgkOaIye4KB46Db0falW7eYY/sbVnip9dz5Sde3/dcxT67cAP+75Tyc6ByE=
X-Received: by 2002:a2e:a28b:: with SMTP id k11mr574556lja.176.1551254095901;
 Tue, 26 Feb 2019 23:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org> <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190218204020.GV32494@hirez.programming.kicks-ass.net> <407b6589-1801-20b5-e3b7-d7458370cfc0@redhat.com>
 <20190222142030.GA32494@hirez.programming.kicks-ass.net> <786668c1-fb52-508c-e916-f86707a1d791@linux.intel.com>
 <CAERHkruwfKWzP6gySSEFGWKkG9-tZm5YybyUONatkRhULx_nBA@mail.gmail.com>
In-Reply-To: <CAERHkruwfKWzP6gySSEFGWKkG9-tZm5YybyUONatkRhULx_nBA@mail.gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Wed, 27 Feb 2019 15:54:44 +0800
Message-ID: <CAERHkrvHyJceCG+NX381b6Stx28tFBwJ_Pt+Zckz2QWVUyeaQg@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        subhra.mazumdar@oracle.com,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 4:26 PM Aubrey Li <aubrey.intel@gmail.com> wrote:
>
> On Sat, Feb 23, 2019 at 3:27 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >
> > On 2/22/19 6:20 AM, Peter Zijlstra wrote:
> > > On Fri, Feb 22, 2019 at 01:17:01PM +0100, Paolo Bonzini wrote:
> > >> On 18/02/19 21:40, Peter Zijlstra wrote:
> > >>> On Mon, Feb 18, 2019 at 09:49:10AM -0800, Linus Torvalds wrote:
> > >>>> On Mon, Feb 18, 2019 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >>>>>
> > >>>>> However; whichever way around you turn this cookie; it is expensive and nasty.
> > >>>>
> > >>>> Do you (or anybody else) have numbers for real loads?
> > >>>>
> > >>>> Because performance is all that matters. If performance is bad, then
> > >>>> it's pointless, since just turning off SMT is the answer.
> > >>>
> > >>> Not for these patches; they stopped crashing only yesterday and I
> > >>> cleaned them up and send them out.
> > >>>
> > >>> The previous version; which was more horrible; but L1TF complete, was
> > >>> between OK-ish and horrible depending on the number of VMEXITs a
> > >>> workload had.
> > >>>
> > >>> If there were close to no VMEXITs, it beat smt=off, if there were lots
> > >>> of VMEXITs it was far far worse. Supposedly hosting people try their
> > >>> very bestest to have no VMEXITs so it mostly works for them (with the
> > >>> obvious exception of single VCPU guests).
> > >>
> > >> If you are giving access to dedicated cores to guests, you also let them
> > >> do PAUSE/HLT/MWAIT without vmexits and the host just thinks it's a CPU
> > >> bound workload.
> > >>
> > >> In any case, IIUC what you are looking for is:
> > >>
> > >> 1) take a benchmark that *is* helped by SMT, this will be something CPU
> > >> bound.
> > >>
> > >> 2) compare two runs, one without SMT and without core scheduler, and one
> > >> with SMT+core scheduler.
> > >>
> > >> 3) find out whether performance is helped by SMT despite the increased
> > >> overhead of the core scheduler
> > >>
> > >> Do you want some other load in the host, so that the scheduler actually
> > >> does do something?  Or is the point just that you show that the
> > >> performance isn't affected when the scheduler does not have anything to
> > >> do (which should be obvious, but having numbers is always better)?
> > >
> > > Well, what _I_ want is for all this to just go away :-)
> > >
> > > Tim did much of testing last time around; and I don't think he did
> > > core-pinning of VMs much (although I'm sure he did some of that). I'm
> >
> > Yes. The last time around I tested basic scenarios like:
> > 1. single VM pinned on a core
> > 2. 2 VMs pinned on a core
> > 3. system oversubscription (no pinning)
> >
> > In general, CPU bound benchmarks and even things without too much I/O
> > causing lots of VMexits perform better with HT than without for Peter's
> > last patchset.
> >
> > > still a complete virt noob; I can barely boot a VM to save my life.
> > >
> > > (you should be glad to not have heard my cursing at qemu cmdline when
> > > trying to reproduce some of Tim's results -- lets just say that I can
> > > deal with gpg)
> > >
> > > I'm sure he tried some oversubscribed scenarios without pinning.
> >
> > We did try some oversubscribed scenarios like SPECVirt, that tried to
> > squeeze tons of VMs on a single system in over subscription mode.
> >
> > There're two main problems in the last go around:
> >
> > 1. Workload with high rate of Vmexits (SpecVirt is one)
> > were a major source of pain when we tried Peter's previous patchset.
> > The switch from vcpus to qemu and back in previous version of Peter's patch
> > requires some coordination between the hyperthread siblings via IPI.  And for
> > workload that does this a lot, the overhead quickly added up.
> >
> > For Peter's new patch, this overhead hopefully would be reduced and give
> > better performance.
> >
> > 2. Load balancing is quite tricky.  Peter's last patchset did not have
> > load balancing for consolidating compatible running threads.
> > I did some non-sophisticated load balancing
> > to pair vcpus up.  But the constant vcpu migrations overhead probably ate up
> > any improvements from better load pairing.  So I didn't get much
> > improvement in the over-subscription case when turning on load balancing
> > to consolidate the VCPUs of the same VM. We'll probably have to try
> > out this incarnation of Peter's patch and see how well the load balancing
> > works.
> >
> > I'll try to line up some benchmarking folks to do some tests.
>
> I can help to do some basic tests.
>
> Cgroup bias looks weird to me. If I have hundreds of cgroups, should I turn
> core scheduling(cpu.tag) on one by one? Or Is there a global knob I missed?
>

I encountered the following panic when I turned core sched on in a
cgroup when the cgroup
was running a best effort workload with high CPU utilization.

Feb 27 01:51:53 aubrey-ivb kernel: [  508.981348] core sched enabled
[  508.990627] BUG: unable to handle kernel NULL pointer dereference
at 000000000000008
[  508.999445] #PF error: [normal kernel read fault]
[  509.004772] PGD 8000001807b7d067 P4D 8000001807b7d067 PUD
18071c9067 PMD 0
[  509.012616] Oops: 0000 [#1] SMP PTI
[  509.016568] CPU: 24 PID: 3503 Comm: schbench Tainted: G          I
     5.0.0-rc8-4
[  509.027918] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.92
[  509.039475] RIP: 0010:rb_insert_color+0x17/0x190
[  509.044707] Code: f3 c3 31 c0 c3 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 48 8b 174
[  509.065765] RSP: 0000:ffffc90009203c08 EFLAGS: 00010046
[  509.071671] RAX: 0000000000000000 RBX: ffff889806f91e00 RCX:
ffff889806f91e00
[  509.079715] RDX: ffff889806f83f48 RSI: ffff88980f2238c8 RDI:
ffff889806f92148
[  509.087752] RBP: ffff88980f222cc0 R08: 000000000000026e R09:
ffff88980a099000
[  509.095789] R10: 0000000000000078 R11: ffff88980a099b58 R12:
0000000000000004
[  509.103833] R13: ffffc90009203c68 R14: 0000000000000046 R15:
0000000000022cc0
[  509.111860] FS:  00007f854e7fc700(0000) GS:ffff88980f200000(0000)
knlGS:000000000000
[  509.120957] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  509.127443] CR2: 0000000000000008 CR3: 0000001807b64005 CR4:
00000000000606e0
[  509.135478] Call Trace:
[  509.138285]  enqueue_task+0x6f/0xe0
[  509.142278]  ttwu_do_activate+0x49/0x80
[  509.146654]  try_to_wake_up+0x1dc/0x4c0
[  509.151038]  ? __probe_kernel_read+0x3a/0x70
[  509.155909]  signal_wake_up_state+0x15/0x30
[  509.160683]  zap_process+0x90/0xd0
[  509.164573]  do_coredump+0xdba/0xef0
[  509.168679]  ? _raw_spin_lock+0x1b/0x20
[  509.173045]  ? try_to_wake_up+0x120/0x4c0
[  509.177632]  ? pointer+0x1f9/0x2b0
[  509.181532]  ? sched_clock+0x5/0x10
[  509.185526]  ? sched_clock_cpu+0xc/0xa0
[  509.189911]  ? log_store+0x1b5/0x280
[  509.194002]  get_signal+0x12d/0x6d0
[  509.197998]  ? page_fault+0x8/0x30
[  509.201895]  do_signal+0x30/0x6c0
[  509.205686]  ? signal_wake_up_state+0x15/0x30
[  509.210643]  ? __send_signal+0x306/0x4a0
[  509.215114]  ? show_opcodes+0x93/0xa0
[  509.219286]  ? force_sig_info+0xc7/0xe0
[  509.223653]  ? page_fault+0x8/0x30
[  509.227544]  exit_to_usermode_loop+0x77/0xe0
[  509.232415]  prepare_exit_to_usermode+0x70/0x80
[  509.237569]  retint_user+0x8/0x8
[  509.241273] RIP: 0033:0x7f854e7fbe80
[  509.245357] Code: 00 00 36 2a 0e 00 00 00 00 00 90 be 7f 4e 85 7f
00 00 4c e8 bf a10
[  509.266508] RSP: 002b:00007f854e7fbe50 EFLAGS: 00010246
[  509.272429] RAX: 0000000000000000 RBX: 00000000002dc6c0 RCX:
0000000000000000
[  509.280500] RDX: 00000000000e2a36 RSI: 00007f854e7fbe50 RDI:
0000000000000000
[  509.288563] RBP: 00007f855020a170 R08: 000000005c764199 R09:
00007ffea1bfb0a0
[  509.296624] R10: 00007f854e7fbe30 R11: 000000000002457c R12:
00007f854e7fbed0
[  509.304685] R13: 00007f855e555e6f R14: 0000000000000000 R15:
00007f855020a150
[  509.312738] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nai
[  509.398325] CR2: 0000000000000008
[  509.402116] ---[ end trace f1214a54c044bdb6 ]---
[  509.402118] BUG: unable to handle kernel NULL pointer dereference
at 000000000000008
[  509.402122] #PF error: [normal kernel read fault]
[  509.412727] RIP: 0010:rb_insert_color+0x17/0x190
[  509.416649] PGD 8000001807b7d067 P4D 8000001807b7d067 PUD
18071c9067 PMD 0
[  509.421990] Code: f3 c3 31 c0 c3 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 48 8b 174
[  509.427230] Oops: 0000 [#2] SMP PTI
[  509.435096] RSP: 0000:ffffc90009203c08 EFLAGS: 00010046
[  509.456243] CPU: 2 PID: 3498 Comm: schbench Tainted: G      D   I
    5.0.0-rc8-04
[  509.460222] RAX: 0000000000000000 RBX: ffff889806f91e00 RCX:
ffff889806f91e00
[  509.460224] RDX: ffff889806f83f48 RSI: ffff88980f2238c8 RDI:
ffff889806f92148
[  509.466152] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.92
[  509.466159] RIP: 0010:task_tick_fair+0xb3/0x290
[  509.477458] RBP: ffff88980f222cc0 R08: 000000000000026e R09:
ffff88980a099000
[  509.477461] R10: 0000000000000078 R11: ffff88980a099b58 R12:
0000000000000004
[  509.485521] Code: 2b 53 60 48 39 d0 0f 82 a0 00 00 00 8b 0d 29 ab
19 01 48 39 ca 728
[  509.485523] RSP: 0000:ffff888c0f083e60 EFLAGS: 00010046
[  509.493583] R13: ffffc90009203c68 R14: 0000000000000046 R15:
0000000000022cc0
[  509.493586] FS:  00007f854e7fc700(0000) GS:ffff88980f200000(0000)
knlGS:000000000000
[  509.505170] RAX: 0000000000b71aff RBX: ffff888be4df3800 RCX:
0000000000000000
[  509.505173] RDX: 00000525112fc50e RSI: 0000000000000000 RDI:
0000000000000000
[  509.510318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  509.510320] CR2: 0000000000000008 CR3: 0000001807b64005 CR4:
00000000000606e0
[  509.518381] RBP: ffff888c0f0a2d40 R08: 0000000001ffffff R09:
0000000000000040
[  509.518383] R10: ffff888c0f083e20 R11: 0000000000405f09 R12:
0000000000000000
[  509.617516] R13: ffff889806f81e00 R14: ffff888c0f0a2cc0 R15:
0000000000000000
[  509.625586] FS:  00007f854ffff700(0000) GS:ffff888c0f080000(0000)
knlGS:000000000000
[  509.634742] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  509.641245] CR2: 0000000000000058 CR3: 0000001807b64002 CR4:
00000000000606e0
[  509.649313] Call Trace:
[  509.652131]  <IRQ>
[  509.654462]  ? tick_sched_do_timer+0x60/0x60
[  509.659315]  scheduler_tick+0x84/0x120
[  509.663584]  update_process_times+0x40/0x50
[  509.668345]  tick_sched_handle+0x21/0x70
[  509.672814]  tick_sched_timer+0x37/0x70
[  509.677204]  __hrtimer_run_queues+0x108/0x290
[  509.682163]  hrtimer_interrupt+0xe5/0x240
[  509.686732]  smp_apic_timer_interrupt+0x6a/0x130
[  509.691989]  apic_timer_interrupt+0xf/0x20
[  509.696659]  </IRQ>
[  509.699079] RIP: 0033:0x7ffea1bfe6ac
[  509.703160] Code: 2d 81 e9 ff ff 4c 8b 05 82 e9 ff ff 0f 01 f9 66
90 41 8b 0c 24 39f
[  509.724301] RSP: 002b:00007f854fffedf0 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[  509.732872] RAX: 0000000077e4a044 RBX: 00007f854fffee50 RCX:
0000000000000002
[  509.740941] RDX: 0000000000000166 RSI: 00007f854fffee50 RDI:
0000000000000000
[  509.749001] RBP: 00007f854fffee10 R08: 0000000000000000 R09:
00007ffea1bfb0a0
[  509.757061] R10: 00007ffea1bfb080 R11: 000000000002457e R12:
0000000000000000
[  509.765121] R13: 00007f855e555e6f R14: 0000000000000000 R15:
00007f85500008c0
[  509.773182] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nai
[  509.858758] CR2: 0000000000000058
[  509.862581] ---[ end trace f1214a54c044bdb7 ]---
[  509.862583] BUG: unable to handle kernel NULL pointer dereference
at 000000000000008
[  509.862585] #PF error: [normal kernel read fault]
[  509.873332] RIP: 0010:rb_insert_color+0x17/0x190
[  509.877246] PGD 8000001807b7d067 P4D 8000001807b7d067 PUD
18071c9067 PMD 0
[  509.882592] Code: f3 c3 31 c0 c3 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 48 8b 174
[  509.887828] Oops: 0000 [#3] SMP PTI
[  509.895684] RSP: 0000:ffffc90009203c08 EFLAGS: 00010046
[  509.916828] CPU: 26 PID: 3506 Comm: schbench Tainted: G      D   I
     5.0.0-rc8-4
[  509.920802] RAX: 0000000000000000 RBX: ffff889806f91e00 RCX:
ffff889806f91e00
[  509.920804] RDX: ffff889806f83f48 RSI: ffff88980f2238c8 RDI:
ffff889806f92148
[  509.926726] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.92
[  509.926731] RIP: 0010:task_tick_fair+0xb3/0x290
[  509.938120] RBP: ffff88980f222cc0 R08: 000000000000026e R09:
ffff88980a099000
[  509.938122] R10: 0000000000000078 R11: ffff88980a099b58 R12:
0000000000000004
[  509.946183] Code: 2b 53 60 48 39 d0 0f 82 a0 00 00 00 8b 0d 29 ab
19 01 48 39 ca 728
[  509.946186] RSP: 0000:ffff88980f283e60 EFLAGS: 00010046
[  509.954245] R13: ffffc90009203c68 R14: 0000000000000046 R15:
0000000000022cc0
[  509.954248] FS:  00007f854ffff700(0000) GS:ffff888c0f080000(0000)
knlGS:000000000000
[  509.965836] RAX: 0000000000b71aff RBX: ffff888be4df3800 RCX:
0000000000000000
[  509.965839] RDX: 00000525112fc50e RSI: 0000000000000000 RDI:
0000000000000000
[  509.970981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  509.970983] CR2: 0000000000000058 CR3: 0000001807b64002 CR4:
00000000000606e0
[  509.979043] RBP: ffff888c0f0a2d40 R08: 0000000001ffffff R09:
0000000000000040
[  509.979045] R10: ffff88980f283e68 R11: 0000000000000000 R12:
0000000000000000
[  509.987095] Kernel panic - not syncing: Fatal exception in
interrupt
[  510.008237] R13: ffff889807f91e00 R14: ffff88980f2a2cc0 R15:
0000000000000000
[  510.008240] FS:  00007f8547fff700(0000) GS:ffff88980f280000(0000)
knlGS:000000000000
[  510.102589] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  510.109103] CR2: 0000000000000058 CR3: 0000001807b64003 CR4:
00000000000606e0
[  510.117164] Call Trace:
[  510.119977]  <IRQ>
[  510.122316]  ? tick_sched_do_timer+0x60/0x60
[  510.127168]  scheduler_tick+0x84/0x120
[  510.131445]  update_process_times+0x40/0x50
[  510.136203]  tick_sched_handle+0x21/0x70
[  510.140672]  tick_sched_timer+0x37/0x70
[  510.145040]  __hrtimer_run_queues+0x108/0x290
[  510.149990]  hrtimer_interrupt+0xe5/0x240
[  510.154554]  smp_apic_timer_interrupt+0x6a/0x130
[  510.159796]  apic_timer_interrupt+0xf/0x20
[  510.164454]  </IRQ>
[  510.166882] RIP: 0033:0x7ffea1bfe6ac
[  510.170958] Code: 2d 81 e9 ff ff 4c 8b 05 82 e9 ff ff 0f 01 f9 66
90 41 8b 0c 24 39f
[  510.192101] RSP: 002b:00007f8547ffedf0 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[  510.200675] RAX: 0000000078890657 RBX: 00007f8547ffee50 RCX:
000000000000101a
[  510.208736] RDX: 0000000000000166 RSI: 00007f8547ffee50 RDI:
0000000000000000
[  510.216799] RBP: 00007f8547ffee10 R08: 0000000000000000 R09:
00007ffea1bfb0a0
[  510.224861] R10: 00007ffea1bfb080 R11: 000000000002457e R12:
0000000000000000
[  510.234319] R13: 00007f855ed56e6f R14: 0000000000000000 R15:
00007f855830ed98
[  510.242371] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nai
[  510.327929] CR2: 0000000000000058
[  510.331720] ---[ end trace f1214a54c044bdb8 ]---
[  510.342658] RIP: 0010:rb_insert_color+0x17/0x190
[  510.347900] Code: f3 c3 31 c0 c3 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 48 8b 174
[  510.369044] RSP: 0000:ffffc90009203c08 EFLAGS: 00010046
[  510.374968] RAX: 0000000000000000 RBX: ffff889806f91e00 RCX:
ffff889806f91e00
[  510.383031] RDX: ffff889806f83f48 RSI: ffff88980f2238c8 RDI:
ffff889806f92148
[  510.391093] RBP: ffff88980f222cc0 R08: 000000000000026e R09:
ffff88980a099000
[  510.399154] R10: 0000000000000078 R11: ffff88980a099b58 R12:
0000000000000004
[  510.407214] R13: ffffc90009203c68 R14: 0000000000000046 R15:
0000000000022cc0
[  510.415278] FS:  00007f8547fff700(0000) GS:ffff88980f280000(0000)
knlGS:000000000000
[  510.424434] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  510.430939] CR2: 0000000000000058 CR3: 0000001807b64003 CR4:
00000000000606e0
[  511.068880] Shutting down cpus with NMI
[  511.075437] Kernel Offset: disabled
[  511.083621] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---
