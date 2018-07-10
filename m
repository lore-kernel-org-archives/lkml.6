Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7612BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 17:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC4820883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 17:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7JQw8g1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC4820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933476AbeGJRBi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 13:01:38 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32953 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754366AbeGJRBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 13:01:36 -0400
Received: by mail-vk0-f44.google.com with SMTP id y70-v6so10532772vkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+FY2Q8RU2DlpmjqsUUHx8sUfIBhBP8g1kq98+ji436s=;
        b=M7JQw8g1hZeMfi2pQgd0bUBneJzB7eml3XfhrZ4PpQ+ynJbNbG+6ijjVpgkpJ5HeM5
         6S3IiTw8Q95cDlPWr9oCteMVHx/eetk0YBlg5V5UZ/kmhdQfCat1VKMECWXJZ39zFNd/
         YRYypXocPAxIjqru02tZ+tMhEw5bguEBwirGWhqzxfig1lvRRQ24nHuh7wM6zQQ19+8s
         imgLy232tBZp95+/EpFL7lsnuaF1a9ugDgBo4L9ptlJbeU67kjv56E6pJ1ZLAPvYYaXk
         yZBIL099h4zeg1zDOccIREnSK/Q5jEw9UXEAnhoYTbQ6ZlHR3475QZT2/Q9q18CsFhvU
         eiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+FY2Q8RU2DlpmjqsUUHx8sUfIBhBP8g1kq98+ji436s=;
        b=JsVhl5JgctiREoMOsWsPc7XJceBjwxYI+9COLjI0M/eMULmk6eqDysIxG0lgwbO3It
         C41X+bouOwwlPzvqGkhNjW7EDmAsV/fk2u5uKr1IC9xa2ElPzR81VU2Yf34jbwkFvMXQ
         ulkR1tT/3LJZbpRcQkMSzc/ZbtbeCsP+U6GvZd7/KUCTyHCiYLkc3cjpvUlL5c2XCt/z
         M2iNOra9cXAQF0x8c1x5Ee84bT/A/ytETxc/L/vXkOrCTdn4iJgm7j7GsGBNdhWX5ID5
         B7GNFMt8M9POtcsJi2RvU47y0Aa+h9WuxXSwGVVUQHwI8oGAt9AJOdlI65mB9D5Y0p9H
         Ju3g==
X-Gm-Message-State: APt69E1zTQKj0bPIuhXnXjauIyzPXjcTMOoy7B4qLxTX5Xg3/StU8P7y
        jJr29mb6Eb5DmvcRvUlVAasRKUcgN7EjevA0ACU=
X-Google-Smtp-Source: AAOMgpcW7PW0CUUZMS5LK0e1CiMfEr1tv5bN2BK8toZ8u+/gBAEjzDKNlUOnfiQ/T5eSfCeVcYuap11/uYSqNOsTV3M=
X-Received: by 2002:a1f:2cce:: with SMTP id s197-v6mr14339602vks.106.1531241595165;
 Tue, 10 Jul 2018 09:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180604055259.GF16472@yexl-desktop> <1483bdb1-df0c-3b9c-43b9-4f477d00b097@intel.com>
In-Reply-To: <1483bdb1-df0c-3b9c-43b9-4f477d00b097@intel.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Tue, 10 Jul 2018 12:52:48 -0400
Message-ID: <CAEjAshqBDmf34Afd1rHChy6cnhgQV0jCwafpN_bXk9zp08S99A@mail.gmail.com>
Subject: Re: [LKP] [lkp-robot] [brd] 316ba5736c: aim7.jobs-per-min -11.2% regression
To:     kemi.wang@intel.com
Cc:     xiaolong.ye@intel.com, axboe@kernel.dk, axboe@fb.com, lkp@01.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I mistakenly found this mail now.  I will look inside for this
though it will take some time because I will not be in office for this
week.


Thanks,
SeongJae Park
On Tue, Jul 10, 2018 at 1:30 AM kemi <kemi.wang@intel.com> wrote:
>
> Hi, SeongJae
>   Do you have any input for this regression? thanks
>
> On 2018=E5=B9=B406=E6=9C=8804=E6=97=A5 13:52, kernel test robot wrote:
> >
> > Greeting,
> >
> > FYI, we noticed a -11.2% regression of aim7.jobs-per-min due to commit:
> >
> >
> > commit: 316ba5736c9caa5dbcd84085989862d2df57431d ("brd: Mark as non-rot=
ational")
> > https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-=
4.18/block
> >
> > in testcase: aim7
> > on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz w=
ith 384G memory
> > with following parameters:
> >
> >       disk: 1BRD_48G
> >       fs: btrfs
> >       test: disk_rw
> >       load: 1500
> >       cpufreq_governor: performance
> >
> > test-description: AIM7 is a traditional UNIX system level benchmark sui=
te which is used to test and measure the performance of multiuser system.
> > test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
> >
> >
> >
> > Details are as below:
> > -----------------------------------------------------------------------=
--------------------------->
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/t=
estcase:
> >   gcc-7/performance/1BRD_48G/btrfs/x86_64-rhel-7.2/1500/debian-x86_64-2=
016-08-31.cgz/lkp-ivb-ep01/disk_rw/aim7
> >
> > commit:
> >   522a777566 ("block: consolidate struct request timestamp fields")
> >   316ba5736c ("brd: Mark as non-rotational")
> >
> > 522a777566f56696 316ba5736c9caa5dbcd8408598
> > ---------------- --------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >      28321           -11.2%      25147        aim7.jobs-per-min
> >     318.19           +12.6%     358.23        aim7.time.elapsed_time
> >     318.19           +12.6%     358.23        aim7.time.elapsed_time.ma=
x
> >    1437526 =C2=B1  2%     +14.6%    1646849 =C2=B1  2%  aim7.time.invol=
untary_context_switches
> >      11986           +14.2%      13691        aim7.time.system_time
> >      73.06 =C2=B1  2%      -3.6%      70.43        aim7.time.user_time
> >    2449470 =C2=B1  2%     -25.0%    1837521 =C2=B1  4%  aim7.time.volun=
tary_context_switches
> >      20.25 =C2=B1 58%   +1681.5%     360.75 =C2=B1109%  numa-meminfo.no=
de1.Mlocked
> >     456062           -16.3%     381859        softirqs.SCHED
> >       9015 =C2=B1  7%     -21.3%       7098 =C2=B1 22%  meminfo.CmaFree
> >      47.50 =C2=B1 58%   +1355.8%     691.50 =C2=B1 92%  meminfo.Mlocked
> >       5.24 =C2=B1  3%      -1.2        3.99 =C2=B1  2%  mpstat.cpu.idle=
%
> >       0.61 =C2=B1  2%      -0.1        0.52 =C2=B1  2%  mpstat.cpu.usr%
> >      16627           +12.8%      18762 =C2=B1  4%  slabinfo.Acpi-State.=
active_objs
> >      16627           +12.9%      18775 =C2=B1  4%  slabinfo.Acpi-State.=
num_objs
> >      57.00 =C2=B1  2%     +17.5%      67.00        vmstat.procs.r
> >      20936           -24.8%      15752 =C2=B1  2%  vmstat.system.cs
> >      45474            -1.7%      44681        vmstat.system.in
> >       6.50 =C2=B1 59%   +1157.7%      81.75 =C2=B1 75%  numa-vmstat.nod=
e0.nr_mlock
> >     242870 =C2=B1  3%     +13.2%     274913 =C2=B1  7%  numa-vmstat.nod=
e0.nr_written
> >       2278 =C2=B1  7%     -22.6%       1763 =C2=B1 21%  numa-vmstat.nod=
e1.nr_free_cma
> >       4.75 =C2=B1 58%   +1789.5%      89.75 =C2=B1109%  numa-vmstat.nod=
e1.nr_mlock
> >   88018135 =C2=B1  3%     -48.9%   44980457 =C2=B1  7%  cpuidle.C1.time
> >    1398288 =C2=B1  3%     -51.1%     683493 =C2=B1  9%  cpuidle.C1.usag=
e
> >    3499814 =C2=B1  2%     -38.5%    2153158 =C2=B1  5%  cpuidle.C1E.tim=
e
> >      52722 =C2=B1  4%     -45.6%      28692 =C2=B1  6%  cpuidle.C1E.usa=
ge
> >    9865857 =C2=B1  3%     -40.1%    5905155 =C2=B1  5%  cpuidle.C3.time
> >      69656 =C2=B1  2%     -42.6%      39990 =C2=B1  5%  cpuidle.C3.usag=
e
> >     590856 =C2=B1  2%     -12.3%     517910        cpuidle.C6.usage
> >      46160 =C2=B1  7%     -53.7%      21372 =C2=B1 11%  cpuidle.POLL.ti=
me
> >       1716 =C2=B1  7%     -46.6%     916.25 =C2=B1 14%  cpuidle.POLL.us=
age
> >     197656            +4.1%     205732        proc-vmstat.nr_active_fil=
e
> >     191867            +4.1%     199647        proc-vmstat.nr_dirty
> >     509282            +1.6%     517318        proc-vmstat.nr_file_pages
> >       2282 =C2=B1  8%     -24.4%       1725 =C2=B1 22%  proc-vmstat.nr_=
free_cma
> >     357.50           +10.6%     395.25 =C2=B1  2%  proc-vmstat.nr_inact=
ive_file
> >      11.50 =C2=B1 58%   +1397.8%     172.25 =C2=B1 93%  proc-vmstat.nr_=
mlock
> >     970355 =C2=B1  4%     +14.6%    1111549 =C2=B1  8%  proc-vmstat.nr_=
written
> >     197984            +4.1%     206034        proc-vmstat.nr_zone_activ=
e_file
> >     357.50           +10.6%     395.25 =C2=B1  2%  proc-vmstat.nr_zone_=
inactive_file
> >     192282            +4.1%     200126        proc-vmstat.nr_zone_write=
_pending
> >    7901465 =C2=B1  3%     -14.0%    6795016 =C2=B1 16%  proc-vmstat.pga=
lloc_movable
> >     886101           +10.2%     976329        proc-vmstat.pgfault
> >  2.169e+12           +15.2%  2.497e+12        perf-stat.branch-instruct=
ions
> >       0.41            -0.1        0.35        perf-stat.branch-miss-rat=
e%
> >      31.19 =C2=B1  2%      +1.6       32.82        perf-stat.cache-miss=
-rate%
> >  9.116e+09            +8.3%  9.869e+09        perf-stat.cache-misses
> >  2.924e+10            +2.9%  3.008e+10 =C2=B1  2%  perf-stat.cache-refe=
rences
> >    6712739 =C2=B1  2%     -15.4%    5678643 =C2=B1  2%  perf-stat.conte=
xt-switches
> >       4.02            +2.7%       4.13        perf-stat.cpi
> >  3.761e+13           +17.3%  4.413e+13        perf-stat.cpu-cycles
> >     606958           -13.7%     523758 =C2=B1  2%  perf-stat.cpu-migrat=
ions
> >  2.476e+12           +13.4%  2.809e+12        perf-stat.dTLB-loads
> >       0.18 =C2=B1  2%      -0.0        0.16 =C2=B1  9%  perf-stat.dTLB-=
store-miss-rate%
> >  1.079e+09 =C2=B1  2%      -9.6%  9.755e+08 =C2=B1  9%  perf-stat.dTLB-=
store-misses
> >  5.933e+11            +1.6%  6.029e+11        perf-stat.dTLB-stores
> >  9.349e+12           +14.2%  1.068e+13        perf-stat.instructions
> >      11247 =C2=B1 11%     +19.8%      13477 =C2=B1  9%  perf-stat.instr=
uctions-per-iTLB-miss
> >       0.25            -2.6%       0.24        perf-stat.ipc
> >     865561           +10.3%     954350        perf-stat.minor-faults
> >  2.901e+09 =C2=B1  3%      +9.8%  3.186e+09 =C2=B1  3%  perf-stat.node-=
load-misses
> >  3.682e+09 =C2=B1  3%     +11.0%  4.088e+09 =C2=B1  3%  perf-stat.node-=
loads
> >  3.778e+09            +4.8%  3.959e+09 =C2=B1  2%  perf-stat.node-store=
-misses
> >  5.079e+09            +6.4%  5.402e+09        perf-stat.node-stores
> >     865565           +10.3%     954352        perf-stat.page-faults
> >      51.75 =C2=B1  5%     -12.5%      45.30 =C2=B1 10%  sched_debug.cfs=
_rq:/.load_avg.avg
> >     316.35 =C2=B1  3%     +17.2%     370.81 =C2=B1  8%  sched_debug.cfs=
_rq:/.util_est_enqueued.stddev
> >      15294 =C2=B1 30%    +234.9%      51219 =C2=B1 76%  sched_debug.cpu=
.avg_idle.min
> >     299443 =C2=B1  3%      -7.3%     277566 =C2=B1  5%  sched_debug.cpu=
.avg_idle.stddev
> >       1182 =C2=B1 19%     -26.3%     872.02 =C2=B1 13%  sched_debug.cpu=
.nr_load_updates.stddev
> >       1.22 =C2=B1  8%     +21.7%       1.48 =C2=B1  6%  sched_debug.cpu=
.nr_running.avg
> >       2.75 =C2=B1 10%     +26.2%       3.47 =C2=B1  6%  sched_debug.cpu=
.nr_running.max
> >       0.58 =C2=B1  7%     +24.2%       0.73 =C2=B1  6%  sched_debug.cpu=
.nr_running.stddev
> >      77148           -20.0%      61702 =C2=B1  7%  sched_debug.cpu.nr_s=
witches.avg
> >      70024           -24.8%      52647 =C2=B1  8%  sched_debug.cpu.nr_s=
witches.min
> >       6662 =C2=B1  6%     +61.9%      10789 =C2=B1 24%  sched_debug.cpu=
.nr_switches.stddev
> >      80.45 =C2=B1 18%     -19.1%      65.05 =C2=B1  6%  sched_debug.cpu=
.nr_uninterruptible.stddev
> >      76819           -19.3%      62008 =C2=B1  8%  sched_debug.cpu.sche=
d_count.avg
> >      70616           -23.5%      53996 =C2=B1  8%  sched_debug.cpu.sche=
d_count.min
> >       5494 =C2=B1  9%     +85.3%      10179 =C2=B1 26%  sched_debug.cpu=
.sched_count.stddev
> >      16936           -52.9%       7975 =C2=B1  9%  sched_debug.cpu.sche=
d_goidle.avg
> >      19281           -49.9%       9666 =C2=B1  7%  sched_debug.cpu.sche=
d_goidle.max
> >      15417           -54.8%       6962 =C2=B1 10%  sched_debug.cpu.sche=
d_goidle.min
> >     875.00 =C2=B1  6%     -35.0%     569.09 =C2=B1 13%  sched_debug.cpu=
.sched_goidle.stddev
> >      40332           -23.5%      30851 =C2=B1  7%  sched_debug.cpu.ttwu=
_count.avg
> >      35074           -26.3%      25833 =C2=B1  6%  sched_debug.cpu.ttwu=
_count.min
> >       3239 =C2=B1  8%     +67.4%       5422 =C2=B1 28%  sched_debug.cpu=
.ttwu_count.stddev
> >       5232           +27.4%       6665 =C2=B1 13%  sched_debug.cpu.ttwu=
_local.avg
> >      15877 =C2=B1 12%     +77.5%      28184 =C2=B1 27%  sched_debug.cpu=
.ttwu_local.max
> >       2530 =C2=B1 10%     +95.9%       4956 =C2=B1 27%  sched_debug.cpu=
.ttwu_local.stddev
> >       2.52 =C2=B1  7%      -0.6        1.95 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.btrfs_dirty_pages.__btrfs_buffered_write.btrfs_file_write=
_iter.__vfs_write.vfs_write
> >       1.48 =C2=B1 12%      -0.5        1.01 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.btrfs_get_extent.btrfs_dirty_pages.__btrfs_buffered_write=
.btrfs_file_write_iter.__vfs_write
> >       1.18 =C2=B1 16%      -0.4        0.76 =C2=B1  7%  perf-profile.ca=
lltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_get_exte=
nt.btrfs_dirty_pages.__btrfs_buffered_write
> >       1.18 =C2=B1 16%      -0.4        0.76 =C2=B1  7%  perf-profile.ca=
lltrace.cycles-pp.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_dirty_pag=
es.__btrfs_buffered_write.btrfs_file_write_iter
> >       0.90 =C2=B1 17%      -0.3        0.56 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.__dentry_kill.dentry_kill.dput.__fput.task_work_run
> >       0.90 =C2=B1 17%      -0.3        0.56 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.evict.__dentry_kill.dentry_kill.dput.__fput
> >       0.90 =C2=B1 17%      -0.3        0.56 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.dentry_kill.dput.__fput.task_work_run.exit_to_usermode_lo=
op
> >       0.90 =C2=B1 18%      -0.3        0.56 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.btrfs_evict_inode.evict.__dentry_kill.dentry_kill.dput
> >       0.90 =C2=B1 17%      -0.3        0.57 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe
> >       0.90 =C2=B1 17%      -0.3        0.57 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
> >       0.90 =C2=B1 17%      -0.3        0.57 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64.=
entry_SYSCALL_64_after_hwframe
> >       0.90 =C2=B1 17%      -0.3        0.57 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.dput.__fput.task_work_run.exit_to_usermode_loop.do_syscal=
l_64
> >       1.69            -0.1        1.54 =C2=B1  2%  perf-profile.calltra=
ce.cycles-pp.lock_and_cleanup_extent_if_need.__btrfs_buffered_write.btrfs_f=
ile_write_iter.__vfs_write.vfs_write
> >       0.87 =C2=B1  4%      -0.1        0.76 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.__clear_extent_bit.clear_extent_bit.lock_and_cleanup_exte=
nt_if_need.__btrfs_buffered_write.btrfs_file_write_iter
> >       0.87 =C2=B1  4%      -0.1        0.76 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.clear_extent_bit.lock_and_cleanup_extent_if_need.__btrfs_=
buffered_write.btrfs_file_write_iter.__vfs_write
> >       0.71 =C2=B1  6%      -0.1        0.61 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.clear_state_bit.__clear_extent_bit.clear_extent_bit.lock_=
and_cleanup_extent_if_need.__btrfs_buffered_write
> >       0.69 =C2=B1  6%      -0.1        0.60 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.btrfs_clear_bit_hook.clear_state_bit.__clear_extent_bit.c=
lear_extent_bit.lock_and_cleanup_extent_if_need
> >      96.77            +0.6       97.33        perf-profile.calltrace.cy=
cles-pp.entry_SYSCALL_64_after_hwframe
> >       0.00            +0.6        0.56 =C2=B1  3%  perf-profile.calltra=
ce.cycles-pp.can_overcommit.reserve_metadata_bytes.btrfs_delalloc_reserve_m=
etadata.__btrfs_buffered_write.btrfs_file_write_iter
> >      96.72            +0.6       97.29        perf-profile.calltrace.cy=
cles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      43.13            +0.8       43.91        perf-profile.calltrace.cy=
cles-pp.btrfs_inode_rsv_release.__btrfs_buffered_write.btrfs_file_write_ite=
r.__vfs_write.vfs_write
> >      42.37            +0.8       43.16        perf-profile.calltrace.cy=
cles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.block_rsv_release_b=
ytes.btrfs_inode_rsv_release.__btrfs_buffered_write
> >      43.11            +0.8       43.89        perf-profile.calltrace.cy=
cles-pp.block_rsv_release_bytes.btrfs_inode_rsv_release.__btrfs_buffered_wr=
ite.btrfs_file_write_iter.__vfs_write
> >      42.96            +0.8       43.77        perf-profile.calltrace.cy=
cles-pp._raw_spin_lock.block_rsv_release_bytes.btrfs_inode_rsv_release.__bt=
rfs_buffered_write.btrfs_file_write_iter
> >      95.28            +0.9       96.23        perf-profile.calltrace.cy=
cles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      95.22            +1.0       96.18        perf-profile.calltrace.cy=
cles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      94.88            +1.0       95.85        perf-profile.calltrace.cy=
cles-pp.__vfs_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_aft=
er_hwframe
> >      94.83            +1.0       95.80        perf-profile.calltrace.cy=
cles-pp.btrfs_file_write_iter.__vfs_write.vfs_write.ksys_write.do_syscall_6=
4
> >      94.51            +1.0       95.50        perf-profile.calltrace.cy=
cles-pp.__btrfs_buffered_write.btrfs_file_write_iter.__vfs_write.vfs_write.=
ksys_write
> >      42.44            +1.1       43.52        perf-profile.calltrace.cy=
cles-pp._raw_spin_lock.reserve_metadata_bytes.btrfs_delalloc_reserve_metada=
ta.__btrfs_buffered_write.btrfs_file_write_iter
> >      42.09            +1.1       43.18        perf-profile.calltrace.cy=
cles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.reserve_metadata_by=
tes.btrfs_delalloc_reserve_metadata.__btrfs_buffered_write
> >      44.07            +1.2       45.29        perf-profile.calltrace.cy=
cles-pp.btrfs_delalloc_reserve_metadata.__btrfs_buffered_write.btrfs_file_w=
rite_iter.__vfs_write.vfs_write
> >      43.42            +1.3       44.69        perf-profile.calltrace.cy=
cles-pp.reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.__btrfs_buff=
ered_write.btrfs_file_write_iter.__vfs_write
> >       2.06 =C2=B1 18%      -0.9        1.21 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.btrfs_search_slot
> >       2.54 =C2=B1  7%      -0.6        1.96 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.btrfs_dirty_pages
> >       1.05 =C2=B1 24%      -0.5        0.52 =C2=B1  9%  perf-profile.ch=
ildren.cycles-pp._raw_spin_lock_irqsave
> >       1.50 =C2=B1 12%      -0.5        1.03 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.btrfs_get_extent
> >       1.22 =C2=B1 15%      -0.4        0.79 =C2=B1  8%  perf-profile.ch=
ildren.cycles-pp.btrfs_lookup_file_extent
> >       0.81 =C2=B1  5%      -0.4        0.41 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.btrfs_calc_reclaim_metadata_size
> >       0.74 =C2=B1 24%      -0.4        0.35 =C2=B1  9%  perf-profile.ch=
ildren.cycles-pp.btrfs_lock_root_node
> >       0.74 =C2=B1 24%      -0.4        0.35 =C2=B1  9%  perf-profile.ch=
ildren.cycles-pp.btrfs_tree_lock
> >       0.90 =C2=B1 17%      -0.3        0.56 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.__dentry_kill
> >       0.90 =C2=B1 17%      -0.3        0.56 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.evict
> >       0.90 =C2=B1 17%      -0.3        0.56 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.dentry_kill
> >       0.90 =C2=B1 18%      -0.3        0.56 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.btrfs_evict_inode
> >       0.91 =C2=B1 18%      -0.3        0.57 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.exit_to_usermode_loop
> >       0.52 =C2=B1 20%      -0.3        0.18 =C2=B1 14%  perf-profile.ch=
ildren.cycles-pp.do_idle
> >       0.90 =C2=B1 17%      -0.3        0.57 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.task_work_run
> >       0.90 =C2=B1 17%      -0.3        0.57 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.__fput
> >       0.90 =C2=B1 18%      -0.3        0.57 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.dput
> >       0.51 =C2=B1 20%      -0.3        0.18 =C2=B1 14%  perf-profile.ch=
ildren.cycles-pp.secondary_startup_64
> >       0.51 =C2=B1 20%      -0.3        0.18 =C2=B1 14%  perf-profile.ch=
ildren.cycles-pp.cpu_startup_entry
> >       0.50 =C2=B1 21%      -0.3        0.17 =C2=B1 16%  perf-profile.ch=
ildren.cycles-pp.start_secondary
> >       0.47 =C2=B1 20%      -0.3        0.16 =C2=B1 13%  perf-profile.ch=
ildren.cycles-pp.cpuidle_enter_state
> >       0.47 =C2=B1 19%      -0.3        0.16 =C2=B1 13%  perf-profile.ch=
ildren.cycles-pp.intel_idle
> >       0.61 =C2=B1 20%      -0.3        0.36 =C2=B1 11%  perf-profile.ch=
ildren.cycles-pp.btrfs_tree_read_lock
> >       0.47 =C2=B1 26%      -0.3        0.21 =C2=B1 10%  perf-profile.ch=
ildren.cycles-pp.prepare_to_wait_event
> >       0.64 =C2=B1 18%      -0.2        0.39 =C2=B1  9%  perf-profile.ch=
ildren.cycles-pp.btrfs_read_lock_root_node
> >       0.40 =C2=B1 22%      -0.2        0.21 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.btrfs_clear_path_blocking
> >       0.38 =C2=B1 23%      -0.2        0.19 =C2=B1 13%  perf-profile.ch=
ildren.cycles-pp.finish_wait
> >       1.51 =C2=B1  3%      -0.2        1.35 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.__clear_extent_bit
> >       1.71            -0.1        1.56 =C2=B1  2%  perf-profile.childre=
n.cycles-pp.lock_and_cleanup_extent_if_need
> >       0.29 =C2=B1 25%      -0.1        0.15 =C2=B1 10%  perf-profile.ch=
ildren.cycles-pp.btrfs_orphan_del
> >       0.27 =C2=B1 27%      -0.1        0.12 =C2=B1  8%  perf-profile.ch=
ildren.cycles-pp.btrfs_del_orphan_item
> >       0.33 =C2=B1 18%      -0.1        0.19 =C2=B1  9%  perf-profile.ch=
ildren.cycles-pp.queued_read_lock_slowpath
> >       0.33 =C2=B1 19%      -0.1        0.20 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.__wake_up_common_lock
> >       0.45 =C2=B1 15%      -0.1        0.34 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.btrfs_alloc_data_chunk_ondemand
> >       0.47 =C2=B1 16%      -0.1        0.36 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.btrfs_check_data_free_space
> >       0.91 =C2=B1  4%      -0.1        0.81 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.clear_extent_bit
> >       1.07 =C2=B1  5%      -0.1        0.97        perf-profile.childre=
n.cycles-pp.__set_extent_bit
> >       0.77 =C2=B1  6%      -0.1        0.69 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.btrfs_clear_bit_hook
> >       0.17 =C2=B1 20%      -0.1        0.08 =C2=B1 10%  perf-profile.ch=
ildren.cycles-pp.queued_write_lock_slowpath
> >       0.16 =C2=B1 22%      -0.1        0.08 =C2=B1 24%  perf-profile.ch=
ildren.cycles-pp.btrfs_lookup_inode
> >       0.21 =C2=B1 17%      -0.1        0.14 =C2=B1 19%  perf-profile.ch=
ildren.cycles-pp.__btrfs_update_delayed_inode
> >       0.26 =C2=B1 12%      -0.1        0.18 =C2=B1 13%  perf-profile.ch=
ildren.cycles-pp.btrfs_async_run_delayed_root
> >       0.52 =C2=B1  5%      -0.1        0.45        perf-profile.childre=
n.cycles-pp.set_extent_bit
> >       0.45 =C2=B1  5%      -0.1        0.40 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.alloc_extent_state
> >       0.11 =C2=B1 17%      -0.1        0.06 =C2=B1 11%  perf-profile.ch=
ildren.cycles-pp.btrfs_clear_lock_blocking_rw
> >       0.28 =C2=B1  9%      -0.0        0.23 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.btrfs_drop_pages
> >       0.07            -0.0        0.03 =C2=B1100%  perf-profile.childre=
n.cycles-pp.btrfs_set_lock_blocking_rw
> >       0.39 =C2=B1  3%      -0.0        0.34 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.get_alloc_profile
> >       0.33 =C2=B1  7%      -0.0        0.29        perf-profile.childre=
n.cycles-pp.btrfs_set_extent_delalloc
> >       0.38 =C2=B1  2%      -0.0        0.35 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.__set_page_dirty_nobuffers
> >       0.49 =C2=B1  3%      -0.0        0.46 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.pagecache_get_page
> >       0.18 =C2=B1  4%      -0.0        0.15 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.truncate_inode_pages_range
> >       0.08 =C2=B1  5%      -0.0        0.05 =C2=B1  9%  perf-profile.ch=
ildren.cycles-pp.btrfs_set_path_blocking
> >       0.08 =C2=B1  6%      -0.0        0.06 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.truncate_cleanup_page
> >       0.80 =C2=B1  4%      +0.2        0.95 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.can_overcommit
> >      96.84            +0.5       97.37        perf-profile.children.cyc=
les-pp.entry_SYSCALL_64_after_hwframe
> >      96.80            +0.5       97.35        perf-profile.children.cyc=
les-pp.do_syscall_64
> >      43.34            +0.8       44.17        perf-profile.children.cyc=
les-pp.btrfs_inode_rsv_release
> >      43.49            +0.8       44.32        perf-profile.children.cyc=
les-pp.block_rsv_release_bytes
> >      95.32            +0.9       96.26        perf-profile.children.cyc=
les-pp.ksys_write
> >      95.26            +0.9       96.20        perf-profile.children.cyc=
les-pp.vfs_write
> >      94.91            +1.0       95.88        perf-profile.children.cyc=
les-pp.__vfs_write
> >      94.84            +1.0       95.81        perf-profile.children.cyc=
les-pp.btrfs_file_write_iter
> >      94.55            +1.0       95.55        perf-profile.children.cyc=
les-pp.__btrfs_buffered_write
> >      86.68            +1.0       87.70        perf-profile.children.cyc=
les-pp.native_queued_spin_lock_slowpath
> >      44.08            +1.2       45.31        perf-profile.children.cyc=
les-pp.btrfs_delalloc_reserve_metadata
> >      43.49            +1.3       44.77        perf-profile.children.cyc=
les-pp.reserve_metadata_bytes
> >      87.59            +1.8       89.38        perf-profile.children.cyc=
les-pp._raw_spin_lock
> >       0.47 =C2=B1 19%      -0.3        0.16 =C2=B1 13%  perf-profile.se=
lf.cycles-pp.intel_idle
> >       0.33 =C2=B1  6%      -0.1        0.18 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.get_alloc_profile
> >       0.27 =C2=B1  8%      -0.0        0.22 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.btrfs_drop_pages
> >       0.07            -0.0        0.03 =C2=B1100%  perf-profile.self.cy=
cles-pp.btrfs_set_lock_blocking_rw
> >       0.14 =C2=B1  5%      -0.0        0.12 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.clear_page_dirty_for_io
> >       0.09 =C2=B1  5%      -0.0        0.07 =C2=B1 10%  perf-profile.se=
lf.cycles-pp._raw_spin_lock_irqsave
> >       0.17 =C2=B1  4%      +0.1        0.23 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.reserve_metadata_bytes
> >       0.31 =C2=B1  7%      +0.1        0.45 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.can_overcommit
> >      86.35            +1.0       87.39        perf-profile.self.cycles-=
pp.native_queued_spin_lock_slowpath
> >
> >
> >
> >                                   aim7.jobs-per-min
> >
> >   29000 +-+------------------------------------------------------------=
-----+
> >   28500 +-+               +..   +                           +..+..  +..=
     |
> >         |..+    +.+..+.. :    .. +  .+.+..+..+.+.. .+..+.. +       +   =
+    |
> >   28000 +-+ + ..         :   +    +.              +       +       +    =
     |
> >   27500 +-+  +          +                                              =
     |
> >         |                                                              =
     |
> >   27000 +-+                                                            =
     |
> >   26500 +-+                                                            =
     |
> >   26000 +-+                                                            =
     |
> >         |                                                              =
     |
> >   25500 +-+               O       O                               O O  =
O    |
> >   25000 +-+                     O    O         O  O O  O  O O          =
     O
> >         |    O  O O     O    O         O                       O       =
  O  |
> >   24500 O-+O         O                    O  O                         =
     |
> >   24000 +-+------------------------------------------------------------=
-----+
> >
> >
> > [*] bisect-good sample
> > [O] bisect-bad  sample
> >
> >
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are pr=
ovided
> > for informational purposes only. Any difference in system hardware or s=
oftware
> > design or configuration may affect actual performance.
> >
> >
> > Thanks,
> > Xiaolong
> >
> >
> >
> > _______________________________________________
> > LKP mailing list
> > LKP@lists.01.org
> > https://lists.01.org/mailman/listinfo/lkp
> >
