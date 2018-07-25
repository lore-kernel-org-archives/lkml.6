Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BCFC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF4420843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF4420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbeGYOx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:53:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbeGYOx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:53:29 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7B96CE90;
        Wed, 25 Jul 2018 13:41:43 +0000 (UTC)
Date:   Wed, 25 Jul 2018 15:41:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.144
Message-ID: <20180725134140.GA11744@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.144 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu |    1=20
 Documentation/kernel-parameters.txt                |   45 ++
 Documentation/spec_ctrl.txt                        |   94 ++++
 Makefile                                           |    2=20
 arch/arc/include/asm/page.h                        |    2=20
 arch/arc/include/asm/pgtable.h                     |    2=20
 arch/x86/entry/entry_64_compat.S                   |   75 ++-
 arch/x86/include/asm/apm.h                         |    6=20
 arch/x86/include/asm/barrier.h                     |    2=20
 arch/x86/include/asm/cpufeature.h                  |    7=20
 arch/x86/include/asm/cpufeatures.h                 |   37 +
 arch/x86/include/asm/disabled-features.h           |    3=20
 arch/x86/include/asm/efi.h                         |    7=20
 arch/x86/include/asm/intel-family.h                |   10=20
 arch/x86/include/asm/irqflags.h                    |    2=20
 arch/x86/include/asm/mmu.h                         |   15=20
 arch/x86/include/asm/mmu_context.h                 |   25 -
 arch/x86/include/asm/msr-index.h                   |   22 +
 arch/x86/include/asm/nospec-branch.h               |   54 ++
 arch/x86/include/asm/required-features.h           |    3=20
 arch/x86/include/asm/spec-ctrl.h                   |   80 +++
 arch/x86/include/asm/thread_info.h                 |    6=20
 arch/x86/include/asm/tlbflush.h                    |   12=20
 arch/x86/kernel/Makefile                           |    1=20
 arch/x86/kernel/cpu/amd.c                          |   38 +
 arch/x86/kernel/cpu/bugs.c                         |  427 ++++++++++++++++=
+++--
 arch/x86/kernel/cpu/common.c                       |  121 +++++
 arch/x86/kernel/cpu/cpu.h                          |    3=20
 arch/x86/kernel/cpu/intel.c                        |   73 +++
 arch/x86/kernel/cpu/mcheck/mce.c                   |    3=20
 arch/x86/kernel/irqflags.S                         |   26 +
 arch/x86/kernel/ldt.c                              |    4=20
 arch/x86/kernel/process.c                          |  224 +++++++++--
 arch/x86/kernel/smpboot.c                          |    5=20
 arch/x86/kvm/svm.c                                 |    2=20
 arch/x86/kvm/vmx.c                                 |    2=20
 arch/x86/mm/tlb.c                                  |   33 +
 arch/x86/platform/efi/efi_64.c                     |    3=20
 arch/x86/xen/enlighten.c                           |   16=20
 arch/x86/xen/smp.c                                 |    5=20
 arch/x86/xen/suspend.c                             |   16=20
 block/blk-core.c                                   |   10=20
 drivers/base/cpu.c                                 |    8=20
 drivers/clk/tegra/clk-tegra30.c                    |   11=20
 drivers/mtd/ubi/attach.c                           |  139 +++++-
 drivers/mtd/ubi/eba.c                              |    4=20
 drivers/mtd/ubi/fastmap-wl.c                       |    6=20
 drivers/mtd/ubi/fastmap.c                          |   51 ++
 drivers/mtd/ubi/ubi.h                              |   46 ++
 drivers/mtd/ubi/wl.c                               |  114 ++++-
 drivers/net/ethernet/broadcom/tg3.c                |    9=20
 drivers/net/phy/phy_device.c                       |    7=20
 drivers/ptp/ptp_chardev.c                          |    1=20
 drivers/usb/host/xhci.c                            |   40 +
 drivers/usb/host/xhci.h                            |    4=20
 fs/fat/inode.c                                     |   20=20
 fs/proc/array.c                                    |   26 +
 include/linux/cpu.h                                |    2=20
 include/linux/nospec.h                             |   10=20
 include/linux/sched.h                              |    9=20
 include/linux/seccomp.h                            |    3=20
 include/linux/skbuff.h                             |   12=20
 include/net/ipv6.h                                 |    2=20
 include/uapi/linux/prctl.h                         |   12=20
 include/uapi/linux/seccomp.h                       |    4=20
 kernel/seccomp.c                                   |   21 -
 kernel/sys.c                                       |   21 +
 lib/rhashtable.c                                   |   17=20
 mm/memcontrol.c                                    |    2=20
 net/core/skbuff.c                                  |    1=20
 net/ipv4/fib_frontend.c                            |    1=20
 net/ipv4/sysctl_net_ipv4.c                         |    5=20
 sound/core/rawmidi.c                               |   20=20
 tools/testing/selftests/seccomp/seccomp_bpf.c      |   98 ++++
 virt/kvm/eventfd.c                                 |    6=20
 75 files changed, 1981 insertions(+), 275 deletions(-)

Alan Jenkins (1):
      block: do not use interruptible wait anywhere

Alexander Sergeyev (1):
      x86/speculation: Remove Skylake C2 from Speculation Control microcode=
 blacklist

Alexey Brodkin (1):
      ARC: Fix CONFIG_SWAP

Andy Lutomirski (2):
      x86/mm: Give each mm TLB flush generation a unique ID
      x86/cpu: Re-apply forced caps every time CPU caps are re-read

Andy Shevchenko (1):
      x86/cpu: Rename Merrifield2 to Moorefield

Arnd Bergmann (1):
      x86/pti: Mark constant arrays as __initconst

Borislav Petkov (4):
      Documentation/spec_ctrl: Do some minor cleanups
      x86/speculation: Use synthetic bits for IBRS/IBPB/STIBP
      x86/cpu/AMD: Fix erratum 1076 (CPB bit)
      x86/bugs: Unify x86_spec_ctrl_{set_guest, restore_host}

Colin Ian King (1):
      ipv6: fix useless rol32 call on hash

Dan Williams (2):
      x86/entry/64/compat: Clear registers for compat syscalls, to reduce s=
peculation attack surface
      x86/speculation: Fix up array_index_nospec_mask() asm constraint

Dave Hansen (1):
      x86/mm: Factor out LDT init from context init

David Ahern (1):
      net/ipv4: Set oif in fib_compute_spec_dst

David Woodhouse (14):
      x86/cpufeatures: Add CPUID_7_EDX CPUID leaf
      x86/cpufeatures: Add Intel feature bits for Speculation Control
      x86/cpufeatures: Add AMD feature bits for Speculation Control
      x86/msr: Add definitions for new speculation control MSRs
      x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdo=
wn
      x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early Spectre v2 micr=
ocodes
      x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) =
support
      x86/cpufeatures: Clean up Spectre v2 related CPUID flags
      x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP feature bits on Intel
      x86/speculation: Update Speculation Control microcode blacklist
      x86/speculation: Correct Speculation Control microcode blacklist again
      x86/speculation: Use IBRS if available before calling into firmware
      x86/amd: don't set X86_BUG_SYSRET_SS_ATTRS when running under Xen
      x86/bugs/AMD: Add support to disable RDS on Fam[15, 16, 17]h if reque=
sted

Davidlohr Bueso (1):
      lib/rhashtable: consider param->min_size when setting initial table s=
ize

Denys Vlasenko (1):
      x86/asm/entry/32: Simplify pushes of zeroed pt_regs->REGs

Dewet Thibaut (1):
      x86/MCE: Remove min interval polling limitation

Greg Kroah-Hartman (1):
      Linux 4.4.144

Gustavo A. R. Silva (1):
      ptp: fix missing break in switch

Heiner Kallweit (1):
      net: phy: fix flag masking in __set_phy_supported

Ingo Molnar (2):
      x86/speculation: Clean up various Spectre related details
      x86/speculation: Move firmware_restrict_branch_speculation_*() from C=
 to CPP

Jim Mattson (1):
      x86/cpu: Make alternative_msr_write work for 32-bit code

Jing Xia (1):
      mm: memcg: fix use after free in mem_cgroup_iter()

Jiri Kosina (2):
      x86/bugs: Fix __ssb_select_mitigation() return type
      x86/bugs: Make cpu_show_common() static

Juergen Gross (3):
      x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend
      xen: set cpu capabilities from xen_start_kernel()
      x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths

Kees Cook (5):
      nospec: Allow getting/setting on non-current task
      proc: Provide details on speculation flaw mitigations
      seccomp: Enable speculation flaw mitigations
      seccomp: Add filter flag to opt-out of SSB mitigation
      x86/speculation: Make "seccomp" the default mode for Speculative Stor=
e Bypass

Konrad Rzeszutek Wilk (14):
      x86/spectre_v2: Don't check microcode versions when running under hyp=
ervisors
      x86/bugs: Concentrate bug detection into a separate function
      x86/bugs: Concentrate bug reporting into a separate function
      x86/bugs: Read SPEC_CTRL MSR during boot and re-use reserved bits
      x86/bugs, KVM: Support the combination of guest and host IBRS
      x86/bugs: Expose /sys/../spec_store_bypass
      x86/cpufeatures: Add X86_FEATURE_RDS
      x86/bugs: Provide boot parameters for the spec_store_bypass_disable m=
itigation
      x86/bugs/intel: Set proper CPU features and setup RDS
      x86/bugs: Whitelist allowed SPEC_CTRL MSR values
      x86/bugs: Rename _RDS to _SSBD
      proc: Use underscores for SSBD in 'status'
      x86/bugs: Fix the parameters alignment and missing void
      x86/bugs: Rename SSBD_NO to SSB_NO

Kyle Huey (2):
      x86/process: Optimize TIF checks in __switch_to_xtra()
      x86/process: Correct and optimize TIF_BLOCKSTEP switch

Lan Tianyu (1):
      KVM/Eventfd: Avoid crash when assign and deassign specific eventfd in=
 parallel.

Linus Torvalds (1):
      x86/nospec: Simplify alternative_msr_write()

Lucas Stach (1):
      clk: tegra: Fix PLL_U post divider and initial rate on Tegra30

Mathias Nyman (1):
      xhci: Fix perceived dead host due to runtime suspend race with event =
handler

Micka=EBl Sala=FCn (2):
      selftest/seccomp: Fix the flag name SECCOMP_FILTER_FLAG_TSYNC
      selftest/seccomp: Fix the seccomp(2) signature

Nick Desaulniers (1):
      x86/paravirt: Make native_save_fl() extern inline

OGAWA Hirofumi (1):
      fat: fix memory allocation failure handling of match_strdup()

Peter Zijlstra (1):
      x86/speculation: Add <asm/msr-index.h> dependency

Piotr Luc (1):
      x86/cpu/intel: Add Knights Mill to Intel family

Richard Weinberger (5):
      ubi: Introduce vol_ignored()
      ubi: Rework Fastmap attach base code
      ubi: Be more paranoid while seaching for the most recent Fastmap
      ubi: Fix races around ubi_refill_pools()
      ubi: Fix Fastmap's update_vol()

Sanjeev Bansal (1):
      tg3: Add higher cpu clock for 5762.

Sascha Hauer (1):
      ubi: fastmap: Erase outdated anchor PEBs during attach

Stefano Brivio (2):
      net: Don't copy pfmemalloc flag in __copy_skb_header()
      skbuff: Unconditionally copy pfmemalloc in __skb_clone()

Takashi Iwai (1):
      ALSA: rawmidi: Change resized buffers atomically

Thomas Gleixner (18):
      x86/speculation: Create spec-ctrl.h to avoid include hell
      prctl: Add speculation control prctls
      x86/process: Optimize TIF_NOTSC switch
      x86/process: Allow runtime control of Speculative Store Bypass
      x86/speculation: Add prctl for Speculative Store Bypass mitigation
      prctl: Add force disable speculation
      seccomp: Use PR_SPEC_FORCE_DISABLE
      seccomp: Move speculation migitation control to arch code
      x86/cpufeatures: Disentangle MSR_SPEC_CTRL enumeration from IBRS
      x86/cpufeatures: Disentangle SSBD enumeration
      x86/cpufeatures: Add FEATURE_ZEN
      x86/speculation: Handle HT correctly on AMD
      x86/bugs, KVM: Extend speculation control for VIRT_SPEC_CTRL
      x86/speculation: Rework speculative_store_bypass_update()
      x86/bugs: Expose x86_spec_ctrl_base directly
      x86/bugs: Remove x86_spec_ctrl_set()
      x86/bugs: Rework spec_ctrl base and mask logic
      x86/speculation, KVM: Implement support for VIRT_SPEC_CTRL/LS_CFG

Tim Chen (1):
      x86/speculation: Use Indirect Branch Prediction Barrier in context sw=
itch

Tom Lendacky (1):
      x86/speculation: Add virtualized speculative store bypass disable sup=
port

Tyler Hicks (1):
      ipv4: Return EINVAL when ping_group_range sysctl doesn't map to user =
ns

Vineet Gupta (1):
      ARC: mm: allow mprotect to make stack mappings executable


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltYfhEACgkQONu9yGCS
aT4DMRAAsm3l46LHbk0Z+TeT0HxdB0gSuCviZsJT2RBZDNShJWXCp2XlcpooeRoQ
oTDFaNOLTKcdW6r7YhqIRsfgoCAGvFc1YClIe0vRm9NMW9uJdmJq3574MRzhm+wC
+24kYnRINAsL9zDa42PPAH+N60oX8U662mccUUR4uQV34Tyxx4e+NSMAlYbG9u+z
EY6+Qkli6G56cEjYvIAY5jtrZUpvp2Z0PusxeuQxwsu/OdbIb84HJyhCJzICf3eB
5iqJeoYMWYLCrcMfjsx7AVVw3+nfabb+5FnP129NxXW/MP+1BRjYoD+TYEKHiBXZ
TvTwWevIosySoeFBqS+xzJBegjlUGMZGoLnN2wctDBR15BsaCOgsjJxkPbMhy3kA
6WSpZPCu7gTlhBPLraQsq4O+BzyKOan7/D/TyEkpe4+tEAsshvP3b3TNZUFuaDJl
pAjFA5fY9ZHPTAWILYzQVXttrAw90Biy8dttXto5Q5mq0EyhVIyuIk4BaA03i69V
FRSfXM/UYIlioa6/O4u7LTBUBXLFEQfRRgI7+tY5PZ3iPNt/1Xhr5QiYEKi+Uu5a
o4trjXNvnI8S4Nq+bKRxqimCek4JSvQsyMzL9sl8DF0ZBAclQD0NiUwh5UJcaQu4
ZPMNhXQtCYojhJ9DlVGi52vEF/xD7IBoDvlgTJdneUWTmPzCQR4=
=LsIp
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
