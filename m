Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824498-2-10242462094108362805
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
    t=1520824497; b=t6Z8cXupTUVQLFW/YFmFRhp1y2O42AwGF50mxX7C+u+T8pq
    sQo0wXx5h84TmowjgixnQKghqpYF7IblGJk7a4bqrv0g4RfujMtmH/2zRQ8naf7O
    eT6qKeCnf26WYPGsK2a14XcpIbDGgDn/lIdQNmpgkEZkw2cm0jGG7OFJEdXJmW9L
    9zDwc0yKbM/J1qTd78Z6ZZxeuwKQtF29snwLT+MLjMH2nKO02qybb8Ht9whBP0HM
    q991Dr5U47HmZAtgDl3zLAbrIpzHNWDtKF8UC6Q3sOU8qtAj1KGCe3uToUT6rprx
    SdFHKCHq7cU0+kpZUw29WQa9i9iLWdVeFQWaUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:sender:list-id;
    s=arctest; t=1520824497; bh=iTxrqA1m6LKp5j+UCG/xvB0YsRaVTkjsCcr
    BXEC7n4U=; b=jKcmj84dH35cxIDa3pgY+BRxVuCpVNPHtaH3IZQcESTi3PZlMQH
    /58CeP/I4PfwRAuJx11nyid3B2RcOwzZB1Wv6gMvieiFMPvCW4mjDDNisgxVblJc
    eAHw91rAKOmdf2wx7WQJX9SGeHOPrDsafobabbToF6/GCrBWuW1xVmt+hl3feKI7
    HKSBkk30414MonHIFmdynlpG0Hib/9nidRsqdHwxfM7PjHM+iiErDf4znzbs5Qmi
    C7XqvIZ/kdeILYNJn40H939osmivUuQa1V6AMBBK5FGHboaIs7aoRAIlOP2xopkF
    vVNeU2J/ZzNUp0czlk2e5/x/tHSZQV75+CQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S932789AbeCLDOx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:14:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41505 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932779AbeCLDHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:51 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org
Date: Mon, 12 Mar 2018 03:06:11 +0000
Message-ID: <lsq.1520823971.5976735@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 00/76] 3.16.56-rc1 review
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.16.56 release.
There are 76 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar 14 12:00:00 UTC 2018.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.16.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Andi Kleen (3):
      module/retpoline: Warn about missing retpoline in module
         [caf7501a1b4ec964190f31f9c3f163de252273b8]
      x86/retpoline/irq32: Convert assembler indirect jumps
         [7614e913db1f40fff819b36216484dc3808995d4]
      x86/retpoline: Optimize inline assembler for vmexit_fill_RSB
         [3f7d875566d8e79c5e0b2c9a413e91b2c29e0854]

Andrey Ryabinin (1):
      x86/asm: Use register variable to get stack pointer value
         [196bd485ee4f03ce4c690bfcf38138abfcd0a4bc]

Andy Lutomirski (3):
      x86/asm: Make asm/alternative.h safe from assembly
         [f005f5d860e0231fe212cfda8c1a3148b99609f4]
      x86/cpu: Factor out application of forced CPU caps
         [8bf1ebca215c262e48c15a4a15f175991776f57f]
      x86: Clean up current_stack_pointer
         [83653c16da91112236292871b820cb8b367220e3]

Arnd Bergmann (1):
      x86: fix build warnign with 32-bit PAE
         [not upstream; specific to KAISER]

Ben Hutchings (1):
      x86/syscall: Sanitize syscall table de-references under speculation
         [2fbd7af5af8665d18bcefae3e9700be07e22b681]

Borislav Petkov (6):
      x86/alternatives: Fix ALTERNATIVE_2 padding generation properly
         [dbe4058a6a44af4ca5d146aebe01b0a1f9b7fd2a]
      x86/alternatives: Fix optimize_nops() checking
         [612e8e9350fd19cae6900cf36ea0c6892d1a0dca]
      x86/alternatives: Guard NOPs optimization
         [69df353ff305805fc16082d0c5bfa6e20fa8b863]
      x86/bugs: Drop one "mitigation" from dmesg
         [55fa19d3e51f33d9cd4056d25836d93abf9438db]
      x86/cpu: Merge bugs.c and bugs_64.c
         [62a67e123e058a67db58bc6a14354dd037bafd0a]
      x86/nospec: Fix header guards names
         [7a32fc51ca938e67974cbb9db31e1a43f98345a9]

Colin Ian King (1):
      x86/spectre: Fix spelling mistake: "vunerable"-> "vulnerable"
         [e698dcdfcda41efd0984de539767b4cddd235f1e]

Dan Carpenter (1):
      x86/spectre: Fix an error message
         [9de29eac8d2189424d81c0d840cd0469aa3d41c8]

Dan Williams (13):
      array_index_nospec: Sanitize speculative array de-references
         [f3804203306e098dae9ca51540fcd5eb700d7f40]
      nl80211: Sanitize array index in parse_txq_params
         [259d8c1e984318497c84eef547bbb6b1d9f4eb05]
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
      x86/usercopy: Replace open coded stac/clac with __uaccess_{begin, end}
         [b5c4ae4f35325d520b230bab6eb3310613b72ac1]
      x86: Implement array_index_mask_nospec
         [babdde2698d482b6c0de1eab4f697cf5856c5859]
      x86: Introduce __uaccess_begin_nospec() and uaccess_try_nospec
         [b3bbfb3fb5d25776b8e3f361d2eedaabb0b496cd]
      x86: Introduce barrier_nospec
         [b3d7ad85b80bbc404635dca80f5b129f6242bc7a]

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
      x86/cpufeatures: Add X86_BUG_SPECTRE_V[12]
         [99c6fa2511d8a683e61468be91b83f85452115fa]
      x86/cpufeatures: Clean up Spectre v2 related CPUID flags
         [2961298efe1ea1b6fc0d7ee8b76018fa6c0bcef2]
      x86/retpoline/checksum32: Convert assembler indirect jumps
         [5096732f6f695001fa2d6f1335a2680b37912c69]
      x86/retpoline/crypto: Convert crypto assembler indirect jumps
         [9697fa39efd3fc3692f2949d4045f393ec58450b]
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

Gustavo A. R. Silva (1):
      x86/cpu: Change type of x86_cache_size variable to unsigned int
         [24dbc6000f4b9b0ef5a9daecb161f1907733765a]

Jim Mattson (1):
      kvm: vmx: Scrub hardware GPRs at VM-exit
         [0cb5b30698fdc8f6b4646012e3acb4ddce430788]

Josh Poimboeuf (1):
      x86/paravirt: Remove 'noreplace-paravirt' cmdline option
         [12c69f1e94c89d40696e83804dd2f0965b5250cd]

KarimAllah Ahmed (1):
      x86/spectre: Simplify spectre_v2 command line parsing
         [9005c6834c0ffdfe46afa76656bd9276cca864f6]

Linus Torvalds (2):
      x86: fix SMAP in 32-bit environments
         [de9e478b9d49f3a0214310d921450cf5bb4a21e6]
      x86: reorganize SMAP handling in user space accesses
         [11f1a4b9755f5dbc3e822a96502ebe9b044b14d8]

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

Peter Zijlstra (2):
      KVM: VMX: Make indirect call speculation safe
         [c940a3fb1e2e9b7d03228ab28f375fb5a47ff699]
      KVM: x86: Make indirect calls in emulator speculation safe
         [1a29b5b7f347a1a9230c1e0af5b37e3e571588ab]

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

Zhenwei.Pi (1):
      x86/pti: Document fix wrong index
         [98f0fceec7f84d80bc053e49e596088573086421]

 Documentation/ABI/testing/sysfs-devices-system-cpu |  16 ++
 Documentation/kernel-parameters.txt                |  51 +++-
 Documentation/speculation.txt                      |  90 +++++++
 Documentation/x86/pti.txt                          | 186 +++++++++++++
 Makefile                                           |   4 +-
 arch/x86/Kconfig                                   |  14 +
 arch/x86/Makefile                                  |   8 +
 arch/x86/crypto/aesni-intel_asm.S                  |   5 +-
 arch/x86/crypto/camellia-aesni-avx-asm_64.S        |   3 +-
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S       |   3 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S          |   3 +-
 arch/x86/include/asm/alternative-asm.h             |  14 +-
 arch/x86/include/asm/alternative.h                 |  20 +-
 arch/x86/include/asm/asm.h                         |  11 +
 arch/x86/include/asm/barrier.h                     |  31 ++-
 arch/x86/include/asm/cpufeature.h                  |   8 +
 arch/x86/include/asm/intel-family.h                |  68 +++++
 arch/x86/include/asm/nospec-branch.h               | 198 ++++++++++++++
 arch/x86/include/asm/processor.h                   |   6 +-
 arch/x86/include/asm/switch_to.h                   |  38 +++
 arch/x86/include/asm/uaccess.h                     |  64 +++--
 arch/x86/include/asm/uaccess_32.h                  |  24 ++
 arch/x86/include/asm/uaccess_64.h                  |  94 +++++--
 arch/x86/include/asm/xen/hypercall.h               |   5 +-
 arch/x86/include/uapi/asm/msr-index.h              |   3 +
 arch/x86/kernel/alternative.c                      |  29 +-
 arch/x86/kernel/cpu/Makefile                       |   4 +-
 arch/x86/kernel/cpu/amd.c                          |  28 +-
 arch/x86/kernel/cpu/bugs.c                         | 299 ++++++++++++++++++++-
 arch/x86/kernel/cpu/bugs_64.c                      |  33 ---
 arch/x86/kernel/cpu/common.c                       |  32 ++-
 arch/x86/kernel/cpu/microcode/intel.c              |   2 +-
 arch/x86/kernel/cpu/proc.c                         |   4 +-
 arch/x86/kernel/entry_32.S                         |  15 +-
 arch/x86/kernel/entry_64.S                         |  29 +-
 arch/x86/kernel/irq_32.c                           |  16 +-
 arch/x86/kernel/kprobes/opt.c                      |  23 +-
 arch/x86/kernel/mcount_64.S                        |   8 +-
 arch/x86/kernel/vmlinux.lds.S                      |   6 +
 arch/x86/kvm/emulate.c                             |   9 +-
 arch/x86/kvm/svm.c                                 |  23 ++
 arch/x86/kvm/vmx.c                                 |  46 ++--
 arch/x86/lib/Makefile                              |   2 +
 arch/x86/lib/checksum_32.S                         |   7 +-
 arch/x86/lib/getuser.S                             |  10 +
 arch/x86/lib/retpoline-export.c                    |  24 ++
 arch/x86/lib/retpoline.S                           |  47 ++++
 arch/x86/lib/usercopy_32.c                         |  20 +-
 drivers/base/Kconfig                               |   3 +
 drivers/base/cpu.c                                 |  48 ++++
 drivers/hv/hv.c                                    |  25 +-
 include/linux/cpu.h                                |   7 +
 include/linux/fdtable.h                            |   5 +-
 include/linux/init.h                               |   9 +-
 include/linux/kaiser.h                             |   2 +-
 include/linux/kconfig.h                            |   9 +-
 include/linux/module.h                             |   9 +
 include/linux/nospec.h                             |  59 ++++
 kernel/module.c                                    |  11 +
 net/wireless/nl80211.c                             |   9 +-
 scripts/mod/modpost.c                              |   9 +
 61 files changed, 1662 insertions(+), 226 deletions(-)

-- 
Ben Hutchings
Design a system any fool can use, and only a fool will want to use it.
