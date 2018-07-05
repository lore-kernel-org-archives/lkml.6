Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C360C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963D72417D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlKa1bjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963D72417D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753186AbeGEGBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:01:06 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:39991 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752773AbeGEGBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:01:03 -0400
Received: by mail-yw0-f196.google.com with SMTP id p129-v6so2570795ywg.7;
        Wed, 04 Jul 2018 23:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gFgtGqqhT8SoKj4UYgUobX64Nj32BFAHF+Jg6YtTKk8=;
        b=FlKa1bjxwgC3/Cs01SF5qQTm5AhwRguMsSbd2phUwgpPsxf+nBuJqf4F/OsFEFRnc/
         FdQcuHmrKCLdwXcs46FxA3QBe+Q1WhL+k9OjoZf2rwnWRCjSumBTFewBPTbm7ZFu8ekE
         NAjVMjItUq9qYhRtzvrwfNcreVDcXHpA68Pq8L/JXtVmpm6wBKImdpKNFc5dd9Z+LnEz
         qumMcsUtqs9B05mEzvhY6Xs3LSoDEe7Z6idhmp4n3/CCHcCZD+LqcHCH32p3OniQv48m
         Ws64AarGv8B+XRUa4Mg7Fw80iQUPLsIFsDTv/T6dj9qNgBhzqJ2FC8LIXsaIy7wRCk0F
         X8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gFgtGqqhT8SoKj4UYgUobX64Nj32BFAHF+Jg6YtTKk8=;
        b=jdEOC4DK/McxcmjTadESdPk5Kp6HBF25QxpYWEEty/tFRemnB9vv51NlDKKGwibnKF
         JRokFsBO2jF8/ypb+ymBQJe3TeGgUD2dvwy9z/LABglx48fGRD677CBT6kFxK5Ql6TNU
         iAcKNHxT8qki8ztQXiNHOvucYsZCKTKjIt6R4oELEllCOEp9BtAtbKIGDKHTVDK2dX33
         mthI3KGH5TtyXhiD6YzYIgQZlsIBoYZP/Bt+Lk0+d26sdbjAHauo26V5RWk3b05TMogm
         XkipGu8QtuMSBO8r2H6lu49Ks8smhPEt4Y8MwypcWoaNUZzvKpIUR9oRX3jXQTOJtgrI
         +yIg==
X-Gm-Message-State: APt69E3I9W/+dejnkVQSR3Pew2+xODddDdYQ5ybKSBYov65ASrPxazq0
        SNGwaM+n5M6S20Fb5LFQTrMUq4m5RFmup8v7i2U=
X-Google-Smtp-Source: AAOMgpcRjny+/TGBWz/PI35rH9tYn44jAMgBwyKm3eBNRsZW8GI8R1rkZcg2r2reoJqTWJ6QQgAXIBkNQefw6lhhsqU=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr2098950ywn.88.1530770462206;
 Wed, 04 Jul 2018 23:01:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:7dc5:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 23:01:01 -0700 (PDT)
In-Reply-To: <CAOQ4uxgRXzq+ZSmwRB_nyGijFJsiuWXaM_F74W-3JOyTvAEz-Q@mail.gmail.com>
References: <CAOQ4uxgRXzq+ZSmwRB_nyGijFJsiuWXaM_F74W-3JOyTvAEz-Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 Jul 2018 09:01:01 +0300
Message-ID: <CAOQ4uxhkFq3uy5685ksXK+ugTYA61_bKQ42g+xkCy4YdNqX1Lw@mail.gmail.com>
Subject: Re: [lkp-robot] [fs] 5c6de586e8: vm-scalability.throughput +12.4%
 improvement (from reorganizing struct inode?)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        kernel test robot <xiaolong.ye@intel.com>, LKP <lkp@01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 9:27 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> Linus,
>
> This may be a test fluctuation or as a result of moving
> i_blkbits closer to i_bytes and i_lock.
>
> In any case, ping for:
> https://marc.info/?l=3Dlinux-fsdevel&m=3D152882624707975&w=3D2
>

Linus,

Per your request, I will re-post the origin patch with a link to this
discussion (which has now been made public).

Thanks,
Amir.

>
> ---------- Forwarded message ----------
> From: kernel test robot <xiaolong.ye@intel.com>
> Date: Mon, Jul 2, 2018 at 8:14 AM
> Subject: [lkp-robot] [fs]  5c6de586e8:  vm-scalability.throughput
> +12.4% improvement
> To: Amir Goldstein <amir73il@gmail.com>
> Cc: lkp@01.org
>
>
>
> Greeting,
>
> FYI, we noticed a +12.4% improvement of vm-scalability.throughput due to =
commit:
>
>
> commit: 5c6de586e899a4a80a0ffa26468639f43dee1009 ("[PATCH] fs: shave 8
> bytes off of struct inode")
> url: https://github.com/0day-ci/linux/commits/Amir-Goldstein/fs-shave-8-b=
ytes-off-of-struct-inode/20180612-192311
>
>
> in testcase: vm-scalability
> on test machine: 56 threads Intel(R) Xeon(R) CPU E5-2695 v3 @ 2.30GHz
> with 256G memory
> with following parameters:
>
>         runtime: 300s
>         test: small-allocs
>         cpufreq_governor: performance
>
> test-description: The motivation behind this suite is to exercise
> functions and regions of the mm/ of the Linux kernel which are of
> interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability=
.git/
>
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase=
:
>   gcc-7/performance/x86_64-rhel-7.2/debian-x86_64-2018-04-03.cgz/300s/lkp=
-hsw-ep5/small-allocs/vm-scalability
>
> commit:
>   8efcf34a26 (" ARM: SoC: late updates")
>   5c6de586e8 ("fs: shave 8 bytes off of struct inode")
>
> 8efcf34a263965e4 5c6de586e899a4a80a0ffa2646
> ---------------- --------------------------
>          %stddev     %change         %stddev
>              \          |                \
>   19335952           +12.4%   21729332        vm-scalability.throughput
>     693688           +11.9%     775935        vm-scalability.median
>       0.56 =C4=85 55%     -43.6%       0.32 =C4=85 62%  vm-scalability.st=
ddev
>     288.16            -7.0%     267.96        vm-scalability.time.elapsed=
_time
>     288.16            -7.0%     267.96
> vm-scalability.time.elapsed_time.max
>      48921 =C4=85  6%      -3.3%      47314 =C4=85  5%
> vm-scalability.time.involuntary_context_switches
>       3777            -4.4%       3610
> vm-scalability.time.maximum_resident_set_size
>  1.074e+09            +0.0%  1.074e+09
> vm-scalability.time.minor_page_faults
>       4096            +0.0%       4096        vm-scalability.time.page_si=
ze
>       2672            +0.6%       2689
> vm-scalability.time.percent_of_cpu_this_job_got
>       5457            -9.4%       4942        vm-scalability.time.system_=
time
>       2244            +0.9%       2263        vm-scalability.time.user_ti=
me
>    5529533 =C4=85  6%     -65.2%    1923014 =C4=85  6%
> vm-scalability.time.voluntary_context_switches
>  4.832e+09            +0.0%  4.832e+09        vm-scalability.workload
>      93827 =C4=85  3%      -7.0%      87299 =C4=85  3%
> interrupts.CAL:Function_call_interrupts
>      26.50            -2.0%      25.98 =C4=85  3%  boot-time.boot
>      16.69            -3.2%      16.16 =C4=85  5%  boot-time.dhcp
>     674.18            -1.1%     666.43 =C4=85  2%  boot-time.idle
>      17.61            -3.5%      17.00 =C4=85  5%  boot-time.kernel_boot
>      15034 =C4=85 62%     -30.0%      10528 =C4=85 79%  softirqs.NET_RX
>     453251 =C4=85  9%      -2.9%     440306 =C4=85 14%  softirqs.RCU
>      46795           -14.9%      39806 =C4=85  2%  softirqs.SCHED
>    3565160 =C4=85  8%      +6.1%    3784023        softirqs.TIMER
>       4.87 =C4=85  4%      -0.6        4.25 =C4=85  3%  mpstat.cpu.idle%
>       0.00 =C4=85 13%      -0.0        0.00 =C4=85 14%  mpstat.cpu.iowait=
%
>       0.00 =C4=85 37%      +0.0        0.00 =C4=85 37%  mpstat.cpu.soft%
>      67.35            -1.8       65.60        mpstat.cpu.sys%
>      27.78            +2.4       30.14        mpstat.cpu.usr%
>       1038            -0.5%       1033        vmstat.memory.buff
>    1117006            -0.3%    1113807        vmstat.memory.cache
>  2.463e+08            -0.2%  2.457e+08        vmstat.memory.free
>      26.00            +1.9%      26.50        vmstat.procs.r
>      42239 =C4=85  6%     -55.9%      18619 =C4=85  5%  vmstat.system.cs
>      31359            -0.7%      31132        vmstat.system.in
>       0.00          -100.0%       0.00        numa-numastat.node0.interle=
ave_hit
>    2713006            -1.0%    2685108        numa-numastat.node0.local_n=
ode
>    2716657            -1.0%    2689682        numa-numastat.node0.numa_hi=
t
>       3651 =C4=85 36%     +25.3%       4576 =C4=85 34%  numa-numastat.nod=
e0.other_node
>       0.00          -100.0%       0.00        numa-numastat.node1.interle=
ave_hit
>    2713025            -0.5%    2699801        numa-numastat.node1.local_n=
ode
>    2714924            -0.5%    2700769        numa-numastat.node1.numa_hi=
t
>       1900 =C4=85 68%     -49.1%     968.00 =C4=85162%  numa-numastat.nod=
e1.other_node
>   21859882 =C4=85  6%     -56.1%    9599175 =C4=85  2%  cpuidle.C1.time
>    5231991 =C4=85  6%     -65.3%    1814200 =C4=85  8%  cpuidle.C1.usage
>     620147 =C4=85  9%     -22.4%     481528 =C4=85 10%  cpuidle.C1E.time
>       7829 =C4=85  6%     -34.5%       5126 =C4=85 17%  cpuidle.C1E.usage
>    5343219 =C4=85  5%     -58.8%    2202020 =C4=85  4%  cpuidle.C3.time
>      22942 =C4=85  5%     -54.9%      10349 =C4=85  4%  cpuidle.C3.usage
>  3.345e+08 =C4=85  3%     -15.1%  2.839e+08 =C4=85  3%  cpuidle.C6.time
>     355754 =C4=85  3%     -16.3%     297683 =C4=85  3%  cpuidle.C6.usage
>     248800 =C4=85  6%     -74.5%      63413 =C4=85  5%  cpuidle.POLL.time
>      90897 =C4=85  6%     -76.4%      21409 =C4=85  7%  cpuidle.POLL.usag=
e
>       2631            +0.5%       2644        turbostat.Avg_MHz
>      95.35            +0.5       95.88        turbostat.Busy%
>       2759            -0.1%       2757        turbostat.Bzy_MHz
>    5227940 =C4=85  6%     -65.4%    1809983 =C4=85  8%  turbostat.C1
>       0.27 =C4=85  5%      -0.1        0.13 =C4=85  3%  turbostat.C1%
>       7646 =C4=85  5%     -36.0%       4894 =C4=85 17%  turbostat.C1E
>       0.01            +0.0        0.01        turbostat.C1E%
>      22705 =C4=85  5%     -56.0%       9995 =C4=85  3%  turbostat.C3
>       0.07 =C4=85  7%      -0.0        0.03        turbostat.C3%
>     354625 =C4=85  3%     -16.3%     296732 =C4=85  3%  turbostat.C6
>       4.11 =C4=85  3%      -0.4        3.75 =C4=85  2%  turbostat.C6%
>       1.68 =C4=85  3%     -15.6%       1.42 =C4=85  2%  turbostat.CPU%c1
>       0.04           -62.5%       0.01 =C4=85 33%  turbostat.CPU%c3
>       2.93 =C4=85  3%      -8.1%       2.69 =C4=85  2%  turbostat.CPU%c6
>      64.50            -1.6%      63.50 =C4=85  2%  turbostat.CoreTmp
>    9095020            -7.6%    8400668        turbostat.IRQ
>      11.78 =C4=85  5%      -2.3        9.45 =C4=85  6%  turbostat.PKG_%
>       0.10 =C4=85 27%      -4.9%       0.10 =C4=85 22%  turbostat.Pkg%pc2
>       0.00 =C4=85173%    -100.0%       0.00        turbostat.Pkg%pc6
>      68.50 =C4=85  2%      +0.0%      68.50        turbostat.PkgTmp
>     230.97            +0.1%     231.10        turbostat.PkgWatt
>      22.45            -0.8%      22.27        turbostat.RAMWatt
>      10304            -8.6%       9415 =C4=85  2%  turbostat.SMI
>       2300            +0.0%       2300        turbostat.TSC_MHz
>     269189            -0.6%     267505        meminfo.Active
>     269118            -0.6%     267429        meminfo.Active(anon)
>     167369            -1.7%     164478        meminfo.AnonHugePages
>     245606            +0.2%     246183        meminfo.AnonPages
>       1042            -0.2%       1039        meminfo.Buffers
>    1066883            -0.2%    1064908        meminfo.Cached
>     203421            -0.0%     203421        meminfo.CmaFree
>     204800            +0.0%     204800        meminfo.CmaTotal
>   1.32e+08            -0.0%   1.32e+08        meminfo.CommitLimit
>     485388 =C4=85 15%      -5.3%     459546 =C4=85  9%  meminfo.Committed=
_AS
>   2.65e+08            +0.0%   2.65e+08        meminfo.DirectMap1G
>    5240434 =C4=85  8%      +0.3%    5257281 =C4=85 16%  meminfo.DirectMap=
2M
>     169088 =C4=85  6%     -10.0%     152241 =C4=85  5%  meminfo.DirectMap=
4k
>       2048            +0.0%       2048        meminfo.Hugepagesize
>     150295            +0.1%     150389        meminfo.Inactive
>     149164            +0.1%     149264        meminfo.Inactive(anon)
>       1130            -0.6%       1124        meminfo.Inactive(file)
>       7375            -0.4%       7345        meminfo.KernelStack
>      28041            -0.5%      27895        meminfo.Mapped
>  2.451e+08            -0.2%  2.445e+08        meminfo.MemAvailable
>  2.462e+08            -0.2%  2.457e+08        meminfo.MemFree
>   2.64e+08            -0.0%   2.64e+08        meminfo.MemTotal
>       1179 =C4=85 57%     -35.2%     764.50 =C4=85100%  meminfo.Mlocked
>    4507108            +3.4%    4660163        meminfo.PageTables
>      50580            -1.9%      49633        meminfo.SReclaimable
>   11620141            +3.3%   12007592        meminfo.SUnreclaim
>     172885            -1.4%     170543        meminfo.Shmem
>   11670722            +3.3%   12057225        meminfo.Slab
>     894024            +0.0%     894327        meminfo.Unevictable
>  3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
>  6.873e+12            -2.1%  6.727e+12        perf-stat.branch-instructio=
ns
>       0.08 =C4=85  2%      -0.0        0.08        perf-stat.branch-miss-=
rate%
>  5.269e+09 =C4=85  2%      -3.7%  5.072e+09        perf-stat.branch-misse=
s
>      37.34            +1.1       38.44        perf-stat.cache-miss-rate%
>  8.136e+09 =C4=85  2%      -7.0%  7.568e+09 =C4=85  3%  perf-stat.cache-m=
isses
>  2.179e+10 =C4=85  2%      -9.6%  1.969e+10 =C4=85  3%  perf-stat.cache-r=
eferences
>   12287807 =C4=85  6%     -59.1%    5020001 =C4=85  5%  perf-stat.context=
-switches
>       0.87            -3.5%       0.84        perf-stat.cpi
>  2.116e+13            -6.5%  1.978e+13        perf-stat.cpu-cycles
>      24160 =C4=85  5%     -13.8%      20819 =C4=85  3%  perf-stat.cpu-mig=
rations
>       0.16 =C4=85  6%      +0.0        0.16 =C4=85  4%  perf-stat.dTLB-lo=
ad-miss-rate%
>  1.057e+10 =C4=85  6%      +0.4%  1.061e+10 =C4=85  5%  perf-stat.dTLB-lo=
ad-misses
>  6.792e+12            -3.5%  6.557e+12        perf-stat.dTLB-loads
>       0.00 =C4=85  9%      +0.0        0.00 =C4=85 20%  perf-stat.dTLB-st=
ore-miss-rate%
>   22950816 =C4=85  9%      +6.2%   24373827 =C4=85 20%  perf-stat.dTLB-st=
ore-misses
>  9.067e+11            -0.7%  9.005e+11        perf-stat.dTLB-stores
>      95.10            +2.7       97.81        perf-stat.iTLB-load-miss-ra=
te%
>  2.437e+09            +6.8%  2.604e+09 =C4=85  4%  perf-stat.iTLB-load-mi=
sses
>  1.257e+08 =C4=85  8%     -53.7%   58211601 =C4=85  6%  perf-stat.iTLB-lo=
ads
>   2.44e+13            -3.1%  2.364e+13        perf-stat.instructions
>      10011            -9.1%       9100 =C4=85  4%
> perf-stat.instructions-per-iTLB-miss
>       1.15            +3.6%       1.20        perf-stat.ipc
>  1.074e+09            -0.0%  1.074e+09        perf-stat.minor-faults
>      64.40 =C4=85  4%      -4.2       60.22 =C4=85  5%  perf-stat.node-lo=
ad-miss-rate%
>  4.039e+09 =C4=85  2%     -10.9%  3.599e+09 =C4=85  3%  perf-stat.node-lo=
ad-misses
>  2.241e+09 =C4=85 10%      +6.7%   2.39e+09 =C4=85 12%  perf-stat.node-lo=
ads
>      49.24            -1.7       47.53        perf-stat.node-store-miss-r=
ate%
>  9.005e+08           -18.3%  7.357e+08 =C4=85  2%  perf-stat.node-store-m=
isses
>  9.282e+08           -12.5%  8.123e+08 =C4=85  2%  perf-stat.node-stores
>  1.074e+09            -0.0%  1.074e+09        perf-stat.page-faults
>       5049            -3.1%       4893        perf-stat.path-length
>      67282            -0.6%      66860        proc-vmstat.nr_active_anon
>      61404            +0.2%      61545        proc-vmstat.nr_anon_pages
>    6117769            -0.2%    6104302
> proc-vmstat.nr_dirty_background_threshold
>   12250497            -0.2%   12223531        proc-vmstat.nr_dirty_thresh=
old
>     266952            -0.2%     266464        proc-vmstat.nr_file_pages
>      50855            -0.0%      50855        proc-vmstat.nr_free_cma
>   61552505            -0.2%   61417644        proc-vmstat.nr_free_pages
>      37259            +0.1%      37286        proc-vmstat.nr_inactive_ano=
n
>     282.25            -0.6%     280.50        proc-vmstat.nr_inactive_fil=
e
>       7375            -0.4%       7344        proc-vmstat.nr_kernel_stack
>       7124            -0.5%       7085        proc-vmstat.nr_mapped
>     295.00 =C4=85 57%     -35.3%     190.75 =C4=85100%  proc-vmstat.nr_ml=
ock
>    1125531            +3.4%    1163908        proc-vmstat.nr_page_table_p=
ages
>      43193            -1.3%      42613        proc-vmstat.nr_shmem
>      12644            -1.9%      12407        proc-vmstat.nr_slab_reclaim=
able
>    2901812            +3.3%    2998814        proc-vmstat.nr_slab_unrecla=
imable
>     223506            +0.0%     223581        proc-vmstat.nr_unevictable
>      67282            -0.6%      66860        proc-vmstat.nr_zone_active_=
anon
>      37259            +0.1%      37286        proc-vmstat.nr_zone_inactiv=
e_anon
>     282.25            -0.6%     280.50        proc-vmstat.nr_zone_inactiv=
e_file
>     223506            +0.0%     223581        proc-vmstat.nr_zone_unevict=
able
>       2685 =C4=85104%    +108.2%       5591 =C4=85 84%  proc-vmstat.numa_=
hint_faults
>       1757 =C4=85140%     +77.9%       3125 =C4=85 87%  proc-vmstat.numa_=
hint_faults_local
>    5456982            -0.7%    5417832        proc-vmstat.numa_hit
>    5451431            -0.7%    5412285        proc-vmstat.numa_local
>       5551            -0.1%       5547        proc-vmstat.numa_other
>     977.50 =C4=85 40%    +193.7%       2871 =C4=85101%  proc-vmstat.numa_=
pages_migrated
>      10519 =C4=85113%    +140.4%      25286 =C4=85 97%  proc-vmstat.numa_=
pte_updates
>      10726 =C4=85  8%      -3.8%      10315 =C4=85  7%  proc-vmstat.pgact=
ivate
>    8191987            -0.5%    8150192        proc-vmstat.pgalloc_normal
>  1.074e+09            -0.0%  1.074e+09        proc-vmstat.pgfault
>    8143430            -2.7%    7926613        proc-vmstat.pgfree
>     977.50 =C4=85 40%    +193.7%       2871 =C4=85101%  proc-vmstat.pgmig=
rate_success
>       2155            -0.4%       2147        proc-vmstat.pgpgin
>       2049            -0.0%       2048        proc-vmstat.pgpgout
>      67375            -0.2%      67232
> slabinfo.Acpi-Namespace.active_objs
>      67375            -0.2%      67232        slabinfo.Acpi-Namespace.num=
_objs
>     604.00 =C4=85 19%      -0.1%     603.50 =C4=85  9%  slabinfo.Acpi-Par=
seExt.active_objs
>     604.00 =C4=85 19%      -0.1%     603.50 =C4=85  9%  slabinfo.Acpi-Par=
seExt.num_objs
>       7972 =C4=85  4%      -0.3%       7949 =C4=85  2%  slabinfo.anon_vma=
.active_objs
>       7972 =C4=85  4%      -0.3%       7949 =C4=85  2%  slabinfo.anon_vma=
.num_objs
>       1697 =C4=85 12%     -10.0%       1528 =C4=85  7%  slabinfo.avtab_no=
de.active_objs
>       1697 =C4=85 12%     -10.0%       1528 =C4=85  7%  slabinfo.avtab_no=
de.num_objs
>      58071            -0.1%      58034        slabinfo.dentry.active_objs
>       1351 =C4=85 25%     -31.2%     930.50 =C4=85 30%
> slabinfo.dmaengine-unmap-16.active_objs
>       1351 =C4=85 25%     -31.2%     930.50 =C4=85 30%
> slabinfo.dmaengine-unmap-16.num_objs
>       1354 =C4=85  6%      -7.1%       1258 =C4=85  9%  slabinfo.eventpol=
l_pwq.active_objs
>       1354 =C4=85  6%      -7.1%       1258 =C4=85  9%  slabinfo.eventpol=
l_pwq.num_objs
>       8880 =C4=85  5%      +0.0%       8883 =C4=85  6%  slabinfo.filp.num=
_objs
>       2715 =C4=85  7%      -9.0%       2470 =C4=85  5%  slabinfo.kmalloc-=
1024.active_objs
>       2831 =C4=85  7%     -10.2%       2543 =C4=85  3%  slabinfo.kmalloc-=
1024.num_objs
>      12480            -2.7%      12140 =C4=85  2%  slabinfo.kmalloc-16.ac=
tive_objs
>      12480            -2.7%      12140 =C4=85  2%  slabinfo.kmalloc-16.nu=
m_objs
>      39520 =C4=85  3%      +1.0%      39922        slabinfo.kmalloc-32.ac=
tive_objs
>      37573            +0.1%      37616        slabinfo.kmalloc-64.active_=
objs
>      37590            +0.2%      37673        slabinfo.kmalloc-64.num_obj=
s
>      17182            +2.1%      17550 =C4=85  2%  slabinfo.kmalloc-8.act=
ive_objs
>      17663            +2.2%      18045 =C4=85  2%  slabinfo.kmalloc-8.num=
_objs
>       4428 =C4=85  7%      -2.9%       4298 =C4=85  4%  slabinfo.kmalloc-=
96.active_objs
>     956.50 =C4=85 10%      +4.5%     999.50 =C4=85 16%  slabinfo.nsproxy.=
active_objs
>     956.50 =C4=85 10%      +4.5%     999.50 =C4=85 16%  slabinfo.nsproxy.=
num_objs
>      19094 =C4=85  3%      -3.3%      18463 =C4=85  5%  slabinfo.pid.acti=
ve_objs
>      19094 =C4=85  3%      -3.0%      18523 =C4=85  5%  slabinfo.pid.num_=
objs
>       2088 =C4=85 14%     -21.1%       1648 =C4=85  8%
> slabinfo.skbuff_head_cache.active_objs
>       2136 =C4=85 16%     -19.5%       1720 =C4=85  7%
> slabinfo.skbuff_head_cache.num_objs
>     872.00 =C4=85 16%      -9.3%     791.00 =C4=85 15%  slabinfo.task_gro=
up.active_objs
>     872.00 =C4=85 16%      -9.3%     791.00 =C4=85 15%  slabinfo.task_gro=
up.num_objs
>   57677936            +3.4%   59655533
> slabinfo.vm_area_struct.active_objs
>    1442050            +3.4%    1491482
> slabinfo.vm_area_struct.active_slabs
>   57682039            +3.4%   59659325        slabinfo.vm_area_struct.num=
_objs
>    1442050            +3.4%    1491482        slabinfo.vm_area_struct.num=
_slabs
>     132527 =C4=85 15%      +1.9%     135006 =C4=85  2%  numa-meminfo.node=
0.Active
>     132475 =C4=85 15%      +1.9%     134985 =C4=85  2%  numa-meminfo.node=
0.Active(anon)
>      86736 =C4=85 32%      +6.5%      92413 =C4=85 15%  numa-meminfo.node=
0.AnonHugePages
>     124613 =C4=85 19%      +3.4%     128788 =C4=85  4%  numa-meminfo.node=
0.AnonPages
>     556225 =C4=85 11%      -5.1%     527584 =C4=85 12%  numa-meminfo.node=
0.FilePages
>     100973 =C4=85 57%     -27.7%      73011 =C4=85 89%  numa-meminfo.node=
0.Inactive
>     100128 =C4=85 57%     -27.4%      72686 =C4=85 90%  numa-meminfo.node=
0.Inactive(anon)
>     843.75 =C4=85 57%     -61.5%     324.75 =C4=85115%  numa-meminfo.node=
0.Inactive(file)
>       4058 =C4=85  3%      +3.5%       4200 =C4=85  4%  numa-meminfo.node=
0.KernelStack
>      12846 =C4=85 26%      +1.6%      13053 =C4=85 26%  numa-meminfo.node=
0.Mapped
>  1.228e+08            -0.1%  1.226e+08        numa-meminfo.node0.MemFree
>   1.32e+08            +0.0%   1.32e+08        numa-meminfo.node0.MemTotal
>    9191573            +1.7%    9347737        numa-meminfo.node0.MemUsed
>    2321138            +2.2%    2372650        numa-meminfo.node0.PageTabl=
es
>      24816 =C4=85 13%      -5.8%      23377 =C4=85 16%  numa-meminfo.node=
0.SReclaimable
>    5985628            +2.2%    6116406        numa-meminfo.node0.SUnrecla=
im
>     108046 =C4=85 57%     -26.9%      78955 =C4=85 80%  numa-meminfo.node=
0.Shmem
>    6010444            +2.2%    6139784        numa-meminfo.node0.Slab
>     447344            +0.2%     448404        numa-meminfo.node0.Unevicta=
ble
>     136675 =C4=85 13%      -3.0%     132521 =C4=85  2%  numa-meminfo.node=
1.Active
>     136655 =C4=85 13%      -3.1%     132467 =C4=85  2%  numa-meminfo.node=
1.Active(anon)
>      80581 =C4=85 35%     -10.5%      72102 =C4=85 18%  numa-meminfo.node=
1.AnonHugePages
>     120993 =C4=85 20%      -3.0%     117407 =C4=85  4%  numa-meminfo.node=
1.AnonPages
>     511901 =C4=85 12%      +5.2%     538396 =C4=85 11%  numa-meminfo.node=
1.FilePages
>      49526 =C4=85116%     +56.3%      77402 =C4=85 84%  numa-meminfo.node=
1.Inactive
>      49238 =C4=85115%     +55.6%      76603 =C4=85 85%  numa-meminfo.node=
1.Inactive(anon)
>     287.75 =C4=85168%    +177.6%     798.75 =C4=85 47%  numa-meminfo.node=
1.Inactive(file)
>       3316 =C4=85  3%      -5.2%       3143 =C4=85  5%  numa-meminfo.node=
1.KernelStack
>      15225 =C4=85 23%      -2.0%      14918 =C4=85 22%  numa-meminfo.node=
1.Mapped
>  1.234e+08            -0.3%   1.23e+08        numa-meminfo.node1.MemFree
>  1.321e+08            -0.0%  1.321e+08        numa-meminfo.node1.MemTotal
>    8664187            +4.4%    9041729        numa-meminfo.node1.MemUsed
>    2185511            +4.6%    2286356        numa-meminfo.node1.PageTabl=
es
>      25762 =C4=85 12%      +1.9%      26255 =C4=85 15%  numa-meminfo.node=
1.SReclaimable
>    5634774            +4.5%    5887602        numa-meminfo.node1.SUnrecla=
im
>      65037 =C4=85 92%     +40.9%      91621 =C4=85 68%  numa-meminfo.node=
1.Shmem
>    5660536            +4.5%    5913858        numa-meminfo.node1.Slab
>     446680            -0.2%     445922        numa-meminfo.node1.Unevicta=
ble
>      15553 =C4=85 18%     -14.1%      13366 =C4=85 11%  numa-vmstat.node0
>      33116 =C4=85 15%      +1.9%      33742 =C4=85  2%  numa-vmstat.node0=
.nr_active_anon
>      31157 =C4=85 19%      +3.3%      32196 =C4=85  4%  numa-vmstat.node0=
.nr_anon_pages
>     139001 =C4=85 11%      -5.1%     131864 =C4=85 12%  numa-vmstat.node0=
.nr_file_pages
>   30692447            -0.1%   30654328        numa-vmstat.node0.nr_free_p=
ages
>      24983 =C4=85 57%     -27.4%      18142 =C4=85 90%  numa-vmstat.node0=
.nr_inactive_anon
>     210.25 =C4=85 57%     -61.6%      80.75 =C4=85116%  numa-vmstat.node0=
.nr_inactive_file
>       4058 =C4=85  3%      +3.5%       4199 =C4=85  4%  numa-vmstat.node0=
.nr_kernel_stack
>       3304 =C4=85 26%      +1.2%       3344 =C4=85 25%  numa-vmstat.node0=
.nr_mapped
>     139.00 =C4=85 60%     -20.3%     110.75 =C4=85100%  numa-vmstat.node0=
.nr_mlock
>     579931            +2.1%     592262
> numa-vmstat.node0.nr_page_table_pages
>      26956 =C4=85 57%     -26.9%      19707 =C4=85 80%  numa-vmstat.node0=
.nr_shmem
>       6203 =C4=85 13%      -5.8%       5844 =C4=85 16%
> numa-vmstat.node0.nr_slab_reclaimable
>    1495541            +2.2%    1527781
> numa-vmstat.node0.nr_slab_unreclaimable
>     111835            +0.2%     112100        numa-vmstat.node0.nr_unevic=
table
>      33116 =C4=85 15%      +1.9%      33742 =C4=85  2%
> numa-vmstat.node0.nr_zone_active_anon
>      24983 =C4=85 57%     -27.4%      18142 =C4=85 90%
> numa-vmstat.node0.nr_zone_inactive_anon
>     210.25 =C4=85 57%     -61.6%      80.75 =C4=85116%
> numa-vmstat.node0.nr_zone_inactive_file
>     111835            +0.2%     112100
> numa-vmstat.node0.nr_zone_unevictable
>    1840693 =C4=85  2%      +1.6%    1869501        numa-vmstat.node0.numa=
_hit
>     144048            +0.2%     144385        numa-vmstat.node0.numa_inte=
rleave
>    1836656 =C4=85  2%      +1.5%    1864579        numa-vmstat.node0.numa=
_local
>       4036 =C4=85 33%     +21.9%       4921 =C4=85 31%  numa-vmstat.node0=
.numa_other
>      11577 =C4=85 24%     +17.8%      13635 =C4=85 11%  numa-vmstat.node1
>      34171 =C4=85 13%      -3.1%      33126 =C4=85  2%  numa-vmstat.node1=
.nr_active_anon
>      30247 =C4=85 20%      -3.0%      29352 =C4=85  4%  numa-vmstat.node1=
.nr_anon_pages
>     127979 =C4=85 12%      +5.2%     134601 =C4=85 11%  numa-vmstat.node1=
.nr_file_pages
>      50855            -0.0%      50855        numa-vmstat.node1.nr_free_c=
ma
>   30858027            -0.3%   30763794        numa-vmstat.node1.nr_free_p=
ages
>      12305 =C4=85116%     +55.6%      19145 =C4=85 85%  numa-vmstat.node1=
.nr_inactive_anon
>      71.75 =C4=85168%    +177.7%     199.25 =C4=85 47%  numa-vmstat.node1=
.nr_inactive_file
>       3315 =C4=85  3%      -5.2%       3144 =C4=85  5%  numa-vmstat.node1=
.nr_kernel_stack
>       3823 =C4=85 23%      -1.8%       3754 =C4=85 22%  numa-vmstat.node1=
.nr_mapped
>     155.00 =C4=85 60%     -48.2%      80.25 =C4=85100%  numa-vmstat.node1=
.nr_mlock
>     545973            +4.6%     571069
> numa-vmstat.node1.nr_page_table_pages
>      16263 =C4=85 92%     +40.9%      22907 =C4=85 68%  numa-vmstat.node1=
.nr_shmem
>       6440 =C4=85 12%      +1.9%       6563 =C4=85 15%
> numa-vmstat.node1.nr_slab_reclaimable
>    1407904            +4.5%    1471030
> numa-vmstat.node1.nr_slab_unreclaimable
>     111669            -0.2%     111480        numa-vmstat.node1.nr_unevic=
table
>      34171 =C4=85 13%      -3.1%      33126 =C4=85  2%
> numa-vmstat.node1.nr_zone_active_anon
>      12305 =C4=85116%     +55.6%      19145 =C4=85 85%
> numa-vmstat.node1.nr_zone_inactive_anon
>      71.75 =C4=85168%    +177.7%     199.25 =C4=85 47%
> numa-vmstat.node1.nr_zone_inactive_file
>     111669            -0.2%     111480
> numa-vmstat.node1.nr_zone_unevictable
>    1846889 =C4=85  2%      +1.4%    1872108        numa-vmstat.node1.numa=
_hit
>     144151            -0.2%     143830        numa-vmstat.node1.numa_inte=
rleave
>    1699975 =C4=85  2%      +1.6%    1726462        numa-vmstat.node1.numa=
_local
>     146913            -0.9%     145645        numa-vmstat.node1.numa_othe=
r
>       0.00        +1.2e+12%      12083 =C4=85100%
> sched_debug.cfs_rq:/.MIN_vruntime.avg
>       0.00        +3.4e+13%     338347 =C4=85100%
> sched_debug.cfs_rq:/.MIN_vruntime.max
>       0.00            +0.0%       0.00
> sched_debug.cfs_rq:/.MIN_vruntime.min
>       0.00        +1.5e+28%      62789 =C4=85100%
> sched_debug.cfs_rq:/.MIN_vruntime.stddev
>     118226            +0.4%     118681
> sched_debug.cfs_rq:/.exec_clock.avg
>     119425            +0.3%     119724
> sched_debug.cfs_rq:/.exec_clock.max
>     117183            +0.1%     117244
> sched_debug.cfs_rq:/.exec_clock.min
>     395.73 =C4=85 14%     +11.0%     439.18 =C4=85 23%
> sched_debug.cfs_rq:/.exec_clock.stddev
>      32398           +14.1%      36980 =C4=85  9%  sched_debug.cfs_rq:/.l=
oad.avg
>      73141 =C4=85  5%    +128.0%     166780 =C4=85 57%  sched_debug.cfs_r=
q:/.load.max
>      17867 =C4=85 19%     +30.4%      23301 =C4=85 13%  sched_debug.cfs_r=
q:/.load.min
>      11142 =C4=85  3%    +146.4%      27458 =C4=85 62%  sched_debug.cfs_r=
q:/.load.stddev
>      59.52 =C4=85  2%      -2.3%      58.13 =C4=85  6%  sched_debug.cfs_r=
q:/.load_avg.avg
>     305.15 =C4=85 10%      -8.8%     278.35 =C4=85  3%  sched_debug.cfs_r=
q:/.load_avg.max
>      27.20 =C4=85  6%      +8.6%      29.55        sched_debug.cfs_rq:/.l=
oad_avg.min
>      71.12 =C4=85  9%      -8.1%      65.38 =C4=85  5%
> sched_debug.cfs_rq:/.load_avg.stddev
>       0.00        +1.2e+12%      12083 =C4=85100%
> sched_debug.cfs_rq:/.max_vruntime.avg
>       0.00        +3.4e+13%     338347 =C4=85100%
> sched_debug.cfs_rq:/.max_vruntime.max
>       0.00            +0.0%       0.00
> sched_debug.cfs_rq:/.max_vruntime.min
>       0.00        +1.5e+28%      62789 =C4=85100%
> sched_debug.cfs_rq:/.max_vruntime.stddev
>    3364874            +0.8%    3391671
> sched_debug.cfs_rq:/.min_vruntime.avg
>    3399316            +0.7%    3423051
> sched_debug.cfs_rq:/.min_vruntime.max
>    3303899            +0.9%    3335083
> sched_debug.cfs_rq:/.min_vruntime.min
>      20061 =C4=85 14%      -2.5%      19552 =C4=85 16%
> sched_debug.cfs_rq:/.min_vruntime.stddev
>       0.87            +3.1%       0.89 =C4=85  2%
> sched_debug.cfs_rq:/.nr_running.avg
>       1.00            +5.0%       1.05 =C4=85  8%
> sched_debug.cfs_rq:/.nr_running.max
>       0.50 =C4=85 19%     +20.0%       0.60
> sched_debug.cfs_rq:/.nr_running.min
>       0.16 =C4=85 14%      -6.0%       0.15 =C4=85 11%
> sched_debug.cfs_rq:/.nr_running.stddev
>       4.14 =C4=85  6%      -6.5%       3.87 =C4=85 10%
> sched_debug.cfs_rq:/.nr_spread_over.avg
>      15.10 =C4=85  7%     +29.8%      19.60 =C4=85 12%
> sched_debug.cfs_rq:/.nr_spread_over.max
>       1.50 =C4=85 11%     -16.7%       1.25 =C4=85 20%
> sched_debug.cfs_rq:/.nr_spread_over.min
>       2.82 =C4=85  8%     +23.0%       3.47 =C4=85 13%
> sched_debug.cfs_rq:/.nr_spread_over.stddev
>       7.31            -6.2%       6.86 =C4=85 69%
> sched_debug.cfs_rq:/.removed.load_avg.avg
>     204.80           -28.2%     147.10 =C4=85 57%
> sched_debug.cfs_rq:/.removed.load_avg.max
>      38.01           -20.3%      30.29 =C4=85 60%
> sched_debug.cfs_rq:/.removed.load_avg.stddev
>     337.44            -6.0%     317.11 =C4=85 69%
> sched_debug.cfs_rq:/.removed.runnable_sum.avg
>       9448           -27.8%       6819 =C4=85 57%
> sched_debug.cfs_rq:/.removed.runnable_sum.max
>       1753           -20.2%       1399 =C4=85 60%
> sched_debug.cfs_rq:/.removed.runnable_sum.stddev
>       2.16 =C4=85 56%     -25.7%       1.60 =C4=85 57%
> sched_debug.cfs_rq:/.removed.util_avg.avg
>      60.40 =C4=85 56%     -37.3%      37.90 =C4=85 61%
> sched_debug.cfs_rq:/.removed.util_avg.max
>      11.21 =C4=85 56%     -33.8%       7.42 =C4=85 58%
> sched_debug.cfs_rq:/.removed.util_avg.stddev
>      30.32 =C4=85  2%      +0.6%      30.52 =C4=85  3%
> sched_debug.cfs_rq:/.runnable_load_avg.avg
>      80.90 =C4=85 14%     -19.2%      65.35 =C4=85 34%
> sched_debug.cfs_rq:/.runnable_load_avg.max
>      14.95 =C4=85 24%     +47.2%      22.00 =C4=85 12%
> sched_debug.cfs_rq:/.runnable_load_avg.min
>      12.10 =C4=85 19%     -27.7%       8.74 =C4=85 42%
> sched_debug.cfs_rq:/.runnable_load_avg.stddev
>      30853           +13.2%      34914 =C4=85 10%
> sched_debug.cfs_rq:/.runnable_weight.avg
>      61794          +152.3%     155911 =C4=85 64%
> sched_debug.cfs_rq:/.runnable_weight.max
>      17867 =C4=85 19%     +30.4%      23300 =C4=85 13%
> sched_debug.cfs_rq:/.runnable_weight.min
>       8534 =C4=85  7%    +193.7%      25066 =C4=85 72%
> sched_debug.cfs_rq:/.runnable_weight.stddev
>      45914 =C4=85 45%     -50.7%      22619 =C4=85 62%  sched_debug.cfs_r=
q:/.spread0.avg
>      80385 =C4=85 26%     -32.8%      53990 =C4=85 34%  sched_debug.cfs_r=
q:/.spread0.max
>     -15013          +126.3%     -33973        sched_debug.cfs_rq:/.spread=
0.min
>      20053 =C4=85 14%      -2.5%      19541 =C4=85 16%
> sched_debug.cfs_rq:/.spread0.stddev
>     964.19            -0.2%     962.12        sched_debug.cfs_rq:/.util_a=
vg.avg
>       1499 =C4=85 14%     -13.2%       1301 =C4=85  4%  sched_debug.cfs_r=
q:/.util_avg.max
>     510.75 =C4=85 12%     +35.6%     692.65 =C4=85 13%  sched_debug.cfs_r=
q:/.util_avg.min
>     177.84 =C4=85 21%     -34.4%     116.72 =C4=85 23%
> sched_debug.cfs_rq:/.util_avg.stddev
>     768.04            +5.1%     807.40
> sched_debug.cfs_rq:/.util_est_enqueued.avg
>       1192 =C4=85 14%     -22.5%     924.20
> sched_debug.cfs_rq:/.util_est_enqueued.max
>     170.90 =C4=85 99%     +89.6%     324.05 =C4=85 21%
> sched_debug.cfs_rq:/.util_est_enqueued.min
>     201.22 =C4=85 17%     -36.7%     127.44 =C4=85 15%
> sched_debug.cfs_rq:/.util_est_enqueued.stddev
>     111567 =C4=85  4%      +7.6%     120067 =C4=85  7%  sched_debug.cpu.a=
vg_idle.avg
>     549432 =C4=85 16%     -16.6%     458264 =C4=85  5%  sched_debug.cpu.a=
vg_idle.max
>       4419 =C4=85 79%     +87.7%       8293 =C4=85 31%  sched_debug.cpu.a=
vg_idle.min
>     123967 =C4=85 13%      -8.9%     112928 =C4=85 15%  sched_debug.cpu.a=
vg_idle.stddev
>     147256            -0.4%     146724        sched_debug.cpu.clock.avg
>     147258            -0.4%     146728        sched_debug.cpu.clock.max
>     147252            -0.4%     146720        sched_debug.cpu.clock.min
>       1.70 =C4=85 11%     +39.5%       2.37 =C4=85 29%  sched_debug.cpu.c=
lock.stddev
>     147256            -0.4%     146724        sched_debug.cpu.clock_task.=
avg
>     147258            -0.4%     146728        sched_debug.cpu.clock_task.=
max
>     147252            -0.4%     146720        sched_debug.cpu.clock_task.=
min
>       1.70 =C4=85 11%     +39.4%       2.37 =C4=85 29%  sched_debug.cpu.c=
lock_task.stddev
>      30.85            +0.4%      30.97 =C4=85  3%  sched_debug.cpu.cpu_lo=
ad[0].avg
>      84.15 =C4=85 13%     -13.8%      72.55 =C4=85 21%  sched_debug.cpu.c=
pu_load[0].max
>      17.35 =C4=85 24%     +26.5%      21.95 =C4=85 24%  sched_debug.cpu.c=
pu_load[0].min
>      12.75 =C4=85 18%     -19.9%      10.22 =C4=85 22%  sched_debug.cpu.c=
pu_load[0].stddev
>      30.88            +1.1%      31.22 =C4=85  2%  sched_debug.cpu.cpu_lo=
ad[1].avg
>      77.35 =C4=85 19%      -9.8%      69.75 =C4=85 18%  sched_debug.cpu.c=
pu_load[1].max
>      18.60 =C4=85 19%     +31.2%      24.40 =C4=85 10%  sched_debug.cpu.c=
pu_load[1].min
>      11.10 =C4=85 24%     -20.5%       8.82 =C4=85 25%  sched_debug.cpu.c=
pu_load[1].stddev
>      31.13            +2.3%      31.84 =C4=85  2%  sched_debug.cpu.cpu_lo=
ad[2].avg
>      71.40 =C4=85 26%      +0.4%      71.70 =C4=85 20%  sched_debug.cpu.c=
pu_load[2].max
>      19.45 =C4=85 21%     +32.9%      25.85 =C4=85  5%  sched_debug.cpu.c=
pu_load[2].min
>       9.61 =C4=85 36%      -8.3%       8.81 =C4=85 27%  sched_debug.cpu.c=
pu_load[2].stddev
>      31.79            +2.9%      32.71 =C4=85  3%  sched_debug.cpu.cpu_lo=
ad[3].avg
>      76.75 =C4=85 19%      +8.1%      82.95 =C4=85 37%  sched_debug.cpu.c=
pu_load[3].max
>      20.25 =C4=85 14%     +33.3%      27.00 =C4=85  3%  sched_debug.cpu.c=
pu_load[3].min
>       9.88 =C4=85 28%      +6.7%      10.54 =C4=85 52%  sched_debug.cpu.c=
pu_load[3].stddev
>      32.95            +2.3%      33.71 =C4=85  3%  sched_debug.cpu.cpu_lo=
ad[4].avg
>     107.65 =C4=85  9%      +3.9%     111.90 =C4=85 33%  sched_debug.cpu.c=
pu_load[4].max
>      20.35 =C4=85  8%     +30.5%      26.55        sched_debug.cpu.cpu_lo=
ad[4].min
>      15.33 =C4=85 12%      +1.2%      15.51 =C4=85 46%  sched_debug.cpu.c=
pu_load[4].stddev
>       1244            +2.0%       1269        sched_debug.cpu.curr->pid.a=
vg
>       4194            -0.7%       4165        sched_debug.cpu.curr->pid.m=
ax
>     655.90 =C4=85 22%     +16.7%     765.75 =C4=85  3%  sched_debug.cpu.c=
urr->pid.min
>     656.54            -0.8%     651.46        sched_debug.cpu.curr->pid.s=
tddev
>      32481           +13.8%      36973 =C4=85  9%  sched_debug.cpu.load.a=
vg
>      73132 =C4=85  5%    +130.1%     168294 =C4=85 56%  sched_debug.cpu.l=
oad.max
>      17867 =C4=85 19%     +20.3%      21497        sched_debug.cpu.load.m=
in
>      11194 =C4=85  3%    +148.6%      27826 =C4=85 61%  sched_debug.cpu.l=
oad.stddev
>     500000            +0.0%     500000
> sched_debug.cpu.max_idle_balance_cost.avg
>     500000            +0.0%     500000
> sched_debug.cpu.max_idle_balance_cost.max
>     500000            +0.0%     500000
> sched_debug.cpu.max_idle_balance_cost.min
>       4294            -0.0%       4294        sched_debug.cpu.next_balanc=
e.avg
>       4294            -0.0%       4294        sched_debug.cpu.next_balanc=
e.max
>       4294            -0.0%       4294        sched_debug.cpu.next_balanc=
e.min
>       0.00 =C4=85  4%      -3.6%       0.00 =C4=85  5%
> sched_debug.cpu.next_balance.stddev
>     126191            -0.0%     126167
> sched_debug.cpu.nr_load_updates.avg
>     133303            -0.6%     132467
> sched_debug.cpu.nr_load_updates.max
>     124404            +0.4%     124852
> sched_debug.cpu.nr_load_updates.min
>       1826 =C4=85 13%      -8.5%       1672 =C4=85  5%
> sched_debug.cpu.nr_load_updates.stddev
>       0.90            +2.2%       0.92 =C4=85  2%  sched_debug.cpu.nr_run=
ning.avg
>       1.80 =C4=85  7%      -5.6%       1.70 =C4=85  5%  sched_debug.cpu.n=
r_running.max
>       0.50 =C4=85 19%     +20.0%       0.60        sched_debug.cpu.nr_run=
ning.min
>       0.29 =C4=85  7%     -13.6%       0.25 =C4=85  4%  sched_debug.cpu.n=
r_running.stddev
>     204123 =C4=85  8%     -56.8%      88239 =C4=85  5%  sched_debug.cpu.n=
r_switches.avg
>     457439 =C4=85 15%     -60.4%     181234 =C4=85  8%  sched_debug.cpu.n=
r_switches.max
>     116531 =C4=85 16%     -62.8%      43365 =C4=85 13%  sched_debug.cpu.n=
r_switches.min
>      72910 =C4=85 22%     -50.5%      36095 =C4=85 13%  sched_debug.cpu.n=
r_switches.stddev
>       0.03 =C4=85 19%     -52.9%       0.01 =C4=85 35%
> sched_debug.cpu.nr_uninterruptible.avg
>      16.50 =C4=85 14%     -11.5%      14.60 =C4=85 16%
> sched_debug.cpu.nr_uninterruptible.max
>     -16.90           -26.3%     -12.45
> sched_debug.cpu.nr_uninterruptible.min
>       7.97 =C4=85 12%     -19.4%       6.42 =C4=85 15%
> sched_debug.cpu.nr_uninterruptible.stddev
>     210655 =C4=85  8%     -56.7%      91289 =C4=85  5%  sched_debug.cpu.s=
ched_count.avg
>     467518 =C4=85 15%     -60.4%     185362 =C4=85  9%  sched_debug.cpu.s=
ched_count.max
>     120764 =C4=85 16%     -62.5%      45233 =C4=85 14%  sched_debug.cpu.s=
ched_count.min
>      74259 =C4=85 23%     -51.0%      36403 =C4=85 14%  sched_debug.cpu.s=
ched_count.stddev
>      89621 =C4=85  8%     -63.5%      32750 =C4=85  7%  sched_debug.cpu.s=
ched_goidle.avg
>     189668 =C4=85  8%     -67.5%      61630 =C4=85 18%  sched_debug.cpu.s=
ched_goidle.max
>      54342 =C4=85 16%     -68.0%      17412 =C4=85 15%  sched_debug.cpu.s=
ched_goidle.min
>      28685 =C4=85 15%     -58.7%      11834 =C4=85 16%
> sched_debug.cpu.sched_goidle.stddev
>     109820 =C4=85  8%     -56.0%      48303 =C4=85  5%  sched_debug.cpu.t=
twu_count.avg
>     144975 =C4=85 13%     -41.1%      85424 =C4=85  7%  sched_debug.cpu.t=
twu_count.max
>      96409 =C4=85  8%     -61.1%      37542 =C4=85  6%  sched_debug.cpu.t=
twu_count.min
>      12310 =C4=85 20%      -2.4%      12009 =C4=85 14%  sched_debug.cpu.t=
twu_count.stddev
>       9749 =C4=85 10%      -5.0%       9257 =C4=85  6%  sched_debug.cpu.t=
twu_local.avg
>      45094 =C4=85 30%      +4.8%      47270 =C4=85 13%  sched_debug.cpu.t=
twu_local.max
>       1447 =C4=85  6%      +1.2%       1465 =C4=85  7%  sched_debug.cpu.t=
twu_local.min
>      12231 =C4=85 24%      -6.1%      11487 =C4=85 13%  sched_debug.cpu.t=
twu_local.stddev
>     147253            -0.4%     146720        sched_debug.cpu_clk
>     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->b=
w.avg
>     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->b=
w.max
>     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->b=
w.min
>  4.295e+09            -0.0%  4.295e+09        sched_debug.jiffies
>     147253            -0.4%     146720        sched_debug.ktime
>     950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runt=
ime.avg
>     950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runt=
ime.max
>     950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runt=
ime.min
>       0.00 =C4=85146%     -69.8%       0.00 =C4=85100%  sched_debug.rt_rq=
:/.rt_time.avg
>       0.04 =C4=85146%     -69.8%       0.01 =C4=85100%  sched_debug.rt_rq=
:/.rt_time.max
>       0.01 =C4=85146%     -69.8%       0.00 =C4=85100%  sched_debug.rt_rq=
:/.rt_time.stddev
>     147626            -0.3%     147114        sched_debug.sched_clk
>       1.00            +0.0%       1.00        sched_debug.sched_clock_sta=
ble()
>    4118331            +0.0%    4118331
> sched_debug.sysctl_sched.sysctl_sched_features
>      24.00            +0.0%      24.00
> sched_debug.sysctl_sched.sysctl_sched_latency
>       3.00            +0.0%       3.00
> sched_debug.sysctl_sched.sysctl_sched_min_granularity
>       1.00            +0.0%       1.00
> sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
>       4.00            +0.0%       4.00
> sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
>      68.63            -2.2       66.43
> perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_failed.call_rw=
sem_down_write_failed.down_write.vma_link
>      73.63            -1.9       71.69
> perf-profile.calltrace.cycles-pp.call_rwsem_down_write_failed.down_write.=
vma_link.mmap_region.do_mmap
>      73.63            -1.9       71.69
> perf-profile.calltrace.cycles-pp.rwsem_down_write_failed.call_rwsem_down_=
write_failed.down_write.vma_link.mmap_region
>      73.99            -1.9       72.05
> perf-profile.calltrace.cycles-pp.down_write.vma_link.mmap_region.do_mmap.=
vm_mmap_pgoff
>      78.36            -1.7       76.67
> perf-profile.calltrace.cycles-pp.vma_link.mmap_region.do_mmap.vm_mmap_pgo=
ff.ksys_mmap_pgoff
>      79.68            -1.5       78.19
> perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_m=
map_pgoff.do_syscall_64
>      81.34            -1.2       80.10
> perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do=
_syscall_64.entry_SYSCALL_64_after_hwframe
>      83.36            -1.2       82.15
> perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame
>      81.59            -1.2       80.39
> perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall=
_64.entry_SYSCALL_64_after_hwframe
>      83.38            -1.2       82.18
> perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>      82.00            -1.2       80.83
> perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe
>       2.44 =C4=85  5%      -0.7        1.79
> perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__do_p=
age_fault.do_page_fault.page_fault
>       3.17 =C4=85  4%      -0.6        2.62
> perf-profile.calltrace.cycles-pp.handle_mm_fault.__do_page_fault.do_page_=
fault.page_fault
>       1.15 =C4=85  2%      -0.2        0.97 =C4=85  2%
> perf-profile.calltrace.cycles-pp.up_write.vma_link.mmap_region.do_mmap.vm=
_mmap_pgoff
>       1.27 =C4=85 18%      -0.0        1.24 =C4=85 16%
> perf-profile.calltrace.cycles-pp.task_numa_work.task_work_run.exit_to_use=
rmode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.27 =C4=85 18%      -0.0        1.24 =C4=85 16%
> perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entr=
y_SYSCALL_64_after_hwframe
>       1.27 =C4=85 18%      -0.0        1.24 =C4=85 16%
> perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_s=
yscall_64.entry_SYSCALL_64_after_hwframe
>       0.55 =C4=85  4%      +0.0        0.58 =C4=85  3%
> perf-profile.calltrace.cycles-pp.__rb_insert_augmented.vma_link.mmap_regi=
on.do_mmap.vm_mmap_pgoff
>       0.94 =C4=85 14%      +0.1        1.02 =C4=85 12%
> perf-profile.calltrace.cycles-pp.task_numa_work.task_work_run.exit_to_use=
rmode_loop.prepare_exit_to_usermode.swapgs_restore_regs_and_return_to_userm=
ode
>       0.94 =C4=85 14%      +0.1        1.02 =C4=85 12%
> perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.prepare_exit_to_us=
ermode.swapgs_restore_regs_and_return_to_usermode
>       0.94 =C4=85 14%      +0.1        1.02 =C4=85 12%
> perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.prep=
are_exit_to_usermode.swapgs_restore_regs_and_return_to_usermode
>       6.67            +0.1        6.76
> perf-profile.calltrace.cycles-pp.__do_page_fault.do_page_fault.page_fault
>       0.95 =C4=85 14%      +0.1        1.04 =C4=85 11%
> perf-profile.calltrace.cycles-pp.prepare_exit_to_usermode.swapgs_restore_=
regs_and_return_to_usermode
>       6.70            +0.1        6.79
> perf-profile.calltrace.cycles-pp.do_page_fault.page_fault
>       6.75            +0.1        6.86
> perf-profile.calltrace.cycles-pp.page_fault
>       0.61 =C4=85  6%      +0.1        0.75 =C4=85  3%
> perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.__do_pa=
ge_fault.do_page_fault.page_fault
>       1.09 =C4=85  2%      +0.1        1.23 =C4=85  3%
> perf-profile.calltrace.cycles-pp.vmacache_find.find_vma.__do_page_fault.d=
o_page_fault.page_fault
>       0.74 =C4=85  4%      +0.2        0.91 =C4=85  3%
> perf-profile.calltrace.cycles-pp.__perf_sw_event.__do_page_fault.do_page_=
fault.page_fault
>       1.35            +0.2        1.56
> perf-profile.calltrace.cycles-pp.unmapped_area_topdown.arch_get_unmapped_=
area_topdown.get_unmapped_area.do_mmap.vm_mmap_pgoff
>       1.39            +0.2        1.61
> perf-profile.calltrace.cycles-pp.arch_get_unmapped_area_topdown.get_unmap=
ped_area.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
>       1.56            +0.2        1.78 =C4=85  2%
> perf-profile.calltrace.cycles-pp.find_vma.__do_page_fault.do_page_fault.p=
age_fault
>       1.50            +0.2        1.72
> perf-profile.calltrace.cycles-pp.get_unmapped_area.do_mmap.vm_mmap_pgoff.=
ksys_mmap_pgoff.do_syscall_64
>       2.71            +0.3        3.05
> perf-profile.calltrace.cycles-pp.native_irq_return_iret
>       2.15            +0.4        2.50 =C4=85  3%
> perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.vma_link.mmap_r=
egion.do_mmap.vm_mmap_pgoff
>       2.70 =C4=85  5%      +0.4        3.07 =C4=85  3%
> perf-profile.calltrace.cycles-pp.swapgs_restore_regs_and_return_to_usermo=
de
>       3.83            +0.4        4.26
> perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_down_write_fai=
led.call_rwsem_down_write_failed.down_write.vma_link
>       0.00            +0.5        0.52
> perf-profile.calltrace.cycles-pp.perf_event_mmap.mmap_region.do_mmap.vm_m=
map_pgoff.ksys_mmap_pgoff
>      68.65            -2.2       66.45
> perf-profile.children.cycles-pp.osq_lock
>      73.63            -1.9       71.69
> perf-profile.children.cycles-pp.call_rwsem_down_write_failed
>      73.63            -1.9       71.69
> perf-profile.children.cycles-pp.rwsem_down_write_failed
>      73.99            -1.9       72.05
> perf-profile.children.cycles-pp.down_write
>      78.36            -1.7       76.68
> perf-profile.children.cycles-pp.vma_link
>      79.70            -1.5       78.21
> perf-profile.children.cycles-pp.mmap_region
>      81.35            -1.2       80.12
> perf-profile.children.cycles-pp.do_mmap
>      81.61            -1.2       80.41
> perf-profile.children.cycles-pp.vm_mmap_pgoff
>      83.48            -1.2       82.28
> perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      83.46            -1.2       82.26
> perf-profile.children.cycles-pp.do_syscall_64
>      82.01            -1.2       80.85
> perf-profile.children.cycles-pp.ksys_mmap_pgoff
>       2.51 =C4=85  5%      -0.6        1.87
> perf-profile.children.cycles-pp.__handle_mm_fault
>       3.24 =C4=85  4%      -0.5        2.70
> perf-profile.children.cycles-pp.handle_mm_fault
>       1.23 =C4=85  2%      -0.2        1.06 =C4=85  2%
> perf-profile.children.cycles-pp.up_write
>       0.20 =C4=85 12%      -0.1        0.10 =C4=85  7%
> perf-profile.children.cycles-pp.do_idle
>       0.20 =C4=85 12%      -0.1        0.10 =C4=85  7%
> perf-profile.children.cycles-pp.secondary_startup_64
>       0.20 =C4=85 12%      -0.1        0.10 =C4=85  7%
> perf-profile.children.cycles-pp.cpu_startup_entry
>       0.18 =C4=85 13%      -0.1        0.09 =C4=85 13%
> perf-profile.children.cycles-pp.start_secondary
>       0.26 =C4=85 11%      -0.1        0.18 =C4=85  8%
> perf-profile.children.cycles-pp.rwsem_wake
>       0.26 =C4=85 11%      -0.1        0.18 =C4=85  6%
> perf-profile.children.cycles-pp.call_rwsem_wake
>       0.07 =C4=85 17%      -0.1        0.00
> perf-profile.children.cycles-pp.intel_idle
>       0.08 =C4=85 14%      -0.1        0.01 =C4=85173%
> perf-profile.children.cycles-pp.cpuidle_enter_state
>       0.06 =C4=85 13%      -0.1        0.00
> perf-profile.children.cycles-pp.schedule
>       0.06 =C4=85  6%      -0.1        0.00
> perf-profile.children.cycles-pp.save_stack_trace_tsk
>       0.18 =C4=85  9%      -0.1        0.12
> perf-profile.children.cycles-pp.wake_up_q
>       0.06 =C4=85  7%      -0.1        0.00
> perf-profile.children.cycles-pp.sched_ttwu_pending
>       0.06 =C4=85  7%      -0.1        0.00
> perf-profile.children.cycles-pp.__save_stack_trace
>       0.18 =C4=85  8%      -0.1        0.13
> perf-profile.children.cycles-pp.try_to_wake_up
>       0.05            -0.1        0.00
> perf-profile.children.cycles-pp.unwind_next_frame
>       0.11 =C4=85  6%      -0.0        0.06 =C4=85 13%
> perf-profile.children.cycles-pp.enqueue_task_fair
>       0.12 =C4=85  9%      -0.0        0.07 =C4=85 10%
> perf-profile.children.cycles-pp.ttwu_do_activate
>       0.08 =C4=85  5%      -0.0        0.04 =C4=85 57%
> perf-profile.children.cycles-pp.__account_scheduler_latency
>       0.11 =C4=85 10%      -0.0        0.06 =C4=85 13%
> perf-profile.children.cycles-pp.enqueue_entity
>       0.10 =C4=85 17%      -0.0        0.06 =C4=85  7%
> perf-profile.children.cycles-pp.__schedule
>       0.36 =C4=85  5%      -0.0        0.32 =C4=85  7%
> perf-profile.children.cycles-pp.osq_unlock
>       0.03 =C4=85100%      -0.0        0.00
> perf-profile.children.cycles-pp.serial8250_console_write
>       0.03 =C4=85100%      -0.0        0.00
> perf-profile.children.cycles-pp.uart_console_write
>       0.03 =C4=85100%      -0.0        0.00
> perf-profile.children.cycles-pp.wait_for_xmitr
>       0.03 =C4=85100%      -0.0        0.00
> perf-profile.children.cycles-pp.serial8250_console_putchar
>       0.03 =C4=85100%      -0.0        0.00
> perf-profile.children.cycles-pp.__softirqentry_text_start
>       0.08 =C4=85 11%      -0.0        0.05 =C4=85  9%
> perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.03 =C4=85100%      -0.0        0.01 =C4=85173%
> perf-profile.children.cycles-pp.console_unlock
>       0.05 =C4=85  9%      -0.0        0.04 =C4=85 58%
> perf-profile.children.cycles-pp.update_load_avg
>       0.03 =C4=85100%      -0.0        0.01 =C4=85173%
> perf-profile.children.cycles-pp.irq_work_run_list
>       0.03 =C4=85100%      -0.0        0.01 =C4=85173%
> perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
>       0.03 =C4=85100%      -0.0        0.01 =C4=85173%
> perf-profile.children.cycles-pp.irq_exit
>       0.01 =C4=85173%      -0.0        0.00
> perf-profile.children.cycles-pp.process_one_work
>       0.01 =C4=85173%      -0.0        0.00
> perf-profile.children.cycles-pp.ktime_get
>       0.01 =C4=85173%      -0.0        0.00
> perf-profile.children.cycles-pp.__vma_link_file
>       0.37 =C4=85  3%      -0.0        0.36 =C4=85  5%
> perf-profile.children.cycles-pp.apic_timer_interrupt
>       0.24 =C4=85  6%      -0.0        0.23 =C4=85  6%
> perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.37 =C4=85  4%      -0.0        0.36 =C4=85  5%
> perf-profile.children.cycles-pp.smp_apic_timer_interrupt
>       0.06 =C4=85 14%      -0.0        0.05 =C4=85  9%
> perf-profile.children.cycles-pp.file_has_perm
>       0.31 =C4=85  5%      -0.0        0.31 =C4=85  7%
> perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.16 =C4=85 10%      -0.0        0.15 =C4=85  7%
> perf-profile.children.cycles-pp.update_process_times
>       0.04 =C4=85 57%      -0.0        0.04 =C4=85 58%
> perf-profile.children.cycles-pp.write
>       0.06 =C4=85  7%      -0.0        0.06 =C4=85  9%
> perf-profile.children.cycles-pp.native_iret
>       0.62 =C4=85  5%      +0.0        0.62 =C4=85  2%
> perf-profile.children.cycles-pp.__rb_insert_augmented
>       0.16 =C4=85 10%      +0.0        0.16 =C4=85  9%
> perf-profile.children.cycles-pp.tick_sched_handle
>       0.01 =C4=85173%      +0.0        0.01 =C4=85173%
> perf-profile.children.cycles-pp.ksys_write
>       0.01 =C4=85173%      +0.0        0.01 =C4=85173%
> perf-profile.children.cycles-pp.worker_thread
>       0.18 =C4=85  9%      +0.0        0.18 =C4=85  8%
> perf-profile.children.cycles-pp.tick_sched_timer
>       0.05 =C4=85  8%      +0.0        0.06 =C4=85  9%
> perf-profile.children.cycles-pp._cond_resched
>       0.11 =C4=85  4%      +0.0        0.11 =C4=85  3%
> perf-profile.children.cycles-pp.scheduler_tick
>       0.08 =C4=85 10%      +0.0        0.09 =C4=85 13%
> perf-profile.children.cycles-pp.mem_cgroup_from_task
>       0.08 =C4=85  5%      +0.0        0.09 =C4=85  7%
> perf-profile.children.cycles-pp.task_tick_fair
>       0.06            +0.0        0.07 =C4=85  7%
> perf-profile.children.cycles-pp.security_mmap_addr
>       0.07 =C4=85  7%      +0.0        0.07 =C4=85  5%
> perf-profile.children.cycles-pp.pmd_devmap_trans_unstable
>       0.09 =C4=85  5%      +0.0        0.10 =C4=85  5%
> perf-profile.children.cycles-pp.vma_gap_callbacks_rotate
>       0.01 =C4=85173%      +0.0        0.03 =C4=85100%
> perf-profile.children.cycles-pp.ret_from_fork
>       0.01 =C4=85173%      +0.0        0.03 =C4=85100%
> perf-profile.children.cycles-pp.kthread
>       0.06 =C4=85 13%      +0.0        0.07 =C4=85  5%
> perf-profile.children.cycles-pp.fput
>       0.07 =C4=85  7%      +0.0        0.08 =C4=85  6%
> perf-profile.children.cycles-pp.__slab_alloc
>       0.05            +0.0        0.06 =C4=85  6%
> perf-profile.children.cycles-pp.prepend_path
>       0.05            +0.0        0.06 =C4=85  6%
> perf-profile.children.cycles-pp.new_slab
>       0.00            +0.0        0.01 =C4=85173%
> perf-profile.children.cycles-pp.ktime_get_update_offsets_now
>       0.00            +0.0        0.01 =C4=85173%
> perf-profile.children.cycles-pp.vfs_write
>       0.00            +0.0        0.01 =C4=85173%
> perf-profile.children.cycles-pp.down_write_killable
>       0.06 =C4=85  6%      +0.0        0.08 =C4=85  6%
> perf-profile.children.cycles-pp.___slab_alloc
>       0.07            +0.0        0.08 =C4=85  5%
> perf-profile.children.cycles-pp.perf_exclude_event
>       0.04 =C4=85 58%      +0.0        0.06 =C4=85  9%
> perf-profile.children.cycles-pp.get_page_from_freelist
>       0.04 =C4=85 58%      +0.0        0.06 =C4=85  7%
> perf-profile.children.cycles-pp.__alloc_pages_nodemask
>       0.03 =C4=85100%      +0.0        0.04 =C4=85 58%
> perf-profile.children.cycles-pp.__pte_alloc
>       0.21 =C4=85  3%      +0.0        0.23 =C4=85  6%
> perf-profile.children.cycles-pp.__entry_trampoline_start
>       0.21 =C4=85  4%      +0.0        0.23 =C4=85  2%
> perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
>       0.11 =C4=85  7%      +0.0        0.14 =C4=85  8%
> perf-profile.children.cycles-pp.selinux_mmap_file
>       0.04 =C4=85 57%      +0.0        0.06
> perf-profile.children.cycles-pp.kfree
>       0.04 =C4=85 57%      +0.0        0.06 =C4=85 11%
> perf-profile.children.cycles-pp.avc_has_perm
>       0.17 =C4=85  4%      +0.0        0.19 =C4=85  4%
> perf-profile.children.cycles-pp.d_path
>       0.00            +0.0        0.03 =C4=85100%
> perf-profile.children.cycles-pp.pte_alloc_one
>       0.01 =C4=85173%      +0.0        0.04 =C4=85 57%
> perf-profile.children.cycles-pp.perf_swevent_event
>       0.12 =C4=85 10%      +0.0        0.15 =C4=85  7%
> perf-profile.children.cycles-pp.security_mmap_file
>       0.18 =C4=85  3%      +0.0        0.21 =C4=85  3%
> perf-profile.children.cycles-pp.up_read
>       0.14 =C4=85  3%      +0.0        0.17 =C4=85  3%
> perf-profile.children.cycles-pp.__might_sleep
>       0.32 =C4=85  3%      +0.0        0.35 =C4=85  4%
> perf-profile.children.cycles-pp.__fget
>       0.12 =C4=85  3%      +0.0        0.15 =C4=85  2%
> perf-profile.children.cycles-pp.kmem_cache_alloc_trace
>       0.16 =C4=85  4%      +0.0        0.19 =C4=85  5%
> perf-profile.children.cycles-pp.kmem_cache_alloc
>       0.21 =C4=85  3%      +0.0        0.25 =C4=85  4%
> perf-profile.children.cycles-pp.down_read_trylock
>       0.25 =C4=85  5%      +0.0        0.29 =C4=85  4%
> perf-profile.children.cycles-pp.__vma_link_rb
>       0.17 =C4=85  6%      +0.0        0.21 =C4=85  7%
> perf-profile.children.cycles-pp.vma_compute_subtree_gap
>       2.22 =C4=85 15%      +0.0        2.26 =C4=85 14%
> perf-profile.children.cycles-pp.exit_to_usermode_loop
>       0.21 =C4=85  7%      +0.0        0.26 =C4=85  4%
> perf-profile.children.cycles-pp._raw_spin_lock
>       0.00            +0.0        0.04 =C4=85 58%
> perf-profile.children.cycles-pp.perf_iterate_sb
>       2.22 =C4=85 15%      +0.0        2.27 =C4=85 14%
> perf-profile.children.cycles-pp.task_numa_work
>       0.16 =C4=85  5%      +0.0        0.20 =C4=85  4%
> perf-profile.children.cycles-pp.___might_sleep
>       0.24 =C4=85 16%      +0.0        0.29 =C4=85 13%
> perf-profile.children.cycles-pp.vma_policy_mof
>       2.21 =C4=85 15%      +0.0        2.26 =C4=85 14%
> perf-profile.children.cycles-pp.task_work_run
>       0.37 =C4=85  3%      +0.0        0.42 =C4=85  5%
> perf-profile.children.cycles-pp.sync_regs
>       0.08 =C4=85 23%      +0.0        0.13 =C4=85 14%
> perf-profile.children.cycles-pp.get_task_policy
>       0.39 =C4=85  2%      +0.1        0.45
> perf-profile.children.cycles-pp.syscall_return_via_sysret
>       0.46            +0.1        0.53 =C4=85  2%
> perf-profile.children.cycles-pp.perf_event_mmap
>       0.97 =C4=85 14%      +0.1        1.05 =C4=85 11%
> perf-profile.children.cycles-pp.prepare_exit_to_usermode
>       6.75            +0.1        6.85
> perf-profile.children.cycles-pp.do_page_fault
>       6.76            +0.1        6.86
> perf-profile.children.cycles-pp.page_fault
>       6.77            +0.1        6.87
> perf-profile.children.cycles-pp.__do_page_fault
>       1.10 =C4=85  2%      +0.1        1.25 =C4=85  3%
> perf-profile.children.cycles-pp.vmacache_find
>       0.63 =C4=85  6%      +0.2        0.78 =C4=85  3%
> perf-profile.children.cycles-pp.___perf_sw_event
>       0.75 =C4=85  4%      +0.2        0.93 =C4=85  3%
> perf-profile.children.cycles-pp.__perf_sw_event
>       1.35            +0.2        1.56
> perf-profile.children.cycles-pp.unmapped_area_topdown
>       1.42            +0.2        1.63
> perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
>       1.58            +0.2        1.81 =C4=85  2%
> perf-profile.children.cycles-pp.find_vma
>       1.50            +0.2        1.73
> perf-profile.children.cycles-pp.get_unmapped_area
>       2.72            +0.3        3.06
> perf-profile.children.cycles-pp.native_irq_return_iret
>       2.15            +0.4        2.50 =C4=85  3%
> perf-profile.children.cycles-pp.vma_interval_tree_insert
>       2.70 =C4=85  5%      +0.4        3.07 =C4=85  3%
> perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermod=
e
>       3.83            +0.4        4.26
> perf-profile.children.cycles-pp.rwsem_spin_on_owner
>      68.47            -2.2       66.29
> perf-profile.self.cycles-pp.osq_lock
>       2.16 =C4=85  7%      -0.7        1.45
> perf-profile.self.cycles-pp.__handle_mm_fault
>       0.74 =C4=85  3%      -0.1        0.64 =C4=85  2%
> perf-profile.self.cycles-pp.rwsem_down_write_failed
>       0.97            -0.1        0.89
> perf-profile.self.cycles-pp.up_write
>       0.07 =C4=85 17%      -0.1        0.00
> perf-profile.self.cycles-pp.intel_idle
>       0.04 =C4=85 58%      -0.0        0.00
> perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.36 =C4=85  5%      -0.0        0.32 =C4=85  7%
> perf-profile.self.cycles-pp.osq_unlock
>       2.00 =C4=85 14%      -0.0        1.99 =C4=85 14%
> perf-profile.self.cycles-pp.task_numa_work
>       0.01 =C4=85173%      -0.0        0.00
> perf-profile.self.cycles-pp.__vma_link_file
>       0.62 =C4=85  5%      -0.0        0.61 =C4=85  2%
> perf-profile.self.cycles-pp.__rb_insert_augmented
>       0.06 =C4=85  7%      -0.0        0.06 =C4=85  9%
> perf-profile.self.cycles-pp.native_iret
>       0.01 =C4=85173%      +0.0        0.01 =C4=85173%
> perf-profile.self.cycles-pp.ksys_mmap_pgoff
>       0.01 =C4=85173%      +0.0        0.01 =C4=85173%
> perf-profile.self.cycles-pp._cond_resched
>       0.06 =C4=85  9%      +0.0        0.06 =C4=85 14%
> perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown
>       0.34 =C4=85  5%      +0.0        0.35 =C4=85  3%
> perf-profile.self.cycles-pp.down_write
>       0.08 =C4=85  5%      +0.0        0.09 =C4=85  4%
> perf-profile.self.cycles-pp.perf_event_mmap
>       0.11 =C4=85  7%      +0.0        0.11 =C4=85  3%
> perf-profile.self.cycles-pp.__vma_link_rb
>       0.08 =C4=85 10%      +0.0        0.09 =C4=85 13%
> perf-profile.self.cycles-pp.mem_cgroup_from_task
>       0.07            +0.0        0.08 =C4=85  5%
> perf-profile.self.cycles-pp.do_page_fault
>       0.06 =C4=85  6%      +0.0        0.07 =C4=85 10%
> perf-profile.self.cycles-pp.pmd_devmap_trans_unstable
>       0.07 =C4=85  7%      +0.0        0.07 =C4=85  5%
> perf-profile.self.cycles-pp.vma_gap_callbacks_rotate
>       0.12 =C4=85  8%      +0.0        0.13 =C4=85  6%  perf-profile.self=
.cycles-pp.d_path
>       0.06            +0.0        0.07 =C4=85 10%
> perf-profile.self.cycles-pp.kmem_cache_alloc
>       0.00            +0.0        0.01 =C4=85173%
> perf-profile.self.cycles-pp.kmem_cache_alloc_trace
>       0.00            +0.0        0.01 =C4=85173%
> perf-profile.self.cycles-pp.prepend_path
>       0.06 =C4=85 11%      +0.0        0.07 =C4=85  5%  perf-profile.self=
.cycles-pp.fput
>       0.07            +0.0        0.08 =C4=85  5%
> perf-profile.self.cycles-pp.perf_exclude_event
>       0.21 =C4=85  4%      +0.0        0.22
> perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
>       0.21 =C4=85  3%      +0.0        0.23 =C4=85  6%
> perf-profile.self.cycles-pp.__entry_trampoline_start
>       0.04 =C4=85 57%      +0.0        0.06 =C4=85  7%  perf-profile.self=
.cycles-pp.kfree
>       0.04 =C4=85 57%      +0.0        0.06 =C4=85 11%
> perf-profile.self.cycles-pp.avc_has_perm
>       0.16 =C4=85 13%      +0.0        0.19 =C4=85 13%
> perf-profile.self.cycles-pp.vma_policy_mof
>       0.01 =C4=85173%      +0.0        0.04 =C4=85 57%
> perf-profile.self.cycles-pp.perf_swevent_event
>       0.14 =C4=85  3%      +0.0        0.16 =C4=85  2%
> perf-profile.self.cycles-pp.__might_sleep
>       0.32 =C4=85  3%      +0.0        0.34 =C4=85  5%  perf-profile.self=
.cycles-pp.__fget
>       0.18 =C4=85  3%      +0.0        0.21 =C4=85  3%
> perf-profile.self.cycles-pp.up_read
>       0.15 =C4=85  7%      +0.0        0.17 =C4=85  2%
> perf-profile.self.cycles-pp.__perf_sw_event
>       0.14 =C4=85 10%      +0.0        0.18 =C4=85  4%
> perf-profile.self.cycles-pp.do_mmap
>       0.21 =C4=85  3%      +0.0        0.25 =C4=85  4%
> perf-profile.self.cycles-pp.down_read_trylock
>       0.17 =C4=85  6%      +0.0        0.21 =C4=85  7%
> perf-profile.self.cycles-pp.vma_compute_subtree_gap
>       0.21 =C4=85  7%      +0.0        0.25 =C4=85  3%
> perf-profile.self.cycles-pp._raw_spin_lock
>       0.00            +0.0        0.04 =C4=85 58%
> perf-profile.self.cycles-pp.perf_iterate_sb
>       0.16 =C4=85  5%      +0.0        0.20 =C4=85  4%
> perf-profile.self.cycles-pp.___might_sleep
>       0.08 =C4=85 23%      +0.0        0.12 =C4=85 14%
> perf-profile.self.cycles-pp.get_task_policy
>       0.37 =C4=85  3%      +0.0        0.42 =C4=85  5%
> perf-profile.self.cycles-pp.sync_regs
>       0.00            +0.1        0.05
> perf-profile.self.cycles-pp.do_syscall_64
>       0.39 =C4=85  2%      +0.1        0.45
> perf-profile.self.cycles-pp.syscall_return_via_sysret
>       0.48            +0.1        0.55
> perf-profile.self.cycles-pp.find_vma
>       0.69 =C4=85  2%      +0.1        0.77 =C4=85  2%
> perf-profile.self.cycles-pp.mmap_region
>       0.70 =C4=85  3%      +0.1        0.81 =C4=85  2%
> perf-profile.self.cycles-pp.handle_mm_fault
>       0.54 =C4=85  7%      +0.1        0.69 =C4=85  3%
> perf-profile.self.cycles-pp.___perf_sw_event
>       1.10 =C4=85  2%      +0.1        1.25 =C4=85  3%
> perf-profile.self.cycles-pp.vmacache_find
>       0.73            +0.1        0.88 =C4=85  5%
> perf-profile.self.cycles-pp.__do_page_fault
>       1.35            +0.2        1.56
> perf-profile.self.cycles-pp.unmapped_area_topdown
>       1.75            +0.3        2.03
> perf-profile.self.cycles-pp.swapgs_restore_regs_and_return_to_usermode
>       2.72            +0.3        3.06
> perf-profile.self.cycles-pp.native_irq_return_iret
>       2.15            +0.3        2.49 =C4=85  3%
> perf-profile.self.cycles-pp.vma_interval_tree_insert
>       3.82            +0.4        4.25
> perf-profile.self.cycles-pp.rwsem_spin_on_owner
>
>
>
>                                vm-scalability.throughput
>
>   2.25e+07 +-+-----------------------------------------------------------=
---+
>            | O       O                                                   =
   |
>    2.2e+07 O-+O O OO  O O OO O  O  O   O  O                              =
   |
>   2.15e+07 +-+                 O     O      O                            =
   |
>            |                      O     O                                =
   |
>    2.1e+07 +-+                                                           =
   |
>            |                                                             =
   |
>   2.05e+07 +-+                                                           =
   |
>            |                                                             =
   |
>      2e+07 +-+     +. +. .++.+    ++    +.      +    +    +.+            =
   |
>   1.95e+07 +-+ .+  : +  +     +  +  + .+  +.++.+ + .+ +   :  +.+         =
  .|
>            | ++  +:            ++    +            +    +.+      + +.+  + =
 + |
>    1.9e+07 +-+    +                                              +   + :+=
 : |
>            |                                                          +  =
+  |
>   1.85e+07 +-+-----------------------------------------------------------=
---+
>
>
>                                 vm-scalability.median
>
>   800000 +-O-------------------------------------------------------------=
---+
>          O    O O  O  O O  O   O     O                                   =
   |
>   780000 +-+O    O   O    O  O    O      O                               =
   |
>          |                      O   O  O   O                             =
   |
>   760000 +-+                                                             =
   |
>          |                                                               =
   |
>   740000 +-+                                                             =
   |
>          |                                                               =
   |
>   720000 +-+             .+      .+                                      =
   |
>          |    +  +.+.++.+  +.   +  +  .+. .+ .+.+  +.+    ++. .+         =
   |
>   700000 +-+ + : :           +. :   ++   +  +    :+   +. +   + :   .+  + =
 +.|
>          | ++  ::              +                 +      +       :.+  :+ +=
 : |
>   680000 +-+    +                                               +    +   =
+  |
>          |                                                               =
   |
>   660000 +-+-------------------------------------------------------------=
---+
>
>
>                    vm-scalability.time.voluntary_context_switches
>
>   8e+06 +-+--------------------------------------------------------------=
---+
>         |           +.             +.                                    =
   |
>   7e+06 +-+        :  +  +  +.    +  +. +   +                            =
   |
>         |          :   :+ + : +. +     + : ::          .+                =
   |
>   6e+06 +-++.+.+. +    +   +    +        : : :  .+.++.+  +.+.++.   .++.+.=
   |
>         |+ :     +                        +  +.+                +.+      =
+ .|
>   5e+06 +-+                                                              =
 + |
>         |                                                                =
   |
>   4e+06 +-+                                                              =
   |
>         |                                                                =
   |
>   3e+06 +-O    O  O O OO    O                                            =
   |
>         O  O O   O       O O                                             =
   |
>   2e+06 +-+                   O O OO O OO O                              =
   |
>         |                                                                =
   |
>   1e+06 +-+--------------------------------------------------------------=
---+
>
>
> [*] bisect-good sample
> [O] bisect-bad  sample
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> Thanks,
> Xiaolong
