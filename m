Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B61C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7333D20841
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7333D20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933930AbeGDLo5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:44:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932594AbeGDLoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:44:54 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64BiQ5M108204
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 07:44:53 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k0untn0q7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:44:52 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 07:44:51 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 07:44:47 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w64Biko511075964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 11:44:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF2BFB2066;
        Wed,  4 Jul 2018 07:44:28 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73E21B2065;
        Wed,  4 Jul 2018 07:44:28 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.104])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jul 2018 07:44:28 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 58E0216CA46B; Wed,  4 Jul 2018 04:47:00 -0700 (PDT)
Date:   Wed, 4 Jul 2018 04:47:00 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     kernel test robot <xiaolong.ye@intel.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        lkp@01.org
Subject: Re: [lkp-robot] [rcu]  e46874dd99: WARNING:suspicious_RCU_usage
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180627204915.27253-1-paulmck@linux.vnet.ibm.com>
 <20180704064347.GP15716@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704064347.GP15716@yexl-desktop>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070411-0068-0000-0000-00000312FE82
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009307; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056400; UDB=6.00541908; IPR=6.00834322;
 MB=3.00021992; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-04 11:44:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070411-0069-0000-0000-000044E8F704
Message-Id: <20180704114700.GJ3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 02:43:47PM +0800, kernel test robot wrote:
> 
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: e46874dd99fa8ef78802bee8e80fe2844ae95cd1 ("[PATCH RFC tip/core/rcu 1/2] rcu: Defer reporting RCU-preempt quiescent states when disabled")
> url: https://github.com/0day-ci/linux/commits/Paul-E-McKenney/RCU-consolidation-patches/20180628-045310
> base: https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> 
> in testcase: boot

I added the rcu_preempt_deferred_qs() a few statements too late in
rcu_eqs_enter(), good catch, thank you!

I clearly need to dig into why my testing didn't find this...

							Thanx, Paul

> on test machine: qemu-system-x86_64 -enable-kvm -cpu Haswell,+smep,+smap -smp 2 -m 512M
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +----------------------------------------------------------------------+------------+------------+
> |                                                                      | bd917f682b | e46874dd99 |
> +----------------------------------------------------------------------+------------+------------+
> | boot_successes                                                       | 208        | 112        |
> | boot_failures                                                        | 2          | 95         |
> | invoked_oom-killer:gfp_mask=0x                                       | 2          | 2          |
> | Mem-Info                                                             | 2          | 2          |
> | WARNING:suspicious_RCU_usage                                         | 0          | 93         |
> | include/linux/rcupdate.h:#rcu_read_lock()used_illegally_while_idle   | 0          | 93         |
> | WARNING:possible_circular_locking_dependency_detected                | 0          | 89         |
> | include/linux/cgroup.h:#suspicious_rcu_dereference_check()usage      | 0          | 1          |
> | include/linux/rcupdate.h:#rcu_read_unlock()used_illegally_while_idle | 0          | 4          |
> | BUG:kernel_hang_in_test_stage                                        | 0          | 1          |
> | WARNING:possible_recursive_locking_detected                          | 0          | 1          |
> +----------------------------------------------------------------------+------------+------------+
> 
> 
> 
> [  112.105779] WARNING: suspicious RCU usage
> [  112.112065] 4.18.0-rc1-00121-ge46874d #1 Not tainted
> [  112.119508] -----------------------------
> [  112.125574] include/linux/rcupdate.h:631 rcu_read_lock() used illegally while idle!
> [  112.139965] 
> [  112.139965] other info that might help us debug this:
> [  112.139965] 
> [  112.152087] 
> [  112.152087] RCU used illegally from idle CPU!
> [  112.152087] rcu_scheduler_active = 2, debug_locks = 0
> [  112.168258] RCU used illegally from extended quiescent state!
> [  112.177070] 3 locks held by grep/3278:
> [  112.182897]  #0: (____ptrval____) (&rsp->gp_wq){..-.}, at: swake_up+0x16/0x46
> [  112.193916]  #1: (____ptrval____) (&p->pi_lock){-.-.}, at: try_to_wake_up+0x42/0x56f
> [  112.205522]  #2: (____ptrval____) (rcu_read_lock){....}, at: select_task_rq_rt+0x22/0x20c
> [  112.218160] 
> [  112.218160] stack backtrace:
> [  112.224902] CPU: 0 PID: 3278 Comm: grep Not tainted 4.18.0-rc1-00121-ge46874d #1
> [  112.236302] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [  112.248488] Call Trace:
> [  112.252248]  dump_stack+0xfa/0x16c
> [  112.257374]  lockdep_rcu_suspicious+0x166/0x176
> [  112.264109]  select_task_rq_rt+0xd5/0x20c
> [  112.270034]  try_to_wake_up+0x257/0x56f
> [  112.275647]  wake_up_process+0x17/0x20
> [  112.281349]  swake_up_locked+0x2d/0x67
> [  112.286922]  swake_up+0x28/0x46
> [  112.291591]  rcu_gp_kthread_wake+0x52/0x5b
> [  112.297615]  rcu_report_qs_rsp+0xaa/0xb6
> [  112.303417]  rcu_preempt_deferred_qs_irqrestore+0x47a/0x5eb
> [  112.311584]  rcu_preempt_deferred_qs+0x5e/0x6a
> [  112.318165]  rcu_eqs_enter+0x14a/0x156
> [  112.325255]  rcu_user_enter+0x8e/0x97
> [  112.330797]  __context_tracking_enter+0x92/0xb1
> [  112.337376]  prepare_exit_to_usermode+0x149/0x155
> [  112.344317]  ? async_page_fault+0x5/0x20
> [  112.350209]  retint_user+0x8/0x18
> [  112.355102] RIP: 0033:0x7f2062ad8dc0
> [  112.360389] Code: 00 00 e8 d3 e3 f8 ff 48 8d 0d bc ec 0d 00 48 8d 35 45 c4 0d 00 48 8d 3d 25 87 0d 00 ba e2 00 00 00 e8 b4 e3 f8 ff 0f 1f 40 00 <41> 57 31 c0 41 56 41 55 41 54 55 89 fd 53 48 83 ec 18 83 fe 01 0f 
> [  112.387996] RSP: 002b:00007ffe5cc3a488 EFLAGS: 00010246
> [  112.395645] RAX: 0000000000000001 RBX: 0000000000000004 RCX: 00007f206321c040
> [  112.405946] RDX: 00007ffe5cc3a550 RSI: 000000000000000d RDI: 00000000000000bc
> [  112.416289] RBP: 00007ffe5cc3a528 R08: 0000000000007fff R09: 000000000000000e
> [  112.426561] R10: 00007ffe5cc3a260 R11: 00007ffe5cc3a3e0 R12: 00007f2062dea730
> [  112.437191] R13: 00007ffe5cc3a550 R14: 00007f2062dea730 R15: 0000000000000000
> [  112.447785] 
> [  112.447791] ======================================================
> [  112.447815] WARNING: possible circular locking dependency detected
> [  112.447818] 4.18.0-rc1-00121-ge46874d #1 Not tainted
> [  112.447821] ------------------------------------------------------
> [  112.447824] grep/3278 is trying to acquire lock:
> [  112.447847] (____ptrval____) ((console_sem).lock){-.-.}, at: down_trylock+0x16/0x4e
> [  112.447856] 
> [  112.447880] but task is already holding lock:
> [  112.447882] (____ptrval____) (&p->pi_lock){-.-.}, at: try_to_wake_up+0x42/0x56f
> [  112.447911] 
> [  112.447914] which lock already depends on the new lock.
> [  112.447915] 
> [  112.447917] 
> [  112.447920] the existing dependency chain (in reverse order) is:
> [  112.447921] 
> [  112.447944] -> #1 (&p->pi_lock){-.-.}:
> [  112.447953]        __lock_acquire+0x957/0xa47
> [  112.447976]        lock_acquire+0xaf/0xe4
> [  112.447978]        _raw_spin_lock_irqsave+0x6c/0x8e
> [  112.447981]        try_to_wake_up+0x42/0x56f
> [  112.447983]        wake_up_process+0x17/0x20
> [  112.447986]        __up+0x58/0x62
> [  112.448009]        up+0x42/0x60
> [  112.448011]        __up_console_sem+0x6a/0xc9
> [  112.448014]        console_unlock+0x663/0x72f
> [  112.448016]        vprintk_emit+0x5cd/0x621
> [  112.448019]        vprintk_default+0x1f/0x28
> [  112.448042]        vprintk_func+0xbf/0xc8
> [  112.448044]        printk+0x54/0x77
> [  112.448047]        _warn_unseeded_randomness+0x7a/0x87
> [  112.448049]        get_random_u64+0x81/0x17d
> [  112.448073]        load_elf_binary+0x495/0x12f7
> [  112.448075]        search_binary_handler+0xc8/0x246
> [  112.448078]        __do_execve_file+0x97b/0xbb7
> [  112.448081]        do_execveat_common+0x16/0x1f
> [  112.448083]        do_execve+0x25/0x2e
> [  112.448106]        __x64_sys_execve+0x3b/0x50
> [  112.448109]        do_syscall_64+0x294/0x4fb
> [  112.448112]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  112.448113] 
> [  112.448115] -> #0 ((console_sem).lock){-.-.}:
> [  112.448145]        validate_chain+0xea2/0x1096
> [  112.448147]        __lock_acquire+0x957/0xa47
> [  112.448170]        lock_acquire+0xaf/0xe4
> [  112.448173]        _raw_spin_lock_irqsave+0x6c/0x8e
> [  112.448175]        down_trylock+0x16/0x4e
> [  112.448178]        __down_trylock_console_sem+0x56/0xff
> [  112.448180]        console_trylock+0x1c/0x7c
> [  112.448204]        vprintk_emit+0x3a9/0x621
> [  112.448206]        vprintk_default+0x1f/0x28
> [  112.448209]        vprintk_func+0xbf/0xc8
> [  112.448211]        printk+0x54/0x77
> [  112.448213]        lockdep_rcu_suspicious+0x30/0x176
> [  112.448237]        select_task_rq_rt+0xd5/0x20c
> [  112.448239]        try_to_wake_up+0x257/0x56f
> [  112.448241]        wake_up_process+0x17/0x20
> [  112.448244]        swake_up_locked+0x2d/0x67
> [  112.448267]        swake_up+0x28/0x46
> [  112.448269]        rcu_gp_kthread_wake+0x52/0x5b
> [  112.448272]        rcu_report_qs_rsp+0xaa/0xb6
> [  112.448275]        rcu_preempt_deferred_qs_irqrestore+0x47a/0x5eb
> [  112.448277]        rcu_preempt_deferred_qs+0x5e/0x6a
> [  112.448301]        rcu_eqs_enter+0x14a/0x156
> [  112.448304]        rcu_user_enter+0x8e/0x97
> [  112.448307]        __context_tracking_enter+0x92/0xb1
> [  112.448309]        prepare_exit_to_usermode+0x149/0x155
> [  112.448332]        retint_user+0x8/0x18
> [  112.448334] 
> [  112.448336] other info that might help us debug this:
> [  112.448338] 
> [  112.448340]  Possible unsafe locking scenario:
> [  112.448341] 
> [  112.448365]        CPU0                    CPU1
> [  112.448367]        ----                    ----
> [  112.448369]   lock(&p->pi_lock);
> [  112.448374]                                lock((console_sem).lock);
> [  112.448401]                                lock(&p->pi_lock);
> [  112.448406]   lock((console_sem).lock);
> [  112.448432] 
> [  112.448434]  *** DEADLOCK ***
> [  112.448435] 
> [  112.448437] 3 locks held by grep/3278:
> [  112.448439]  #0: (____ptrval____) (&rsp->gp_wq){..-.}, at: swake_up+0x16/0x46
> [  112.448470]  #1: (____ptrval____) (&p->pi_lock){-.-.}, at: try_to_wake_up+0x42/0x56f
> [  112.448501]  #2: (____ptrval____) (rcu_read_lock){....}, at: select_task_rq_rt+0x22/0x20c
> [  112.448532] 
> [  112.448534] stack backtrace:
> [  112.448559] CPU: 0 PID: 3278 Comm: grep Not tainted 4.18.0-rc1-00121-ge46874d #1
> [  112.448562] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [  112.448564] Call Trace:
> [  112.448567]  dump_stack+0xfa/0x16c
> [  112.448569]  print_circular_bug+0x40d/0x422
> [  112.448593]  check_prev_add+0x1c1/0x94a
> [  112.448595]  validate_chain+0xea2/0x1096
> [  112.448598]  ? validate_chain+0xea2/0x1096
> [  112.448601]  __lock_acquire+0x957/0xa47
> [  112.448624]  lock_acquire+0xaf/0xe4
> [  112.448626]  ? down_trylock+0x16/0x4e
> [  112.448628]  ? vprintk_emit+0x3a9/0x621
> [  112.448631]  _raw_spin_lock_irqsave+0x6c/0x8e
> [  112.448633]  ? down_trylock+0x16/0x4e
> [  112.448656]  down_trylock+0x16/0x4e
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Xiaolong

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86_64 4.18.0-rc1 Kernel Configuration
> #
> 
> #
> # Compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> #
> CONFIG_64BIT=y
> CONFIG_X86_64=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ZONE_DMA32=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_X86_64_SMP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=4
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=70300
> CONFIG_CLANG_VERSION=0
> CONFIG_CONSTRUCTORS=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_EXTABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_KERNEL_GZIP=y
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> # CONFIG_POSIX_MQUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=y
> CONFIG_USELIB=y
> # CONFIG_AUDIT is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_GENERIC_IRQ_MIGRATION=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_SIM=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> CONFIG_GENERIC_IRQ_DEBUGFS=y
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_DATA=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> # CONFIG_NO_HZ_IDLE is not set
> CONFIG_NO_HZ_FULL=y
> # CONFIG_NO_HZ is not set
> CONFIG_HIGH_RES_TIMERS=y
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_VIRT_CPU_ACCOUNTING=y
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> CONFIG_CPU_ISOLATION=y
> 
> #
> # RCU Subsystem
> #
> CONFIG_PREEMPT_RCU=y
> CONFIG_RCU_EXPERT=y
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_CONTEXT_TRACKING=y
> CONFIG_CONTEXT_TRACKING_FORCE=y
> CONFIG_RCU_FANOUT=64
> CONFIG_RCU_FANOUT_LEAF=16
> # CONFIG_RCU_FAST_NO_HZ is not set
> CONFIG_RCU_BOOST=y
> CONFIG_RCU_BOOST_DELAY=500
> CONFIG_RCU_NOCB_CPU=y
> CONFIG_BUILD_BIN2C=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_ARCH_SUPPORTS_INT128=y
> CONFIG_NUMA_BALANCING=y
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
> CONFIG_CGROUPS=y
> CONFIG_PAGE_COUNTER=y
> CONFIG_MEMCG=y
> CONFIG_MEMCG_SWAP=y
> CONFIG_MEMCG_SWAP_ENABLED=y
> CONFIG_BLK_CGROUP=y
> CONFIG_DEBUG_BLK_CGROUP=y
> CONFIG_CGROUP_WRITEBACK=y
> CONFIG_CGROUP_SCHED=y
> CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_CFS_BANDWIDTH=y
> # CONFIG_RT_GROUP_SCHED is not set
> # CONFIG_CGROUP_PIDS is not set
> CONFIG_CGROUP_RDMA=y
> CONFIG_CGROUP_FREEZER=y
> # CONFIG_CPUSETS is not set
> # CONFIG_CGROUP_DEVICE is not set
> # CONFIG_CGROUP_CPUACCT is not set
> CONFIG_CGROUP_PERF=y
> CONFIG_CGROUP_DEBUG=y
> # CONFIG_NAMESPACES is not set
> CONFIG_SCHED_AUTOGROUP=y
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_SYSCTL=y
> CONFIG_ANON_INODES=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_BPF=y
> CONFIG_EXPERT=y
> CONFIG_MULTIUSER=y
> # CONFIG_SGETMASK_SYSCALL is not set
> CONFIG_SYSFS_SYSCALL=y
> # CONFIG_SYSCTL_SYSCALL is not set
> CONFIG_FHANDLE=y
> # CONFIG_POSIX_TIMERS is not set
> CONFIG_PRINTK=y
> CONFIG_PRINTK_NMI=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> # CONFIG_ADVISE_SYSCALLS is not set
> CONFIG_MEMBARRIER=y
> CONFIG_CHECKPOINT_RESTORE=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> # CONFIG_BPF_SYSCALL is not set
> CONFIG_USERFAULTFD=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_RSEQ=y
> # CONFIG_DEBUG_RSEQ is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PERF_USE_VMALLOC=y
> # CONFIG_PC104 is not set
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> CONFIG_DEBUG_PERF_USE_VMALLOC=y
> CONFIG_VM_EVENT_COUNTERS=y
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_SLAB is not set
> # CONFIG_SLUB is not set
> CONFIG_SLOB=y
> CONFIG_SLAB_MERGE_DEFAULT=y
> CONFIG_PROFILING=y
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> # CONFIG_OPROFILE is not set
> CONFIG_HAVE_OPROFILE=y
> CONFIG_OPROFILE_NMI_TIMER=y
> # CONFIG_KPROBES is not set
> # CONFIG_JUMP_LABEL is not set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP_FILTER=y
> CONFIG_PLUGIN_HOSTCC="g++"
> CONFIG_HAVE_GCC_PLUGINS=y
> # CONFIG_GCC_PLUGINS is not set
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_CONTEXT_TRACKING=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
> CONFIG_HAVE_COPY_THREAD_TLS=y
> CONFIG_HAVE_STACK_VALIDATION=y
> CONFIG_HAVE_RELIABLE_STACKTRACE=y
> CONFIG_ISA_BUS_API=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> # CONFIG_VMAP_STACK is not set
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_ARCH_HAS_REFCOUNT=y
> # CONFIG_REFCOUNT_FULL is not set
> 
> #
> # GCOV-based kernel profiling
> #
> CONFIG_GCOV_KERNEL=y
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> CONFIG_GCOV_PROFILE_ALL=y
> CONFIG_GCOV_FORMAT_4_7=y
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> CONFIG_MODULE_FORCE_LOAD=y
> # CONFIG_MODULE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> CONFIG_MODULE_COMPRESS=y
> CONFIG_MODULE_COMPRESS_GZIP=y
> # CONFIG_MODULE_COMPRESS_XZ is not set
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLK_SCSI_REQUEST=y
> CONFIG_BLK_DEV_BSG=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> # CONFIG_BLK_DEV_ZONED is not set
> # CONFIG_BLK_DEV_THROTTLING is not set
> CONFIG_BLK_CMDLINE_PARSER=y
> CONFIG_BLK_WBT=y
> # CONFIG_BLK_WBT_SQ is not set
> # CONFIG_BLK_WBT_MQ is not set
> # CONFIG_BLK_DEBUG_FS is not set
> CONFIG_BLK_SED_OPAL=y
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> CONFIG_EFI_PARTITION=y
> CONFIG_BLOCK_COMPAT=y
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> 
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=m
> CONFIG_CFQ_GROUP_IOSCHED=y
> CONFIG_DEFAULT_DEADLINE=y
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED="deadline"
> CONFIG_MQ_IOSCHED_DEADLINE=y
> # CONFIG_MQ_IOSCHED_KYBER is not set
> CONFIG_IOSCHED_BFQ=m
> # CONFIG_BFQ_GROUP_IOSCHED is not set
> CONFIG_PADATA=y
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> CONFIG_FREEZER=y
> 
> #
> # Processor type and features
> #
> # CONFIG_ZONE_DMA is not set
> CONFIG_SMP=y
> CONFIG_X86_FEATURE_NAMES=y
> CONFIG_X86_X2APIC=y
> # CONFIG_X86_MPPARSE is not set
> CONFIG_GOLDFISH=y
> CONFIG_RETPOLINE=y
> # CONFIG_X86_EXTENDED_PLATFORM is not set
> # CONFIG_X86_INTEL_LPSS is not set
> CONFIG_X86_AMD_PLATFORM_DEVICE=y
> CONFIG_IOSF_MBI=y
> CONFIG_IOSF_MBI_DEBUG=y
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_PARAVIRT_SPINLOCKS=y
> # CONFIG_QUEUED_LOCK_STAT is not set
> # CONFIG_XEN is not set
> CONFIG_KVM_GUEST=y
> # CONFIG_KVM_DEBUG_FS is not set
> CONFIG_PARAVIRT_TIME_ACCOUNTING=y
> CONFIG_PARAVIRT_CLOCK=y
> # CONFIG_JAILHOUSE_GUEST is not set
> CONFIG_NO_BOOTMEM=y
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_GENERIC_CPU=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=64
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_PROCESSOR_SELECT=y
> # CONFIG_CPU_SUP_INTEL is not set
> # CONFIG_CPU_SUP_AMD is not set
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_DMI=y
> CONFIG_CALGARY_IOMMU=y
> CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT=y
> CONFIG_MAXSMP=y
> CONFIG_NR_CPUS_RANGE_BEGIN=8192
> CONFIG_NR_CPUS_RANGE_END=8192
> CONFIG_NR_CPUS_DEFAULT=8192
> CONFIG_NR_CPUS=8192
> CONFIG_SCHED_SMT=y
> # CONFIG_SCHED_MC is not set
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_COUNT=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> # CONFIG_X86_MCE is not set
> 
> #
> # Performance monitoring
> #
> # CONFIG_X86_16BIT is not set
> CONFIG_X86_VSYSCALL_EMULATION=y
> CONFIG_I8K=m
> # CONFIG_X86_MSR is not set
> CONFIG_X86_CPUID=m
> # CONFIG_X86_5LEVEL is not set
> CONFIG_X86_DIRECT_GBPAGES=y
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_NUMA=y
> CONFIG_AMD_NUMA=y
> CONFIG_X86_64_ACPI_NUMA=y
> CONFIG_NODES_SPAN_OTHER_NODES=y
> # CONFIG_NUMA_EMU is not set
> CONFIG_NODES_SHIFT=10
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_NEED_MULTIPLE_NODES=y
> CONFIG_HAVE_MEMORY_PRESENT=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_HAVE_MEMBLOCK=y
> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> CONFIG_HAVE_GENERIC_GUP=y
> CONFIG_ARCH_DISCARD_MEMBLOCK=y
> CONFIG_MEMORY_ISOLATION=y
> # CONFIG_MEMORY_HOTPLUG is not set
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_COMPACTION=y
> CONFIG_MIGRATION=y
> CONFIG_ARCH_ENABLE_THP_MIGRATION=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_MMU_NOTIFIER=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_TRANSPARENT_HUGEPAGE=y
> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> CONFIG_ARCH_WANTS_THP_SWAP=y
> CONFIG_THP_SWAP=y
> CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
> # CONFIG_CLEANCACHE is not set
> # CONFIG_FRONTSWAP is not set
> CONFIG_CMA=y
> CONFIG_CMA_DEBUG=y
> CONFIG_CMA_DEBUGFS=y
> CONFIG_CMA_AREAS=7
> # CONFIG_MEM_SOFT_DIRTY is not set
> # CONFIG_ZPOOL is not set
> CONFIG_ZBUD=m
> # CONFIG_ZSMALLOC is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_ARCH_HAS_ZONE_DEVICE=y
> CONFIG_PERCPU_STATS=y
> # CONFIG_GUP_BENCHMARK is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> # CONFIG_X86_PMEM_LEGACY is not set
> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
> CONFIG_X86_RESERVE_LOW=64
> # CONFIG_MTRR is not set
> CONFIG_ARCH_RANDOM=y
> # CONFIG_X86_SMAP is not set
> # CONFIG_EFI is not set
> CONFIG_SECCOMP=y
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> CONFIG_HZ_300=y
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=300
> CONFIG_SCHED_HRTICK=y
> # CONFIG_KEXEC is not set
> CONFIG_KEXEC_FILE=y
> CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
> CONFIG_KEXEC_VERIFY_SIG=y
> CONFIG_CRASH_DUMP=y
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> # CONFIG_RANDOMIZE_BASE is not set
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_HOTPLUG_CPU=y
> # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
> CONFIG_DEBUG_HOTPLUG_CPU0=y
> CONFIG_LEGACY_VSYSCALL_EMULATE=y
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> CONFIG_HAVE_LIVEPATCH=y
> CONFIG_ARCH_HAS_ADD_PAGES=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_USE_PERCPU_NUMA_NODE_ID=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=y
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> CONFIG_SUSPEND_SKIP_SYNC=y
> CONFIG_HIBERNATE_CALLBACKS=y
> CONFIG_HIBERNATION=y
> CONFIG_PM_STD_PARTITION=""
> CONFIG_PM_SLEEP=y
> CONFIG_PM_SLEEP_SMP=y
> # CONFIG_PM_AUTOSLEEP is not set
> CONFIG_PM_WAKELOCKS=y
> CONFIG_PM_WAKELOCKS_LIMIT=100
> # CONFIG_PM_WAKELOCKS_GC is not set
> CONFIG_PM=y
> # CONFIG_PM_DEBUG is not set
> CONFIG_PM_CLK=y
> CONFIG_PM_GENERIC_DOMAINS=y
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
> CONFIG_PM_GENERIC_DOMAINS_OF=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> CONFIG_ACPI_DEBUGGER=y
> # CONFIG_ACPI_DEBUGGER_USER is not set
> # CONFIG_ACPI_SPCR_TABLE is not set
> CONFIG_ACPI_LPIT=y
> CONFIG_ACPI_SLEEP=y
> # CONFIG_ACPI_PROCFS_POWER is not set
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> # CONFIG_ACPI_EC_DEBUGFS is not set
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=m
> CONFIG_ACPI_FAN=m
> # CONFIG_ACPI_TAD is not set
> # CONFIG_ACPI_DOCK is not set
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_PROCESSOR=m
> CONFIG_ACPI_HOTPLUG_CPU=y
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
> CONFIG_ACPI_THERMAL=m
> CONFIG_ACPI_NUMA=y
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_DEBUG=y
> # CONFIG_ACPI_PCI_SLOT is not set
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> CONFIG_ACPI_SBS=m
> CONFIG_ACPI_HED=y
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> # CONFIG_ACPI_NFIT is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> CONFIG_ACPI_APEI=y
> CONFIG_ACPI_APEI_GHES=y
> # CONFIG_ACPI_APEI_EINJ is not set
> # CONFIG_ACPI_APEI_ERST_DEBUG is not set
> CONFIG_DPTF_POWER=y
> CONFIG_ACPI_WATCHDOG=y
> CONFIG_PMIC_OPREGION=y
> CONFIG_ACPI_CONFIGFS=y
> CONFIG_X86_PM_TIMER=y
> CONFIG_SFI=y
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> # CONFIG_CPU_IDLE_GOV_MENU is not set
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_MMCONF_FAM10H=y
> CONFIG_PCI_CNB20LE_QUIRK=y
> # CONFIG_PCIEPORTBUS is not set
> # CONFIG_PCI_MSI is not set
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> CONFIG_PCI_REALLOC_ENABLE_AUTO=y
> CONFIG_PCI_STUB=y
> CONFIG_PCI_PF_STUB=y
> CONFIG_PCI_ATS=y
> CONFIG_PCI_LOCKLESS_CONFIG=y
> CONFIG_PCI_IOV=y
> # CONFIG_PCI_PRI is not set
> # CONFIG_PCI_PASID is not set
> CONFIG_PCI_LABEL=y
> CONFIG_HOTPLUG_PCI=y
> CONFIG_HOTPLUG_PCI_ACPI=y
> CONFIG_HOTPLUG_PCI_ACPI_IBM=y
> CONFIG_HOTPLUG_PCI_CPCI=y
> # CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
> CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
> # CONFIG_HOTPLUG_PCI_SHPC is not set
> 
> #
> # PCI controller drivers
> #
> 
> #
> # Cadence PCIe controllers support
> #
> CONFIG_PCIE_CADENCE=y
> CONFIG_PCIE_CADENCE_HOST=y
> CONFIG_PCIE_CADENCE_EP=y
> # CONFIG_PCI_FTPCI100 is not set
> # CONFIG_PCI_HOST_GENERIC is not set
> 
> #
> # DesignWare PCI Core Support
> #
> 
> #
> # PCI Endpoint
> #
> CONFIG_PCI_ENDPOINT=y
> CONFIG_PCI_ENDPOINT_CONFIGFS=y
> CONFIG_PCI_EPF_TEST=y
> 
> #
> # PCI switch controller drivers
> #
> CONFIG_PCI_SW_SWITCHTEC=m
> CONFIG_ISA_BUS=y
> CONFIG_ISA_DMA_API=y
> # CONFIG_PCCARD is not set
> # CONFIG_RAPIDIO is not set
> CONFIG_X86_SYSFB=y
> 
> #
> # Executable file formats / Emulations
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=m
> CONFIG_COREDUMP=y
> # CONFIG_IA32_EMULATION is not set
> CONFIG_X86_X32=y
> CONFIG_COMPAT=y
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
> CONFIG_SYSVIPC_COMPAT=y
> CONFIG_X86_DEV_DMA_OPS=y
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> # CONFIG_PACKET is not set
> CONFIG_UNIX=y
> # CONFIG_UNIX_DIAG is not set
> # CONFIG_TLS is not set
> CONFIG_XFRM=y
> # CONFIG_XFRM_USER is not set
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_XFRM_MIGRATE is not set
> # CONFIG_XFRM_STATISTICS is not set
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=y
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_XFRM_MODE_TRANSPORT=y
> CONFIG_INET_XFRM_MODE_TUNNEL=y
> CONFIG_INET_XFRM_MODE_BEET=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_INET_RAW_DIAG is not set
> # CONFIG_INET_DIAG_DESTROY is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=y
> # CONFIG_IPV6_ROUTER_PREF is not set
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_MIP6 is not set
> CONFIG_INET6_XFRM_MODE_TRANSPORT=y
> CONFIG_INET6_XFRM_MODE_TUNNEL=y
> CONFIG_INET6_XFRM_MODE_BEET=y
> # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
> # CONFIG_IPV6_VTI is not set
> CONFIG_IPV6_SIT=y
> # CONFIG_IPV6_SIT_6RD is not set
> CONFIG_IPV6_NDISC_NODETYPE=y
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
> # CONFIG_IPV6_MROUTE is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_NETLABEL is not set
> # CONFIG_NETWORK_SECMARK is not set
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> # CONFIG_BRIDGE is not set
> CONFIG_HAVE_NET_DSA=y
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_6LOWPAN is not set
> # CONFIG_IEEE802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> CONFIG_DNS_RESOLVER=m
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> # CONFIG_NET_NSH is not set
> # CONFIG_HSR is not set
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> # CONFIG_NET_NCSI is not set
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_XPS=y
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> # CONFIG_BPF_JIT is not set
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_WIRELESS=y
> # CONFIG_CFG80211 is not set
> 
> #
> # CFG80211 needs to be enabled for MAC80211
> #
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> # CONFIG_WIMAX is not set
> # CONFIG_RFKILL is not set
> # CONFIG_NET_9P is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> # CONFIG_LWTUNNEL is not set
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> # CONFIG_NET_DEVLINK is not set
> CONFIG_MAY_USE_DEVLINK=y
> # CONFIG_FAILOVER is not set
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER=y
> CONFIG_UEVENT_HELPER_PATH=""
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> CONFIG_WANT_DEV_COREDUMP=y
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_TEST_ASYNC_DRIVER_PROBE=m
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=m
> CONFIG_REGMAP_SPI=y
> CONFIG_REGMAP_SPMI=m
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_DMA_SHARED_BUFFER=y
> CONFIG_DMA_FENCE_TRACE=y
> CONFIG_DMA_CMA=y
> 
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=0
> CONFIG_CMA_SIZE_PERCENTAGE=0
> # CONFIG_CMA_SIZE_SEL_MBYTES is not set
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> CONFIG_CMA_SIZE_SEL_MIN=y
> # CONFIG_CMA_SIZE_SEL_MAX is not set
> CONFIG_CMA_ALIGNMENT=8
> 
> #
> # Bus devices
> #
> CONFIG_SIMPLE_PM_BUS=m
> # CONFIG_CONNECTOR is not set
> # CONFIG_MTD is not set
> CONFIG_DTC=y
> CONFIG_OF=y
> CONFIG_OF_UNITTEST=y
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_OF_KOBJ=y
> CONFIG_OF_DYNAMIC=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_NET=y
> CONFIG_OF_RESOLVE=y
> # CONFIG_OF_OVERLAY is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> CONFIG_PARPORT=y
> # CONFIG_PARPORT_PC is not set
> CONFIG_PARPORT_AX88796=m
> # CONFIG_PARPORT_1284 is not set
> CONFIG_PARPORT_NOT_PC=y
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG_MESSAGES is not set
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> # CONFIG_BLK_DEV_NULL_BLK is not set
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_LOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SKD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> # CONFIG_VIRTIO_BLK is not set
> # CONFIG_BLK_DEV_RBD is not set
> # CONFIG_BLK_DEV_RSXX is not set
> 
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=y
> CONFIG_BLK_DEV_NVME=y
> # CONFIG_NVME_MULTIPATH is not set
> CONFIG_NVME_FABRICS=y
> CONFIG_NVME_FC=y
> CONFIG_NVME_TARGET=m
> CONFIG_NVME_TARGET_LOOP=m
> CONFIG_NVME_TARGET_FC=m
> CONFIG_NVME_TARGET_FCLOOP=m
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=m
> # CONFIG_AD525X_DPOT is not set
> CONFIG_DUMMY_IRQ=m
> CONFIG_IBM_ASM=y
> # CONFIG_PHANTOM is not set
> # CONFIG_SGI_IOC4 is not set
> # CONFIG_TIFM_CORE is not set
> CONFIG_ICS932S401=m
> CONFIG_ENCLOSURE_SERVICES=m
> # CONFIG_HP_ILO is not set
> CONFIG_APDS9802ALS=m
> CONFIG_ISL29003=m
> CONFIG_ISL29020=m
> CONFIG_SENSORS_TSL2550=m
> CONFIG_SENSORS_BH1770=m
> CONFIG_SENSORS_APDS990X=m
> CONFIG_HMC6352=m
> CONFIG_DS1682=m
> # CONFIG_VMWARE_BALLOON is not set
> # CONFIG_USB_SWITCH_FSA9480 is not set
> CONFIG_LATTICE_ECP3_CONFIG=m
> # CONFIG_SRAM is not set
> CONFIG_PCI_ENDPOINT_TEST=y
> CONFIG_C2PORT=y
> CONFIG_C2PORT_DURAMAR_2150=m
> 
> #
> # EEPROM support
> #
> CONFIG_EEPROM_AT24=m
> CONFIG_EEPROM_AT25=y
> CONFIG_EEPROM_LEGACY=m
> CONFIG_EEPROM_MAX6875=m
> # CONFIG_EEPROM_93CX6 is not set
> CONFIG_EEPROM_93XX46=m
> CONFIG_EEPROM_IDT_89HPESX=m
> CONFIG_CB710_CORE=y
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> CONFIG_SENSORS_LIS3_I2C=m
> 
> #
> # Altera FPGA firmware download module (requires I2C)
> #
> CONFIG_ALTERA_STAPL=m
> CONFIG_INTEL_MEI=m
> # CONFIG_INTEL_MEI_ME is not set
> CONFIG_INTEL_MEI_TXE=m
> CONFIG_VMWARE_VMCI=y
> 
> #
> # Intel MIC & related support
> #
> 
> #
> # Intel MIC Bus Driver
> #
> # CONFIG_INTEL_MIC_BUS is not set
> 
> #
> # SCIF Bus Driver
> #
> CONFIG_SCIF_BUS=y
> 
> #
> # VOP Bus Driver
> #
> CONFIG_VOP_BUS=m
> 
> #
> # Intel MIC Host Driver
> #
> 
> #
> # Intel MIC Card Driver
> #
> 
> #
> # SCIF Driver
> #
> 
> #
> # Intel MIC Coprocessor State Management (COSM) Drivers
> #
> 
> #
> # VOP Driver
> #
> CONFIG_VOP=m
> CONFIG_VHOST_RING=m
> # CONFIG_GENWQE is not set
> CONFIG_ECHO=y
> # CONFIG_MISC_RTSX_PCI is not set
> CONFIG_HAVE_IDE=y
> CONFIG_IDE=m
> 
> #
> # Please see Documentation/ide/ide.txt for help/info on IDE drives
> #
> CONFIG_IDE_XFER_MODE=y
> CONFIG_IDE_TIMINGS=y
> CONFIG_IDE_ATAPI=y
> # CONFIG_BLK_DEV_IDE_SATA is not set
> # CONFIG_IDE_GD is not set
> # CONFIG_BLK_DEV_IDECD is not set
> CONFIG_BLK_DEV_IDETAPE=m
> # CONFIG_BLK_DEV_IDEACPI is not set
> CONFIG_IDE_TASK_IOCTL=y
> CONFIG_IDE_PROC_FS=y
> 
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_IDE_GENERIC=m
> # CONFIG_BLK_DEV_PLATFORM is not set
> CONFIG_BLK_DEV_CMD640=m
> CONFIG_BLK_DEV_CMD640_ENHANCED=y
> CONFIG_BLK_DEV_IDEPNP=m
> CONFIG_BLK_DEV_IDEDMA_SFF=y
> 
> #
> # PCI IDE chipsets support
> #
> CONFIG_BLK_DEV_IDEPCI=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_BLK_DEV_GENERIC=m
> CONFIG_BLK_DEV_OPTI621=m
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_BLK_DEV_AEC62XX=m
> CONFIG_BLK_DEV_ALI15X3=m
> CONFIG_BLK_DEV_AMD74XX=m
> CONFIG_BLK_DEV_ATIIXP=m
> CONFIG_BLK_DEV_CMD64X=m
> CONFIG_BLK_DEV_TRIFLEX=m
> # CONFIG_BLK_DEV_HPT366 is not set
> CONFIG_BLK_DEV_JMICRON=m
> CONFIG_BLK_DEV_PIIX=m
> # CONFIG_BLK_DEV_IT8172 is not set
> # CONFIG_BLK_DEV_IT8213 is not set
> # CONFIG_BLK_DEV_IT821X is not set
> CONFIG_BLK_DEV_NS87415=m
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> CONFIG_BLK_DEV_PDC202XX_NEW=m
> CONFIG_BLK_DEV_SVWKS=m
> CONFIG_BLK_DEV_SIIMAGE=m
> CONFIG_BLK_DEV_SIS5513=m
> CONFIG_BLK_DEV_SLC90E66=m
> CONFIG_BLK_DEV_TRM290=m
> CONFIG_BLK_DEV_VIA82CXXX=m
> # CONFIG_BLK_DEV_TC86C001 is not set
> CONFIG_BLK_DEV_IDEDMA=y
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=m
> CONFIG_RAID_ATTRS=m
> CONFIG_SCSI=m
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_MQ_DEFAULT=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> # CONFIG_BLK_DEV_SD is not set
> CONFIG_CHR_DEV_ST=m
> CONFIG_CHR_DEV_OSST=m
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=m
> CONFIG_CHR_DEV_SCH=m
> CONFIG_SCSI_ENCLOSURE=m
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=m
> # CONFIG_SCSI_FC_ATTRS is not set
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> CONFIG_SCSI_SAS_ATTRS=m
> CONFIG_SCSI_SAS_LIBSAS=m
> CONFIG_SCSI_SAS_HOST_SMP=y
> CONFIG_SCSI_SRP_ATTRS=m
> # CONFIG_SCSI_LOWLEVEL is not set
> CONFIG_SCSI_DH=y
> CONFIG_SCSI_DH_RDAC=m
> # CONFIG_SCSI_DH_HP_SW is not set
> CONFIG_SCSI_DH_EMC=m
> CONFIG_SCSI_DH_ALUA=m
> # CONFIG_SCSI_OSD_INITIATOR is not set
> # CONFIG_ATA is not set
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=m
> CONFIG_MD_LINEAR=m
> CONFIG_MD_RAID0=m
> CONFIG_MD_RAID1=m
> # CONFIG_MD_RAID10 is not set
> CONFIG_MD_RAID456=m
> # CONFIG_MD_MULTIPATH is not set
> CONFIG_MD_FAULTY=m
> CONFIG_BCACHE=m
> CONFIG_BCACHE_DEBUG=y
> CONFIG_BCACHE_CLOSURES_DEBUG=y
> # CONFIG_BLK_DEV_DM is not set
> CONFIG_TARGET_CORE=m
> # CONFIG_TCM_IBLOCK is not set
> CONFIG_TCM_FILEIO=m
> CONFIG_TCM_PSCSI=m
> # CONFIG_TCM_USER2 is not set
> # CONFIG_LOOPBACK_TARGET is not set
> # CONFIG_ISCSI_TARGET is not set
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> CONFIG_FIREWIRE_NOSY=m
> # CONFIG_MACINTOSH_DRIVERS is not set
> CONFIG_NETDEVICES=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_FC is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_MACSEC is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_NTB_NETDEV is not set
> # CONFIG_TUN is not set
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> # CONFIG_VIRTIO_NET is not set
> # CONFIG_NLMON is not set
> # CONFIG_ARCNET is not set
> 
> #
> # CAIF transport drivers
> #
> 
> #
> # Distributed Switch Architecture drivers
> #
> CONFIG_ETHERNET=y
> CONFIG_MDIO=m
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_VORTEX is not set
> # CONFIG_TYPHOON is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> CONFIG_NET_VENDOR_AMD=y
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD_XGBE is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> # CONFIG_NET_VENDOR_AURORA is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> CONFIG_NET_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> # CONFIG_THUNDER_NIC_PF is not set
> # CONFIG_THUNDER_NIC_VF is not set
> # CONFIG_THUNDER_NIC_BGX is not set
> # CONFIG_THUNDER_NIC_RGX is not set
> CONFIG_CAVIUM_PTP=y
> # CONFIG_LIQUIDIO is not set
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=y
> # CONFIG_GEMINI_ETHERNET is not set
> # CONFIG_CX_ECAT is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> # CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_HP=y
> # CONFIG_HP100 is not set
> CONFIG_NET_VENDOR_HUAWEI=y
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> CONFIG_E1000E=m
> CONFIG_E1000E_HWTS=y
> CONFIG_IGB=m
> CONFIG_IGB_HWMON=y
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> CONFIG_IXGBE=m
> CONFIG_IXGBE_HWMON=y
> # CONFIG_I40E is not set
> CONFIG_NET_VENDOR_EXAR=y
> # CONFIG_S2IO is not set
> # CONFIG_VXGE is not set
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8851 is not set
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=y
> # CONFIG_ENC28J60 is not set
> # CONFIG_ENCX24J600 is not set
> # CONFIG_LAN743X is not set
> CONFIG_NET_VENDOR_MICROSEMI=y
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> CONFIG_NET_VENDOR_NI=y
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_NE2K_PCI is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_ETHOC is not set
> CONFIG_NET_PACKET_ENGINE=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_QLGE is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> # CONFIG_QCA7000_SPI is not set
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_ATP is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_R8169 is not set
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_ROCKER=y
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SILAN=y
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=y
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=y
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_ALE is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VIA=y
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> # CONFIG_MDIO_DEVICE is not set
> # CONFIG_PHYLIB is not set
> # CONFIG_MICREL_KS8995MA is not set
> # CONFIG_PLIP is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Host-side USB support is needed for USB Network Adapter support
> #
> CONFIG_WLAN=y
> # CONFIG_WIRELESS_WDS is not set
> CONFIG_WLAN_VENDOR_ADMTEK=y
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K_PCI is not set
> CONFIG_WLAN_VENDOR_ATMEL=y
> CONFIG_WLAN_VENDOR_BROADCOM=y
> CONFIG_WLAN_VENDOR_CISCO=y
> CONFIG_WLAN_VENDOR_INTEL=y
> CONFIG_WLAN_VENDOR_INTERSIL=y
> # CONFIG_HOSTAP is not set
> # CONFIG_PRISM54 is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> CONFIG_WLAN_VENDOR_MEDIATEK=y
> CONFIG_WLAN_VENDOR_RALINK=y
> CONFIG_WLAN_VENDOR_REALTEK=y
> CONFIG_WLAN_VENDOR_RSI=y
> CONFIG_WLAN_VENDOR_ST=y
> CONFIG_WLAN_VENDOR_TI=y
> CONFIG_WLAN_VENDOR_ZYDAS=y
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> 
> #
> # Enable WiMAX (Networking options) to see the WiMAX drivers
> #
> # CONFIG_WAN is not set
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_HYPERV_NET is not set
> # CONFIG_NETDEVSIM is not set
> # CONFIG_NET_FAILOVER is not set
> # CONFIG_ISDN is not set
> CONFIG_NVM=y
> CONFIG_NVM_DEBUG=y
> # CONFIG_NVM_PBLK is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=m
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_POLLDEV=y
> CONFIG_INPUT_SPARSEKMAP=y
> # CONFIG_INPUT_MATRIXKMAP is not set
> 
> #
> # Userland interfaces
> #
> # CONFIG_INPUT_MOUSEDEV is not set
> CONFIG_INPUT_JOYDEV=m
> # CONFIG_INPUT_EVDEV is not set
> CONFIG_INPUT_EVBUG=y
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADC is not set
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_STMPE is not set
> # CONFIG_KEYBOARD_OMAP4 is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CROS_EC is not set
> # CONFIG_KEYBOARD_CAP11XX is not set
> # CONFIG_KEYBOARD_BCM is not set
> # CONFIG_KEYBOARD_MTK_PMIC is not set
> # CONFIG_INPUT_MOUSE is not set
> CONFIG_INPUT_JOYSTICK=y
> CONFIG_JOYSTICK_ANALOG=y
> CONFIG_JOYSTICK_A3D=m
> # CONFIG_JOYSTICK_ADI is not set
> CONFIG_JOYSTICK_COBRA=m
> CONFIG_JOYSTICK_GF2K=y
> CONFIG_JOYSTICK_GRIP=y
> # CONFIG_JOYSTICK_GRIP_MP is not set
> # CONFIG_JOYSTICK_GUILLEMOT is not set
> # CONFIG_JOYSTICK_INTERACT is not set
> # CONFIG_JOYSTICK_SIDEWINDER is not set
> # CONFIG_JOYSTICK_TMDC is not set
> CONFIG_JOYSTICK_IFORCE=m
> CONFIG_JOYSTICK_IFORCE_232=y
> CONFIG_JOYSTICK_WARRIOR=m
> # CONFIG_JOYSTICK_MAGELLAN is not set
> CONFIG_JOYSTICK_SPACEORB=m
> # CONFIG_JOYSTICK_SPACEBALL is not set
> CONFIG_JOYSTICK_STINGER=m
> CONFIG_JOYSTICK_TWIDJOY=m
> CONFIG_JOYSTICK_ZHENHUA=m
> CONFIG_JOYSTICK_DB9=m
> CONFIG_JOYSTICK_GAMECON=m
> # CONFIG_JOYSTICK_TURBOGRAFX is not set
> # CONFIG_JOYSTICK_AS5011 is not set
> # CONFIG_JOYSTICK_JOYDUMP is not set
> # CONFIG_JOYSTICK_XPAD is not set
> CONFIG_JOYSTICK_WALKERA0701=y
> CONFIG_JOYSTICK_PSXPAD_SPI=m
> # CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
> # CONFIG_JOYSTICK_PXRC is not set
> CONFIG_INPUT_TABLET=y
> # CONFIG_TABLET_USB_ACECAD is not set
> # CONFIG_TABLET_USB_AIPTEK is not set
> # CONFIG_TABLET_USB_HANWANG is not set
> # CONFIG_TABLET_USB_KBTAB is not set
> # CONFIG_TABLET_USB_PEGASUS is not set
> CONFIG_TABLET_SERIAL_WACOM4=m
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> # CONFIG_INPUT_88PM80X_ONKEY is not set
> CONFIG_INPUT_AD714X=m
> # CONFIG_INPUT_AD714X_I2C is not set
> CONFIG_INPUT_AD714X_SPI=m
> CONFIG_INPUT_ATMEL_CAPTOUCH=m
> # CONFIG_INPUT_BMA150 is not set
> # CONFIG_INPUT_E3X0_BUTTON is not set
> CONFIG_INPUT_PCSPKR=y
> CONFIG_INPUT_MC13783_PWRBUTTON=m
> CONFIG_INPUT_MMA8450=m
> CONFIG_INPUT_APANEL=m
> CONFIG_INPUT_GP2A=m
> # CONFIG_INPUT_GPIO_BEEPER is not set
> CONFIG_INPUT_GPIO_DECODER=y
> CONFIG_INPUT_CPCAP_PWRBUTTON=m
> CONFIG_INPUT_ATLAS_BTNS=y
> # CONFIG_INPUT_ATI_REMOTE2 is not set
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> CONFIG_INPUT_KXTJ9=m
> # CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
> # CONFIG_INPUT_POWERMATE is not set
> # CONFIG_INPUT_YEALINK is not set
> # CONFIG_INPUT_CM109 is not set
> # CONFIG_INPUT_REGULATOR_HAPTIC is not set
> CONFIG_INPUT_RETU_PWRBUTTON=m
> # CONFIG_INPUT_TPS65218_PWRBUTTON is not set
> CONFIG_INPUT_UINPUT=m
> CONFIG_INPUT_PCF8574=m
> # CONFIG_INPUT_RK805_PWRKEY is not set
> CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
> CONFIG_INPUT_ADXL34X=m
> CONFIG_INPUT_ADXL34X_I2C=m
> # CONFIG_INPUT_ADXL34X_SPI is not set
> CONFIG_INPUT_CMA3000=y
> # CONFIG_INPUT_CMA3000_I2C is not set
> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> CONFIG_INPUT_DRV2665_HAPTICS=m
> # CONFIG_INPUT_DRV2667_HAPTICS is not set
> CONFIG_RMI4_CORE=y
> # CONFIG_RMI4_I2C is not set
> # CONFIG_RMI4_SPI is not set
> CONFIG_RMI4_SMB=m
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=y
> CONFIG_RMI4_2D_SENSOR=y
> # CONFIG_RMI4_F11 is not set
> CONFIG_RMI4_F12=y
> CONFIG_RMI4_F30=y
> CONFIG_RMI4_F34=y
> CONFIG_RMI4_F55=y
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=m
> CONFIG_SERIO_CT82C710=m
> CONFIG_SERIO_PARKBD=y
> CONFIG_SERIO_PCIPS2=y
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> CONFIG_SERIO_ALTERA_PS2=y
> CONFIG_SERIO_PS2MULT=y
> # CONFIG_SERIO_ARC_PS2 is not set
> CONFIG_SERIO_APBPS2=y
> CONFIG_HYPERV_KEYBOARD=y
> # CONFIG_SERIO_GPIO_PS2 is not set
> # CONFIG_USERIO is not set
> CONFIG_GAMEPORT=y
> CONFIG_GAMEPORT_NS558=y
> CONFIG_GAMEPORT_L4=y
> # CONFIG_GAMEPORT_EMU10K1 is not set
> # CONFIG_GAMEPORT_FM801 is not set
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> # CONFIG_VT is not set
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_NOZOMI is not set
> # CONFIG_N_GSM is not set
> # CONFIG_TRACE_SINK is not set
> CONFIG_GOLDFISH_TTY=y
> CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
> # CONFIG_DEVMEM is not set
> # CONFIG_DEVKMEM is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> # CONFIG_SERIAL_8250_PNP is not set
> CONFIG_SERIAL_8250_FINTEK=y
> CONFIG_SERIAL_8250_CONSOLE=y
> # CONFIG_SERIAL_8250_PCI is not set
> CONFIG_SERIAL_8250_MEN_MCB=m
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> # CONFIG_SERIAL_8250_MANY_PORTS is not set
> CONFIG_SERIAL_8250_ASPEED_VUART=m
> # CONFIG_SERIAL_8250_SHARE_IRQ is not set
> CONFIG_SERIAL_8250_DETECT_IRQ=y
> # CONFIG_SERIAL_8250_RSA is not set
> CONFIG_SERIAL_8250_DW=y
> # CONFIG_SERIAL_8250_RT288X is not set
> # CONFIG_SERIAL_8250_LPSS is not set
> CONFIG_SERIAL_8250_MID=y
> # CONFIG_SERIAL_8250_MOXA is not set
> # CONFIG_SERIAL_OF_PLATFORM is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_MAX3100=m
> # CONFIG_SERIAL_MAX310X is not set
> CONFIG_SERIAL_UARTLITE=m
> CONFIG_SERIAL_UARTLITE_NR_UARTS=1
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_JSM=m
> # CONFIG_SERIAL_SCCNXP is not set
> CONFIG_SERIAL_SC16IS7XX=m
> # CONFIG_SERIAL_SC16IS7XX_I2C is not set
> # CONFIG_SERIAL_SC16IS7XX_SPI is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> CONFIG_SERIAL_ALTERA_UART=m
> CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
> CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
> CONFIG_SERIAL_IFX6X60=y
> # CONFIG_SERIAL_XILINX_PS_UART is not set
> # CONFIG_SERIAL_ARC is not set
> CONFIG_SERIAL_RP2=m
> CONFIG_SERIAL_RP2_NR_UARTS=32
> # CONFIG_SERIAL_FSL_LPUART is not set
> CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
> # CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
> # CONFIG_SERIAL_MEN_Z135 is not set
> # CONFIG_SERIAL_DEV_BUS is not set
> CONFIG_TTY_PRINTK=y
> CONFIG_PRINTER=m
> # CONFIG_LP_CONSOLE is not set
> # CONFIG_PPDEV is not set
> CONFIG_HVC_DRIVER=y
> CONFIG_VIRTIO_CONSOLE=m
> # CONFIG_IPMI_HANDLER is not set
> # CONFIG_HW_RANDOM is not set
> CONFIG_NVRAM=m
> CONFIG_R3964=m
> # CONFIG_APPLICOM is not set
> # CONFIG_MWAVE is not set
> CONFIG_RAW_DRIVER=y
> CONFIG_MAX_RAW_DEVS=256
> CONFIG_HPET=y
> # CONFIG_HPET_MMAP is not set
> CONFIG_HANGCHECK_TIMER=m
> CONFIG_TCG_TPM=m
> # CONFIG_TCG_TIS is not set
> # CONFIG_TCG_TIS_SPI is not set
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> CONFIG_TCG_TIS_I2C_INFINEON=m
> CONFIG_TCG_TIS_I2C_NUVOTON=m
> # CONFIG_TCG_NSC is not set
> # CONFIG_TCG_ATMEL is not set
> CONFIG_TCG_INFINEON=m
> # CONFIG_TCG_CRB is not set
> CONFIG_TCG_VTPM_PROXY=m
> CONFIG_TCG_TIS_ST33ZP24=m
> CONFIG_TCG_TIS_ST33ZP24_I2C=m
> CONFIG_TCG_TIS_ST33ZP24_SPI=m
> CONFIG_TELCLOCK=m
> # CONFIG_DEVPORT is not set
> # CONFIG_XILLYBUS is not set
> 
> #
> # I2C support
> #
> CONFIG_I2C=m
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_CHARDEV=m
> CONFIG_I2C_MUX=m
> 
> #
> # Multiplexer I2C Chip support
> #
> CONFIG_I2C_ARB_GPIO_CHALLENGE=m
> CONFIG_I2C_MUX_GPIO=m
> CONFIG_I2C_MUX_GPMUX=m
> CONFIG_I2C_MUX_LTC4306=m
> # CONFIG_I2C_MUX_PCA9541 is not set
> CONFIG_I2C_MUX_PCA954x=m
> # CONFIG_I2C_MUX_PINCTRL is not set
> CONFIG_I2C_MUX_REG=m
> CONFIG_I2C_DEMUX_PINCTRL=m
> # CONFIG_I2C_MUX_MLXCPLD is not set
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=m
> CONFIG_I2C_ALGOBIT=m
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> CONFIG_I2C_ALI1535=m
> CONFIG_I2C_ALI1563=m
> CONFIG_I2C_ALI15X3=m
> CONFIG_I2C_AMD756=m
> # CONFIG_I2C_AMD756_S4882 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_I801 is not set
> CONFIG_I2C_ISCH=m
> CONFIG_I2C_ISMT=m
> CONFIG_I2C_PIIX4=m
> CONFIG_I2C_NFORCE2=m
> # CONFIG_I2C_NFORCE2_S4985 is not set
> CONFIG_I2C_SIS5595=m
> CONFIG_I2C_SIS630=m
> CONFIG_I2C_SIS96X=m
> # CONFIG_I2C_VIA is not set
> CONFIG_I2C_VIAPRO=m
> 
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=m
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> CONFIG_I2C_CBUS_GPIO=m
> CONFIG_I2C_DESIGNWARE_CORE=m
> CONFIG_I2C_DESIGNWARE_PLATFORM=m
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PCI=m
> # CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
> CONFIG_I2C_EMEV2=m
> # CONFIG_I2C_GPIO is not set
> CONFIG_I2C_KEMPLD=m
> CONFIG_I2C_OCORES=m
> # CONFIG_I2C_PCA_PLATFORM is not set
> CONFIG_I2C_RK3X=m
> CONFIG_I2C_SIMTEC=m
> CONFIG_I2C_XILINX=m
> 
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_PARPORT is not set
> CONFIG_I2C_PARPORT_LIGHT=m
> CONFIG_I2C_TAOS_EVM=m
> 
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_MLXCPLD=m
> # CONFIG_I2C_CROS_EC_TUNNEL is not set
> CONFIG_I2C_STUB=m
> CONFIG_I2C_SLAVE=y
> CONFIG_I2C_SLAVE_EEPROM=m
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> CONFIG_SPI_MEM=y
> 
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> CONFIG_SPI_AXI_SPI_ENGINE=m
> CONFIG_SPI_BITBANG=y
> CONFIG_SPI_BUTTERFLY=y
> # CONFIG_SPI_CADENCE is not set
> CONFIG_SPI_DESIGNWARE=m
> CONFIG_SPI_DW_PCI=m
> CONFIG_SPI_DW_MMIO=m
> CONFIG_SPI_GPIO=m
> # CONFIG_SPI_LM70_LLP is not set
> CONFIG_SPI_FSL_LIB=y
> CONFIG_SPI_FSL_SPI=y
> CONFIG_SPI_OC_TINY=y
> # CONFIG_SPI_PXA2XX is not set
> CONFIG_SPI_ROCKCHIP=y
> CONFIG_SPI_SC18IS602=m
> # CONFIG_SPI_XCOMM is not set
> CONFIG_SPI_XILINX=m
> CONFIG_SPI_ZYNQMP_GQSPI=y
> 
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_LOOPBACK_TEST is not set
> CONFIG_SPI_TLE62X0=y
> CONFIG_SPI_SLAVE=y
> # CONFIG_SPI_SLAVE_TIME is not set
> CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
> CONFIG_SPMI=m
> CONFIG_HSI=y
> CONFIG_HSI_BOARDINFO=y
> 
> #
> # HSI controllers
> #
> 
> #
> # HSI clients
> #
> CONFIG_HSI_CHAR=m
> # CONFIG_PPS is not set
> 
> #
> # PTP clock support
> #
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> CONFIG_PINCTRL=y
> CONFIG_PINMUX=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> CONFIG_DEBUG_PINCTRL=y
> CONFIG_PINCTRL_AMD=m
> CONFIG_PINCTRL_MCP23S08=m
> # CONFIG_PINCTRL_SINGLE is not set
> CONFIG_PINCTRL_RK805=m
> CONFIG_PINCTRL_BAYTRAIL=y
> CONFIG_PINCTRL_CHERRYVIEW=y
> CONFIG_PINCTRL_INTEL=y
> # CONFIG_PINCTRL_BROXTON is not set
> CONFIG_PINCTRL_CANNONLAKE=y
> CONFIG_PINCTRL_CEDARFORK=m
> CONFIG_PINCTRL_DENVERTON=y
> CONFIG_PINCTRL_GEMINILAKE=m
> # CONFIG_PINCTRL_LEWISBURG is not set
> CONFIG_PINCTRL_SUNRISEPOINT=m
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_OF_GPIO=y
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_SYSFS=y
> CONFIG_GPIO_GENERIC=y
> CONFIG_GPIO_MAX730X=m
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_74XX_MMIO is not set
> # CONFIG_GPIO_ALTERA is not set
> # CONFIG_GPIO_AMDPT is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_FTGPIO010 is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> CONFIG_GPIO_GRGPIO=y
> CONFIG_GPIO_HLWD=y
> # CONFIG_GPIO_ICH is not set
> CONFIG_GPIO_LYNXPOINT=m
> CONFIG_GPIO_MB86S7X=y
> CONFIG_GPIO_MENZ127=m
> CONFIG_GPIO_MOCKUP=y
> # CONFIG_GPIO_SYSCON is not set
> CONFIG_GPIO_VX855=m
> CONFIG_GPIO_XILINX=m
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> CONFIG_GPIO_F7188X=m
> CONFIG_GPIO_IT87=y
> CONFIG_GPIO_SCH=m
> # CONFIG_GPIO_SCH311X is not set
> # CONFIG_GPIO_WINBOND is not set
> # CONFIG_GPIO_WS16C48 is not set
> 
> #
> # I2C GPIO expanders
> #
> CONFIG_GPIO_ADP5588=m
> CONFIG_GPIO_ADNP=m
> # CONFIG_GPIO_MAX7300 is not set
> CONFIG_GPIO_MAX732X=m
> CONFIG_GPIO_PCA953X=m
> # CONFIG_GPIO_PCF857X is not set
> CONFIG_GPIO_TPIC2810=m
> 
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_ARIZONA=m
> # CONFIG_GPIO_BD9571MWV is not set
> CONFIG_GPIO_KEMPLD=m
> # CONFIG_GPIO_LP3943 is not set
> CONFIG_GPIO_LP873X=m
> # CONFIG_GPIO_STMPE is not set
> CONFIG_GPIO_TPS65912=m
> CONFIG_GPIO_WM8994=m
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> CONFIG_GPIO_BT8XX=y
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> CONFIG_GPIO_PCIE_IDIO_24=y
> CONFIG_GPIO_RDC321X=m
> CONFIG_GPIO_SODAVILLE=y
> 
> #
> # SPI GPIO expanders
> #
> CONFIG_GPIO_74X164=y
> # CONFIG_GPIO_MAX3191X is not set
> CONFIG_GPIO_MAX7301=m
> CONFIG_GPIO_MC33880=m
> CONFIG_GPIO_PISOSR=m
> CONFIG_GPIO_XRA1403=y
> CONFIG_W1=y
> 
> #
> # 1-wire Bus Masters
> #
> # CONFIG_W1_MASTER_MATROX is not set
> # CONFIG_W1_MASTER_DS2482 is not set
> CONFIG_W1_MASTER_DS1WM=m
> CONFIG_W1_MASTER_GPIO=m
> 
> #
> # 1-wire Slaves
> #
> CONFIG_W1_SLAVE_THERM=y
> # CONFIG_W1_SLAVE_SMEM is not set
> CONFIG_W1_SLAVE_DS2405=m
> CONFIG_W1_SLAVE_DS2408=y
> # CONFIG_W1_SLAVE_DS2408_READBACK is not set
> CONFIG_W1_SLAVE_DS2413=m
> CONFIG_W1_SLAVE_DS2406=m
> CONFIG_W1_SLAVE_DS2423=m
> CONFIG_W1_SLAVE_DS2805=y
> # CONFIG_W1_SLAVE_DS2431 is not set
> CONFIG_W1_SLAVE_DS2433=m
> CONFIG_W1_SLAVE_DS2433_CRC=y
> CONFIG_W1_SLAVE_DS2438=y
> # CONFIG_W1_SLAVE_DS2760 is not set
> CONFIG_W1_SLAVE_DS2780=m
> CONFIG_W1_SLAVE_DS2781=y
> CONFIG_W1_SLAVE_DS28E04=y
> CONFIG_W1_SLAVE_DS28E17=m
> CONFIG_POWER_AVS=y
> # CONFIG_POWER_RESET is not set
> CONFIG_POWER_SUPPLY=y
> CONFIG_POWER_SUPPLY_DEBUG=y
> CONFIG_PDA_POWER=y
> # CONFIG_GENERIC_ADC_BATTERY is not set
> # CONFIG_TEST_POWER is not set
> CONFIG_BATTERY_CPCAP=m
> CONFIG_BATTERY_DS2780=m
> CONFIG_BATTERY_DS2781=y
> # CONFIG_BATTERY_DS2782 is not set
> CONFIG_BATTERY_LEGO_EV3=m
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> CONFIG_MANAGER_SBS=m
> CONFIG_BATTERY_BQ27XXX=y
> # CONFIG_BATTERY_BQ27XXX_I2C is not set
> # CONFIG_BATTERY_BQ27XXX_HDQ is not set
> # CONFIG_BATTERY_DA9150 is not set
> CONFIG_BATTERY_MAX17040=m
> CONFIG_BATTERY_MAX17042=m
> # CONFIG_BATTERY_MAX1721X is not set
> # CONFIG_CHARGER_MAX8903 is not set
> CONFIG_CHARGER_LP8727=m
> CONFIG_CHARGER_GPIO=y
> # CONFIG_CHARGER_MANAGER is not set
> # CONFIG_CHARGER_LTC3651 is not set
> CONFIG_CHARGER_MAX14577=m
> CONFIG_CHARGER_DETECTOR_MAX14656=m
> CONFIG_CHARGER_BQ2415X=m
> CONFIG_CHARGER_BQ24190=m
> CONFIG_CHARGER_BQ24257=m
> CONFIG_CHARGER_BQ24735=m
> CONFIG_CHARGER_BQ25890=m
> CONFIG_CHARGER_SMB347=m
> # CONFIG_CHARGER_TPS65217 is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> CONFIG_BATTERY_GOLDFISH=m
> CONFIG_CHARGER_RT9455=m
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> # CONFIG_SENSORS_ABITUGURU is not set
> CONFIG_SENSORS_ABITUGURU3=y
> # CONFIG_SENSORS_AD7314 is not set
> # CONFIG_SENSORS_AD7414 is not set
> CONFIG_SENSORS_AD7418=m
> CONFIG_SENSORS_ADM1021=m
> CONFIG_SENSORS_ADM1025=m
> # CONFIG_SENSORS_ADM1026 is not set
> # CONFIG_SENSORS_ADM1029 is not set
> CONFIG_SENSORS_ADM1031=m
> CONFIG_SENSORS_ADM9240=m
> CONFIG_SENSORS_ADT7X10=m
> CONFIG_SENSORS_ADT7310=m
> CONFIG_SENSORS_ADT7410=m
> CONFIG_SENSORS_ADT7411=m
> CONFIG_SENSORS_ADT7462=m
> # CONFIG_SENSORS_ADT7470 is not set
> CONFIG_SENSORS_ADT7475=m
> # CONFIG_SENSORS_ASC7621 is not set
> # CONFIG_SENSORS_K8TEMP is not set
> CONFIG_SENSORS_APPLESMC=m
> # CONFIG_SENSORS_ASB100 is not set
> CONFIG_SENSORS_ASPEED=m
> CONFIG_SENSORS_ATXP1=m
> # CONFIG_SENSORS_DS620 is not set
> CONFIG_SENSORS_DS1621=m
> CONFIG_SENSORS_DELL_SMM=m
> CONFIG_SENSORS_I5K_AMB=m
> CONFIG_SENSORS_F71805F=m
> CONFIG_SENSORS_F71882FG=m
> # CONFIG_SENSORS_F75375S is not set
> # CONFIG_SENSORS_MC13783_ADC is not set
> CONFIG_SENSORS_FSCHMD=m
> CONFIG_SENSORS_FTSTEUTATES=m
> CONFIG_SENSORS_GL518SM=m
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_G760A is not set
> CONFIG_SENSORS_G762=m
> CONFIG_SENSORS_GPIO_FAN=y
> # CONFIG_SENSORS_HIH6130 is not set
> CONFIG_SENSORS_IIO_HWMON=m
> CONFIG_SENSORS_I5500=m
> CONFIG_SENSORS_CORETEMP=m
> CONFIG_SENSORS_IT87=y
> CONFIG_SENSORS_JC42=m
> CONFIG_SENSORS_POWR1220=m
> # CONFIG_SENSORS_LINEAGE is not set
> CONFIG_SENSORS_LTC2945=m
> CONFIG_SENSORS_LTC2990=m
> # CONFIG_SENSORS_LTC4151 is not set
> # CONFIG_SENSORS_LTC4215 is not set
> CONFIG_SENSORS_LTC4222=m
> CONFIG_SENSORS_LTC4245=m
> CONFIG_SENSORS_LTC4260=m
> CONFIG_SENSORS_LTC4261=m
> CONFIG_SENSORS_MAX1111=m
> # CONFIG_SENSORS_MAX16065 is not set
> CONFIG_SENSORS_MAX1619=m
> CONFIG_SENSORS_MAX1668=m
> CONFIG_SENSORS_MAX197=y
> CONFIG_SENSORS_MAX31722=m
> CONFIG_SENSORS_MAX6621=m
> CONFIG_SENSORS_MAX6639=m
> CONFIG_SENSORS_MAX6642=m
> # CONFIG_SENSORS_MAX6650 is not set
> # CONFIG_SENSORS_MAX6697 is not set
> # CONFIG_SENSORS_MAX31790 is not set
> CONFIG_SENSORS_MCP3021=m
> CONFIG_SENSORS_TC654=m
> CONFIG_SENSORS_ADCXX=y
> CONFIG_SENSORS_LM63=m
> CONFIG_SENSORS_LM70=m
> # CONFIG_SENSORS_LM73 is not set
> CONFIG_SENSORS_LM75=m
> CONFIG_SENSORS_LM77=m
> # CONFIG_SENSORS_LM78 is not set
> CONFIG_SENSORS_LM80=m
> CONFIG_SENSORS_LM83=m
> CONFIG_SENSORS_LM85=m
> CONFIG_SENSORS_LM87=m
> # CONFIG_SENSORS_LM90 is not set
> CONFIG_SENSORS_LM92=m
> CONFIG_SENSORS_LM93=m
> CONFIG_SENSORS_LM95234=m
> CONFIG_SENSORS_LM95241=m
> # CONFIG_SENSORS_LM95245 is not set
> CONFIG_SENSORS_PC87360=m
> CONFIG_SENSORS_PC87427=y
> # CONFIG_SENSORS_NTC_THERMISTOR is not set
> # CONFIG_SENSORS_NCT6683 is not set
> CONFIG_SENSORS_NCT6775=m
> CONFIG_SENSORS_NCT7802=m
> # CONFIG_SENSORS_NCT7904 is not set
> CONFIG_SENSORS_PCF8591=m
> CONFIG_PMBUS=m
> CONFIG_SENSORS_PMBUS=m
> CONFIG_SENSORS_ADM1275=m
> # CONFIG_SENSORS_IBM_CFFPS is not set
> # CONFIG_SENSORS_IR35221 is not set
> # CONFIG_SENSORS_LM25066 is not set
> CONFIG_SENSORS_LTC2978=m
> CONFIG_SENSORS_LTC2978_REGULATOR=y
> CONFIG_SENSORS_LTC3815=m
> CONFIG_SENSORS_MAX16064=m
> CONFIG_SENSORS_MAX20751=m
> CONFIG_SENSORS_MAX31785=m
> CONFIG_SENSORS_MAX34440=m
> CONFIG_SENSORS_MAX8688=m
> # CONFIG_SENSORS_TPS40422 is not set
> CONFIG_SENSORS_TPS53679=m
> # CONFIG_SENSORS_UCD9000 is not set
> CONFIG_SENSORS_UCD9200=m
> CONFIG_SENSORS_ZL6100=m
> CONFIG_SENSORS_SHT15=y
> CONFIG_SENSORS_SHT21=m
> # CONFIG_SENSORS_SHT3x is not set
> CONFIG_SENSORS_SHTC1=m
> CONFIG_SENSORS_SIS5595=m
> CONFIG_SENSORS_DME1737=m
> CONFIG_SENSORS_EMC1403=m
> CONFIG_SENSORS_EMC2103=m
> CONFIG_SENSORS_EMC6W201=m
> # CONFIG_SENSORS_SMSC47M1 is not set
> CONFIG_SENSORS_SMSC47M192=m
> CONFIG_SENSORS_SMSC47B397=y
> CONFIG_SENSORS_SCH56XX_COMMON=y
> CONFIG_SENSORS_SCH5627=y
> CONFIG_SENSORS_SCH5636=y
> CONFIG_SENSORS_STTS751=m
> CONFIG_SENSORS_SMM665=m
> CONFIG_SENSORS_ADC128D818=m
> CONFIG_SENSORS_ADS1015=m
> CONFIG_SENSORS_ADS7828=m
> CONFIG_SENSORS_ADS7871=y
> CONFIG_SENSORS_AMC6821=m
> CONFIG_SENSORS_INA209=m
> CONFIG_SENSORS_INA2XX=m
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=m
> CONFIG_SENSORS_TMP102=m
> CONFIG_SENSORS_TMP103=m
> # CONFIG_SENSORS_TMP108 is not set
> CONFIG_SENSORS_TMP401=m
> CONFIG_SENSORS_TMP421=m
> CONFIG_SENSORS_VIA_CPUTEMP=m
> CONFIG_SENSORS_VIA686A=m
> # CONFIG_SENSORS_VT1211 is not set
> CONFIG_SENSORS_VT8231=y
> # CONFIG_SENSORS_W83773G is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83791D is not set
> # CONFIG_SENSORS_W83792D is not set
> CONFIG_SENSORS_W83793=m
> CONFIG_SENSORS_W83795=m
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=m
> CONFIG_SENSORS_W83L786NG=m
> CONFIG_SENSORS_W83627HF=m
> # CONFIG_SENSORS_W83627EHF is not set
> 
> #
> # ACPI drivers
> #
> # CONFIG_SENSORS_ACPI_POWER is not set
> CONFIG_SENSORS_ATK0110=m
> CONFIG_THERMAL=y
> CONFIG_THERMAL_STATISTICS=y
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> # CONFIG_THERMAL_OF is not set
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> # CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_BANG_BANG=y
> # CONFIG_THERMAL_GOV_USER_SPACE is not set
> CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
> CONFIG_THERMAL_EMULATION=y
> CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
> CONFIG_INTEL_SOC_DTS_THERMAL=y
> 
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> CONFIG_INTEL_PCH_THERMAL=m
> # CONFIG_QCOM_SPMI_TEMP_ALARM is not set
> CONFIG_GENERIC_ADC_THERMAL=m
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> CONFIG_WATCHDOG_NOWAYOUT=y
> # CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
> # CONFIG_WATCHDOG_SYSFS is not set
> 
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=y
> CONFIG_GPIO_WATCHDOG=m
> CONFIG_WDAT_WDT=y
> CONFIG_XILINX_WATCHDOG=y
> CONFIG_ZIIRAVE_WATCHDOG=m
> CONFIG_CADENCE_WATCHDOG=m
> CONFIG_DW_WATCHDOG=y
> CONFIG_RN5T618_WATCHDOG=m
> # CONFIG_MAX63XX_WATCHDOG is not set
> CONFIG_RETU_WATCHDOG=m
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> # CONFIG_ALIM1535_WDT is not set
> # CONFIG_ALIM7101_WDT is not set
> # CONFIG_EBC_C384_WDT is not set
> CONFIG_F71808E_WDT=m
> # CONFIG_SP5100_TCO is not set
> # CONFIG_SBC_FITPC2_WATCHDOG is not set
> # CONFIG_EUROTECH_WDT is not set
> CONFIG_IB700_WDT=y
> CONFIG_IBMASR=y
> CONFIG_WAFER_WDT=y
> CONFIG_I6300ESB_WDT=m
> # CONFIG_IE6XX_WDT is not set
> CONFIG_ITCO_WDT=m
> CONFIG_ITCO_VENDOR_SUPPORT=y
> # CONFIG_IT8712F_WDT is not set
> CONFIG_IT87_WDT=m
> CONFIG_HP_WATCHDOG=m
> CONFIG_KEMPLD_WDT=m
> CONFIG_HPWDT_NMI_DECODING=y
> CONFIG_SC1200_WDT=y
> # CONFIG_PC87413_WDT is not set
> CONFIG_NV_TCO=m
> # CONFIG_60XX_WDT is not set
> # CONFIG_CPU5_WDT is not set
> CONFIG_SMSC_SCH311X_WDT=y
> CONFIG_SMSC37B787_WDT=y
> CONFIG_VIA_WDT=m
> CONFIG_W83627HF_WDT=y
> # CONFIG_W83877F_WDT is not set
> # CONFIG_W83977F_WDT is not set
> CONFIG_MACHZ_WDT=m
> CONFIG_SBC_EPX_C3_WATCHDOG=m
> CONFIG_INTEL_MEI_WDT=m
> CONFIG_NI903X_WDT=m
> CONFIG_NIC7018_WDT=m
> # CONFIG_MEN_A21_WDT is not set
> 
> #
> # PCI-based Watchdog Cards
> #
> CONFIG_PCIPCWATCHDOG=y
> CONFIG_WDTPCI=y
> 
> #
> # Watchdog Pretimeout Governors
> #
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
> CONFIG_SSB_POSSIBLE=y
> CONFIG_SSB=m
> CONFIG_SSB_PCIHOST_POSSIBLE=y
> # CONFIG_SSB_PCIHOST is not set
> CONFIG_SSB_SDIOHOST_POSSIBLE=y
> # CONFIG_SSB_SDIOHOST is not set
> # CONFIG_SSB_SILENT is not set
> CONFIG_SSB_DEBUG=y
> # CONFIG_SSB_DRIVER_GPIO is not set
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=m
> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> # CONFIG_BCMA_HOST_PCI is not set
> CONFIG_BCMA_HOST_SOC=y
> # CONFIG_BCMA_DRIVER_PCI is not set
> CONFIG_BCMA_SFLASH=y
> # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
> CONFIG_BCMA_DRIVER_GPIO=y
> CONFIG_BCMA_DEBUG=y
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_ACT8945A is not set
> CONFIG_MFD_ATMEL_FLEXCOM=m
> CONFIG_MFD_ATMEL_HLCDC=y
> CONFIG_MFD_BCM590XX=m
> CONFIG_MFD_BD9571MWV=m
> # CONFIG_MFD_AXP20X_I2C is not set
> CONFIG_MFD_CROS_EC=m
> # CONFIG_MFD_CROS_EC_I2C is not set
> # CONFIG_MFD_CROS_EC_SPI is not set
> # CONFIG_MFD_CROS_EC_CHARDEV is not set
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> CONFIG_MFD_DA9150=m
> CONFIG_MFD_MC13XXX=m
> CONFIG_MFD_MC13XXX_SPI=m
> CONFIG_MFD_MC13XXX_I2C=m
> CONFIG_MFD_HI6421_PMIC=y
> CONFIG_HTC_PASIC3=m
> CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
> CONFIG_LPC_ICH=m
> CONFIG_LPC_SCH=y
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> CONFIG_MFD_INTEL_LPSS=y
> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> CONFIG_MFD_INTEL_LPSS_PCI=y
> # CONFIG_MFD_JANZ_CMODIO is not set
> CONFIG_MFD_KEMPLD=m
> CONFIG_MFD_88PM800=m
> CONFIG_MFD_88PM805=m
> CONFIG_MFD_MAX14577=m
> # CONFIG_MFD_MAX77686 is not set
> # CONFIG_MFD_MAX77693 is not set
> CONFIG_MFD_MAX8907=m
> CONFIG_MFD_MT6397=y
> # CONFIG_MFD_MENF21BMC is not set
> # CONFIG_EZX_PCAP is not set
> CONFIG_MFD_CPCAP=m
> CONFIG_MFD_RETU=m
> # CONFIG_MFD_PCF50633 is not set
> CONFIG_MFD_RDC321X=m
> # CONFIG_MFD_RT5033 is not set
> CONFIG_MFD_RK808=m
> CONFIG_MFD_RN5T618=m
> CONFIG_MFD_SI476X_CORE=m
> CONFIG_MFD_SM501=m
> # CONFIG_MFD_SM501_GPIO is not set
> CONFIG_MFD_SKY81452=m
> CONFIG_ABX500_CORE=y
> CONFIG_MFD_STMPE=y
> 
> #
> # STMicroelectronics STMPE Interface Drivers
> #
> CONFIG_STMPE_SPI=y
> CONFIG_MFD_SYSCON=y
> CONFIG_MFD_TI_AM335X_TSCADC=m
> CONFIG_MFD_LP3943=m
> CONFIG_MFD_TI_LMU=m
> CONFIG_TPS6105X=m
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> CONFIG_MFD_TPS65217=m
> CONFIG_MFD_TI_LP873X=m
> # CONFIG_MFD_TI_LP87565 is not set
> # CONFIG_MFD_TPS65218 is not set
> CONFIG_MFD_TPS65912=m
> CONFIG_MFD_TPS65912_I2C=m
> # CONFIG_MFD_TPS65912_SPI is not set
> CONFIG_MFD_WL1273_CORE=m
> # CONFIG_MFD_LM3533 is not set
> CONFIG_MFD_VX855=y
> CONFIG_MFD_ARIZONA=y
> CONFIG_MFD_ARIZONA_I2C=m
> CONFIG_MFD_ARIZONA_SPI=y
> # CONFIG_MFD_CS47L24 is not set
> # CONFIG_MFD_WM5102 is not set
> CONFIG_MFD_WM5110=y
> CONFIG_MFD_WM8997=y
> # CONFIG_MFD_WM8998 is not set
> # CONFIG_MFD_WM831X_SPI is not set
> CONFIG_MFD_WM8994=m
> CONFIG_REGULATOR=y
> CONFIG_REGULATOR_DEBUG=y
> CONFIG_REGULATOR_FIXED_VOLTAGE=m
> CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
> CONFIG_REGULATOR_USERSPACE_CONSUMER=y
> CONFIG_REGULATOR_88PG86X=m
> # CONFIG_REGULATOR_88PM800 is not set
> CONFIG_REGULATOR_ACT8865=m
> CONFIG_REGULATOR_AD5398=m
> CONFIG_REGULATOR_ANATOP=y
> CONFIG_REGULATOR_BCM590XX=m
> # CONFIG_REGULATOR_BD9571MWV is not set
> CONFIG_REGULATOR_CPCAP=m
> CONFIG_REGULATOR_DA9210=m
> # CONFIG_REGULATOR_DA9211 is not set
> CONFIG_REGULATOR_FAN53555=m
> # CONFIG_REGULATOR_GPIO is not set
> CONFIG_REGULATOR_HI6421=y
> # CONFIG_REGULATOR_HI6421V530 is not set
> # CONFIG_REGULATOR_ISL9305 is not set
> # CONFIG_REGULATOR_ISL6271A is not set
> # CONFIG_REGULATOR_LM363X is not set
> CONFIG_REGULATOR_LP3971=m
> CONFIG_REGULATOR_LP3972=m
> CONFIG_REGULATOR_LP872X=m
> CONFIG_REGULATOR_LP873X=m
> CONFIG_REGULATOR_LP8755=m
> # CONFIG_REGULATOR_LTC3589 is not set
> CONFIG_REGULATOR_LTC3676=m
> # CONFIG_REGULATOR_MAX14577 is not set
> CONFIG_REGULATOR_MAX1586=m
> # CONFIG_REGULATOR_MAX8649 is not set
> # CONFIG_REGULATOR_MAX8660 is not set
> CONFIG_REGULATOR_MAX8907=m
> CONFIG_REGULATOR_MAX8952=m
> CONFIG_REGULATOR_MC13XXX_CORE=m
> CONFIG_REGULATOR_MC13783=m
> CONFIG_REGULATOR_MC13892=m
> CONFIG_REGULATOR_MT6311=m
> CONFIG_REGULATOR_MT6323=y
> # CONFIG_REGULATOR_MT6397 is not set
> # CONFIG_REGULATOR_PFUZE100 is not set
> # CONFIG_REGULATOR_PV88060 is not set
> CONFIG_REGULATOR_PV88080=m
> CONFIG_REGULATOR_PV88090=m
> CONFIG_REGULATOR_QCOM_SPMI=m
> CONFIG_REGULATOR_RK808=m
> # CONFIG_REGULATOR_RN5T618 is not set
> CONFIG_REGULATOR_SKY81452=m
> CONFIG_REGULATOR_SY8106A=m
> CONFIG_REGULATOR_TPS51632=m
> # CONFIG_REGULATOR_TPS6105X is not set
> # CONFIG_REGULATOR_TPS62360 is not set
> CONFIG_REGULATOR_TPS65023=m
> # CONFIG_REGULATOR_TPS6507X is not set
> # CONFIG_REGULATOR_TPS65132 is not set
> CONFIG_REGULATOR_TPS65217=m
> # CONFIG_REGULATOR_TPS6524X is not set
> # CONFIG_REGULATOR_TPS65912 is not set
> # CONFIG_REGULATOR_VCTRL is not set
> # CONFIG_REGULATOR_WM8994 is not set
> CONFIG_CEC_CORE=m
> CONFIG_CEC_NOTIFIER=y
> CONFIG_RC_CORE=m
> # CONFIG_RC_MAP is not set
> # CONFIG_LIRC is not set
> # CONFIG_RC_DECODERS is not set
> CONFIG_RC_DEVICES=y
> # CONFIG_RC_ATI_REMOTE is not set
> CONFIG_IR_ENE=m
> CONFIG_IR_HIX5HD2=m
> # CONFIG_IR_IMON is not set
> # CONFIG_IR_IMON_RAW is not set
> # CONFIG_IR_MCEUSB is not set
> CONFIG_IR_ITE_CIR=m
> CONFIG_IR_FINTEK=m
> # CONFIG_IR_NUVOTON is not set
> # CONFIG_IR_REDRAT3 is not set
> # CONFIG_IR_STREAMZAP is not set
> # CONFIG_IR_WINBOND_CIR is not set
> # CONFIG_IR_IGORPLUGUSB is not set
> # CONFIG_IR_IGUANA is not set
> # CONFIG_IR_TTUSBIR is not set
> CONFIG_RC_LOOPBACK=m
> # CONFIG_IR_GPIO_CIR is not set
> CONFIG_IR_SERIAL=m
> # CONFIG_IR_SERIAL_TRANSMITTER is not set
> CONFIG_IR_SIR=m
> CONFIG_MEDIA_SUPPORT=m
> 
> #
> # Multimedia core support
> #
> # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> # CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
> # CONFIG_MEDIA_RADIO_SUPPORT is not set
> # CONFIG_MEDIA_SDR_SUPPORT is not set
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> CONFIG_MEDIA_CEC_RC=y
> CONFIG_VIDEO_ADV_DEBUG=y
> CONFIG_VIDEO_FIXED_MINOR_RANGES=y
> 
> #
> # Media drivers
> #
> CONFIG_MEDIA_PCI_SUPPORT=y
> 
> #
> # Supported MMC/SDIO adapters
> #
> 
> #
> # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
> #
> 
> #
> # Media SPI Adapters
> #
> 
> #
> # Customise DVB Frontends
> #
> 
> #
> # Tools to develop new frontends
> #
> 
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> CONFIG_INTEL_GTT=m
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> CONFIG_VGA_SWITCHEROO=y
> CONFIG_DRM=m
> CONFIG_DRM_MIPI_DSI=y
> # CONFIG_DRM_DP_AUX_CHARDEV is not set
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=m
> CONFIG_DRM_KMS_FB_HELPER=y
> # CONFIG_DRM_FBDEV_EMULATION is not set
> # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> CONFIG_DRM_TTM=m
> CONFIG_DRM_GEM_CMA_HELPER=y
> CONFIG_DRM_KMS_CMA_HELPER=y
> CONFIG_DRM_VM=y
> CONFIG_DRM_SCHED=m
> 
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=m
> CONFIG_DRM_I2C_SIL164=m
> CONFIG_DRM_I2C_NXP_TDA998X=m
> CONFIG_DRM_I2C_NXP_TDA9950=m
> # CONFIG_DRM_RADEON is not set
> CONFIG_DRM_AMDGPU=m
> CONFIG_DRM_AMDGPU_SI=y
> # CONFIG_DRM_AMDGPU_CIK is not set
> # CONFIG_DRM_AMDGPU_USERPTR is not set
> # CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set
> 
> #
> # ACP (Audio CoProcessor) Configuration
> #
> CONFIG_DRM_AMD_ACP=y
> 
> #
> # Display Engine Configuration
> #
> CONFIG_DRM_AMD_DC=y
> CONFIG_DRM_AMD_DC_FBC=y
> # CONFIG_DRM_AMD_DC_DCN1_0 is not set
> CONFIG_DEBUG_KERNEL_DC=y
> 
> #
> # AMD Library routines
> #
> CONFIG_CHASH=m
> CONFIG_CHASH_STATS=y
> CONFIG_CHASH_SELFTEST=y
> # CONFIG_DRM_NOUVEAU is not set
> CONFIG_DRM_I915=m
> CONFIG_DRM_I915_ALPHA_SUPPORT=y
> # CONFIG_DRM_I915_CAPTURE_ERROR is not set
> # CONFIG_DRM_I915_USERPTR is not set
> CONFIG_DRM_I915_GVT=y
> 
> #
> # drm/i915 Debugging
> #
> CONFIG_DRM_I915_WERROR=y
> # CONFIG_DRM_I915_DEBUG is not set
> # CONFIG_DRM_I915_DEBUG_GEM is not set
> CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
> CONFIG_DRM_I915_SW_FENCE_CHECK_DAG=y
> # CONFIG_DRM_I915_DEBUG_GUC is not set
> CONFIG_DRM_I915_SELFTEST=y
> CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=y
> # CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
> CONFIG_DRM_VGEM=m
> # CONFIG_DRM_VMWGFX is not set
> CONFIG_DRM_GMA500=m
> # CONFIG_DRM_GMA600 is not set
> CONFIG_DRM_GMA3600=y
> # CONFIG_DRM_UDL is not set
> CONFIG_DRM_AST=m
> # CONFIG_DRM_MGAG200 is not set
> CONFIG_DRM_CIRRUS_QEMU=m
> CONFIG_DRM_RCAR_DW_HDMI=m
> # CONFIG_DRM_RCAR_LVDS is not set
> CONFIG_DRM_QXL=m
> CONFIG_DRM_BOCHS=m
> # CONFIG_DRM_VIRTIO_GPU is not set
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> CONFIG_DRM_PANEL_ARM_VERSATILE=m
> # CONFIG_DRM_PANEL_LVDS is not set
> CONFIG_DRM_PANEL_SIMPLE=m
> # CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
> CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
> CONFIG_DRM_PANEL_JDI_LT070ME05000=m
> CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
> # CONFIG_DRM_PANEL_LG_LG4573 is not set
> CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
> CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
> CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
> # CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
> CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
> CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
> CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
> CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
> # CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
> # CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
> CONFIG_DRM_PANEL_SITRONIX_ST7789V=m
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> CONFIG_DRM_ANALOGIX_ANX78XX=m
> CONFIG_DRM_CDNS_DSI=m
> CONFIG_DRM_DUMB_VGA_DAC=m
> CONFIG_DRM_LVDS_ENCODER=m
> CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
> CONFIG_DRM_NXP_PTN3460=m
> # CONFIG_DRM_PARADE_PS8622 is not set
> CONFIG_DRM_SIL_SII8620=m
> CONFIG_DRM_SII902X=m
> CONFIG_DRM_SII9234=m
> CONFIG_DRM_THINE_THC63LVD1024=m
> CONFIG_DRM_TOSHIBA_TC358767=m
> CONFIG_DRM_TI_TFP410=m
> CONFIG_DRM_I2C_ADV7511=m
> # CONFIG_DRM_I2C_ADV7533 is not set
> # CONFIG_DRM_I2C_ADV7511_CEC is not set
> CONFIG_DRM_DW_HDMI=m
> CONFIG_DRM_DW_HDMI_CEC=m
> CONFIG_HSA_AMD=m
> # CONFIG_DRM_ARCPGU is not set
> CONFIG_DRM_HISI_HIBMC=m
> CONFIG_DRM_MXS=y
> CONFIG_DRM_MXSFB=m
> CONFIG_DRM_TINYDRM=m
> CONFIG_TINYDRM_MIPI_DBI=m
> CONFIG_TINYDRM_ILI9225=m
> CONFIG_TINYDRM_MI0283QT=m
> CONFIG_TINYDRM_REPAPER=m
> # CONFIG_TINYDRM_ST7586 is not set
> # CONFIG_TINYDRM_ST7735R is not set
> CONFIG_DRM_LEGACY=y
> # CONFIG_DRM_TDFX is not set
> CONFIG_DRM_R128=m
> CONFIG_DRM_MGA=m
> # CONFIG_DRM_VIA is not set
> CONFIG_DRM_SAVAGE=m
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB=y
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB_BOOT_VESA_SUPPORT=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> CONFIG_FB_FOREIGN_ENDIAN=y
> # CONFIG_FB_BOTH_ENDIAN is not set
> # CONFIG_FB_BIG_ENDIAN is not set
> CONFIG_FB_LITTLE_ENDIAN=y
> CONFIG_FB_SYS_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_HECUBA=y
> CONFIG_FB_SVGALIB=y
> CONFIG_FB_BACKLIGHT=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> CONFIG_FB_ARC=m
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_VESA=y
> CONFIG_FB_N411=y
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_OPENCORES is not set
> CONFIG_FB_S1D13XXX=m
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_LE80578 is not set
> CONFIG_FB_MATROX=y
> CONFIG_FB_MATROX_MILLENIUM=y
> CONFIG_FB_MATROX_MYSTIQUE=y
> CONFIG_FB_MATROX_G=y
> # CONFIG_FB_MATROX_I2C is not set
> # CONFIG_FB_RADEON is not set
> CONFIG_FB_ATY128=m
> CONFIG_FB_ATY128_BACKLIGHT=y
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> CONFIG_FB_SIS=m
> CONFIG_FB_SIS_300=y
> # CONFIG_FB_SIS_315 is not set
> CONFIG_FB_VIA=m
> CONFIG_FB_VIA_DIRECT_PROCFS=y
> CONFIG_FB_VIA_X_COMPATIBILITY=y
> # CONFIG_FB_NEOMAGIC is not set
> CONFIG_FB_KYRO=m
> CONFIG_FB_3DFX=y
> CONFIG_FB_3DFX_ACCEL=y
> # CONFIG_FB_3DFX_I2C is not set
> CONFIG_FB_VOODOO1=y
> CONFIG_FB_VT8623=y
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> CONFIG_FB_PM3=y
> CONFIG_FB_CARMINE=m
> CONFIG_FB_CARMINE_DRAM_EVAL=y
> # CONFIG_CARMINE_DRAM_CUSTOM is not set
> CONFIG_FB_SM501=m
> CONFIG_FB_IBM_GXT4500=m
> CONFIG_FB_GOLDFISH=y
> CONFIG_FB_VIRTUAL=m
> CONFIG_FB_METRONOME=y
> # CONFIG_FB_MB862XX is not set
> CONFIG_FB_BROADSHEET=y
> CONFIG_FB_HYPERV=m
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SSD1307 is not set
> CONFIG_FB_SM712=m
> CONFIG_BACKLIGHT_LCD_SUPPORT=y
> CONFIG_LCD_CLASS_DEVICE=y
> # CONFIG_LCD_L4F00242T03 is not set
> # CONFIG_LCD_LMS283GF05 is not set
> CONFIG_LCD_LTV350QV=m
> # CONFIG_LCD_ILI922X is not set
> CONFIG_LCD_ILI9320=m
> CONFIG_LCD_TDO24M=y
> CONFIG_LCD_VGG2432A4=m
> CONFIG_LCD_PLATFORM=m
> CONFIG_LCD_S6E63M0=m
> CONFIG_LCD_LD9040=y
> CONFIG_LCD_AMS369FG06=m
> CONFIG_LCD_LMS501KF03=y
> CONFIG_LCD_HX8357=m
> CONFIG_LCD_OTM3225A=m
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_BACKLIGHT_GENERIC=y
> CONFIG_BACKLIGHT_APPLE=y
> CONFIG_BACKLIGHT_PM8941_WLED=m
> CONFIG_BACKLIGHT_SAHARA=m
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> CONFIG_BACKLIGHT_LM3639=m
> # CONFIG_BACKLIGHT_SKY81452 is not set
> CONFIG_BACKLIGHT_TPS65217=m
> CONFIG_BACKLIGHT_GPIO=y
> CONFIG_BACKLIGHT_LV5207LP=m
> CONFIG_BACKLIGHT_BD6107=m
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> CONFIG_VGASTATE=y
> CONFIG_VIDEOMODE_HELPERS=y
> CONFIG_HDMI=y
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> # CONFIG_LOGO_LINUX_CLUT224 is not set
> # CONFIG_SOUND is not set
> 
> #
> # HID support
> #
> CONFIG_HID=m
> # CONFIG_HID_BATTERY_STRENGTH is not set
> CONFIG_HIDRAW=y
> CONFIG_UHID=m
> # CONFIG_HID_GENERIC is not set
> 
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=m
> CONFIG_HID_ACRUX=m
> CONFIG_HID_ACRUX_FF=y
> # CONFIG_HID_APPLE is not set
> # CONFIG_HID_ASUS is not set
> CONFIG_HID_AUREAL=m
> # CONFIG_HID_BELKIN is not set
> CONFIG_HID_CHERRY=m
> CONFIG_HID_CHICONY=m
> # CONFIG_HID_CMEDIA is not set
> # CONFIG_HID_CYPRESS is not set
> # CONFIG_HID_DRAGONRISE is not set
> CONFIG_HID_EMS_FF=m
> # CONFIG_HID_ELECOM is not set
> CONFIG_HID_EZKEY=m
> CONFIG_HID_GEMBIRD=m
> CONFIG_HID_GFRM=m
> # CONFIG_HID_KEYTOUCH is not set
> CONFIG_HID_KYE=m
> # CONFIG_HID_WALTOP is not set
> # CONFIG_HID_GYRATION is not set
> # CONFIG_HID_ICADE is not set
> CONFIG_HID_ITE=m
> # CONFIG_HID_JABRA is not set
> CONFIG_HID_TWINHAN=m
> CONFIG_HID_KENSINGTON=m
> CONFIG_HID_LCPOWER=m
> CONFIG_HID_LED=m
> CONFIG_HID_LENOVO=m
> # CONFIG_HID_LOGITECH is not set
> # CONFIG_HID_MAGICMOUSE is not set
> CONFIG_HID_MAYFLASH=m
> # CONFIG_HID_REDRAGON is not set
> # CONFIG_HID_MICROSOFT is not set
> CONFIG_HID_MONTEREY=m
> CONFIG_HID_MULTITOUCH=m
> CONFIG_HID_NTI=m
> # CONFIG_HID_ORTEK is not set
> CONFIG_HID_PANTHERLORD=m
> # CONFIG_PANTHERLORD_FF is not set
> CONFIG_HID_PETALYNX=m
> CONFIG_HID_PICOLCD=m
> CONFIG_HID_PICOLCD_FB=y
> # CONFIG_HID_PICOLCD_BACKLIGHT is not set
> CONFIG_HID_PICOLCD_LCD=y
> # CONFIG_HID_PICOLCD_LEDS is not set
> # CONFIG_HID_PICOLCD_CIR is not set
> CONFIG_HID_PLANTRONICS=m
> CONFIG_HID_PRIMAX=m
> CONFIG_HID_SAITEK=m
> CONFIG_HID_SAMSUNG=m
> CONFIG_HID_SPEEDLINK=m
> # CONFIG_HID_STEAM is not set
> # CONFIG_HID_STEELSERIES is not set
> # CONFIG_HID_SUNPLUS is not set
> # CONFIG_HID_RMI is not set
> CONFIG_HID_GREENASIA=m
> CONFIG_GREENASIA_FF=y
> CONFIG_HID_HYPERV_MOUSE=m
> CONFIG_HID_SMARTJOYPLUS=m
> CONFIG_SMARTJOYPLUS_FF=y
> # CONFIG_HID_TIVO is not set
> CONFIG_HID_TOPSEED=m
> # CONFIG_HID_THINGM is not set
> CONFIG_HID_THRUSTMASTER=m
> # CONFIG_THRUSTMASTER_FF is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> CONFIG_HID_WIIMOTE=m
> # CONFIG_HID_XINMO is not set
> CONFIG_HID_ZEROPLUS=m
> # CONFIG_ZEROPLUS_FF is not set
> CONFIG_HID_ZYDACRON=m
> # CONFIG_HID_SENSOR_HUB is not set
> # CONFIG_HID_ALPS is not set
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID is not set
> 
> #
> # Intel ISH HID support
> #
> # CONFIG_INTEL_ISH_HID is not set
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_ARCH_HAS_HCD=y
> # CONFIG_USB is not set
> CONFIG_USB_PCI=y
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_TAHVO_USB is not set
> # CONFIG_USB_GADGET is not set
> # CONFIG_TYPEC is not set
> # CONFIG_USB_LED_TRIG is not set
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_UWB is not set
> CONFIG_MMC=m
> # CONFIG_PWRSEQ_EMMC is not set
> CONFIG_PWRSEQ_SIMPLE=m
> # CONFIG_MMC_BLOCK is not set
> # CONFIG_SDIO_UART is not set
> CONFIG_MMC_TEST=m
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> CONFIG_MMC_DEBUG=y
> CONFIG_MMC_SDHCI=m
> # CONFIG_MMC_SDHCI_PCI is not set
> # CONFIG_MMC_SDHCI_ACPI is not set
> # CONFIG_MMC_SDHCI_PLTFM is not set
> CONFIG_MMC_WBSD=m
> # CONFIG_MMC_TIFM_SD is not set
> CONFIG_MMC_GOLDFISH=m
> # CONFIG_MMC_SPI is not set
> CONFIG_MMC_CB710=m
> CONFIG_MMC_VIA_SDMMC=m
> # CONFIG_MMC_USDHI6ROL0 is not set
> # CONFIG_MMC_CQHCI is not set
> CONFIG_MMC_TOSHIBA_PCI=m
> CONFIG_MMC_MTK=m
> CONFIG_MEMSTICK=m
> CONFIG_MEMSTICK_DEBUG=y
> 
> #
> # MemoryStick drivers
> #
> CONFIG_MEMSTICK_UNSAFE_RESUME=y
> # CONFIG_MSPRO_BLOCK is not set
> CONFIG_MS_BLOCK=m
> 
> #
> # MemoryStick Host Controller Drivers
> #
> # CONFIG_MEMSTICK_TIFM_MS is not set
> CONFIG_MEMSTICK_JMICRON_38X=m
> # CONFIG_MEMSTICK_R592 is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=m
> # CONFIG_LEDS_CLASS_FLASH is not set
> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_APU is not set
> # CONFIG_LEDS_BCM6328 is not set
> # CONFIG_LEDS_BCM6358 is not set
> CONFIG_LEDS_CPCAP=m
> # CONFIG_LEDS_CR0014114 is not set
> CONFIG_LEDS_LM3530=m
> # CONFIG_LEDS_LM3642 is not set
> CONFIG_LEDS_LM3692X=m
> CONFIG_LEDS_MT6323=m
> # CONFIG_LEDS_PCA9532 is not set
> CONFIG_LEDS_GPIO=m
> CONFIG_LEDS_LP3944=m
> # CONFIG_LEDS_LP3952 is not set
> CONFIG_LEDS_LP55XX_COMMON=m
> CONFIG_LEDS_LP5521=m
> CONFIG_LEDS_LP5523=m
> CONFIG_LEDS_LP5562=m
> CONFIG_LEDS_LP8501=m
> CONFIG_LEDS_LP8860=m
> # CONFIG_LEDS_CLEVO_MAIL is not set
> # CONFIG_LEDS_PCA955X is not set
> CONFIG_LEDS_PCA963X=m
> # CONFIG_LEDS_DAC124S085 is not set
> # CONFIG_LEDS_REGULATOR is not set
> # CONFIG_LEDS_BD2802 is not set
> # CONFIG_LEDS_INTEL_SS4200 is not set
> CONFIG_LEDS_LT3593=m
> CONFIG_LEDS_MC13783=m
> # CONFIG_LEDS_TCA6507 is not set
> CONFIG_LEDS_TLC591XX=m
> CONFIG_LEDS_LM355x=m
> CONFIG_LEDS_IS31FL319X=m
> CONFIG_LEDS_IS31FL32XX=m
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=m
> # CONFIG_LEDS_MLXCPLD is not set
> # CONFIG_LEDS_MLXREG is not set
> CONFIG_LEDS_USER=m
> CONFIG_LEDS_NIC78BX=m
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> CONFIG_LEDS_TRIGGER_TIMER=y
> CONFIG_LEDS_TRIGGER_ONESHOT=y
> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
> CONFIG_LEDS_TRIGGER_CPU=y
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> # CONFIG_LEDS_TRIGGER_GPIO is not set
> # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=m
> CONFIG_LEDS_TRIGGER_CAMERA=y
> CONFIG_LEDS_TRIGGER_PANIC=y
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> CONFIG_ACCESSIBILITY=y
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> # CONFIG_RTC_HCTOSYS is not set
> CONFIG_RTC_SYSTOHC=y
> CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
> CONFIG_RTC_DEBUG=y
> CONFIG_RTC_NVMEM=y
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> # CONFIG_RTC_INTF_DEV is not set
> CONFIG_RTC_DRV_TEST=m
> 
> #
> # I2C RTC drivers
> #
> CONFIG_RTC_DRV_88PM80X=m
> CONFIG_RTC_DRV_ABB5ZES3=m
> # CONFIG_RTC_DRV_ABX80X is not set
> CONFIG_RTC_DRV_DS1307=m
> # CONFIG_RTC_DRV_DS1307_HWMON is not set
> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> CONFIG_RTC_DRV_DS1374=m
> # CONFIG_RTC_DRV_DS1374_WDT is not set
> CONFIG_RTC_DRV_DS1672=m
> # CONFIG_RTC_DRV_HYM8563 is not set
> # CONFIG_RTC_DRV_MAX6900 is not set
> CONFIG_RTC_DRV_MAX8907=m
> CONFIG_RTC_DRV_RK808=m
> CONFIG_RTC_DRV_RS5C372=m
> CONFIG_RTC_DRV_ISL1208=m
> CONFIG_RTC_DRV_ISL12022=m
> # CONFIG_RTC_DRV_ISL12026 is not set
> # CONFIG_RTC_DRV_X1205 is not set
> CONFIG_RTC_DRV_PCF8523=m
> CONFIG_RTC_DRV_PCF85063=m
> # CONFIG_RTC_DRV_PCF85363 is not set
> CONFIG_RTC_DRV_PCF8563=m
> # CONFIG_RTC_DRV_PCF8583 is not set
> # CONFIG_RTC_DRV_M41T80 is not set
> CONFIG_RTC_DRV_BQ32K=m
> # CONFIG_RTC_DRV_S35390A is not set
> # CONFIG_RTC_DRV_FM3130 is not set
> CONFIG_RTC_DRV_RX8010=m
> CONFIG_RTC_DRV_RX8581=m
> CONFIG_RTC_DRV_RX8025=m
> # CONFIG_RTC_DRV_EM3027 is not set
> CONFIG_RTC_DRV_RV8803=m
> 
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> CONFIG_RTC_DRV_M41T94=m
> CONFIG_RTC_DRV_DS1302=y
> CONFIG_RTC_DRV_DS1305=y
> CONFIG_RTC_DRV_DS1343=m
> CONFIG_RTC_DRV_DS1347=y
> CONFIG_RTC_DRV_DS1390=m
> # CONFIG_RTC_DRV_MAX6916 is not set
> CONFIG_RTC_DRV_R9701=y
> CONFIG_RTC_DRV_RX4581=y
> CONFIG_RTC_DRV_RX6110=y
> CONFIG_RTC_DRV_RS5C348=m
> # CONFIG_RTC_DRV_MAX6902 is not set
> CONFIG_RTC_DRV_PCF2123=y
> # CONFIG_RTC_DRV_MCP795 is not set
> CONFIG_RTC_I2C_AND_SPI=m
> 
> #
> # SPI and I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS3232 is not set
> CONFIG_RTC_DRV_PCF2127=m
> # CONFIG_RTC_DRV_RV3029C2 is not set
> 
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=y
> # CONFIG_RTC_DRV_DS1286 is not set
> CONFIG_RTC_DRV_DS1511=y
> # CONFIG_RTC_DRV_DS1553 is not set
> CONFIG_RTC_DRV_DS1685_FAMILY=y
> # CONFIG_RTC_DRV_DS1685 is not set
> # CONFIG_RTC_DRV_DS1689 is not set
> # CONFIG_RTC_DRV_DS17285 is not set
> # CONFIG_RTC_DRV_DS17485 is not set
> CONFIG_RTC_DRV_DS17885=y
> # CONFIG_RTC_DS1685_PROC_REGS is not set
> # CONFIG_RTC_DS1685_SYSFS_REGS is not set
> CONFIG_RTC_DRV_DS1742=m
> CONFIG_RTC_DRV_DS2404=y
> # CONFIG_RTC_DRV_STK17TA8 is not set
> CONFIG_RTC_DRV_M48T86=m
> CONFIG_RTC_DRV_M48T35=m
> # CONFIG_RTC_DRV_M48T59 is not set
> CONFIG_RTC_DRV_MSM6242=m
> CONFIG_RTC_DRV_BQ4802=y
> CONFIG_RTC_DRV_RP5C01=m
> # CONFIG_RTC_DRV_V3020 is not set
> # CONFIG_RTC_DRV_ZYNQMP is not set
> CONFIG_RTC_DRV_CROS_EC=m
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_FTRTC010 is not set
> # CONFIG_RTC_DRV_MC13XXX is not set
> CONFIG_RTC_DRV_SNVS=m
> # CONFIG_RTC_DRV_MT6397 is not set
> CONFIG_RTC_DRV_R7301=y
> CONFIG_RTC_DRV_CPCAP=m
> 
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_DMADEVICES is not set
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> # CONFIG_SW_SYNC is not set
> CONFIG_AUXDISPLAY=y
> CONFIG_HD44780=y
> # CONFIG_IMG_ASCII_LCD is not set
> # CONFIG_HT16K33 is not set
> CONFIG_PANEL=y
> CONFIG_PANEL_PARPORT=0
> CONFIG_PANEL_PROFILE=5
> CONFIG_PANEL_CHANGE_MESSAGE=y
> CONFIG_PANEL_BOOT_MESSAGE=""
> CONFIG_CHARLCD=y
> CONFIG_UIO=y
> # CONFIG_UIO_CIF is not set
> CONFIG_UIO_PDRV_GENIRQ=y
> CONFIG_UIO_DMEM_GENIRQ=m
> # CONFIG_UIO_AEC is not set
> CONFIG_UIO_SERCOS3=m
> CONFIG_UIO_PCI_GENERIC=y
> CONFIG_UIO_NETX=y
> # CONFIG_UIO_PRUSS is not set
> CONFIG_UIO_MF624=m
> CONFIG_UIO_HV_GENERIC=y
> CONFIG_VIRT_DRIVERS=y
> # CONFIG_VBOXGUEST is not set
> CONFIG_VIRTIO=m
> CONFIG_VIRTIO_MENU=y
> # CONFIG_VIRTIO_PCI is not set
> # CONFIG_VIRTIO_BALLOON is not set
> CONFIG_VIRTIO_INPUT=m
> # CONFIG_VIRTIO_MMIO is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> CONFIG_HYPERV=y
> CONFIG_HYPERV_TSCPAGE=y
> CONFIG_HYPERV_BALLOON=m
> # CONFIG_STAGING is not set
> # CONFIG_X86_PLATFORM_DEVICES is not set
> CONFIG_PMC_ATOM=y
> # CONFIG_GOLDFISH_BUS is not set
> # CONFIG_GOLDFISH_PIPE is not set
> CONFIG_CHROME_PLATFORMS=y
> # CONFIG_CHROMEOS_LAPTOP is not set
> CONFIG_CHROMEOS_PSTORE=y
> CONFIG_CHROMEOS_TBMC=y
> CONFIG_CROS_EC_LPC=m
> CONFIG_CROS_EC_LPC_MEC=y
> CONFIG_CROS_EC_PROTO=y
> CONFIG_CROS_KBD_LED_BACKLIGHT=m
> CONFIG_MELLANOX_PLATFORM=y
> CONFIG_MLXREG_HOTPLUG=m
> CONFIG_CLKDEV_LOOKUP=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> 
> #
> # Common Clock Framework
> #
> CONFIG_CLK_HSDK=y
> # CONFIG_COMMON_CLK_RK808 is not set
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_SI514 is not set
> CONFIG_COMMON_CLK_SI544=m
> # CONFIG_COMMON_CLK_SI570 is not set
> CONFIG_COMMON_CLK_CDCE706=m
> # CONFIG_COMMON_CLK_CDCE925 is not set
> CONFIG_COMMON_CLK_CS2000_CP=m
> CONFIG_COMMON_CLK_VC5=m
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # CONFIG_MAILBOX is not set
> # CONFIG_IOMMU_SUPPORT is not set
> 
> #
> # Remoteproc drivers
> #
> CONFIG_REMOTEPROC=m
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=m
> # CONFIG_RPMSG_CHAR is not set
> CONFIG_RPMSG_VIRTIO=m
> # CONFIG_SOUNDWIRE is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> 
> #
> # Broadcom SoC drivers
> #
> 
> #
> # i.MX SoC drivers
> #
> 
> #
> # Qualcomm SoC drivers
> #
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> CONFIG_XILINX_VCU=y
> # CONFIG_PM_DEVFREQ is not set
> CONFIG_EXTCON=m
> 
> #
> # Extcon Device Drivers
> #
> # CONFIG_EXTCON_ADC_JACK is not set
> CONFIG_EXTCON_GPIO=m
> CONFIG_EXTCON_INTEL_INT3496=m
> CONFIG_EXTCON_MAX14577=m
> CONFIG_EXTCON_MAX3355=m
> # CONFIG_EXTCON_RT8973A is not set
> CONFIG_EXTCON_SM5502=m
> # CONFIG_EXTCON_USB_GPIO is not set
> # CONFIG_EXTCON_USBC_CROS_EC is not set
> # CONFIG_MEMORY is not set
> CONFIG_IIO=m
> CONFIG_IIO_BUFFER=y
> CONFIG_IIO_BUFFER_CB=m
> CONFIG_IIO_BUFFER_HW_CONSUMER=m
> CONFIG_IIO_KFIFO_BUF=m
> CONFIG_IIO_TRIGGERED_BUFFER=m
> CONFIG_IIO_CONFIGFS=m
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> CONFIG_IIO_SW_DEVICE=m
> # CONFIG_IIO_SW_TRIGGER is not set
> CONFIG_IIO_TRIGGERED_EVENT=m
> 
> #
> # Accelerometers
> #
> CONFIG_ADIS16201=m
> CONFIG_ADIS16209=m
> CONFIG_BMA180=m
> CONFIG_BMA220=m
> # CONFIG_BMC150_ACCEL is not set
> # CONFIG_DA280 is not set
> CONFIG_DA311=m
> CONFIG_DMARD06=m
> # CONFIG_DMARD09 is not set
> CONFIG_DMARD10=m
> # CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
> CONFIG_IIO_ST_ACCEL_3AXIS=m
> CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
> CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
> CONFIG_KXSD9=m
> CONFIG_KXSD9_SPI=m
> CONFIG_KXSD9_I2C=m
> CONFIG_KXCJK1013=m
> CONFIG_MC3230=m
> CONFIG_MMA7455=m
> # CONFIG_MMA7455_I2C is not set
> CONFIG_MMA7455_SPI=m
> CONFIG_MMA7660=m
> # CONFIG_MMA8452 is not set
> CONFIG_MMA9551_CORE=m
> CONFIG_MMA9551=m
> CONFIG_MMA9553=m
> CONFIG_MXC4005=m
> CONFIG_MXC6255=m
> CONFIG_SCA3000=m
> # CONFIG_STK8312 is not set
> CONFIG_STK8BA50=m
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD7266=m
> CONFIG_AD7291=m
> CONFIG_AD7298=m
> # CONFIG_AD7476 is not set
> # CONFIG_AD7766 is not set
> # CONFIG_AD7791 is not set
> # CONFIG_AD7793 is not set
> CONFIG_AD7887=m
> CONFIG_AD7923=m
> # CONFIG_AD799X is not set
> CONFIG_CC10001_ADC=m
> CONFIG_CPCAP_ADC=m
> # CONFIG_DA9150_GPADC is not set
> CONFIG_ENVELOPE_DETECTOR=m
> CONFIG_HI8435=m
> CONFIG_HX711=m
> CONFIG_INA2XX_ADC=m
> # CONFIG_LTC2471 is not set
> CONFIG_LTC2485=m
> CONFIG_LTC2497=m
> # CONFIG_MAX1027 is not set
> CONFIG_MAX11100=m
> # CONFIG_MAX1118 is not set
> CONFIG_MAX1363=m
> CONFIG_MAX9611=m
> # CONFIG_MCP320X is not set
> CONFIG_MCP3422=m
> # CONFIG_MEN_Z188_ADC is not set
> CONFIG_NAU7802=m
> CONFIG_QCOM_SPMI_IADC=m
> # CONFIG_QCOM_SPMI_VADC is not set
> # CONFIG_SD_ADC_MODULATOR is not set
> # CONFIG_TI_ADC081C is not set
> CONFIG_TI_ADC0832=m
> CONFIG_TI_ADC084S021=m
> CONFIG_TI_ADC12138=m
> # CONFIG_TI_ADC108S102 is not set
> CONFIG_TI_ADC128S052=m
> CONFIG_TI_ADC161S626=m
> # CONFIG_TI_ADS1015 is not set
> CONFIG_TI_ADS7950=m
> # CONFIG_TI_ADS8688 is not set
> CONFIG_TI_AM335X_ADC=m
> CONFIG_TI_TLC4541=m
> CONFIG_VF610_ADC=m
> 
> #
> # Analog Front Ends
> #
> # CONFIG_IIO_RESCALE is not set
> 
> #
> # Amplifiers
> #
> CONFIG_AD8366=m
> 
> #
> # Chemical Sensors
> #
> CONFIG_ATLAS_PH_SENSOR=m
> CONFIG_CCS811=m
> CONFIG_IAQCORE=m
> CONFIG_VZ89X=m
> CONFIG_IIO_CROS_EC_SENSORS_CORE=m
> CONFIG_IIO_CROS_EC_SENSORS=m
> 
> #
> # Hid Sensor IIO Common
> #
> CONFIG_IIO_MS_SENSORS_I2C=m
> 
> #
> # SSP Sensor Common
> #
> CONFIG_IIO_SSP_SENSORS_COMMONS=m
> CONFIG_IIO_SSP_SENSORHUB=m
> CONFIG_IIO_ST_SENSORS_I2C=m
> CONFIG_IIO_ST_SENSORS_SPI=m
> CONFIG_IIO_ST_SENSORS_CORE=m
> 
> #
> # Counters
> #
> 
> #
> # Digital to analog converters
> #
> CONFIG_AD5064=m
> CONFIG_AD5360=m
> CONFIG_AD5380=m
> CONFIG_AD5421=m
> # CONFIG_AD5446 is not set
> CONFIG_AD5449=m
> CONFIG_AD5592R_BASE=m
> CONFIG_AD5592R=m
> CONFIG_AD5593R=m
> CONFIG_AD5504=m
> CONFIG_AD5624R_SPI=m
> # CONFIG_LTC2632 is not set
> CONFIG_AD5686=m
> CONFIG_AD5686_SPI=m
> CONFIG_AD5696_I2C=m
> CONFIG_AD5755=m
> CONFIG_AD5761=m
> CONFIG_AD5764=m
> # CONFIG_AD5791 is not set
> # CONFIG_AD7303 is not set
> CONFIG_CIO_DAC=m
> CONFIG_AD8801=m
> # CONFIG_DPOT_DAC is not set
> CONFIG_DS4424=m
> # CONFIG_M62332 is not set
> CONFIG_MAX517=m
> # CONFIG_MAX5821 is not set
> CONFIG_MCP4725=m
> # CONFIG_MCP4922 is not set
> CONFIG_TI_DAC082S085=m
> # CONFIG_TI_DAC5571 is not set
> # CONFIG_VF610_DAC is not set
> 
> #
> # IIO dummy driver
> #
> CONFIG_IIO_DUMMY_EVGEN=m
> CONFIG_IIO_SIMPLE_DUMMY=m
> CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
> CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
> 
> #
> # Frequency Synthesizers DDS/PLL
> #
> 
> #
> # Clock Generator/Distribution
> #
> # CONFIG_AD9523 is not set
> 
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> CONFIG_ADF4350=m
> 
> #
> # Digital gyroscope sensors
> #
> CONFIG_ADIS16080=m
> CONFIG_ADIS16130=m
> # CONFIG_ADIS16136 is not set
> CONFIG_ADIS16260=m
> # CONFIG_ADXRS450 is not set
> CONFIG_BMG160=m
> CONFIG_BMG160_I2C=m
> CONFIG_BMG160_SPI=m
> CONFIG_MPU3050=m
> CONFIG_MPU3050_I2C=m
> CONFIG_IIO_ST_GYRO_3AXIS=m
> CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
> CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
> CONFIG_ITG3200=m
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> CONFIG_AFE4403=m
> CONFIG_AFE4404=m
> CONFIG_MAX30100=m
> # CONFIG_MAX30102 is not set
> 
> #
> # Humidity sensors
> #
> CONFIG_AM2315=m
> CONFIG_DHT11=m
> # CONFIG_HDC100X is not set
> CONFIG_HTS221=m
> CONFIG_HTS221_I2C=m
> CONFIG_HTS221_SPI=m
> CONFIG_HTU21=m
> CONFIG_SI7005=m
> # CONFIG_SI7020 is not set
> 
> #
> # Inertial measurement units
> #
> # CONFIG_ADIS16400 is not set
> CONFIG_ADIS16480=m
> CONFIG_BMI160=m
> CONFIG_BMI160_I2C=m
> CONFIG_BMI160_SPI=m
> CONFIG_KMX61=m
> # CONFIG_INV_MPU6050_I2C is not set
> # CONFIG_INV_MPU6050_SPI is not set
> # CONFIG_IIO_ST_LSM6DSX is not set
> CONFIG_IIO_ADIS_LIB=m
> CONFIG_IIO_ADIS_LIB_BUFFER=y
> 
> #
> # Light sensors
> #
> # CONFIG_ACPI_ALS is not set
> CONFIG_ADJD_S311=m
> CONFIG_AL3320A=m
> # CONFIG_APDS9300 is not set
> CONFIG_APDS9960=m
> CONFIG_BH1750=m
> # CONFIG_BH1780 is not set
> CONFIG_CM32181=m
> CONFIG_CM3232=m
> # CONFIG_CM3323 is not set
> CONFIG_CM3605=m
> CONFIG_CM36651=m
> CONFIG_IIO_CROS_EC_LIGHT_PROX=m
> CONFIG_GP2AP020A00F=m
> CONFIG_SENSORS_ISL29018=m
> CONFIG_SENSORS_ISL29028=m
> # CONFIG_ISL29125 is not set
> CONFIG_JSA1212=m
> CONFIG_RPR0521=m
> CONFIG_LTR501=m
> CONFIG_LV0104CS=m
> # CONFIG_MAX44000 is not set
> # CONFIG_OPT3001 is not set
> # CONFIG_PA12203001 is not set
> CONFIG_SI1145=m
> # CONFIG_STK3310 is not set
> CONFIG_ST_UVIS25=m
> CONFIG_ST_UVIS25_I2C=m
> CONFIG_ST_UVIS25_SPI=m
> CONFIG_TCS3414=m
> # CONFIG_TCS3472 is not set
> # CONFIG_SENSORS_TSL2563 is not set
> CONFIG_TSL2583=m
> CONFIG_TSL2772=m
> CONFIG_TSL4531=m
> CONFIG_US5182D=m
> CONFIG_VCNL4000=m
> # CONFIG_VEML6070 is not set
> # CONFIG_VL6180 is not set
> CONFIG_ZOPT2201=m
> 
> #
> # Magnetometer sensors
> #
> CONFIG_AK8974=m
> CONFIG_AK8975=m
> CONFIG_AK09911=m
> CONFIG_BMC150_MAGN=m
> # CONFIG_BMC150_MAGN_I2C is not set
> CONFIG_BMC150_MAGN_SPI=m
> # CONFIG_MAG3110 is not set
> CONFIG_MMC35240=m
> CONFIG_IIO_ST_MAGN_3AXIS=m
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
> CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
> CONFIG_SENSORS_HMC5843=m
> CONFIG_SENSORS_HMC5843_I2C=m
> # CONFIG_SENSORS_HMC5843_SPI is not set
> 
> #
> # Multiplexers
> #
> CONFIG_IIO_MUX=m
> 
> #
> # Inclinometer sensors
> #
> 
> #
> # Triggers - standalone
> #
> CONFIG_IIO_INTERRUPT_TRIGGER=m
> CONFIG_IIO_SYSFS_TRIGGER=m
> 
> #
> # Digital potentiometers
> #
> # CONFIG_AD5272 is not set
> CONFIG_DS1803=m
> # CONFIG_MAX5481 is not set
> # CONFIG_MAX5487 is not set
> CONFIG_MCP4018=m
> # CONFIG_MCP4131 is not set
> CONFIG_MCP4531=m
> CONFIG_TPL0102=m
> 
> #
> # Digital potentiostats
> #
> CONFIG_LMP91000=m
> 
> #
> # Pressure sensors
> #
> CONFIG_ABP060MG=m
> CONFIG_BMP280=m
> CONFIG_BMP280_I2C=m
> CONFIG_BMP280_SPI=m
> # CONFIG_IIO_CROS_EC_BARO is not set
> CONFIG_HP03=m
> CONFIG_MPL115=m
> CONFIG_MPL115_I2C=m
> CONFIG_MPL115_SPI=m
> CONFIG_MPL3115=m
> CONFIG_MS5611=m
> # CONFIG_MS5611_I2C is not set
> # CONFIG_MS5611_SPI is not set
> # CONFIG_MS5637 is not set
> CONFIG_IIO_ST_PRESS=m
> CONFIG_IIO_ST_PRESS_I2C=m
> CONFIG_IIO_ST_PRESS_SPI=m
> # CONFIG_T5403 is not set
> CONFIG_HP206C=m
> # CONFIG_ZPA2326 is not set
> 
> #
> # Lightning sensors
> #
> CONFIG_AS3935=m
> 
> #
> # Proximity and distance sensors
> #
> CONFIG_LIDAR_LITE_V2=m
> CONFIG_RFD77402=m
> # CONFIG_SRF04 is not set
> CONFIG_SX9500=m
> # CONFIG_SRF08 is not set
> 
> #
> # Resolver to digital converters
> #
> CONFIG_AD2S1200=m
> 
> #
> # Temperature sensors
> #
> CONFIG_MAXIM_THERMOCOUPLE=m
> # CONFIG_MLX90614 is not set
> CONFIG_MLX90632=m
> CONFIG_TMP006=m
> CONFIG_TMP007=m
> CONFIG_TSYS01=m
> CONFIG_TSYS02D=m
> CONFIG_NTB=m
> CONFIG_NTB_AMD=m
> # CONFIG_NTB_IDT is not set
> CONFIG_NTB_INTEL=m
> CONFIG_NTB_SWITCHTEC=m
> # CONFIG_NTB_PINGPONG is not set
> CONFIG_NTB_TOOL=m
> CONFIG_NTB_PERF=m
> CONFIG_NTB_TRANSPORT=m
> # CONFIG_VME_BUS is not set
> # CONFIG_PWM is not set
> 
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=y
> CONFIG_ARM_GIC_MAX_NR=1
> # CONFIG_IPACK_BUS is not set
> CONFIG_RESET_CONTROLLER=y
> CONFIG_RESET_TI_SYSCON=m
> # CONFIG_FMC is not set
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> # CONFIG_BCM_KONA_USB2_PHY is not set
> CONFIG_PHY_PXA_28NM_HSIC=m
> CONFIG_PHY_PXA_28NM_USB2=y
> # CONFIG_PHY_CPCAP_USB is not set
> # CONFIG_PHY_MAPPHONE_MDM6600 is not set
> # CONFIG_POWERCAP is not set
> CONFIG_MCB=m
> CONFIG_MCB_PCI=m
> # CONFIG_MCB_LPC is not set
> 
> #
> # Performance monitor support
> #
> # CONFIG_RAS is not set
> # CONFIG_THUNDERBOLT is not set
> 
> #
> # Android
> #
> CONFIG_ANDROID=y
> # CONFIG_ANDROID_BINDER_IPC is not set
> # CONFIG_LIBNVDIMM is not set
> CONFIG_DAX=y
> CONFIG_DEV_DAX=m
> CONFIG_NVMEM=y
> 
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> CONFIG_INTEL_TH=y
> CONFIG_INTEL_TH_PCI=y
> CONFIG_INTEL_TH_ACPI=m
> CONFIG_INTEL_TH_GTH=m
> CONFIG_INTEL_TH_MSU=y
> CONFIG_INTEL_TH_PTI=m
> # CONFIG_INTEL_TH_DEBUG is not set
> # CONFIG_FPGA is not set
> # CONFIG_FSI is not set
> CONFIG_MULTIPLEXER=m
> 
> #
> # Multiplexer drivers
> #
> CONFIG_MUX_ADG792A=m
> # CONFIG_MUX_GPIO is not set
> CONFIG_MUX_MMIO=m
> # CONFIG_UNISYS_VISORBUS is not set
> CONFIG_SIOX=m
> CONFIG_SIOX_BUS_GPIO=m
> CONFIG_SLIMBUS=y
> CONFIG_SLIM_QCOM_CTRL=m
> 
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> # CONFIG_FIRMWARE_MEMMAP is not set
> # CONFIG_DELL_RBU is not set
> # CONFIG_DCDBAS is not set
> # CONFIG_DMIID is not set
> CONFIG_DMI_SYSFS=y
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> CONFIG_ISCSI_IBFT_FIND=y
> # CONFIG_FW_CFG_SYSFS is not set
> CONFIG_GOOGLE_FIRMWARE=y
> CONFIG_GOOGLE_COREBOOT_TABLE=m
> CONFIG_GOOGLE_COREBOOT_TABLE_ACPI=m
> CONFIG_GOOGLE_COREBOOT_TABLE_OF=m
> CONFIG_GOOGLE_MEMCONSOLE=y
> CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=y
> CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=m
> CONFIG_GOOGLE_VPD=m
> CONFIG_UEFI_CPER=y
> CONFIG_UEFI_CPER_X86=y
> 
> #
> # Tegra firmware driver
> #
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> CONFIG_FS_IOMAP=y
> CONFIG_EXT2_FS=m
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT2_FS_SECURITY=y
> # CONFIG_EXT3_FS is not set
> # CONFIG_EXT4_FS is not set
> CONFIG_FS_MBCACHE=m
> # CONFIG_REISERFS_FS is not set
> CONFIG_JFS_FS=y
> CONFIG_JFS_POSIX_ACL=y
> CONFIG_JFS_SECURITY=y
> CONFIG_JFS_DEBUG=y
> # CONFIG_JFS_STATISTICS is not set
> CONFIG_XFS_FS=y
> # CONFIG_XFS_QUOTA is not set
> # CONFIG_XFS_POSIX_ACL is not set
> CONFIG_XFS_RT=y
> CONFIG_XFS_ONLINE_SCRUB=y
> # CONFIG_XFS_ONLINE_REPAIR is not set
> CONFIG_XFS_WARN=y
> # CONFIG_XFS_DEBUG is not set
> CONFIG_GFS2_FS=y
> # CONFIG_OCFS2_FS is not set
> # CONFIG_BTRFS_FS is not set
> CONFIG_NILFS2_FS=y
> CONFIG_F2FS_FS=m
> # CONFIG_F2FS_STAT_FS is not set
> CONFIG_F2FS_FS_XATTR=y
> CONFIG_F2FS_FS_POSIX_ACL=y
> # CONFIG_F2FS_FS_SECURITY is not set
> CONFIG_F2FS_CHECK_FS=y
> # CONFIG_F2FS_FS_ENCRYPTION is not set
> CONFIG_F2FS_FAULT_INJECTION=y
> # CONFIG_FS_DAX is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_MANDATORY_FILE_LOCKING=y
> CONFIG_FS_ENCRYPTION=y
> CONFIG_FSNOTIFY=y
> # CONFIG_DNOTIFY is not set
> CONFIG_INOTIFY_USER=y
> # CONFIG_FANOTIFY is not set
> # CONFIG_QUOTA is not set
> # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> CONFIG_QUOTACTL=y
> CONFIG_QUOTACTL_COMPAT=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=m
> CONFIG_CUSE=m
> # CONFIG_OVERLAY_FS is not set
> 
> #
> # Caches
> #
> CONFIG_FSCACHE=m
> # CONFIG_FSCACHE_STATS is not set
> # CONFIG_FSCACHE_HISTOGRAM is not set
> CONFIG_FSCACHE_DEBUG=y
> # CONFIG_FSCACHE_OBJECT_LIST is not set
> CONFIG_CACHEFILES=m
> # CONFIG_CACHEFILES_DEBUG is not set
> # CONFIG_CACHEFILES_HISTOGRAM is not set
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_UDF_FS=m
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> # CONFIG_MSDOS_FS is not set
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> CONFIG_NTFS_FS=y
> CONFIG_NTFS_DEBUG=y
> # CONFIG_NTFS_RW is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> # CONFIG_PROC_KCORE is not set
> CONFIG_PROC_VMCORE=y
> # CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_PROC_CHILDREN=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> # CONFIG_TMPFS_XATTR is not set
> # CONFIG_HUGETLBFS is not set
> CONFIG_MEMFD_CREATE=y
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> CONFIG_CONFIGFS_FS=y
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_ORANGEFS_FS=m
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ECRYPT_FS is not set
> CONFIG_HFS_FS=m
> CONFIG_HFSPLUS_FS=y
> # CONFIG_HFSPLUS_FS_POSIX_ACL is not set
> CONFIG_BEFS_FS=m
> CONFIG_BEFS_DEBUG=y
> # CONFIG_BFS_FS is not set
> CONFIG_EFS_FS=m
> # CONFIG_CRAMFS is not set
> CONFIG_SQUASHFS=m
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=y
> # CONFIG_SQUASHFS_DECOMP_SINGLE is not set
> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> CONFIG_SQUASHFS_LZ4=y
> CONFIG_SQUASHFS_LZO=y
> CONFIG_SQUASHFS_XZ=y
> CONFIG_SQUASHFS_ZSTD=y
> CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
> CONFIG_SQUASHFS_EMBEDDED=y
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> CONFIG_VXFS_FS=m
> CONFIG_MINIX_FS=y
> CONFIG_OMFS_FS=y
> CONFIG_HPFS_FS=m
> CONFIG_QNX4FS_FS=m
> # CONFIG_QNX6FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_PSTORE=y
> CONFIG_PSTORE_DEFLATE_COMPRESS=m
> # CONFIG_PSTORE_LZO_COMPRESS is not set
> CONFIG_PSTORE_LZ4_COMPRESS=y
> # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> # CONFIG_PSTORE_842_COMPRESS is not set
> CONFIG_PSTORE_COMPRESS=y
> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
> # CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
> CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
> # CONFIG_PSTORE_CONSOLE is not set
> CONFIG_PSTORE_PMSG=y
> # CONFIG_PSTORE_RAM is not set
> # CONFIG_SYSV_FS is not set
> CONFIG_UFS_FS=y
> # CONFIG_UFS_FS_WRITE is not set
> CONFIG_UFS_DEBUG=y
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=m
> # CONFIG_NFS_SWAP is not set
> # CONFIG_NFS_V4_1 is not set
> # CONFIG_ROOT_NFS is not set
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> # CONFIG_NFSD is not set
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=m
> CONFIG_RPCSEC_GSS_KRB5=m
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_CEPH_FS is not set
> CONFIG_CIFS=m
> # CONFIG_CIFS_STATS is not set
> # CONFIG_CIFS_WEAK_PW_HASH is not set
> # CONFIG_CIFS_UPCALL is not set
> # CONFIG_CIFS_XATTR is not set
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> # CONFIG_CIFS_DFS_UPCALL is not set
> # CONFIG_CIFS_SMB311 is not set
> # CONFIG_CIFS_FSCACHE is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=m
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> CONFIG_NLS_CODEPAGE_855=m
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> CONFIG_NLS_CODEPAGE_862=y
> CONFIG_NLS_CODEPAGE_863=y
> CONFIG_NLS_CODEPAGE_864=m
> CONFIG_NLS_CODEPAGE_865=y
> # CONFIG_NLS_CODEPAGE_866 is not set
> CONFIG_NLS_CODEPAGE_869=m
> CONFIG_NLS_CODEPAGE_936=y
> # CONFIG_NLS_CODEPAGE_950 is not set
> CONFIG_NLS_CODEPAGE_932=y
> # CONFIG_NLS_CODEPAGE_949 is not set
> CONFIG_NLS_CODEPAGE_874=y
> CONFIG_NLS_ISO8859_8=y
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ASCII is not set
> CONFIG_NLS_ISO8859_1=y
> CONFIG_NLS_ISO8859_2=y
> CONFIG_NLS_ISO8859_3=m
> CONFIG_NLS_ISO8859_4=y
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> CONFIG_NLS_ISO8859_9=y
> # CONFIG_NLS_ISO8859_13 is not set
> CONFIG_NLS_ISO8859_14=m
> CONFIG_NLS_ISO8859_15=m
> CONFIG_NLS_KOI8_R=m
> CONFIG_NLS_KOI8_U=m
> CONFIG_NLS_MAC_ROMAN=m
> CONFIG_NLS_MAC_CELTIC=y
> # CONFIG_NLS_MAC_CENTEURO is not set
> CONFIG_NLS_MAC_CROATIAN=m
> # CONFIG_NLS_MAC_CYRILLIC is not set
> CONFIG_NLS_MAC_GAELIC=m
> CONFIG_NLS_MAC_GREEK=m
> CONFIG_NLS_MAC_ICELAND=y
> # CONFIG_NLS_MAC_INUIT is not set
> CONFIG_NLS_MAC_ROMANIAN=m
> CONFIG_NLS_MAC_TURKISH=y
> CONFIG_NLS_UTF8=y
> # CONFIG_DLM is not set
> 
> #
> # Kernel hacking
> #
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_DYNAMIC_DEBUG is not set
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_DEBUG_INFO_DWARF4=y
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_ENABLE_WARN_DEPRECATED=y
> # CONFIG_ENABLE_MUST_CHECK is not set
> CONFIG_FRAME_WARN=2048
> # CONFIG_STRIP_ASM_SYMS is not set
> CONFIG_READABLE_ASM=y
> CONFIG_UNUSED_SYMBOLS=y
> CONFIG_PAGE_OWNER=y
> CONFIG_DEBUG_FS=y
> CONFIG_HEADERS_CHECK=y
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_FRAME_POINTER=y
> CONFIG_STACK_VALIDATION=y
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_DEBUG_KERNEL=y
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_PAGE_POISONING is not set
> CONFIG_DEBUG_RODATA_TEST=y
> CONFIG_DEBUG_OBJECTS=y
> # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
> CONFIG_DEBUG_OBJECTS_FREE=y
> CONFIG_DEBUG_OBJECTS_TIMERS=y
> # CONFIG_DEBUG_OBJECTS_WORK is not set
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> CONFIG_DEBUG_STACK_USAGE=y
> # CONFIG_DEBUG_VM is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_MEMORY_INIT=y
> CONFIG_DEBUG_PER_CPU_MAPS=y
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_KCOV is not set
> CONFIG_DEBUG_SHIRQ=y
> 
> #
> # Debug Lockups and Hangs
> #
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> CONFIG_HARDLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
> CONFIG_WQ_WATCHDOG=y
> CONFIG_PANIC_ON_OOPS=y
> CONFIG_PANIC_ON_OOPS_VALUE=1
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_SCHED_DEBUG=y
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_SCHED_STACK_END_CHECK is not set
> # CONFIG_DEBUG_TIMEKEEPING is not set
> # CONFIG_DEBUG_PREEMPT is not set
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> CONFIG_PROVE_LOCKING=y
> # CONFIG_LOCK_STAT is not set
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> CONFIG_DEBUG_LOCKDEP=y
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> CONFIG_LOCK_TORTURE_TEST=m
> # CONFIG_WW_MUTEX_SELFTEST is not set
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_STACKTRACE=y
> CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
> # CONFIG_DEBUG_KOBJECT is not set
> # CONFIG_DEBUG_KOBJECT_RELEASE is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> CONFIG_DEBUG_LIST=y
> # CONFIG_DEBUG_PI_LIST is not set
> CONFIG_DEBUG_SG=y
> CONFIG_DEBUG_NOTIFIERS=y
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> CONFIG_PROVE_RCU=y
> CONFIG_TORTURE_TEST=y
> CONFIG_RCU_PERF_TEST=y
> CONFIG_RCU_TORTURE_TEST=m
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
> CONFIG_NOTIFIER_ERROR_INJECTION=y
> # CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
> # CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
> # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
> CONFIG_FAULT_INJECTION=y
> # CONFIG_FAIL_PAGE_ALLOC is not set
> # CONFIG_FAIL_MAKE_REQUEST is not set
> CONFIG_FAIL_IO_TIMEOUT=y
> CONFIG_FAIL_FUTEX=y
> CONFIG_FAULT_INJECTION_DEBUG_FS=y
> # CONFIG_FAIL_MMC_REQUEST is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_FENTRY=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACING_SUPPORT=y
> # CONFIG_FTRACE is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_RUNTIME_TESTING_MENU is not set
> CONFIG_MEMTEST=y
> CONFIG_BUG_ON_DATA_CORRUPTION=y
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> # CONFIG_UBSAN is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> CONFIG_EARLY_PRINTK_USB=y
> CONFIG_X86_VERBOSE_BOOTUP=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_EARLY_PRINTK_DBGP=y
> # CONFIG_EARLY_PRINTK_USB_XDBC is not set
> CONFIG_X86_PTDUMP_CORE=y
> CONFIG_X86_PTDUMP=m
> CONFIG_DEBUG_WX=y
> CONFIG_DOUBLEFAULT=y
> CONFIG_DEBUG_TLBFLUSH=y
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> CONFIG_IO_DELAY_TYPE_0X80=0
> CONFIG_IO_DELAY_TYPE_0XED=1
> CONFIG_IO_DELAY_TYPE_UDELAY=2
> CONFIG_IO_DELAY_TYPE_NONE=3
> # CONFIG_IO_DELAY_0X80 is not set
> CONFIG_IO_DELAY_0XED=y
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEFAULT_IO_DELAY_TYPE=1
> CONFIG_DEBUG_BOOT_PARAMS=y
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_OPTIMIZE_INLINING is not set
> # CONFIG_DEBUG_ENTRY is not set
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> # CONFIG_X86_DEBUG_FPU is not set
> CONFIG_PUNIT_ATOM_DEBUG=m
> # CONFIG_UNWINDER_ORC is not set
> CONFIG_UNWINDER_FRAME_POINTER=y
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> CONFIG_KEYS_COMPAT=y
> # CONFIG_PERSISTENT_KEYRINGS is not set
> CONFIG_BIG_KEYS=y
> CONFIG_TRUSTED_KEYS=m
> CONFIG_ENCRYPTED_KEYS=y
> CONFIG_KEY_DH_OPERATIONS=y
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=y
> CONFIG_SECURITYFS=y
> # CONFIG_SECURITY_NETWORK is not set
> CONFIG_PAGE_TABLE_ISOLATION=y
> # CONFIG_SECURITY_PATH is not set
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> CONFIG_SECURITY_LOADPIN=y
> # CONFIG_SECURITY_LOADPIN_ENABLED is not set
> CONFIG_SECURITY_YAMA=y
> # CONFIG_INTEGRITY is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_DEFAULT_SECURITY=""
> CONFIG_XOR_BLOCKS=m
> CONFIG_ASYNC_CORE=m
> CONFIG_ASYNC_MEMCPY=m
> CONFIG_ASYNC_XOR=m
> CONFIG_ASYNC_PQ=m
> CONFIG_ASYNC_RAID6_RECOV=m
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_BLKCIPHER=y
> CONFIG_CRYPTO_BLKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> CONFIG_CRYPTO_ECDH=m
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_PCRYPT=y
> CONFIG_CRYPTO_WORKQUEUE=y
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_MCRYPTD=y
> CONFIG_CRYPTO_AUTHENC=y
> CONFIG_CRYPTO_TEST=m
> CONFIG_CRYPTO_SIMD=y
> CONFIG_CRYPTO_GLUE_HELPER_X86=y
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=m
> CONFIG_CRYPTO_GCM=y
> CONFIG_CRYPTO_CHACHA20POLY1305=y
> CONFIG_CRYPTO_AEGIS128=y
> # CONFIG_CRYPTO_AEGIS128L is not set
> CONFIG_CRYPTO_AEGIS256=m
> CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=m
> # CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
> # CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
> CONFIG_CRYPTO_MORUS640=m
> # CONFIG_CRYPTO_MORUS640_SSE2 is not set
> CONFIG_CRYPTO_MORUS1280=y
> CONFIG_CRYPTO_MORUS1280_GLUE=m
> CONFIG_CRYPTO_MORUS1280_SSE2=m
> CONFIG_CRYPTO_MORUS1280_AVX2=m
> CONFIG_CRYPTO_SEQIV=y
> # CONFIG_CRYPTO_ECHAINIV is not set
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> # CONFIG_CRYPTO_CFB is not set
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_LRW=m
> # CONFIG_CRYPTO_PCBC is not set
> CONFIG_CRYPTO_XTS=y
> CONFIG_CRYPTO_KEYWRAP=y
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=m
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_XCBC=y
> CONFIG_CRYPTO_VMAC=m
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=y
> CONFIG_CRYPTO_CRC32=m
> CONFIG_CRYPTO_CRC32_PCLMUL=m
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_POLY1305=y
> # CONFIG_CRYPTO_POLY1305_X86_64 is not set
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MD5=m
> CONFIG_CRYPTO_MICHAEL_MIC=m
> CONFIG_CRYPTO_RMD128=m
> # CONFIG_CRYPTO_RMD160 is not set
> CONFIG_CRYPTO_RMD256=y
> # CONFIG_CRYPTO_RMD320 is not set
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA1_SSSE3=m
> CONFIG_CRYPTO_SHA256_SSSE3=m
> # CONFIG_CRYPTO_SHA512_SSSE3 is not set
> CONFIG_CRYPTO_SHA1_MB=y
> CONFIG_CRYPTO_SHA256_MB=m
> # CONFIG_CRYPTO_SHA512_MB is not set
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=m
> CONFIG_CRYPTO_SHA3=m
> CONFIG_CRYPTO_SM3=y
> CONFIG_CRYPTO_TGR192=y
> CONFIG_CRYPTO_WP512=y
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> # CONFIG_CRYPTO_AES_TI is not set
> CONFIG_CRYPTO_AES_X86_64=y
> # CONFIG_CRYPTO_AES_NI_INTEL is not set
> # CONFIG_CRYPTO_ANUBIS is not set
> CONFIG_CRYPTO_ARC4=m
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_BLOWFISH_COMMON=m
> CONFIG_CRYPTO_BLOWFISH_X86_64=m
> # CONFIG_CRYPTO_CAMELLIA is not set
> CONFIG_CRYPTO_CAMELLIA_X86_64=y
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> # CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_DES3_EDE_X86_64=y
> # CONFIG_CRYPTO_FCRYPT is not set
> CONFIG_CRYPTO_KHAZAD=m
> # CONFIG_CRYPTO_SALSA20 is not set
> CONFIG_CRYPTO_CHACHA20=y
> CONFIG_CRYPTO_CHACHA20_X86_64=y
> CONFIG_CRYPTO_SEED=m
> CONFIG_CRYPTO_SERPENT=y
> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
> CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
> # CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
> CONFIG_CRYPTO_SM4=m
> CONFIG_CRYPTO_SPECK=m
> CONFIG_CRYPTO_TEA=y
> CONFIG_CRYPTO_TWOFISH=m
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> CONFIG_CRYPTO_TWOFISH_X86_64=y
> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=m
> CONFIG_CRYPTO_LZO=y
> CONFIG_CRYPTO_842=m
> CONFIG_CRYPTO_LZ4=y
> CONFIG_CRYPTO_LZ4HC=m
> CONFIG_CRYPTO_ZSTD=y
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=y
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> CONFIG_CRYPTO_DRBG_HASH=y
> CONFIG_CRYPTO_DRBG_CTR=y
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> CONFIG_CRYPTO_HASH_INFO=y
> # CONFIG_CRYPTO_HW is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> CONFIG_PKCS7_MESSAGE_PARSER=y
> 
> #
> # Certificates for signature checking
> #
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
> CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
> CONFIG_SECONDARY_TRUSTED_KEYRING=y
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> CONFIG_HAVE_KVM=y
> # CONFIG_VIRTUALIZATION is not set
> 
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=m
> CONFIG_BITREVERSE=y
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> # CONFIG_CRC_CCITT is not set
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> CONFIG_CRC32_SELFTEST=y
> # CONFIG_CRC32_SLICEBY8 is not set
> CONFIG_CRC32_SLICEBY4=y
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC4=y
> CONFIG_CRC7=m
> CONFIG_LIBCRC32C=y
> # CONFIG_CRC8 is not set
> CONFIG_XXHASH=y
> CONFIG_RANDOM32_SELFTEST=y
> CONFIG_842_COMPRESS=m
> CONFIG_842_DECOMPRESS=m
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=m
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=y
> CONFIG_LZ4HC_COMPRESS=m
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> # CONFIG_XZ_DEC_X86 is not set
> # CONFIG_XZ_DEC_POWERPC is not set
> # CONFIG_XZ_DEC_IA64 is not set
> # CONFIG_XZ_DEC_ARM is not set
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_BCJ=y
> CONFIG_XZ_DEC_TEST=m
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_RADIX_TREE_MULTIORDER=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_SGL_ALLOC=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_IOMMU_HELPER=y
> CONFIG_DMA_DIRECT_OPS=y
> CONFIG_SWIOTLB=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_CPUMASK_OFFSTACK=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_CORDIC=m
> # CONFIG_DDR is not set
> # CONFIG_IRQ_POLL is not set
> CONFIG_MPILIB=y
> CONFIG_LIBFDT=y
> CONFIG_OID_REGISTRY=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_HAS_SG_CHAIN=y
> CONFIG_ARCH_HAS_PMEM_API=y
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
> CONFIG_STACKDEPOT=y
> CONFIG_SBITMAP=y
> CONFIG_PRIME_NUMBERS=m
> CONFIG_STRING_SELFTEST=y

> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='boot'
> 	export testcase='boot'
> 	export timeout='10m'
> 	export job_origin='/lkp/lkp/src/jobs/boot.yaml'
> 	export queue='bisect'
> 	export testbox='vm-lkp-wsx03-quantal-x86_64-14'
> 	export tbox_group='vm-lkp-wsx03-quantal-x86_64'
> 	export branch='linux-devel/devel-catchup-201806280754'
> 	export commit='e46874dd99fa8ef78802bee8e80fe2844ae95cd1'
> 	export kconfig='x86_64-randconfig-s5-06280653'
> 	export submit_id='5b35e6fc0b9a935f4b3c1ffd'
> 	export job_file='/lkp/scheduled/vm-lkp-wsx03-quantal-x86_64-14/boot-1-quantal-core-x86_64.cgz-e46874dd99fa8ef78802bee8e80fe2844ae95cd1-20180629-89931-fepxne-0.yaml'
> 	export id='32a0c0836269b0e3a42770e0c7c1b96df2eff98e'
> 	export model='qemu-system-x86_64 -enable-kvm -cpu Haswell,+smep,+smap'
> 	export nr_vm=32
> 	export nr_cpu=2
> 	export memory='512M'
> 	export rootfs='quantal-core-x86_64.cgz'
> 	export need_kconfig='CONFIG_KVM_GUEST=y'
> 	export compiler='gcc-7'
> 	export enqueue_time='2018-06-29 15:59:56 +0800'
> 	export _id='5b35e6fc0b9a935f4b3c1ffd'
> 	export _rt='/result/boot/1/vm-lkp-wsx03-quantal-x86_64/quantal-core-x86_64.cgz/x86_64-randconfig-s5-06280653/gcc-7/e46874dd99fa8ef78802bee8e80fe2844ae95cd1'
> 	export user='lkp'
> 	export result_root='/result/boot/1/vm-lkp-wsx03-quantal-x86_64/quantal-core-x86_64.cgz/x86_64-randconfig-s5-06280653/gcc-7/e46874dd99fa8ef78802bee8e80fe2844ae95cd1/0'
> 	export LKP_SERVER='inn'
> 	export max_uptime=600
> 	export initrd='/osimage/quantal/quantal-core-x86_64.cgz'
> 	export bootloader_append='root=/dev/ram0
> user=lkp
> job=/lkp/scheduled/vm-lkp-wsx03-quantal-x86_64-14/boot-1-quantal-core-x86_64.cgz-e46874dd99fa8ef78802bee8e80fe2844ae95cd1-20180629-89931-fepxne-0.yaml
> ARCH=x86_64
> kconfig=x86_64-randconfig-s5-06280653
> branch=linux-devel/devel-catchup-201806280754
> commit=e46874dd99fa8ef78802bee8e80fe2844ae95cd1
> BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s5-06280653/gcc-7/e46874dd99fa8ef78802bee8e80fe2844ae95cd1/vmlinuz-4.18.0-rc1-00121-ge46874d
> max_uptime=600
> RESULT_ROOT=/result/boot/1/vm-lkp-wsx03-quantal-x86_64/quantal-core-x86_64.cgz/x86_64-randconfig-s5-06280653/gcc-7/e46874dd99fa8ef78802bee8e80fe2844ae95cd1/0
> LKP_SERVER=inn
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export modules_initrd='/pkg/linux/x86_64-randconfig-s5-06280653/gcc-7/e46874dd99fa8ef78802bee8e80fe2844ae95cd1/modules.cgz'
> 	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export kernel='/pkg/linux/x86_64-randconfig-s5-06280653/gcc-7/e46874dd99fa8ef78802bee8e80fe2844ae95cd1/vmlinuz-4.18.0-rc1-00121-ge46874d'
> 	export dequeue_time='2018-06-29 16:32:05 +0800'
> 	export job_initrd='/lkp/scheduled/vm-lkp-wsx03-quantal-x86_64-14/boot-1-quantal-core-x86_64.cgz-e46874dd99fa8ef78802bee8e80fe2844ae95cd1-20180629-89931-fepxne-0.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	run_test $LKP_SRC/tests/wrapper sleep 1
> }
> 
> extract_stats()
> {
> 	$LKP_SRC/stats/wrapper boot-slabinfo
> 	$LKP_SRC/stats/wrapper boot-meminfo
> 	$LKP_SRC/stats/wrapper memmap
> 	$LKP_SRC/stats/wrapper boot-memory
> 	$LKP_SRC/stats/wrapper boot-time
> 	$LKP_SRC/stats/wrapper kernel-size
> 	$LKP_SRC/stats/wrapper kmsg
> 
> 	$LKP_SRC/stats/wrapper time sleep.time
> 	$LKP_SRC/stats/wrapper time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper last_state
> }
> 
> "$@"


