Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeCCUYT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 15:24:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:30481 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752299AbeCCUYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 15:24:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,419,1515484800";
   d="gz'50?scan'50,208,50";a="34407513"
Date: Sun, 4 Mar 2018 04:23:55 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: [tip:WIP.sched/core 19/20] arch/tile/include/asm/switch_to.h:36:0:
 warning: "prepare_arch_switch" redefined
Message-ID: <201803040452.OTVZczra%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.sched/core
head:   bb3aa6d89286e954fc5c670413c762dca3f4cc44
commit: 8c5e90d837fb1b1b0dda3db559b97bdab9c62853 [19/20] sched/headers: Simplify and clean up header usage in the scheduler
config: tile-tilegx_defconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8c5e90d837fb1b1b0dda3db559b97bdab9c62853
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/core.c:10:0:
>> arch/tile/include/asm/switch_to.h:36:0: warning: "prepare_arch_switch" redefined
    #define prepare_arch_switch(next) _prepare_arch_switch(next)
    
   In file included from kernel/sched/core.c:8:0:
   kernel/sched/sched.h:1392:0: note: this is the location of the previous definition
    # define prepare_arch_switch(next) do { } while (0)
    
   In file included from kernel/sched/core.c:10:0:
>> arch/tile/include/asm/switch_to.h:58:0: warning: "finish_arch_post_lock_switch" redefined
    #define finish_arch_post_lock_switch() do {                               \
    
   In file included from kernel/sched/core.c:8:0:
   kernel/sched/sched.h:1395:0: note: this is the location of the previous definition
    # define finish_arch_post_lock_switch() do { } while (0)
    
--
   In file included from kernel//sched/core.c:10:0:
>> arch/tile/include/asm/switch_to.h:36:0: warning: "prepare_arch_switch" redefined
    #define prepare_arch_switch(next) _prepare_arch_switch(next)
    
   In file included from kernel//sched/core.c:8:0:
   kernel//sched/sched.h:1392:0: note: this is the location of the previous definition
    # define prepare_arch_switch(next) do { } while (0)
    
   In file included from kernel//sched/core.c:10:0:
>> arch/tile/include/asm/switch_to.h:58:0: warning: "finish_arch_post_lock_switch" redefined
    #define finish_arch_post_lock_switch() do {                               \
    
   In file included from kernel//sched/core.c:8:0:
   kernel//sched/sched.h:1395:0: note: this is the location of the previous definition
    # define finish_arch_post_lock_switch() do { } while (0)
    

vim +/prepare_arch_switch +36 arch/tile/include/asm/switch_to.h

bd119c69 David Howells 2012-03-28  32  
bd119c69 David Howells 2012-03-28  33  /*
bd119c69 David Howells 2012-03-28  34   * Pause the DMA engine and static network before task switching.
bd119c69 David Howells 2012-03-28  35   */
bd119c69 David Howells 2012-03-28 @36  #define prepare_arch_switch(next) _prepare_arch_switch(next)
bd119c69 David Howells 2012-03-28  37  void _prepare_arch_switch(struct task_struct *next);
bd119c69 David Howells 2012-03-28  38  
bd119c69 David Howells 2012-03-28  39  struct task_struct;
bd119c69 David Howells 2012-03-28  40  #define switch_to(prev, next, last) ((last) = _switch_to((prev), (next)))
bd119c69 David Howells 2012-03-28  41  extern struct task_struct *_switch_to(struct task_struct *prev,
bd119c69 David Howells 2012-03-28  42  				      struct task_struct *next);
bd119c69 David Howells 2012-03-28  43  
bd119c69 David Howells 2012-03-28  44  /* Helper function for _switch_to(). */
bd119c69 David Howells 2012-03-28  45  extern struct task_struct *__switch_to(struct task_struct *prev,
bd119c69 David Howells 2012-03-28  46  				       struct task_struct *next,
bd119c69 David Howells 2012-03-28  47  				       unsigned long new_system_save_k_0);
bd119c69 David Howells 2012-03-28  48  
bd119c69 David Howells 2012-03-28  49  /* Address that switched-away from tasks are at. */
bd119c69 David Howells 2012-03-28  50  extern unsigned long get_switch_to_pc(void);
bd119c69 David Howells 2012-03-28  51  
bd119c69 David Howells 2012-03-28  52  /*
bd119c69 David Howells 2012-03-28  53   * Kernel threads can check to see if they need to migrate their
bd119c69 David Howells 2012-03-28  54   * stack whenever they return from a context switch; for user
bd119c69 David Howells 2012-03-28  55   * threads, we defer until they are returning to user-space.
fe363adb Chris Metcalf 2015-07-29  56   * We defer homecache migration until the runqueue lock is released.
bd119c69 David Howells 2012-03-28  57   */
fe363adb Chris Metcalf 2015-07-29 @58  #define finish_arch_post_lock_switch() do {                               \
1eaef888 Chris Metcalf 2015-08-05  59  	__insn_mtspr(SPR_SIM_CONTROL, SIM_CONTROL_OS_SWITCH |             \
1eaef888 Chris Metcalf 2015-08-05  60  		(current->pid << _SIM_CONTROL_OPERATOR_BITS));            \
bd119c69 David Howells 2012-03-28  61  	if (current->mm == NULL && !kstack_hash &&                        \
fe363adb Chris Metcalf 2015-07-29  62  	    current_thread_info()->homecache_cpu != raw_smp_processor_id()) \
bd119c69 David Howells 2012-03-28  63  		homecache_migrate_kthread();                              \
bd119c69 David Howells 2012-03-28  64  } while (0)
bd119c69 David Howells 2012-03-28  65  

:::::: The code at line 36 was first introduced by commit
:::::: bd119c69239322caafdb64517a806037d0d0c70a Disintegrate asm/system.h for Tile

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--Nq2Wo0NMKNjxTN9z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
aLr8WMmD58Xyf5O5VMYkBQEA

--Nq2Wo0NMKNjxTN9z--
