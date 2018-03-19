Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521494082-2-1796208381552797701
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: linux-3.2.101.patch
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494075; b=MvIL+ZdC7CDnvoEvZBq+X5S0GFhNJDO9gtCV3QVj5diiYxq
    ZCmacsomz373K5darSx9OgRDvR70KQBf1ErcC5uCS0jE6c47ggtzfKImjkDydoAb
    Un4wKo2AiOyI9XMsxTfl9Nz21LGYBFj4vU/s5vvRzk1VGAjeyTGxTnCNBarFwNtl
    twxkJ3Ld/K/NUzAKOPMIC1cT4W3w15fUyWWXdPSjoX2vaoWzOhZGUfUHUmQTmplv
    PyFpBtW0uR0WBodUJaMUJ7+fvWMfJxy44L4H1LWf7F0zdpxPGjPz6RI8zwIPQB1W
    oFgIvNdIT+wOU55SePcKB1bXaw4jgoHGSaekD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:mime-version
    :content-type:subject:sender:list-id; s=arctest; t=1521494075;
    bh=hMbeVh95wJa+ixdnhuSdN8p2r6zCPu+t4/xeaqz2vNc=; b=QPLS7Aq36Bgm
    tUO9R8Z1yCSaxvDo4ywSQEhOCBrxfajgX7rFcol43GDjW392oyD7glqWwJDBtrj8
    6CtV9O6vKvgEEZlVmDa3EI+CrEpp//NgQXN72BivQCHpm2VVDYkyeuQCjxdXjz9S
    AF1Jv4s/SUAeqkMw0MGZkrXkk+dj6IpWmS3KPmoNAUorWVXdYV79yqPriDCp0yqy
    go5ji9IV167fWMzA13WoTCnwyuI/S5bDmITOkmfpT9n45/TEBWvMf17OEUGLJykL
    Si32jnvMiTAfajBKKK0SUNWCdnrNDeOztnufQHp4Nr7/owyq9SMV9E7QJC5sgvJC
    ykeYDz4lyQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvkfggtgguofgfufhsphejsehgtderreerredunecuhfhrohhmpeeuvghnucfjuhhttghhihhnghhsuceosggvnhesuggvtggruggvnhhtrdhorhhgrdhukheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdekkedrleeirddurdduvdeinecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudeludejjeelnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvkfggtgguofgfufhsphejsehgtderreerredunecuhfhrohhmpeeuvghnucfjuhhttghhihhnghhsuceosggvnhesuggvtggruggvnhhtrdhorhhgrdhukheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdekkedrleeirddurdduvdeinecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudeludejjeelnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934973AbeCSVLx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:11:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52019 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934955AbeCSVKr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 17:10:47 -0400
Date: Mon, 19 Mar 2018 21:10:33 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>,
        stable@vger.kernel.org
Cc: lwn@lwn.net
Message-ID: <20180319211033.GI8564@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o+ZCuNqY+dEAKBWl"
Content-Disposition: inline
X-Mailer: LinuxStableQueue (scripts by bwh)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        shadbolt.decadent.org.uk
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS autolearn=disabled
        version=3.4.0
Subject: Linux 3.2.101
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--o+ZCuNqY+dEAKBWl
Content-Type: multipart/mixed; boundary="Qgof7w7UksPF5inF"
Content-Disposition: inline


--Qgof7w7UksPF5inF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.2.101 kernel.

All users of the 3.2 kernel series should upgrade.

The updated 3.2.y git tree can be found at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
=2Egit linux-3.2.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git

The diff from 3.2.100 is attached to this message.

Ben.

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu |  16 +
 Documentation/gcov.txt                             |   4 +
 Documentation/kernel-parameters.txt                |  51 +-
 Documentation/speculation.txt                      |  90 ++++
 Documentation/x86/pti.txt                          | 186 +++++++
 Makefile                                           |   4 +-
 arch/cris/arch-v10/lib/Makefile                    |   3 -
 arch/x86/Kconfig                                   |  14 +
 arch/x86/Makefile                                  |   8 +
 arch/x86/ia32/ia32entry.S                          |  54 +-
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
 arch/x86/kernel/entry_32.S                         |  24 +-
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
 kernel/gcov/gcc_4_7.c                              | 565 +++++++++++++++++=
++++
 kernel/gcov/gcov.h                                 |  65 +--
 kernel/kprobes.c                                   |  10 +-
 kernel/module.c                                    |  11 +
 net/bluetooth/hci_conn.c                           |  16 -
 scripts/mod/modpost.c                              |  58 ++-
 security/selinux/ss/services.c                     |  54 +-
 90 files changed, 2688 insertions(+), 478 deletions(-)

Alexandre Oliva (1):
      brcmfmac: work-around gcc 4.7 build issue

Andi Kleen (5):
      brcm80211: Remove bogus memcpy in ai_detach
      ath6kl: fix uninitialized variable in ath6kl_sdio_enable_scatter()
      x86/retpoline/irq32: Convert assembler indirect jumps
      x86/retpoline: Optimize inline assembler for vmexit_fill_RSB
      module/retpoline: Warn about missing retpoline in module

Andrey Ryabinin (1):
      x86/asm: Use register variable to get stack pointer value

Andy Lutomirski (2):
      x86/cpu: Factor out application of forced CPU caps
      x86/asm: Make asm/alternative.h safe from assembly

Arnd Bergmann (2):
      Turn off -Wmaybe-uninitialized when building with -Os
      x86: fix build warnign with 32-bit PAE

Avi Kivity (2):
      KVM: VMX: Make use of asm.h
      KVM: SVM: Make use of asm.h

Ben Hutchings (2):
      x86/syscall: Sanitize syscall table de-references under speculation
      Linux 3.2.101

Borislav Petkov (9):
      x86/bitops: Move BIT_64() for a wider use
      x86, cpu: Expand cpufeature facility to include cpu bugs
      x86: Add another set of MSR accessor functions
      x86/cpu: Merge bugs.c and bugs_64.c
      x86/alternatives: Guard NOPs optimization
      x86/alternatives: Fix ALTERNATIVE_2 padding generation properly
      x86/alternatives: Fix optimize_nops() checking
      x86/nospec: Fix header guards names
      x86/bugs: Drop one "mitigation" from dmesg

Colin Ian King (1):
      x86/spectre: Fix spelling mistake: "vunerable"-> "vulnerable"

Dan Carpenter (1):
      x86/spectre: Fix an error message

Dan Williams (11):
      array_index_nospec: Sanitize speculative array de-references
      x86: Implement array_index_mask_nospec
      x86: Introduce barrier_nospec
      x86/get_user: Use pointer masking to limit speculation
      vfs, fdtable: Prevent bounds-check bypass via speculative execution
      x86/spectre: Report get_user mitigation for spectre_v1
      x86/kvm: Update spectre-v1 mitigation
      nospec: Kill array_index_nospec_mask_check()
      nospec: Include <asm/barrier.h> dependency
      x86: Introduce __uaccess_begin_nospec() and uaccess_try_nospec
      x86/uaccess: Use __uaccess_begin_nospec() and uaccess_try_nospec

Danny Kukawka (1):
      max2165: trival fix for some -Wuninitialized warning

Darren Kenny (1):
      x86/speculation: Fix typo IBRS_ATT, which should be IBRS_ALL

Dave Hansen (2):
      x86/Documentation: Add PTI description
      x86/cpu/intel: Introduce macros for Intel family numbers

David Woodhouse (14):
      x86/alternatives: Add missing ' ' at end of ALTERNATIVE inline asm
      x86/cpufeatures: Add X86_BUG_SPECTRE_V[12]
      sysfs/cpu: Fix typos in vulnerability documentation
      x86/retpoline: Add initial retpoline support
      x86/spectre: Add boot time option to select Spectre v2 mitigation
      x86/retpoline/entry: Convert entry assembler indirect jumps
      x86/retpoline/ftrace: Convert ftrace assembler indirect jumps
      x86/retpoline/hyperv: Convert assembler indirect jumps
      x86/retpoline/xen: Convert Xen hypercall indirect jumps
      x86/retpoline/checksum32: Convert assembler indirect jumps
      x86/retpoline: Fill return stack buffer on vmexit
      x86/retpoline: Fill RSB on context switch for affected CPUs
      x86/retpoline: Avoid retpolines for built-in __init functions
      x86/cpufeatures: Clean up Spectre v2 related CPUID flags

Dou Liyang (1):
      x86/spectre: Check CONFIG_RETPOLINE in command line parser

Frantisek Hrbata (3):
      gcov: move gcov structs definitions to a gcc version specific file
      gcov: add support for gcc 4.7 gcov format
      gcov: compile specific gcov implementation based on gcc version

H. Peter Anvin (1):
      x86, alternative: Add header guards to <asm/alternative-asm.h>

Han Shen (2):
      rtl8192c:dm: Properly initialize local array and set value.
      Removed unused typedef to avoid "unused local typedef" warnings.

Jan-Simon M=F6ller (1):
      x86, asm: Extend definitions of _ASM_* with a raw format

Jim Mattson (1):
      kvm: vmx: Scrub hardware GPRs at VM-exit

Josh Poimboeuf (1):
      x86/paravirt: Remove 'noreplace-paravirt' cmdline option

Kalle Valo (1):
      ath6kl: fix struct hif_scatter_req list handling

KarimAllah Ahmed (1):
      x86/spectre: Simplify spectre_v2 command line parsing

Kuninori Morimoto (2):
      usb: renesas_usbhs: fixup __usbhs_for_each_pipe 1st pos
      usb: renesas_usbhs: tidyup original usbhsx_for_each_xxx macro

Larry Finger (3):
      rtlwifi: rtl8192se: Fix gcc 4.7.x warning
      rtlwifi: rtl8192c: Fix W=3D1 warning
      rtlwifi: rtl8192de: Fix W=3D1 build warnings

Mark Rutland (1):
      Documentation: Document array_index_nospec

Masahiro Yamada (1):
      kconfig.h: use __is_defined() to check if MODULE is defined

Masami Hiramatsu (3):
      retpoline: Introduce start/end markers of indirect thunk
      kprobes/x86: Blacklist indirect thunk functions for kprobes
      kprobes/x86: Disable optimizing on the function jumps to indirect thu=
nk

Mathias Krause (1):
      modpost: reduce visibility of symbols and constify r/o arrays

Paul Bolle (2):
      budget-av: only use t_state if initialized
      atp: remove set_rx_mode_8012()

Paul Gortmaker (3):
      modpost: don't emit section mismatch warnings for compiler optimizati=
ons
      kconfig: fix IS_ENABLED to not require all options to be defined
      cris: Remove old legacy "-traditional" flag from arch-v10/lib/Makefile

Peter Huewe (1):
      staging/wlan-ng: Fix 'Branch condition evaluates to a garbage value' =
in p80211netdev.c

Srinivas Pandruvada (1):
      bitops: Introduce BIT_ULL

Syam Sidhardhan (1):
      Bluetooth: Remove unused hci_le_ltk_reply()

Thomas Gleixner (8):
      x86/cpufeatures: Make CPU bugs sticky
      x86/cpufeatures: Add X86_BUG_CPU_INSECURE
      x86/pti: Rename BUG_CPU_INSECURE to BUG_CPU_MELTDOWN
      sysfs/cpu: Add vulnerability folder
      x86/cpu: Implement CPU vulnerabilites sysfs functions
      x86/alternatives: Make optimize_nops() interrupt safe and synced
      x86/retpoline: Remove compile time warning
      x86/cpu/bugs: Make retpoline module warning conditional

Tim Gardner (2):
      SELinux: security_load_policy: Silence frame-larger-than warning
      fs: namespace: suppress 'may be used uninitialized' warnings

Tom Lendacky (4):
      x86/cpu, x86/pti: Do not enable PTI on AMD processors
      x86/cpu/AMD: Make LFENCE a serializing instruction
      x86/cpu/AMD: Use LFENCE_RDTSC in preference to MFENCE_RDTSC
      x86/retpoline: Add LFENCE to the retpoline/RSB filling RSB macros

Waiman Long (1):
      x86/retpoline: Remove the esp/rsp thunk

Will Deacon (1):
      nospec: Move array_index_nospec() parameter checking into separate ma=
cro

Yuan Pengfei (1):
      gcov: add support for GCC 4.9

Yunlian Jiang (1):
      rtlwifi: initialize local array and set value.

zhenwei.pi (1):
      x86/pti: Document fix wrong index


--Qgof7w7UksPF5inF
Content-Type: text/x-diff; charset=UTF-8; name="linux-3.2.101.patch"
Content-Disposition: attachment; filename="linux-3.2.101.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documenta=
tion/ABI/testing/sysfs-devices-system-cpu
index e7be75b96e4b..8e7ecfeb03f6 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -201,3 +201,19 @@ Description:	Disable L3 cache indices
 		All AMD processors with L3 caches provide this functionality.
 		For details, see BKDGs at
 		http://developer.amd.com/documentation/guides/Pages/default.aspx
+
+What:		/sys/devices/system/cpu/vulnerabilities
+		/sys/devices/system/cpu/vulnerabilities/meltdown
+		/sys/devices/system/cpu/vulnerabilities/spectre_v1
+		/sys/devices/system/cpu/vulnerabilities/spectre_v2
+Date:		January 2018
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Information about CPU vulnerabilities
+
+		The files are named after the code names of CPU
+		vulnerabilities. The output of those files reflects the
+		state of the CPUs in the system. Possible output values:
+
+		"Not affected"	  CPU is not affected by the vulnerability
+		"Vulnerable"	  CPU is affected and no mitigation in effect
+		"Mitigation: $M"  CPU is affected and mitigation $M is in effect
diff --git a/Documentation/gcov.txt b/Documentation/gcov.txt
index e7ca6478cd93..7b727783db7e 100644
--- a/Documentation/gcov.txt
+++ b/Documentation/gcov.txt
@@ -50,6 +50,10 @@ for the entire kernel and provide coverage overviews in =
HTML format.
         CONFIG_DEBUG_FS=3Dy
         CONFIG_GCOV_KERNEL=3Dy
=20
+select the gcc's gcov format, default is autodetect based on gcc version:
+
+        CONFIG_GCOV_FORMAT_AUTODETECT=3Dy
+
 and to get coverage data for the entire kernel:
=20
         CONFIG_GCOV_PROFILE_ALL=3Dy
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-par=
ameters.txt
index 0d27ce60d452..ff397dbf36a4 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1753,6 +1753,11 @@ bytes respectively. Such letter suffixes can also be=
 entirely omitted.
 			register save and restore. The kernel will only save
 			legacy floating-point registers on task switch.
=20
+	nospectre_v2	[X86] Disable all mitigations for the Spectre variant 2
+			(indirect branch prediction) vulnerability. System may
+			allow data leaks with this option, which is equivalent
+			to spectre_v2=3Doff.
+
 	noxsave		[BUGS=3DX86] Disables x86 extended register state save
 			and restore using xsave. The kernel will fallback to
 			enabling legacy floating-point and sse state.
@@ -1803,8 +1808,6 @@ bytes respectively. Such letter suffixes can also be =
entirely omitted.
=20
 	nojitter	[IA-64] Disables jitter checking for ITC timers.
=20
-	nopti		[X86-64] Disable KAISER isolation of kernel from user.
-
 	no-kvmclock	[X86,KVM] Disable paravirtualized KVM clock driver
=20
 	no-kvmapf	[X86,KVM] Disable paravirtualized asynchronous page
@@ -1836,8 +1839,6 @@ bytes respectively. Such letter suffixes can also be =
entirely omitted.
 	norandmaps	Don't use address space randomization.  Equivalent to
 			echo 0 > /proc/sys/kernel/randomize_va_space
=20
-	noreplace-paravirt	[X86,IA-64,PV_OPS] Don't patch paravirt_ops
-
 	noreplace-smp	[X86-32,SMP] Don't replace SMP instructions
 			with UP alternatives
=20
@@ -2245,11 +2246,20 @@ bytes respectively. Such letter suffixes can also b=
e entirely omitted.
 	pt.		[PARIDE]
 			See Documentation/blockdev/paride.txt.
=20
-	pti=3D		[X86_64]
-			Control KAISER user/kernel address space isolation:
-			on - enable
-			off - disable
-			auto - default setting
+	pti=3D		[X86_64] Control Page Table Isolation of user and
+			kernel address spaces.  Disabling this feature
+			removes hardening, but improves performance of
+			system calls and interrupts.
+
+			on   - unconditionally enable
+			off  - unconditionally disable
+			auto - kernel detects whether your CPU model is
+			       vulnerable to issues that PTI mitigates
+
+			Not specifying this option is equivalent to pti=3Dauto.
+
+	nopti		[X86_64]
+			Equivalent to pti=3Doff
=20
 	pty.legacy_count=3D
 			[KNL] Number of legacy pty's. Overwrites compiled-in
@@ -2461,6 +2471,29 @@ bytes respectively. Such letter suffixes can also be=
 entirely omitted.
 	specialix=3D	[HW,SERIAL] Specialix multi-serial port adapter
 			See Documentation/serial/specialix.txt.
=20
+	spectre_v2=3D	[X86] Control mitigation of Spectre variant 2
+			(indirect branch speculation) vulnerability.
+
+			on   - unconditionally enable
+			off  - unconditionally disable
+			auto - kernel detects whether your CPU model is
+			       vulnerable
+
+			Selecting 'on' will, and 'auto' may, choose a
+			mitigation method at run time according to the
+			CPU, the available microcode, the setting of the
+			CONFIG_RETPOLINE configuration option, and the
+			compiler with which the kernel was built.
+
+			Specific mitigations can also be selected manually:
+
+			retpoline	  - replace indirect branches
+			retpoline,generic - google's original retpoline
+			retpoline,amd     - AMD-specific minimal thunk
+
+			Not specifying this option is equivalent to
+			spectre_v2=3Dauto.
+
 	spia_io_base=3D	[HW,MTD]
 	spia_fio_base=3D
 	spia_pedr=3D
diff --git a/Documentation/speculation.txt b/Documentation/speculation.txt
new file mode 100644
index 000000000000..e9e6cbae2841
--- /dev/null
+++ b/Documentation/speculation.txt
@@ -0,0 +1,90 @@
+This document explains potential effects of speculation, and how undesirab=
le
+effects can be mitigated portably using common APIs.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Speculation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+To improve performance and minimize average latencies, many contemporary C=
PUs
+employ speculative execution techniques such as branch prediction, perform=
ing
+work which may be discarded at a later stage.
+
+Typically speculative execution cannot be observed from architectural stat=
e,
+such as the contents of registers. However, in some cases it is possible to
+observe its impact on microarchitectural state, such as the presence or
+absence of data in caches. Such state may form side-channels which can be
+observed to extract secret information.
+
+For example, in the presence of branch prediction, it is possible for boun=
ds
+checks to be ignored by code which is speculatively executed. Consider the
+following code:
+
+	int load_array(int *array, unsigned int index)
+	{
+		if (index >=3D MAX_ARRAY_ELEMS)
+			return 0;
+		else
+			return array[index];
+	}
+
+Which, on arm64, may be compiled to an assembly sequence such as:
+
+	CMP	<index>, #MAX_ARRAY_ELEMS
+	B.LT	less
+	MOV	<returnval>, #0
+	RET
+  less:
+	LDR	<returnval>, [<array>, <index>]
+	RET
+
+It is possible that a CPU mis-predicts the conditional branch, and
+speculatively loads array[index], even if index >=3D MAX_ARRAY_ELEMS. This
+value will subsequently be discarded, but the speculated load may affect
+microarchitectural state which can be subsequently measured.
+
+More complex sequences involving multiple dependent memory accesses may
+result in sensitive information being leaked. Consider the following
+code, building on the prior example:
+
+	int load_dependent_arrays(int *arr1, int *arr2, int index)
+	{
+		int val1, val2,
+
+		val1 =3D load_array(arr1, index);
+		val2 =3D load_array(arr2, val1);
+
+		return val2;
+	}
+
+Under speculation, the first call to load_array() may return the value
+of an out-of-bounds address, while the second call will influence
+microarchitectural state dependent on this value. This may provide an
+arbitrary read primitive.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Mitigating speculation side-channels
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The kernel provides a generic API to ensure that bounds checks are
+respected even under speculation. Architectures which are affected by
+speculation-based side-channels are expected to implement these
+primitives.
+
+The array_index_nospec() helper in <linux/nospec.h> can be used to
+prevent information from being leaked via side-channels.
+
+A call to array_index_nospec(index, size) returns a sanitized index
+value that is bounded to [0, size) even under cpu speculation
+conditions.
+
+This can be used to protect the earlier load_array() example:
+
+	int load_array(int *array, unsigned int index)
+	{
+		if (index >=3D MAX_ARRAY_ELEMS)
+			return 0;
+		else {
+			index =3D array_index_nospec(index, MAX_ARRAY_ELEMS);
+			return array[index];
+		}
+	}
diff --git a/Documentation/x86/pti.txt b/Documentation/x86/pti.txt
new file mode 100644
index 000000000000..5cd58439ad2d
--- /dev/null
+++ b/Documentation/x86/pti.txt
@@ -0,0 +1,186 @@
+Overview
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+Page Table Isolation (pti, previously known as KAISER[1]) is a
+countermeasure against attacks on the shared user/kernel address
+space such as the "Meltdown" approach[2].
+
+To mitigate this class of attacks, we create an independent set of
+page tables for use only when running userspace applications.  When
+the kernel is entered via syscalls, interrupts or exceptions, the
+page tables are switched to the full "kernel" copy.  When the system
+switches back to user mode, the user copy is used again.
+
+The userspace page tables contain only a minimal amount of kernel
+data: only what is needed to enter/exit the kernel such as the
+entry/exit functions themselves and the interrupt descriptor table
+(IDT).  There are a few strictly unnecessary things that get mapped
+such as the first C function when entering an interrupt (see
+comments in pti.c).
+
+This approach helps to ensure that side-channel attacks leveraging
+the paging structures do not function when PTI is enabled.  It can be
+enabled by setting CONFIG_PAGE_TABLE_ISOLATION=3Dy at compile time.
+Once enabled at compile-time, it can be disabled at boot with the
+'nopti' or 'pti=3D' kernel parameters (see kernel-parameters.txt).
+
+Page Table Management
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+When PTI is enabled, the kernel manages two sets of page tables.
+The first set is very similar to the single set which is present in
+kernels without PTI.  This includes a complete mapping of userspace
+that the kernel can use for things like copy_to_user().
+
+Although _complete_, the user portion of the kernel page tables is
+crippled by setting the NX bit in the top level.  This ensures
+that any missed kernel->user CR3 switch will immediately crash
+userspace upon executing its first instruction.
+
+The userspace page tables map only the kernel data needed to enter
+and exit the kernel.  This data is entirely contained in the 'struct
+cpu_entry_area' structure which is placed in the fixmap which gives
+each CPU's copy of the area a compile-time-fixed virtual address.
+
+For new userspace mappings, the kernel makes the entries in its
+page tables like normal.  The only difference is when the kernel
+makes entries in the top (PGD) level.  In addition to setting the
+entry in the main kernel PGD, a copy of the entry is made in the
+userspace page tables' PGD.
+
+This sharing at the PGD level also inherently shares all the lower
+layers of the page tables.  This leaves a single, shared set of
+userspace page tables to manage.  One PTE to lock, one set of
+accessed bits, dirty bits, etc...
+
+Overhead
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+Protection against side-channel attacks is important.  But,
+this protection comes at a cost:
+
+1. Increased Memory Use
+  a. Each process now needs an order-1 PGD instead of order-0.
+     (Consumes an additional 4k per process).
+  b. The 'cpu_entry_area' structure must be 2MB in size and 2MB
+     aligned so that it can be mapped by setting a single PMD
+     entry.  This consumes nearly 2MB of RAM once the kernel
+     is decompressed, but no space in the kernel image itself.
+
+2. Runtime Cost
+  a. CR3 manipulation to switch between the page table copies
+     must be done at interrupt, syscall, and exception entry
+     and exit (it can be skipped when the kernel is interrupted,
+     though.)  Moves to CR3 are on the order of a hundred
+     cycles, and are required at every entry and exit.
+  b. A "trampoline" must be used for SYSCALL entry.  This
+     trampoline depends on a smaller set of resources than the
+     non-PTI SYSCALL entry code, so requires mapping fewer
+     things into the userspace page tables.  The downside is
+     that stacks must be switched at entry time.
+  c. Global pages are disabled for all kernel structures not
+     mapped into both kernel and userspace page tables.  This
+     feature of the MMU allows different processes to share TLB
+     entries mapping the kernel.  Losing the feature means more
+     TLB misses after a context switch.  The actual loss of
+     performance is very small, however, never exceeding 1%.
+  d. Process Context IDentifiers (PCID) is a CPU feature that
+     allows us to skip flushing the entire TLB when switching page
+     tables by setting a special bit in CR3 when the page tables
+     are changed.  This makes switching the page tables (at context
+     switch, or kernel entry/exit) cheaper.  But, on systems with
+     PCID support, the context switch code must flush both the user
+     and kernel entries out of the TLB.  The user PCID TLB flush is
+     deferred until the exit to userspace, minimizing the cost.
+     See intel.com/sdm for the gory PCID/INVPCID details.
+  e. The userspace page tables must be populated for each new
+     process.  Even without PTI, the shared kernel mappings
+     are created by copying top-level (PGD) entries into each
+     new process.  But, with PTI, there are now *two* kernel
+     mappings: one in the kernel page tables that maps everything
+     and one for the entry/exit structures.  At fork(), we need to
+     copy both.
+  f. In addition to the fork()-time copying, there must also
+     be an update to the userspace PGD any time a set_pgd() is done
+     on a PGD used to map userspace.  This ensures that the kernel
+     and userspace copies always map the same userspace
+     memory.
+  g. On systems without PCID support, each CR3 write flushes
+     the entire TLB.  That means that each syscall, interrupt
+     or exception flushes the TLB.
+  h. INVPCID is a TLB-flushing instruction which allows flushing
+     of TLB entries for non-current PCIDs.  Some systems support
+     PCIDs, but do not support INVPCID.  On these systems, addresses
+     can only be flushed from the TLB for the current PCID.  When
+     flushing a kernel address, we need to flush all PCIDs, so a
+     single kernel address flush will require a TLB-flushing CR3
+     write upon the next use of every PCID.
+
+Possible Future Work
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+1. We can be more careful about not actually writing to CR3
+   unless its value is actually changed.
+2. Allow PTI to be enabled/disabled at runtime in addition to the
+   boot-time switching.
+
+Testing
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+To test stability of PTI, the following test procedure is recommended,
+ideally doing all of these in parallel:
+
+1. Set CONFIG_DEBUG_ENTRY=3Dy
+2. Run several copies of all of the tools/testing/selftests/x86/ tests
+   (excluding MPX and protection_keys) in a loop on multiple CPUs for
+   several minutes.  These tests frequently uncover corner cases in the
+   kernel entry code.  In general, old kernels might cause these tests
+   themselves to crash, but they should never crash the kernel.
+3. Run the 'perf' tool in a mode (top or record) that generates many
+   frequent performance monitoring non-maskable interrupts (see "NMI"
+   in /proc/interrupts).  This exercises the NMI entry/exit code which
+   is known to trigger bugs in code paths that did not expect to be
+   interrupted, including nested NMIs.  Using "-c" boosts the rate of
+   NMIs, and using two -c with separate counters encourages nested NMIs
+   and less deterministic behavior.
+
+	while true; do perf record -c 10000 -e instructions,cycles -a sleep 10; d=
one
+
+4. Launch a KVM virtual machine.
+5. Run 32-bit binaries on systems supporting the SYSCALL instruction.
+   This has been a lightly-tested code path and needs extra scrutiny.
+
+Debugging
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bugs in PTI cause a few different signatures of crashes
+that are worth noting here.
+
+ * Failures of the selftests/x86 code.  Usually a bug in one of the
+   more obscure corners of entry_64.S
+ * Crashes in early boot, especially around CPU bringup.  Bugs
+   in the trampoline code or mappings cause these.
+ * Crashes at the first interrupt.  Caused by bugs in entry_64.S,
+   like screwing up a page table switch.  Also caused by
+   incorrectly mapping the IRQ handler entry code.
+ * Crashes at the first NMI.  The NMI code is separate from main
+   interrupt handlers and can have bugs that do not affect
+   normal interrupts.  Also caused by incorrectly mapping NMI
+   code.  NMIs that interrupt the entry code must be very
+   careful and can be the cause of crashes that show up when
+   running perf.
+ * Kernel crashes at the first exit to userspace.  entry_64.S
+   bugs, or failing to map some of the exit code.
+ * Crashes at first interrupt that interrupts userspace. The paths
+   in entry_64.S that return to userspace are sometimes separate
+   from the ones that return to the kernel.
+ * Double faults: overflowing the kernel stack because of page
+   faults upon page faults.  Caused by touching non-pti-mapped
+   data in the entry code, or forgetting to switch to kernel
+   CR3 before calling into C functions which are not pti-mapped.
+ * Userspace segfaults early in boot, sometimes manifesting
+   as mount(8) failing to mount the rootfs.  These have
+   tended to be TLB invalidation issues.  Usually invalidating
+   the wrong PCID, or otherwise missing an invalidation.
+
+1. https://gruss.cc/files/kaiser.pdf
+2. https://meltdownattack.com/meltdown.pdf
diff --git a/Makefile b/Makefile
index d8a202610b4f..b571211a32b5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION =3D 3
 PATCHLEVEL =3D 2
-SUBLEVEL =3D 100
+SUBLEVEL =3D 101
 EXTRAVERSION =3D
 NAME =3D Sleepy Otter
=20
@@ -559,7 +559,7 @@ endif # $(dot-config)
 all: vmlinux
=20
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-KBUILD_CFLAGS	+=3D -Os
+KBUILD_CFLAGS	+=3D -Os $(call cc-disable-warning,maybe-uninitialized,)
 else
 KBUILD_CFLAGS	+=3D -O2
 endif
diff --git a/arch/cris/arch-v10/lib/Makefile b/arch/cris/arch-v10/lib/Makef=
ile
index 36e9a9c5239b..725153edb764 100644
--- a/arch/cris/arch-v10/lib/Makefile
+++ b/arch/cris/arch-v10/lib/Makefile
@@ -2,8 +2,5 @@
 # Makefile for Etrax-specific library files..
 #
=20
-
-EXTRA_AFLAGS :=3D -traditional
-
 lib-y  =3D checksum.o checksumcopy.o string.o usercopy.o memset.o csumcpfr=
user.o
=20
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d720208f6018..ac2addde045d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -75,6 +75,7 @@ config X86
 	select HAVE_BPF_JIT if (X86_64 && NET)
 	select CLKEVT_I8253
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select GENERIC_CPU_VULNERABILITIES
 	select ARCH_SUPPORTS_ATOMIC_RMW
=20
 config INSTRUCTION_DECODER
@@ -311,6 +312,19 @@ config X86_BIGSMP
 	---help---
 	  This option is needed for the systems that have more than 8 CPUs
=20
+config RETPOLINE
+	bool "Avoid speculative indirect branches in kernel"
+	default y
+	help
+	  Compile kernel with the retpoline compiler options to guard against
+	  kernel-to-user data leaks by avoiding speculative indirect
+	  branches. Requires a compiler with -mindirect-branch=3Dthunk-extern
+	  support for full protection. The kernel may run slower.
+
+	  Without compiler support, at least indirect branches in assembler
+	  code are eliminated. Since this includes the syscall entry path,
+	  it is not entirely pointless.
+
 if X86_32
 config X86_EXTENDED_PLATFORM
 	bool "Support for extended (non-PC) x86 platforms"
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 03dbc7f5b4d9..e2e34225363a 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -117,6 +117,14 @@ KBUILD_CFLAGS +=3D $(call cc-option,-mno-sse -mno-mmx =
-mno-sse2 -mno-3dnow,)
 KBUILD_CFLAGS +=3D $(mflags-y)
 KBUILD_AFLAGS +=3D $(mflags-y)
=20
+# Avoid indirect branches in kernel to deal with Spectre
+ifdef CONFIG_RETPOLINE
+    RETPOLINE_CFLAGS +=3D $(call cc-option,-mindirect-branch=3Dthunk-exter=
n -mindirect-branch-register)
+    ifneq ($(RETPOLINE_CFLAGS),)
+        KBUILD_CFLAGS +=3D $(RETPOLINE_CFLAGS) -DRETPOLINE
+    endif
+endif
+
 archscripts:
 	$(Q)$(MAKE) $(build)=3Darch/x86/tools relocs
=20
diff --git a/arch/x86/ia32/ia32entry.S b/arch/x86/ia32/ia32entry.S
index 130db0702d9f..750c6f7e961d 100644
--- a/arch/x86/ia32/ia32entry.S
+++ b/arch/x86/ia32/ia32entry.S
@@ -18,6 +18,7 @@
 #include <asm/kaiser.h>
 #include <asm/irqflags.h>
 #include <linux/linkage.h>
+#include <asm/nospec-branch.h>
=20
 /* Avoid __ASSEMBLER__'ifying <linux/audit.h> just for this.  */
 #include <linux/elf-em.h>
@@ -160,12 +161,19 @@ ENTRY(ia32_sysenter_target)
 	testl  $_TIF_WORK_SYSCALL_ENTRY,TI_flags(%r10)
 	CFI_REMEMBER_STATE
 	jnz  sysenter_tracesys
-	cmpq	$(IA32_NR_syscalls-1),%rax
-	ja	ia32_badsys
+	cmpq	$(IA32_NR_syscalls),%rax
+	jae	ia32_badsys
 sysenter_do_call:
+	sbb	%r8,%r8				/* array_index_mask_nospec() */
+	and	%r8,%rax
 	IA32_ARG_FIXUP
 sysenter_dispatch:
+#ifdef CONFIG_RETPOLINE
+	movq	ia32_sys_call_table(,%rax,8),%rax
+	call	__x86_indirect_thunk_rax
+#else
 	call	*ia32_sys_call_table(,%rax,8)
+#endif
 	movq	%rax,RAX-ARGOFFSET(%rsp)
 	GET_THREAD_INFO(%r10)
 	DISABLE_INTERRUPTS(CLBR_NONE)
@@ -201,8 +209,10 @@ ENTRY(ia32_sysenter_target)
 	movl $AUDIT_ARCH_I386,%edi	/* 1st arg: audit arch */
 	call audit_syscall_entry
 	movl RAX-ARGOFFSET(%rsp),%eax	/* reload syscall number */
-	cmpq $(IA32_NR_syscalls-1),%rax
-	ja ia32_badsys
+	cmpq $(IA32_NR_syscalls),%rax
+	jae  ia32_badsys
+	sbb  %r8,%r8			/* array_index_mask_nospec() */
+	and  %r8,%rax
 	movl %ebx,%edi			/* reload 1st syscall arg */
 	movl RCX-ARGOFFSET(%rsp),%esi	/* reload 2nd syscall arg */
 	movl RDX-ARGOFFSET(%rsp),%edx	/* reload 3rd syscall arg */
@@ -254,8 +264,8 @@ ENTRY(ia32_sysenter_target)
 	call	syscall_trace_enter
 	LOAD_ARGS32 ARGOFFSET  /* reload args from stack in case ptrace changed i=
t */
 	RESTORE_REST
-	cmpq	$(IA32_NR_syscalls-1),%rax
-	ja	int_ret_from_sys_call /* sysenter_tracesys has set RAX(%rsp) */
+	cmpq	$(IA32_NR_syscalls),%rax
+	jae	int_ret_from_sys_call /* sysenter_tracesys has set RAX(%rsp) */
 	jmp	sysenter_do_call
 	CFI_ENDPROC
 ENDPROC(ia32_sysenter_target)
@@ -321,12 +331,19 @@ ENTRY(ia32_cstar_target)
 	testl $_TIF_WORK_SYSCALL_ENTRY,TI_flags(%r10)
 	CFI_REMEMBER_STATE
 	jnz   cstar_tracesys
-	cmpq $IA32_NR_syscalls-1,%rax
-	ja  ia32_badsys
+	cmpq $IA32_NR_syscalls,%rax
+	jae  ia32_badsys
 cstar_do_call:
+	sbb  %r8,%r8				/* array_index_mask_nospec() */
+	and  %r8,%rax
 	IA32_ARG_FIXUP 1
 cstar_dispatch:
+#ifdef CONFIG_RETPOLINE
+	movq ia32_sys_call_table(,%rax,8),%rax
+	call __x86_indirect_thunk_rax
+#else
 	call *ia32_sys_call_table(,%rax,8)
+#endif
 	movq %rax,RAX-ARGOFFSET(%rsp)
 	GET_THREAD_INFO(%r10)
 	DISABLE_INTERRUPTS(CLBR_NONE)
@@ -375,8 +392,8 @@ ENTRY(ia32_cstar_target)
 	LOAD_ARGS32 ARGOFFSET, 1  /* reload args from stack in case ptrace change=
d it */
 	RESTORE_REST
 	xchgl %ebp,%r9d
-	cmpq $(IA32_NR_syscalls-1),%rax
-	ja int_ret_from_sys_call /* cstar_tracesys has set RAX(%rsp) */
+	cmpq $(IA32_NR_syscalls),%rax
+	jae int_ret_from_sys_call /* cstar_tracesys has set RAX(%rsp) */
 	jmp cstar_do_call
 END(ia32_cstar_target)
 			=09
@@ -433,11 +450,18 @@ ENTRY(ia32_syscall)
 	orl   $TS_COMPAT,TI_status(%r10)
 	testl $_TIF_WORK_SYSCALL_ENTRY,TI_flags(%r10)
 	jnz ia32_tracesys
-	cmpq $(IA32_NR_syscalls-1),%rax
-	ja ia32_badsys
+	cmpq $(IA32_NR_syscalls),%rax
+	jae  ia32_badsys
 ia32_do_call:
+	sbb  %r8,%r8				/* array_index_mask_nospec() */
+	and  %r8,%rax
 	IA32_ARG_FIXUP
+#ifdef CONFIG_RETPOLINE
+	movq ia32_sys_call_table(,%rax,8),%rax
+	call __x86_indirect_thunk_rax
+#else
 	call *ia32_sys_call_table(,%rax,8) # xxx: rip relative
+#endif
 ia32_sysret:
 	movq %rax,RAX-ARGOFFSET(%rsp)
 ia32_ret_from_sys_call:
@@ -452,8 +476,8 @@ ia32_tracesys:
 	call syscall_trace_enter
 	LOAD_ARGS32 ARGOFFSET  /* reload args from stack in case ptrace changed i=
t */
 	RESTORE_REST
-	cmpq $(IA32_NR_syscalls-1),%rax
-	ja  int_ret_from_sys_call	/* ia32_tracesys has set RAX(%rsp) */
+	cmpq $(IA32_NR_syscalls),%rax
+	jae int_ret_from_sys_call	/* ia32_tracesys has set RAX(%rsp) */
 	jmp ia32_do_call
 END(ia32_syscall)
=20
@@ -503,7 +527,7 @@ ENTRY(ia32_ptregs_common)
 	CFI_REL_OFFSET	rsp,RSP-ARGOFFSET
 /*	CFI_REL_OFFSET	ss,SS-ARGOFFSET*/
 	SAVE_REST
-	call *%rax
+	CALL_NOSPEC %rax
 	RESTORE_REST
 	jmp  ia32_sysret	/* misbalances the return cache */
 	CFI_ENDPROC
diff --git a/arch/x86/include/asm/alternative-asm.h b/arch/x86/include/asm/=
alternative-asm.h
index e8c1d8b8d895..fd4b8eb6ff0a 100644
--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -1,3 +1,6 @@
+#ifndef _ASM_X86_ALTERNATIVE_ASM_H
+#define _ASM_X86_ALTERNATIVE_ASM_H
+
 #ifdef __ASSEMBLY__
=20
 #include <asm/asm.h>
@@ -42,12 +45,22 @@
 	.popsection
 .endm
=20
+#define old_len			141b-140b
+#define new_len1		144f-143f
+#define new_len2		145f-144f
+
+/*
+ * max without conditionals. Idea adapted from:
+ * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
+ */
+#define alt_max_short(a, b)	((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
+
 .macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature2
 140:
 	\oldinstr
 141:
-	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90
-	.skip -(((145f-144f)-(144f-143f)-(141b-140b)) > 0) * ((145f-144f)-(144f-1=
43f)-(141b-140b)),0x90
+	.skip -((alt_max_short(new_len1, new_len2) - (old_len)) > 0) * \
+		(alt_max_short(new_len1, new_len2) - (old_len)),0x90
 142:
=20
 	.pushsection .altinstructions,"a"
@@ -65,3 +78,5 @@
 .endm
=20
 #endif  /*  __ASSEMBLY__  */
+
+#endif /* _ASM_X86_ALTERNATIVE_ASM_H */
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alte=
rnative.h
index e1c00154b610..375459d540e2 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_X86_ALTERNATIVE_H
 #define _ASM_X86_ALTERNATIVE_H
=20
+#ifndef __ASSEMBLY__
+
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/stringify.h>
@@ -94,14 +96,22 @@ static inline int alternatives_text_reserved(void *star=
t, void *end)
 	__OLDINSTR(oldinstr, num)					\
 	alt_end_marker ":\n"
=20
+/*
+ * max without conditionals. Idea adapted from:
+ * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
+ *
+ * The additional "-" is needed because gas works with s32s.
+ */
+#define alt_max_short(a, b)	"((" a ") ^ (((" a ") ^ (" b ")) & -(-((" a ")=
 - (" b ")))))"
+
 /*
  * Pad the second replacement alternative with additional NOPs if it is
  * additionally longer than the first replacement alternative.
  */
-#define OLDINSTR_2(oldinstr, num1, num2)					\
-	__OLDINSTR(oldinstr, num1)						\
-	".skip -(((" alt_rlen(num2) ")-(" alt_rlen(num1) ")-(662b-661b)) > 0) * "=
 \
-		"((" alt_rlen(num2) ")-(" alt_rlen(num1) ")-(662b-661b)),0x90\n"  \
+#define OLDINSTR_2(oldinstr, num1, num2) \
+	"661:\n\t" oldinstr "\n662:\n"								\
+	".skip -((" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen=
 ")) > 0) * "	\
+		"(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")), 0=
x90\n"	\
 	alt_end_marker ":\n"
=20
 #define ALTINSTR_ENTRY(feature, num)					      \
@@ -123,7 +133,7 @@ static inline int alternatives_text_reserved(void *star=
t, void *end)
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr, feature, 1)			\
-	".popsection"
+	".popsection\n"
=20
 #define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
 	OLDINSTR_2(oldinstr, 1, 2)					\
@@ -134,7 +144,7 @@ static inline int alternatives_text_reserved(void *star=
t, void *end)
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr1, feature1, 1)			\
 	ALTINSTR_REPLACEMENT(newinstr2, feature2, 2)			\
-	".popsection"
+	".popsection\n"
=20
 /*
  * This must be included *after* the definition of ALTERNATIVE due to
@@ -232,4 +242,6 @@ extern void *text_poke(void *addr, const void *opcode, =
size_t len);
 extern void *text_poke_smp(void *addr, const void *opcode, size_t len);
 extern void text_poke_smp_batch(struct text_poke_param *params, int n);
=20
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_ALTERNATIVE_H */
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 9412d6558c88..14b488f77030 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -3,23 +3,27 @@
=20
 #ifdef __ASSEMBLY__
 # define __ASM_FORM(x)	x
+# define __ASM_FORM_RAW(x)     x
 # define __ASM_FORM_COMMA(x) x,
 # define __ASM_EX_SEC	.section __ex_table, "a"
 #else
 # define __ASM_FORM(x)	" " #x " "
+# define __ASM_FORM_RAW(x)     #x
 # define __ASM_FORM_COMMA(x) " " #x ","
 # define __ASM_EX_SEC	" .section __ex_table,\"a\"\n"
 #endif
=20
 #ifdef CONFIG_X86_32
 # define __ASM_SEL(a,b) __ASM_FORM(a)
+# define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(a)
 #else
 # define __ASM_SEL(a,b) __ASM_FORM(b)
+# define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(b)
 #endif
=20
 #define __ASM_SIZE(inst, ...)	__ASM_SEL(inst##l##__VA_ARGS__, \
 					  inst##q##__VA_ARGS__)
-#define __ASM_REG(reg)		__ASM_SEL(e##reg, r##reg)
+#define __ASM_REG(reg)         __ASM_SEL_RAW(e##reg, r##reg)
=20
 #define _ASM_PTR	__ASM_SEL(.long, .quad)
 #define _ASM_ALIGN	__ASM_SEL(.balign 4, .balign 8)
@@ -55,4 +59,15 @@
 	" .previous\n"
 #endif
=20
+#ifndef __ASSEMBLY__
+/*
+ * This output constraint should be used for any inline asm which has a "c=
all"
+ * instruction.  Otherwise the asm may be inserted before the frame pointer
+ * gets set up by the containing function.  If you forget to do this, objt=
ool
+ * may print a "call without frame pointer save/setup" warning.
+ */
+register unsigned long current_stack_pointer asm(_ASM_SP);
+#define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
+#endif
+
 #endif /* _ASM_X86_ASM_H */
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 1775d6e5920e..7aa2d34d1ff9 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -15,6 +15,8 @@
 #include <linux/compiler.h>
 #include <asm/alternative.h>
=20
+#define BIT_64(n)			(U64_C(1) << (n))
+
 /*
  * These have to be done with inline assembly: that way the bit-setting
  * is guaranteed to be atomic. All bit operations return 0 if the bit
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufe=
ature.h
index 5d1b51652d3a..fbad3104b7da 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -7,6 +7,7 @@
 #include <asm/required-features.h>
=20
 #define NCAPINTS	10	/* N 32-bit words worth of info */
+#define NBUGINTS	1	/* N 32-bit bug flags */
=20
 /*
  * Note: If the comment begins with a quoted string, that string is used
@@ -177,7 +178,10 @@
 #define X86_FEATURE_PTS		(7*32+ 6) /* Intel Package Thermal Status */
 #define X86_FEATURE_DTHERM	(7*32+ 7) /* Digital Thermal Sensor */
 #define X86_FEATURE_INVPCID_SINGLE (7*32+ 8) /* Effectively INVPCID && CR4=
=2EPCIDE=3D1 */
+#define X86_FEATURE_RSB_CTXSW	(7*32+9) /* "" Fill RSB on context switches =
*/
=20
+#define X86_FEATURE_RETPOLINE	(7*32+29) /* "" Generic Retpoline mitigation=
 for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* "" AMD Retpoline mitigation=
 for Spectre variant 2 */
 /* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club..=
=2E */
 #define X86_FEATURE_KAISER	( 7*32+31) /* "" CONFIG_PAGE_TABLE_ISOLATION w/=
o nokaiser */
=20
@@ -208,6 +212,15 @@
 #define X86_FEATURE_INVPCID	(9*32+10) /* Invalidate Processor Context ID */
 #define X86_FEATURE_RTM		(9*32+11) /* Restricted Transactional Memory */
=20
+/*
+ * BUG word(s)
+ */
+#define X86_BUG(x)		(NCAPINTS*32 + (x))
+
+#define X86_BUG_CPU_MELTDOWN	X86_BUG(0) /* CPU is affected by meltdown att=
ack and needs kernel page table isolation */
+#define X86_BUG_SPECTRE_V1	X86_BUG(1) /* CPU is affected by Spectre varian=
t 1 attack with conditional branches */
+#define X86_BUG_SPECTRE_V2	X86_BUG(2) /* CPU is affected by Spectre varian=
t 2 attack with indirect branches */
+
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
=20
 #include <asm/asm.h>
@@ -252,6 +265,8 @@ extern const char * const x86_power_flags[32];
 	set_bit(bit, (unsigned long *)cpu_caps_set);	\
 } while (0)
=20
+#define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
+
 #define cpu_has_fpu		boot_cpu_has(X86_FEATURE_FPU)
 #define cpu_has_vme		boot_cpu_has(X86_FEATURE_VME)
 #define cpu_has_de		boot_cpu_has(X86_FEATURE_DE)
@@ -397,6 +412,13 @@ static __always_inline __pure bool __static_cpu_has(u1=
6 bit)
 #define static_cpu_has(bit) boot_cpu_has(bit)
 #endif
=20
+#define cpu_has_bug(c, bit)	cpu_has(c, (bit))
+#define set_cpu_bug(c, bit)	set_cpu_cap(c, (bit))
+#define clear_cpu_bug(c, bit)	clear_cpu_cap(c, (bit));
+
+#define static_cpu_has_bug(bit)	static_cpu_has((bit))
+#define boot_cpu_has_bug(bit)	cpu_has_bug(&boot_cpu_data, (bit))
+
 #endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
=20
 #endif /* _ASM_X86_CPUFEATURE_H */
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/int=
el-family.h
new file mode 100644
index 000000000000..6999f7d01a0d
--- /dev/null
+++ b/arch/x86/include/asm/intel-family.h
@@ -0,0 +1,68 @@
+#ifndef _ASM_X86_INTEL_FAMILY_H
+#define _ASM_X86_INTEL_FAMILY_H
+
+/*
+ * "Big Core" Processors (Branded as Core, Xeon, etc...)
+ *
+ * The "_X" parts are generally the EP and EX Xeons, or the
+ * "Extreme" ones, like Broadwell-E.
+ *
+ * Things ending in "2" are usually because we have no better
+ * name for them.  There's no processor called "WESTMERE2".
+ */
+
+#define INTEL_FAM6_CORE_YONAH		0x0E
+#define INTEL_FAM6_CORE2_MEROM		0x0F
+#define INTEL_FAM6_CORE2_MEROM_L	0x16
+#define INTEL_FAM6_CORE2_PENRYN		0x17
+#define INTEL_FAM6_CORE2_DUNNINGTON	0x1D
+
+#define INTEL_FAM6_NEHALEM		0x1E
+#define INTEL_FAM6_NEHALEM_EP		0x1A
+#define INTEL_FAM6_NEHALEM_EX		0x2E
+#define INTEL_FAM6_WESTMERE		0x25
+#define INTEL_FAM6_WESTMERE2		0x1F
+#define INTEL_FAM6_WESTMERE_EP		0x2C
+#define INTEL_FAM6_WESTMERE_EX		0x2F
+
+#define INTEL_FAM6_SANDYBRIDGE		0x2A
+#define INTEL_FAM6_SANDYBRIDGE_X	0x2D
+#define INTEL_FAM6_IVYBRIDGE		0x3A
+#define INTEL_FAM6_IVYBRIDGE_X		0x3E
+
+#define INTEL_FAM6_HASWELL_CORE		0x3C
+#define INTEL_FAM6_HASWELL_X		0x3F
+#define INTEL_FAM6_HASWELL_ULT		0x45
+#define INTEL_FAM6_HASWELL_GT3E		0x46
+
+#define INTEL_FAM6_BROADWELL_CORE	0x3D
+#define INTEL_FAM6_BROADWELL_XEON_D	0x56
+#define INTEL_FAM6_BROADWELL_GT3E	0x47
+#define INTEL_FAM6_BROADWELL_X		0x4F
+
+#define INTEL_FAM6_SKYLAKE_MOBILE	0x4E
+#define INTEL_FAM6_SKYLAKE_DESKTOP	0x5E
+#define INTEL_FAM6_SKYLAKE_X		0x55
+#define INTEL_FAM6_KABYLAKE_MOBILE	0x8E
+#define INTEL_FAM6_KABYLAKE_DESKTOP	0x9E
+
+/* "Small Core" Processors (Atom) */
+
+#define INTEL_FAM6_ATOM_PINEVIEW	0x1C
+#define INTEL_FAM6_ATOM_LINCROFT	0x26
+#define INTEL_FAM6_ATOM_PENWELL		0x27
+#define INTEL_FAM6_ATOM_CLOVERVIEW	0x35
+#define INTEL_FAM6_ATOM_CEDARVIEW	0x36
+#define INTEL_FAM6_ATOM_SILVERMONT1	0x37 /* BayTrail/BYT / Valleyview */
+#define INTEL_FAM6_ATOM_SILVERMONT2	0x4D /* Avaton/Rangely */
+#define INTEL_FAM6_ATOM_AIRMONT		0x4C /* CherryTrail / Braswell */
+#define INTEL_FAM6_ATOM_MERRIFIELD1	0x4A /* Tangier */
+#define INTEL_FAM6_ATOM_MERRIFIELD2	0x5A /* Annidale */
+#define INTEL_FAM6_ATOM_GOLDMONT	0x5C
+#define INTEL_FAM6_ATOM_DENVERTON	0x5F /* Goldmont Microserver */
+
+/* Xeon Phi */
+
+#define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
+
+#endif /* _ASM_X86_INTEL_FAMILY_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-in=
dex.h
index 3d48aa4ea5aa..719b6220fad5 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -150,6 +150,9 @@
 #define FAM10H_MMIO_CONF_BASE_MASK	0xfffffffULL
 #define FAM10H_MMIO_CONF_BASE_SHIFT	20
 #define MSR_FAM10H_NODE_ID		0xc001100c
+#define MSR_F10H_DECFG			0xc0011029
+#define MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT	1
+#define MSR_F10H_DECFG_LFENCE_SERIALIZE		BIT_ULL(MSR_F10H_DECFG_LFENCE_SER=
IALIZE_BIT)
=20
 /* K8 MSRs */
 #define MSR_K8_TOP_MEM1			0xc001001a
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 95203d40ffdd..d7facae367b4 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -265,6 +265,8 @@ do {                                                   =
         \
=20
 struct msr *msrs_alloc(void);
 void msrs_free(struct msr *msrs);
+int msr_set_bit(u32 msr, u8 bit);
+int msr_clear_bit(u32 msr, u8 bit);
=20
 #ifdef CONFIG_SMP
 int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/no=
spec-branch.h
new file mode 100644
index 000000000000..4e0e2e698e2b
--- /dev/null
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -0,0 +1,199 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_X86_NOSPEC_BRANCH_H_
+#define _ASM_X86_NOSPEC_BRANCH_H_
+
+#include <asm/alternative.h>
+#include <asm/alternative-asm.h>
+#include <asm/cpufeature.h>
+
+/*
+ * Fill the CPU return stack buffer.
+ *
+ * Each entry in the RSB, if used for a speculative 'ret', contains an
+ * infinite 'pause; lfence; jmp' loop to capture speculative execution.
+ *
+ * This is required in various cases for retpoline and IBRS-based
+ * mitigations for the Spectre variant 2 vulnerability. Sometimes to
+ * eliminate potentially bogus entries from the RSB, and sometimes
+ * purely to ensure that it doesn't get empty, which on some CPUs would
+ * allow predictions from other (unwanted!) sources to be used.
+ *
+ * We define a CPP macro such that it can be used from both .S files and
+ * inline assembly. It's possible to do a .macro and then include that
+ * from C via asm(".include <asm/nospec-branch.h>") but let's not go there.
+ */
+
+#define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
+#define RSB_FILL_LOOPS		16	/* To avoid underflow */
+
+/*
+ * Google experimented with loop-unrolling and this turned out to be
+ * the optimal version =E2=80=94 two calls, each with their own speculation
+ * trap should their return address end up getting used, in a loop.
+ */
+#define __FILL_RETURN_BUFFER(reg, nr, sp)	\
+	mov	$(nr/2), reg;			\
+771:						\
+	call	772f;				\
+773:	/* speculation trap */			\
+	pause;					\
+	lfence;					\
+	jmp	773b;				\
+772:						\
+	call	774f;				\
+775:	/* speculation trap */			\
+	pause;					\
+	lfence;					\
+	jmp	775b;				\
+774:						\
+	dec	reg;				\
+	jnz	771b;				\
+	add	$(BITS_PER_LONG/8) * nr, sp;
+
+#ifdef __ASSEMBLY__
+
+/*
+ * These are the bare retpoline primitives for indirect jmp and call.
+ * Do not use these directly; they only exist to make the ALTERNATIVE
+ * invocation below less ugly.
+ */
+.macro RETPOLINE_JMP reg:req
+	call	.Ldo_rop_\@
+.Lspec_trap_\@:
+	pause
+	lfence
+	jmp	.Lspec_trap_\@
+.Ldo_rop_\@:
+	mov	\reg, (%_ASM_SP)
+	ret
+.endm
+
+/*
+ * This is a wrapper around RETPOLINE_JMP so the called function in reg
+ * returns to the instruction after the macro.
+ */
+.macro RETPOLINE_CALL reg:req
+	jmp	.Ldo_call_\@
+.Ldo_retpoline_jmp_\@:
+	RETPOLINE_JMP \reg
+.Ldo_call_\@:
+	call	.Ldo_retpoline_jmp_\@
+.endm
+
+/*
+ * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
+ * indirect jmp/call which may be susceptible to the Spectre variant 2
+ * attack.
+ */
+.macro JMP_NOSPEC reg:req
+#ifdef CONFIG_RETPOLINE
+	ALTERNATIVE_2 __stringify(jmp *\reg),				\
+		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
+		__stringify(lfence; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
+#else
+	jmp	*\reg
+#endif
+.endm
+
+.macro CALL_NOSPEC reg:req
+#ifdef CONFIG_RETPOLINE
+	ALTERNATIVE_2 __stringify(call *\reg),				\
+		__stringify(RETPOLINE_CALL \reg), X86_FEATURE_RETPOLINE,\
+		__stringify(lfence; call *\reg), X86_FEATURE_RETPOLINE_AMD
+#else
+	call	*\reg
+#endif
+.endm
+
+ /*
+  * A simpler FILL_RETURN_BUFFER macro. Don't make people use the CPP
+  * monstrosity above, manually.
+  */
+.macro FILL_RETURN_BUFFER reg:req nr:req ftr:req
+#ifdef CONFIG_RETPOLINE
+	ALTERNATIVE "jmp .Lskip_rsb_\@",				\
+		__stringify(__FILL_RETURN_BUFFER(\reg,\nr,%_ASM_SP))	\
+		\ftr
+.Lskip_rsb_\@:
+#endif
+.endm
+
+#else /* __ASSEMBLY__ */
+
+#if defined(CONFIG_X86_64) && defined(RETPOLINE)
+
+/*
+ * Since the inline asm uses the %V modifier which is only in newer GCC,
+ * the 64-bit one is dependent on RETPOLINE not CONFIG_RETPOLINE.
+ */
+# define CALL_NOSPEC						\
+	ALTERNATIVE(						\
+	"call *%[thunk_target]\n",				\
+	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
+	X86_FEATURE_RETPOLINE)
+# define THUNK_TARGET(addr) [thunk_target] "r" (addr)
+
+#elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
+/*
+ * For i386 we use the original ret-equivalent retpoline, because
+ * otherwise we'll run out of registers. We don't care about CET
+ * here, anyway.
+ */
+# define CALL_NOSPEC ALTERNATIVE("call *%[thunk_target]\n",	\
+	"       jmp    904f;\n"					\
+	"       .align 16\n"					\
+	"901:	call   903f;\n"					\
+	"902:	pause;\n"					\
+	"    	lfence;\n"					\
+	"       jmp    902b;\n"					\
+	"       .align 16\n"					\
+	"903:	addl   $4, %%esp;\n"				\
+	"       pushl  %[thunk_target];\n"			\
+	"       ret;\n"						\
+	"       .align 16\n"					\
+	"904:	call   901b;\n",				\
+	X86_FEATURE_RETPOLINE)
+
+# define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
+#else /* No retpoline for C / inline asm */
+# define CALL_NOSPEC "call *%[thunk_target]\n"
+# define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
+#endif
+
+/* The Spectre V2 mitigation variants */
+enum spectre_v2_mitigation {
+	SPECTRE_V2_NONE,
+	SPECTRE_V2_RETPOLINE_MINIMAL,
+	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
+	SPECTRE_V2_RETPOLINE_GENERIC,
+	SPECTRE_V2_RETPOLINE_AMD,
+	SPECTRE_V2_IBRS,
+};
+
+extern char __indirect_thunk_start[];
+extern char __indirect_thunk_end[];
+extern char __indirect_thunk_size[];
+
+/*
+ * On VMEXIT we must ensure that no RSB predictions learned in the guest
+ * can be followed in the host, by overwriting the RSB completely. Both
+ * retpoline and IBRS mitigations for Spectre v2 need this; only on future
+ * CPUs with IBRS_ALL *might* it be avoided.
+ */
+static inline void vmexit_fill_RSB(void)
+{
+#ifdef CONFIG_RETPOLINE
+	unsigned long loops;
+
+	asm volatile (ALTERNATIVE("jmp 910f",
+				  __stringify(__FILL_RETURN_BUFFER(%0, RSB_CLEAR_LOOPS, %1)),
+				  X86_FEATURE_RETPOLINE)
+		      "910:"
+		      : "=3Dr" (loops), ASM_CALL_CONSTRAINT
+		      : : "memory" );
+#endif
+}
+
+#endif /* __ASSEMBLY__ */
+#endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proces=
sor.h
index 048249e983ca..243ce0804f8a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -86,7 +86,7 @@ struct cpuinfo_x86 {
 	__u32			extended_cpuid_level;
 	/* Maximum supported CPUID level, -1=3Dno CPUID: */
 	int			cpuid_level;
-	__u32			x86_capability[NCAPINTS];
+	__u32			x86_capability[NCAPINTS + NBUGINTS];
 	char			x86_vendor_id[16];
 	char			x86_model_id[64];
 	/* in KB - valid for CPUS which support this call: */
@@ -130,8 +130,8 @@ extern struct cpuinfo_x86	boot_cpu_data;
 extern struct cpuinfo_x86	new_cpu_data;
=20
 extern struct tss_struct	doublefault_tss;
-extern __u32			cpu_caps_cleared[NCAPINTS];
-extern __u32			cpu_caps_set[NCAPINTS];
+extern __u32			cpu_caps_cleared[NCAPINTS + NBUGINTS];
+extern __u32			cpu_caps_set[NCAPINTS + NBUGINTS];
=20
 #ifdef CONFIG_SMP
 DECLARE_PER_CPU_SHARED_ALIGNED(struct cpuinfo_x86, cpu_info);
diff --git a/arch/x86/include/asm/system.h b/arch/x86/include/asm/system.h
index d75adff83784..59567d16c617 100644
--- a/arch/x86/include/asm/system.h
+++ b/arch/x86/include/asm/system.h
@@ -6,6 +6,7 @@
 #include <asm/cpufeature.h>
 #include <asm/cmpxchg.h>
 #include <asm/nops.h>
+#include <asm/nospec-branch.h>
=20
 #include <linux/kernel.h>
 #include <linux/irqflags.h>
@@ -41,6 +42,23 @@ extern void show_regs_common(void);
 #define __switch_canary_iparam
 #endif	/* CC_STACKPROTECTOR */
=20
+#ifdef CONFIG_RETPOLINE
+	/*
+	 * When switching from a shallower to a deeper call stack
+	 * the RSB may either underflow or use entries populated
+	 * with userspace addresses. On CPUs where those concerns
+	 * exist, overwrite the RSB with entries which capture
+	 * speculative execution to prevent attack.
+	 */
+#define __retpoline_fill_return_buffer					\
+	ALTERNATIVE("jmp 910f",						\
+		__stringify(__FILL_RETURN_BUFFER(%%ebx, RSB_CLEAR_LOOPS, %%esp)),\
+		X86_FEATURE_RSB_CTXSW)					\
+	"910:\n\t"
+#else
+#define __retpoline_fill_return_buffer
+#endif
+
 /*
  * Saving eflags is important. It switches not only IOPL between tasks,
  * it also protects other tasks from NT leaking through sysenter etc.
@@ -63,6 +81,7 @@ do {									\
 		     "movl $1f,%[prev_ip]\n\t"	/* save    EIP   */	\
 		     "pushl %[next_ip]\n\t"	/* restore EIP   */	\
 		     __switch_canary					\
+		     __retpoline_fill_return_buffer			\
 		     "jmp __switch_to\n"	/* regparm call  */	\
 		     "1:\t"						\
 		     "popl %%ebp\n\t"		/* restore EBP   */	\
@@ -117,6 +136,23 @@ do {									\
 #define __switch_canary_iparam
 #endif	/* CC_STACKPROTECTOR */
=20
+#ifdef CONFIG_RETPOLINE
+	/*
+	 * When switching from a shallower to a deeper call stack
+	 * the RSB may either underflow or use entries populated
+	 * with userspace addresses. On CPUs where those concerns
+	 * exist, overwrite the RSB with entries which capture
+	 * speculative execution to prevent attack.
+	 */
+#define __retpoline_fill_return_buffer					\
+	ALTERNATIVE("jmp 910f",						\
+		__stringify(__FILL_RETURN_BUFFER(%%r12, RSB_CLEAR_LOOPS, %%rsp)),\
+		X86_FEATURE_RSB_CTXSW)					\
+	"910:\n\t"
+#else
+#define __retpoline_fill_return_buffer
+#endif
+
 /* Save restore flags to clear handle leaking NT */
 #define switch_to(prev, next, last) \
 	asm volatile(SAVE_CONTEXT					  \
@@ -125,6 +161,7 @@ do {									\
 	     "call __switch_to\n\t"					  \
 	     "movq "__percpu_arg([current_task])",%%rsi\n\t"		  \
 	     __switch_canary						  \
+	     __retpoline_fill_return_buffer				  \
 	     "movq %P[thread_info](%%rsi),%%r8\n\t"			  \
 	     "movq %%rax,%%rdi\n\t" 					  \
 	     "testl  %[_tif_fork],%P[ti_flags](%%r8)\n\t"		  \
@@ -417,6 +454,34 @@ void stop_this_cpu(void *dummy);
 #define wmb()	asm volatile("sfence" ::: "memory")
 #endif
=20
+/**
+ * array_index_mask_nospec() - generate a mask that is ~0UL when the
+ * 	bounds check succeeds and 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ *
+ * Returns:
+ *     0 - (index < size)
+ */
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+		unsigned long size)
+{
+	unsigned long mask;
+
+	asm ("cmp %1,%2; sbb %0,%0;"
+			:"=3Dr" (mask)
+			:"r"(size),"r" (index)
+			:"cc");
+	return mask;
+}
+
+/* Override the default implementation from linux/nospec.h. */
+#define array_index_mask_nospec array_index_mask_nospec
+
+/* Prevent speculative execution past this barrier. */
+#define barrier_nospec() alternative_2("", "mfence", X86_FEATURE_MFENCE_RD=
TSC, \
+					   "lfence", X86_FEATURE_LFENCE_RDTSC)
+
 /**
  * read_barrier_depends - Flush all pending reads that subsequents reads
  * depend on.
@@ -502,8 +567,7 @@ void stop_this_cpu(void *dummy);
  */
 static __always_inline void rdtsc_barrier(void)
 {
-	alternative(ASM_NOP3, "mfence", X86_FEATURE_MFENCE_RDTSC);
-	alternative(ASM_NOP3, "lfence", X86_FEATURE_LFENCE_RDTSC);
+	barrier_nospec();
 }
=20
 /*
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thre=
ad_info.h
index d7ef849714a1..829c2343796e 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -181,9 +181,6 @@ struct thread_info {
 #ifndef __ASSEMBLY__
=20
=20
-/* how to get the current stack pointer from C */
-register unsigned long current_stack_pointer asm("esp") __used;
-
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 336c8aedb6a1..7dd47ba20f75 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -423,6 +423,7 @@ do {									\
 ({									\
 	int __gu_err;							\
 	unsigned long __gu_val;						\
+	barrier_nospec();					\
 	__get_user_size(__gu_val, (ptr), (size), __gu_err, -EFAULT);	\
 	(x) =3D (__force __typeof__(*(ptr)))__gu_val;			\
 	__gu_err;							\
@@ -462,6 +463,11 @@ struct __large_struct { unsigned long buf[100]; };
 	current_thread_info()->uaccess_err =3D 0;				\
 	barrier();
=20
+#define uaccess_try_nospec do {						\
+	int prev_err =3D current_thread_info()->uaccess_err;		\
+	current_thread_info()->uaccess_err =3D 0;				\
+	barrier_nospec();
+
 #define uaccess_catch(err)						\
 	(err) |=3D current_thread_info()->uaccess_err;			\
 	current_thread_info()->uaccess_err =3D prev_err;			\
@@ -524,7 +530,7 @@ struct __large_struct { unsigned long buf[100]; };
  *	get_user_ex(...);
  * } get_user_catch(err)
  */
-#define get_user_try		uaccess_try
+#define get_user_try		uaccess_try_nospec
 #define get_user_catch(err)	uaccess_catch(err)
=20
 #define get_user_ex(x, ptr)	do {					\
diff --git a/arch/x86/include/asm/uaccess_32.h b/arch/x86/include/asm/uacce=
ss_32.h
index 566e803cc602..b6f5617e8d27 100644
--- a/arch/x86/include/asm/uaccess_32.h
+++ b/arch/x86/include/asm/uaccess_32.h
@@ -48,14 +48,17 @@ __copy_to_user_inatomic(void __user *to, const void *fr=
om, unsigned long n)
=20
 		switch (n) {
 		case 1:
+			barrier_nospec();
 			__put_user_size(*(u8 *)from, (u8 __user *)to,
 					1, ret, 1);
 			return ret;
 		case 2:
+			barrier_nospec();
 			__put_user_size(*(u16 *)from, (u16 __user *)to,
 					2, ret, 2);
 			return ret;
 		case 4:
+			barrier_nospec();
 			__put_user_size(*(u32 *)from, (u32 __user *)to,
 					4, ret, 4);
 			return ret;
@@ -98,12 +101,15 @@ __copy_from_user_inatomic(void *to, const void __user =
*from, unsigned long n)
=20
 		switch (n) {
 		case 1:
+			barrier_nospec();
 			__get_user_size(*(u8 *)to, from, 1, ret, 1);
 			return ret;
 		case 2:
+			barrier_nospec();
 			__get_user_size(*(u16 *)to, from, 2, ret, 2);
 			return ret;
 		case 4:
+			barrier_nospec();
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
 			return ret;
 		}
@@ -142,12 +148,15 @@ __copy_from_user(void *to, const void __user *from, u=
nsigned long n)
=20
 		switch (n) {
 		case 1:
+			barrier_nospec();
 			__get_user_size(*(u8 *)to, from, 1, ret, 1);
 			return ret;
 		case 2:
+			barrier_nospec();
 			__get_user_size(*(u16 *)to, from, 2, ret, 2);
 			return ret;
 		case 4:
+			barrier_nospec();
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
 			return ret;
 		}
@@ -164,12 +173,15 @@ static __always_inline unsigned long __copy_from_user=
_nocache(void *to,
=20
 		switch (n) {
 		case 1:
+			barrier_nospec();
 			__get_user_size(*(u8 *)to, from, 1, ret, 1);
 			return ret;
 		case 2:
+			barrier_nospec();
 			__get_user_size(*(u16 *)to, from, 2, ret, 2);
 			return ret;
 		case 4:
+			barrier_nospec();
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
 			return ret;
 		}
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uacce=
ss_64.h
index 31fed191a41e..dda633ca71fa 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -75,19 +75,28 @@ int __copy_from_user_nocheck(void *dst, const void __us=
er *src, unsigned size)
 	if (!__builtin_constant_p(size))
 		return copy_user_generic(dst, (__force void *)src, size);
 	switch (size) {
-	case 1:__get_user_asm(*(u8 *)dst, (u8 __user *)src,
+	case 1:
+		barrier_nospec();
+		__get_user_asm(*(u8 *)dst, (u8 __user *)src,
 			      ret, "b", "b", "=3Dq", 1);
 		return ret;
-	case 2:__get_user_asm(*(u16 *)dst, (u16 __user *)src,
+	case 2:
+		barrier_nospec();
+		__get_user_asm(*(u16 *)dst, (u16 __user *)src,
 			      ret, "w", "w", "=3Dr", 2);
 		return ret;
-	case 4:__get_user_asm(*(u32 *)dst, (u32 __user *)src,
+	case 4:
+		barrier_nospec();
+		__get_user_asm(*(u32 *)dst, (u32 __user *)src,
 			      ret, "l", "k", "=3Dr", 4);
 		return ret;
-	case 8:__get_user_asm(*(u64 *)dst, (u64 __user *)src,
+	case 8:
+		barrier_nospec();
+		__get_user_asm(*(u64 *)dst, (u64 __user *)src,
 			      ret, "q", "", "=3Dr", 8);
 		return ret;
 	case 10:
+		barrier_nospec();
 		__get_user_asm(*(u64 *)dst, (u64 __user *)src,
 			       ret, "q", "", "=3Dr", 10);
 		if (unlikely(ret))
@@ -97,6 +106,7 @@ int __copy_from_user_nocheck(void *dst, const void __use=
r *src, unsigned size)
 			       ret, "w", "w", "=3Dr", 2);
 		return ret;
 	case 16:
+		barrier_nospec();
 		__get_user_asm(*(u64 *)dst, (u64 __user *)src,
 			       ret, "q", "", "=3Dr", 16);
 		if (unlikely(ret))
@@ -179,6 +189,7 @@ int __copy_in_user(void __user *dst, const void __user =
*src, unsigned size)
 	switch (size) {
 	case 1: {
 		u8 tmp;
+		barrier_nospec();
 		__get_user_asm(tmp, (u8 __user *)src,
 			       ret, "b", "b", "=3Dq", 1);
 		if (likely(!ret))
@@ -188,6 +199,7 @@ int __copy_in_user(void __user *dst, const void __user =
*src, unsigned size)
 	}
 	case 2: {
 		u16 tmp;
+		barrier_nospec();
 		__get_user_asm(tmp, (u16 __user *)src,
 			       ret, "w", "w", "=3Dr", 2);
 		if (likely(!ret))
@@ -198,6 +210,7 @@ int __copy_in_user(void __user *dst, const void __user =
*src, unsigned size)
=20
 	case 4: {
 		u32 tmp;
+		barrier_nospec();
 		__get_user_asm(tmp, (u32 __user *)src,
 			       ret, "l", "k", "=3Dr", 4);
 		if (likely(!ret))
@@ -207,6 +220,7 @@ int __copy_in_user(void __user *dst, const void __user =
*src, unsigned size)
 	}
 	case 8: {
 		u64 tmp;
+		barrier_nospec();
 		__get_user_asm(tmp, (u64 __user *)src,
 			       ret, "q", "", "=3Dr", 8);
 		if (likely(!ret))
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xe=
n/hypercall.h
index 5728852fb90f..aa80db91eda2 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -43,6 +43,7 @@
=20
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/nospec-branch.h>
=20
 #include <xen/interface/xen.h>
 #include <xen/interface/sched.h>
@@ -212,9 +213,9 @@ privcmd_call(unsigned call,
 	__HYPERCALL_DECLS;
 	__HYPERCALL_5ARG(a1, a2, a3, a4, a5);
=20
-	asm volatile("call *%[call]"
+	asm volatile(CALL_NOSPEC
 		     : __HYPERCALL_5PARAM
-		     : [call] "a" (&hypercall_page[call])
+		     : [thunk_target] "a" (&hypercall_page[call])
 		     : __HYPERCALL_CLOBBER5);
=20
 	return (long)__res;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 81193ea301e2..ad10e465f1c6 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -39,17 +39,6 @@ static int __init setup_noreplace_smp(char *str)
 }
 __setup("noreplace-smp", setup_noreplace_smp);
=20
-#ifdef CONFIG_PARAVIRT
-static int __initdata_or_module noreplace_paravirt =3D 0;
-
-static int __init setup_noreplace_paravirt(char *str)
-{
-	noreplace_paravirt =3D 1;
-	return 1;
-}
-__setup("noreplace-paravirt", setup_noreplace_paravirt);
-#endif
-
 #define DPRINTK(fmt, args...)						\
 do {									\
 	if (debug_alternative)						\
@@ -323,7 +312,18 @@ recompute_jump(struct alt_instr *a, u8 *orig_insn, u8 =
*repl_insn, u8 *insnbuf)
=20
 static void __init_or_module optimize_nops(struct alt_instr *a, u8 *instr)
 {
+	unsigned long flags;
+	int i;
+
+	for (i =3D 0; i < a->padlen; i++) {
+		if (instr[i] !=3D 0x90)
+			return;
+	}
+
+	local_irq_save(flags);
 	add_nops(instr + (a->instrlen - a->padlen), a->padlen);
+	sync_core();
+	local_irq_restore(flags);
=20
 	DUMP_BYTES(instr, a->instrlen, "%p: [%d:%d) optimized NOPs: ",
 		   instr, a->instrlen - a->padlen, a->padlen);
@@ -359,7 +359,7 @@ void __init_or_module apply_alternatives(struct alt_ins=
tr *start,
 		instr =3D (u8 *)&a->instr_offset + a->instr_offset;
 		replacement =3D (u8 *)&a->repl_offset + a->repl_offset;
 		BUG_ON(a->instrlen > sizeof(insnbuf));
-		BUG_ON(a->cpuid >=3D NCAPINTS*32);
+		BUG_ON(a->cpuid >=3D (NCAPINTS + NBUGINTS) * 32);
 		if (!boot_cpu_has(a->cpuid)) {
 			if (a->padlen > 1)
 				optimize_nops(a, instr);
@@ -367,11 +367,11 @@ void __init_or_module apply_alternatives(struct alt_i=
nstr *start,
 			continue;
 		}
=20
-		DPRINTK("feat: %d*32+%d, old: (%p, len: %d), repl: (%p, len: %d)",
+		DPRINTK("feat: %d*32+%d, old: (%p, len: %d), repl: (%p, len: %d), pad: %=
d",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
 			instr, a->instrlen,
-			replacement, a->replacementlen);
+			replacement, a->replacementlen, a->padlen);
=20
 		DUMP_BYTES(instr, a->instrlen, "%p: old_insn: ", instr);
 		DUMP_BYTES(replacement, a->replacementlen, "%p: rpl_insn: ", replacement=
);
@@ -572,9 +572,6 @@ void __init_or_module apply_paravirt(struct paravirt_pa=
tch_site *start,
 	struct paravirt_patch_site *p;
 	char insnbuf[MAX_PATCH_LEN];
=20
-	if (noreplace_paravirt)
-		return;
-
 	for (p =3D start; p < end; p++) {
 		unsigned int used;
=20
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 25f24dccdcfa..06afb955a94e 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -16,9 +16,7 @@ obj-y			:=3D intel_cacheinfo.o scattered.o topology.o
 obj-y			+=3D proc.o capflags.o powerflags.o common.o
 obj-y			+=3D vmware.o hypervisor.o sched.o mshyperv.o
 obj-y			+=3D rdrand.o
-
-obj-$(CONFIG_X86_32)	+=3D bugs.o
-obj-$(CONFIG_X86_64)	+=3D bugs_64.o
+obj-y			+=3D bugs.o
=20
 obj-$(CONFIG_CPU_SUP_INTEL)		+=3D intel.o
 obj-$(CONFIG_CPU_SUP_AMD)		+=3D amd.o
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 60d4c3351cdb..f2f2e6b7e864 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -641,8 +641,32 @@ static void __cpuinit init_amd(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_K8);
=20
 	if (cpu_has_xmm2) {
-		/* MFENCE stops RDTSC speculation */
-		set_cpu_cap(c, X86_FEATURE_MFENCE_RDTSC);
+		unsigned long long val;
+		int ret;
+
+		/*
+		 * A serializing LFENCE has less overhead than MFENCE, so
+		 * use it for execution serialization.  On families which
+		 * don't have that MSR, LFENCE is already serializing.
+		 * msr_set_bit() uses the safe accessors, too, even if the MSR
+		 * is not present.
+		 */
+		msr_set_bit(MSR_F10H_DECFG,
+			    MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT);
+
+		/*
+		 * Verify that the MSR write was successful (could be running
+		 * under a hypervisor) and only then assume that LFENCE is
+		 * serializing.
+		 */
+		ret =3D rdmsrl_safe(MSR_F10H_DECFG, &val);
+		if (!ret && (val & MSR_F10H_DECFG_LFENCE_SERIALIZE)) {
+			/* A serializing LFENCE stops RDTSC speculation */
+			set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
+		} else {
+			/* MFENCE stops RDTSC speculation */
+			set_cpu_cap(c, X86_FEATURE_MFENCE_RDTSC);
+		}
 	}
=20
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ad95476a08b9..af3b13493139 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -9,6 +9,11 @@
  */
 #include <linux/init.h>
 #include <linux/utsname.h>
+#include <linux/cpu.h>
+#include <linux/module.h>
+
+#include <asm/nospec-branch.h>
+#include <asm/cmdline.h>
 #include <asm/bugs.h>
 #include <asm/processor.h>
 #include <asm/processor-flags.h>
@@ -16,6 +21,13 @@
 #include <asm/msr.h>
 #include <asm/paravirt.h>
 #include <asm/alternative.h>
+#include <asm/pgtable.h>
+#include <asm/cacheflush.h>
+#include <asm/intel-family.h>
+
+static void __init spectre_v2_select_mitigation(void);
+
+#ifdef CONFIG_X86_32
=20
 static int __init no_halt(char *s)
 {
@@ -156,6 +168,7 @@ static void __init check_config(void)
 #endif
 }
=20
+#endif /* CONFIG_X86_32 */
=20
 void __init check_bugs(void)
 {
@@ -168,10 +181,16 @@ void __init check_bugs(void)
 #endif
=20
 	identify_boot_cpu();
-#ifndef CONFIG_SMP
-	printk(KERN_INFO "CPU: ");
-	print_cpu_info(&boot_cpu_data);
-#endif
+
+	if (!IS_ENABLED(CONFIG_SMP)) {
+		pr_info("CPU: ");
+		print_cpu_info(&boot_cpu_data);
+	}
+
+	/* Select the proper spectre mitigation before patching alternatives */
+	spectre_v2_select_mitigation();
+
+#ifdef CONFIG_X86_32
 	check_config();
 	check_fpu();
 	check_hlt();
@@ -179,4 +198,276 @@ void __init check_bugs(void)
 	init_utsname()->machine[1] =3D
 		'0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
 	alternative_instructions();
+#else /* CONFIG_X86_64 */
+	alternative_instructions();
+
+	/*
+	 * Make sure the first 2MB area is not mapped by huge pages
+	 * There are typically fixed size MTRRs in there and overlapping
+	 * MTRRs into large pages causes slow downs.
+	 *
+	 * Right now we don't do that with gbpages because there seems
+	 * very little benefit for that case.
+	 */
+	if (!direct_gbpages)
+		set_memory_4k((unsigned long)__va(0), 1);
+#endif
+}
+
+/* The kernel command line selection */
+enum spectre_v2_mitigation_cmd {
+	SPECTRE_V2_CMD_NONE,
+	SPECTRE_V2_CMD_AUTO,
+	SPECTRE_V2_CMD_FORCE,
+	SPECTRE_V2_CMD_RETPOLINE,
+	SPECTRE_V2_CMD_RETPOLINE_GENERIC,
+	SPECTRE_V2_CMD_RETPOLINE_AMD,
+};
+
+static const char *spectre_v2_strings[] =3D {
+	[SPECTRE_V2_NONE]			=3D "Vulnerable",
+	[SPECTRE_V2_RETPOLINE_MINIMAL]		=3D "Vulnerable: Minimal generic ASM retp=
oline",
+	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	=3D "Vulnerable: Minimal AMD ASM retpo=
line",
+	[SPECTRE_V2_RETPOLINE_GENERIC]		=3D "Mitigation: Full generic retpoline",
+	[SPECTRE_V2_RETPOLINE_AMD]		=3D "Mitigation: Full AMD retpoline",
+};
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "Spectre V2 : " fmt
+
+static enum spectre_v2_mitigation spectre_v2_enabled =3D SPECTRE_V2_NONE;
+
+#ifdef RETPOLINE
+static bool spectre_v2_bad_module;
+
+bool retpoline_module_ok(bool has_retpoline)
+{
+	if (spectre_v2_enabled =3D=3D SPECTRE_V2_NONE || has_retpoline)
+		return true;
+
+	pr_err("System may be vulnerable to spectre v2\n");
+	spectre_v2_bad_module =3D true;
+	return false;
+}
+
+static inline const char *spectre_v2_module_string(void)
+{
+	return spectre_v2_bad_module ? " - vulnerable module loaded" : "";
+}
+#else
+static inline const char *spectre_v2_module_string(void) { return ""; }
+#endif
+
+static void __init spec2_print_if_insecure(const char *reason)
+{
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		pr_info("%s selected on command line.\n", reason);
+}
+
+static void __init spec2_print_if_secure(const char *reason)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		pr_info("%s selected on command line.\n", reason);
+}
+
+static inline bool retp_compiler(void)
+{
+	return __is_defined(RETPOLINE);
+}
+
+static inline bool match_option(const char *arg, int arglen, const char *o=
pt)
+{
+	int len =3D strlen(opt);
+
+	return len =3D=3D arglen && !strncmp(arg, opt, len);
+}
+
+static const struct {
+	const char *option;
+	enum spectre_v2_mitigation_cmd cmd;
+	bool secure;
+} mitigation_options[] =3D {
+	{ "off",               SPECTRE_V2_CMD_NONE,              false },
+	{ "on",                SPECTRE_V2_CMD_FORCE,             true },
+	{ "retpoline",         SPECTRE_V2_CMD_RETPOLINE,         false },
+	{ "retpoline,amd",     SPECTRE_V2_CMD_RETPOLINE_AMD,     false },
+	{ "retpoline,generic", SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
+	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
+};
+
+static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
+{
+	char arg[20];
+	int ret, i;
+	enum spectre_v2_mitigation_cmd cmd =3D SPECTRE_V2_CMD_AUTO;
+
+	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
+		return SPECTRE_V2_CMD_NONE;
+	else {
+		ret =3D cmdline_find_option(boot_command_line, "spectre_v2", arg,
+					  sizeof(arg));
+		if (ret < 0)
+			return SPECTRE_V2_CMD_AUTO;
+
+		for (i =3D 0; i < ARRAY_SIZE(mitigation_options); i++) {
+			if (!match_option(arg, ret, mitigation_options[i].option))
+				continue;
+			cmd =3D mitigation_options[i].cmd;
+			break;
+		}
+
+		if (i >=3D ARRAY_SIZE(mitigation_options)) {
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
+			return SPECTRE_V2_CMD_AUTO;
+		}
+	}
+
+	if ((cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE ||
+	     cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_AMD ||
+	     cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_GENERIC) &&
+	    !IS_ENABLED(CONFIG_RETPOLINE)) {
+		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
+		       mitigation_options[i].option);
+		return SPECTRE_V2_CMD_AUTO;
+	}
+
+	if (cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_AMD &&
+	    boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD) {
+		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO sel=
ect\n");
+		return SPECTRE_V2_CMD_AUTO;
+	}
+
+	if (mitigation_options[i].secure)
+		spec2_print_if_secure(mitigation_options[i].option);
+	else
+		spec2_print_if_insecure(mitigation_options[i].option);
+
+	return cmd;
+}
+
+/* Check for Skylake-like CPUs (for RSB handling) */
+static bool __init is_skylake_era(void)
+{
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL &&
+	    boot_cpu_data.x86 =3D=3D 6) {
+		switch (boot_cpu_data.x86_model) {
+		case INTEL_FAM6_SKYLAKE_MOBILE:
+		case INTEL_FAM6_SKYLAKE_DESKTOP:
+		case INTEL_FAM6_SKYLAKE_X:
+		case INTEL_FAM6_KABYLAKE_MOBILE:
+		case INTEL_FAM6_KABYLAKE_DESKTOP:
+			return true;
+		}
+	}
+	return false;
+}
+
+static void __init spectre_v2_select_mitigation(void)
+{
+	enum spectre_v2_mitigation_cmd cmd =3D spectre_v2_parse_cmdline();
+	enum spectre_v2_mitigation mode =3D SPECTRE_V2_NONE;
+
+	/*
+	 * If the CPU is not affected and the command line mode is NONE or AUTO
+	 * then nothing to do.
+	 */
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
+	    (cmd =3D=3D SPECTRE_V2_CMD_NONE || cmd =3D=3D SPECTRE_V2_CMD_AUTO))
+		return;
+
+	switch (cmd) {
+	case SPECTRE_V2_CMD_NONE:
+		return;
+
+	case SPECTRE_V2_CMD_FORCE:
+	case SPECTRE_V2_CMD_AUTO:
+		if (IS_ENABLED(CONFIG_RETPOLINE))
+			goto retpoline_auto;
+		break;
+	case SPECTRE_V2_CMD_RETPOLINE_AMD:
+		if (IS_ENABLED(CONFIG_RETPOLINE))
+			goto retpoline_amd;
+		break;
+	case SPECTRE_V2_CMD_RETPOLINE_GENERIC:
+		if (IS_ENABLED(CONFIG_RETPOLINE))
+			goto retpoline_generic;
+		break;
+	case SPECTRE_V2_CMD_RETPOLINE:
+		if (IS_ENABLED(CONFIG_RETPOLINE))
+			goto retpoline_auto;
+		break;
+	}
+	pr_err("kernel not compiled with retpoline; no mitigation available!");
+	return;
+
+retpoline_auto:
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD) {
+	retpoline_amd:
+		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
+			pr_err("LFENCE not serializing. Switching to generic retpoline\n");
+			goto retpoline_generic;
+		}
+		mode =3D retp_compiler() ? SPECTRE_V2_RETPOLINE_AMD :
+					 SPECTRE_V2_RETPOLINE_MINIMAL_AMD;
+		setup_force_cpu_cap(X86_FEATURE_RETPOLINE_AMD);
+		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
+	} else {
+	retpoline_generic:
+		mode =3D retp_compiler() ? SPECTRE_V2_RETPOLINE_GENERIC :
+					 SPECTRE_V2_RETPOLINE_MINIMAL;
+		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
+	}
+
+	spectre_v2_enabled =3D mode;
+	pr_info("%s\n", spectre_v2_strings[mode]);
+
+	/*
+	 * If neither SMEP or KPTI are available, there is a risk of
+	 * hitting userspace addresses in the RSB after a context switch
+	 * from a shallow call stack to a deeper one. To prevent this fill
+	 * the entire RSB, even when using IBRS.
+	 *
+	 * Skylake era CPUs have a separate issue with *underflow* of the
+	 * RSB, when they will predict 'ret' targets from the generic BTB.
+	 * The proper mitigation for this is IBRS. If IBRS is not supported
+	 * or deactivated in favour of retpolines the RSB fill on context
+	 * switch is required.
+	 */
+	if ((!boot_cpu_has(X86_FEATURE_KAISER) &&
+	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
+		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
+		pr_info("Filling RSB on context switch\n");
+	}
 }
+
+#undef pr_fmt
+
+#ifdef CONFIG_SYSFS
+ssize_t cpu_show_meltdown(struct sysdev_class *dev,
+			  struct sysdev_class_attribute *attr, char *buf)
+{
+	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
+		return sprintf(buf, "Not affected\n");
+	if (boot_cpu_has(X86_FEATURE_KAISER))
+		return sprintf(buf, "Mitigation: PTI\n");
+	return sprintf(buf, "Vulnerable\n");
+}
+
+ssize_t cpu_show_spectre_v1(struct sysdev_class *dev,
+			    struct sysdev_class_attribute *attr, char *buf)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
+		return sprintf(buf, "Not affected\n");
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+}
+
+ssize_t cpu_show_spectre_v2(struct sysdev_class *dev,
+			    struct sysdev_class_attribute *attr, char *buf)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		return sprintf(buf, "Not affected\n");
+
+	return sprintf(buf, "%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+		       spectre_v2_module_string());
+}
+#endif
diff --git a/arch/x86/kernel/cpu/bugs_64.c b/arch/x86/kernel/cpu/bugs_64.c
deleted file mode 100644
index 04f0fe5af83e..000000000000
--- a/arch/x86/kernel/cpu/bugs_64.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  Copyright (C) 1994  Linus Torvalds
- *  Copyright (C) 2000  SuSE
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <asm/alternative.h>
-#include <asm/bugs.h>
-#include <asm/processor.h>
-#include <asm/mtrr.h>
-#include <asm/cacheflush.h>
-
-void __init check_bugs(void)
-{
-	identify_boot_cpu();
-#if !defined(CONFIG_SMP)
-	printk(KERN_INFO "CPU: ");
-	print_cpu_info(&boot_cpu_data);
-#endif
-	alternative_instructions();
-
-	/*
-	 * Make sure the first 2MB area is not mapped by huge pages
-	 * There are typically fixed size MTRRs in there and overlapping
-	 * MTRRs into large pages causes slow downs.
-	 *
-	 * Right now we don't do that with gbpages because there seems
-	 * very little benefit for that case.
-	 */
-	if (!direct_gbpages)
-		set_memory_4k((unsigned long)__va(0), 1);
-}
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d5ff61ffbe01..458c59508c30 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -424,8 +424,8 @@ static const char *__cpuinit table_lookup_model(struct =
cpuinfo_x86 *c)
 	return NULL;		/* Not found */
 }
=20
-__u32 cpu_caps_cleared[NCAPINTS] __cpuinitdata;
-__u32 cpu_caps_set[NCAPINTS] __cpuinitdata;
+__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __cpuinitdata;
+__u32 cpu_caps_set[NCAPINTS + NBUGINTS] __cpuinitdata;
=20
 void load_percpu_segment(int cpu)
 {
@@ -632,6 +632,16 @@ void __cpuinit cpu_detect(struct cpuinfo_x86 *c)
 	}
 }
=20
+static void apply_forced_caps(struct cpuinfo_x86 *c)
+{
+	int i;
+
+	for (i =3D 0; i < NCAPINTS + NBUGINTS; i++) {
+		c->x86_capability[i] &=3D ~cpu_caps_cleared[i];
+		c->x86_capability[i] |=3D cpu_caps_set[i];
+	}
+}
+
 void __cpuinit get_cpu_cap(struct cpuinfo_x86 *c)
 {
 	u32 tfms, xlvl;
@@ -757,6 +767,12 @@ static void __init early_identify_cpu(struct cpuinfo_x=
86 *c)
=20
 	if (this_cpu->c_bsp_init)
 		this_cpu->c_bsp_init(c);
+
+	if (c->x86_vendor !=3D X86_VENDOR_AMD)
+		setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
+
+	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
+	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
 }
=20
 void __init early_cpu_init(void)
@@ -880,10 +896,7 @@ static void __cpuinit identify_cpu(struct cpuinfo_x86 =
*c)
 		this_cpu->c_identify(c);
=20
 	/* Clear/Set all flags overriden by options, after probe */
-	for (i =3D 0; i < NCAPINTS; i++) {
-		c->x86_capability[i] &=3D ~cpu_caps_cleared[i];
-		c->x86_capability[i] |=3D cpu_caps_set[i];
-	}
+	apply_forced_caps(c);
=20
 #ifdef CONFIG_X86_64
 	c->apicid =3D apic->phys_pkg_id(c->initial_apicid, 0);
@@ -939,10 +952,7 @@ static void __cpuinit identify_cpu(struct cpuinfo_x86 =
*c)
 	 * Clear/Set all flags overriden by options, need do it
 	 * before following smp all cpus cap AND.
 	 */
-	for (i =3D 0; i < NCAPINTS; i++) {
-		c->x86_capability[i] &=3D ~cpu_caps_cleared[i];
-		c->x86_capability[i] |=3D cpu_caps_set[i];
-	}
+	apply_forced_caps(c);
=20
 	/*
 	 * On SMP, boot_cpu_data holds the common feature set between
@@ -954,6 +964,10 @@ static void __cpuinit identify_cpu(struct cpuinfo_x86 =
*c)
 		/* AND the already accumulated flags with these */
 		for (i =3D 0; i < NCAPINTS; i++)
 			boot_cpu_data.x86_capability[i] &=3D c->x86_capability[i];
+
+		/* OR, i.e. replicate the bug flags */
+		for (i =3D NCAPINTS; i < NCAPINTS + NBUGINTS; i++)
+			c->x86_capability[i] |=3D boot_cpu_data.x86_capability[i];
 	}
=20
 	/* Init Machine Check Exception if available. */
diff --git a/arch/x86/kernel/entry_32.S b/arch/x86/kernel/entry_32.S
index 061f09b46929..ede58eeeb11f 100644
--- a/arch/x86/kernel/entry_32.S
+++ b/arch/x86/kernel/entry_32.S
@@ -55,6 +55,7 @@
 #include <asm/irq_vectors.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative-asm.h>
+#include <asm/nospec-branch.h>
=20
 /* Avoid __ASSEMBLER__'ifying <linux/audit.h> just for this.  */
 #include <linux/elf-em.h>
@@ -428,7 +429,14 @@ ENTRY(ia32_sysenter_target)
 sysenter_do_call:
 	cmpl $(nr_syscalls), %eax
 	jae sysenter_badsys
+	sbb %edx, %edx				/* array_index_mask_nospec() */
+	and %edx, %eax
+#ifdef CONFIG_RETPOLINE
+	movl sys_call_table(,%eax,4),%eax
+	call __x86_indirect_thunk_eax
+#else
 	call *sys_call_table(,%eax,4)
+#endif
 sysenter_after_call:
 	movl %eax,PT_EAX(%esp)
 	LOCKDEP_SYS_EXIT
@@ -511,7 +519,14 @@ ENTRY(system_call)
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 syscall_call:
+	sbb %edx, %edx				/* array_index_mask_nospec() */
+	and %edx, %eax
+#ifdef CONFIG_RETPOLINE
+	movl sys_call_table(,%eax,4),%eax
+	call __x86_indirect_thunk_eax
+#else
 	call *sys_call_table(,%eax,4)
+#endif
 syscall_after_call:
 	movl %eax,PT_EAX(%esp)		# store the return value
 syscall_exit:
@@ -1017,7 +1032,7 @@ ENTRY(kernel_thread_helper)
 	pushl $0		# fake return address for unwinder
 	CFI_STARTPROC
 	movl %edi,%eax
-	call *%esi
+	CALL_NOSPEC %esi
 	call do_exit
 	ud2			# padding for call trace
 	CFI_ENDPROC
@@ -1182,7 +1197,8 @@ ENTRY(mcount)
 	movl 0x4(%ebp), %edx
 	subl $MCOUNT_INSN_SIZE, %eax
=20
-	call *ftrace_trace_function
+	movl ftrace_trace_function, %ecx
+	CALL_NOSPEC %ecx
=20
 	popl %edx
 	popl %ecx
@@ -1220,7 +1236,7 @@ END(ftrace_graph_caller)
 	movl %eax, %ecx
 	popl %edx
 	popl %eax
-	jmp *%ecx
+	JMP_NOSPEC %ecx
 #endif
=20
 .section .rodata,"a"
@@ -1274,7 +1290,7 @@ ENTRY(page_fault)
 	movl %ecx, %es
 	TRACE_IRQS_OFF
 	movl %esp,%eax			# pt_regs pointer
-	call *%edi
+	CALL_NOSPEC %edi
 	jmp ret_from_exception
 	CFI_ENDPROC
 END(page_fault)
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index c13ca52ce42e..e992680d0eab 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -59,6 +59,7 @@
 #include <asm/alternative-asm.h>
 #include <asm/cpufeature.h>
 #include <asm/kaiser.h>
+#include <asm/nospec-branch.h>
=20
 /* Avoid __ASSEMBLER__'ifying <linux/audit.h> just for this.  */
 #include <linux/elf-em.h>
@@ -125,8 +126,8 @@ GLOBAL(ftrace_stub)
 	movq 8(%rbp), %rsi
 	subq $MCOUNT_INSN_SIZE, %rdi
=20
-	call   *ftrace_trace_function
-
+	movq ftrace_trace_function, %r8
+	CALL_NOSPEC %r8
 	MCOUNT_RESTORE_FRAME
=20
 	jmp ftrace_stub
@@ -167,7 +168,7 @@ GLOBAL(return_to_handler)
 	movq 8(%rsp), %rdx
 	movq (%rsp), %rax
 	addq $24, %rsp
-	jmp *%rdi
+	JMP_NOSPEC %rdi
 #endif
=20
=20
@@ -516,10 +517,17 @@ ENTRY(system_call_after_swapgs)
 	testl $_TIF_WORK_SYSCALL_ENTRY,TI_flags(%rcx)
 	jnz tracesys
 system_call_fastpath:
-	cmpq $__NR_syscall_max,%rax
-	ja badsys
+	cmpq	$NR_syscalls, %rax
+	jae	badsys
+	sbb	%rcx, %rcx			/* array_index_mask_nospec() */
+	and	%rcx, %rax
 	movq %r10,%rcx
+#ifdef CONFIG_RETPOLINE
+	movq	sys_call_table(, %rax, 8), %rax
+	call	__x86_indirect_thunk_rax
+#else
 	call *sys_call_table(,%rax,8)  # XXX:	 rip relative
+#endif
 	movq %rax,RAX-ARGOFFSET(%rsp)
 /*
  * Syscall return path ending with SYSRET (fast path)
@@ -640,10 +648,17 @@ ENTRY(system_call_after_swapgs)
 	 */
 	LOAD_ARGS ARGOFFSET, 1
 	RESTORE_REST
-	cmpq $__NR_syscall_max,%rax
-	ja   int_ret_from_sys_call	/* RAX(%rsp) set to -ENOSYS above */
+	cmpq	$NR_syscalls, %rax
+	jae	int_ret_from_sys_call		/* RAX(%rsp) set to -ENOSYS above */
+	sbb	%rcx, %rcx			/* array_index_mask_nospec() */
+	and	%rcx, %rax
 	movq %r10,%rcx	/* fixup for C */
+#ifdef CONFIG_RETPOLINE
+	movq	sys_call_table(, %rax, 8), %rax
+	call	__x86_indirect_thunk_rax
+#else
 	call *sys_call_table(,%rax,8)
+#endif
 	movq %rax,RAX-ARGOFFSET(%rsp)
 	/* Use IRET because user could have changed frame */
=20
@@ -1219,7 +1234,7 @@ ENTRY(kernel_thread_helper)
 	 * Here we are in the child and the registers are set as they were
 	 * at kernel_thread() invocation in the parent.
 	 */
-	call *%rsi
+	CALL_NOSPEC %rsi
 	# exit
 	mov %eax, %edi
 	call do_exit
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index 72090705a656..91fc1328675c 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
=20
 #include <asm/apic.h>
+#include <asm/nospec-branch.h>
=20
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
@@ -64,11 +65,11 @@ static DEFINE_PER_CPU(union irq_ctx *, softirq_ctx);
 static void call_on_stack(void *func, void *stack)
 {
 	asm volatile("xchgl	%%ebx,%%esp	\n"
-		     "call	*%%edi		\n"
+		     CALL_NOSPEC
 		     "movl	%%ebx,%%esp	\n"
 		     : "=3Db" (stack)
 		     : "0" (stack),
-		       "D"(func)
+		       [thunk_target] "D"(func)
 		     : "memory", "cc", "edx", "ecx", "eax");
 }
=20
@@ -107,11 +108,11 @@ execute_on_irq_stack(int overflow, struct irq_desc *d=
esc, int irq)
 		call_on_stack(print_stack_overflow, isp);
=20
 	asm volatile("xchgl	%%ebx,%%esp	\n"
-		     "call	*%%edi		\n"
+		     CALL_NOSPEC
 		     "movl	%%ebx,%%esp	\n"
 		     : "=3Da" (arg1), "=3Dd" (arg2), "=3Db" (isp)
 		     :  "0" (irq),   "1" (desc),  "2" (isp),
-			"D" (desc->handle_irq)
+			[thunk_target] "D" (desc->handle_irq)
 		     : "memory", "cc", "ecx");
 	return 1;
 }
diff --git a/arch/x86/kernel/kprobes.c b/arch/x86/kernel/kprobes.c
index 29aed8d01b76..dc5e1bc30638 100644
--- a/arch/x86/kernel/kprobes.c
+++ b/arch/x86/kernel/kprobes.c
@@ -58,6 +58,7 @@
 #include <asm/alternative.h>
 #include <asm/insn.h>
 #include <asm/debugreg.h>
+#include <asm/nospec-branch.h>
=20
 void jprobe_return_end(void);
=20
@@ -1256,7 +1257,7 @@ static int __kprobes copy_optimized_instructions(u8 *=
dest, u8 *src)
 }
=20
 /* Check whether insn is indirect jump */
-static int __kprobes insn_is_indirect_jump(struct insn *insn)
+static int __kprobes __insn_is_indirect_jump(struct insn *insn)
 {
 	return ((insn->opcode.bytes[0] =3D=3D 0xff &&
 		(X86_MODRM_REG(insn->modrm.value) & 6) =3D=3D 4) || /* Jump */
@@ -1290,6 +1291,26 @@ static int insn_jump_into_range(struct insn *insn, u=
nsigned long start, int len)
 	return (start <=3D target && target <=3D start + len);
 }
=20
+static int __kprobes insn_is_indirect_jump(struct insn *insn)
+{
+	int ret =3D __insn_is_indirect_jump(insn);
+
+#ifdef CONFIG_RETPOLINE
+	/*
+	 * Jump to x86_indirect_thunk_* is treated as an indirect jump.
+	 * Note that even with CONFIG_RETPOLINE=3Dy, the kernel compiled with
+	 * older gcc may use indirect jump. So we add this check instead of
+	 * replace indirect-jump check.
+	 */
+	if (!ret)
+		ret =3D insn_jump_into_range(insn,
+				(unsigned long)__indirect_thunk_start,
+				(unsigned long)__indirect_thunk_end -
+				(unsigned long)__indirect_thunk_start);
+#endif
+	return ret;
+}
+
 /* Decode whole function to ensure any instructions don't jump into target=
 */
 static int __kprobes can_optimize(unsigned long paddr)
 {
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0f703f10901a..84aae84d4c02 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -108,6 +108,13 @@ SECTIONS
 		IRQENTRY_TEXT
 		*(.fixup)
 		*(.gnu.warning)
+#ifdef CONFIG_RETPOLINE
+		__indirect_thunk_start =3D .;
+		*(.text.__x86.indirect_thunk)
+		__indirect_thunk_end =3D .;
+		__indirect_thunk_size =3D __indirect_thunk_end - __indirect_thunk_start;
+#endif
+
 		/* End of text section */
 		_etext =3D .;
 	} :text =3D 0x9090
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 4bdd0acc68c3..3dacb59b15c2 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -33,6 +33,7 @@
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
 #include <asm/kvm_para.h>
+#include <asm/nospec-branch.h>
=20
 #include <asm/virtext.h>
 #include "trace.h"
@@ -3679,12 +3680,6 @@ static void svm_cancel_injection(struct kvm_vcpu *vc=
pu)
 	svm_complete_interrupts(svm);
 }
=20
-#ifdef CONFIG_X86_64
-#define R "r"
-#else
-#define R "e"
-#endif
-
 static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm =3D to_svm(vcpu);
@@ -3711,13 +3706,13 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	local_irq_enable();
=20
 	asm volatile (
-		"push %%"R"bp; \n\t"
-		"mov %c[rbx](%[svm]), %%"R"bx \n\t"
-		"mov %c[rcx](%[svm]), %%"R"cx \n\t"
-		"mov %c[rdx](%[svm]), %%"R"dx \n\t"
-		"mov %c[rsi](%[svm]), %%"R"si \n\t"
-		"mov %c[rdi](%[svm]), %%"R"di \n\t"
-		"mov %c[rbp](%[svm]), %%"R"bp \n\t"
+		"push %%" _ASM_BP "; \n\t"
+		"mov %c[rbx](%[svm]), %%" _ASM_BX " \n\t"
+		"mov %c[rcx](%[svm]), %%" _ASM_CX " \n\t"
+		"mov %c[rdx](%[svm]), %%" _ASM_DX " \n\t"
+		"mov %c[rsi](%[svm]), %%" _ASM_SI " \n\t"
+		"mov %c[rdi](%[svm]), %%" _ASM_DI " \n\t"
+		"mov %c[rbp](%[svm]), %%" _ASM_BP " \n\t"
 #ifdef CONFIG_X86_64
 		"mov %c[r8](%[svm]),  %%r8  \n\t"
 		"mov %c[r9](%[svm]),  %%r9  \n\t"
@@ -3730,20 +3725,20 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 #endif
=20
 		/* Enter guest mode */
-		"push %%"R"ax \n\t"
-		"mov %c[vmcb](%[svm]), %%"R"ax \n\t"
+		"push %%" _ASM_AX " \n\t"
+		"mov %c[vmcb](%[svm]), %%" _ASM_AX " \n\t"
 		__ex(SVM_VMLOAD) "\n\t"
 		__ex(SVM_VMRUN) "\n\t"
 		__ex(SVM_VMSAVE) "\n\t"
-		"pop %%"R"ax \n\t"
+		"pop %%" _ASM_AX " \n\t"
=20
 		/* Save guest registers, load host registers */
-		"mov %%"R"bx, %c[rbx](%[svm]) \n\t"
-		"mov %%"R"cx, %c[rcx](%[svm]) \n\t"
-		"mov %%"R"dx, %c[rdx](%[svm]) \n\t"
-		"mov %%"R"si, %c[rsi](%[svm]) \n\t"
-		"mov %%"R"di, %c[rdi](%[svm]) \n\t"
-		"mov %%"R"bp, %c[rbp](%[svm]) \n\t"
+		"mov %%" _ASM_BX ", %c[rbx](%[svm]) \n\t"
+		"mov %%" _ASM_CX ", %c[rcx](%[svm]) \n\t"
+		"mov %%" _ASM_DX ", %c[rdx](%[svm]) \n\t"
+		"mov %%" _ASM_SI ", %c[rsi](%[svm]) \n\t"
+		"mov %%" _ASM_DI ", %c[rdi](%[svm]) \n\t"
+		"mov %%" _ASM_BP ", %c[rbp](%[svm]) \n\t"
 #ifdef CONFIG_X86_64
 		"mov %%r8,  %c[r8](%[svm]) \n\t"
 		"mov %%r9,  %c[r9](%[svm]) \n\t"
@@ -3754,7 +3749,26 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 		"mov %%r14, %c[r14](%[svm]) \n\t"
 		"mov %%r15, %c[r15](%[svm]) \n\t"
 #endif
-		"pop %%"R"bp"
+		/*
+		* Clear host registers marked as clobbered to prevent
+		* speculative use.
+		*/
+		"xor %%" _ASM_BX ", %%" _ASM_BX " \n\t"
+		"xor %%" _ASM_CX ", %%" _ASM_CX " \n\t"
+		"xor %%" _ASM_DX ", %%" _ASM_DX " \n\t"
+		"xor %%" _ASM_SI ", %%" _ASM_SI " \n\t"
+		"xor %%" _ASM_DI ", %%" _ASM_DI " \n\t"
+#ifdef CONFIG_X86_64
+		"xor %%r8, %%r8 \n\t"
+		"xor %%r9, %%r9 \n\t"
+		"xor %%r10, %%r10 \n\t"
+		"xor %%r11, %%r11 \n\t"
+		"xor %%r12, %%r12 \n\t"
+		"xor %%r13, %%r13 \n\t"
+		"xor %%r14, %%r14 \n\t"
+		"xor %%r15, %%r15 \n\t"
+#endif
+		"pop %%" _ASM_BP
 		:
 		: [svm]"a"(svm),
 		  [vmcb]"i"(offsetof(struct vcpu_svm, vmcb_pa)),
@@ -3775,12 +3789,17 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 		  [r15]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_R15]))
 #endif
 		: "cc", "memory"
-		, R"bx", R"cx", R"dx", R"si", R"di"
 #ifdef CONFIG_X86_64
+		, "rbx", "rcx", "rdx", "rsi", "rdi"
 		, "r8", "r9", "r10", "r11" , "r12", "r13", "r14", "r15"
+#else
+		, "ebx", "ecx", "edx", "esi", "edi"
 #endif
 		);
=20
+	/* Eliminate branch target predictions from guest mode */
+	vmexit_fill_RSB();
+
 #ifdef CONFIG_X86_64
 	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
 #else
@@ -3837,8 +3856,6 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	mark_all_clean(svm->vmcb);
 }
=20
-#undef R
-
 static void svm_set_cr3(struct kvm_vcpu *vcpu, unsigned long root)
 {
 	struct vcpu_svm *svm =3D to_svm(vcpu);
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 690120f552db..24227a820ee3 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -29,6 +29,7 @@
 #include <linux/ftrace_event.h>
 #include <linux/slab.h>
 #include <linux/tboot.h>
+#include <linux/nospec.h>
 #include "kvm_cache_regs.h"
 #include "x86.h"
=20
@@ -40,6 +41,7 @@
 #include <asm/i387.h>
 #include <asm/xcr.h>
 #include <asm/perf_event.h>
+#include <asm/nospec-branch.h>
=20
 #include "trace.h"
=20
@@ -569,23 +571,21 @@ static unsigned short vmcs_field_to_offset_table[] =
=3D {
 	FIELD(HOST_RSP, host_rsp),
 	FIELD(HOST_RIP, host_rip),
 };
-static const int max_vmcs_field =3D ARRAY_SIZE(vmcs_field_to_offset_table);
=20
 static inline short vmcs_field_to_offset(unsigned long field)
 {
-	if (field >=3D max_vmcs_field)
-		return -1;
-
-	/*
-	 * FIXME: Mitigation for CVE-2017-5753.  To be replaced with a
-	 * generic mechanism.
-	 */
-	asm("lfence");
+	const size_t size =3D ARRAY_SIZE(vmcs_field_to_offset_table);
+	unsigned short offset;
=20
-	if (vmcs_field_to_offset_table[field] =3D=3D 0)
+	BUILD_BUG_ON(size > SHRT_MAX);
+	if (field >=3D size)
 		return -1;
=20
-	return vmcs_field_to_offset_table[field];
+	field =3D array_index_nospec(field, size);
+	offset =3D vmcs_field_to_offset_table[field];
+	if (offset =3D=3D 0)
+		return -1;
+	return offset;
 }
=20
 static inline struct vmcs12 *get_vmcs12(struct kvm_vcpu *vcpu)
@@ -6130,14 +6130,6 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx =
*vmx)
 					msrs[i].host);
 }
=20
-#ifdef CONFIG_X86_64
-#define R "r"
-#define Q "q"
-#else
-#define R "e"
-#define Q "l"
-#endif
-
 static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
@@ -6191,30 +6183,30 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu =
*vcpu)
 	vmx->__launched =3D vmx->loaded_vmcs->launched;
 	asm(
 		/* Store host registers */
-		"push %%"R"dx; push %%"R"bp;"
-		"push %%"R"cx \n\t" /* placeholder for guest rcx */
-		"push %%"R"cx \n\t"
-		"cmp %%"R"sp, %c[host_rsp](%0) \n\t"
+		"push %%" _ASM_DX "; push %%" _ASM_BP ";"
+		"push %%" _ASM_CX " \n\t" /* placeholder for guest rcx */
+		"push %%" _ASM_CX " \n\t"
+		"cmp %%" _ASM_SP ", %c[host_rsp](%0) \n\t"
 		"je 1f \n\t"
-		"mov %%"R"sp, %c[host_rsp](%0) \n\t"
+		"mov %%" _ASM_SP ", %c[host_rsp](%0) \n\t"
 		__ex(ASM_VMX_VMWRITE_RSP_RDX) "\n\t"
 		"1: \n\t"
 		/* Reload cr2 if changed */
-		"mov %c[cr2](%0), %%"R"ax \n\t"
-		"mov %%cr2, %%"R"dx \n\t"
-		"cmp %%"R"ax, %%"R"dx \n\t"
+		"mov %c[cr2](%0), %%" _ASM_AX " \n\t"
+		"mov %%cr2, %%" _ASM_DX " \n\t"
+		"cmp %%" _ASM_AX ", %%" _ASM_DX " \n\t"
 		"je 2f \n\t"
-		"mov %%"R"ax, %%cr2 \n\t"
+		"mov %%" _ASM_AX", %%cr2 \n\t"
 		"2: \n\t"
 		/* Check if vmlaunch of vmresume is needed */
 		"cmpl $0, %c[launched](%0) \n\t"
 		/* Load guest registers.  Don't clobber flags. */
-		"mov %c[rax](%0), %%"R"ax \n\t"
-		"mov %c[rbx](%0), %%"R"bx \n\t"
-		"mov %c[rdx](%0), %%"R"dx \n\t"
-		"mov %c[rsi](%0), %%"R"si \n\t"
-		"mov %c[rdi](%0), %%"R"di \n\t"
-		"mov %c[rbp](%0), %%"R"bp \n\t"
+		"mov %c[rax](%0), %%" _ASM_AX " \n\t"
+		"mov %c[rbx](%0), %%" _ASM_BX " \n\t"
+		"mov %c[rdx](%0), %%" _ASM_DX " \n\t"
+		"mov %c[rsi](%0), %%" _ASM_SI " \n\t"
+		"mov %c[rdi](%0), %%" _ASM_DI " \n\t"
+		"mov %c[rbp](%0), %%" _ASM_BP " \n\t"
 #ifdef CONFIG_X86_64
 		"mov %c[r8](%0),  %%r8  \n\t"
 		"mov %c[r9](%0),  %%r9  \n\t"
@@ -6225,7 +6217,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *v=
cpu)
 		"mov %c[r14](%0), %%r14 \n\t"
 		"mov %c[r15](%0), %%r15 \n\t"
 #endif
-		"mov %c[rcx](%0), %%"R"cx \n\t" /* kills %0 (ecx) */
+		"mov %c[rcx](%0), %%" _ASM_CX " \n\t" /* kills %0 (ecx) */
=20
 		/* Enter guest mode */
 		"jne .Llaunched \n\t"
@@ -6234,15 +6226,16 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu =
*vcpu)
 		".Llaunched: " __ex(ASM_VMX_VMRESUME) "\n\t"
 		".Lkvm_vmx_return: "
 		/* Save guest registers, load host registers, keep flags */
-		"mov %0, %c[wordsize](%%"R"sp) \n\t"
+		"mov %0, %c[wordsize](%%" _ASM_SP ") \n\t"
 		"pop %0 \n\t"
-		"mov %%"R"ax, %c[rax](%0) \n\t"
-		"mov %%"R"bx, %c[rbx](%0) \n\t"
-		"pop"Q" %c[rcx](%0) \n\t"
-		"mov %%"R"dx, %c[rdx](%0) \n\t"
-		"mov %%"R"si, %c[rsi](%0) \n\t"
-		"mov %%"R"di, %c[rdi](%0) \n\t"
-		"mov %%"R"bp, %c[rbp](%0) \n\t"
+		"setbe %c[fail](%0)\n\t"
+		"mov %%" _ASM_AX ", %c[rax](%0) \n\t"
+		"mov %%" _ASM_BX ", %c[rbx](%0) \n\t"
+		__ASM_SIZE(pop) " %c[rcx](%0) \n\t"
+		"mov %%" _ASM_DX ", %c[rdx](%0) \n\t"
+		"mov %%" _ASM_SI ", %c[rsi](%0) \n\t"
+		"mov %%" _ASM_DI ", %c[rdi](%0) \n\t"
+		"mov %%" _ASM_BP ", %c[rbp](%0) \n\t"
 #ifdef CONFIG_X86_64
 		"mov %%r8,  %c[r8](%0) \n\t"
 		"mov %%r9,  %c[r9](%0) \n\t"
@@ -6252,12 +6245,23 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu =
*vcpu)
 		"mov %%r13, %c[r13](%0) \n\t"
 		"mov %%r14, %c[r14](%0) \n\t"
 		"mov %%r15, %c[r15](%0) \n\t"
+		"xor %%r8d,  %%r8d \n\t"
+		"xor %%r9d,  %%r9d \n\t"
+		"xor %%r10d, %%r10d \n\t"
+		"xor %%r11d, %%r11d \n\t"
+		"xor %%r12d, %%r12d \n\t"
+		"xor %%r13d, %%r13d \n\t"
+		"xor %%r14d, %%r14d \n\t"
+		"xor %%r15d, %%r15d \n\t"
 #endif
-		"mov %%cr2, %%"R"ax   \n\t"
-		"mov %%"R"ax, %c[cr2](%0) \n\t"
-
-		"pop  %%"R"bp; pop  %%"R"dx \n\t"
-		"setbe %c[fail](%0) \n\t"
+		"mov %%cr2, %%" _ASM_AX "   \n\t"
+		"mov %%" _ASM_AX ", %c[cr2](%0) \n\t"
+
+		"xor %%eax, %%eax \n\t"
+		"xor %%ebx, %%ebx \n\t"
+		"xor %%esi, %%esi \n\t"
+		"xor %%edi, %%edi \n\t"
+		"pop  %%" _ASM_BP "; pop  %%" _ASM_DX " \n\t"
 	      : : "c"(vmx), "d"((unsigned long)HOST_RSP),
 		[launched]"i"(offsetof(struct vcpu_vmx, __launched)),
 		[fail]"i"(offsetof(struct vcpu_vmx, fail)),
@@ -6282,12 +6286,17 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu =
*vcpu)
 		[cr2]"i"(offsetof(struct vcpu_vmx, vcpu.arch.cr2)),
 		[wordsize]"i"(sizeof(ulong))
 	      : "cc", "memory"
-		, R"ax", R"bx", R"di", R"si"
 #ifdef CONFIG_X86_64
+		, "rax", "rbx", "rdi", "rsi"
 		, "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"
+#else
+		, "eax", "ebx", "edi", "esi"
 #endif
 	      );
=20
+	/* Eliminate branch target predictions from guest mode */
+	vmexit_fill_RSB();
+
 	vcpu->arch.regs_avail =3D ~((1 << VCPU_REGS_RIP) | (1 << VCPU_REGS_RSP)
 				  | (1 << VCPU_EXREG_RFLAGS)
 				  | (1 << VCPU_EXREG_CPL)
@@ -6320,9 +6329,6 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *v=
cpu)
 	vmx_complete_interrupts(vmx);
 }
=20
-#undef R
-#undef Q
-
 static void vmx_load_vmcs01(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 2db5846d86ed..bd1dcf5a76ab 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -23,6 +23,8 @@ lib-y +=3D memcpy_$(BITS).o
 lib-$(CONFIG_SMP) +=3D rwlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) +=3D rwsem.o
 lib-$(CONFIG_INSTRUCTION_DECODER) +=3D insn.o inat.o
+lib-$(CONFIG_RETPOLINE) +=3D retpoline.o
+obj-$(CONFIG_RETPOLINE) +=3D retpoline-export.o
=20
 obj-y +=3D msr.o msr-reg.o msr-reg-export.o
=20
diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 78d16a554db0..6122c6f7a92d 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -28,7 +28,8 @@
 #include <linux/linkage.h>
 #include <asm/dwarf2.h>
 #include <asm/errno.h>
-			=09
+#include <asm/nospec-branch.h>
+
 /*
  * computes a partial checksum, e.g. for TCP/UDP fragments
  */
@@ -164,7 +165,7 @@ ENTRY(csum_partial)
 	negl %ebx
 	lea 45f(%ebx,%ebx,2), %ebx
 	testl %esi, %esi
-	jmp *%ebx
+	JMP_NOSPEC %ebx
=20
 	# Handle 2-byte-aligned regions
 20:	addw (%esi), %ax
@@ -466,7 +467,7 @@ ENTRY(csum_partial_copy_generic)
 	andl $-32,%edx
 	lea 3f(%ebx,%ebx), %ebx
 	testl %esi, %esi=20
-	jmp *%ebx
+	JMP_NOSPEC %ebx
 1:	addl $64,%esi
 	addl $64,%edi=20
 	SRC(movb -32(%edx),%bl)	; SRC(movb (%edx),%bl)
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 51f1504cddd9..559f676e8863 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -40,6 +40,8 @@ ENTRY(__get_user_1)
 	GET_THREAD_INFO(%_ASM_DX)
 	cmp TI_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 1:	movzb (%_ASM_AX),%edx
 	xor %eax,%eax
 	ret
@@ -53,6 +55,8 @@ ENTRY(__get_user_2)
 	GET_THREAD_INFO(%_ASM_DX)
 	cmp TI_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 2:	movzwl -1(%_ASM_AX),%edx
 	xor %eax,%eax
 	ret
@@ -66,6 +70,8 @@ ENTRY(__get_user_4)
 	GET_THREAD_INFO(%_ASM_DX)
 	cmp TI_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 3:	mov -3(%_ASM_AX),%edx
 	xor %eax,%eax
 	ret
@@ -80,6 +86,8 @@ ENTRY(__get_user_8)
 	GET_THREAD_INFO(%_ASM_DX)
 	cmp TI_addr_limit(%_ASM_DX),%_ASM_AX
 	jae	bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 4:	movq -7(%_ASM_AX),%_ASM_DX
 	xor %eax,%eax
 	ret
diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index 8f8eebdca7d4..ec0717415785 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -8,7 +8,7 @@ struct msr *msrs_alloc(void)
=20
 	msrs =3D alloc_percpu(struct msr);
 	if (!msrs) {
-		pr_warning("%s: error allocating msrs\n", __func__);
+		pr_warn("%s: error allocating msrs\n", __func__);
 		return NULL;
 	}
=20
@@ -21,3 +21,90 @@ void msrs_free(struct msr *msrs)
 	free_percpu(msrs);
 }
 EXPORT_SYMBOL(msrs_free);
+
+/**
+ * Read an MSR with error handling
+ *
+ * @msr: MSR to read
+ * @m: value to read into
+ *
+ * It returns read data only on success, otherwise it doesn't change the o=
utput
+ * argument @m.
+ *
+ */
+int msr_read(u32 msr, struct msr *m)
+{
+	int err;
+	u64 val;
+
+	err =3D rdmsrl_safe(msr, &val);
+	if (!err)
+		m->q =3D val;
+
+	return err;
+}
+
+/**
+ * Write an MSR with error handling
+ *
+ * @msr: MSR to write
+ * @m: value to write
+ */
+int msr_write(u32 msr, struct msr *m)
+{
+	return checking_wrmsrl(msr, m->q);
+}
+
+static inline int __flip_bit(u32 msr, u8 bit, bool set)
+{
+	struct msr m, m1;
+	int err =3D -EINVAL;
+
+	if (bit > 63)
+		return err;
+
+	err =3D msr_read(msr, &m);
+	if (err)
+		return err;
+
+	m1 =3D m;
+	if (set)
+		m1.q |=3D  BIT_64(bit);
+	else
+		m1.q &=3D ~BIT_64(bit);
+
+	if (m1.q =3D=3D m.q)
+		return 0;
+
+	err =3D msr_write(msr, &m);
+	if (err)
+		return err;
+
+	return 1;
+}
+
+/**
+ * Set @bit in a MSR @msr.
+ *
+ * Retval:
+ * < 0: An error was encountered.
+ * =3D 0: Bit was already set.
+ * > 0: Hardware accepted the MSR write.
+ */
+int msr_set_bit(u32 msr, u8 bit)
+{
+	return __flip_bit(msr, bit, true);
+}
+
+/**
+ * Clear @bit in a MSR @msr.
+ *
+ * Retval:
+ * < 0: An error was encountered.
+ * =3D 0: Bit was already cleared.
+ * > 0: Hardware accepted the MSR write.
+ */
+int msr_clear_bit(u32 msr, u8 bit)
+{
+	return __flip_bit(msr, bit, false);
+}
diff --git a/arch/x86/lib/retpoline-export.c b/arch/x86/lib/retpoline-expor=
t.c
new file mode 100644
index 000000000000..a17f17f89fee
--- /dev/null
+++ b/arch/x86/lib/retpoline-export.c
@@ -0,0 +1,25 @@
+#include <linux/export.h>
+#include <linux/linkage.h>
+
+#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_X86_32
+#define INDIRECT_THUNK(reg) extern asmlinkage void __x86_indirect_thunk_e =
## reg(void); EXPORT_SYMBOL(__x86_indirect_thunk_e ## reg);
+#else
+#define INDIRECT_THUNK(reg) extern asmlinkage void __x86_indirect_thunk_r =
## reg(void); EXPORT_SYMBOL(__x86_indirect_thunk_r ## reg);
+INDIRECT_THUNK(8)
+INDIRECT_THUNK(9)
+INDIRECT_THUNK(10)
+INDIRECT_THUNK(11)
+INDIRECT_THUNK(12)
+INDIRECT_THUNK(13)
+INDIRECT_THUNK(14)
+INDIRECT_THUNK(15)
+#endif
+INDIRECT_THUNK(ax)
+INDIRECT_THUNK(bx)
+INDIRECT_THUNK(cx)
+INDIRECT_THUNK(dx)
+INDIRECT_THUNK(si)
+INDIRECT_THUNK(di)
+INDIRECT_THUNK(bp)
+#endif /* CONFIG_RETPOLINE */
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
new file mode 100644
index 000000000000..5242a3b96bf4
--- /dev/null
+++ b/arch/x86/lib/retpoline.S
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/stringify.h>
+#include <linux/linkage.h>
+#include <asm/dwarf2.h>
+#include <asm/cpufeature.h>
+#include <asm/alternative-asm.h>
+#include <asm/nospec-branch.h>
+
+.macro THUNK reg
+	.section .text.__x86.indirect_thunk
+
+ENTRY(__x86_indirect_thunk_\reg)
+	CFI_STARTPROC
+	JMP_NOSPEC %\reg
+	CFI_ENDPROC
+ENDPROC(__x86_indirect_thunk_\reg)
+.endm
+
+/*
+ * Despite being an assembler file we can't just use .irp here
+ * because __KSYM_DEPS__ only uses the C preprocessor and would
+ * only see one instance of "__x86_indirect_thunk_\reg" rather
+ * than one per register with the correct names. So we do it
+ * the simple and nasty way...
+ */
+#define GENERATE_THUNK(reg) THUNK reg
+
+GENERATE_THUNK(_ASM_AX)
+GENERATE_THUNK(_ASM_BX)
+GENERATE_THUNK(_ASM_CX)
+GENERATE_THUNK(_ASM_DX)
+GENERATE_THUNK(_ASM_SI)
+GENERATE_THUNK(_ASM_DI)
+GENERATE_THUNK(_ASM_BP)
+#ifdef CONFIG_64BIT
+GENERATE_THUNK(r8)
+GENERATE_THUNK(r9)
+GENERATE_THUNK(r10)
+GENERATE_THUNK(r11)
+GENERATE_THUNK(r12)
+GENERATE_THUNK(r13)
+GENERATE_THUNK(r14)
+GENERATE_THUNK(r15)
+#endif
diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index e218d5df85ff..0462f6531ed6 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -774,6 +774,7 @@ unsigned long __copy_to_user_ll(void __user *to, const =
void *from,
 		return n;
 	}
 #endif
+	barrier_nospec();
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else
@@ -785,6 +786,7 @@ EXPORT_SYMBOL(__copy_to_user_ll);
 unsigned long __copy_from_user_ll(void *to, const void __user *from,
 					unsigned long n)
 {
+	barrier_nospec();
 	if (movsl_is_ok(to, from, n))
 		__copy_user_zeroing(to, from, n);
 	else
@@ -796,6 +798,7 @@ EXPORT_SYMBOL(__copy_from_user_ll);
 unsigned long __copy_from_user_ll_nozero(void *to, const void __user *from,
 					 unsigned long n)
 {
+	barrier_nospec();
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else
@@ -808,6 +811,7 @@ EXPORT_SYMBOL(__copy_from_user_ll_nozero);
 unsigned long __copy_from_user_ll_nocache(void *to, const void __user *fro=
m,
 					unsigned long n)
 {
+	barrier_nospec();
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	if (n > 64 && cpu_has_xmm2)
 		n =3D __copy_user_zeroing_intel_nocache(to, from, n);
@@ -823,6 +827,7 @@ EXPORT_SYMBOL(__copy_from_user_ll_nocache);
 unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __us=
er *from,
 					unsigned long n)
 {
+	barrier_nospec();
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	if (n > 64 && cpu_has_xmm2)
 		n =3D __copy_user_intel_nocache(to, from, n);
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 21cf46f45245..050b6c6a48f7 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -172,6 +172,9 @@ config SYS_HYPERVISOR
 	bool
 	default n
=20
+config GENERIC_CPU_VULNERABILITIES
+	bool
+
 source "drivers/base/regmap/Kconfig"
=20
 endmenu
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 251acea3d359..8d82884da93a 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -247,6 +247,53 @@ struct sys_device *get_cpu_sysdev(unsigned cpu)
 }
 EXPORT_SYMBOL_GPL(get_cpu_sysdev);
=20
+#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
+
+ssize_t __weak cpu_show_meltdown(struct sysdev_class *class,
+				 struct sysdev_class_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
+ssize_t __weak cpu_show_spectre_v1(struct sysdev_class *class,
+				   struct sysdev_class_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
+ssize_t __weak cpu_show_spectre_v2(struct sysdev_class *class,
+				   struct sysdev_class_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
+static SYSDEV_CLASS_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
+static SYSDEV_CLASS_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
+static SYSDEV_CLASS_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
+
+static struct attribute *cpu_root_vulnerabilities_attrs[] =3D {
+	&attr_meltdown.attr,
+	&attr_spectre_v1.attr,
+	&attr_spectre_v2.attr,
+	NULL
+};
+
+static const struct attribute_group cpu_root_vulnerabilities_group =3D {
+	.name  =3D "vulnerabilities",
+	.attrs =3D cpu_root_vulnerabilities_attrs,
+};
+
+static void __init cpu_register_vulnerabilities(void)
+{
+	if (sysfs_create_group(&cpu_sysdev_class.kset.kobj,
+			       &cpu_root_vulnerabilities_group))
+		pr_err("Unable to register CPU vulnerabilities\n");
+}
+
+#else
+static inline void cpu_register_vulnerabilities(void) { }
+#endif
+
 int __init cpu_dev_init(void)
 {
 	int err;
@@ -256,6 +303,8 @@ int __init cpu_dev_init(void)
 	if (!err)
 		err =3D sched_create_sysfs_power_savings_entries(&cpu_sysdev_class);
 #endif
+	if (!err)
+		cpu_register_vulnerabilities();
=20
 	return err;
 }
diff --git a/drivers/edac/mce_amd.h b/drivers/edac/mce_amd.h
index 0106747e240c..a40dcfd6d872 100644
--- a/drivers/edac/mce_amd.h
+++ b/drivers/edac/mce_amd.h
@@ -5,8 +5,6 @@
=20
 #include <asm/mce.h>
=20
-#define BIT_64(n)			(U64_C(1) << (n))
-
 #define EC(x)				((x) & 0xffff)
 #define XEC(x, mask)			(((x) >> 16) & mask)
=20
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index f5cccd0edf56..c31014b40533 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -27,6 +27,7 @@
 #include <linux/vmalloc.h>
 #include <linux/hyperv.h>
 #include <asm/hyperv.h>
+#include <asm/nospec-branch.h>
 #include "hyperv_vmbus.h"
=20
 /* The one and only */
@@ -113,10 +114,13 @@ static u64 do_hypercall(u64 control, void *input, voi=
d *output)
 	u64 output_address =3D (output) ? virt_to_phys(output) : 0;
 	void *hypercall_page =3D hv_context.hypercall_page;
=20
-	__asm__ __volatile__("mov %0, %%r8" : : "r" (output_address) : "r8");
-	__asm__ __volatile__("call *%3" : "=3Da" (hv_status) :
-			     "c" (control), "d" (input_address),
-			     "m" (hypercall_page));
+	__asm__ __volatile__("mov %4, %%r8\n"
+			     CALL_NOSPEC
+			     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
+			       "+c" (control), "+d" (input_address)
+			     :  "r" (output_address),
+				THUNK_TARGET(hypercall_page)
+			     : "cc", "memory", "r8", "r9", "r10", "r11");
=20
 	return hv_status;
=20
@@ -134,11 +138,14 @@ static u64 do_hypercall(u64 control, void *input, voi=
d *output)
 	u32 output_address_lo =3D output_address & 0xFFFFFFFF;
 	void *hypercall_page =3D hv_context.hypercall_page;
=20
-	__asm__ __volatile__ ("call *%8" : "=3Dd"(hv_status_hi),
-			      "=3Da"(hv_status_lo) : "d" (control_hi),
-			      "a" (control_lo), "b" (input_address_hi),
-			      "c" (input_address_lo), "D"(output_address_hi),
-			      "S"(output_address_lo), "m" (hypercall_page));
+	__asm__ __volatile__(CALL_NOSPEC
+			     : "=3Dd" (hv_status_hi), "=3Da" (hv_status_lo),
+			       "+c" (input_address_lo), ASM_CALL_CONSTRAINT
+			     : "d" (control_hi), "a" (control_lo),
+			       "b" (input_address_hi),
+			       "D"(output_address_hi), "S"(output_address_lo),
+			       THUNK_TARGET(hypercall_page)
+			     : "cc", "memory");
=20
 	return hv_status_lo | ((u64)hv_status_hi << 32);
 #endif /* !x86_64 */
diff --git a/drivers/media/common/tuners/max2165.c b/drivers/media/common/t=
uners/max2165.c
index 9883617b7862..d5773bd0e2f2 100644
--- a/drivers/media/common/tuners/max2165.c
+++ b/drivers/media/common/tuners/max2165.c
@@ -168,7 +168,7 @@ int fixpt_div32(u32 dividend, u32 divisor, u32 *quotien=
t, u32 *fraction)
 	int i;
=20
 	if (0 =3D=3D divisor)
-		return -1;
+		return -EINVAL;
=20
 	q =3D dividend / divisor;
 	remainder =3D dividend - q * divisor;
@@ -194,10 +194,13 @@ static int max2165_set_rf(struct max2165_priv *priv, =
u32 freq)
 	u8 tf_ntch;
 	u32 t;
 	u32 quotient, fraction;
+	int ret;
=20
 	/* Set PLL divider according to RF frequency */
-	fixpt_div32(freq / 1000, priv->config->osc_clk * 1000,
-		&quotient, &fraction);
+	ret =3D fixpt_div32(freq / 1000, priv->config->osc_clk * 1000,
+			 &quotient, &fraction);
+	if (ret !=3D 0)
+		return ret;
=20
 	/* 20-bit fraction */
 	fraction >>=3D 12;
diff --git a/drivers/media/dvb/frontends/tda8261_cfg.h b/drivers/media/dvb/=
frontends/tda8261_cfg.h
index 1af1ee49b542..46710744173b 100644
--- a/drivers/media/dvb/frontends/tda8261_cfg.h
+++ b/drivers/media/dvb/frontends/tda8261_cfg.h
@@ -78,7 +78,7 @@ static int tda8261_get_bandwidth(struct dvb_frontend *fe,=
 u32 *bandwidth)
 			return err;
 		}
 		*bandwidth =3D t_state.bandwidth;
+		printk("%s: Bandwidth=3D%d\n", __func__, t_state.bandwidth);
 	}
-	printk("%s: Bandwidth=3D%d\n", __func__, t_state.bandwidth);
 	return 0;
 }
diff --git a/drivers/net/ethernet/realtek/atp.c b/drivers/net/ethernet/real=
tek/atp.c
index e3f57fdbf0ea..8c7dd4d005f0 100644
--- a/drivers/net/ethernet/realtek/atp.c
+++ b/drivers/net/ethernet/realtek/atp.c
@@ -176,8 +176,7 @@ struct net_local {
     unsigned int tx_unit_busy:1;
     unsigned char re_tx,	/* Number of packet retransmissions. */
 		addr_mode,		/* Current Rx filter e.g. promiscuous, etc. */
-		pac_cnt_in_tx_buf,
-		chip_type;
+		pac_cnt_in_tx_buf;
 };
=20
 /* This code, written by wwc@super.org, resets the adapter every
@@ -340,7 +339,6 @@ static int __init atp_probe1(long ioaddr)
 	write_reg_high(ioaddr, CMR1, CMR1h_RESET | CMR1h_MUX);
=20
 	lp =3D netdev_priv(dev);
-	lp->chip_type =3D RTL8002;
 	lp->addr_mode =3D CMR2h_Normal;
 	spin_lock_init(&lp->lock);
=20
@@ -853,7 +851,7 @@ net_close(struct net_device *dev)
  *	Set or clear the multicast filter for this adapter.
  */
=20
-static void set_rx_mode_8002(struct net_device *dev)
+static void set_rx_mode(struct net_device *dev)
 {
 	struct net_local *lp =3D netdev_priv(dev);
 	long ioaddr =3D dev->base_addr;
@@ -865,58 +863,6 @@ static void set_rx_mode_8002(struct net_device *dev)
 	write_reg_high(ioaddr, CMR2, lp->addr_mode);
 }
=20
-static void set_rx_mode_8012(struct net_device *dev)
-{
-	struct net_local *lp =3D netdev_priv(dev);
-	long ioaddr =3D dev->base_addr;
-	unsigned char new_mode, mc_filter[8]; /* Multicast hash filter */
-	int i;
-
-	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous. */
-		new_mode =3D CMR2h_PROMISC;
-	} else if ((netdev_mc_count(dev) > 1000) ||
-		   (dev->flags & IFF_ALLMULTI)) {
-		/* Too many to filter perfectly -- accept all multicasts. */
-		memset(mc_filter, 0xff, sizeof(mc_filter));
-		new_mode =3D CMR2h_Normal;
-	} else {
-		struct netdev_hw_addr *ha;
-
-		memset(mc_filter, 0, sizeof(mc_filter));
-		netdev_for_each_mc_addr(ha, dev) {
-			int filterbit =3D ether_crc_le(ETH_ALEN, ha->addr) & 0x3f;
-			mc_filter[filterbit >> 5] |=3D 1 << (filterbit & 31);
-		}
-		new_mode =3D CMR2h_Normal;
-	}
-	lp->addr_mode =3D new_mode;
-    write_reg(ioaddr, CMR2, CMR2_IRQOUT | 0x04); /* Switch to page 1. */
-    for (i =3D 0; i < 8; i++)
-		write_reg_byte(ioaddr, i, mc_filter[i]);
-	if (net_debug > 2 || 1) {
-		lp->addr_mode =3D 1;
-		printk(KERN_DEBUG "%s: Mode %d, setting multicast filter to",
-			   dev->name, lp->addr_mode);
-		for (i =3D 0; i < 8; i++)
-			printk(" %2.2x", mc_filter[i]);
-		printk(".\n");
-	}
-
-	write_reg_high(ioaddr, CMR2, lp->addr_mode);
-    write_reg(ioaddr, CMR2, CMR2_IRQOUT); /* Switch back to page 0 */
-}
-
-static void set_rx_mode(struct net_device *dev)
-{
-	struct net_local *lp =3D netdev_priv(dev);
-
-	if (lp->chip_type =3D=3D RTL8002)
-		return set_rx_mode_8002(dev);
-	else
-		return set_rx_mode_8012(dev);
-}
-
-
 static int __init atp_init_module(void) {
 	if (debug)					/* Emit version even if no cards detected. */
 		printk(KERN_INFO "%s", version);
diff --git a/drivers/net/ethernet/realtek/atp.h b/drivers/net/ethernet/real=
tek/atp.h
index 0edc642c2c2f..040b13739947 100644
--- a/drivers/net/ethernet/realtek/atp.h
+++ b/drivers/net/ethernet/realtek/atp.h
@@ -16,8 +16,6 @@ struct rx_header {
 #define PAR_STATUS	1
 #define PAR_CONTROL 2
=20
-enum chip_type { RTL8002, RTL8012 };
-
 #define Ctrl_LNibRead	0x08	/* LP_PSELECP */
 #define Ctrl_HNibRead	0
 #define Ctrl_LNibWrite	0x08	/* LP_PSELECP */
diff --git a/drivers/net/wireless/ath/ath6kl/hif.h b/drivers/net/wireless/a=
th/ath6kl/hif.h
index 797e2d1d9bf9..73e84e535adb 100644
--- a/drivers/net/wireless/ath/ath6kl/hif.h
+++ b/drivers/net/wireless/ath/ath6kl/hif.h
@@ -183,7 +183,7 @@ struct hif_scatter_req {
 	/* bounce buffer for upper layers to copy to/from */
 	u8 *virt_dma_buf;
=20
-	struct hif_scatter_item scat_list[1];
+	struct hif_scatter_item scat_list[0];
 };
=20
 struct ath6kl_hif_ops {
diff --git a/drivers/net/wireless/ath/ath6kl/sdio.c b/drivers/net/wireless/=
ath/ath6kl/sdio.c
index 066d4f88807f..edec7c7344d9 100644
--- a/drivers/net/wireless/ath/ath6kl/sdio.c
+++ b/drivers/net/wireless/ath/ath6kl/sdio.c
@@ -319,7 +319,7 @@ static int ath6kl_sdio_alloc_prep_scat_req(struct ath6k=
l_sdio *ar_sdio,
 	int i, scat_req_sz, scat_list_sz, sg_sz, buf_sz;
 	u8 *virt_buf;
=20
-	scat_list_sz =3D (n_scat_entry - 1) * sizeof(struct hif_scatter_item);
+	scat_list_sz =3D n_scat_entry * sizeof(struct hif_scatter_item);
 	scat_req_sz =3D sizeof(*s_req) + scat_list_sz;
=20
 	if (!virt_scat)
@@ -670,7 +670,7 @@ static int ath6kl_sdio_enable_scatter(struct ath6kl *ar)
 {
 	struct ath6kl_sdio *ar_sdio =3D ath6kl_sdio_priv(ar);
 	struct htc_target *target =3D ar->htc_target;
-	int ret;
+	int ret =3D 0;
 	bool virt_scat =3D false;
=20
 	/* check if host supports scatter and it meets our requirements */
diff --git a/drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c b/driver=
s/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c
index e4e326a5f9ab..adf99bed7c37 100644
--- a/drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c
@@ -2465,7 +2465,7 @@ static s32 brcmf_init_iscan(struct brcmf_cfg80211_pri=
v *cfg_priv)
 	return err;
 }
=20
-static void brcmf_delay(u32 ms)
+static __always_inline void brcmf_delay(u32 ms)
 {
 	if (ms < 1000 / HZ) {
 		cond_resched();
diff --git a/drivers/net/wireless/brcm80211/brcmsmac/aiutils.c b/drivers/ne=
t/wireless/brcm80211/brcmsmac/aiutils.c
index 025fa0eb6f47..68d0505921f7 100644
--- a/drivers/net/wireless/brcm80211/brcmsmac/aiutils.c
+++ b/drivers/net/wireless/brcm80211/brcmsmac/aiutils.c
@@ -1193,9 +1193,6 @@ void ai_detach(struct si_pub *sih)
 {
 	struct si_info *sii;
=20
-	struct si_pub *si_local =3D NULL;
-	memcpy(&si_local, &sih, sizeof(struct si_pub **));
-
 	sii =3D (struct si_info *)sih;
=20
 	if (sii =3D=3D NULL)
diff --git a/drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c b/drivers/ne=
t/wireless/rtlwifi/rtl8192c/dm_common.c
index ba7ef2fd4997..a9c725ed6a96 100644
--- a/drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c
+++ b/drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c
@@ -672,7 +672,8 @@ static void rtl92c_dm_txpower_tracking_callback_thermal=
meter(struct ieee80211_hw
 	u8 thermalvalue, delta, delta_lck, delta_iqk;
 	long ele_a, ele_d, temp_cck, val_x, value32;
 	long val_y, ele_c =3D 0;
-	u8 ofdm_index[2], cck_index =3D 0, ofdm_index_old[2], cck_index_old =3D 0;
+	u8 ofdm_index[2], ofdm_index_old[2] =3D {0, 0}, cck_index_old =3D 0;
+	s8 cck_index =3D 0;
 	int i;
 	bool is2t =3D IS_92C_SERIAL(rtlhal->version);
 	s8 txpwr_level[2] =3D {0, 0};
@@ -721,7 +722,7 @@ static void rtl92c_dm_txpower_tracking_callback_thermal=
meter(struct ieee80211_hw
 			for (i =3D 0; i < OFDM_TABLE_LENGTH; i++) {
 				if (ele_d =3D=3D (ofdmswing_table[i] &
 				    MASKOFDM_D)) {
-
+					ofdm_index_old[1] =3D (u8) i;
 					RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
 					   DBG_LOUD,
 					   ("Initial pathB ele_d reg0x%x =3D "
diff --git a/drivers/net/wireless/rtlwifi/rtl8192de/dm.c b/drivers/net/wire=
less/rtlwifi/rtl8192de/dm.c
index 3cd0736fe8e1..05f2c5313dd2 100644
--- a/drivers/net/wireless/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/rtlwifi/rtl8192de/dm.c
@@ -843,9 +843,9 @@ static void rtl92d_dm_txpower_tracking_callback_thermal=
meter(
 	long ele_a =3D 0, ele_d, temp_cck, val_x, value32;
 	long val_y, ele_c =3D 0;
 	u8 ofdm_index[2];
-	u8 cck_index =3D 0;
-	u8 ofdm_index_old[2];
-	u8 cck_index_old =3D 0;
+	s8 cck_index =3D 0;
+	u8 ofdm_index_old[2] =3D {0, 0};
+	s8 cck_index_old =3D 0;
 	u8 index;
 	int i;
 	bool is2t =3D IS_92D_SINGLEPHY(rtlhal->version);
diff --git a/drivers/net/wireless/rtlwifi/rtl8192se/phy.c b/drivers/net/wir=
eless/rtlwifi/rtl8192se/phy.c
index f10ac1ad9087..c336026e4faf 100644
--- a/drivers/net/wireless/rtlwifi/rtl8192se/phy.c
+++ b/drivers/net/wireless/rtlwifi/rtl8192se/phy.c
@@ -1254,6 +1254,9 @@ static void _rtl92s_phy_get_txpower_index(struct ieee=
80211_hw *hw, u8 channel,
 		/* Read HT 40 OFDM TX power */
 		ofdmpowerLevel[0] =3D rtlefuse->txpwrlevel_ht40_2s[0][index];
 		ofdmpowerLevel[1] =3D rtlefuse->txpwrlevel_ht40_2s[1][index];
+	} else {
+		ofdmpowerLevel[0] =3D 0;
+		ofdmpowerLevel[1] =3D 0;
 	}
 }
=20
diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-=
ng/p80211netdev.c
index 14bfeb2e704c..a8ca81e6f1d1 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -354,6 +354,8 @@ static int p80211knetdev_hard_start_xmit(struct sk_buff=
 *skb,
 	union p80211_hdr p80211_hdr;
 	struct p80211_metawep p80211_wep;
=20
+	p80211_wep.data =3D NULL;
+
 	if (skb =3D=3D NULL)
 		return NETDEV_TX_OK;
=20
diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_u=
sbhs/mod_gadget.c
index eb465621193b..674413ecd74f 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -76,9 +76,9 @@ struct usbhsg_recip_handle {
 		struct usbhsg_gpriv, mod)
=20
 #define __usbhsg_for_each_uep(start, pos, g, i)	\
-	for (i =3D start, pos =3D (g)->uep + i;	\
-	     i < (g)->uep_size;			\
-	     i++, pos =3D (g)->uep + i)
+	for ((i) =3D start;					\
+	     ((i) < (g)->uep_size) && ((pos) =3D (g)->uep + (i));	\
+	     (i)++)
=20
 #define usbhsg_for_each_uep(pos, gpriv, i)	\
 	__usbhsg_for_each_uep(1, pos, gpriv, i)
diff --git a/drivers/usb/renesas_usbhs/mod_host.c b/drivers/usb/renesas_usb=
hs/mod_host.c
index 7955de589951..b3a610ce3270 100644
--- a/drivers/usb/renesas_usbhs/mod_host.c
+++ b/drivers/usb/renesas_usbhs/mod_host.c
@@ -131,9 +131,9 @@ static const char usbhsh_hcd_name[] =3D "renesas_usbhs =
host";
 	__usbhsh_for_each_hpipe(0, pos, hpriv, i)
=20
 #define __usbhsh_for_each_udev(start, pos, h, i)	\
-	for (i =3D start, pos =3D (h)->udev + i;		\
-	     i < USBHSH_DEVICE_MAX;			\
-	     i++, pos =3D (h)->udev + i)
+	for ((i) =3D start;						\
+	     ((i) < USBHSH_DEVICE_MAX) && ((pos) =3D (h)->udev + (i));	\
+	     (i)++)
=20
 #define usbhsh_for_each_udev(pos, hpriv, i)	\
 	__usbhsh_for_each_udev(1, pos, hpriv, i)
diff --git a/drivers/usb/renesas_usbhs/pipe.h b/drivers/usb/renesas_usbhs/p=
ipe.h
index 6334fc644cc0..a00b67a0a134 100644
--- a/drivers/usb/renesas_usbhs/pipe.h
+++ b/drivers/usb/renesas_usbhs/pipe.h
@@ -54,9 +54,9 @@ struct usbhs_pipe_info {
  * pipe list
  */
 #define __usbhs_for_each_pipe(start, pos, info, i)	\
-	for (i =3D start, pos =3D (info)->pipe;		\
-	     i < (info)->size;				\
-	     i++, pos =3D (info)->pipe + i)
+	for ((i) =3D start;						\
+	     ((i) < (info)->size) && ((pos) =3D (info)->pipe + (i));	\
+	     (i)++)
=20
 #define usbhs_for_each_pipe(pos, priv, i)			\
 	__usbhs_for_each_pipe(1, pos, &((priv)->pipe_info), i)
diff --git a/fs/compat.c b/fs/compat.c
index 4bf082dbc273..4a03adb84f64 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -797,8 +797,9 @@ asmlinkage long compat_sys_mount(const char __user * de=
v_name,
 	char *dir_page;
 	int retval;
=20
-	retval =3D copy_mount_string(type, &kernel_type);
-	if (retval < 0)
+	kernel_type =3D copy_mount_string(type);
+	retval =3D PTR_ERR(kernel_type);
+	if (IS_ERR(kernel_type))
 		goto out;
=20
 	dir_page =3D getname(dir_name);
@@ -806,8 +807,9 @@ asmlinkage long compat_sys_mount(const char __user * de=
v_name,
 	if (IS_ERR(dir_page))
 		goto out1;
=20
-	retval =3D copy_mount_string(dev_name, &kernel_dev);
-	if (retval < 0)
+	kernel_dev =3D copy_mount_string(dev_name);
+	retval =3D PTR_ERR(kernel_dev);
+	if (IS_ERR(kernel_dev))
 		goto out2;
=20
 	retval =3D copy_mount_options(data, &data_page);
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index f854cf9355a8..d72deac465e3 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -608,7 +608,6 @@ struct serial_struct32 {
 static int serial_struct_ioctl(unsigned fd, unsigned cmd,
 			struct serial_struct32 __user *ss32)
 {
-        typedef struct serial_struct SS;
         typedef struct serial_struct32 SS32;
         int err;
         struct serial_struct ss;
diff --git a/fs/internal.h b/fs/internal.h
index fe327c20af83..03e1a1533d1c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -60,7 +60,7 @@ extern int check_unsafe_exec(struct linux_binprm *);
  * namespace.c
  */
 extern int copy_mount_options(const void __user *, unsigned long *);
-extern int copy_mount_string(const void __user *, char **);
+extern char *copy_mount_string(const void __user *);
=20
 extern unsigned int mnt_get_count(struct vfsmount *mnt);
 extern struct vfsmount *__lookup_mnt(struct vfsmount *, struct dentry *, i=
nt);
diff --git a/fs/namespace.c b/fs/namespace.c
index a1e663d781a2..a2adfcc5c90d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2253,21 +2253,9 @@ int copy_mount_options(const void __user * data, uns=
igned long *where)
 	return 0;
 }
=20
-int copy_mount_string(const void __user *data, char **where)
+char *copy_mount_string(const void __user *data)
 {
-	char *tmp;
-
-	if (!data) {
-		*where =3D NULL;
-		return 0;
-	}
-
-	tmp =3D strndup_user(data, PAGE_SIZE);
-	if (IS_ERR(tmp))
-		return PTR_ERR(tmp);
-
-	*where =3D tmp;
-	return 0;
+	return data ? strndup_user(data, PAGE_SIZE) : NULL;
 }
=20
 /*
@@ -2535,8 +2523,9 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char =
__user *, dir_name,
 	char *kernel_dev;
 	unsigned long data_page;
=20
-	ret =3D copy_mount_string(type, &kernel_type);
-	if (ret < 0)
+	kernel_type =3D copy_mount_string(type);
+	ret =3D PTR_ERR(kernel_type);
+	if (IS_ERR(kernel_type))
 		goto out_type;
=20
 	kernel_dir =3D getname(dir_name);
@@ -2545,8 +2534,9 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char =
__user *, dir_name,
 		goto out_dir;
 	}
=20
-	ret =3D copy_mount_string(dev_name, &kernel_dev);
-	if (ret < 0)
+	kernel_dev =3D copy_mount_string(dev_name);
+	ret =3D PTR_ERR(kernel_dev);
+	if (IS_ERR(kernel_dev))
 		goto out_dev;
=20
 	ret =3D copy_mount_options(data, &data_page);
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 87a375f4e051..29c2dfa2c150 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -4,8 +4,11 @@
=20
 #ifdef	__KERNEL__
 #define BIT(nr)			(1UL << (nr))
+#define BIT_ULL(nr)		(1ULL << (nr))
 #define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
+#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
+#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 21b1e9789a80..4583d615e90c 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -36,6 +36,13 @@ extern void cpu_remove_sysdev_attr_group(struct attribut=
e_group *attrs);
=20
 extern int sched_create_sysfs_power_savings_entries(struct sysdev_class *c=
ls);
=20
+ssize_t cpu_show_meltdown(struct sysdev_class *class,
+			  struct sysdev_class_attribute *attr, char *buf);
+ssize_t cpu_show_spectre_v1(struct sysdev_class *class,
+			    struct sysdev_class_attribute *attr, char *buf);
+ssize_t cpu_show_spectre_v2(struct sysdev_class *class,
+			    struct sysdev_class_attribute *attr, char *buf);
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
 extern ssize_t arch_cpu_probe(const char *, size_t);
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 82163c4b32c9..5a14de6a6f62 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
+#include <linux/nospec.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/fs.h>
@@ -85,8 +86,10 @@ static inline struct file * fcheck_files(struct files_st=
ruct *files, unsigned in
 	struct file * file =3D NULL;
 	struct fdtable *fdt =3D files_fdtable(files);
=20
-	if (fd < fdt->max_fds)
+	if (fd < fdt->max_fds) {
+		fd =3D array_index_nospec(fd, fdt->max_fds);
 		file =3D rcu_dereference_check_fdtable(files, fdt->fd[fd]);
+	}
 	return file;
 }
=20
diff --git a/include/linux/init.h b/include/linux/init.h
index 9146f39cdddf..13dfc98844fa 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -3,6 +3,13 @@
=20
 #include <linux/compiler.h>
=20
+/* Built-in __init functions needn't be compiled with retpoline */
+#if defined(RETPOLINE) && !defined(MODULE)
+#define __noretpoline __attribute__((indirect_branch("keep")))
+#else
+#define __noretpoline
+#endif
+
 /* These macros are used to mark some functions or=20
  * initialized data (doesn't apply to uninitialized data)
  * as `initialization' functions. The kernel can take this
@@ -40,7 +47,7 @@
=20
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(.init.text) __cold notrace
+#define __init		__section(.init.text) __cold notrace __noretpoline
 #define __initdata	__section(.init.data)
 #define __initconst	__section(.init.rodata)
 #define __exitdata	__section(.exit.data)
diff --git a/include/linux/kaiser.h b/include/linux/kaiser.h
index 58c55b1589d0..b56c19010480 100644
--- a/include/linux/kaiser.h
+++ b/include/linux/kaiser.h
@@ -32,7 +32,7 @@ static inline void kaiser_init(void)
 {
 }
 static inline int kaiser_add_mapping(unsigned long addr,
-				     unsigned long size, unsigned long flags)
+				     unsigned long size, u64 flags)
 {
 	return 0;
 }
diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
index 067eda0e4b32..4143edbce275 100644
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -4,29 +4,44 @@
 #include <generated/autoconf.h>
=20
 /*
- * Helper macros to use CONFIG_ options in C expressions. Note that
+ * Helper macros to use CONFIG_ options in C/CPP expressions. Note that
  * these only work with boolean and tristate options.
  */
=20
+/*
+ * Getting something that works in C and CPP for an arg that may or may
+ * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
+ * we match on the placeholder define, insert the "0," for arg1 and genera=
te
+ * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a =
one).
+ * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and w=
hen
+ * the last step cherry picks the 2nd arg, we get a zero.
+ */
+#define __ARG_PLACEHOLDER_1 0,
+#define config_enabled(cfg)		___is_defined(cfg)
+#define __is_defined(x)			___is_defined(x)
+#define ___is_defined(val)		____is_defined(__ARG_PLACEHOLDER_##val)
+#define ____is_defined(arg1_or_junk)	__take_second_arg(arg1_or_junk 1, 0)
+#define __take_second_arg(__ignored, val, ...) val
+
 /*
  * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm=
',
  * 0 otherwise.
  *
  */
 #define IS_ENABLED(option) \
-	(__enabled_ ## option || __enabled_ ## option ## _MODULE)
+	(config_enabled(option) || config_enabled(option##_MODULE))
=20
 /*
  * IS_BUILTIN(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y', 0
  * otherwise. For boolean options, this is equivalent to
  * IS_ENABLED(CONFIG_FOO).
  */
-#define IS_BUILTIN(option) __enabled_ ## option
+#define IS_BUILTIN(option) config_enabled(option)
=20
 /*
  * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
  * otherwise.
  */
-#define IS_MODULE(option) __enabled_ ## option ## _MODULE
+#define IS_MODULE(option) config_enabled(option##_MODULE)
=20
 #endif /* __LINUX_KCONFIG_H */
diff --git a/include/linux/module.h b/include/linux/module.h
index 3cb7839a60b9..509e8ad69f40 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -661,4 +661,13 @@ static inline void module_bug_finalize(const Elf_Ehdr =
*hdr,
 static inline void module_bug_cleanup(struct module *mod) {}
 #endif	/* CONFIG_GENERIC_BUG */
=20
+#ifdef RETPOLINE
+extern bool retpoline_module_ok(bool has_retpoline);
+#else
+static inline bool retpoline_module_ok(bool has_retpoline)
+{
+	return true;
+}
+#endif
+
 #endif /* _LINUX_MODULE_H */
diff --git a/include/linux/nospec.h b/include/linux/nospec.h
new file mode 100644
index 000000000000..4232e73f0b11
--- /dev/null
+++ b/include/linux/nospec.h
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright(c) 2018 Linus Torvalds. All rights reserved.
+// Copyright(c) 2018 Alexei Starovoitov. All rights reserved.
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+
+#ifndef _LINUX_NOSPEC_H
+#define _LINUX_NOSPEC_H
+#include <asm/system.h>
+
+/**
+ * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 oth=
erwise
+ * @index: array element index
+ * @size: number of elements in array
+ *
+ * When @index is out of bounds (@index >=3D @size), the sign bit will be
+ * set.  Extend the sign bit to all bits and invert, giving a result of
+ * zero for an out of bounds index, or ~0 if within bounds [0, @size).
+ */
+#ifndef array_index_mask_nospec
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+						    unsigned long size)
+{
+	/*
+	 * Always calculate and emit the mask even if the compiler
+	 * thinks the mask is not needed. The compiler does not take
+	 * into account the value of @index under speculation.
+	 */
+	OPTIMIZER_HIDE_VAR(index);
+	return ~(long)(index | (size - 1UL - index)) >> (BITS_PER_LONG - 1);
+}
+#endif
+
+/*
+ * array_index_nospec - sanitize an array index after a bounds check
+ *
+ * For a code sequence like:
+ *
+ *     if (index < size) {
+ *         index =3D array_index_nospec(index, size);
+ *         val =3D array[index];
+ *     }
+ *
+ * ...if the CPU speculates past the bounds check then
+ * array_index_nospec() will clamp the index within the range of [0,
+ * size).
+ */
+#define array_index_nospec(index, size)					\
+({									\
+	typeof(index) _i =3D (index);					\
+	typeof(size) _s =3D (size);					\
+	unsigned long _mask =3D array_index_mask_nospec(_i, _s);		\
+									\
+	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
+	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
+									\
+	_i &=3D _mask;							\
+	_i;								\
+})
+#endif /* _LINUX_NOSPEC_H */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_c=
ore.h
index 3779ea362257..b72437f9ee6a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -912,7 +912,6 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min,=
 u16 max,
 					u16 latency, u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
-void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
 void hci_le_ltk_neg_reply(struct hci_conn *conn);
=20
 #endif /* __HCI_CORE_H */
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index a92028196cc1..74ae965a2a04 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -46,4 +46,34 @@ config GCOV_PROFILE_ALL
 	larger and run slower. Also be sure to exclude files from profiling
 	which are not linked to the kernel image to prevent linker errors.
=20
+choice
+	prompt "Specify GCOV format"
+	depends on GCOV_KERNEL
+	default GCOV_FORMAT_AUTODETECT
+	---help---
+	The gcov format is usually determined by the GCC version, but there are
+	exceptions where format changes are integrated in lower-version GCCs.
+	In such a case use this option to adjust the format used in the kernel
+	accordingly.
+
+	If unsure, choose "Autodetect".
+
+config GCOV_FORMAT_AUTODETECT
+	bool "Autodetect"
+	---help---
+	Select this option to use the format that corresponds to your GCC
+	version.
+
+config GCOV_FORMAT_3_4
+	bool "GCC 3.4 format"
+	---help---
+	Select this option to use the format defined by GCC 3.4.
+
+config GCOV_FORMAT_4_7
+	bool "GCC 4.7 format"
+	---help---
+	Select this option to use the format defined by GCC 4.7.
+
+endchoice
+
 endmenu
diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
index e97ca59e2520..52aa7e8de927 100644
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -1,3 +1,33 @@
 ccflags-y :=3D -DSRCTREE=3D'"$(srctree)"' -DOBJTREE=3D'"$(objtree)"'
=20
-obj-$(CONFIG_GCOV_KERNEL) :=3D base.o fs.o gcc_3_4.o
+# if-lt
+# Usage VAR :=3D $(call if-lt, $(a), $(b))
+# Returns 1 if (a < b)
+if-lt =3D $(shell [ $(1) -lt $(2) ] && echo 1)
+
+ifeq ($(CONFIG_GCOV_FORMAT_3_4),y)
+  cc-ver :=3D 0304
+else ifeq ($(CONFIG_GCOV_FORMAT_4_7),y)
+  cc-ver :=3D 0407
+else
+# Use cc-version if available, otherwise set 0
+#
+# scripts/Kbuild.include, which contains cc-version function, is not inclu=
ded
+# during make clean "make -f scripts/Makefile.clean obj=3Dkernel/gcov"
+# Meaning cc-ver is empty causing if-lt test to fail with
+# "/bin/sh: line 0: [: -lt: unary operator expected" error mesage.
+# This has no affect on the clean phase, but the error message could be
+# confusing/annoying. So this dummy workaround sets cc-ver to zero if cc-v=
ersion
+# is not available. We can probably move if-lt to Kbuild.include, so it's =
also
+# not defined during clean or to include Kbuild.include in
+# scripts/Makefile.clean. But the following workaround seems least invasiv=
e.
+  cc-ver :=3D $(if $(call cc-version),$(call cc-version),0)
+endif
+
+obj-$(CONFIG_GCOV_KERNEL) :=3D base.o fs.o
+
+ifeq ($(call if-lt, $(cc-ver), 0407),1)
+  obj-$(CONFIG_GCOV_KERNEL) +=3D gcc_3_4.o
+else
+  obj-$(CONFIG_GCOV_KERNEL) +=3D gcc_4_7.o
+endif
diff --git a/kernel/gcov/base.c b/kernel/gcov/base.c
index 9b22d03cc581..b358a802fd18 100644
--- a/kernel/gcov/base.c
+++ b/kernel/gcov/base.c
@@ -20,7 +20,6 @@
 #include <linux/mutex.h>
 #include "gcov.h"
=20
-static struct gcov_info *gcov_info_head;
 static int gcov_events_enabled;
 static DEFINE_MUTEX(gcov_lock);
=20
@@ -34,7 +33,7 @@ void __gcov_init(struct gcov_info *info)
=20
 	mutex_lock(&gcov_lock);
 	if (gcov_version =3D=3D 0) {
-		gcov_version =3D info->version;
+		gcov_version =3D gcov_info_version(info);
 		/*
 		 * Printing gcc's version magic may prove useful for debugging
 		 * incompatibility reports.
@@ -45,8 +44,7 @@ void __gcov_init(struct gcov_info *info)
 	 * Add new profiling data structure to list and inform event
 	 * listener.
 	 */
-	info->next =3D gcov_info_head;
-	gcov_info_head =3D info;
+	gcov_info_link(info);
 	if (gcov_events_enabled)
 		gcov_event(GCOV_ADD, info);
 	mutex_unlock(&gcov_lock);
@@ -81,6 +79,18 @@ void __gcov_merge_delta(gcov_type *counters, unsigned in=
t n_counters)
 }
 EXPORT_SYMBOL(__gcov_merge_delta);
=20
+void __gcov_merge_ior(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_ior);
+
+void __gcov_merge_time_profile(gcov_type *counters, unsigned int n_counter=
s)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_time_profile);
+
 /**
  * gcov_enable_events - enable event reporting through gcov_event()
  *
@@ -91,13 +101,15 @@ EXPORT_SYMBOL(__gcov_merge_delta);
  */
 void gcov_enable_events(void)
 {
-	struct gcov_info *info;
+	struct gcov_info *info =3D NULL;
=20
 	mutex_lock(&gcov_lock);
 	gcov_events_enabled =3D 1;
+
 	/* Perform event callback for previously registered entries. */
-	for (info =3D gcov_info_head; info; info =3D info->next)
+	while ((info =3D gcov_info_next(info)))
 		gcov_event(GCOV_ADD, info);
+
 	mutex_unlock(&gcov_lock);
 }
=20
@@ -112,25 +124,23 @@ static int gcov_module_notifier(struct notifier_block=
 *nb, unsigned long event,
 				void *data)
 {
 	struct module *mod =3D data;
-	struct gcov_info *info;
-	struct gcov_info *prev;
+	struct gcov_info *info =3D NULL;
+	struct gcov_info *prev =3D NULL;
=20
 	if (event !=3D MODULE_STATE_GOING)
 		return NOTIFY_OK;
 	mutex_lock(&gcov_lock);
-	prev =3D NULL;
+
 	/* Remove entries located in module from linked list. */
-	for (info =3D gcov_info_head; info; info =3D info->next) {
+	while ((info =3D gcov_info_next(info))) {
 		if (within(info, mod->module_core, mod->core_size)) {
-			if (prev)
-				prev->next =3D info->next;
-			else
-				gcov_info_head =3D info->next;
+			gcov_info_unlink(prev, info);
 			if (gcov_events_enabled)
 				gcov_event(GCOV_REMOVE, info);
 		} else
 			prev =3D info;
 	}
+
 	mutex_unlock(&gcov_lock);
=20
 	return NOTIFY_OK;
diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 9bd0934f6c33..27e12ce30e7d 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -242,7 +242,7 @@ static struct gcov_node *get_node_by_name(const char *n=
ame)
=20
 	list_for_each_entry(node, &all_head, all) {
 		info =3D get_node_info(node);
-		if (info && (strcmp(info->filename, name) =3D=3D 0))
+		if (info && (strcmp(gcov_info_filename(info), name) =3D=3D 0))
 			return node;
 	}
=20
@@ -279,7 +279,7 @@ static ssize_t gcov_seq_write(struct file *file, const =
char __user *addr,
 	seq =3D file->private_data;
 	info =3D gcov_iter_get_info(seq->private);
 	mutex_lock(&node_lock);
-	node =3D get_node_by_name(info->filename);
+	node =3D get_node_by_name(gcov_info_filename(info));
 	if (node) {
 		/* Reset counts or remove node for unloaded modules. */
 		if (node->num_loaded =3D=3D 0)
@@ -376,8 +376,9 @@ static void add_links(struct gcov_node *node, struct de=
ntry *parent)
 	if (!node->links)
 		return;
 	for (i =3D 0; i < num; i++) {
-		target =3D get_link_target(get_node_info(node)->filename,
-					 &gcov_link[i]);
+		target =3D get_link_target(
+				gcov_info_filename(get_node_info(node)),
+				&gcov_link[i]);
 		if (!target)
 			goto out_err;
 		basename =3D strrchr(target, '/');
@@ -576,7 +577,7 @@ static void add_node(struct gcov_info *info)
 	struct gcov_node *parent;
 	struct gcov_node *node;
=20
-	filename =3D kstrdup(info->filename, GFP_KERNEL);
+	filename =3D kstrdup(gcov_info_filename(info), GFP_KERNEL);
 	if (!filename)
 		return;
 	parent =3D &root_node;
@@ -631,7 +632,7 @@ static void add_info(struct gcov_node *node, struct gco=
v_info *info)
 	loaded_info =3D kcalloc(num + 1, sizeof(struct gcov_info *), GFP_KERNEL);
 	if (!loaded_info) {
 		pr_warning("could not add '%s' (out of memory)\n",
-			   info->filename);
+			   gcov_info_filename(info));
 		return;
 	}
 	memcpy(loaded_info, node->loaded_info,
@@ -645,7 +646,8 @@ static void add_info(struct gcov_node *node, struct gco=
v_info *info)
 		 */
 		if (!gcov_info_is_compatible(node->unloaded_info, info)) {
 			pr_warning("discarding saved data for %s "
-				   "(incompatible version)\n", info->filename);
+				   "(incompatible version)\n",
+				   gcov_info_filename(info));
 			gcov_info_free(node->unloaded_info);
 			node->unloaded_info =3D NULL;
 		}
@@ -656,7 +658,7 @@ static void add_info(struct gcov_node *node, struct gco=
v_info *info)
 		 */
 		if (!gcov_info_is_compatible(node->loaded_info[0], info)) {
 			pr_warning("could not add '%s' (incompatible "
-				   "version)\n", info->filename);
+				   "version)\n", gcov_info_filename(info));
 			kfree(loaded_info);
 			return;
 		}
@@ -692,7 +694,8 @@ static void save_info(struct gcov_node *node, struct gc=
ov_info *info)
 		node->unloaded_info =3D gcov_info_dup(info);
 		if (!node->unloaded_info) {
 			pr_warning("could not save data for '%s' "
-				   "(out of memory)\n", info->filename);
+				   "(out of memory)\n",
+				   gcov_info_filename(info));
 		}
 	}
 }
@@ -708,7 +711,7 @@ static void remove_info(struct gcov_node *node, struct =
gcov_info *info)
 	i =3D get_info_index(node, info);
 	if (i < 0) {
 		pr_warning("could not remove '%s' (not found)\n",
-			   info->filename);
+			   gcov_info_filename(info));
 		return;
 	}
 	if (gcov_persist)
@@ -735,7 +738,7 @@ void gcov_event(enum gcov_action action, struct gcov_in=
fo *info)
 	struct gcov_node *node;
=20
 	mutex_lock(&node_lock);
-	node =3D get_node_by_name(info->filename);
+	node =3D get_node_by_name(gcov_info_filename(info));
 	switch (action) {
 	case GCOV_ADD:
 		if (node)
@@ -748,7 +751,7 @@ void gcov_event(enum gcov_action action, struct gcov_in=
fo *info)
 			remove_info(node, info);
 		else {
 			pr_warning("could not remove '%s' (not found)\n",
-				   info->filename);
+				   gcov_info_filename(info));
 		}
 		break;
 	}
diff --git a/kernel/gcov/gcc_3_4.c b/kernel/gcov/gcc_3_4.c
index ae5bb4260033..27bc88a35013 100644
--- a/kernel/gcov/gcc_3_4.c
+++ b/kernel/gcov/gcc_3_4.c
@@ -21,6 +21,121 @@
 #include <linux/vmalloc.h>
 #include "gcov.h"
=20
+#define GCOV_COUNTERS		5
+
+static struct gcov_info *gcov_info_head;
+
+/**
+ * struct gcov_fn_info - profiling meta data per function
+ * @ident: object file-unique function identifier
+ * @checksum: function checksum
+ * @n_ctrs: number of values per counter type belonging to this function
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time.
+ */
+struct gcov_fn_info {
+	unsigned int ident;
+	unsigned int checksum;
+	unsigned int n_ctrs[0];
+};
+
+/**
+ * struct gcov_ctr_info - profiling data per counter type
+ * @num: number of counter values for this type
+ * @values: array of counter values for this type
+ * @merge: merge function for counter values of this type (unused)
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time with the exception of the values array.
+ */
+struct gcov_ctr_info {
+	unsigned int	num;
+	gcov_type	*values;
+	void		(*merge)(gcov_type *, unsigned int);
+};
+
+/**
+ * struct gcov_info - profiling data per object file
+ * @version: gcov version magic indicating the gcc version used for compil=
ation
+ * @next: list head for a singly-linked list
+ * @stamp: time stamp
+ * @filename: name of the associated gcov data file
+ * @n_functions: number of instrumented functions
+ * @functions: function data
+ * @ctr_mask: mask specifying which counter types are active
+ * @counts: counter data per counter type
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time with the exception of the next pointer.
+ */
+struct gcov_info {
+	unsigned int			version;
+	struct gcov_info		*next;
+	unsigned int			stamp;
+	const char			*filename;
+	unsigned int			n_functions;
+	const struct gcov_fn_info	*functions;
+	unsigned int			ctr_mask;
+	struct gcov_ctr_info		counts[0];
+};
+
+/**
+ * gcov_info_filename - return info filename
+ * @info: profiling data set
+ */
+const char *gcov_info_filename(struct gcov_info *info)
+{
+	return info->filename;
+}
+
+/**
+ * gcov_info_version - return info version
+ * @info: profiling data set
+ */
+unsigned int gcov_info_version(struct gcov_info *info)
+{
+	return info->version;
+}
+
+/**
+ * gcov_info_next - return next profiling data set
+ * @info: profiling data set
+ *
+ * Returns next gcov_info following @info or first gcov_info in the chain =
if
+ * @info is %NULL.
+ */
+struct gcov_info *gcov_info_next(struct gcov_info *info)
+{
+	if (!info)
+		return gcov_info_head;
+
+	return info->next;
+}
+
+/**
+ * gcov_info_link - link/add profiling data set to the list
+ * @info: profiling data set
+ */
+void gcov_info_link(struct gcov_info *info)
+{
+	info->next =3D gcov_info_head;
+	gcov_info_head =3D info;
+}
+
+/**
+ * gcov_info_unlink - unlink/remove profiling data set from the list
+ * @prev: previous profiling data set
+ * @info: profiling data set
+ */
+void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
+{
+	if (prev)
+		prev->next =3D info->next;
+	else
+		gcov_info_head =3D info->next;
+}
+
 /* Symbolic links to be created for each profiling data file. */
 const struct gcov_link gcov_link[] =3D {
 	{ OBJ_TREE, "gcno" },	/* Link to .gcno file in $(objtree). */
diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
new file mode 100644
index 000000000000..826ba9fb5e32
--- /dev/null
+++ b/kernel/gcov/gcc_4_7.c
@@ -0,0 +1,565 @@
+/*
+ *  This code provides functions to handle gcc's profiling data format
+ *  introduced with gcc 4.7.
+ *
+ *  This file is based heavily on gcc_3_4.c file.
+ *
+ *  For a better understanding, refer to gcc source:
+ *  gcc/gcov-io.h
+ *  libgcc/libgcov.c
+ *
+ *  Uses gcc-internal data definitions.
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/seq_file.h>
+#include <linux/vmalloc.h>
+#include "gcov.h"
+
+#if __GNUC__ =3D=3D 4 && __GNUC_MINOR__ >=3D 9
+#define GCOV_COUNTERS			9
+#else
+#define GCOV_COUNTERS			8
+#endif
+
+#define GCOV_TAG_FUNCTION_LENGTH	3
+
+static struct gcov_info *gcov_info_head;
+
+/**
+ * struct gcov_ctr_info - information about counters for a single function
+ * @num: number of counter values for this type
+ * @values: array of counter values for this type
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time with the exception of the values array.
+ */
+struct gcov_ctr_info {
+	unsigned int num;
+	gcov_type *values;
+};
+
+/**
+ * struct gcov_fn_info - profiling meta data per function
+ * @key: comdat key
+ * @ident: unique ident of function
+ * @lineno_checksum: function lineo_checksum
+ * @cfg_checksum: function cfg checksum
+ * @ctrs: instrumented counters
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time.
+ *
+ * Information about a single function.  This uses the trailing array
+ * idiom. The number of counters is determined from the merge pointer
+ * array in gcov_info.  The key is used to detect which of a set of
+ * comdat functions was selected -- it points to the gcov_info object
+ * of the object file containing the selected comdat function.
+ */
+struct gcov_fn_info {
+	const struct gcov_info *key;
+	unsigned int ident;
+	unsigned int lineno_checksum;
+	unsigned int cfg_checksum;
+	struct gcov_ctr_info ctrs[0];
+};
+
+/**
+ * struct gcov_info - profiling data per object file
+ * @version: gcov version magic indicating the gcc version used for compil=
ation
+ * @next: list head for a singly-linked list
+ * @stamp: uniquifying time stamp
+ * @filename: name of the associated gcov data file
+ * @merge: merge functions (null for unused counter type)
+ * @n_functions: number of instrumented functions
+ * @functions: pointer to pointers to function information
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time with the exception of the next pointer.
+ */
+struct gcov_info {
+	unsigned int version;
+	struct gcov_info *next;
+	unsigned int stamp;
+	const char *filename;
+	void (*merge[GCOV_COUNTERS])(gcov_type *, unsigned int);
+	unsigned int n_functions;
+	struct gcov_fn_info **functions;
+};
+
+/**
+ * gcov_info_filename - return info filename
+ * @info: profiling data set
+ */
+const char *gcov_info_filename(struct gcov_info *info)
+{
+	return info->filename;
+}
+
+/**
+ * gcov_info_version - return info version
+ * @info: profiling data set
+ */
+unsigned int gcov_info_version(struct gcov_info *info)
+{
+	return info->version;
+}
+
+/**
+ * gcov_info_next - return next profiling data set
+ * @info: profiling data set
+ *
+ * Returns next gcov_info following @info or first gcov_info in the chain =
if
+ * @info is %NULL.
+ */
+struct gcov_info *gcov_info_next(struct gcov_info *info)
+{
+	if (!info)
+		return gcov_info_head;
+
+	return info->next;
+}
+
+/**
+ * gcov_info_link - link/add profiling data set to the list
+ * @info: profiling data set
+ */
+void gcov_info_link(struct gcov_info *info)
+{
+	info->next =3D gcov_info_head;
+	gcov_info_head =3D info;
+}
+
+/**
+ * gcov_info_unlink - unlink/remove profiling data set from the list
+ * @prev: previous profiling data set
+ * @info: profiling data set
+ */
+void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
+{
+	if (prev)
+		prev->next =3D info->next;
+	else
+		gcov_info_head =3D info->next;
+}
+
+/* Symbolic links to be created for each profiling data file. */
+const struct gcov_link gcov_link[] =3D {
+	{ OBJ_TREE, "gcno" },	/* Link to .gcno file in $(objtree). */
+	{ 0, NULL},
+};
+
+/*
+ * Determine whether a counter is active. Doesn't change at run-time.
+ */
+static int counter_active(struct gcov_info *info, unsigned int type)
+{
+	return info->merge[type] ? 1 : 0;
+}
+
+/* Determine number of active counters. Based on gcc magic. */
+static unsigned int num_counter_active(struct gcov_info *info)
+{
+	unsigned int i;
+	unsigned int result =3D 0;
+
+	for (i =3D 0; i < GCOV_COUNTERS; i++) {
+		if (counter_active(info, i))
+			result++;
+	}
+	return result;
+}
+
+/**
+ * gcov_info_reset - reset profiling data to zero
+ * @info: profiling data set
+ */
+void gcov_info_reset(struct gcov_info *info)
+{
+	struct gcov_ctr_info *ci_ptr;
+	unsigned int fi_idx;
+	unsigned int ct_idx;
+
+	for (fi_idx =3D 0; fi_idx < info->n_functions; fi_idx++) {
+		ci_ptr =3D info->functions[fi_idx]->ctrs;
+
+		for (ct_idx =3D 0; ct_idx < GCOV_COUNTERS; ct_idx++) {
+			if (!counter_active(info, ct_idx))
+				continue;
+
+			memset(ci_ptr->values, 0,
+					sizeof(gcov_type) * ci_ptr->num);
+			ci_ptr++;
+		}
+	}
+}
+
+/**
+ * gcov_info_is_compatible - check if profiling data can be added
+ * @info1: first profiling data set
+ * @info2: second profiling data set
+ *
+ * Returns non-zero if profiling data can be added, zero otherwise.
+ */
+int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *inf=
o2)
+{
+	return (info1->stamp =3D=3D info2->stamp);
+}
+
+/**
+ * gcov_info_add - add up profiling data
+ * @dest: profiling data set to which data is added
+ * @source: profiling data set which is added
+ *
+ * Adds profiling counts of @source to @dest.
+ */
+void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
+{
+	struct gcov_ctr_info *dci_ptr;
+	struct gcov_ctr_info *sci_ptr;
+	unsigned int fi_idx;
+	unsigned int ct_idx;
+	unsigned int val_idx;
+
+	for (fi_idx =3D 0; fi_idx < src->n_functions; fi_idx++) {
+		dci_ptr =3D dst->functions[fi_idx]->ctrs;
+		sci_ptr =3D src->functions[fi_idx]->ctrs;
+
+		for (ct_idx =3D 0; ct_idx < GCOV_COUNTERS; ct_idx++) {
+			if (!counter_active(src, ct_idx))
+				continue;
+
+			for (val_idx =3D 0; val_idx < sci_ptr->num; val_idx++)
+				dci_ptr->values[val_idx] +=3D
+					sci_ptr->values[val_idx];
+
+			dci_ptr++;
+			sci_ptr++;
+		}
+	}
+}
+
+/**
+ * gcov_info_dup - duplicate profiling data set
+ * @info: profiling data set to duplicate
+ *
+ * Return newly allocated duplicate on success, %NULL on error.
+ */
+struct gcov_info *gcov_info_dup(struct gcov_info *info)
+{
+	struct gcov_info *dup;
+	struct gcov_ctr_info *dci_ptr; /* dst counter info */
+	struct gcov_ctr_info *sci_ptr; /* src counter info */
+	unsigned int active;
+	unsigned int fi_idx; /* function info idx */
+	unsigned int ct_idx; /* counter type idx */
+	size_t fi_size; /* function info size */
+	size_t cv_size; /* counter values size */
+
+	dup =3D kmemdup(info, sizeof(*dup), GFP_KERNEL);
+	if (!dup)
+		return NULL;
+
+	dup->next =3D NULL;
+	dup->filename =3D NULL;
+	dup->functions =3D NULL;
+
+	dup->filename =3D kstrdup(info->filename, GFP_KERNEL);
+	if (!dup->filename)
+		goto err_free;
+
+	dup->functions =3D kcalloc(info->n_functions,
+				 sizeof(struct gcov_fn_info *), GFP_KERNEL);
+	if (!dup->functions)
+		goto err_free;
+
+	active =3D num_counter_active(info);
+	fi_size =3D sizeof(struct gcov_fn_info);
+	fi_size +=3D sizeof(struct gcov_ctr_info) * active;
+
+	for (fi_idx =3D 0; fi_idx < info->n_functions; fi_idx++) {
+		dup->functions[fi_idx] =3D kzalloc(fi_size, GFP_KERNEL);
+		if (!dup->functions[fi_idx])
+			goto err_free;
+
+		*(dup->functions[fi_idx]) =3D *(info->functions[fi_idx]);
+
+		sci_ptr =3D info->functions[fi_idx]->ctrs;
+		dci_ptr =3D dup->functions[fi_idx]->ctrs;
+
+		for (ct_idx =3D 0; ct_idx < active; ct_idx++) {
+
+			cv_size =3D sizeof(gcov_type) * sci_ptr->num;
+
+			dci_ptr->values =3D vmalloc(cv_size);
+
+			if (!dci_ptr->values)
+				goto err_free;
+
+			dci_ptr->num =3D sci_ptr->num;
+			memcpy(dci_ptr->values, sci_ptr->values, cv_size);
+
+			sci_ptr++;
+			dci_ptr++;
+		}
+	}
+
+	return dup;
+err_free:
+	gcov_info_free(dup);
+	return NULL;
+}
+
+/**
+ * gcov_info_free - release memory for profiling data set duplicate
+ * @info: profiling data set duplicate to free
+ */
+void gcov_info_free(struct gcov_info *info)
+{
+	unsigned int active;
+	unsigned int fi_idx;
+	unsigned int ct_idx;
+	struct gcov_ctr_info *ci_ptr;
+
+	if (!info->functions)
+		goto free_info;
+
+	active =3D num_counter_active(info);
+
+	for (fi_idx =3D 0; fi_idx < info->n_functions; fi_idx++) {
+		if (!info->functions[fi_idx])
+			continue;
+
+		ci_ptr =3D info->functions[fi_idx]->ctrs;
+
+		for (ct_idx =3D 0; ct_idx < active; ct_idx++, ci_ptr++)
+			vfree(ci_ptr->values);
+
+		kfree(info->functions[fi_idx]);
+	}
+
+free_info:
+	kfree(info->functions);
+	kfree(info->filename);
+	kfree(info);
+}
+
+#define ITER_STRIDE	PAGE_SIZE
+
+/**
+ * struct gcov_iterator - specifies current file position in logical recor=
ds
+ * @info: associated profiling data
+ * @buffer: buffer containing file data
+ * @size: size of buffer
+ * @pos: current position in file
+ */
+struct gcov_iterator {
+	struct gcov_info *info;
+	void *buffer;
+	size_t size;
+	loff_t pos;
+};
+
+/**
+ * store_gcov_u32 - store 32 bit number in gcov format to buffer
+ * @buffer: target buffer or NULL
+ * @off: offset into the buffer
+ * @v: value to be stored
+ *
+ * Number format defined by gcc: numbers are recorded in the 32 bit
+ * unsigned binary form of the endianness of the machine generating the
+ * file. Returns the number of bytes stored. If @buffer is %NULL, doesn't
+ * store anything.
+ */
+static size_t store_gcov_u32(void *buffer, size_t off, u32 v)
+{
+	u32 *data;
+
+	if (buffer) {
+		data =3D buffer + off;
+		*data =3D v;
+	}
+
+	return sizeof(*data);
+}
+
+/**
+ * store_gcov_u64 - store 64 bit number in gcov format to buffer
+ * @buffer: target buffer or NULL
+ * @off: offset into the buffer
+ * @v: value to be stored
+ *
+ * Number format defined by gcc: numbers are recorded in the 32 bit
+ * unsigned binary form of the endianness of the machine generating the
+ * file. 64 bit numbers are stored as two 32 bit numbers, the low part
+ * first. Returns the number of bytes stored. If @buffer is %NULL, doesn't=
 store
+ * anything.
+ */
+static size_t store_gcov_u64(void *buffer, size_t off, u64 v)
+{
+	u32 *data;
+
+	if (buffer) {
+		data =3D buffer + off;
+
+		data[0] =3D (v & 0xffffffffUL);
+		data[1] =3D (v >> 32);
+	}
+
+	return sizeof(*data) * 2;
+}
+
+/**
+ * convert_to_gcda - convert profiling data set to gcda file format
+ * @buffer: the buffer to store file data or %NULL if no data should be st=
ored
+ * @info: profiling data set to be converted
+ *
+ * Returns the number of bytes that were/would have been stored into the b=
uffer.
+ */
+static size_t convert_to_gcda(char *buffer, struct gcov_info *info)
+{
+	struct gcov_fn_info *fi_ptr;
+	struct gcov_ctr_info *ci_ptr;
+	unsigned int fi_idx;
+	unsigned int ct_idx;
+	unsigned int cv_idx;
+	size_t pos =3D 0;
+
+	/* File header. */
+	pos +=3D store_gcov_u32(buffer, pos, GCOV_DATA_MAGIC);
+	pos +=3D store_gcov_u32(buffer, pos, info->version);
+	pos +=3D store_gcov_u32(buffer, pos, info->stamp);
+
+	for (fi_idx =3D 0; fi_idx < info->n_functions; fi_idx++) {
+		fi_ptr =3D info->functions[fi_idx];
+
+		/* Function record. */
+		pos +=3D store_gcov_u32(buffer, pos, GCOV_TAG_FUNCTION);
+		pos +=3D store_gcov_u32(buffer, pos, GCOV_TAG_FUNCTION_LENGTH);
+		pos +=3D store_gcov_u32(buffer, pos, fi_ptr->ident);
+		pos +=3D store_gcov_u32(buffer, pos, fi_ptr->lineno_checksum);
+		pos +=3D store_gcov_u32(buffer, pos, fi_ptr->cfg_checksum);
+
+		ci_ptr =3D fi_ptr->ctrs;
+
+		for (ct_idx =3D 0; ct_idx < GCOV_COUNTERS; ct_idx++) {
+			if (!counter_active(info, ct_idx))
+				continue;
+
+			/* Counter record. */
+			pos +=3D store_gcov_u32(buffer, pos,
+					      GCOV_TAG_FOR_COUNTER(ct_idx));
+			pos +=3D store_gcov_u32(buffer, pos, ci_ptr->num * 2);
+
+			for (cv_idx =3D 0; cv_idx < ci_ptr->num; cv_idx++) {
+				pos +=3D store_gcov_u64(buffer, pos,
+						      ci_ptr->values[cv_idx]);
+			}
+
+			ci_ptr++;
+		}
+	}
+
+	return pos;
+}
+
+/**
+ * gcov_iter_new - allocate and initialize profiling data iterator
+ * @info: profiling data set to be iterated
+ *
+ * Return file iterator on success, %NULL otherwise.
+ */
+struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
+{
+	struct gcov_iterator *iter;
+
+	iter =3D kzalloc(sizeof(struct gcov_iterator), GFP_KERNEL);
+	if (!iter)
+		goto err_free;
+
+	iter->info =3D info;
+	/* Dry-run to get the actual buffer size. */
+	iter->size =3D convert_to_gcda(NULL, info);
+	iter->buffer =3D vmalloc(iter->size);
+	if (!iter->buffer)
+		goto err_free;
+
+	convert_to_gcda(iter->buffer, info);
+
+	return iter;
+
+err_free:
+	kfree(iter);
+	return NULL;
+}
+
+
+/**
+ * gcov_iter_get_info - return profiling data set for given file iterator
+ * @iter: file iterator
+ */
+void gcov_iter_free(struct gcov_iterator *iter)
+{
+	vfree(iter->buffer);
+	kfree(iter);
+}
+
+/**
+ * gcov_iter_get_info - return profiling data set for given file iterator
+ * @iter: file iterator
+ */
+struct gcov_info *gcov_iter_get_info(struct gcov_iterator *iter)
+{
+	return iter->info;
+}
+
+/**
+ * gcov_iter_start - reset file iterator to starting position
+ * @iter: file iterator
+ */
+void gcov_iter_start(struct gcov_iterator *iter)
+{
+	iter->pos =3D 0;
+}
+
+/**
+ * gcov_iter_next - advance file iterator to next logical record
+ * @iter: file iterator
+ *
+ * Return zero if new position is valid, non-zero if iterator has reached =
end.
+ */
+int gcov_iter_next(struct gcov_iterator *iter)
+{
+	if (iter->pos < iter->size)
+		iter->pos +=3D ITER_STRIDE;
+
+	if (iter->pos >=3D iter->size)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * gcov_iter_write - write data for current pos to seq_file
+ * @iter: file iterator
+ * @seq: seq_file handle
+ *
+ * Return zero on success, non-zero otherwise.
+ */
+int gcov_iter_write(struct gcov_iterator *iter, struct seq_file *seq)
+{
+	size_t len;
+
+	if (iter->pos >=3D iter->size)
+		return -EINVAL;
+
+	len =3D ITER_STRIDE;
+	if (iter->pos + len > iter->size)
+		len =3D iter->size - iter->pos;
+
+	seq_write(seq, iter->buffer + iter->pos, len);
+
+	return 0;
+}
diff --git a/kernel/gcov/gcov.h b/kernel/gcov/gcov.h
index 060073ebf7a6..92c8e22a29ed 100644
--- a/kernel/gcov/gcov.h
+++ b/kernel/gcov/gcov.h
@@ -21,7 +21,6 @@
  * gcc and need to be kept as close to the original definition as possible=
 to
  * remain compatible.
  */
-#define GCOV_COUNTERS		5
 #define GCOV_DATA_MAGIC		((unsigned int) 0x67636461)
 #define GCOV_TAG_FUNCTION	((unsigned int) 0x01000000)
 #define GCOV_TAG_COUNTER_BASE	((unsigned int) 0x01a10000)
@@ -34,60 +33,18 @@ typedef long gcov_type;
 typedef long long gcov_type;
 #endif
=20
-/**
- * struct gcov_fn_info - profiling meta data per function
- * @ident: object file-unique function identifier
- * @checksum: function checksum
- * @n_ctrs: number of values per counter type belonging to this function
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time.
- */
-struct gcov_fn_info {
-	unsigned int ident;
-	unsigned int checksum;
-	unsigned int n_ctrs[0];
-};
-
-/**
- * struct gcov_ctr_info - profiling data per counter type
- * @num: number of counter values for this type
- * @values: array of counter values for this type
- * @merge: merge function for counter values of this type (unused)
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time with the exception of the values array.
- */
-struct gcov_ctr_info {
-	unsigned int	num;
-	gcov_type	*values;
-	void		(*merge)(gcov_type *, unsigned int);
-};
+/* Opaque gcov_info. The gcov structures can change as for example in gcc =
4.7 so
+ * we cannot use full definition here and they need to be placed in gcc sp=
ecific
+ * implementation of gcov. This also means no direct access to the members=
 in
+ * generic code and usage of the interface below.*/
+struct gcov_info;
=20
-/**
- * struct gcov_info - profiling data per object file
- * @version: gcov version magic indicating the gcc version used for compil=
ation
- * @next: list head for a singly-linked list
- * @stamp: time stamp
- * @filename: name of the associated gcov data file
- * @n_functions: number of instrumented functions
- * @functions: function data
- * @ctr_mask: mask specifying which counter types are active
- * @counts: counter data per counter type
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time with the exception of the next pointer.
- */
-struct gcov_info {
-	unsigned int			version;
-	struct gcov_info		*next;
-	unsigned int			stamp;
-	const char			*filename;
-	unsigned int			n_functions;
-	const struct gcov_fn_info	*functions;
-	unsigned int			ctr_mask;
-	struct gcov_ctr_info		counts[0];
-};
+/* Interface to access gcov_info data  */
+const char *gcov_info_filename(struct gcov_info *info);
+unsigned int gcov_info_version(struct gcov_info *info);
+struct gcov_info *gcov_info_next(struct gcov_info *info);
+void gcov_info_link(struct gcov_info *info);
+void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info);
=20
 /* Base interface. */
 enum gcov_action {
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a4f561a3f27f..ec1748679b45 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -53,6 +53,9 @@
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
 #include <asm/uaccess.h>
+#ifdef CONFIG_RETPOLINE
+#include <asm/nospec-branch.h>
+#endif
=20
 #define KPROBE_HASH_BITS 6
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
@@ -99,6 +102,11 @@ static struct kprobe_blackpoint kprobe_blacklist[] =3D {
 	{"irq_entries_start",},
 	{"common_interrupt",},
 	{"mcount",},	/* mcount can be called from everywhere */
+#ifdef CONFIG_RETPOLINE
+	{"__indirect_thunk_start",
+	 /* Linker scripts can't set symbol sizes */
+	 .range =3D (size_t)__indirect_thunk_size},
+#endif
 	{NULL}    /* Terminator */
 };
=20
@@ -1986,7 +1994,7 @@ static int __init init_kprobes(void)
 				&size, &offset, &modname, namebuf);
 		if (!symbol_name)
 			kb->range =3D 0;
-		else
+		else if (size)
 			kb->range =3D size;
 	}
=20
diff --git a/kernel/module.c b/kernel/module.c
index 8d2f37d7a75d..7bc1aed0d07f 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2335,6 +2335,15 @@ static inline void kmemleak_load_module(const struct=
 module *mod,
 }
 #endif
=20
+static void check_modinfo_retpoline(struct module *mod, struct load_info *=
info)
+{
+	if (retpoline_module_ok(get_modinfo(info, "retpoline")))
+		return;
+
+	pr_warn("%s: loading module not compiled with retpoline compiler.\n",
+		mod->name);
+}
+
 /* Sets info->hdr and info->len. */
 static int copy_and_check(struct load_info *info,
 			  const void __user *umod, unsigned long len,
@@ -2495,6 +2504,8 @@ static int check_modinfo(struct module *mod, struct l=
oad_info *info)
 	if (!get_modinfo(info, "intree"))
 		add_taint_module(mod, TAINT_OOT_MODULE);
=20
+	check_modinfo_retpoline(mod, info);
+
 	if (get_modinfo(info, "staging")) {
 		add_taint_module(mod, TAINT_CRAP);
 		printk(KERN_WARNING "%s: module is from the staging directory,"
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f45664580671..b2b440406669 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -225,22 +225,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ed=
iv, __u8 rand[8],
 }
 EXPORT_SYMBOL(hci_le_start_enc);
=20
-void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16])
-{
-	struct hci_dev *hdev =3D conn->hdev;
-	struct hci_cp_le_ltk_reply cp;
-
-	BT_DBG("%p", conn);
-
-	memset(&cp, 0, sizeof(cp));
-
-	cp.handle =3D cpu_to_le16(conn->handle);
-	memcpy(cp.ltk, ltk, sizeof(ltk));
-
-	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
-}
-EXPORT_SYMBOL(hci_le_ltk_reply);
-
 void hci_le_ltk_neg_reply(struct hci_conn *conn)
 {
 	struct hci_dev *hdev =3D conn->hdev;
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index dc5748f3e384..cd23f828e1eb 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -28,9 +28,9 @@
=20
=20
 /* Are we using CONFIG_MODVERSIONS? */
-int modversions =3D 0;
+static int modversions =3D 0;
 /* Warn about undefined symbols? (do so if we have vmlinux) */
-int have_vmlinux =3D 0;
+static int have_vmlinux =3D 0;
 /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
 static int all_versions =3D 0;
 /* If we are modposting external module set to 1 */
@@ -225,7 +225,7 @@ static struct symbol *find_symbol(const char *name)
 	return NULL;
 }
=20
-static struct {
+static const struct {
 	const char *str;
 	enum export export;
 } export_list[] =3D {
@@ -816,7 +816,7 @@ static int match(const char *sym, const char * const pa=
t[])
 }
=20
 /* sections that we do not want to do full section mismatch check on */
-static const char *section_white_list[] =3D
+static const char *const section_white_list[] =3D
 {
 	".comment*",
 	".debug*",
@@ -876,6 +876,8 @@ static void check_section(const char *modname, struct e=
lf_info *elf,
=20
 #define DATA_SECTIONS ".data$", ".data.rel$"
 #define TEXT_SECTIONS ".text$"
+#define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
+		".fixup", ".entry.text"
=20
 #define INIT_SECTIONS      ".init.*"
 #define DEV_INIT_SECTIONS  ".devinit.*"
@@ -887,18 +889,25 @@ static void check_section(const char *modname, struct=
 elf_info *elf,
 #define CPU_EXIT_SECTIONS  ".cpuexit.*"
 #define MEM_EXIT_SECTIONS  ".memexit.*"
=20
+#define ALL_TEXT_SECTIONS  ALL_INIT_TEXT_SECTIONS, ALL_EXIT_TEXT_SECTIONS,=
 \
+		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
+
 /* init data sections */
-static const char *init_data_sections[] =3D { ALL_INIT_DATA_SECTIONS, NULL=
 };
+static const char *const init_data_sections[] =3D
+	{ ALL_INIT_DATA_SECTIONS, NULL };
=20
 /* all init sections */
-static const char *init_sections[] =3D { ALL_INIT_SECTIONS, NULL };
+static const char *const init_sections[] =3D { ALL_INIT_SECTIONS, NULL };
=20
 /* All init and exit sections (code + data) */
-static const char *init_exit_sections[] =3D
+static const char *const init_exit_sections[] =3D
 	{ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS, NULL };
=20
+/* all text sections */
+static const char *const text_sections[] =3D { ALL_TEXT_SECTIONS, NULL };
+
 /* data section */
-static const char *data_sections[] =3D { DATA_SECTIONS, NULL };
+static const char *const data_sections[] =3D { DATA_SECTIONS, NULL };
=20
=20
 /* symbols in .data that may refer to init/exit sections */
@@ -912,9 +921,10 @@ static const char *data_sections[] =3D { DATA_SECTIONS=
, NULL };
 	"*_probe_one",							\
 	"*_console"
=20
-static const char *head_sections[] =3D { ".head.text*", NULL };
-static const char *linker_symbols[] =3D
+static const char *const head_sections[] =3D { ".head.text*", NULL };
+static const char *const linker_symbols[] =3D
 	{ "__init_begin", "_sinittext", "_einittext", NULL };
+static const char *const optim_symbols[] =3D { "*.constprop.*", NULL };
=20
 enum mismatch {
 	TEXT_TO_ANY_INIT,
@@ -935,7 +945,7 @@ struct sectioncheck {
 	const char *symbol_white_list[20];
 };
=20
-const struct sectioncheck sectioncheck[] =3D {
+static const struct sectioncheck sectioncheck[] =3D {
 /* Do not reference init/exit code/data from
  * normal code and data
  */
@@ -1096,6 +1106,17 @@ static const struct sectioncheck *section_mismatch(
  *   This pattern is identified by
  *   refsymname =3D __init_begin, _sinittext, _einittext
  *
+ * Pattern 5:
+ *   GCC may optimize static inlines when fed constant arg(s) resulting
+ *   in functions like cpumask_empty() -- generating an associated symbol
+ *   cpumask_empty.constprop.3 that appears in the audit.  If the const th=
at
+ *   is passed in comes from __init, like say nmi_ipi_mask, we get a
+ *   meaningless section warning.  May need to add isra symbols too...
+ *   This pattern is identified by
+ *   tosec   =3D init section
+ *   fromsec =3D text section
+ *   refsymname =3D *.constprop.*
+ *
  **/
 static int secref_whitelist(const struct sectioncheck *mismatch,
 			    const char *fromsec, const char *fromsym,
@@ -1128,6 +1149,12 @@ static int secref_whitelist(const struct sectionchec=
k *mismatch,
 	if (match(tosym, linker_symbols))
 		return 0;
=20
+	/* Check for pattern 5 */
+	if (match(fromsec, text_sections) &&
+	    match(tosec, init_sections) &&
+	    match(fromsym, optim_symbols))
+		return 0;
+
 	return 1;
 }
=20
@@ -1862,6 +1889,14 @@ static void add_intree_flag(struct buffer *b, int is=
_intree)
 		buf_printf(b, "\nMODULE_INFO(intree, \"Y\");\n");
 }
=20
+/* Cannot check for assembler */
+static void add_retpoline(struct buffer *b)
+{
+	buf_printf(b, "\n#ifdef RETPOLINE\n");
+	buf_printf(b, "MODULE_INFO(retpoline, \"Y\");\n");
+	buf_printf(b, "#endif\n");
+}
+
 static void add_staging_flag(struct buffer *b, const char *name)
 {
 	static const char *staging_dir =3D "drivers/staging";
@@ -2183,6 +2218,7 @@ int main(int argc, char **argv)
=20
 		add_header(&buf, mod);
 		add_intree_flag(&buf, !external_module);
+		add_retpoline(&buf);
 		add_staging_flag(&buf, mod->name);
 		err |=3D add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 72b20b1089df..bc069d5e2fee 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1806,7 +1806,7 @@ static int security_preserve_bools(struct policydb *p=
);
  */
 int security_load_policy(void *data, size_t len)
 {
-	struct policydb oldpolicydb, newpolicydb;
+	struct policydb *oldpolicydb, *newpolicydb;
 	struct sidtab oldsidtab, newsidtab;
 	struct selinux_mapping *oldmap, *map =3D NULL;
 	struct convert_context_args args;
@@ -1815,12 +1815,19 @@ int security_load_policy(void *data, size_t len)
 	int rc =3D 0;
 	struct policy_file file =3D { data, len }, *fp =3D &file;
=20
+	oldpolicydb =3D kzalloc(2 * sizeof(*oldpolicydb), GFP_KERNEL);
+	if (!oldpolicydb) {
+		rc =3D -ENOMEM;
+		goto out;
+	}
+	newpolicydb =3D oldpolicydb + 1;
+
 	if (!ss_initialized) {
 		avtab_cache_init();
 		rc =3D policydb_read(&policydb, fp);
 		if (rc) {
 			avtab_cache_destroy();
-			return rc;
+			goto out;
 		}
=20
 		policydb.len =3D len;
@@ -1830,14 +1837,14 @@ int security_load_policy(void *data, size_t len)
 		if (rc) {
 			policydb_destroy(&policydb);
 			avtab_cache_destroy();
-			return rc;
+			goto out;
 		}
=20
 		rc =3D policydb_load_isids(&policydb, &sidtab);
 		if (rc) {
 			policydb_destroy(&policydb);
 			avtab_cache_destroy();
-			return rc;
+			goto out;
 		}
=20
 		security_load_policycaps();
@@ -1849,36 +1856,36 @@ int security_load_policy(void *data, size_t len)
 		selinux_status_update_policyload(seqno);
 		selinux_netlbl_cache_invalidate();
 		selinux_xfrm_notify_policyload();
-		return 0;
+		goto out;
 	}
=20
 #if 0
 	sidtab_hash_eval(&sidtab, "sids");
 #endif
=20
-	rc =3D policydb_read(&newpolicydb, fp);
+	rc =3D policydb_read(newpolicydb, fp);
 	if (rc)
-		return rc;
+		goto out;
=20
-	newpolicydb.len =3D len;
+	newpolicydb->len =3D len;
 	/* If switching between different policy types, log MLS status */
-	if (policydb.mls_enabled && !newpolicydb.mls_enabled)
+	if (policydb.mls_enabled && !newpolicydb->mls_enabled)
 		printk(KERN_INFO "SELinux: Disabling MLS support...\n");
-	else if (!policydb.mls_enabled && newpolicydb.mls_enabled)
+	else if (!policydb.mls_enabled && newpolicydb->mls_enabled)
 		printk(KERN_INFO "SELinux: Enabling MLS support...\n");
=20
-	rc =3D policydb_load_isids(&newpolicydb, &newsidtab);
+	rc =3D policydb_load_isids(newpolicydb, &newsidtab);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to load the initial SIDs\n");
-		policydb_destroy(&newpolicydb);
-		return rc;
+		policydb_destroy(newpolicydb);
+		goto out;
 	}
=20
-	rc =3D selinux_set_mapping(&newpolicydb, secclass_map, &map, &map_size);
+	rc =3D selinux_set_mapping(newpolicydb, secclass_map, &map, &map_size);
 	if (rc)
 		goto err;
=20
-	rc =3D security_preserve_bools(&newpolicydb);
+	rc =3D security_preserve_bools(newpolicydb);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to preserve booleans\n");
 		goto err;
@@ -1896,7 +1903,7 @@ int security_load_policy(void *data, size_t len)
 	 * in the new SID table.
 	 */
 	args.oldp =3D &policydb;
-	args.newp =3D &newpolicydb;
+	args.newp =3D newpolicydb;
 	rc =3D sidtab_map(&newsidtab, convert_context, &args);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to convert the internal"
@@ -1906,12 +1913,12 @@ int security_load_policy(void *data, size_t len)
 	}
=20
 	/* Save the old policydb and SID table to free later. */
-	memcpy(&oldpolicydb, &policydb, sizeof policydb);
+	memcpy(oldpolicydb, &policydb, sizeof(policydb));
 	sidtab_set(&oldsidtab, &sidtab);
=20
 	/* Install the new policydb and SID table. */
 	write_lock_irq(&policy_rwlock);
-	memcpy(&policydb, &newpolicydb, sizeof policydb);
+	memcpy(&policydb, newpolicydb, sizeof(policydb));
 	sidtab_set(&sidtab, &newsidtab);
 	security_load_policycaps();
 	oldmap =3D current_mapping;
@@ -1921,7 +1928,7 @@ int security_load_policy(void *data, size_t len)
 	write_unlock_irq(&policy_rwlock);
=20
 	/* Free the old policydb and SID table. */
-	policydb_destroy(&oldpolicydb);
+	policydb_destroy(oldpolicydb);
 	sidtab_destroy(&oldsidtab);
 	kfree(oldmap);
=20
@@ -1931,14 +1938,17 @@ int security_load_policy(void *data, size_t len)
 	selinux_netlbl_cache_invalidate();
 	selinux_xfrm_notify_policyload();
=20
-	return 0;
+	rc =3D 0;
+	goto out;
=20
 err:
 	kfree(map);
 	sidtab_destroy(&newsidtab);
-	policydb_destroy(&newpolicydb);
-	return rc;
+	policydb_destroy(newpolicydb);
=20
+out:
+	kfree(oldpolicydb);
+	return rc;
 }
=20
 size_t security_policydb_len(void)

--Qgof7w7UksPF5inF--

--o+ZCuNqY+dEAKBWl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWrAnSOe/yOyVhhEJAQojyg//falTZ2ZTFwezgZViSItsgzLihwnXUErT
pnjJ26qbTsjHrwABv4zB4baHXZMSgmBYI4SCDmRmPUHuibKE0aESHufRGV3Rz5i9
s6hgH3bO0PBHnQm8WjmYXshpT3Xw5TGPzqdLuW4kG3tN6a1e35edEyg0SJdQfg6t
/VIxldu4aO4dqSVR+FJzMvScBZR8qZEMsVUjn+hU4EgKtbA86SVSaz86lxFCXk9g
EHIzxDRVKLqjNGPBkRHvhTpEJKsGIpsEjP5P4q61bp2dhEB0ms5pqw4Ftku6bggZ
vdsT5gDw/PpJuH+He9+x6nAUjytXxzd25lhXfExSNKC0H29J99WEGvLSYHcyoF2b
vZX1UUpVGCLcVPLYuS3Q+QjnG3gBKCYB4UD6a5ojkrBMXqYjdt3PJm/QeHJhFJa+
5qJCDjZk1VC1SkQQ4P83yCkJWto4VFQDE3scg59irzdqklPgdh8z3FyPvoX3zXhC
CJ/BLCKYsin0ppL+RcjCAx9s4+VSG0tlfcb5bgi30Ft/ccP2XnjrIrelltLRqdL9
n7HWAujjyVswuhBGU4vmy4GJxv1m4ZQZnWb3BWWveKaahzgf4lk3aE7RJe98GKae
bK68AxKuvheX3PwmpGaZTOAPAwUUQYs2thNSPRGoVccczpsUIFyBTwfXePS5bIcx
OsygE3Xj0YI=
=IUA6
-----END PGP SIGNATURE-----

--o+ZCuNqY+dEAKBWl--
