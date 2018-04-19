Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752972AbeDSDDl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 23:03:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:45552 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752159AbeDSDDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 23:03:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="scan'208";a="43003378"
Date: Thu, 19 Apr 2018 11:03:29 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Phil Sutter <phil@nwl.cc>
Cc: Thomas Graf <tgraf@suug.ch>, Daniel Borkmann <daniel@iogearbox.net>,
        Florian Westphal <fw@strlen.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
        lkp@01.org
Subject: [test_rhashtable] WARNING: suspicious RCU usage
Message-ID: <20180419030329.mvt3nhq263be4xtp@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="o4bgh4uvgwqptlb4"
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o4bgh4uvgwqptlb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

FYI this happens in mainline kernel 4.17.0-rc1.
It at least dates back to v4.1 .

[    7.767898] test if its possible to exceed max_size 8192: no, ok
[    7.768365] Average test time: 234002708
[    7.768638] test inserting duplicates
[    7.768907]
[    7.769018] =============================
[    7.769297] WARNING: suspicious RCU usage
[    7.769576] 4.17.0-rc1 #46 Not tainted
[    7.769836] -----------------------------
[    7.770129] lib/test_rhashtable.c:502 suspicious rcu_dereference_protected() usage!
[    7.770752]
[    7.770752] other info that might help us debug this:
[    7.770752]
[    7.771298]
[    7.771298] rcu_scheduler_active = 2, debug_locks = 1
[    7.771743] no locks held by swapper/1.
[    7.772011]
[    7.772011] stack backtrace:
[    7.772319] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc1 #46
[    7.772739] Call Trace:
[    7.772925]  ? print_ht+0x66/0x25c:
						print_ht at lib/test_rhashtable.c:502 (discriminator 7)
[    7.773167]  ? test_insert_dup+0x565/0x5d7:
						test_insert_dup at lib/test_rhashtable.c:570
[    7.773462]  ? my_hashfn+0x10/0x10:
						my_cmpfn at lib/test_rhashtable.c:94
[    7.773706]  ? kstrtoll_from_user+0x69/0x69:
						jhash at include/linux/jhash.h:76
[    7.773999]  ? jhash+0x125/0x125:
						jhash2 at include/linux/jhash.h:121
						 (inlined by) rhashtable_jhash2 at lib/rhashtable.c:932
						
						jhash+0x125/0x125:
						my_hashfn at lib/test_rhashtable.c:86
[    7.774224]  ? my_hashfn+0x10/0x10:
						my_cmpfn at lib/test_rhashtable.c:94
[    7.774462]  ? rhashtable_rehash_alloc+0x63/0x63:
						rht_deferred_worker at lib/rhashtable.c:413
[    7.774780]  ? test_rht_init+0x2ae/0x561:
						test_insert_duplicates_run at lib/test_rhashtable.c:593 (discriminator 260)
						 (inlined by) test_rht_init at lib/test_rhashtable.c:748 (discriminator 260)
[    7.775060]  ? test_rhashtable+0x634/0x634
[    7.775413]  ? do_one_initcall+0x66/0x14f:
						do_trace_initcall_finish at init/main.c:867
						 (inlined by) do_one_initcall at init/main.c:884
[    7.775691]  ? do_early_param+0x70/0x70:
						repair_env_string at init/main.c:251
[    7.775980]  ? kernel_init_freeable+0xd6/0x173:
						do_initcall_level at init/main.c:950
						 (inlined by) do_initcalls at init/main.c:959
						 (inlined by) do_basic_setup at init/main.c:977
						 (inlined by) kernel_init_freeable at init/main.c:1127
[    7.776287]  ? kernel_init_freeable+0xec/0x173:
						do_initcall_level at init/main.c:950
						 (inlined by) do_initcalls at init/main.c:959
						 (inlined by) do_basic_setup at init/main.c:977
						 (inlined by) kernel_init_freeable at init/main.c:1127
[    7.776595]  ? rest_init+0x107/0x107:
						kernel_init at init/main.c:1053
[    7.776853]  ? kernel_init+0x5/0xc7:
						kernel_init at init/main.c:1055
[    7.777104]  ? ret_from_fork+0x2e/0x38:
						ret_from_fork at arch/x86/entry/entry_32.S:311
[    7.777364]
[    7.777474] =============================
[    7.777750] WARNING: suspicious RCU usage
[    7.778031] 4.17.0-rc1 #46 Not tainted
[    7.778290] -----------------------------
[    7.778566] lib/test_rhashtable.c:507 suspicious rcu_dereference_protected() usage!
[    7.779191]
[    7.779191] other info that might help us debug this:
[    7.779191]
[    7.779732]
[    7.779732] rcu_scheduler_active = 2, debug_locks = 1
[    7.780190] no locks held by swapper/1.
[    7.780456]
[    7.780456] stack backtrace:
[    7.780756] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc1 #46
[    7.781179] Call Trace:
[    7.781355]  ? print_ht+0xb2/0x25c:
						print_ht at lib/test_rhashtable.c:507 (discriminator 7)
[    7.781595]  ? test_insert_dup+0x565/0x5d7:
						test_insert_dup at lib/test_rhashtable.c:570
[    7.781878]  ? my_hashfn+0x10/0x10:
						my_cmpfn at lib/test_rhashtable.c:94
[    7.782120]  ? kstrtoll_from_user+0x69/0x69:
						jhash at include/linux/jhash.h:76
[    7.782409]  ? jhash+0x125/0x125:
						jhash2 at include/linux/jhash.h:121
						 (inlined by) rhashtable_jhash2 at lib/rhashtable.c:932
						
						jhash+0x125/0x125:
						my_hashfn at lib/test_rhashtable.c:86
[    7.782633]  ? my_hashfn+0x10/0x10:
						my_cmpfn at lib/test_rhashtable.c:94
[    7.782871]  ? rhashtable_rehash_alloc+0x63/0x63:
						rht_deferred_worker at lib/rhashtable.c:413
[    7.783192]  ? test_rht_init+0x2ae/0x561:
						test_insert_duplicates_run at lib/test_rhashtable.c:593 (discriminator 260)
						 (inlined by) test_rht_init at lib/test_rhashtable.c:748 (discriminator 260)
[    7.783472]  ? test_rhashtable+0x634/0x634
[    7.783824]  ? do_one_initcall+0x66/0x14f:
						do_trace_initcall_finish at init/main.c:867
						 (inlined by) do_one_initcall at init/main.c:884
[    7.784105]  ? do_early_param+0x70/0x70:
						repair_env_string at init/main.c:251
[    7.784371]  ? kernel_init_freeable+0xd6/0x173:
						do_initcall_level at init/main.c:950
						 (inlined by) do_initcalls at init/main.c:959
						 (inlined by) do_basic_setup at init/main.c:977
						 (inlined by) kernel_init_freeable at init/main.c:1127
[    7.784677]  ? kernel_init_freeable+0xec/0x173:
						do_initcall_level at init/main.c:950
						 (inlined by) do_initcalls at init/main.c:959
						 (inlined by) do_basic_setup at init/main.c:977
						 (inlined by) kernel_init_freeable at init/main.c:1127
[    7.784988]  ? rest_init+0x107/0x107:
						kernel_init at init/main.c:1053
[    7.785237]  ? kernel_init+0x5/0xc7:
						kernel_init at init/main.c:1055
[    7.785480]  ? ret_from_fork+0x2e/0x38:
						ret_from_fork at arch/x86/entry/entry_32.S:311
[    7.785739]
[    7.785849] =============================
[    7.786129] WARNING: suspicious RCU usage
[    7.786406] 4.17.0-rc1 #46 Not tainted
[    7.786664] -----------------------------
[    7.786950] lib/test_rhashtable.c:508 suspicious rcu_dereference_protected() usage!
[    7.787570]
[    7.787570] other info that might help us debug this:
[    7.787570]
[    7.788114]
[    7.788114] rcu_scheduler_active = 2, debug_locks = 1
[    7.788555] no locks held by swapper/1.
[    7.788820]
[    7.788820] stack backtrace:
[    7.789126] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc1 #46
[    7.789544] Call Trace:
[    7.789718]  ? print_ht+0xfa/0x25c:
						print_ht at lib/test_rhashtable.c:508 (discriminator 9)
[    7.789962]  ? test_insert_dup+0x565/0x5d7:
						test_insert_dup at lib/test_rhashtable.c:570
[    7.790250]  ? my_hashfn+0x10/0x10:
						my_cmpfn at lib/test_rhashtable.c:94
[    7.790494]  ? kstrtoll_from_user+0x69/0x69:
						jhash at include/linux/jhash.h:76
[    7.790781]  ? jhash+0x125/0x125:
						jhash2 at include/linux/jhash.h:121
						 (inlined by) rhashtable_jhash2 at lib/rhashtable.c:932
						
						jhash+0x125/0x125:
						my_hashfn at lib/test_rhashtable.c:86
[    7.791008]  ? my_hashfn+0x10/0x10:
						my_cmpfn at lib/test_rhashtable.c:94
[    7.791245]  ? rhashtable_rehash_alloc+0x63/0x63:
						rht_deferred_worker at lib/rhashtable.c:413
[    7.791568]  ? test_rht_init+0x2ae/0x561:
						test_insert_duplicates_run at lib/test_rhashtable.c:593 (discriminator 260)
						 (inlined by) test_rht_init at lib/test_rhashtable.c:748 (discriminator 260)
[    7.791839]  ? test_rhashtable+0x634/0x634
[    7.792196]  ? do_one_initcall+0x66/0x14f:
						do_trace_initcall_finish at init/main.c:867
						 (inlined by) do_one_initcall at init/main.c:884
[    7.792472]  ? do_early_param+0x70/0x70:
						repair_env_string at init/main.c:251
[    7.792736]  ? kernel_init_freeable+0xd6/0x173:
						do_initcall_level at init/main.c:950
						 (inlined by) do_initcalls at init/main.c:959
						 (inlined by) do_basic_setup at init/main.c:977
						 (inlined by) kernel_init_freeable at init/main.c:1127
[    7.793045]  ? kernel_init_freeable+0xec/0x173:
						do_initcall_level at init/main.c:950
						 (inlined by) do_initcalls at init/main.c:959
						 (inlined by) do_basic_setup at init/main.c:977
						 (inlined by) kernel_init_freeable at init/main.c:1127
[    7.793359]  ? rest_init+0x107/0x107:
						kernel_init at init/main.c:1053
[    7.793608]  ? kernel_init+0x5/0xc7:
						kernel_init at init/main.c:1055
[    7.793851]  ? ret_from_fork+0x2e/0x38:
						ret_from_fork at arch/x86/entry/entry_32.S:311
[    7.794115]
[    7.794225] =============================
[    7.794502] WARNING: suspicious RCU usage
[    7.794779] 4.17.0-rc1 #46 Not tainted
[    7.795043] -----------------------------
[    7.795320] lib/test_rhashtable.c:519 suspicious rcu_dereference_protected() usage!
[    7.795944]
[    7.795944] other info that might help us debug this:
[    7.795944]
[    7.796487]
[    7.796487] rcu_scheduler_active = 2, debug_locks = 1
[    7.796942] no locks held by swapper/1.
[    7.797208]
[    7.797208] stack backtrace:
[    7.797509] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc1 #46
[    7.797934] Call Trace:
[    7.798109]  ? print_ht+0x164/0x25c:
						rht_obj at include/linux/rhashtable.h:234 (discriminator 7)
						 (inlined by) print_ht at lib/test_rhashtable.c:520 (discriminator 7)
[    7.798356]  ? test_insert_dup+0x565/0x5d7:
						test_insert_dup at lib/test_rhashtable.c:570
[    7.798639]  ? my_hashfn+0x10/0x10:
						my_cmpfn at lib/test_rhashtable.c:94
[    7.798878]  ? kstrtoll_from_user+0x69/0x69:
						jhash at include/linux/jhash.h:76
[    7.799176]  ? jhash+0x125/0x125:
						jhash2 at include/linux/jhash.h:121
						 (inlined by) rhashtable_jhash2 at lib/rhashtable.c:932
						
						jhash+0x125/0x125:
						my_hashfn at lib/test_rhashtable.c:86
[    7.799402]  ? my_hashfn+0x10/0x10:
						my_cmpfn at lib/test_rhashtable.c:94
[    7.799641]  ? rhashtable_rehash_alloc+0x63/0x63:
						rht_deferred_worker at lib/rhashtable.c:413
[    7.799963]  ? test_rht_init+0x2ae/0x561:
						test_insert_duplicates_run at lib/test_rhashtable.c:593 (discriminator 260)
						 (inlined by) test_rht_init at lib/test_rhashtable.c:748 (discriminator 260)
[    7.800248]  ? test_rhashtable+0x634/0x634
[    7.800601]  ? do_one_initcall+0x66/0x14f:
						do_trace_initcall_finish at init/main.c:867
						 (inlined by) do_one_initcall at init/main.c:884
[    7.800878]  ? do_early_param+0x70/0x70:
						repair_env_string at init/main.c:251
[    7.801147]  ? kernel_init_freeable+0xd6/0x173:
						do_initcall_level at init/main.c:950
						 (inlined by) do_initcalls at init/main.c:959
						 (inlined by) do_basic_setup at init/main.c:977
						 (inlined by) kernel_init_freeable at init/main.c:1127
[    7.801452]  ? kernel_init_freeable+0xec/0x173:
						do_initcall_level at init/main.c:950
						 (inlined by) do_initcalls at init/main.c:959
						 (inlined by) do_basic_setup at init/main.c:977
						 (inlined by) kernel_init_freeable at init/main.c:1127
[    7.801758]  ? rest_init+0x107/0x107:
						kernel_init at init/main.c:1053
[    7.802010]  ? kernel_init+0x5/0xc7:
						kernel_init at init/main.c:1055
[    7.802254]  ? ret_from_fork+0x2e/0x38:
						ret_from_fork at arch/x86/entry/entry_32.S:311
[    7.802515]
[    7.802625] =============================
[    7.802904] WARNING: suspicious RCU usage
[    7.803181] 4.17.0-rc1 #46 Not tainted
[    7.803448] -----------------------------
[    7.803725] lib/test_rhashtable.c:529 suspicious rcu_dereference_protected() usage!
[    7.804349]
[    7.804349] other info that might help us debug this:
[    7.804349]
[    7.804892]
[    7.804892] rcu_scheduler_active = 2, debug_locks = 1
[    7.805336] no locks held by swapper/1.
[    7.805601]
[    7.805601] stack backtrace:
[    7.805904] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc1 #46
[    7.806324] Call Trace:
[    7.806499]  ? print_ht+0x1e1/0x25c:
						print_ht at lib/test_rhashtable.c:529 (discriminator 9)
[    7.806753]  ? test_insert_dup+0x565/0x5d7:
						test_insert_dup at lib/test_rhashtable.c:570
[    7.807040]  ? my_hashfn+0x10/0x10:
						my_cmpfn at lib/test_rhashtable.c:94
[    7.807278]  ? kstrtoll_from_user+0x69/0x69:
						jhash at include/linux/jhash.h:76
[    7.807567]  ? jhash+0x125/0x125:
						jhash2 at include/linux/jhash.h:121
						 (inlined by) rhashtable_jhash2 at lib/rhashtable.c:932
						
						jhash+0x125/0x125:
						my_hashfn at lib/test_rhashtable.c:86
[    7.807792]  ? my_hashfn+0x10/0x10:
						my_cmpfn at lib/test_rhashtable.c:94
[    7.808033]  ? rhashtable_rehash_alloc+0x63/0x63:
						rht_deferred_worker at lib/rhashtable.c:413
[    7.808352]  ? test_rht_init+0x2ae/0x561:
						test_insert_duplicates_run at lib/test_rhashtable.c:593 (discriminator 260)
						 (inlined by) test_rht_init at lib/test_rhashtable.c:748 (discriminator 260)
[    7.808625]  ? test_rhashtable+0x634/0x634
[    7.808983]  ? do_one_initcall+0x66/0x14f:
						do_trace_initcall_finish at init/main.c:867
						 (inlined by) do_one_initcall at init/main.c:884
[    7.809260]  ? do_early_param+0x70/0x70:
						repair_env_string at init/main.c:251
[    7.809525]  ? kernel_init_freeable+0xd6/0x173:
						do_initcall_level at init/main.c:950
						 (inlined by) do_initcalls at init/main.c:959
						 (inlined by) do_basic_setup at init/main.c:977
						 (inlined by) kernel_init_freeable at init/main.c:1127
[    7.809831]  ? kernel_init_freeable+0xec/0x173:
						do_initcall_level at init/main.c:950
						 (inlined by) do_initcalls at init/main.c:959
						 (inlined by) do_basic_setup at init/main.c:977
						 (inlined by) kernel_init_freeable at init/main.c:1127
[    7.810149]  ? rest_init+0x107/0x107:
						kernel_init at init/main.c:1053
[    7.810399]  ? kernel_init+0x5/0xc7:
						kernel_init at init/main.c:1055
[    7.810642]  ? ret_from_fork+0x2e/0x38:
						ret_from_fork at arch/x86/entry/entry_32.S:311
[    7.810913]
[    7.810913] ---- ht: ----
[    7.810913] bucket[1] -> [[ val 1 (tid=0) ]] -> [[ val 21 (tid=1) ]]
[    7.810913] -------------
[    7.813358]

Attached the full dmesg, kconfig and reproduce scripts.

Thanks,
Fengguang

--o4bgh4uvgwqptlb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-openwrt-lkp-hsw01-15:20180418191103:i386-randconfig-c0-04181855:4.17.0-rc1:46"

early console in setup code
[    0.000000] Linux version 4.17.0-rc1 (kbuild@cairo) (gcc version 7.3.0 (Debian 7.3.0-16)) #46 Wed Apr 18 19:05:36 CST 2018
[    0.000000] KERNEL supported cpus:
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   UMC UMC UMC UMC
[    0.000000] CPU: vendor_id 'GenuineIntel' unknown, using generic init.
[    0.000000] CPU: Your system may be unstable.
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000000ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000ffe0000-0x000000000fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0xffe0 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask FF80000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000f6aa0-0x000f6aaf] mapped at [(ptrval)]
[    0.000000]   mpc: f6ab0-f6b80
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] initial memory mapped: [mem 0x00000000-0x027fffff]
[    0.000000] Base memory trampoline at [(ptrval)] 9b000 size 16384
[    0.000000] BRK [0x020d8000, 0x020d8fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x0fdc9000-0x0ffdffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F68D0 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x000000000FFE15CE 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x000000000FFE142A 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x000000000FFE0040 0013EA (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x000000000FFE0000 000040
[    0.000000] ACPI: APIC 0x000000000FFE151E 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x000000000FFE1596 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffb000 (        fee00000)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 255MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 0ffe0000
[    0.000000]   low ram: 0 - 0ffe0000
[    0.000000] kvm-clock: cpu 0, msr 0:fdc7001, primary cpu clock
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: using sched offset of 559675804 cycles
[    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000000] BRK [0x020d9000, 0x020d9fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x000000000ffdffff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000000ffdffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000000ffdffff]
[    0.000000] On node 0 totalpages: 65406
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 480 pages used for memmap
[    0.000000]   Normal zone: 61408 pages, LIFO batch:15
[    0.000000] Reserved but unavailable: 98 pages
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] mapped IOAPIC to ffffa000 (fec00000)
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 1731500
[    0.000000] e820: [mem 0x10000000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.000000] random: fast init done
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 64894
[    0.000000] Kernel command line: root=/dev/ram0 hung_task_panic=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw link=/kbuild-tests/run-queue/kvm/i386-randconfig-c0-04181855/linux-devel:devel-hourly-2018041810:60cc43fc888428bb2f18f08997432d426a243338/.vmlinuz-60cc43fc888428bb2f18f08997432d426a243338-20180418190902-2:openwrt-lkp-hsw01-15 branch=linux-devel/devel-hourly-2018041810 BOOT_IMAGE=/pkg/linux/i386-randconfig-c0-04181855/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmlinuz-4.17.0-rc1 drbd.minor_count=8 rcuperf.shutdown=0
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 113332K/261624K available (4665K kernel code, 511K rwdata, 2604K rodata, 484K init, 8840K bss, 21776K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff8d000 - 0xfffff000   ( 456 kB)
[    0.000000]   cpu_entry : 0xffc00000 - 0xffc07000   (  28 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0x907e0000 - 0xff7fe000   (1776 MB)
[    0.000000]     lowmem  : 0x80000000 - 0x8ffe0000   ( 255 MB)
[    0.000000]       .init : 0x817b3000 - 0x8182c000   ( 484 kB)
[    0.000000]       .data : 0x8148e574 - 0x8179cf40   (3130 kB)
[    0.000000]       .text : 0x81000000 - 0x8148e574   (4665 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.003333] Running RCU self tests
[    0.003333] NR_IRQS: 2304, nr_irqs: 256, preallocated irqs: 16
[    0.003333] CPU 0 irqstacks, hard=(ptrval) soft=(ptrval)
[    0.003333] console [ttyS0] enabled
[    0.003333] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.003333] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.003333] ... MAX_LOCK_DEPTH:          48
[    0.003333] ... MAX_LOCKDEP_KEYS:        8191
[    0.003333] ... CLASSHASH_SIZE:          4096
[    0.003333] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.003333] ... MAX_LOCKDEP_CHAINS:      65536
[    0.003333] ... CHAINHASH_SIZE:          32768
[    0.003333]  memory used by lock dependency info: 4399 kB
[    0.003333]  per task-struct memory footprint: 1344 bytes
[    0.003333] ODEBUG: selftest passed
[    0.003333] ACPI: Core revision 20180313
[    0.003333] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.003333] hpet clockevent registered
[    0.003350] APIC: Switch to symmetric I/O mode setup
[    0.003692] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.004090] enabled ExtINT on CPU#0
[    0.004922] ENABLING IO-APIC IRQs
[    0.005168] init IO_APIC IRQs
[    0.005376]  apic 0 pin 0 not connected
[    0.005690] IOAPIC[0]: Set routing entry (0-1 -> 0xef -> IRQ 1 Mode:0 Active:0 Dest:1)
[    0.006281] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:1)
[    0.006666] IOAPIC[0]: Set routing entry (0-3 -> 0xef -> IRQ 3 Mode:0 Active:0 Dest:1)
[    0.006666] IOAPIC[0]: Set routing entry (0-4 -> 0xef -> IRQ 4 Mode:0 Active:0 Dest:1)
[    0.006666] IOAPIC[0]: Set routing entry (0-5 -> 0xef -> IRQ 5 Mode:1 Active:0 Dest:1)
[    0.006666] IOAPIC[0]: Set routing entry (0-6 -> 0xef -> IRQ 6 Mode:0 Active:0 Dest:1)
[    0.006666] IOAPIC[0]: Set routing entry (0-7 -> 0xef -> IRQ 7 Mode:0 Active:0 Dest:1)
[    0.006666] IOAPIC[0]: Set routing entry (0-8 -> 0xef -> IRQ 8 Mode:0 Active:0 Dest:1)
[    0.006666] IOAPIC[0]: Set routing entry (0-9 -> 0xef -> IRQ 9 Mode:1 Active:0 Dest:1)
[    0.006666] IOAPIC[0]: Set routing entry (0-10 -> 0xef -> IRQ 10 Mode:1 Active:0 Dest:1)
[    0.006666] IOAPIC[0]: Set routing entry (0-11 -> 0xef -> IRQ 11 Mode:1 Active:0 Dest:1)
[    0.006666] IOAPIC[0]: Set routing entry (0-12 -> 0xef -> IRQ 12 Mode:0 Active:0 Dest:1)
[    0.006666] IOAPIC[0]: Set routing entry (0-13 -> 0xef -> IRQ 13 Mode:0 Active:0 Dest:1)
[    0.006666] IOAPIC[0]: Set routing entry (0-14 -> 0xef -> IRQ 14 Mode:0 Active:0 Dest:1)
[    0.006666] IOAPIC[0]: Set routing entry (0-15 -> 0xef -> IRQ 15 Mode:0 Active:0 Dest:1)
[    0.006666]  apic 0 pin 16 not connected
[    0.006666]  apic 0 pin 17 not connected
[    0.006666]  apic 0 pin 18 not connected
[    0.006666]  apic 0 pin 19 not connected
[    0.006666]  apic 0 pin 20 not connected
[    0.006666]  apic 0 pin 21 not connected
[    0.006666]  apic 0 pin 22 not connected
[    0.006666]  apic 0 pin 23 not connected
[    0.006666] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.006666] tsc: Detected 2593.992 MHz processor
[    0.006666] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x25641074d3b, max_idle_ns: 440795244898 ns
[    0.006666] Calibrating delay loop (skipped) preset value.. 5190.15 BogoMIPS (lpj=8646640)
[    0.006666] pid_max: default: 4096 minimum: 301
[    0.006666] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.006666] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.007217] mce: CPU supports 10 MCE banks
[    0.007510] mce: unknown CPU type - not enabling MCE support
[    0.007897] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.008267] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.008666] CPU: GenuineIntel Intel Core Processor (Haswell) (family: 0x6, model: 0x3c, stepping: 0x4)
[    0.009306] Spectre V2 : Mitigation: Full generic retpoline
[    0.010612] Performance Events: no PMU driver, software events only.
[    0.011474] TSC deadline timer enabled
[    0.012731] node 0 initialised, 31629 pages in 0ms
[    0.013305] pgdatinit0 (9) used greatest stack depth: 7328 bytes left
[    0.013333] devtmpfs: initialized
[    0.013826] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.014503] futex hash table entries: 16 (order: -3, 704 bytes)
[    0.014956] pinctrl core: initialized pinctrl subsystem
[    0.016169] NET: Registered protocol family 16
[    0.017455] EISA bus registered
[    0.017698] cpuidle: using governor ladder
[    0.018470] ACPI: bus type PCI registered
[    0.018971] PCI: PCI BIOS revision 2.10 entry at 0xfd501, last bus=0
[    0.019412] PCI: Using configuration type 1 for base access
[    0.026660] cryptd: max_cpu_qlen set to 1000
[    0.026804] ACPI: Added _OSI(Module Device)
[    0.027104] ACPI: Added _OSI(Processor Device)
[    0.027410] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.027732] ACPI: Added _OSI(Processor Aggregator Device)
[    0.028112] ACPI: Added _OSI(Linux-Dell-Video)
[    0.031856] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.035176] ACPI: Interpreter enabled
[    0.035451] ACPI: (supports S0 S5)
[    0.035689] ACPI: Using IOAPIC for interrupt routing
[    0.036059] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.037007] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.047421] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.047892] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.048423] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.048927] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.049937] PCI host bridge to bus 0000:00
[    0.050008] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.050475] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.050951] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.051466] pci_bus 0000:00: root bus resource [mem 0x10000000-0xfebfffff window]
[    0.051979] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.052424] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.053531] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.054579] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.057177] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    0.058695] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.059179] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.059624] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.060007] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.060811] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.061507] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.062000] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.062888] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.064247] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.067346] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.072787] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.073653] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.075758] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.076674] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.080592] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.081450] pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000
[    0.082480] pci 0000:00:04.0: reg 0x10: [mem 0xfebf1000-0xfebf100f]
[    0.087405] pci_bus 0000:00: on NUMA node 0
[    0.088998] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.089678] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.090272] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.090930] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.091437] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    0.092531] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.092977] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.093340] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.093737] vgaarb: loaded
[    0.094379] FPGA manager framework
[    0.094650] PCI: Using ACPI for IRQ routing
[    0.094942] PCI: pci_cache_line_size set to 64 bytes
[    0.095352] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.095777] e820: reserve RAM buffer [mem 0x0ffe0000-0x0fffffff]
[    0.096885] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    0.097820] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.098165] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.100018] clocksource: Switched to clocksource kvm-clock
[    0.100579] VFS: Disk quotas dquot_6.6.0
[    0.100865] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.101434] pnp: PnP ACPI init
[    0.101806] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.102348] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.102888] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.103380] pnp 00:03: [dma 2]
[    0.103632] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.104218] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.104784] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.105369] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.106346] pnp: PnP ACPI: found 7 devices
[    0.106633] PnPBIOS: Disabled
[    0.141959] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.142569] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.142980] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.143394] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.143844] pci_bus 0000:00: resource 7 [mem 0x10000000-0xfebfffff window]
[    0.144439] NET: Registered protocol family 2
[    0.145037] tcp_listen_portaddr_hash hash table entries: 128 (order: 0, 5120 bytes)
[    0.145558] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    0.146043] TCP bind hash table entries: 2048 (order: 4, 73728 bytes)
[    0.146572] TCP: Hash tables configured (established 2048 bind 2048)
[    0.147054] UDP hash table entries: 128 (order: 1, 10240 bytes)
[    0.147468] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
[    0.147963] NET: Registered protocol family 1
[    0.148621] RPC: Registered named UNIX socket transport module.
[    0.149022] RPC: Registered udp transport module.
[    0.149320] RPC: Registered tcp transport module.
[    0.149617] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.150039] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.150422] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.150797] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.151218] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.151755] PCI: CLS 0 bytes, default 64
[    0.152184] Unpacking initramfs...
[    0.225350] Freeing initrd memory: 2140K
[    0.226372] Machine check injector initialized
[    0.226872] Scanning for low memory corruption every 60 seconds
[    0.227479] cryptomgr_test (24) used greatest stack depth: 7320 bytes left
[    0.228089] spin_lock-torture:--- Start of test [debug]: nwriters_stress=2 nreaders_stress=0 stat_interval=60 verbose=1 shuffle_interval=3 stutter=5 shutdown_secs=0 onoff_interval=0 onoff_holdoff=0
[    0.229102] spin_lock-torture: Creating torture_shuffle task
[    0.229518] spin_lock-torture: Creating torture_stutter task
[    0.229863] spin_lock-torture: torture_shuffle task started
[    0.230203] spin_lock-torture: Creating lock_torture_writer task
[    0.230568] spin_lock-torture: torture_stutter task started
[    0.230898] spin_lock-torture: Creating lock_torture_writer task
[    0.231256] spin_lock-torture: lock_torture_writer task started
[    0.231611] spin_lock-torture: Creating lock_torture_stats task
[    0.231968] spin_lock-torture: lock_torture_writer task started
[    0.232444] spin_lock-torture: lock_torture_stats task started
[    1.228110] tsc: Refined TSC clocksource calibration: 2593.989 MHz
[    1.228522] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x25640db9c9f, max_idle_ns: 440795213164 ns
[    6.775313] torture_init_begin: Refusing rcu init: spin_lock running.
[    6.777020] torture_init_begin: One torture test at a time!
[    6.779212] workingset: timestamp_bits=30 max_order=16 bucket_order=0
[    6.784556] cryptomgr_test (63) used greatest stack depth: 7224 bytes left
[    6.800255] test_hash: __hash_32() has no arch implementation to test.
[    6.801046] test_hash: hash_32() has no arch implementation to test.
[    6.801790] test_hash: hash_64() has no arch implementation to test.
[    6.802535] test_hash: 33152 tests passed.
[    6.803086] test_siphash: self-tests: pass
[    6.807019] Running rhashtable test nelem=8, max_size=0, shrinking=0
[    6.807777] Test 00:
[    6.808122]   Adding 50000 keys
[    6.971546]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    7.004280]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    7.004853]   Deleting 50000 keys
[    7.046860]   Duration of test: 238355517 ns
[    7.047188] Test 01:
[    7.047416]   Adding 50000 keys
[    7.189432]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    7.226242]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    7.226831]   Deleting 50000 keys
[    7.268898]   Duration of test: 221261553 ns
[    7.269207] Test 02:
[    7.269415]   Adding 50000 keys
[    7.403177]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    7.436199]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    7.436786]   Deleting 50000 keys
[    7.482203]   Duration of test: 212567253 ns
[    7.482517] Test 03:
[    7.482715]   Adding 50000 keys
[    7.660510] Info: encountered resize
[    7.667637]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=1
[    7.704392]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    7.704973]   Deleting 50000 keys
[    7.746774]   Duration of test: 263826509 ns
[    7.767898] test if its possible to exceed max_size 8192: no, ok
[    7.768365] Average test time: 234002708
[    7.768638] test inserting duplicates
[    7.768907] 
[    7.769018] =============================
[    7.769297] WARNING: suspicious RCU usage
[    7.769576] 4.17.0-rc1 #46 Not tainted
[    7.769836] -----------------------------
[    7.770129] lib/test_rhashtable.c:502 suspicious rcu_dereference_protected() usage!
[    7.770752] 
[    7.770752] other info that might help us debug this:
[    7.770752] 
[    7.771298] 
[    7.771298] rcu_scheduler_active = 2, debug_locks = 1
[    7.771743] no locks held by swapper/1.
[    7.772011] 
[    7.772011] stack backtrace:
[    7.772319] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc1 #46
[    7.772739] Call Trace:
[    7.772925]  ? print_ht+0x66/0x25c
[    7.773167]  ? test_insert_dup+0x565/0x5d7
[    7.773462]  ? my_hashfn+0x10/0x10
[    7.773706]  ? kstrtoll_from_user+0x69/0x69
[    7.773999]  ? jhash+0x125/0x125
[    7.774224]  ? my_hashfn+0x10/0x10
[    7.774462]  ? rhashtable_rehash_alloc+0x63/0x63
[    7.774780]  ? test_rht_init+0x2ae/0x561
[    7.775060]  ? test_rhashtable+0x634/0x634
[    7.775413]  ? do_one_initcall+0x66/0x14f
[    7.775691]  ? do_early_param+0x70/0x70
[    7.775980]  ? kernel_init_freeable+0xd6/0x173
[    7.776287]  ? kernel_init_freeable+0xec/0x173
[    7.776595]  ? rest_init+0x107/0x107
[    7.776853]  ? kernel_init+0x5/0xc7
[    7.777104]  ? ret_from_fork+0x2e/0x38
[    7.777364] 
[    7.777474] =============================
[    7.777750] WARNING: suspicious RCU usage
[    7.778031] 4.17.0-rc1 #46 Not tainted
[    7.778290] -----------------------------
[    7.778566] lib/test_rhashtable.c:507 suspicious rcu_dereference_protected() usage!
[    7.779191] 
[    7.779191] other info that might help us debug this:
[    7.779191] 
[    7.779732] 
[    7.779732] rcu_scheduler_active = 2, debug_locks = 1
[    7.780190] no locks held by swapper/1.
[    7.780456] 
[    7.780456] stack backtrace:
[    7.780756] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc1 #46
[    7.781179] Call Trace:
[    7.781355]  ? print_ht+0xb2/0x25c
[    7.781595]  ? test_insert_dup+0x565/0x5d7
[    7.781878]  ? my_hashfn+0x10/0x10
[    7.782120]  ? kstrtoll_from_user+0x69/0x69
[    7.782409]  ? jhash+0x125/0x125
[    7.782633]  ? my_hashfn+0x10/0x10
[    7.782871]  ? rhashtable_rehash_alloc+0x63/0x63
[    7.783192]  ? test_rht_init+0x2ae/0x561
[    7.783472]  ? test_rhashtable+0x634/0x634
[    7.783824]  ? do_one_initcall+0x66/0x14f
[    7.784105]  ? do_early_param+0x70/0x70
[    7.784371]  ? kernel_init_freeable+0xd6/0x173
[    7.784677]  ? kernel_init_freeable+0xec/0x173
[    7.784988]  ? rest_init+0x107/0x107
[    7.785237]  ? kernel_init+0x5/0xc7
[    7.785480]  ? ret_from_fork+0x2e/0x38
[    7.785739] 
[    7.785849] =============================
[    7.786129] WARNING: suspicious RCU usage
[    7.786406] 4.17.0-rc1 #46 Not tainted
[    7.786664] -----------------------------
[    7.786950] lib/test_rhashtable.c:508 suspicious rcu_dereference_protected() usage!
[    7.787570] 
[    7.787570] other info that might help us debug this:
[    7.787570] 
[    7.788114] 
[    7.788114] rcu_scheduler_active = 2, debug_locks = 1
[    7.788555] no locks held by swapper/1.
[    7.788820] 
[    7.788820] stack backtrace:
[    7.789126] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc1 #46
[    7.789544] Call Trace:
[    7.789718]  ? print_ht+0xfa/0x25c
[    7.789962]  ? test_insert_dup+0x565/0x5d7
[    7.790250]  ? my_hashfn+0x10/0x10
[    7.790494]  ? kstrtoll_from_user+0x69/0x69
[    7.790781]  ? jhash+0x125/0x125
[    7.791008]  ? my_hashfn+0x10/0x10
[    7.791245]  ? rhashtable_rehash_alloc+0x63/0x63
[    7.791568]  ? test_rht_init+0x2ae/0x561
[    7.791839]  ? test_rhashtable+0x634/0x634
[    7.792196]  ? do_one_initcall+0x66/0x14f
[    7.792472]  ? do_early_param+0x70/0x70
[    7.792736]  ? kernel_init_freeable+0xd6/0x173
[    7.793045]  ? kernel_init_freeable+0xec/0x173
[    7.793359]  ? rest_init+0x107/0x107
[    7.793608]  ? kernel_init+0x5/0xc7
[    7.793851]  ? ret_from_fork+0x2e/0x38
[    7.794115] 
[    7.794225] =============================
[    7.794502] WARNING: suspicious RCU usage
[    7.794779] 4.17.0-rc1 #46 Not tainted
[    7.795043] -----------------------------
[    7.795320] lib/test_rhashtable.c:519 suspicious rcu_dereference_protected() usage!
[    7.795944] 
[    7.795944] other info that might help us debug this:
[    7.795944] 
[    7.796487] 
[    7.796487] rcu_scheduler_active = 2, debug_locks = 1
[    7.796942] no locks held by swapper/1.
[    7.797208] 
[    7.797208] stack backtrace:
[    7.797509] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc1 #46
[    7.797934] Call Trace:
[    7.798109]  ? print_ht+0x164/0x25c
[    7.798356]  ? test_insert_dup+0x565/0x5d7
[    7.798639]  ? my_hashfn+0x10/0x10
[    7.798878]  ? kstrtoll_from_user+0x69/0x69
[    7.799176]  ? jhash+0x125/0x125
[    7.799402]  ? my_hashfn+0x10/0x10
[    7.799641]  ? rhashtable_rehash_alloc+0x63/0x63
[    7.799963]  ? test_rht_init+0x2ae/0x561
[    7.800248]  ? test_rhashtable+0x634/0x634
[    7.800601]  ? do_one_initcall+0x66/0x14f
[    7.800878]  ? do_early_param+0x70/0x70
[    7.801147]  ? kernel_init_freeable+0xd6/0x173
[    7.801452]  ? kernel_init_freeable+0xec/0x173
[    7.801758]  ? rest_init+0x107/0x107
[    7.802010]  ? kernel_init+0x5/0xc7
[    7.802254]  ? ret_from_fork+0x2e/0x38
[    7.802515] 
[    7.802625] =============================
[    7.802904] WARNING: suspicious RCU usage
[    7.803181] 4.17.0-rc1 #46 Not tainted
[    7.803448] -----------------------------
[    7.803725] lib/test_rhashtable.c:529 suspicious rcu_dereference_protected() usage!
[    7.804349] 
[    7.804349] other info that might help us debug this:
[    7.804349] 
[    7.804892] 
[    7.804892] rcu_scheduler_active = 2, debug_locks = 1
[    7.805336] no locks held by swapper/1.
[    7.805601] 
[    7.805601] stack backtrace:
[    7.805904] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc1 #46
[    7.806324] Call Trace:
[    7.806499]  ? print_ht+0x1e1/0x25c
[    7.806753]  ? test_insert_dup+0x565/0x5d7
[    7.807040]  ? my_hashfn+0x10/0x10
[    7.807278]  ? kstrtoll_from_user+0x69/0x69
[    7.807567]  ? jhash+0x125/0x125
[    7.807792]  ? my_hashfn+0x10/0x10
[    7.808033]  ? rhashtable_rehash_alloc+0x63/0x63
[    7.808352]  ? test_rht_init+0x2ae/0x561
[    7.808625]  ? test_rhashtable+0x634/0x634
[    7.808983]  ? do_one_initcall+0x66/0x14f
[    7.809260]  ? do_early_param+0x70/0x70
[    7.809525]  ? kernel_init_freeable+0xd6/0x173
[    7.809831]  ? kernel_init_freeable+0xec/0x173
[    7.810149]  ? rest_init+0x107/0x107
[    7.810399]  ? kernel_init+0x5/0xc7
[    7.810642]  ? ret_from_fork+0x2e/0x38
[    7.810913] 
[    7.810913] ---- ht: ----
[    7.810913] bucket[1] -> [[ val 1 (tid=0) ]] -> [[ val 21 (tid=1) ]]
[    7.810913] -------------
[    7.813358] 
[    7.813358] ---- ht: ----
[    7.813358] bucket[1] -> [[ val 1 (tid=2),  val 1 (tid=0) ]] -> [[ val 21 (tid=1) ]]
[    7.813358] -------------
[    7.814343] 
[    7.814343] ---- ht: ----
[    7.814343] bucket[1] -> [[ val 21 (tid=1) ]] -> [[ val 1 (tid=0) ]]
[    7.814343] -------------
[    7.815231] 
[    7.815231] ---- ht: ----
[    7.815231] bucket[1] -> [[ val 21 (tid=1) ]] -> [[ val 1 (tid=2),  val 1 (tid=0) ]]
[    7.815231] -------------
[    7.816200] Testing concurrent rhashtable access from 10 threads
[   12.302538] test 3125 add/delete pairs into rhlist
[   12.442759] test 3125 random rhlist add/delete operations
[   12.607170] Started 10 threads, 0 failed, rhltable test returns 0
[   12.608529] rivafb_setup START
[   12.608851] vmlfb: initializing
[   12.609169] hgafb: HGA card not detected.
[   12.609428] hgafb: probe of hgafb.0 failed with error -22
[   12.609954] Warning: Processor Platform Limit event detected, but not handled.
[   12.610380] Consider compiling CPUfreq support into your kernel.
[   12.637868] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   12.659978] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   12.702424] 00:06: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[   12.727991] kworker/u2:1 (109) used greatest stack depth: 6996 bytes left
[   12.728507] lp: driver loaded but no devices found
[   12.728992] toshiba: not a supported Toshiba laptop
[   12.729335] platform pc8736x_gpio.0: NatSemi pc8736x GPIO Driver Initializing
[   12.729737] platform pc8736x_gpio.0: no device found
[   12.730116] nsc_gpio initializing
[   12.730332] telclk_interrupt = 0xf non-mcpbl0010 hw.
[   12.731571] slram: not enough parameters.
[   12.733664] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[   12.734091] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   12.970771] PCI Interrupt Link [LNKC] enabled at IRQ 11
[   13.300491] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[   13.300970] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[   13.301616] Intel ISA PCIC probe: 
[   13.301653] not found.
[   13.302257] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[   13.303377] serio: i8042 KBD port at 0x60,0x64 irq 1
[   13.303702] serio: i8042 AUX port at 0x60,0x64 irq 12
[   13.304850] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[   13.306115] rtc-test rtc-test.0: rtc core: registered test as rtc0
[   13.306619] rtc-test rtc-test.1: rtc core: registered test as rtc1
[   13.307198] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
[   13.308013] Driver for 1-wire Dallas network protocol.
[   13.308359] DS1WM w1 busmaster driver - (c) 2004 Szabolcs Gyurko
[   13.354585] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
[   13.354921] alim7101_wdt: ALi M7101 PMU not present - WDT not set
[   13.355371] cpu5wdt: init success
[   13.355606] w83977f_wdt: driver v1.00
[   13.355814] w83977f_wdt: cannot register miscdev on minor=130 (err=-16)
[   13.356204] machzwd: MachZ ZF-Logic Watchdog driver initializing
[   13.356569] machzwd: no ZF-Logic found
[   13.356852] watchdog: Software Watchdog: cannot register miscdev on minor=130 (err=-16).
[   13.357340] watchdog: Software Watchdog: a legacy watchdog module is probably present.
[   13.357937] softdog: initialized. soft_noboot=0 soft_margin=60 sec soft_panic=0 (nowayout=0)
[   13.358552] platform eisa.0: Probing EISA bus 0
[   13.358852] platform eisa.0: EISA: Cannot allocate resource for mainboard
[   13.360415]  fake-fmc-carrier: mezzanine 0
[   13.360664]       Manufacturer: fake-vendor
[   13.360910]       Product name: fake-design-for-testing
[   13.361429] NET: Registered protocol family 10
[   13.362276] Segment Routing with IPv6
[   13.362525] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   13.363270] mce: Unable to init MCE device (rc: -5)
[   13.363944] ... APIC ID:      00000000 (0)
[   13.364186] ... APIC VERSION: 01050014
[   13.364409] 0000000000000000000000000000000000000000000000000000000000000000
[   13.364819] 0000000000000000000000000000000000000000000000000000000000000000
[   13.365237] 0000000000000000000000000000000000000000000000000000000000000000
[   13.365652] number of MP IRQ sources: 15.
[   13.365887] number of IO-APIC #0 registers: 24.
[   13.366150] testing the IO APIC.......................
[   13.366452] IO APIC #0......
[   13.366621] .... register #00: 00000000
[   13.366855] .......    : physical APIC id: 00
[   13.367121] .......    : Delivery Type: 0
[   13.367361] .......    : LTS          : 0
[   13.367594] .... register #01: 00170011
[   13.367817] .......     : max redirection entries: 17
[   13.368111] .......     : PRQ implemented: 0
[   13.368358] .......     : IO APIC version: 11
[   13.368613] .... register #02: 00000000
[   13.368836] .......     : arbitration: 00
[   13.369070] .... IRQ redirection table:
[   13.369293] IOAPIC 0:
[   13.369437]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.369890]  pin01, enabled , edge , high, V(22), IRR(0), S(0), logical , D(01), M(0)
[   13.370348]  pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(01), M(0)
[   13.370799]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.371254]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.371704]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.372158]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.372609]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.373064]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.373525]  pin09, enabled , level, high, V(20), IRR(0), S(0), logical , D(01), M(0)
[   13.373984]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.374435]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.374901]  pin0c, enabled , edge , high, V(21), IRR(0), S(0), logical , D(01), M(0)
[   13.375358]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.375793]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.376253]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.376721]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.377174]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.377621]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.378070]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.378517]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.378979]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.379438]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.379889]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   13.380338] IRQ to pin mappings:
[   13.380527] IRQ0 -> 0:2
[   13.380674] IRQ1 -> 0:1
[   13.380821] IRQ3 -> 0:3
[   13.380996] IRQ4 -> 0:4
[   13.381143] IRQ5 -> 0:5
[   13.381300] IRQ6 -> 0:6
[   13.381442] IRQ7 -> 0:7
[   13.381584] IRQ8 -> 0:8
[   13.381726] IRQ9 -> 0:9
[   13.381868] IRQ10 -> 0:10
[   13.382040] IRQ11 -> 0:11
[   13.382196] IRQ12 -> 0:12
[   13.382360] IRQ13 -> 0:13
[   13.382512] IRQ14 -> 0:14
[   13.382664] IRQ15 -> 0:15
[   13.382815] .................................... done.
[   13.383127] Using IPI Shortcut mode
[   13.387016] sched_clock: Marking stable (13386669142, 0)->(13473104341, -86435199)
[   13.389240] Freeing unused kernel memory: 484K
[   13.389536] Write protecting the kernel text: 4668k
[   13.389932] Write protecting the kernel read-only data: 2616k
procd: Console is alive
procd: - watchdog -
[   13.408876] kmodloader (120) used greatest stack depth: 6988 bytes left
procd: - preinit -
Press the [f] key and hit [enter] to enter failsafe mode
Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
[   15.488521] rm (129) used greatest stack depth: 6804 bytes left
mounting /dev/root
mount: mounting 1 on /mnt failed: No such device
mv: can't rename '/mnt/sysupgrade.tgz': No such file or directory
umount: can't umount /mnt: Invalid argument
[   15.502135] sh (122) used greatest stack depth: 6564 bytes left
procd: - early -
procd: - watchdog -
procd: - ubus -
procd: - init -
Please press Enter to activate this console.
[   61.066741] Writes:  Total: 7771326  Max/Min: 0/0   Fail: 0 
procd: - shutdown -
[  117.975727] dropbear (1461) used greatest stack depth: 6428 bytes left
[  118.041225] netifd (904) used greatest stack depth: 6164 bytes left
procd: - reboot -
[  118.080455] Unregister pv shared memory for cpu 0
[  118.080807] spin_lock-torture: Unscheduled system shutdown detected
[  118.262972] torture thread torture_shuffle parking due to system shutdown
[  118.270006] torture thread torture_stutter parking due to system shutdown
[  118.332626] reboot: Restarting system
[  118.332842] reboot: machine restart

Elapsed time: 120

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep
	-kernel $kernel
	-initrd /osimage/openwrt/openwrt-trinity-i386.cgz
	-m 256
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	branch=linux-devel/devel-hourly-2018041810
	BOOT_IMAGE=/pkg/linux/i386-randconfig-c0-04181855/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmlinuz-4.17.0-rc1
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--o4bgh4uvgwqptlb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.17.0-rc1 Kernel Configuration
#
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_PROFILING is not set
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
CONFIG_CC_STACKPROTECTOR_STRONG=y
# CONFIG_CC_STACKPROTECTOR_AUTO is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
# CONFIG_GCOV_FORMAT_AUTODETECT is not set
CONFIG_GCOV_FORMAT_3_4=y
# CONFIG_GCOV_FORMAT_4_7 is not set
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=m
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
# CONFIG_X86_RDC321X is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
CONFIG_MCORE2=y
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
CONFIG_CPU_SUP_CYRIX_32=y
# CONFIG_CPU_SUP_AMD is not set
CONFIG_CPU_SUP_CENTAUR=y
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
# CONFIG_X86_MCE_INTEL is not set
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_TOSHIBA=y
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
CONFIG_VMSPLIT_2G=y
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0x80000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
CONFIG_ZPOOL=m
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_HIGHPTE is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
# CONFIG_X86_PAT is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
# CONFIG_ACPI_DEBUGGER_USER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=m
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_DPTF_POWER=m
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_PMIC_OPREGION=y
# CONFIG_CRC_PMIC_OPREGION is not set
CONFIG_CHT_DC_TI_PMIC_OPREGION=y
CONFIG_ACPI_CONFIGFS=y
CONFIG_TPS68470_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEAER_INJECT=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEBUG=y
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
CONFIG_PCIEASPM_POWER_SUPERSAVE=y
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT is not set

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
CONFIG_SCx200=m
CONFIG_SCx200HR_TIMER=m
CONFIG_OLPC=y
CONFIG_OLPC_XO15_SCI=y
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
# CONFIG_YENTA_O2 is not set
CONFIG_YENTA_RICOH=y
# CONFIG_YENTA_TI is not set
CONFIG_YENTA_TOSHIBA=y
# CONFIG_PD6729 is not set
CONFIG_I82092=y
CONFIG_I82365=y
CONFIG_TCIC=m
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=m
# CONFIG_RAPIDIO_TSI721 is not set
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=m
# CONFIG_RAPIDIO_CHMAN is not set
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
CONFIG_RAPIDIO_CPS_XX=m
CONFIG_RAPIDIO_TSI568=m
CONFIG_RAPIDIO_CPS_GEN2=m
# CONFIG_RAPIDIO_RXS_GEN3 is not set
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=m
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=m
CONFIG_MTD_AR7_PARTS=y

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=m
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=y
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_PHYSMAP_OF=y
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_ICHXROM=m
CONFIG_MTD_ESB2ROM=m
CONFIG_MTD_CK804XROM=m
CONFIG_MTD_SCB2_FLASH=m
CONFIG_MTD_NETtel=m
# CONFIG_MTD_L440GX is not set
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=m

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
CONFIG_MTD_DATAFLASH_OTP=y
# CONFIG_MTD_M25P80 is not set
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_ONENAND=y
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
# CONFIG_MTD_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_MT81xx_NOR=m
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=m
CONFIG_SPI_INTEL_SPI_PCI=m
CONFIG_SPI_INTEL_SPI_PLATFORM=m
# CONFIG_MTD_UBI is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y
# CONFIG_PNPBIOS_PROC_FS is not set
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_AD525X_DPOT_SPI=m
CONFIG_DUMMY_IRQ=m
CONFIG_IBM_ASM=m
CONFIG_PHANTOM=m
CONFIG_SGI_IOC4=m
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
CONFIG_ECHO=y
CONFIG_MISC_RTSX_PCI=y
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_NI65 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC9194 is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=m
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
CONFIG_JOYSTICK_AS5011=m
CONFIG_JOYSTICK_JOYDUMP=m
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_WALKERA0701=m
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_APBPS2=m
CONFIG_SERIO_OLPC_APSP=m
# CONFIG_HYPERV_KEYBOARD is not set
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=m
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PROC_INTERFACE=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
CONFIG_APPLICOM=m
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
CONFIG_CARDMAN_4040=y
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_I2C_ATMEL=m
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TCG_TIS_ST33ZP24_SPI=m
CONFIG_TELCLOCK=y
# CONFIG_DEVPORT is not set
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_PINCTRL is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=m
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=m
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_NFORCE2_S4985 is not set
CONFIG_I2C_SIS5595=m
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PXA=m
CONFIG_I2C_PXA_PCI=y
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_ELEKTOR=y
CONFIG_I2C_PCA_ISA=m
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_PCI=m
# CONFIG_SPI_DW_MID_DMA is not set
CONFIG_SPI_DW_MMIO=y
CONFIG_SPI_GPIO=y
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_FSL_SPI is not set
CONFIG_SPI_OC_TINY=m
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=m
# CONFIG_SPI_SC18IS602 is not set
CONFIG_SPI_TOPCLIFF_PCH=y
CONFIG_SPI_XCOMM=y
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=m
CONFIG_SPI_SLAVE=y
# CONFIG_SPI_SLAVE_TIME is not set
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=m

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=m
CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AS3722=y
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_PALMAS=m
# CONFIG_PINCTRL_RK805 is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=y
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=y
# CONFIG_PINCTRL_DENVERTON is not set
CONFIG_PINCTRL_GEMINILAKE=y
# CONFIG_PINCTRL_LEWISBURG is not set
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
# CONFIG_GPIO_ALTERA is not set
CONFIG_GPIO_AMDPT=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HLWD is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VX855=m
CONFIG_GPIO_XILINX=m

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_GPIO_MM is not set
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=m
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_ADNP=m
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=m
CONFIG_GPIO_CRYSTAL_COVE=y
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP87565=m
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_TIMBERDALE is not set
CONFIG_GPIO_TPS65218=m
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TPS68470=y
CONFIG_GPIO_TWL6040=y
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=m
CONFIG_GPIO_WM8994=m

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=m
CONFIG_GPIO_PCI_IDIO_16=m
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
# CONFIG_GPIO_XRA1403 is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=m
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=m
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=m
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_BATTERY_ACT8945A=m
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=m
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_OLPC=m
CONFIG_BATTERY_SBS=m
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=m
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9150=m
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_88PM860X=m
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LTC3651 is not set
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_BQ2415X=m
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65217 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_CHARGER_RT9455=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=y
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_GPIO_FAN=m
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=m
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=m
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_IR35221=m
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LTC2978 is not set
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_TPS40422=m
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_PWM_FAN=m
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=y
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=y
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
CONFIG_CLOCK_THERMAL=y
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
CONFIG_QORIQ_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=m
CONFIG_WDAT_WDT=m
CONFIG_WM831X_WATCHDOG=y
CONFIG_WM8350_WATCHDOG=m
CONFIG_XILINX_WATCHDOG=m
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=m
CONFIG_RN5T618_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_RETU_WATCHDOG=m
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=y
CONFIG_ALIM7101_WDT=y
CONFIG_EBC_C384_WDT=y
# CONFIG_F71808E_WDT is not set
CONFIG_SP5100_TCO=y
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=m
# CONFIG_ITCO_VENDOR_SUPPORT is not set
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
CONFIG_HP_WATCHDOG=m
# CONFIG_KEMPLD_WDT is not set
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
CONFIG_SCx200_WDT=m
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_SBC8360_WDT is not set
CONFIG_SBC7240_WDT=m
CONFIG_CPU5_WDT=y
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
CONFIG_NIC7018_WDT=y
# CONFIG_MEN_A21_WDT is not set

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=y
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
CONFIG_WDTPCI=m

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_SILENT=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=m
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=m
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_SPI=m
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=m
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=m
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77686=m
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=y
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=m
CONFIG_MFD_RN5T618=m
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=m
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SYSCON is not set
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TPS68470=y
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TI_LP87565=m
CONFIG_MFD_TPS65218=m
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=m
# CONFIG_RAVE_SP_CORE is not set
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM8607=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_ACT8945A=m
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=m
# CONFIG_REGULATOR_AB3100 is not set
CONFIG_REGULATOR_AS3711=m
CONFIG_REGULATOR_AS3722=m
# CONFIG_REGULATOR_CPCAP is not set
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LP87565=m
CONFIG_REGULATOR_LP8788=m
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX14577=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX77686=m
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=m
CONFIG_REGULATOR_MC13XXX_CORE=m
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PCAP is not set
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_RC5T583 is not set
# CONFIG_REGULATOR_RK808 is not set
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS65218=m
CONFIG_REGULATOR_TPS6524X=m
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM831X is not set
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8994=m
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
# CONFIG_IR_RC5_DECODER is not set
# CONFIG_IR_RC6_DECODER is not set
CONFIG_IR_JVC_DECODER=m
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
# CONFIG_IR_IMON_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_HIX5HD2 is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_SPI is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_GPIO_TX is not set
CONFIG_IR_PWM_TX=m
CONFIG_IR_SERIAL=m
# CONFIG_IR_SERIAL_TRANSMITTER is not set
# CONFIG_IR_SIR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=m
CONFIG_AGP_ALI=m
CONFIG_AGP_ATI=m
CONFIG_AGP_AMD=m
CONFIG_AGP_INTEL=m
CONFIG_AGP_NVIDIA=m
CONFIG_AGP_SIS=m
CONFIG_AGP_SWORKS=m
CONFIG_AGP_VIA=m
CONFIG_AGP_EFFICEON=m
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_RADEON=m
# CONFIG_DRM_RADEON_USERPTR is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_ALPHA_SUPPORT=y
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set

#
# drm/i915 Debugging
#
CONFIG_DRM_I915_WERROR=y
CONFIG_DRM_I915_DEBUG=y
# CONFIG_DRM_I915_DEBUG_GEM is not set
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
CONFIG_DRM_I915_SELFTEST=y
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_VGEM=m
CONFIG_DRM_VMWGFX=m
# CONFIG_DRM_VMWGFX_FBCON is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_GMA600 is not set
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_RCAR_DW_HDMI=m
CONFIG_DRM_RCAR_LVDS=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_LVDS=m
CONFIG_DRM_PANEL_SIMPLE=m
CONFIG_DRM_PANEL_ILITEK_IL9322=m
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
# CONFIG_DRM_PANEL_LG_LG4573 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
CONFIG_DRM_PANEL_SITRONIX_ST7789V=m
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_DUMB_VGA_DAC=m
CONFIG_DRM_LVDS_ENCODER=m
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
CONFIG_DRM_NXP_PTN3460=m
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=m
CONFIG_DRM_SII9234=m
CONFIG_DRM_TOSHIBA_TC358767=m
CONFIG_DRM_TI_TFP410=m
# CONFIG_DRM_I2C_ADV7511 is not set
CONFIG_DRM_DW_HDMI=m
# CONFIG_DRM_DW_HDMI_CEC is not set
CONFIG_DRM_ARCPGU=m
CONFIG_DRM_HISI_HIBMC=m
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_EFI is not set
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
# CONFIG_FB_I740 is not set
# CONFIG_FB_I810 is not set
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=m
CONFIG_FB_INTEL=m
CONFIG_FB_INTEL_DEBUG=y
# CONFIG_FB_INTEL_I2C is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=m
CONFIG_FB_ATY128_BACKLIGHT=y
# CONFIG_FB_ATY is not set
CONFIG_FB_S3=m
CONFIG_FB_S3_DDC=y
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=m
# CONFIG_FB_SIS_300 is not set
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=m
CONFIG_FB_VIA_DIRECT_PROCFS=y
CONFIG_FB_VIA_X_COMPATIBILITY=y
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=m
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_IBM_GXT4500=m
# CONFIG_FB_GOLDFISH is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_AUO_K190X=m
CONFIG_FB_AUO_K1900=m
CONFIG_FB_AUO_K1901=m
CONFIG_FB_HYPERV=m
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
CONFIG_FB_SM712=m
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
# CONFIG_LCD_LMS283GF05 is not set
CONFIG_LCD_LTV350QV=m
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
CONFIG_LCD_S6E63M0=m
# CONFIG_LCD_LD9040 is not set
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
# CONFIG_LCD_HX8357 is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_CARILLO_RANCH=m
CONFIG_BACKLIGHT_PWM=m
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=m
# CONFIG_BACKLIGHT_ADP5520 is not set
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_AAT2870=y
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_LP8788 is not set
CONFIG_BACKLIGHT_TPS65217=m
CONFIG_BACKLIGHT_AS3711=m
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
CONFIG_SOUND=m
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=m
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=m
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
CONFIG_HID_KEYTOUCH=m
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=m
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MAYFLASH=m
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=m
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=m
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_HYPERV_MOUSE=m
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=m
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m

#
# I2C HID support
#
CONFIG_I2C_HID=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
# CONFIG_UWB_WHCI is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=m
CONFIG_PWRSEQ_SIMPLE=y
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=m
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_GOLDFISH=m
CONFIG_MMC_SPI=y
CONFIG_MMC_SDRICOH_CS=y
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_CQHCI=m
CONFIG_MMC_TOSHIBA_PCI=m
# CONFIG_MMC_MTK is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
CONFIG_LEDS_AAT1290=m
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_CPCAP is not set
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_NET48XX=m
# CONFIG_LEDS_WRAP is not set
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=m
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DAC124S085=y
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_ADP5520 is not set
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_MENF21BMC=m
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=m

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_AMD76X=m
CONFIG_EDAC_E7XXX=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82875P=m
CONFIG_EDAC_I82975X=m
# CONFIG_EDAC_I3000 is not set
CONFIG_EDAC_I3200=m
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I82860=m
CONFIG_EDAC_R82600=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=m
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_AS3722=m
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_HWMON=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=y
CONFIG_RTC_DRV_LP8788=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_MAX77686=m
CONFIG_RTC_DRV_RK808=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=y
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_ISL12026=m
CONFIG_RTC_DRV_X1205=m
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_PALMAS is not set
# CONFIG_RTC_DRV_TPS6586X is not set
# CONFIG_RTC_DRV_RC5T583 is not set
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=m
CONFIG_RTC_DRV_RX8010=m
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV8803=y

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
CONFIG_RTC_DRV_DS1347=m
# CONFIG_RTC_DRV_DS1390 is not set
CONFIG_RTC_DRV_MAX6916=y
CONFIG_RTC_DRV_R9701=y
CONFIG_RTC_DRV_RX4581=y
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
CONFIG_RTC_DRV_PCF2123=y
CONFIG_RTC_DRV_MCP795=m
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
CONFIG_RTC_DRV_DS1286=y
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=m
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
CONFIG_RTC_DRV_DS17285=y
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DS1685_PROC_REGS is not set
# CONFIG_RTC_DS1685_SYSFS_REGS is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=m
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_V3020=m
CONFIG_RTC_DRV_WM831X=m
# CONFIG_RTC_DRV_WM8350 is not set
CONFIG_RTC_DRV_AB3100=y
# CONFIG_RTC_DRV_ZYNQMP is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=m
CONFIG_RTC_DRV_PCAP=y
# CONFIG_RTC_DRV_MC13XXX is not set
CONFIG_RTC_DRV_SNVS=y
# CONFIG_RTC_DRV_MT6397 is not set
# CONFIG_RTC_DRV_R7301 is not set
# CONFIG_RTC_DRV_CPCAP is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
CONFIG_PCH_DMA=y
# CONFIG_TIMB_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
CONFIG_UIO_CIF=m
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
CONFIG_UIO_SERCOS3=m
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
CONFIG_UIO_HV_GENERIC=m
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
# CONFIG_HYPERV_BALLOON is not set
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_BUS=y
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
# CONFIG_CLK_HSDK is not set
CONFIG_COMMON_CLK_MAX77686=m
CONFIG_COMMON_CLK_RK808=m
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=m
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=m
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IOVA=y
CONFIG_OF_IOMMU=y
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
CONFIG_SOUNDWIRE_BUS=m
CONFIG_SOUNDWIRE_CADENCE=m
CONFIG_SOUNDWIRE_INTEL=m

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
# CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND is not set
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=m

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=m
CONFIG_EXTCON_MAX14577=m
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77843=m
# CONFIG_EXTCON_PALMAS is not set
CONFIG_EXTCON_RT8973A=m
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=m
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_ATMEL_HLCDC_PWM=y
CONFIG_PWM_CRC=y
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_LP3943 is not set
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
CONFIG_PWM_LPSS_PLATFORM=m
CONFIG_PWM_PCA9685=m

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
# CONFIG_RESET_CONTROLLER is not set
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
CONFIG_FMC_TRIVIAL=m
CONFIG_FMC_WRITE_EEPROM=m
# CONFIG_FMC_CHARDEV is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_DAX=m
CONFIG_NVMEM=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_ALTERA_PR_IP_CORE_PLAT=m
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
CONFIG_FPGA_MGR_ALTERA_CVP=m
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_MGR_ICE40_SPI=m
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FSI is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
# CONFIG_SLIMBUS is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_COREBOOT_TABLE_ACPI=y
CONFIG_GOOGLE_COREBOOT_TABLE_OF=m
# CONFIG_GOOGLE_MEMCONSOLE_COREBOOT is not set
# CONFIG_GOOGLE_VPD is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
# CONFIG_EFI_RUNTIME_MAP is not set
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH is not set
CONFIG_EFI_TEST=y
CONFIG_UEFI_CPER=y

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=m
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ECRYPT_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_FS_WBUF_VERIFY=y
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_CRAMFS=y
CONFIG_CRAMFS_MTD=y
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_MTD=y
CONFIG_ROMFS_ON_MTD=y
# CONFIG_PSTORE is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=m
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=m
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=y
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_LIST_SORT=m
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=m
# CONFIG_TEST_HEXDUMP is not set
CONFIG_TEST_STRING_HELPERS=m
CONFIG_TEST_KSTRTOX=y
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_HASH=y
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
# CONFIG_TEST_BPF is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_TEST_UDELAY=m
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=m
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_INTEL_TXT=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=m
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=m
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_SALSA20_586 is not set
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SPECK is not set
CONFIG_CRYPTO_TEA=m
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=m
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=m
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=m
CONFIG_UCS2_STRING=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_PRIME_NUMBERS=m
# CONFIG_STRING_SELFTEST is not set

--o4bgh4uvgwqptlb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-openwrt-lkp-hsw01-15:20180418191103:i386-randconfig-c0-04181855:4.17.0-rc1:46"

#!/bin/bash

kernel=$1
initrd=openwrt-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/openwrt/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep
	-kernel $kernel
	-initrd $initrd
	-m 256
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--o4bgh4uvgwqptlb4--
