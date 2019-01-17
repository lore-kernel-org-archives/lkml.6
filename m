Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FF4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A107A20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hz9hhLNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfAQO6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:58:43 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51184 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAQO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:58:42 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so1780248iti.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 06:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mo6qyxnxL8fMs9xe5dWsTIlbD4szbxIYzVYpAO1J3+8=;
        b=Hz9hhLNL+KGJcjIqCgmajJ3iPlpaRqaOe4nlj82ghv/oGqjKRbcGAISVH/yB1WDGTz
         3yxxLVlu9MLV5PsUyO/rNfEhl6VZe2DonaPY3idxdb8LOnufM+/5ZMmTCcg1tcDgHkeg
         oWLfQbzmGwqyuUyVKe3qJp19TDM1c5OC8xSNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mo6qyxnxL8fMs9xe5dWsTIlbD4szbxIYzVYpAO1J3+8=;
        b=BCJnswhecRuzVDzX8zfHJBfFoAWKSp47P2vj0ec2BBH3TKRwXS04SdzuMJtBTysIil
         jHUnmRdYvSN9tAIjW6NtuvqoRn5sdDw9vQMeywfup3oL1EMjIGagfxd/5cu4gUObfr6X
         +M/KT8YbyivxKUxWOIFP2TbyOcHMNhTLTKf6KOUW4EFxjvxxzDZyzalMBbFBUEGLNS0r
         dD+912NwRHVRKTITv5xJqUcIQqRW6XQC3mBQ4zP8Up8ClYE0A28zXq0TiXqm4eecJ0NZ
         E58yAgafjDv2QfOBPlO8vhCbJCzErqMrrNjNrQM4iRxx4cHsDKCbp8mMSSroeBNARVUA
         E40g==
X-Gm-Message-State: AJcUukffcS6LS5AEGT/ySyEj51ULCz1+Ey9D4Xilq6K9B9JIE/lmOsv+
        s+kOf/tRzf6nfYiHGzwH3pLK3gR2ASTVFm39nVd0/6Id4+M=
X-Google-Smtp-Source: ALg8bN4VaXJW5IIvGsj6gEKYkHHotBP2gHBnvDG2R3MB3HFu4tG8V9ltsgZ8XZPKdCZQjJku/LBUKxkJyv76uwkc0lc=
X-Received: by 2002:a05:660c:a8f:: with SMTP id m15mr8483549itk.114.1547737120684;
 Thu, 17 Jan 2019 06:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20190115032444.GP17624@shao2-debian> <CAKfTPtB4cHpF2JcUiOLbmczDVSLEmBCpNDcYqCdAqwYZ2LAsRg@mail.gmail.com>
 <20190116153839.GA3867@shao2-debian>
In-Reply-To: <20190116153839.GA3867@shao2-debian>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 17 Jan 2019 15:58:29 +0100
Message-ID: <CAKfTPtDVUCxNRcyqJBp0D-HxV7wubVorH3p3kXjSRP8eyaayiA@mail.gmail.com>
Subject: Re: [LKP] [PM] 8234f6734c: will-it-scale.per_process_ops -3.6% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rong,

On Wed, 16 Jan 2019 at 16:38, kernel test robot <rong.a.chen@intel.com> wro=
te:
>
> On Tue, Jan 15, 2019 at 02:13:47PM +0100, Vincent Guittot wrote:
> > Hi Rong,
> >
> > On Tue, 15 Jan 2019 at 04:24, kernel test robot <rong.a.chen@intel.com>=
 wrote:
> > >
> > > Greeting,
> > >
> > > FYI, we noticed a -3.6% regression of will-it-scale.per_process_ops d=
ue to commit:
> > >
> > >
> > > commit: 8234f6734c5d74ac794e5517437f51c57d65f865 ("PM-runtime: Switch=
 autosuspend over to using hrtimers")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git maste=
r
> > >
> >
> > Could you rerun with the patch :
> > https://lore.kernel.org/patchwork/patch/1030857/ ?
> > It optimizes autosuspend by reducing the number of call to ktime_get
>
> Hi Vincent,
>
> the regression of will-it-scale.per_process_ops is still exist according =
to the result.

Thanks for the test.
So I have looked at the test which create some tempfile and poll on
them and TBH, I don't see any direct relation between the test and the
content of the patch.



>
> commit:
>    v4.20-rc7
>    c534491102 ("PM/runtime: Do not needlessly call ktime_get")
>
>        v4.20-rc7  c534491102b35a2075c78b72bb
> ----------------  --------------------------
>          %stddev      change         %stddev
>              \          |                \
>   25028944              -4%   23987264        will-it-scale.workload
>     240662              -4%     230646        will-it-scale.per_process_o=
ps
>      80031                       78804        proc-vmstat.nr_zone_active_=
anon
>      80031                       78804        proc-vmstat.nr_active_anon
>       7649 =C2=B1173%     -6e+03       1870 =C2=B1133%  latency_stats.avg=
.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wr=
apper.nfs3_proc_lookup.nfs_lookup_revalidate_dentry.nfs_do_lookup_revalidat=
e.__nfs_lookup_revalidate.lookup_fast.walk_component.link_path_walk
>       7654 =C2=B1173%     -6e+03       1834 =C2=B1133%  latency_stats.avg=
.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wr=
apper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_p=
ath_walk.path_lookupat.filename_lookup
>      13537 =C2=B1173%     -1e+04          0        latency_stats.avg.rpc_=
wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_get_acl.get=
_acl.posix_acl_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.=
do_sys_open
>      66199 =C2=B1130%     -7e+04          0        latency_stats.avg.rpc_=
wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper=
.nfs3_proc_lookup.nfs_lookup.path_openat.do_filp_open.do_sys_open.do_syscal=
l_64.entry_SYSCALL_64_after_hwframe
>     389513 =C2=B1161%     -4e+05          0        latency_stats.avg.rpc_=
wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper=
.nfs3_do_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys=
_open.do_syscall_64
>        629 =C2=B1 65%      4e+03       4446 =C2=B1123%  latency_stats.max=
.io_schedule.__lock_page.do_wp_page.__handle_mm_fault.handle_mm_fault.__do_=
page_fault.do_page_fault.page_fault
>       7748 =C2=B1173%     -6e+03       1899 =C2=B1133%  latency_stats.max=
.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wr=
apper.nfs3_proc_lookup.nfs_lookup_revalidate_dentry.nfs_do_lookup_revalidat=
e.__nfs_lookup_revalidate.lookup_fast.walk_component.link_path_walk
>       7750 =C2=B1173%     -6e+03       1845 =C2=B1133%  latency_stats.max=
.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wr=
apper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_p=
ath_walk.path_lookupat.filename_lookup
>      13537 =C2=B1173%     -1e+04          0        latency_stats.max.rpc_=
wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_get_acl.get=
_acl.posix_acl_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.=
do_sys_open
>      66199 =C2=B1130%     -7e+04          0        latency_stats.max.rpc_=
wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper=
.nfs3_proc_lookup.nfs_lookup.path_openat.do_filp_open.do_sys_open.do_syscal=
l_64.entry_SYSCALL_64_after_hwframe
>     392739 =C2=B1159%     -4e+05          0        latency_stats.max.rpc_=
wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper=
.nfs3_do_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys=
_open.do_syscall_64
>      15365 =C2=B1 41%      2e+05     194745 =C2=B1123%  latency_stats.sum=
.io_schedule.__lock_page.do_wp_page.__handle_mm_fault.handle_mm_fault.__do_=
page_fault.do_page_fault.page_fault
>       9214 =C2=B1 30%      6e+04      71022 =C2=B1 22%  latency_stats.sum=
.pipe_wait.pipe_write.__vfs_write.vfs_write.ksys_write.do_syscall_64.entry_=
SYSCALL_64_after_hwframe
>      15299 =C2=B1173%     -1e+04       3740 =C2=B1133%  latency_stats.sum=
.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wr=
apper.nfs3_proc_lookup.nfs_lookup_revalidate_dentry.nfs_do_lookup_revalidat=
e.__nfs_lookup_revalidate.lookup_fast.walk_component.link_path_walk
>      13537 =C2=B1173%     -1e+04          0        latency_stats.sum.rpc_=
wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_get_acl.get=
_acl.posix_acl_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.=
do_sys_open
>      22963 =C2=B1173%     -2e+04       3668 =C2=B1133%  latency_stats.sum=
.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wr=
apper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_p=
ath_walk.path_lookupat.filename_lookup
>      66199 =C2=B1130%     -7e+04          0        latency_stats.sum.rpc_=
wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper=
.nfs3_proc_lookup.nfs_lookup.path_openat.do_filp_open.do_sys_open.do_syscal=
l_64.entry_SYSCALL_64_after_hwframe
>     408736 =C2=B1151%     -4e+05          0        latency_stats.sum.rpc_=
wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper=
.nfs3_do_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys=
_open.do_syscall_64
>      79146 =C2=B1 26%       626%     574528 =C2=B1  5%  perf-stat.i.iTLB-=
loads
>       8211 =C2=B1  7%        56%      12770 =C2=B1 14%  perf-stat.i.node-=
store-misses
>       0.28              15%       0.32        perf-stat.overall.branch-mi=
ss-rate%
>   1.61e+08              11%  1.791e+08        perf-stat.i.branch-misses
>      71.87              10%      79.18 =C2=B1  3%  perf-stat.overall.node=
-store-miss-rate%
>      13107 =C2=B1  4%         7%      14023        perf-stat.i.node-loads
>       1.04               5%       1.09        perf-stat.overall.cpi
>      99.05                       97.63        perf-stat.i.iTLB-load-miss-=
rate%
>      83.87                       82.36        perf-stat.overall.node-load=
-miss-rate%
>      99.68                       97.65        perf-stat.overall.iTLB-load=
-miss-rate%
>   24777147              -3%   23919344        perf-stat.i.iTLB-load-misse=
s
>  2.743e+11              -4%  2.646e+11        perf-stat.i.instructions
>  5.791e+10              -4%  5.586e+10        perf-stat.i.branch-instruct=
ions
>   2.89e+10              -4%  2.787e+10        perf-stat.i.dTLB-stores
>  5.964e+10              -4%  5.752e+10        perf-stat.i.dTLB-loads
>       0.96              -4%       0.92        perf-stat.i.ipc
>  8.333e+13              -4%  7.976e+13        perf-stat.total.instruction=
s
>       0.96              -4%       0.92        perf-stat.overall.ipc
>     355843 =C2=B1  4%       -12%     313369 =C2=B1  4%  perf-stat.i.cache=
-misses
>
> Best Regards,
> Rong Chen
>
> >
> > Regards,
> > Vincent
> >
> > > in testcase: will-it-scale
> > > on test machine: 104 threads Skylake with 192G memory
> > > with following parameters:
> > >
> > >         nr_task: 100%
> > >         mode: process
> > >         test: poll2
> > >         cpufreq_governor: performance
> > >
> > > test-description: Will It Scale takes a testcase and runs it from 1 t=
hrough to n parallel copies to see if the testcase will scale. It builds bo=
th a process and threads based test in order to see any differences between=
 the two.
> > > test-url: https://github.com/antonblanchard/will-it-scale
> > >
> > >
> > >
> > > Details are as below:
> > > ---------------------------------------------------------------------=
----------------------------->
> > >
> > >
> > > To reproduce:
> > >
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         bin/lkp install job.yaml  # job file is attached in this emai=
l
> > >         bin/lkp run     job.yaml
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test=
/testcase:
> > >   gcc-7/performance/x86_64-rhel-7.2/process/100%/debian-x86_64-2018-0=
4-03.cgz/lkp-skl-fpga01/poll2/will-it-scale
> > >
> > > commit:
> > >   v4.20-rc7
> > >   8234f6734c ("PM-runtime: Switch autosuspend over to using hrtimers"=
)
> > >
> > >        v4.20-rc7 8234f6734c5d74ac794e551743
> > > ---------------- --------------------------
> > >        fail:runs  %reproduction    fail:runs
> > >            |             |             |
> > >            :2           50%           1:4     dmesg.WARNING:at#for_ip=
_interrupt_entry/0x
> > >          %stddev     %change         %stddev
> > >              \          |                \
> > >     240408            -3.6%     231711        will-it-scale.per_proce=
ss_ops
> > >   25002520            -3.6%   24097991        will-it-scale.workload
> > >     351914            -1.7%     345882        interrupts.CAL:Function=
_call_interrupts
> > >       1.77 =C2=B1 45%      -1.1        0.64        mpstat.cpu.idle%
> > >     106164 =C2=B1 24%     -23.2%      81494 =C2=B1 28%  numa-meminfo.=
node0.AnonHugePages
> > >     326430 =C2=B1  8%     -11.3%     289513        softirqs.SCHED
> > >       1294            -2.0%       1268        vmstat.system.cs
> > >       3178           +48.4%       4716 =C2=B1 16%  slabinfo.eventpoll=
_pwq.active_objs
> > >       3178           +48.4%       4716 =C2=B1 16%  slabinfo.eventpoll=
_pwq.num_objs
> > >     336.32          -100.0%       0.00        uptime.boot
> > >       3192          -100.0%       0.00        uptime.idle
> > >  3.456e+08 =C2=B1 76%     -89.9%   34913819 =C2=B1 62%  cpuidle.C1E.t=
ime
> > >     747832 =C2=B1 72%     -87.5%      93171 =C2=B1 45%  cpuidle.C1E.u=
sage
> > >      16209 =C2=B1 26%     -38.2%      10021 =C2=B1 44%  cpuidle.POLL.=
time
> > >       6352 =C2=B1 32%     -39.5%       3843 =C2=B1 48%  cpuidle.POLL.=
usage
> > >     885259 =C2=B1  2%     -13.8%     763434 =C2=B1  7%  numa-vmstat.n=
ode0.numa_hit
> > >     865117 =C2=B1  2%     -13.9%     744992 =C2=B1  7%  numa-vmstat.n=
ode0.numa_local
> > >     405085 =C2=B1  7%     +38.0%     558905 =C2=B1  9%  numa-vmstat.n=
ode1.numa_hit
> > >     254056 =C2=B1 11%     +59.7%     405824 =C2=B1 13%  numa-vmstat.n=
ode1.numa_local
> > >     738158 =C2=B1 73%     -88.5%      85078 =C2=B1 47%  turbostat.C1E
> > >       1.07 =C2=B1 76%      -1.0        0.11 =C2=B1 62%  turbostat.C1E=
%
> > >       1.58 =C2=B1 49%     -65.4%       0.55 =C2=B1  6%  turbostat.CPU=
%c1
> > >       0.15 =C2=B1 13%     -35.0%       0.10 =C2=B1 38%  turbostat.CPU=
%c6
> > >     153.97 =C2=B1 16%     -54.7       99.31        turbostat.PKG_%
> > >      64141            +1.5%      65072        proc-vmstat.nr_anon_pag=
es
> > >      19541            -7.0%      18178 =C2=B1  8%  proc-vmstat.nr_shm=
em
> > >      18296            +1.1%      18506        proc-vmstat.nr_slab_rec=
laimable
> > >     713938            -2.3%     697489        proc-vmstat.numa_hit
> > >     693688            -2.4%     677228        proc-vmstat.numa_local
> > >     772220            -1.9%     757334        proc-vmstat.pgalloc_nor=
mal
> > >     798565            -1.8%     784042        proc-vmstat.pgfault
> > >     732336            -2.7%     712661        proc-vmstat.pgfree
> > >      20.33 =C2=B1  4%      -7.0%      18.92        sched_debug.cfs_rq=
:/.runnable_load_avg.max
> > >     160603           -44.5%      89108 =C2=B1 38%  sched_debug.cfs_rq=
:/.spread0.avg
> > >     250694           -29.3%     177358 =C2=B1 18%  sched_debug.cfs_rq=
:/.spread0.max
> > >       1109 =C2=B1  4%      -7.0%       1031        sched_debug.cfs_rq=
:/.util_avg.max
> > >      20.33 =C2=B1  4%      -7.2%      18.88        sched_debug.cpu.cp=
u_load[0].max
> > >     -10.00           +35.0%     -13.50        sched_debug.cpu.nr_unin=
terruptible.min
> > >       3.56 =C2=B1 10%     +44.2%       5.14 =C2=B1 18%  sched_debug.c=
pu.nr_uninterruptible.stddev
> > >      87.10 =C2=B1 24%     -34.0%      57.44 =C2=B1 37%  sched_debug.c=
pu.sched_goidle.avg
> > >     239.48           -25.6%     178.07 =C2=B1 18%  sched_debug.cpu.sc=
hed_goidle.stddev
> > >     332.67 =C2=B1  7%     -25.5%     247.83 =C2=B1 13%  sched_debug.c=
pu.ttwu_count.min
> > >     231.67 =C2=B1  8%     -15.4%     195.96 =C2=B1 12%  sched_debug.c=
pu.ttwu_local.min
> > >      95.47           -95.5        0.00        perf-profile.calltrace.=
cycles-pp.poll
> > >      90.26           -90.3        0.00        perf-profile.calltrace.=
cycles-pp.entry_SYSCALL_64_after_hwframe.poll
> > >      90.08           -90.1        0.00        perf-profile.calltrace.=
cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.poll
> > >      89.84           -89.8        0.00        perf-profile.calltrace.=
cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.poll
> > >      88.04           -88.0        0.00        perf-profile.calltrace.=
cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_h=
wframe.poll
> > >       2.66            -0.1        2.54        perf-profile.calltrace.=
cycles-pp._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SY=
SCALL_64_after_hwframe
> > >       1.90            -0.1        1.81        perf-profile.calltrace.=
cycles-pp.copy_user_enhanced_fast_string._copy_from_user.do_sys_poll.__x64_=
sys_poll.do_syscall_64
> > >       2.56            +0.1        2.64        perf-profile.calltrace.=
cycles-pp.__fdget.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64=
_after_hwframe
> > >       0.00            +2.3        2.29        perf-profile.calltrace.=
cycles-pp.syscall_return_via_sysret
> > >       0.00            +2.3        2.34        perf-profile.calltrace.=
cycles-pp.entry_SYSCALL_64
> > >      17.45            +3.8       21.24        perf-profile.calltrace.=
cycles-pp.__fget_light.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCA=
LL_64_after_hwframe
> > >       0.00           +92.7       92.66        perf-profile.calltrace.=
cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_h=
wframe
> > >       0.00           +94.5       94.51        perf-profile.calltrace.=
cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       0.00           +94.8       94.75        perf-profile.calltrace.=
cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       0.00           +94.9       94.92        perf-profile.calltrace.=
cycles-pp.entry_SYSCALL_64_after_hwframe
> > >      96.03           -96.0        0.00        perf-profile.children.c=
ycles-pp.poll
> > >      90.29           -90.3        0.00        perf-profile.children.c=
ycles-pp.entry_SYSCALL_64_after_hwframe
> > >      90.11           -90.1        0.00        perf-profile.children.c=
ycles-pp.do_syscall_64
> > >      89.87           -89.9        0.00        perf-profile.children.c=
ycles-pp.__x64_sys_poll
> > >      89.39           -89.4        0.00        perf-profile.children.c=
ycles-pp.do_sys_poll
> > >      16.19           -16.2        0.00        perf-profile.children.c=
ycles-pp.__fget_light
> > >      68.59           -68.6        0.00        perf-profile.self.cycle=
s-pp.do_sys_poll
> > >      14.84           -14.8        0.00        perf-profile.self.cycle=
s-pp.__fget_light
> > >  1.759e+13          -100.0%       0.00        perf-stat.branch-instru=
ctions
> > >       0.28            -0.3        0.00        perf-stat.branch-miss-r=
ate%
> > >  4.904e+10          -100.0%       0.00        perf-stat.branch-misses
> > >       6.79 =C2=B1  3%      -6.8        0.00        perf-stat.cache-mi=
ss-rate%
> > >  1.071e+08 =C2=B1  4%    -100.0%       0.00        perf-stat.cache-mi=
sses
> > >  1.578e+09          -100.0%       0.00        perf-stat.cache-referen=
ces
> > >     385311 =C2=B1  2%    -100.0%       0.00        perf-stat.context-=
switches
> > >       1.04          -100.0%       0.00        perf-stat.cpi
> > >  8.643e+13          -100.0%       0.00        perf-stat.cpu-cycles
> > >      13787          -100.0%       0.00        perf-stat.cpu-migration=
s
> > >       0.00 =C2=B1  4%      -0.0        0.00        perf-stat.dTLB-loa=
d-miss-rate%
> > >   23324811 =C2=B1  5%    -100.0%       0.00        perf-stat.dTLB-loa=
d-misses
> > >  1.811e+13          -100.0%       0.00        perf-stat.dTLB-loads
> > >       0.00            -0.0        0.00        perf-stat.dTLB-store-mi=
ss-rate%
> > >    2478029          -100.0%       0.00        perf-stat.dTLB-store-mi=
sses
> > >  8.775e+12          -100.0%       0.00        perf-stat.dTLB-stores
> > >      99.66           -99.7        0.00        perf-stat.iTLB-load-mis=
s-rate%
> > >  7.527e+09          -100.0%       0.00        perf-stat.iTLB-load-mis=
ses
> > >   25540468 =C2=B1 39%    -100.0%       0.00        perf-stat.iTLB-loa=
ds
> > >   8.33e+13          -100.0%       0.00        perf-stat.instructions
> > >      11066          -100.0%       0.00        perf-stat.instructions-=
per-iTLB-miss
> > >       0.96          -100.0%       0.00        perf-stat.ipc
> > >     777357          -100.0%       0.00        perf-stat.minor-faults
> > >      81.69           -81.7        0.00        perf-stat.node-load-mis=
s-rate%
> > >   20040093          -100.0%       0.00        perf-stat.node-load-mis=
ses
> > >    4491667 =C2=B1  7%    -100.0%       0.00        perf-stat.node-loa=
ds
> > >      75.23 =C2=B1 10%     -75.2        0.00        perf-stat.node-sto=
re-miss-rate%
> > >    3418662 =C2=B1 30%    -100.0%       0.00        perf-stat.node-sto=
re-misses
> > >    1027183 =C2=B1 11%    -100.0%       0.00        perf-stat.node-sto=
res
> > >     777373          -100.0%       0.00        perf-stat.page-faults
> > >    3331644          -100.0%       0.00        perf-stat.path-length
> > >
> > >
> > >
> > >                             will-it-scale.per_process_ops
> > >
> > >   242000 +-+---------------------------------------------------------=
-------+
> > >          |                      +.+..   .+..+.      .+.+..+.+.+.    .=
+.+..  |
> > >   240000 +-+                   +     +.+      +.+..+            +..+ =
     +.|
> > >   238000 +-+..+.+.  .+.   .+..+                                      =
       |
> > >          |        +.   +.+                                           =
       |
> > >   236000 +-+                                                         =
       |
> > >          |                                                           =
       |
> > >   234000 +-+                                                         =
       |
> > >          |                                  O O O  O                 =
       |
> > >   232000 +-+             O O  O O                      O  O O O O  O =
O O  O |
> > >   230000 +-+           O          O  O O O           O               =
       |
> > >          |           O                                               =
       |
> > >   228000 O-+    O O                                                  =
       |
> > >          | O  O                                                      =
       |
> > >   226000 +-+---------------------------------------------------------=
-------+
> > >
> > >
> > >                                 will-it-scale.workload
> > >
> > >   2.52e+07 +-+-------------------------------------------------------=
-------+
> > >            |                     +..+.   .+..+.      .+. .+.+..+.   .=
+..+.  |
> > >    2.5e+07 +-+                  +     +.+      +.+.+.   +        +.+ =
     +.|
> > >   2.48e+07 +-+.+..+. .+.    .+.+                                     =
       |
> > >            |        +   +..+                                         =
       |
> > >   2.46e+07 +-+                                                       =
       |
> > >   2.44e+07 +-+                                                       =
       |
> > >            |                                                         =
       |
> > >   2.42e+07 +-+               O   O           O O O O        O        =
O      |
> > >    2.4e+07 +-+          O  O   O                        O O    O O O =
   O O |
> > >            |          O             O O O O           O              =
       |
> > >   2.38e+07 O-+    O                                                  =
       |
> > >   2.36e+07 +-O O    O                                                =
       |
> > >            |                                                         =
       |
> > >   2.34e+07 +-+-------------------------------------------------------=
-------+
> > >
> > >
> > > [*] bisect-good sample
> > > [O] bisect-bad  sample
> > >
> > >
> > >
> > > Disclaimer:
> > > Results have been estimated based on internal Intel analysis and are =
provided
> > > for informational purposes only. Any difference in system hardware or=
 software
> > > design or configuration may affect actual performance.
> > >
> > >
> > > Thanks,
> > > Rong Chen
> > _______________________________________________
> > LKP mailing list
> > LKP@lists.01.org
> > https://lists.01.org/mailman/listinfo/lkp
