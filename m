Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826786-2-8729660484834622726
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826785; b=nRvvxc7dfQe3jptaJQUF3eFN+4uiYB0UfemCNI9Cyk2rv42
    WA8b5di62sY41jbsPg5+Y6bDo6NxSUsZSTmLYdsbXZ4eStzKbQILV2H/SRRZTAp5
    dawXVQHDP2T10TuiEqFtaPmlXw/XKvovTtIVT189nA+GnC06x2bpFQUFfanFduCv
    fER4fFKLVFcV++P23v/zZ+wfhdXMygC6teUaMPLi6P9yfOe/yS2IsWOgHEWKLWjY
    K2sej2RtOSJBKevwUBWp6iPx6k5BidP7kbBfQ6849Y8SWBzIKFAQ5OX3xU+Rm7uE
    RtWOXO5yRuGEODeYKnoXWA++v2YdrpuhFohgu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:sender:list-id;
    s=arctest; t=1520826785; bh=SIOKhdD3KioX3GP/JSppLEGZNjj472wQ1ER
    9dVHzMAk=; b=SKZlp44eKkk8XOKsrTwl3X12O+SgQTrlDQ4iP8mUmdjCtr8/SuU
    DIr480M4egMP6GyTIRqCJxjD3kK89Nl0jcOWwI/ONExpDbxzP+19k1wmPJGMNQiA
    pJrXyVtvlsoKK3uf44EYjC/mju02su6apv3CZ8eciUTjMOM3z4qIeHPS23tNhYMe
    dO6Gr5DHlU81yfPTUdWsCwlt4zX8GWGqHWnyI8C9HONPEl4AsbU+StpJQaV5fFOi
    aRb4CF8P15NilKVNXlbxKxkFy+lDS4qP9hwu9AMjgpGJ5yphl1ycxXT0Ly3sDvTU
    n7oPqe/L02DLbKIRAaSCWCBERvH0b8J8gWQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932532AbeCLDxC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:53:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41013 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932503AbeCLDHi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:38 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.606620518@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 000/104] 3.2.101-rc1 review
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.2.101 release.
There are 104 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar 14 12:00:00 UTC 2018.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.2.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Alexandre Oliva (1):
      brcmfmac: work-around gcc 4.7 build issue
         [5addc0de28f5e286f9d121112c4222250807b5a5]

Andi Kleen (5):
      ath6kl: fix uninitialized variable in ath6kl_sdio_enable_scatter()
         [527f6570300980251e818e80865b437eefb4e5d3]
      brcm80211: Remove bogus memcpy in ai_detach
         [af2c8ffe56133928355d1d51978b35115ffbbc2a]
      module/retpoline: Warn about missing retpoline in module
         [caf7501a1b4ec964190f31f9c3f163de252273b8]
      x86/retpoline/irq32: Convert assembler indirect jumps
         [7614e913db1f40fff819b36216484dc3808995d4]
      x86/retpoline: Optimize inline assembler for vmexit_fill_RSB
         [3f7d875566d8e79c5e0b2c9a413e91b2c29e0854]

Andrey Ryabinin (1):
      x86/asm: Use register variable to get stack pointer value
         [196bd485ee4f03ce4c690bfcf38138abfcd0a4bc]

Andy Lutomirski (2):
      x86/asm: Make asm/alternative.h safe from assembly
         [f005f5d860e0231fe212cfda8c1a3148b99609f4]
      x86/cpu: Factor out application of forced CPU caps
         [8bf1ebca215c262e48c15a4a15f175991776f57f]

Arnd Bergmann (2):
      Turn off -Wmaybe-uninitialized when building with -Os
         [e74fc973b6e531fef1fce8b101ffff05ecfb774c]
      x86: fix build warnign with 32-bit PAE
         [not upstream; specific to KAISER]

Avi Kivity (2):
      KVM: SVM: Make use of asm.h
         [7454766f7bead388251aedee35a478356a7f4e72]
      KVM: VMX: Make use of asm.h
         [b188c81f2e1a188ddda6a3d353e5b546c30a9b90]

Ben Hutchings (1):
      x86/syscall: Sanitize syscall table de-references under speculation
         [2fbd7af5af8665d18bcefae3e9700be07e22b681]

Borislav Petkov (9):
      x86, cpu: Expand cpufeature facility to include cpu bugs
         [65fc985b37dc241c4db7cd32adcbc989193fe3c8]
      x86/alternatives: Fix ALTERNATIVE_2 padding generation properly
         [dbe4058a6a44af4ca5d146aebe01b0a1f9b7fd2a]
      x86/alternatives: Fix optimize_nops() checking
         [612e8e9350fd19cae6900cf36ea0c6892d1a0dca]
      x86/alternatives: Guard NOPs optimization
         [69df353ff305805fc16082d0c5bfa6e20fa8b863]
      x86/bitops: Move BIT_64() for a wider use
         [e8f380e00840f694599e6ab42806639f7de26f11]
      x86/bugs: Drop one "mitigation" from dmesg
         [55fa19d3e51f33d9cd4056d25836d93abf9438db]
      x86/cpu: Merge bugs.c and bugs_64.c
         [62a67e123e058a67db58bc6a14354dd037bafd0a]
      x86/nospec: Fix header guards names
         [7a32fc51ca938e67974cbb9db31e1a43f98345a9]
      x86: Add another set of MSR accessor functions
         [22085a66c2fab6cf9b9393c056a3600a6b4735de]

Colin Ian King (1):
      x86/spectre: Fix spelling mistake: "vunerable"-> "vulnerable"
         [e698dcdfcda41efd0984de539767b4cddd235f1e]

Dan Carpenter (1):
      x86/spectre: Fix an error message
         [9de29eac8d2189424d81c0d840cd0469aa3d41c8]

Dan Williams (11):
      array_index_nospec: Sanitize speculative array de-references
         [f3804203306e098dae9ca51540fcd5eb700d7f40]
      nospec: Include <asm/barrier.h> dependency
         [eb6174f6d1be16b19cfa43dac296bfed003ce1a6]
      nospec: Kill array_index_nospec_mask_check()
         [1d91c1d2c80cb70e2e553845e278b87a960c04da]
      vfs, fdtable: Prevent bounds-check bypass via speculative execution
         [56c30ba7b348b90484969054d561f711ba196507]
      x86/get_user: Use pointer masking to limit speculation
         [c7f631cb07e7da06ac1d231ca178452339e32a94]
      x86/kvm: Update spectre-v1 mitigation
         [085331dfc6bbe3501fb936e657331ca943827600]
      x86/spectre: Report get_user mitigation for spectre_v1
         [edfbae53dab8348fca778531be9f4855d2ca0360]
      x86/uaccess: Use __uaccess_begin_nospec() and uaccess_try_nospec
         [304ec1b050310548db33063e567123fae8fd0301]
      x86: Implement array_index_mask_nospec
         [babdde2698d482b6c0de1eab4f697cf5856c5859]
      x86: Introduce __uaccess_begin_nospec() and uaccess_try_nospec
         [b3bbfb3fb5d25776b8e3f361d2eedaabb0b496cd]
      x86: Introduce barrier_nospec
         [b3d7ad85b80bbc404635dca80f5b129f6242bc7a]

Danny Kukawka (1):
      [media] max2165: trival fix for some -Wuninitialized warning
         [32d7e63c1f4f86ad18404e3f36be99c9910fae9b]

Darren Kenny (1):
      x86/speculation: Fix typo IBRS_ATT, which should be IBRS_ALL
         [af189c95a371b59f493dbe0f50c0a09724868881]

Dave Hansen (2):
      x86/Documentation: Add PTI description
         [01c9b17bf673b05bb401b76ec763e9730ccf1376]
      x86/cpu/intel: Introduce macros for Intel family numbers
         [970442c599b22ccd644ebfe94d1d303bf6f87c05]

David Woodhouse (14):
      sysfs/cpu: Fix typos in vulnerability documentation
         [9ecccfaa7cb5249bd31bdceb93fcf5bedb8a24d8]
      x86/alternatives: Add missing '\n' at end of ALTERNATIVE inline asm
         [b9e705ef7cfaf22db0daab91ad3cd33b0fa32eb9]
      x86/cpufeatures: Add X86_BUG_SPECTRE_V[12]
         [99c6fa2511d8a683e61468be91b83f85452115fa]
      x86/cpufeatures: Clean up Spectre v2 related CPUID flags
         [2961298efe1ea1b6fc0d7ee8b76018fa6c0bcef2]
      x86/retpoline/checksum32: Convert assembler indirect jumps
         [5096732f6f695001fa2d6f1335a2680b37912c69]
      x86/retpoline/entry: Convert entry assembler indirect jumps
         [2641f08bb7fc63a636a2b18173221d7040a3512e]
      x86/retpoline/ftrace: Convert ftrace assembler indirect jumps
         [9351803bd803cdbeb9b5a7850b7b6f464806e3db]
      x86/retpoline/hyperv: Convert assembler indirect jumps
         [e70e5892b28c18f517f29ab6e83bd57705104b31]
      x86/retpoline/xen: Convert Xen hypercall indirect jumps
         [ea08816d5b185ab3d09e95e393f265af54560350]
      x86/retpoline: Add initial retpoline support
         [76b043848fd22dbf7f8bf3a1452f8c70d557b860]
      x86/retpoline: Avoid retpolines for built-in __init functions
         [66f793099a636862a71c59d4a6ba91387b155e0c]
      x86/retpoline: Fill RSB on context switch for affected CPUs
         [c995efd5a740d9cbafbf58bde4973e8b50b4d761]
      x86/retpoline: Fill return stack buffer on vmexit
         [117cc7a908c83697b0b737d15ae1eb5943afe35b]
      x86/spectre: Add boot time option to select Spectre v2 mitigation
         [da285121560e769cc31797bba6422eea71d473e0]

Dou Liyang (1):
      x86/spectre: Check CONFIG_RETPOLINE in command line parser
         [9471eee9186a46893726e22ebb54cade3f9bc043]

Frantisek Hrbata (3):
      gcov: add support for gcc 4.7 gcov format
         [5f41ea0386a53414d688cfcaa321a78310e5f7c1]
      gcov: compile specific gcov implementation based on gcc version
         [17c568d60af5a810208baf116dc174a2005c6c3e]
      gcov: move gcov structs definitions to a gcc version specific file
         [8cbce376e3fdf4a21f59365aefbb52eac3c2e312]

H. Peter Anvin (1):
      x86, alternative: Add header guards to <asm/alternative-asm.h>
         [76f30759f690db21ca567a20665ed2679ad3235b]

Han Shen (2):
      Removed unused typedef to avoid "unused local typedef" warnings.
         [6b13eb1baa17b8746f96bd536d2897ec86e823d9]
      rtl8192c:dm: Properly initialize local array and set value.
         [7c8f0db0d024efda38976fc2acf7743f458e1d96]

Jan-Simon Möller (1):
      x86, asm: Extend definitions of _ASM_* with a raw format
         [3e9b2327b59801e677a7581fe4d2541ca749dcab]

Jim Mattson (1):
      kvm: vmx: Scrub hardware GPRs at VM-exit
         [0cb5b30698fdc8f6b4646012e3acb4ddce430788]

Josh Poimboeuf (1):
      x86/paravirt: Remove 'noreplace-paravirt' cmdline option
         [12c69f1e94c89d40696e83804dd2f0965b5250cd]

Kalle Valo (1):
      ath6kl: fix struct hif_scatter_req list handling
         [31b9cc9a873dcab161999622314f98a75d838975]

KarimAllah Ahmed (1):
      x86/spectre: Simplify spectre_v2 command line parsing
         [9005c6834c0ffdfe46afa76656bd9276cca864f6]

Kuninori Morimoto (2):
      usb: renesas_usbhs: fixup __usbhs_for_each_pipe 1st pos
         [c2fa3edc58a262dfcb7aea78e24661e90e00098c]
      usb: renesas_usbhs: tidyup original usbhsx_for_each_xxx macro
         [925403f425a4a9c503f2fc295652647b1eb10d82]

Larry Finger (3):
      rtlwifi: rtl8192c: Fix W=1 warning
         [8a8e31cc22739d1a5780591c008940292edcde87]
      rtlwifi: rtl8192de: Fix W=1 build warnings
         [8925d518663628f769173d3586c66987fdd3ab61]
      rtlwifi: rtl8192se: Fix gcc 4.7.x warning
         [f761b6947dde42890beea59b020e1be87491809e]

Mark Rutland (1):
      Documentation: Document array_index_nospec
         [f84a56f73dddaeac1dba8045b007f742f61cd2da]

Masahiro Yamada (1):
      kconfig.h: use __is_defined() to check if MODULE is defined
         [4f920843d248946545415c1bf6120942048708ed]

Masami Hiramatsu (3):
      kprobes/x86: Blacklist indirect thunk functions for kprobes
         [c1804a236894ecc942da7dc6c5abe209e56cba93]
      kprobes/x86: Disable optimizing on the function jumps to indirect thunk
         [c86a32c09f8ced67971a2310e3b0dda4d1749007]
      retpoline: Introduce start/end markers of indirect thunk
         [736e80a4213e9bbce40a7c050337047128b472ac]

Mathias Krause (1):
      modpost: reduce visibility of symbols and constify r/o arrays
         [7a3ee7538598e0d60e6aa87dcf34a4e8a0adebc2]

Paul Bolle (2):
      [media] budget-av: only use t_state if initialized
         [cb31c7487580a0cfc6eb253e604c1e51ac8eb3c8]
      atp: remove set_rx_mode_8012()
         [bb263e18f481199a04f7aab9454c18cd3dbdb218]

Paul Gortmaker (3):
      cris: Remove old legacy "-traditional" flag from arch-v10/lib/Makefile
         [7b91747d42a1012e3781dd09fa638d113809e3fd]
      kconfig: fix IS_ENABLED to not require all options to be defined
         [69349c2dc01c489eccaa4c472542c08e370c6d7e]
      modpost: don't emit section mismatch warnings for compiler optimizations
         [4a3893d069b788f3570c19c12d9e986e8e15870f]

Peter Huewe (1):
      staging/wlan-ng: Fix 'Branch condition evaluates to a garbage value' in p80211netdev.c
         [fae7e4d39373305cf505d1f0871a4491897d56f9]

Srinivas Pandruvada (1):
      bitops: Introduce BIT_ULL
         [bfd1ff6375c82930bfb3b401eee2c96720fa8e84]

Syam Sidhardhan (1):
      Bluetooth: Remove unused hci_le_ltk_reply()
         [e10b9969f217c948c5523045f44eba4d3a758ff0]

Thomas Gleixner (8):
      sysfs/cpu: Add vulnerability folder
         [87590ce6e373d1a5401f6539f0c59ef92dd924a9]
      x86/alternatives: Make optimize_nops() interrupt safe and synced
         [66c117d7fa2ae429911e60d84bf31a90b2b96189]
      x86/cpu/bugs: Make retpoline module warning conditional
         [e383095c7fe8d218e00ec0f83e4b95ed4e627b02]
      x86/cpu: Implement CPU vulnerabilites sysfs functions
         [61dc0f555b5c761cdafb0ba5bd41ecf22d68a4c4]
      x86/cpufeatures: Add X86_BUG_CPU_INSECURE
         [a89f040fa34ec9cd682aed98b8f04e3c47d998bd]
      x86/cpufeatures: Make CPU bugs sticky
         [6cbd2171e89b13377261d15e64384df60ecb530e]
      x86/pti: Rename BUG_CPU_INSECURE to BUG_CPU_MELTDOWN
         [de791821c295cc61419a06fe5562288417d1bc58]
      x86/retpoline: Remove compile time warning
         [b8b9ce4b5aec8de9e23cabb0a26b78641f9ab1d6]

Tim Gardner (2):
      SELinux: security_load_policy: Silence frame-larger-than warning
         [b5495b4217d3fa64deac479db83dbede149af7d8]
      fs: namespace: suppress 'may be used uninitialized' warnings
         [b8850d1fa8e2f6653e57daf6d08e58c5f5eb2c85]

Tom Lendacky (4):
      x86/cpu, x86/pti: Do not enable PTI on AMD processors
         [694d99d40972f12e59a3696effee8a376b79d7c8]
      x86/cpu/AMD: Make LFENCE a serializing instruction
         [e4d0e84e490790798691aaa0f2e598637f1867ec]
      x86/cpu/AMD: Use LFENCE_RDTSC in preference to MFENCE_RDTSC
         [9c6a73c75864ad9fa49e5fa6513e4c4071c0e29f]
      x86/retpoline: Add LFENCE to the retpoline/RSB filling RSB macros
         [28d437d550e1e39f805d99f9f8ac399c778827b7]

Waiman Long (1):
      x86/retpoline: Remove the esp/rsp thunk
         [1df37383a8aeabb9b418698f0bcdffea01f4b1b2]

Will Deacon (1):
      nospec: Move array_index_nospec() parameter checking into separate macro
         [8fa80c503b484ddc1abbd10c7cb2ab81f3824a50]

Yuan Pengfei (1):
      gcov: add support for GCC 4.9
         [a992bf836f9c3039a16f4bd068d161c86c6c3e2c]

Yunlian Jiang (1):
      rtlwifi: initialize local array and set value.
         [ec71997eff2231098212a99934c0fb987a9e6b04]

Zhenwei.Pi (1):
      x86/pti: Document fix wrong index
         [98f0fceec7f84d80bc053e49e596088573086421]

 Documentation/ABI/testing/sysfs-devices-system-cpu |  16 +
 Documentation/gcov.txt                             |   4 +
 Documentation/kernel-parameters.txt                |  51 +-
 Documentation/speculation.txt                      |  90 ++++
 Documentation/x86/pti.txt                          | 186 +++++++
 Makefile                                           |   6 +-
 arch/cris/arch-v10/lib/Makefile                    |   3 -
 arch/x86/Kconfig                                   |  14 +
 arch/x86/Makefile                                  |   8 +
 arch/x86/include/asm/alternative-asm.h             |  19 +-
 arch/x86/include/asm/alternative.h                 |  24 +-
 arch/x86/include/asm/asm.h                         |  17 +-
 arch/x86/include/asm/bitops.h                      |   2 +
 arch/x86/include/asm/cpufeature.h                  |  22 +
 arch/x86/include/asm/intel-family.h                |  68 +++
 arch/x86/include/asm/msr-index.h                   |   3 +
 arch/x86/include/asm/msr.h                         |   2 +
 arch/x86/include/asm/nospec-branch.h               | 199 ++++++++
 arch/x86/include/asm/processor.h                   |   6 +-
 arch/x86/include/asm/system.h                      |  68 ++-
 arch/x86/include/asm/thread_info.h                 |   3 -
 arch/x86/include/asm/uaccess.h                     |   8 +-
 arch/x86/include/asm/uaccess_32.h                  |  12 +
 arch/x86/include/asm/uaccess_64.h                  |  22 +-
 arch/x86/include/asm/xen/hypercall.h               |   5 +-
 arch/x86/kernel/alternative.c                      |  31 +-
 arch/x86/kernel/cpu/Makefile                       |   4 +-
 arch/x86/kernel/cpu/amd.c                          |  28 +-
 arch/x86/kernel/cpu/bugs.c                         | 299 ++++++++++-
 arch/x86/kernel/cpu/bugs_64.c                      |  33 --
 arch/x86/kernel/cpu/common.c                       |  34 +-
 arch/x86/kernel/entry_32.S                         |  14 +-
 arch/x86/kernel/entry_64.S                         |  31 +-
 arch/x86/kernel/irq_32.c                           |   9 +-
 arch/x86/kernel/kprobes.c                          |  23 +-
 arch/x86/kernel/vmlinux.lds.S                      |   7 +
 arch/x86/kvm/svm.c                                 |  69 ++-
 arch/x86/kvm/vmx.c                                 | 110 ++--
 arch/x86/lib/Makefile                              |   2 +
 arch/x86/lib/checksum_32.S                         |   7 +-
 arch/x86/lib/getuser.S                             |   8 +
 arch/x86/lib/msr.c                                 |  89 +++-
 arch/x86/lib/retpoline-export.c                    |  25 +
 arch/x86/lib/retpoline.S                           |  45 ++
 arch/x86/lib/usercopy_32.c                         |   5 +
 drivers/base/Kconfig                               |   3 +
 drivers/base/cpu.c                                 |  49 ++
 drivers/edac/mce_amd.h                             |   2 -
 drivers/hv/hv.c                                    |  25 +-
 drivers/media/common/tuners/max2165.c              |   9 +-
 drivers/media/dvb/frontends/tda8261_cfg.h          |   2 +-
 drivers/net/ethernet/realtek/atp.c                 |  58 +--
 drivers/net/ethernet/realtek/atp.h                 |   2 -
 drivers/net/wireless/ath/ath6kl/hif.h              |   2 +-
 drivers/net/wireless/ath/ath6kl/sdio.c             |   4 +-
 .../net/wireless/brcm80211/brcmfmac/wl_cfg80211.c  |   2 +-
 drivers/net/wireless/brcm80211/brcmsmac/aiutils.c  |   3 -
 drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c  |   5 +-
 drivers/net/wireless/rtlwifi/rtl8192de/dm.c        |   6 +-
 drivers/net/wireless/rtlwifi/rtl8192se/phy.c       |   3 +
 drivers/staging/wlan-ng/p80211netdev.c             |   2 +
 drivers/usb/renesas_usbhs/mod_gadget.c             |   6 +-
 drivers/usb/renesas_usbhs/mod_host.c               |   6 +-
 drivers/usb/renesas_usbhs/pipe.h                   |   6 +-
 fs/compat.c                                        |  10 +-
 fs/compat_ioctl.c                                  |   1 -
 fs/internal.h                                      |   2 +-
 fs/namespace.c                                     |  26 +-
 include/linux/bitops.h                             |   3 +
 include/linux/cpu.h                                |   7 +
 include/linux/fdtable.h                            |   5 +-
 include/linux/init.h                               |   9 +-
 include/linux/kaiser.h                             |   2 +-
 include/linux/kconfig.h                            |  23 +-
 include/linux/module.h                             |   9 +
 include/linux/nospec.h                             |  59 +++
 include/net/bluetooth/hci_core.h                   |   1 -
 kernel/gcov/Kconfig                                |  30 ++
 kernel/gcov/Makefile                               |  32 +-
 kernel/gcov/base.c                                 |  38 +-
 kernel/gcov/fs.c                                   |  27 +-
 kernel/gcov/gcc_3_4.c                              | 115 +++++
 kernel/gcov/gcc_4_7.c                              | 565 +++++++++++++++++++++
 kernel/gcov/gcov.h                                 |  65 +--
 kernel/kprobes.c                                   |  10 +-
 kernel/module.c                                    |  11 +
 net/bluetooth/hci_conn.c                           |  16 -
 scripts/mod/modpost.c                              |  58 ++-
 security/selinux/ss/services.c                     |  54 +-
 89 files changed, 2640 insertions(+), 464 deletions(-)

-- 
Ben Hutchings
Design a system any fool can use, and only a fool will want to use it.
