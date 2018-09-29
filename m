Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A15C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE218206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE218206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeI3ESW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51528 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbeI3ESV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:21 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000Gs-BU; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006or-4N; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org
Date:   Sat, 29 Sep 2018 22:43:06 +0100
Message-ID: <lsq.1538257386.330095874@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 000/131] 3.16.59-rc1 review
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.16.59 release.
There are 131 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon Oct 01 21:43:06 UTC 2018.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.16.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Andi Kleen (10):
      x86/mm/kmmio: Make the tracer robust against L1TF
         [1063711b57393c1999248cccb57bebfaf16739e7]
      x86/mm/pat: Make set_memory_np() L1TF safe
         [958f79b9ee55dfaf00c8106ed1c22a2919e0028b]
      x86/speculation/l1tf: Add sysfs reporting for l1tf
         [17dbca119312b4e8173d4e25ff64262119fcef38]
      x86/speculation/l1tf: Disallow non privileged high MMIO PROT_NONE mappings
         [42e4089c7890725fcd329999252dc489b72f2921]
      x86/speculation/l1tf: Increase 32bit PAE __PHYSICAL_PAGE_SHIFT
         [50896e180c6aa3a9c61a26ced99e15d602666a4c]
      x86/speculation/l1tf: Invert all not present mappings
         [f22cc87f6c1f771b57c407555cfefd811cdd9507]
      x86/speculation/l1tf: Limit swap file size to MAX_PA/2
         [377eeaa8e11fe815b1d07c81c4a0e2843a8c15eb]
      x86/speculation/l1tf: Make pmd/pud_mknotpresent() invert
         [0768f91530ff46683e0b372df14fd79fe8d156e5]
      x86/speculation/l1tf: Make sure the first page is always reserved
         [10a70416e1f067f6c4efda6ffd8ea96002ac4223]
      x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation
         [6b28baca9b1f0d4a42b865da7a05b1c81424bd5c]

Andy Lutomirski (2):
      mm/vmstat: Make NR_TLB_REMOTE_FLUSH_RECEIVED available even on UP
         [5dd0b16cdaff9b94da06074d5888b03235c0bf17]
      mm: Add vm_insert_pfn_prot()
         [1745cbc5d0dee0749a6bc0ea8e872c5db0074061]

Andy Whitcroft (1):
      floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl
         [65eea8edc315589d6c993cf12dbb5d0e9ef1fe4e]

Ben Hutchings (3):
      x86/cpufeatures: Show KAISER in cpuinfo
         [not upstream; upstream shows the related PTI feature]
      x86/speculation/l1tf: Protect NUMA-balance entries against L1TF
         [not upstream; these functions were removed in 4.0]
      x86: mm: Add PUD functions
         [a00cc7d9dd93d66a3fb83fc52aa57a4bec51c517]

Borislav Petkov (3):
      Documentation/spec_ctrl: Do some minor cleanups
         [dd0792699c4058e63c0715d9a7c2d40226fcdddc]
      x86/bugs: Unify x86_spec_ctrl_{set_guest,restore_host}
         [cc69b34989210f067b2c51d5539b5f96ebcc3a01]
      x86/speculation: Use synthetic bits for IBRS/IBPB/STIBP
         [e7c587da125291db39ddf1f49b18e5970adbac17]

Dan Williams (1):
      mm: fix cache mode tracking in vm_insert_mixed()
         [87744ab3832b83ba71b931f86f9cfdb000d07da5]

Daniel Rosenberg (1):
      HID: debug: check length before copy_to_user()
         [717adfdaf14704fd3ec7fa2c04520c0723247eac]

Dave Airlie (2):
      drm/drivers: add support for using the arch wc mapping API.
         [7cf321d118a825c1541b43ca45294126fd474efa]
      x86/io: add interface to reserve io memtype for a resource range. (v1.1)
         [8ef4227615e158faa4ee85a1d6466782f7e22f2f]

Dave Hansen (1):
      x86/mm: Move swap offset/type up in PTE to work around erratum
         [00839ee3b299303c6a5e26a0a2485427a3afcbbf]

Finn Thain (1):
      via-cuda: Use spinlock_irq_save/restore instead of enable/disable_irq
         [ac39452e942af6a212e8f89e8a36b71354323845]

Jim Mattson (1):
      x86/cpu: Make alternative_msr_write work for 32-bit code
         [5f2b745f5e1304f438f9b2cd03ebc8120b6e0d3b]

Jiri Kosina (3):
      x86/bugs: Fix __ssb_select_mitigation() return type
         [d66d8ff3d21667b41eddbe86b35ab411e40d8c5f]
      x86/bugs: Make cpu_show_common() static
         [7bb4d366cba992904bffa4820d24e70a3de93e76]
      x86/speculation/l1tf: Unbreak !__HAVE_ARCH_PFN_MODIFY_ALLOWED architectures
         [6c26fcd2abfe0a56bbd95271fce02df2896cfd24]

Juergen Gross (1):
      x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths
         [74899d92e66663dc7671a8017b3146dcd4735f3b]

Kees Cook (6):
      exec: Limit arg stack to at most 75% of _STK_LIM
         [da029c11e6b12f321f36dac8771e833b65cec962]
      nospec: Allow getting/setting on non-current task
         [7bbf1373e228840bb0295a2ca26d548ef37f448e]
      proc: Provide details on speculation flaw mitigations
         [fae1fa0fc6cca8beee3ab8ed71d54f9a78fa3f64]
      seccomp: Add filter flag to opt-out of SSB mitigation
         [00a02d0c502a06d15e07b857f8ff921e3e402675]
      seccomp: Enable speculation flaw mitigations
         [5c3070890d06ff82eecb808d02d2ca39169533ef]
      x86/speculation: Make "seccomp" the default mode for Speculative Store Bypass
         [f21b53b20c754021935ea43364dbf53778eeba32]

Kirill A. Shutemov (39):
      alpha: drop _PAGE_FILE and pte_file()-related helpers
         [b816157a5366550c5ee29a6431ba1abb88721266]
      arc: drop _PAGE_FILE and pte_file()-related helpers
         [18747151308f9e0fb63766057957617ec4afa190]
      arm64: drop PTE_FILE and pte_file()-related helpers
         [9b3e661e58b90b0c2d5c2168c23408f1e59e9e35]
      arm: drop L_PTE_FILE and pte_file()-related helpers
         [b007ea798f5c568d3f464d37288220ef570f062c]
      asm-generic: drop unused pte_file* helpers
         [5064c8e19dc215afae8ffae95570e7f22062d49c]
      avr32: drop _PAGE_FILE and pte_file()-related helpers
         [7a7d2db4b8b3505a3195178619ffcc80985c4be1]
      blackfin: drop pte_file()
         [2bc6ff14d46745a7728ed4ed90c5e0edca91f52e]
      c6x: drop pte_file()
         [f5b45de9b00eb53d11ada85c61e4ea1c31ab8218]
      cris: drop _PAGE_FILE and pte_file()-related helpers
         [103f3d9a26df944f4c29de190d72dfbf913c71af]
      frv: drop _PAGE_FILE and pte_file()-related helpers
         [ca5bfa7b390017f053d7581bc701518b87bc3d43]
      hexagon: drop _PAGE_FILE and pte_file()-related helpers
         [d99f95e6522db22192c331c75de182023a49fbcc]
      ia64: drop _PAGE_FILE and pte_file()-related helpers
         [636a002b704e0a36cefb5f4cf0293fab858fc46c]
      m32r: drop _PAGE_FILE and pte_file()-related helpers
         [406b16e26d0996516c8d1641008a7d326bf282d6]
      m68k: drop _PAGE_FILE and pte_file()-related helpers
         [1eeda0abf4425c91e7ce3ca32f1908c3a51bf84e]
      metag: drop _PAGE_FILE and pte_file()-related helpers
         [22f9bf3950f20d24198791685f2dccac2c4ef38a]
      microblaze: drop _PAGE_FILE and pte_file()-related helpers
         [937fa39fb22fea1c1d8ca9e5f31c452b91ac7239]
      mips: drop _PAGE_FILE and pte_file()-related helpers
         [b32da82e28ce90bff4e371fc15d2816fa3175bb0]
      mm: drop support of non-linear mapping from fault codepath
         [9b4bdd2ffab9557ac43af7dff02e7dab1c8c58bd]
      mm: drop support of non-linear mapping from unmap/zap codepath
         [8a5f14a23177061ec11daeaa3d09d0765d785c47]
      mm: drop vm_ops->remap_pages and generic_file_remap_pages() stub
         [d83a08db5ba6072caa658745881f4baa9bad6a08]
      mm: fix regression in remap_file_pages() emulation
         [48f7df329474b49d83d0dffec1b6186647f11976]
      mm: remove rest usage of VM_NONLINEAR and pte_file()
         [0661a33611fca12570cba48d9344ce68834ee86c]
      mm: replace remap_file_pages() syscall with emulation
         [c8d78c1823f46519473949d33f0d1d33fe21ea16]
      mm: replace vma->sharead.linear with vma->shared
         [ac51b934f3912582d3c897c6c4d09b32ea57b2c7]
      mn10300: drop _PAGE_FILE and pte_file()-related helpers
         [6bf63a8ccb1dccd6ab81bc8bc46863493629cdb8]
      openrisc: drop _PAGE_FILE and pte_file()-related helpers
         [3824e3cf7e865b2ff0b71de23b16e332fe6a853a]
      parisc: drop _PAGE_FILE and pte_file()-related helpers
         [8d55da810f1fabcf1d4c0bbc46205e5f2c0fa84b]
      powerpc: drop _PAGE_FILE and pte_file()-related helpers
         [780fc5642f59b6c6e2b05794de60b2d2ad5f040e]
      proc: drop handling non-linear mappings
         [1da4b35b001481df99a6dcab12d5d39a876f7056]
      rmap: drop support of non-linear mappings
         [27ba0644ea9dfe6e7693abc85837b60e40583b96]
      s390: drop pte_file()-related helpers
         [6e76d4b20bf6b514408ab5bd07f4a76723259b64]
      score: drop _PAGE_FILE and pte_file()-related helpers
         [917e401ea75478d4f4575bc8b0ef3d14ecf9ef69]
      sh: drop _PAGE_FILE and pte_file()-related helpers
         [8b70beac99466b6d164de9fe647b3567e6f17e3a]
      sparc: drop pte_file()-related helpers
         [6a8c4820895cf1dd2a128aef67ce079ba6eded80]
      tile: drop pte_file()-related helpers
         [eb12f4872a3845a8803f689646dea5b92a30aff7]
      um: drop _PAGE_FILE and pte_file()-related helpers
         [3513006a5691ae3629eef9ddef0b71a47c40dfbc]
      unicore32: drop pte_file()-related helpers
         [40171798fe11a6dc1d963058b097b2c4c9d34a9c]
      x86: drop _PAGE_FILE and pte_file()-related helpers
         [0a191362058391878cc2a4d4ccddcd8223eb4f79]
      xtensa: drop _PAGE_FILE and pte_file()-related helpers
         [d9ecee281b8f89da6d3203be62802eda991e37cc]

Konrad Rzeszutek Wilk (17):
      KVM/VMX: Expose SSBD properly to guests
         [0aa48468d00959c8a37cd3ac727284f4f7359151]
      proc: Use underscores for SSBD in 'status'
         [e96f46ee8587607a828f783daa6eb5b44d25004d]
      x86/KVM/VMX: Expose SPEC_CTRL Bit(2) to the guest
         [da39556f66f5cfe8f9c989206974f1cb16ca5d7c]
      x86/bugs, KVM: Support the combination of guest and host IBRS
         [5cf687548705412da47c9cec342fd952d71ed3d5]
      x86/bugs/AMD: Add support to disable RDS on Fam[15,16,17]h if requested
         [764f3c21588a059cd783c6ba0734d4db2d72822d]
      x86/bugs/intel: Set proper CPU features and setup RDS
         [772439717dbf703b39990be58d8d4e3e4ad0598a]
      x86/bugs: Concentrate bug detection into a separate function
         [4a28bfe3267b68e22c663ac26185aa16c9b879ef]
      x86/bugs: Concentrate bug reporting into a separate function
         [d1059518b4789cabe34bb4b714d07e6089c82ca1]
      x86/bugs: Expose /sys/../spec_store_bypass
         [c456442cd3a59eeb1d60293c26cbe2ff2c4e42cf]
      x86/bugs: Fix the parameters alignment and missing void
         [ffed645e3be0e32f8e9ab068d257aee8d0fe8eec]
      x86/bugs: Move the l1tf function and define pr_fmt properly
         [56563f53d3066afa9e63d6c997bf67e76a8b05c0]
      x86/bugs: Provide boot parameters for the spec_store_bypass_disable mitigation
         [24f7fc83b9204d20f878c57cb77d261ae825e033]
      x86/bugs: Read SPEC_CTRL MSR during boot and re-use reserved bits
         [1b86883ccb8d5d9506529d42dbe1a5257cb30b18]
      x86/bugs: Rename SSBD_NO to SSB_NO
         [240da953fcc6a9008c92fae5b1f727ee5ed167ab]
      x86/bugs: Rename _RDS to _SSBD
         [9f65fb29374ee37856dbad847b4e121aab72b510]
      x86/bugs: Whitelist allowed SPEC_CTRL MSR values
         [1115a859f33276fe8afb31c60cf9d8e657872558]
      x86/cpufeatures: Add X86_FEATURE_RDS
         [0cc5fa00b0a88dad140b4e5c2cead9951ad36822]

Linus Torvalds (3):
      x86/nospec: Simplify alternative_msr_write()
         [1aa7a5735a41418d8e01fa7c9565eb2657e2ea3f]
      x86/speculation/l1tf: Change order of offset/type in swap entry
         [bcd11afa7adad8d720e7ba5ef58bdcd9775cf45f]
      x86/speculation/l1tf: Protect swap entries against L1TF
         [2f22b4cd45b67b3496f4aa4c7180a1271c6452f6]

Markus Trippelsdorf (1):
      x86/tools: Fix gcc-7 warning in relocs.c
         [7ebb916782949621ff6819acf373a06902df7679]

Michal Hocko (1):
      x86/speculation/l1tf: Fix up pte->pfn conversion for PAE
         [e14d7dfb41f5807a0c1c26a13f2b8ef16af24935]

Naoya Horiguchi (3):
      mm/pagewalk: remove pgd_entry() and pud_entry()
         [0b1fbfe50006c41014cc25660c0e735d21c34939]
      mm: x86: move _PAGE_SWP_SOFT_DIRTY from bit 7 to bit 1
         [eee4818baac0f2b37848fdf90e4b16430dc536ac]
      pagewalk: improve vma handling
         [fafaa4264eba49fd10695c193a82760558d093f4]

Sean Christopherson (1):
      x86/speculation/l1tf: Exempt zeroed PTEs from inversion
         [f19f5c49bbc3ffcc9126cc245fc1b24cc29f4a37]

Thomas Gleixner (19):
      KVM: SVM: Move spec control call after restore of GS
         [15e6c22fd8e5a42c5ed6d487b7c9fe44c2517765]
      KVM: x86: SVM: Call x86_spec_ctrl_set_guest/host() with interrupts disabled
         [024d83cadc6b2af027e473720f3c3da97496c318]
      prctl: Add force disable speculation
         [356e4bfff2c5489e016fdb925adbf12a1e3950ee]
      prctl: Add speculation control prctls
         [b617cfc858161140d69cc0b5cc211996b557a1c7]
      seccomp: Move speculation migitation control to arch code
         [8bf37d8c067bb7eb8e7c381bdadf9bd89182b6bc]
      seccomp: Use PR_SPEC_FORCE_DISABLE
         [b849a812f7eb92e96d1c8239b06581b2cfd8b275]
      x86/bugs, KVM: Extend speculation control for VIRT_SPEC_CTRL
         [ccbcd2674472a978b48c91c1fbfb66c0ff959f24]
      x86/bugs: Expose x86_spec_ctrl_base directly
         [fa8ac4988249c38476f6ad678a4848a736373403]
      x86/bugs: Remove x86_spec_ctrl_set()
         [4b59bdb569453a60b752b274ca61f009e37f4dae]
      x86/bugs: Rework spec_ctrl base and mask logic
         [be6fcb5478e95bb1c91f489121238deb3abca46a]
      x86/cpufeatures: Add FEATURE_ZEN
         [d1035d971829dcf80e8686ccde26f94b0a069472]
      x86/cpufeatures: Disentangle MSR_SPEC_CTRL enumeration from IBRS
         [7eb8956a7fec3c1f0abc2a5517dada99ccc8a961]
      x86/cpufeatures: Disentangle SSBD enumeration
         [52817587e706686fcdb27f14c1b000c92f266c96]
      x86/process: Allow runtime control of Speculative Store Bypass
         [885f82bfbc6fefb6664ea27965c3ab9ac4194b8c]
      x86/speculation, KVM: Implement support for VIRT_SPEC_CTRL/LS_CFG
         [47c61b3955cf712cadfc25635bf9bc174af030ea]
      x86/speculation: Add prctl for Speculative Store Bypass mitigation
         [a73ec77ee17ec556fe7f165d00314cb7c047b1ac]
      x86/speculation: Create spec-ctrl.h to avoid include hell
         [28a2775217b17208811fa43a9e96bd1fdf417b86]
      x86/speculation: Handle HT correctly on AMD
         [1f50ddb4f4189243c05926b842dc1a0332195f31]
      x86/speculation: Rework speculative_store_bypass_update()
         [0270be3e34efb05a88bc4c422572ece038ef3608]

Tom Lendacky (2):
      KVM: SVM: Implement VIRT_SPEC_CTRL support for SSBD
         [bc226f07dcd3c9ef0b7f6236fe356ea4a9cb4769]
      x86/speculation: Add virtualized speculative store bypass disable support
         [11fb0683493b2da112cd64c9dada221b52463bf7]

Tyler Hicks (2):
      irda: Fix memory leak caused by repeated binds of irda socket
         [not upstream; irda has been removed]
      irda: Only insert new objects into the global database via setsockopt
         [not upstream; irda has been removed]

Vincent Pelletier (1):
      scsi: target: iscsi: Use hex2bin instead of a re-implementation
         [1816494330a83f2a064499d8ed2797045641f92c]

Vlastimil Babka (6):
      x86/init: fix build with CONFIG_SWAP=n
         [792adb90fa724ce07c0171cbc96b9215af4b1045]
      x86/speculation/l1tf: Extend 64bit swap file size limit
         [1a7ed1ba4bba6c075d5ad61bb75e3fbc870840d6]
      x86/speculation/l1tf: Fix off-by-one error when warning that system has too much RAM
         [b0a182f875689647b014bc01d36b340217792852]
      x86/speculation/l1tf: Fix overflow in l1tf_pfn_limit() on 32bit
         [9df9516940a61d29aedf4d91b483ca6597e7d480]
      x86/speculation/l1tf: Protect PAE swap entries against L1TF
         [0d0f6249058834ffe1ceaad0bb31464af66f6e7a]
      x86/speculation/l1tf: Suggest what to do on systems with too much RAM
         [6a012288d6906fee1dbc244050ade1dafe4a9c8d]

 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/cachetlb.txt                         |   8 +-
 Documentation/kernel-parameters.txt                |  45 +++
 Documentation/spec_ctrl.rst                        |  94 +++++
 Documentation/vm/remap_file_pages.txt              |   7 +-
 Makefile                                           |   4 +-
 arch/alpha/include/asm/pgtable.h                   |   7 -
 arch/arc/include/asm/pgtable.h                     |  13 +-
 arch/arm/include/asm/pgtable-2level.h              |   1 -
 arch/arm/include/asm/pgtable-3level.h              |   1 -
 arch/arm/include/asm/pgtable-nommu.h               |   2 -
 arch/arm/include/asm/pgtable.h                     |  20 +-
 arch/arm/mm/proc-macros.S                          |   2 +-
 arch/arm64/include/asm/pgtable.h                   |  22 +-
 arch/avr32/include/asm/pgtable.h                   |  25 --
 arch/blackfin/include/asm/pgtable.h                |   5 -
 arch/c6x/include/asm/pgtable.h                     |   5 -
 arch/cris/include/arch-v10/arch/mmu.h              |   3 -
 arch/cris/include/arch-v32/arch/mmu.h              |   3 -
 arch/cris/include/asm/pgtable.h                    |   4 -
 arch/frv/include/asm/pgtable.h                     |  27 +-
 arch/hexagon/include/asm/pgtable.h                 |  60 +--
 arch/ia64/include/asm/pgtable.h                    |  25 +-
 arch/m32r/include/asm/pgtable-2level.h             |   4 -
 arch/m32r/include/asm/pgtable.h                    |  11 -
 arch/m68k/include/asm/mcf_pgtable.h                |  23 +-
 arch/m68k/include/asm/motorola_pgtable.h           |  15 -
 arch/m68k/include/asm/pgtable_no.h                 |   2 -
 arch/m68k/include/asm/sun3_pgtable.h               |  15 -
 arch/metag/include/asm/pgtable.h                   |   6 -
 arch/microblaze/include/asm/pgtable.h              |  11 -
 arch/mips/include/asm/pgtable-32.h                 |  39 --
 arch/mips/include/asm/pgtable-64.h                 |   9 -
 arch/mips/include/asm/pgtable-bits.h               |  10 -
 arch/mips/include/asm/pgtable.h                    |   2 -
 arch/mn10300/include/asm/pgtable.h                 |  17 +-
 arch/openrisc/include/asm/pgtable.h                |   8 -
 arch/openrisc/kernel/head.S                        |   5 -
 arch/parisc/include/asm/pgtable.h                  |  10 -
 arch/powerpc/include/asm/pgtable-ppc32.h           |   9 +-
 arch/powerpc/include/asm/pgtable-ppc64.h           |   5 +-
 arch/powerpc/include/asm/pgtable.h                 |   1 -
 arch/powerpc/include/asm/pte-40x.h                 |   1 -
 arch/powerpc/include/asm/pte-44x.h                 |   5 -
 arch/powerpc/include/asm/pte-8xx.h                 |   1 -
 arch/powerpc/include/asm/pte-book3e.h              |   1 -
 arch/powerpc/include/asm/pte-fsl-booke.h           |   3 -
 arch/powerpc/include/asm/pte-hash32.h              |   1 -
 arch/powerpc/include/asm/pte-hash64.h              |   1 -
 arch/powerpc/mm/pgtable_64.c                       |   2 +-
 arch/s390/include/asm/pgtable.h                    |  29 +-
 arch/score/include/asm/pgtable-bits.h              |   1 -
 arch/score/include/asm/pgtable.h                   |  18 +-
 arch/sh/include/asm/pgtable_32.h                   |  30 +-
 arch/sh/include/asm/pgtable_64.h                   |   9 +-
 arch/sparc/include/asm/pgtable_32.h                |  24 --
 arch/sparc/include/asm/pgtable_64.h                |  40 --
 arch/sparc/include/asm/pgtsrmmu.h                  |  14 +-
 arch/tile/include/asm/pgtable.h                    |  11 -
 arch/tile/mm/homecache.c                           |   4 -
 arch/um/include/asm/pgtable-2level.h               |   9 -
 arch/um/include/asm/pgtable-3level.h               |  20 -
 arch/um/include/asm/pgtable.h                      |   9 -
 arch/unicore32/include/asm/pgtable-hwdef.h         |   1 -
 arch/unicore32/include/asm/pgtable.h               |  14 -
 arch/x86/include/asm/cpufeature.h                  |  21 +-
 arch/x86/include/asm/io.h                          |   6 +
 arch/x86/include/asm/kvm_host.h                    |   1 +
 arch/x86/include/asm/nospec-branch.h               |  43 +-
 arch/x86/include/asm/page_32_types.h               |   9 +-
 arch/x86/include/asm/pgtable-2level.h              |  55 +--
 arch/x86/include/asm/pgtable-3level.h              |  49 ++-
 arch/x86/include/asm/pgtable-invert.h              |  41 ++
 arch/x86/include/asm/pgtable.h                     | 144 +++++--
 arch/x86/include/asm/pgtable_64.h                  |  60 ++-
 arch/x86/include/asm/pgtable_types.h               |  13 +-
 arch/x86/include/asm/processor.h                   |   5 +
 arch/x86/include/asm/spec-ctrl.h                   |  80 ++++
 arch/x86/include/asm/thread_info.h                 |  10 +-
 arch/x86/include/uapi/asm/msr-index.h              |   9 +
 arch/x86/kernel/cpu/amd.c                          |  22 +
 arch/x86/kernel/cpu/bugs.c                         | 441 ++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c                       |  97 ++++-
 arch/x86/kernel/cpu/cpu.h                          |   3 +
 arch/x86/kernel/cpu/intel.c                        |   3 +
 arch/x86/kernel/process.c                          | 146 +++++++
 arch/x86/kernel/setup.c                            |   6 +
 arch/x86/kernel/smpboot.c                          |   5 +
 arch/x86/kvm/cpuid.c                               |  21 +-
 arch/x86/kvm/cpuid.h                               |  16 +-
 arch/x86/kvm/svm.c                                 |  72 +++-
 arch/x86/kvm/vmx.c                                 |  27 +-
 arch/x86/kvm/x86.c                                 |   7 +-
 arch/x86/mm/init.c                                 |  24 ++
 arch/x86/mm/kmmio.c                                |  25 +-
 arch/x86/mm/mmap.c                                 |  21 +
 arch/x86/mm/pageattr.c                             |   6 +-
 arch/x86/mm/pat.c                                  |  14 +
 arch/x86/tools/relocs.c                            |   5 +-
 arch/x86/xen/smp.c                                 |   5 +
 arch/xtensa/include/asm/pgtable.h                  |  10 -
 drivers/base/cpu.c                                 |  16 +
 drivers/block/floppy.c                             |   3 +
 drivers/gpu/drm/ast/ast_ttm.c                      |   6 +
 drivers/gpu/drm/cirrus/cirrus_ttm.c                |   7 +
 drivers/gpu/drm/drm_vma_manager.c                  |   3 +-
 drivers/gpu/drm/mgag200/mgag200_ttm.c              |   7 +
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |   8 +
 drivers/gpu/drm/radeon/radeon_object.c             |   5 +
 drivers/hid/hid-debug.c                            |   8 +-
 drivers/macintosh/via-cuda.c                       |  16 +-
 drivers/target/iscsi/iscsi_target_auth.c           |  30 +-
 fs/9p/vfs_file.c                                   |   2 -
 fs/btrfs/file.c                                    |   1 -
 fs/ceph/addr.c                                     |   1 -
 fs/cifs/file.c                                     |   1 -
 fs/exec.c                                          |  11 +-
 fs/ext4/file.c                                     |   1 -
 fs/f2fs/file.c                                     |   1 -
 fs/fuse/file.c                                     |   1 -
 fs/gfs2/file.c                                     |   1 -
 fs/inode.c                                         |   1 -
 fs/nfs/file.c                                      |   1 -
 fs/nilfs2/file.c                                   |   1 -
 fs/ocfs2/mmap.c                                    |   1 -
 fs/proc/array.c                                    |  26 ++
 fs/proc/task_mmu.c                                 |  15 -
 fs/ubifs/file.c                                    |   1 -
 fs/xfs/xfs_file.c                                  |   1 -
 include/asm-generic/pgtable.h                      |  27 +-
 include/linux/cpu.h                                |   4 +
 include/linux/fs.h                                 |   6 +-
 include/linux/io.h                                 |  22 +
 include/linux/mm.h                                 |  50 +--
 include/linux/mm_types.h                           |  12 +-
 include/linux/nospec.h                             |  10 +
 include/linux/rmap.h                               |   2 -
 include/linux/sched.h                              |  10 +-
 include/linux/seccomp.h                            |   2 +
 include/linux/swapfile.h                           |   2 +
 include/linux/swapops.h                            |   4 +-
 include/linux/vm_event_item.h                      |   2 -
 include/uapi/linux/prctl.h                         |  12 +
 include/uapi/linux/seccomp.h                       |   3 +
 kernel/fork.c                                      |   8 +-
 kernel/seccomp.c                                   |  16 +-
 kernel/sys.c                                       |  23 ++
 mm/Makefile                                        |   2 +-
 mm/filemap.c                                       |   1 -
 mm/filemap_xip.c                                   |   1 -
 mm/fremap.c                                        | 283 -------------
 mm/gup.c                                           |   2 +-
 mm/interval_tree.c                                 |  34 +-
 mm/ksm.c                                           |   2 +-
 mm/madvise.c                                       |  13 +-
 mm/memcontrol.c                                    |   7 +-
 mm/memory.c                                        | 285 ++++++-------
 mm/migrate.c                                       |  32 --
 mm/mincore.c                                       |   9 +-
 mm/mmap.c                                          | 117 +++++-
 mm/mprotect.c                                      |  51 ++-
 mm/mremap.c                                        |   2 -
 mm/msync.c                                         |   5 +-
 mm/nommu.c                                         |   8 -
 mm/pagewalk.c                                      | 213 +++++-----
 mm/rmap.c                                          | 222 +----------
 mm/shmem.c                                         |   1 -
 mm/swap.c                                          |   4 +-
 mm/swapfile.c                                      |  46 ++-
 net/irda/af_irda.c                                 |  13 +-
 170 files changed, 2215 insertions(+), 1885 deletions(-)

-- 
Ben Hutchings
For every action, there is an equal and opposite criticism. - Harrison

