Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E931C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1482184D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="IFrMUQZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbeLWQYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:24:43 -0500
Received: from mail-eopbgr690132.outbound.protection.outlook.com ([40.107.69.132]:13299
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729470AbeLWQYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 11:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSrgzeStAv3m+UC9MPTxm0A1Ci0/qU/yeUQ+zWagTwc=;
 b=IFrMUQZUo3X0Ly2ch7+Ik3/aODOcHF71XelyD39OjjAnh+0KiWxC/x4RFGTaeaXMPjV1bGnwSk4gGAiamoBeDE4ZWqyi/5bYcsKuqoWsPkGa7xBf8D1w1gWTpxsp2TGyqpwtTVSZ8LG7AHhl+2Qx6V9yR3E9WvgGYPtc+3QRP4Y=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1181.namprd22.prod.outlook.com (10.174.169.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Sun, 23 Dec 2018 16:24:37 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 16:24:37 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Main MIPS pull for 4.21
Thread-Topic: [GIT PULL] Main MIPS pull for 4.21
Thread-Index: AQHUmtv/a9u/XYYsPUe2LMJqSzoICg==
Date:   Sun, 23 Dec 2018 16:24:37 +0000
Message-ID: <20181223162426.36uer6mzf2o3xkya@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0306.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::30) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1181;6:HUfxZ9LKXq+xz6cJDgMaU3Ao21wVESc6yBknYINTQW2PFUJni0AGDsPPecY1PnjwZxLtmUYp33Aamm4083dXOydh7FLjCXXw6XwgwFfdp+Y/1xZMw+U9tcIHun+1+yORp6olrjb59uGmSEM67bMftkVfLSQ0nTOLAmJiOMuyQ+a6yX31Qq4FbnckLmk5hxZZbnotRc7GciZ66JYU1S9k5sM4uBk+s2C5bniueTumiE3159cHXiX3BSSuvu9N/iCRFKB1kwGIh4OnCUzy9PfHc8Z/LKjniLdL1ZBF3ZTmqqLQHE+dcJheAveWNHlCLqJVzdYVw0prETW+H6XJdwPG55vY8wPUZ023abFk+YIC9TYWpBmGAbJTJ1j4JhFi14fxYDL0NNXYW9r4SSOnNs4Ef7ZpSVzpdlAwvI7RwORUFdIbUI/gDRtfDvAd7xo4sU73UcweADnE3o7Hj7KAQ95/YA==;5:Yrw5apHshcNNVJlMZG2r0RR6Z9AIpacg9VFAbg32JCEtDxoa+jcZpt2sScion1CFuXDQ/vEamdZJTfZpRWMkWpv67ob0gcpG+gJawluPga2LikBgPTXCV+iamJ0F5vxR8OOTxyr0LiDyWhoRQuTZJfax+AKiGjM2AX0NXB9bWN8=;7:7CZ7iA4fATnKMMpnUqQIh2NHKVsRlejmsHEci05nwg+9vA/LTYssPZ4EHkTDTPHIqL6xH98jmuMwEg79Xob2bwiAKdV/+sst0VJay4jswwlb+lQyZBa8/QgF8rDoH99AM37odF8f8ii0lrYjo23asA==
x-ms-office365-filtering-correlation-id: 276f015f-f2b6-4940-0279-08d668f31e75
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(49563074)(7193020);SRVR:MWHPR2201MB1181;
x-ms-traffictypediagnostic: MWHPR2201MB1181:
x-microsoft-antispam-prvs: <MWHPR2201MB118137A5E4D96B63EE43B5E9C1BA0@MWHPR2201MB1181.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(102415395)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(3231475)(944501520)(4983020)(52105112)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1181;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1181;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(396003)(39830400003)(366004)(376002)(346002)(189003)(199004)(44832011)(256004)(8676002)(14444005)(97736004)(105586002)(106356001)(4001150100001)(81156014)(81166006)(7736002)(486006)(386003)(508600001)(6506007)(68736007)(305945005)(99936001)(14454004)(4326008)(2906002)(33716001)(33896004)(52116002)(53946003)(9686003)(6512007)(186003)(1076003)(99286004)(54906003)(58126008)(102836004)(42882007)(53936002)(26005)(6116002)(316002)(5660300001)(6486002)(8936002)(71190400001)(71200400001)(3846002)(476003)(6436002)(66066001)(6916009)(4744004)(25786009)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1181;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wc8S4Wi5UMUDaXEIOPMa9Z0CKDZbKV0Cx/++ao1EL3MSAZOexaXzhzDkMyR8WPs7WrD7aJrkXx562mY8Tii00OyWs1yMkcz2Gy46NnUhZUCPNU07G5iYkgw7pjrwBw1rVuGKdke8Mcj410I7JtbjmETFM39QAKrdGOoC85RBcchEzBtaeYs97raLOGY7U80vrfa+eA3DEiGsq3bOTRjKOu0/5CHeqwwzwajuZQsWFWwadxURhLJKGph7XZBYicI8ju0U4RqWHN3LmJLyPGylAFforfHUcolU8r/WVih51b7vVCfvvFnUX5ilQs4lNBfo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fqikle2eol76q4p"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276f015f-f2b6-4940-0279-08d668f31e75
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 16:24:37.3767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2fqikle2eol76q4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here are the main MIPS changes for 4.21, summarized below. Please pull.

Thanks,
    Paul


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_4.21

for you to fetch changes up to adcc81f148d733b7e8e641300c5590a2cdc13bf3:

  MIPS: math-emu: Write-protect delay slot emulation pages (2018-12-20 10:00:01 -0800)

----------------------------------------------------------------
Here's the main MIPS pull for Linux 4.21. Core architecture changes
include:

 - Syscall tables & definitions for unistd.h are now generated by
   scripts, providing greater consistency with other architectures &
   making it easier to add new syscalls.

 - Support for building kernels with no floating point support, upon
   which any userland attempting to use floating point instructions will
   receive a SIGILL. Mostly useful to shrink the kernel & as preparation
   for nanoMIPS support which does not yet include FP.

 - MIPS SIMD Architecture (MSA) vector register context is now exposed
   by ptrace via a new NT_MIPS_MSA regset.

 - ASIDs are now stored as 64b values even for MIPS32 kernels, expanding
   the ASID version field sufficiently that we don't need to worry about
   overflow & avoiding rare issues with reused ASIDs that have been
   observed in the wild.

 - The branch delay slot "emulation" page is now mapped without write
   permission for the user, preventing its use as a nice location for
   attacks to execute malicious code from.

 - Support for ioremap_prot(), primarily to allow gdb or other
   ptrace users the ability to view their tracee's memory using the same
   cache coherency attribute.

 - Optimizations to more cpu_has_* macros, allowing more to be
   compile-time constant where possible.

 - Enable building the whole kernel with UBSAN instrumentation.

 - Enable building the kernel with link-time dead code & data
   elimination.

Platform specific changes include:

 - The Boston board gains a workaround for DMA prefetching issues with
   the EG20T Platform Controller Hub that it uses.

 - Cleanups to Cavium Octeon code removing about 20k lines of redundant
   code, mostly unused or duplicate register definitions in headers.

 - defconfig updates for the DECstation machines, including new
   defconfigs for r4k & 64b machines.

 - Further work on Loongson 3 support.

 - DMA fixes for SiByte machines.

----------------------------------------------------------------
Aaro Koskinen (30):
      MIPS: OCTEON: cvmx-l2c: make cvmx_l2c_spinlock static
      MIPS: OCTEON: setup: make internal functions and data static
      MIPS: OCTEON: setup: include asm/fw/fw.h
      MIPS: OCTEON: setup: include asm/prom.h
      MIPS: OCTEON: cvmx-helper: make __cvmx_helper_errata_fix_ipd_ptr_alignment static
      MIPS: OCTEON: delete unused loopback configuration functions
      MIPS: OCTEON: octeon-platform: make octeon_ids static
      MIPS: OCTEON: octeon-platform: fix typing
      MIPS: OCTEON: octeon-irq: make octeon_irq_ciu3_set_affinity() static
      MIPS: OCTEON: csrc-octeon: include linux/sched/clock.h
      MIPS: OCTEON: smp: make internal symbols static
      MIPS: OCTEON: cvmx-helper-util: delete cvmx_helper_dump_packet
      MIPS: OCTEON: cvmx-helper-util: make cvmx_helper_setup_red_queue static
      MIPS: OCTEON: make cvmx_bootmem_alloc_range static
      MIPS: OCTEON: cvmx-bootmem: delete unused functions
      MIPS: OCTEON: cvmx-bootmem: move code to avoid forward declarations
      MIPS: OCTEON: cvmx-bootmem: make more functions static
      MIPS: OCTEON: delete cvmx override functions
      MIPS: OCTEON: gmxx-defs.h: delete unused functions and macros
      MIPS: OCTEON: cvmx-gmxx-defs.h: delete unused unions
      MIPS: OCTEON: cvmx-gmxx-defs.h: delete unused union fields
      MIPS: OCTEON: cvmx-gmxx-defs.h: use default register value return when possible
      MIPS: OCTEON: cvmx-ciu2-defs.h: delete unused macros
      MIPS: OCTEON: cvmx-ciu2-defs.h: delete unused unions
      MIPS: OCTEON: enable all OCTEON drivers in defconfig
      MIPS: OCTEON: octeon-usb: use common gpio_bit definition
      MIPS: OCTEON: cvmx_pko_mem_debug8: use oldest forward compatible definition
      MIPS: OCTEON: cvmx_mio_fus_dat3: use oldest forward compatible definition
      MIPS: OCTEON: cvmx_gmxx_inf_mode: use oldest forward compatible definition
      MIPS: OCTEON: delete redundant register definitions

Firoz Khan (7):
      mips: add __NR_syscalls along with __NR_Linux_syscalls
      mips: remove unused macros
      mips: rename scall64-64.S to scall64-n64.S
      mips: add +1 to __NR_syscalls in uapi header
      mips: remove syscall table entries
      mips: add system call table generation support
      mips: generate uapi header and system call table files

Hassan Naveed (2):
      MIPS: Enable IOREMAP_PROT config option for MIPS cpus
      MIPS: Enable Undefined Behavior Sanitizer UBSAN

Huacai Chen (4):
      MIPS: Loongson: Add Loongson-3A R2.1 basic support
      MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
      MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
      MIPS: Align kernel load address to 64KB

Maciej W. Rozycki (6):
      MIPS: DEC: Update R3k DECstation defconfig for Y2018
      MIPS: DEC: Add R4k DECstation defconfig
      MIPS: DEC: Add 64-bit DECstation defconfig
      MIPS: SiByte: Set 32-bit bus mask for BCM1250 PCI
      MIPS: SiByte: Enable ZONE_DMA32 for LittleSur
      MIPS: SiByte: Enable swiotlb for SWARM, LittleSur and BigSur

Maksym Kokhan (2):
      mips: delete duplicated BUILTIN_DTB and LIBFDT configs
      mips: sort list of configs for Malta

Mathieu Malaterre (1):
      mips: annotate implicit fall throughs

Paul Burton (39):
      MIPS: Remove GCC_IMM_ASM & GCC_REG_ACCUM macros
      MIPS: Simplify GCC_OFF_SMALL_ASM definition
      MIPS: Hardcode cpu_has_mmips=1 for microMIPS kernels
      MIPS: Hide CONFIG_MIPS_O32_FP64_SUPPORT prompt for >= MIPSr6
      MIPS: BCM5xxx: Remove dead init_fpu code
      MIPS: Simplify FP context initialization
      MIPS: Ensure emulated FP sets PF_USED_MATH
      MIPS: Drop forward declarations of sigcontext in asm/fpu.h
      MIPS: Better abstract R2300 FPU usage in Kconfig
      MIPS: Introduce CONFIG_MIPS_FP_SUPPORT
      MIPS: Hardcode cpu_has_fpu=0 when CONFIG_MIPS_FP_SUPPORT=n
      MIPS: Stub asm/fpu.h functions
      MIPS: cpu-probe: Avoid probing FPU when CONFIG_MIPS_FP_SUPPORT=n
      MIPS: traps: Never enable FPU when CONFIG_MIPS_FP_SUPPORT=n
      MIPS: branch: Remove FP branch handling when CONFIG_MIPS_FP_SUPPORT=n
      MIPS: unaligned: Remove FP & MSA code when unsupported
      MIPS: ptrace: Remove FP support when CONFIG_MIPS_FP_SUPPORT=n
      MIPS: signal: Remove FP context support when CONFIG_MIPS_FP_SUPPORT=n
      MIPS: Avoid FP ELF checks when CONFIG_MIPS_FP_SUPPORT=n
      MIPS: Avoid FCSR sanitization when CONFIG_MIPS_FP_SUPPORT=n
      MIPS: Don't compile math-emu when CONFIG_MIPS_FP_SUPPORT=n
      MIPS: Remove struct task_struct fpu state when CONFIG_MIPS_FP_SUPPORT=n
      MIPS: Allow FP support to be disabled
      MIPS: Avoid using .set mips0 to restore ISA
      MIPS: Fix do_ade() closing brace indentation
      MIPS: Don't dump Hi & Lo regs on >= MIPSr6
      MIPS: Boston: Disable EG20T prefetch
      MIPS: Use Kconfig to select CPU_NO_EFFICIENT_FFS
      lib/gcd: Remove use of CPU_NO_EFFICIENT_FFS macro
      MIPS: ptrace: introduce NT_MIPS_MSA regset
      MIPS: malta: Use img-ascii-lcd driver for LCD display
      MIPS: Regenerate defconfigs
      MIPS: Enable dead code elimination
      MIPS: Only include mmzone.h when CONFIG_NEED_MULTIPLE_NODES=y
      MIPS: MT: Remove norps command line parameter
      MIPS: Hardcode cpu_has_mips* where target ISA allows
      MIPS: Expand MIPS32 ASIDs to 64 bits
      MIPS: Remove struct mm_context_t fp_mode_switching field
      MIPS: math-emu: Write-protect delay slot emulation pages

Rob Herring (1):
      MIPS: Use device_type helpers to access the node type

Sean Young (1):
      MIPS: Remove superfluous check for __linux__

Yangtao Li (2):
      MIPS: math-emu: Change to use DEFINE_SHOW_ATTRIBUTE macro
      MIPS: r2-on-r6-emu: Change to use DEFINE_SHOW_ATTRIBUTE macro

 .../features/vm/ioremap_prot/arch-support.txt      |    2 +-
 arch/mips/Kconfig                                  |   65 +-
 arch/mips/Makefile                                 |    5 +-
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |    7 +-
 arch/mips/boot/dts/img/boston.dts                  |    6 +
 arch/mips/boot/dts/mti/malta.dts                   |    5 +
 arch/mips/cavium-octeon/csrc-octeon.c              |    1 +
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |  149 +-
 arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c |    2 +-
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |   68 -
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |   38 -
 .../cavium-octeon/executive/cvmx-helper-util.c     |   90 +-
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |   39 -
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |   91 +-
 .../cavium-octeon/executive/cvmx-interrupt-rsl.c   |    2 +-
 arch/mips/cavium-octeon/executive/cvmx-l2c.c       |    2 +-
 arch/mips/cavium-octeon/executive/octeon-model.c   |   12 +-
 arch/mips/cavium-octeon/octeon-irq.c               |    4 +-
 arch/mips/cavium-octeon/octeon-platform.c          |    4 +-
 arch/mips/cavium-octeon/octeon-usb.c               |    6 +-
 arch/mips/cavium-octeon/setup.c                    |    8 +-
 arch/mips/cavium-octeon/smp.c                      |    4 +-
 arch/mips/configs/ar7_defconfig                    |   44 +-
 arch/mips/configs/ath25_defconfig                  |   25 +-
 arch/mips/configs/ath79_defconfig                  |   33 +-
 arch/mips/configs/bcm47xx_defconfig                |   11 +-
 arch/mips/configs/bcm63xx_defconfig                |   37 +-
 arch/mips/configs/bigsur_defconfig                 |   65 +-
 arch/mips/configs/bmips_be_defconfig               |   22 +-
 arch/mips/configs/bmips_stb_defconfig              |   23 +-
 arch/mips/configs/capcella_defconfig               |   24 +-
 arch/mips/configs/cavium_octeon_defconfig          |   44 +-
 arch/mips/configs/ci20_defconfig                   |   27 +-
 arch/mips/configs/cobalt_defconfig                 |    8 +-
 arch/mips/configs/db1xxx_defconfig                 |   47 +-
 arch/mips/configs/decstation_64_defconfig          |  227 +
 arch/mips/configs/decstation_defconfig             |  163 +-
 arch/mips/configs/decstation_r4k_defconfig         |  224 +
 arch/mips/configs/e55_defconfig                    |    8 +-
 arch/mips/configs/fuloong2e_defconfig              |   79 +-
 arch/mips/configs/gcw0_defconfig                   |   12 +-
 arch/mips/configs/generic_defconfig                |   26 +-
 arch/mips/configs/gpr_defconfig                    |  112 +-
 arch/mips/configs/ip22_defconfig                   |   76 +-
 arch/mips/configs/ip27_defconfig                   |  149 +-
 arch/mips/configs/ip28_defconfig                   |   26 +-
 arch/mips/configs/ip32_defconfig                   |   41 +-
 arch/mips/configs/jazz_defconfig                   |   62 +-
 arch/mips/configs/jmr3927_defconfig                |   13 +-
 arch/mips/configs/lasat_defconfig                  |   24 +-
 arch/mips/configs/lemote2f_defconfig               |  143 +-
 arch/mips/configs/loongson1b_defconfig             |   15 +-
 arch/mips/configs/loongson1c_defconfig             |   17 +-
 arch/mips/configs/loongson3_defconfig              |   70 +-
 arch/mips/configs/malta_defconfig                  |   42 +-
 arch/mips/configs/malta_kvm_defconfig              |   59 +-
 arch/mips/configs/malta_kvm_guest_defconfig        |   48 +-
 arch/mips/configs/malta_qemu_32r6_defconfig        |   22 +-
 arch/mips/configs/maltaaprp_defconfig              |   25 +-
 arch/mips/configs/maltasmvp_defconfig              |   30 +-
 arch/mips/configs/maltasmvp_eva_defconfig          |   30 +-
 arch/mips/configs/maltaup_defconfig                |   21 +-
 arch/mips/configs/maltaup_xpa_defconfig            |   44 +-
 arch/mips/configs/markeins_defconfig               |   35 +-
 arch/mips/configs/mips_paravirt_defconfig          |   35 +-
 arch/mips/configs/mpc30x_defconfig                 |    7 +-
 arch/mips/configs/msp71xx_defconfig                |   20 +-
 arch/mips/configs/mtx1_defconfig                   |  307 +-
 arch/mips/configs/nlm_xlp_defconfig                |  112 +-
 arch/mips/configs/nlm_xlr_defconfig                |  145 +-
 arch/mips/configs/omega2p_defconfig                |   28 +-
 arch/mips/configs/pic32mzda_defconfig              |   12 +-
 arch/mips/configs/pistachio_defconfig              |   78 +-
 arch/mips/configs/pnx8335_stb225_defconfig         |   27 +-
 arch/mips/configs/qi_lb60_defconfig                |   23 +-
 arch/mips/configs/rb532_defconfig                  |   49 +-
 arch/mips/configs/rbtx49xx_defconfig               |   24 +-
 arch/mips/configs/rm200_defconfig                  |   79 +-
 arch/mips/configs/rt305x_defconfig                 |   45 +-
 arch/mips/configs/sb1250_swarm_defconfig           |   36 +-
 arch/mips/configs/tb0219_defconfig                 |   32 +-
 arch/mips/configs/tb0226_defconfig                 |   17 +-
 arch/mips/configs/tb0287_defconfig                 |   29 +-
 arch/mips/configs/vocore2_defconfig                |   28 +-
 arch/mips/configs/workpad_defconfig                |   18 +-
 arch/mips/configs/xway_defconfig                   |   32 +-
 arch/mips/include/asm/Kbuild                       |    4 +
 arch/mips/include/asm/atomic.h                     |   27 +-
 arch/mips/include/asm/bitops.h                     |   42 +-
 arch/mips/include/asm/cmpxchg.h                    |    6 +-
 arch/mips/include/asm/compiler.h                   |   24 +-
 arch/mips/include/asm/cpu-features.h               |   60 +-
 arch/mips/include/asm/cpu-info.h                   |    2 +-
 arch/mips/include/asm/cpu.h                        |    3 +-
 arch/mips/include/asm/dsemul.h                     |   29 +-
 arch/mips/include/asm/edac.h                       |    3 +-
 arch/mips/include/asm/elf.h                        |   26 +-
 arch/mips/include/asm/fpu.h                        |  145 +-
 arch/mips/include/asm/fpu_emulator.h               |   11 -
 arch/mips/include/asm/futex.h                      |   14 +-
 arch/mips/include/asm/hazards.h                    |    6 +-
 arch/mips/include/asm/io.h                         |   22 +-
 arch/mips/include/asm/kvm_host.h                   |    9 +-
 arch/mips/include/asm/local.h                      |   12 +-
 .../asm/mach-loongson64/kernel-entry-init.h        |    4 +-
 arch/mips/include/asm/mach-loongson64/mmzone.h     |    1 +
 arch/mips/include/asm/mipsmtregs.h                 |    7 +-
 arch/mips/include/asm/mipsregs.h                   |   30 +-
 arch/mips/include/asm/mmu.h                        |    3 +-
 arch/mips/include/asm/mmu_context.h                |   10 +-
 arch/mips/include/asm/mmzone.h                     |   13 +-
 arch/mips/include/asm/octeon/cvmx-agl-defs.h       |  699 --
 arch/mips/include/asm/octeon/cvmx-asxx-defs.h      |  105 -
 arch/mips/include/asm/octeon/cvmx-bootmem.h        |   76 -
 arch/mips/include/asm/octeon/cvmx-ciu2-defs.h      | 7060 --------------------
 arch/mips/include/asm/octeon/cvmx-dbg-defs.h       |    4 -
 arch/mips/include/asm/octeon/cvmx-dpi-defs.h       |  178 -
 arch/mips/include/asm/octeon/cvmx-fpa-defs.h       |  247 -
 arch/mips/include/asm/octeon/cvmx-gmxx-defs.h      | 5058 +-------------
 arch/mips/include/asm/octeon/cvmx-gpio-defs.h      |  116 -
 arch/mips/include/asm/octeon/cvmx-helper-rgmii.h   |   17 -
 arch/mips/include/asm/octeon/cvmx-helper-sgmii.h   |   17 -
 arch/mips/include/asm/octeon/cvmx-helper-util.h    |   23 -
 arch/mips/include/asm/octeon/cvmx-helper-xaui.h    |   16 -
 arch/mips/include/asm/octeon/cvmx-helper.h         |   36 -
 arch/mips/include/asm/octeon/cvmx-iob-defs.h       |  375 --
 arch/mips/include/asm/octeon/cvmx-ipd-defs.h       |  538 --
 arch/mips/include/asm/octeon/cvmx-l2t-defs.h       |    6 -
 arch/mips/include/asm/octeon/cvmx-led-defs.h       |   78 -
 arch/mips/include/asm/octeon/cvmx-lmcx-defs.h      |  514 --
 arch/mips/include/asm/octeon/cvmx-mio-defs.h       | 1197 ----
 arch/mips/include/asm/octeon/cvmx-mixx-defs.h      |  136 -
 arch/mips/include/asm/octeon/cvmx-npei-defs.h      |  295 -
 arch/mips/include/asm/octeon/cvmx-npi-defs.h       |  235 -
 arch/mips/include/asm/octeon/cvmx-pci-defs.h       |  392 --
 arch/mips/include/asm/octeon/cvmx-pcsx-defs.h      |  185 -
 arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h     |  146 -
 arch/mips/include/asm/octeon/cvmx-pemx-defs.h      |  144 -
 arch/mips/include/asm/octeon/cvmx-pescx-defs.h     |   59 -
 arch/mips/include/asm/octeon/cvmx-pip-defs.h       |  688 --
 arch/mips/include/asm/octeon/cvmx-pko-defs.h       |  619 --
 arch/mips/include/asm/octeon/cvmx-pko.h            |    2 +-
 arch/mips/include/asm/octeon/cvmx-pow-defs.h       |  317 -
 arch/mips/include/asm/octeon/cvmx-rnm-defs.h       |   53 -
 arch/mips/include/asm/octeon/cvmx-rst-defs.h       |   28 -
 arch/mips/include/asm/octeon/cvmx-smix-defs.h      |   88 -
 arch/mips/include/asm/octeon/cvmx-spxx-defs.h      |   62 -
 arch/mips/include/asm/octeon/cvmx-sriox-defs.h     |  123 -
 arch/mips/include/asm/octeon/cvmx-srxx-defs.h      |   22 -
 arch/mips/include/asm/octeon/cvmx-stxx-defs.h      |   64 -
 arch/mips/include/asm/octeon/cvmx-uctlx-defs.h     |   89 -
 arch/mips/include/asm/page.h                       |    1 +
 arch/mips/include/asm/pgtable-64.h                 |    5 +
 arch/mips/include/asm/pgtable.h                    |    6 +-
 arch/mips/include/asm/processor.h                  |   19 +-
 arch/mips/include/asm/r4kcache.h                   |   22 +
 arch/mips/include/asm/stackframe.h                 |    3 +-
 arch/mips/include/asm/switch_to.h                  |    6 +-
 arch/mips/include/asm/unistd.h                     |    3 +
 arch/mips/include/uapi/asm/Kbuild                  |    6 +
 arch/mips/include/uapi/asm/sgidefs.h               |    8 -
 arch/mips/include/uapi/asm/unistd.h                | 1074 +--
 arch/mips/kernel/Makefile                          |    5 +-
 arch/mips/kernel/asm-offsets.c                     |    7 +-
 arch/mips/kernel/bmips_5xxx_init.S                 |    6 -
 arch/mips/kernel/branch.c                          |   41 +-
 arch/mips/kernel/cpu-bugs64.c                      |    4 +-
 arch/mips/kernel/cpu-probe.c                       |   64 +-
 arch/mips/kernel/elf.c                             |    4 +
 arch/mips/kernel/ftrace.c                          |    6 +-
 arch/mips/kernel/genex.S                           |    5 +-
 arch/mips/kernel/idle.c                            |    7 +-
 arch/mips/kernel/mips-mt.c                         |   11 -
 arch/mips/kernel/mips-r2-to-r6-emul.c              |   39 +-
 arch/mips/kernel/process.c                         |    9 +-
 arch/mips/kernel/ptrace.c                          |  466 +-
 arch/mips/kernel/ptrace32.c                        |   33 +-
 arch/mips/kernel/r2300_fpu.S                       |   58 -
 arch/mips/kernel/r4k_fpu.S                         |  144 -
 arch/mips/kernel/scall32-o32.S                     |  391 +-
 arch/mips/kernel/scall64-64.S                      |  444 --
 arch/mips/kernel/scall64-n32.S                     |  341 +-
 arch/mips/kernel/scall64-n64.S                     |  117 +
 arch/mips/kernel/scall64-o32.S                     |  379 +-
 arch/mips/kernel/signal.c                          |   39 +-
 arch/mips/kernel/syscall.c                         |    6 +-
 arch/mips/kernel/syscalls/Makefile                 |   96 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |  343 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |  339 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |  382 ++
 arch/mips/kernel/syscalls/syscallhdr.sh            |   37 +
 arch/mips/kernel/syscalls/syscallnr.sh             |   28 +
 arch/mips/kernel/syscalls/syscalltbl.sh            |   36 +
 arch/mips/kernel/traps.c                           |  124 +-
 arch/mips/kernel/unaligned.c                       |   40 +-
 arch/mips/kernel/vdso.c                            |    4 +-
 arch/mips/kernel/vmlinux.lds.S                     |    4 +-
 arch/mips/kernel/watch.c                           |   13 +
 arch/mips/kvm/Kconfig                              |    1 +
 arch/mips/loongson64/common/env.c                  |    3 +-
 arch/mips/loongson64/loongson-3/cop2-ex.c          |    7 +-
 arch/mips/loongson64/loongson-3/smp.c              |    3 +-
 arch/mips/math-emu/cp1emu.c                        |    7 +
 arch/mips/math-emu/dsemul.c                        |   38 +-
 arch/mips/math-emu/me-debugfs.c                    |   12 +-
 arch/mips/mm/c-r3k.c                               |    2 +-
 arch/mips/mm/c-r4k.c                               |   48 +-
 arch/mips/mm/tlbex.c                               |    1 +
 arch/mips/mti-malta/Makefile                       |    1 -
 arch/mips/mti-malta/malta-display.c                |   56 -
 arch/mips/mti-malta/malta-init.c                   |    3 -
 arch/mips/mti-malta/malta-setup.c                  |    2 -
 arch/mips/mti-malta/malta-time.c                   |    2 -
 arch/mips/pci/fixup-sb1250.c                       |   53 +
 arch/mips/pci/pci-rt3883.c                         |    6 +-
 arch/mips/sibyte/common/Makefile                   |    1 +
 arch/mips/sibyte/common/dma.c                      |   14 +
 arch/mips/vdso/Makefile                            |    1 +
 drivers/platform/mips/cpu_hwmon.c                  |    3 +-
 include/uapi/linux/elf.h                           |    1 +
 lib/gcd.c                                          |    2 +-
 221 files changed, 4492 insertions(+), 25666 deletions(-)
 create mode 100644 arch/mips/configs/decstation_64_defconfig
 create mode 100644 arch/mips/configs/decstation_r4k_defconfig
 delete mode 100644 arch/mips/kernel/scall64-64.S
 create mode 100644 arch/mips/kernel/scall64-n64.S
 create mode 100644 arch/mips/kernel/syscalls/Makefile
 create mode 100644 arch/mips/kernel/syscalls/syscall_n32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_n64.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_o32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/mips/kernel/syscalls/syscallnr.sh
 create mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/mips/mti-malta/malta-display.c
 create mode 100644 arch/mips/sibyte/common/dma.c

--2fqikle2eol76q4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCXB+2ugAKCRA+p5+stXUA
3X0ZAPsE97DRK/eQLKocqMZaCMH6YGHrWysZSF1QncmhM/W9XQD/WQFAyB97u7Tr
Hei63C36+OsyGJx4MPs0el49JpSaQAA=
=q/S2
-----END PGP SIGNATURE-----

--2fqikle2eol76q4p--
