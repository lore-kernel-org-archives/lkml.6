Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF23C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F64F216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F64F216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbeI1EXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:23:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42305 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbeI1EXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:23:30 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g5eN6-0007dC-DR; Thu, 27 Sep 2018 23:03:01 +0100
Date:   Thu, 27 Sep 2018 23:02:56 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>,
        stable@vger.kernel.org
Cc:     lwn@lwn.net
Message-ID: <20180927220256.GH4765@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qLni7iB6Dl8qUSwk"
Content-Disposition: inline
X-Mailer: LinuxStableQueue (scripts by bwh)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: Linux 3.16.58
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qLni7iB6Dl8qUSwk
Content-Type: multipart/mixed; boundary="gTtJ75FAzB1T2CN6"
Content-Disposition: inline


--gTtJ75FAzB1T2CN6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.16.58 kernel.

All users of the 3.16 kernel series should upgrade.

The updated 3.16.y git tree can be found at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
=2Egit linux-3.16.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git

The diff from 3.16.57 is attached to this message.

Ben.

------------

 Makefile                              |   2 +-
 arch/Kconfig                          |   1 +
 arch/x86/include/asm/intel-family.h   |   1 +
 arch/x86/include/asm/kvm_emulate.h    |   6 +-
 arch/x86/include/uapi/asm/msr-index.h |   1 +
 arch/x86/kernel/cpu/amd.c             |  13 +++
 arch/x86/kernel/cpu/bugs.c            |  59 ++++----------
 arch/x86/kernel/cpu/common.c          |  17 ++--
 arch/x86/kernel/entry_64.S            |  13 +--
 arch/x86/kernel/i387.c                |  24 ++++++
 arch/x86/kernel/paravirt.c            |  14 +++-
 arch/x86/kernel/process.c             |  62 +++++++++------
 arch/x86/kernel/xsave.c               |  24 +-----
 arch/x86/kvm/emulate.c                |  76 ++++++++++--------
 arch/x86/kvm/vmx.c                    |  20 +++--
 arch/x86/kvm/x86.c                    |  91 ++++++++++++++-------
 arch/x86/kvm/x86.h                    |   4 +-
 arch/x86/syscalls/syscall_32.tbl      |   1 +
 arch/x86/syscalls/syscall_64.tbl      |   1 +
 drivers/cdrom/cdrom.c                 |   2 +-
 drivers/infiniband/core/ucma.c        |   6 +-
 drivers/scsi/libsas/sas_scsi_host.c   |  33 +++-----
 drivers/scsi/sg.c                     |   2 +-
 drivers/scsi/sr_ioctl.c               |  21 ++---
 drivers/staging/usbip/stub.h          |   2 +
 drivers/staging/usbip/stub_dev.c      |  69 +++++++++-------
 drivers/staging/usbip/stub_main.c     | 100 +++++++++++++++++++++--
 drivers/usb/misc/yurex.c              |  23 ++----
 drivers/usb/storage/uas.c             |   8 +-
 drivers/video/fbdev/uvesafb.c         |   3 +-
 fs/btrfs/relocation.c                 |  23 +++---
 fs/ext4/balloc.c                      |  21 +++--
 fs/ext4/ext4.h                        |   8 --
 fs/ext4/ext4_extents.h                |   1 +
 fs/ext4/extents.c                     |   6 ++
 fs/ext4/ialloc.c                      |  19 ++++-
 fs/ext4/inline.c                      |  39 +--------
 fs/ext4/inode.c                       |   3 +-
 fs/ext4/mballoc.c                     |   6 +-
 fs/ext4/super.c                       |  41 +++++++++-
 fs/ext4/xattr.c                       |  49 ++++++------
 fs/hfsplus/dir.c                      |   4 +-
 fs/inode.c                            |   6 ++
 fs/jbd2/transaction.c                 |   2 +-
 fs/jfs/xattr.c                        |  10 ++-
 fs/xfs/xfs_attr_leaf.c                |   5 +-
 fs/xfs/xfs_bmap.c                     |   2 +
 fs/xfs/xfs_icache.c                   |  58 ++++++++++++--
 include/linux/mm_types.h              |   2 +-
 include/linux/sched.h                 |   2 +-
 include/linux/syscalls.h              |   2 +
 include/linux/vmacache.h              |   5 --
 include/uapi/asm-generic/unistd.h     |   4 +-
 include/uapi/linux/seccomp.h          |   4 +
 kernel/futex.c                        |  99 +++++++++++++++++++++--
 kernel/seccomp.c                      | 146 ++++++++++++++++++++++++++++--=
----
 kernel/sys_ni.c                       |   3 +
 mm/vmacache.c                         |  36 ---------
 net/bluetooth/hidp/core.c             |   4 +-
 net/core/sock.c                       |   2 +
 net/ipv4/ip_vti.c                     |   1 +
 sound/core/rawmidi.c                  |  20 +++--
 62 files changed, 846 insertions(+), 486 deletions(-)

Alexander Potapenko (1):
      scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()

Alexey Khoroshilov (1):
      usbip: fix error handling in stub_probe()

Andy Lutomirski (1):
      x86/entry/64: Remove %ebx handling from error_entry/exit

Ben Hutchings (3):
      x86/fpu: Default eagerfpu if FPU and FXSR are enabled
      Revert "vti4: Don't override MTU passed on link creation via IFLA_MTU"
      Linux 3.16.58

Borislav Petkov (1):
      x86/cpu/AMD: Fix erratum 1076 (CPB bit)

Christoph Paasch (1):
      net: Set sk_prot_creator when cloning sockets to the right proto

Cong Wang (1):
      infiniband: fix a possible use-after-free bug

Dave Chinner (2):
      xfs: catch inode allocation state mismatch corruption
      xfs: validate cached inodes are free when allocated

Eric Sandeen (2):
      xfs: set format back to extents if xfs_bmap_extents_to_btree
      xfs: don't call xfs_da_shrink_inode with NULL bp

Ernesto A. Fern=E1ndez (1):
      hfsplus: fix NULL dereference in hfsplus_lookup()

Ingo Molnar (2):
      x86/fpu: Fix the 'nofxsr' boot parameter to also clear X86_FEATURE_FX=
SR_OPT
      x86/speculation: Clean up various Spectre related details

Jann Horn (1):
      USB: yurex: fix out-of-bounds uaccess in read handler

Jason Yan (1):
      scsi: libsas: defer ata device eh commands to libata

Jens Axboe (1):
      sr: pass down correctly sized SCSI sense buffer

Jiri Kosina (1):
      x86/speculation: Protect against userspace-userspace spectreRSB

Kees Cook (5):
      video: uvesafb: Fix integer overflow in allocation
      seccomp: create internal mode-setting function
      seccomp: extract check/assign mode helpers
      seccomp: split mode setting routines
      seccomp: add "seccomp" syscall

Kyle Huey (2):
      x86/process: Optimize TIF checks in __switch_to_xtra()
      x86/process: Correct and optimize TIF_BLOCKSTEP switch

Linus Torvalds (2):
      Fix up non-directory creation in SGID directories
      mm: get rid of vmacache_flush_all() entirely

Mark Salyzyn (1):
      Bluetooth: hidp: buffer overflow in hidp_process_report

Mel Gorman (2):
      futex: Remove requirement for lock_page() in get_futex_key()
      futex: Remove unnecessary warning from get_futex_key

Nadav Amit (1):
      KVM: x86: Emulator ignores LDTR/TR extended base on LLDT/LTR

Paolo Bonzini (4):
      KVM: x86: introduce linear_{read,write}_system
      KVM: x86: pass kvm_vcpu to kvm_read_guest_virt and kvm_write_guest_vi=
rt_system
      kvm: x86: use correct privilege level for sgdt/sidt/fxsave/fxrstor ac=
cess
      KVM: x86: introduce num_emulated_msrs

Peter Zijlstra (1):
      x86/paravirt: Fix spectre-v2 mitigations for paravirt guests

Piotr Luc (1):
      x86/cpu/intel: Add Knights Mill to Intel family

Qu Wenruo (1):
      btrfs: relocation: Only remove reloc rb_trees if reloc control has be=
en initialized

Sanjeev Sharma (1):
      uas: replace WARN_ON_ONCE() with lockdep_assert_held()

Scott Bauer (1):
      cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status

Shankara Pailoor (1):
      jfs: Fix inconsistency between memory allocation and ea_buf->max_size

Shuah Khan (2):
      usbip: usbip_host: fix to hold parent lock for device_attach() calls
      usbip: usbip_host: refine probe and disconnect debug msgs to be useful

Shuah Khan (Samsung OSG) (4):
      usbip: usbip_host: delete device from busid_table after rebind
      usbip: usbip_host: run rebind from exit when module is removed
      usbip: usbip_host: fix NULL-ptr deref and use-after-free errors
      usbip: usbip_host: fix bad unlock balance during stub_probe()

Takashi Iwai (1):
      ALSA: rawmidi: Change resized buffers atomically

Theodore Ts'o (14):
      ext4: only look at the bg_flags field if it is valid
      ext4: fix check to prevent initializing reserved inodes
      ext4: verify the depth of extent tree in ext4_find_extent()
      ext4: always check block group bounds in ext4_init_block_bitmap()
      ext4: don't allow r/w mounts if metadata blocks overlap the superblock
      ext4: make sure bitmaps and the inode table don't overlap with bg des=
criptors
      ext4: fix false negatives *and* false positives in ext4_check_descrip=
tors()
      ext4: add corruption check in ext4_xattr_set_entry()
      ext4: always verify the magic number in xattr blocks
      ext4: never move the system.data xattr out of the inode body
      ext4: clear i_data in ext4_inode_info when removing inline data
      ext4: add more inode number paranoia checks
      jbd2: don't mark block as modified if the handle is out of credits
      ext4: avoid running out of journal credits when appending to an inlin=
e file


--gTtJ75FAzB1T2CN6
Content-Type: text/x-diff; charset=UTF-8; name="linux-3.16.58.patch"
Content-Disposition: attachment; filename="linux-3.16.58.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/Makefile b/Makefile
index 4cf98f68a826..82b947eb9bcf 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION =3D 3
 PATCHLEVEL =3D 16
-SUBLEVEL =3D 57
+SUBLEVEL =3D 58
 EXTRAVERSION =3D
 NAME =3D Museum of Fishiegoodies
=20
diff --git a/arch/Kconfig b/arch/Kconfig
index 97ff872c7acc..0eae9df35b88 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -321,6 +321,7 @@ config HAVE_ARCH_SECCOMP_FILTER
 	  - secure_computing is called from a ptrace_event()-safe context
 	  - secure_computing return value is checked and a return value of -1
 	    results in the system call being skipped immediately.
+	  - seccomp syscall wired up
=20
 config SECCOMP_FILTER
 	def_bool y
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/int=
el-family.h
index caa8ccb7587b..40661857e0eb 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -67,5 +67,6 @@
 /* Xeon Phi */
=20
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
+#define INTEL_FAM6_XEON_PHI_KNM		0x85 /* Knights Mill */
=20
 #endif /* _ASM_X86_INTEL_FAMILY_H */
diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_=
emulate.h
index c10f7175bef3..8a37c3b7302b 100644
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -104,11 +104,12 @@ struct x86_emulate_ops {
 	 *  @addr:  [IN ] Linear address from which to read.
 	 *  @val:   [OUT] Value read from memory, zero-extended to 'u_long'.
 	 *  @bytes: [IN ] Number of bytes to read from memory.
+	 *  @system:[IN ] Whether the access is forced to be at CPL0.
 	 */
 	int (*read_std)(struct x86_emulate_ctxt *ctxt,
 			unsigned long addr, void *val,
 			unsigned int bytes,
-			struct x86_exception *fault);
+			struct x86_exception *fault, bool system);
=20
 	/*
 	 * write_std: Write bytes of standard (non-emulated/special) memory.
@@ -116,10 +117,11 @@ struct x86_emulate_ops {
 	 *  @addr:  [IN ] Linear address to which to write.
 	 *  @val:   [OUT] Value write to memory, zero-extended to 'u_long'.
 	 *  @bytes: [IN ] Number of bytes to write to memory.
+	 *  @system:[IN ] Whether the access is forced to be at CPL0.
 	 */
 	int (*write_std)(struct x86_emulate_ctxt *ctxt,
 			 unsigned long addr, void *val, unsigned int bytes,
-			 struct x86_exception *fault);
+			 struct x86_exception *fault, bool system);
 	/*
 	 * fetch: Read bytes of standard (non-emulated/special) memory.
 	 *        Used for instruction fetch.
diff --git a/arch/x86/include/uapi/asm/msr-index.h b/arch/x86/include/uapi/=
asm/msr-index.h
index 6544e99baa1c..aa8bd503b6ed 100644
--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -109,6 +109,7 @@
=20
 /* DEBUGCTLMSR bits (others vary by model): */
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
+#define DEBUGCTLMSR_BTF_SHIFT		1
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
 #define DEBUGCTLMSR_TR			(1UL <<  6)
 #define DEBUGCTLMSR_BTS			(1UL <<  7)
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2b597d03d5ed..ae2832700bb5 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -533,6 +533,16 @@ static void init_amd_ln(struct cpuinfo_x86 *c)
 	msr_set_bit(MSR_AMD64_DE_CFG, 31);
 }
=20
+static void init_amd_zn(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
+	 * all up to and including B1.
+	 */
+	if (c->x86_model <=3D 1 && c->x86_mask <=3D 1)
+		set_cpu_cap(c, X86_FEATURE_CPB);
+}
+
 static void init_amd(struct cpuinfo_x86 *c)
 {
 	u32 dummy;
@@ -611,6 +621,9 @@ static void init_amd(struct cpuinfo_x86 *c)
 		clear_cpu_cap(c, X86_FEATURE_MCE);
 #endif
=20
+	if (c->x86 =3D=3D 0x17)
+		init_amd_zn(c);
+
 	/* Enable workaround for FXSAVE leak */
 	if (c->x86 >=3D 6)
 		set_cpu_cap(c, X86_FEATURE_FXSAVE_LEAK);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c3000969dd46..8af32e95e563 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -224,8 +224,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2=
_parse_cmdline(void)
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
 	else {
-		ret =3D cmdline_find_option(boot_command_line, "spectre_v2", arg,
-					  sizeof(arg));
+		ret =3D cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof=
(arg));
 		if (ret < 0)
 			return SPECTRE_V2_CMD_AUTO;
=20
@@ -246,8 +245,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2=
_parse_cmdline(void)
 	     cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_AMD ||
 	     cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_GENERIC) &&
 	    !IS_ENABLED(CONFIG_RETPOLINE)) {
-		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
-		       mitigation_options[i].option);
+		pr_err("%s selected but not compiled in. Switching to AUTO select\n", mi=
tigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
 	}
=20
@@ -265,23 +263,6 @@ static enum spectre_v2_mitigation_cmd __init spectre_v=
2_parse_cmdline(void)
 	return cmd;
 }
=20
-/* Check for Skylake-like CPUs (for RSB handling) */
-static bool __init is_skylake_era(void)
-{
-	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL &&
-	    boot_cpu_data.x86 =3D=3D 6) {
-		switch (boot_cpu_data.x86_model) {
-		case INTEL_FAM6_SKYLAKE_MOBILE:
-		case INTEL_FAM6_SKYLAKE_DESKTOP:
-		case INTEL_FAM6_SKYLAKE_X:
-		case INTEL_FAM6_KABYLAKE_MOBILE:
-		case INTEL_FAM6_KABYLAKE_DESKTOP:
-			return true;
-		}
-	}
-	return false;
-}
-
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd =3D spectre_v2_parse_cmdline();
@@ -317,14 +298,14 @@ static void __init spectre_v2_select_mitigation(void)
 			goto retpoline_auto;
 		break;
 	}
-	pr_err("kernel not compiled with retpoline; no mitigation available!");
+	pr_err("Spectre mitigation: kernel not compiled with retpoline; no mitiga=
tion available!");
 	return;
=20
 retpoline_auto:
 	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD) {
 	retpoline_amd:
 		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
-			pr_err("LFENCE not serializing. Switching to generic retpoline\n");
+			pr_err("Spectre mitigation: LFENCE not serializing, switching to generi=
c retpoline\n");
 			goto retpoline_generic;
 		}
 		mode =3D retp_compiler() ? SPECTRE_V2_RETPOLINE_AMD :
@@ -342,27 +323,20 @@ static void __init spectre_v2_select_mitigation(void)
 	pr_info("%s\n", spectre_v2_strings[mode]);
=20
 	/*
-	 * If neither SMEP or KPTI are available, there is a risk of
-	 * hitting userspace addresses in the RSB after a context switch
-	 * from a shallow call stack to a deeper one. To prevent this fill
-	 * the entire RSB, even when using IBRS.
+	 * If spectre v2 protection has been enabled, unconditionally fill
+	 * RSB during a context switch; this protects against two independent
+	 * issues:
 	 *
-	 * Skylake era CPUs have a separate issue with *underflow* of the
-	 * RSB, when they will predict 'ret' targets from the generic BTB.
-	 * The proper mitigation for this is IBRS. If IBRS is not supported
-	 * or deactivated in favour of retpolines the RSB fill on context
-	 * switch is required.
+	 *	- RSB underflow (and switch to BTB) on Skylake+
+	 *	- SpectreRSB variant of spectre v2 on X86_BUG_SPECTRE_V2 CPUs
 	 */
-	if ((!boot_cpu_has(X86_FEATURE_KAISER) &&
-	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
-		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
-		pr_info("Filling RSB on context switch\n");
-	}
+	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
+	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switc=
h\n");
=20
 	/* Initialize Indirect Branch Prediction Barrier if supported */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
-		pr_info("Enabling Indirect Branch Prediction Barrier\n");
+		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barr=
ier\n");
 	}
=20
 	/*
@@ -378,8 +352,7 @@ static void __init spectre_v2_select_mitigation(void)
 #undef pr_fmt
=20
 #ifdef CONFIG_SYSFS
-ssize_t cpu_show_meltdown(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *att=
r, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
 		return sprintf(buf, "Not affected\n");
@@ -388,16 +361,14 @@ ssize_t cpu_show_meltdown(struct device *dev,
 	return sprintf(buf, "Vulnerable\n");
 }
=20
-ssize_t cpu_show_spectre_v1(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *a=
ttr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return sprintf(buf, "Not affected\n");
 	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
=20
-ssize_t cpu_show_spectre_v2(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *a=
ttr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 6cfcffe66652..b1546961eac8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -199,6 +199,15 @@ static int __init x86_noinvpcid_setup(char *s)
 }
 early_param("noinvpcid", x86_noinvpcid_setup);
=20
+static int __init x86_fxsr_setup(char *s)
+{
+	setup_clear_cpu_cap(X86_FEATURE_FXSR);
+	setup_clear_cpu_cap(X86_FEATURE_FXSR_OPT);
+	setup_clear_cpu_cap(X86_FEATURE_XMM);
+	return 1;
+}
+__setup("nofxsr", x86_fxsr_setup);
+
 #ifdef CONFIG_X86_32
 static int cachesize_override =3D -1;
 static int disable_x86_serial_nr =3D 1;
@@ -210,14 +219,6 @@ static int __init cachesize_setup(char *str)
 }
 __setup("cachesize=3D", cachesize_setup);
=20
-static int __init x86_fxsr_setup(char *s)
-{
-	setup_clear_cpu_cap(X86_FEATURE_FXSR);
-	setup_clear_cpu_cap(X86_FEATURE_XMM);
-	return 1;
-}
-__setup("nofxsr", x86_fxsr_setup);
-
 static int __init x86_sep_setup(char *s)
 {
 	setup_clear_cpu_cap(X86_FEATURE_SEP);
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 1c4c26cfa778..280230fe7e49 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1135,7 +1135,7 @@ ENTRY(\sym)
 	.if \paranoid
 	jmp paranoid_exit		/* %ebx: no swapgs flag */
 	.else
-	jmp error_exit			/* %ebx: no swapgs flag */
+	jmp error_exit
 	.endif
=20
 	CFI_ENDPROC
@@ -1411,7 +1411,6 @@ END(paranoid_exit)
=20
 /*
  * Exception entry point. This expects an error code/orig_rax on the stack.
- * returns in "no swapgs flag" in %ebx.
  */
 ENTRY(error_entry)
 	XCPT_FRAME
@@ -1440,7 +1439,6 @@ ENTRY(error_entry)
 	 * the kernel CR3 here.
 	 */
 	SWITCH_KERNEL_CR3
-	xorl %ebx,%ebx
 	testl $3,CS+8(%rsp)
 	je error_kernelspace
 error_swapgs:
@@ -1456,7 +1454,6 @@ ENTRY(error_entry)
  * for these here too.
  */
 error_kernelspace:
-	incl %ebx
 	leaq native_irq_return_iret(%rip),%rcx
 	cmpq %rcx,RIP+8(%rsp)
 	je error_bad_iret
@@ -1477,22 +1474,18 @@ ENTRY(error_entry)
 	mov %rsp,%rdi
 	call fixup_bad_iret
 	mov %rax,%rsp
-	decl %ebx	/* Return to usergs */
 	jmp error_sti
 	CFI_ENDPROC
 END(error_entry)
=20
-
-/* ebx:	no swapgs flag (1: don't need swapgs, 0: need it) */
 ENTRY(error_exit)
 	DEFAULT_FRAME
-	movl %ebx,%eax
 	RESTORE_REST
 	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
 	GET_THREAD_INFO(%rcx)
-	testl %eax,%eax
-	jne retint_kernel
+	testb	$3, CS-ARGOFFSET(%rsp)
+	jz	retint_kernel
 	LOCKDEP_SYS_EXIT_IRQ
 	movl TI_flags(%rcx),%edx
 	movl $_TIF_WORK_MASK,%edi
diff --git a/arch/x86/kernel/i387.c b/arch/x86/kernel/i387.c
index 99df035d7cb1..60ea04f36653 100644
--- a/arch/x86/kernel/i387.c
+++ b/arch/x86/kernel/i387.c
@@ -159,6 +159,19 @@ static void init_thread_xstate(void)
 		xstate_size =3D sizeof(struct i387_fsave_struct);
 }
=20
+static enum { AUTO, ENABLE, DISABLE } eagerfpu =3D AUTO;
+static int __init eager_fpu_setup(char *s)
+{
+	if (!strcmp(s, "on"))
+		eagerfpu =3D ENABLE;
+	else if (!strcmp(s, "off"))
+		eagerfpu =3D DISABLE;
+	else if (!strcmp(s, "auto"))
+		eagerfpu =3D AUTO;
+	return 1;
+}
+__setup("eagerfpu=3D", eager_fpu_setup);
+
 /*
  * Called at bootup to set up the initial FPU state that is later cloned
  * into all processes.
@@ -197,6 +210,17 @@ void fpu_init(void)
 	if (xstate_size =3D=3D 0)
 		init_thread_xstate();
=20
+	/*
+	 * We should always enable eagerfpu, but it doesn't work properly
+	 * here without fpu and fxsr.
+	 */
+	if (eagerfpu =3D=3D AUTO)
+		eagerfpu =3D (boot_cpu_has(X86_FEATURE_FPU) &&
+			    boot_cpu_has(X86_FEATURE_FXSR)) ?
+			ENABLE : DISABLE;
+	if (eagerfpu =3D=3D ENABLE)
+		setup_force_cpu_cap(X86_FEATURE_EAGER_FPU);
+
 	mxcsr_feature_mask_init();
 	xsave_init();
 	eager_fpu_init();
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 8819ec730be4..e9e5afd7b2b8 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -97,10 +97,12 @@ unsigned paravirt_patch_call(void *insnbuf,
 	struct branch *b =3D insnbuf;
 	unsigned long delta =3D (unsigned long)target - (addr+5);
=20
-	if (tgt_clobbers & ~site_clobbers)
-		return len;	/* target would clobber too much for this site */
-	if (len < 5)
+	if (len < 5) {
+#ifdef CONFIG_RETPOLINE
+		WARN_ONCE("Failing to patch indirect CALL in %ps\n", (void *)addr);
+#endif
 		return len;	/* call too long for patch site */
+	}
=20
 	b->opcode =3D 0xe8; /* call */
 	b->delta =3D delta;
@@ -115,8 +117,12 @@ unsigned paravirt_patch_jmp(void *insnbuf, const void =
*target,
 	struct branch *b =3D insnbuf;
 	unsigned long delta =3D (unsigned long)target - (addr+5);
=20
-	if (len < 5)
+	if (len < 5) {
+#ifdef CONFIG_RETPOLINE
+		WARN_ONCE("Failing to patch indirect JMP in %ps\n", (void *)addr);
+#endif
 		return len;	/* call too long for patch site */
+	}
=20
 	b->opcode =3D 0xe9;	/* jmp */
 	b->delta =3D delta;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ee6014b2c43b..687152ec56e1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -196,48 +196,58 @@ int set_tsc_mode(unsigned int val)
 	return 0;
 }
=20
+static inline void switch_to_bitmap(struct tss_struct *tss,
+				    struct thread_struct *prev,
+				    struct thread_struct *next,
+				    unsigned long tifp, unsigned long tifn)
+{
+	if (tifn & _TIF_IO_BITMAP) {
+		/*
+		 * Copy the relevant range of the IO bitmap.
+		 * Normally this is 128 bytes or less:
+		 */
+		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
+		       max(prev->io_bitmap_max, next->io_bitmap_max));
+	} else if (tifp & _TIF_IO_BITMAP) {
+		/*
+		 * Clear any possible leftover bits:
+		 */
+		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
+	}
+}
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next=
_p,
 		      struct tss_struct *tss)
 {
 	struct thread_struct *prev, *next;
+	unsigned long tifp, tifn;
=20
 	prev =3D &prev_p->thread;
 	next =3D &next_p->thread;
=20
-	if (test_tsk_thread_flag(prev_p, TIF_BLOCKSTEP) ^
-	    test_tsk_thread_flag(next_p, TIF_BLOCKSTEP)) {
-		unsigned long debugctl =3D get_debugctlmsr();
+	tifn =3D ACCESS_ONCE(task_thread_info(next_p)->flags);
+	tifp =3D ACCESS_ONCE(task_thread_info(prev_p)->flags);
+	switch_to_bitmap(tss, prev, next, tifp, tifn);
=20
-		debugctl &=3D ~DEBUGCTLMSR_BTF;
-		if (test_tsk_thread_flag(next_p, TIF_BLOCKSTEP))
-			debugctl |=3D DEBUGCTLMSR_BTF;
+	propagate_user_return_notify(prev_p, next_p);
=20
-		update_debugctlmsr(debugctl);
+	if ((tifp & _TIF_BLOCKSTEP || tifn & _TIF_BLOCKSTEP) &&
+	    arch_has_block_step()) {
+		unsigned long debugctl, msk;
+
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+		debugctl &=3D ~DEBUGCTLMSR_BTF;
+		msk =3D tifn & _TIF_BLOCKSTEP;
+		debugctl |=3D (msk >> TIF_BLOCKSTEP) << DEBUGCTLMSR_BTF_SHIFT;
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 	}
=20
-	if (test_tsk_thread_flag(prev_p, TIF_NOTSC) ^
-	    test_tsk_thread_flag(next_p, TIF_NOTSC)) {
-		/* prev and next are different */
-		if (test_tsk_thread_flag(next_p, TIF_NOTSC))
+	if ((tifp ^ tifn) & _TIF_NOTSC) {
+		if (tifn & _TIF_NOTSC)
 			hard_disable_TSC();
 		else
 			hard_enable_TSC();
 	}
-
-	if (test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
-		/*
-		 * Copy the relevant range of the IO bitmap.
-		 * Normally this is 128 bytes or less:
-		 */
-		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-		       max(prev->io_bitmap_max, next->io_bitmap_max));
-	} else if (test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)) {
-		/*
-		 * Clear any possible leftover bits:
-		 */
-		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
-	}
-	propagate_user_return_notify(prev_p, next_p);
 }
=20
 /*
diff --git a/arch/x86/kernel/xsave.c b/arch/x86/kernel/xsave.c
index cfc2dbffa16c..44d28b6071a5 100644
--- a/arch/x86/kernel/xsave.c
+++ b/arch/x86/kernel/xsave.c
@@ -509,19 +509,6 @@ static void __init setup_init_fpu_buf(void)
 	xsave_state(init_xstate_buf, -1);
 }
=20
-static enum { AUTO, ENABLE, DISABLE } eagerfpu =3D AUTO;
-static int __init eager_fpu_setup(char *s)
-{
-	if (!strcmp(s, "on"))
-		eagerfpu =3D ENABLE;
-	else if (!strcmp(s, "off"))
-		eagerfpu =3D DISABLE;
-	else if (!strcmp(s, "auto"))
-		eagerfpu =3D AUTO;
-	return 1;
-}
-__setup("eagerfpu=3D", eager_fpu_setup);
-
 /*
  * Enable and initialize the xsave feature.
  */
@@ -560,17 +547,11 @@ static void __init xstate_enable_boot_cpu(void)
 	prepare_fx_sw_frame();
 	setup_init_fpu_buf();
=20
-	/* Auto enable eagerfpu for xsaveopt */
-	if (cpu_has_xsaveopt && eagerfpu !=3D DISABLE)
-		eagerfpu =3D ENABLE;
-
 	if (pcntxt_mask & XSTATE_EAGER) {
-		if (eagerfpu =3D=3D DISABLE) {
+		if (!boot_cpu_has(X86_FEATURE_EAGER_FPU)) {
 			pr_err("eagerfpu not present, disabling some xstate features: 0x%llx\n",
 					pcntxt_mask & XSTATE_EAGER);
 			pcntxt_mask &=3D ~XSTATE_EAGER;
-		} else {
-			eagerfpu =3D ENABLE;
 		}
 	}
=20
@@ -613,9 +594,6 @@ void eager_fpu_init(void)
 	clear_used_math();
 	current_thread_info()->status =3D 0;
=20
-	if (eagerfpu =3D=3D ENABLE)
-		setup_force_cpu_cap(X86_FEATURE_EAGER_FPU);
-
 	if (!cpu_has_eager_fpu) {
 		stts();
 		return;
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 98c567c98497..ede6797ee203 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -731,6 +731,19 @@ static int linearize(struct x86_emulate_ctxt *ctxt,
 }
=20
=20
+static int linear_read_system(struct x86_emulate_ctxt *ctxt, ulong linear,
+			      void *data, unsigned size)
+{
+	return ctxt->ops->read_std(ctxt, linear, data, size, &ctxt->exception, tr=
ue);
+}
+
+static int linear_write_system(struct x86_emulate_ctxt *ctxt,
+			       ulong linear, void *data,
+			       unsigned int size)
+{
+	return ctxt->ops->write_std(ctxt, linear, data, size, &ctxt->exception, t=
rue);
+}
+
 static int segmented_read_std(struct x86_emulate_ctxt *ctxt,
 			      struct segmented_address addr,
 			      void *data,
@@ -742,7 +755,7 @@ static int segmented_read_std(struct x86_emulate_ctxt *=
ctxt,
 	rc =3D linearize(ctxt, addr, size, false, &linear);
 	if (rc !=3D X86EMUL_CONTINUE)
 		return rc;
-	return ctxt->ops->read_std(ctxt, linear, data, size, &ctxt->exception);
+	return ctxt->ops->read_std(ctxt, linear, data, size, &ctxt->exception, fa=
lse);
 }
=20
 static int segmented_write_std(struct x86_emulate_ctxt *ctxt,
@@ -756,7 +769,7 @@ static int segmented_write_std(struct x86_emulate_ctxt =
*ctxt,
 	rc =3D linearize(ctxt, addr, size, true, &linear);
 	if (rc !=3D X86EMUL_CONTINUE)
 		return rc;
-	return ctxt->ops->write_std(ctxt, linear, data, size, &ctxt->exception);
+	return ctxt->ops->write_std(ctxt, linear, data, size, &ctxt->exception, f=
alse);
 }
=20
 /*
@@ -1394,8 +1407,7 @@ static int read_interrupt_descriptor(struct x86_emula=
te_ctxt *ctxt,
 		return emulate_gp(ctxt, index << 3 | 0x2);
=20
 	addr =3D dt.address + index * 8;
-	return ctxt->ops->read_std(ctxt, addr, desc, sizeof *desc,
-				   &ctxt->exception);
+	return linear_read_system(ctxt, addr, desc, sizeof *desc);
 }
=20
 static void get_descriptor_table_ptr(struct x86_emulate_ctxt *ctxt,
@@ -1432,8 +1444,7 @@ static int read_segment_descriptor(struct x86_emulate=
_ctxt *ctxt,
 		return emulate_gp(ctxt, selector & 0xfffc);
=20
 	*desc_addr_p =3D addr =3D dt.address + index * 8;
-	return ctxt->ops->read_std(ctxt, addr, desc, sizeof *desc,
-				   &ctxt->exception);
+	return linear_read_system(ctxt, addr, desc, sizeof(*desc));
 }
=20
 /* allowed just for 8 bytes segments */
@@ -1450,8 +1461,7 @@ static int write_segment_descriptor(struct x86_emulat=
e_ctxt *ctxt,
 		return emulate_gp(ctxt, selector & 0xfffc);
=20
 	addr =3D dt.address + index * 8;
-	return ctxt->ops->write_std(ctxt, addr, desc, sizeof *desc,
-				    &ctxt->exception);
+	return linear_write_system(ctxt, addr, desc, sizeof *desc);
 }
=20
 static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
@@ -1467,6 +1477,7 @@ static int __load_segment_descriptor(struct x86_emula=
te_ctxt *ctxt,
 	ulong desc_addr;
 	int ret;
 	u16 dummy;
+	u32 base3 =3D 0;
=20
 	memset(&seg_desc, 0, sizeof seg_desc);
=20
@@ -1597,9 +1608,13 @@ static int __load_segment_descriptor(struct x86_emul=
ate_ctxt *ctxt,
 		ret =3D write_segment_descriptor(ctxt, selector, &seg_desc);
 		if (ret !=3D X86EMUL_CONTINUE)
 			return ret;
+	} else if (ctxt->mode =3D=3D X86EMUL_MODE_PROT64) {
+		ret =3D linear_read_system(ctxt, desc_addr+8, &base3, sizeof(base3));
+		if (ret !=3D X86EMUL_CONTINUE)
+			return ret;
 	}
 load:
-	ctxt->ops->set_segment(ctxt, selector, &seg_desc, 0, seg);
+	ctxt->ops->set_segment(ctxt, selector, &seg_desc, base3, seg);
 	if (desc)
 		*desc =3D seg_desc;
 	return X86EMUL_CONTINUE;
@@ -1911,11 +1926,11 @@ static int __emulate_int_real(struct x86_emulate_ct=
xt *ctxt, int irq)
 	eip_addr =3D dt.address + (irq << 2);
 	cs_addr =3D dt.address + (irq << 2) + 2;
=20
-	rc =3D ops->read_std(ctxt, cs_addr, &cs, 2, &ctxt->exception);
+	rc =3D linear_read_system(ctxt, cs_addr, &cs, 2);
 	if (rc !=3D X86EMUL_CONTINUE)
 		return rc;
=20
-	rc =3D ops->read_std(ctxt, eip_addr, &eip, 2, &ctxt->exception);
+	rc =3D linear_read_system(ctxt, eip_addr, &eip, 2);
 	if (rc !=3D X86EMUL_CONTINUE)
 		return rc;
=20
@@ -2457,12 +2472,12 @@ static bool emulator_io_port_access_allowed(struct =
x86_emulate_ctxt *ctxt,
 #ifdef CONFIG_X86_64
 	base |=3D ((u64)base3) << 32;
 #endif
-	r =3D ops->read_std(ctxt, base + 102, &io_bitmap_ptr, 2, NULL);
+	r =3D ops->read_std(ctxt, base + 102, &io_bitmap_ptr, 2, NULL, true);
 	if (r !=3D X86EMUL_CONTINUE)
 		return false;
 	if (io_bitmap_ptr + port/8 > desc_limit_scaled(&tr_seg))
 		return false;
-	r =3D ops->read_std(ctxt, base + io_bitmap_ptr + port/8, &perm, 2, NULL);
+	r =3D ops->read_std(ctxt, base + io_bitmap_ptr + port/8, &perm, 2, NULL, =
true);
 	if (r !=3D X86EMUL_CONTINUE)
 		return false;
 	if ((perm >> bit_idx) & mask)
@@ -2567,27 +2582,23 @@ static int task_switch_16(struct x86_emulate_ctxt *=
ctxt,
 			  u16 tss_selector, u16 old_tss_sel,
 			  ulong old_tss_base, struct desc_struct *new_desc)
 {
-	const struct x86_emulate_ops *ops =3D ctxt->ops;
 	struct tss_segment_16 tss_seg;
 	int ret;
 	u32 new_tss_base =3D get_desc_base(new_desc);
=20
-	ret =3D ops->read_std(ctxt, old_tss_base, &tss_seg, sizeof tss_seg,
-			    &ctxt->exception);
+	ret =3D linear_read_system(ctxt, old_tss_base, &tss_seg, sizeof tss_seg);
 	if (ret !=3D X86EMUL_CONTINUE)
 		/* FIXME: need to provide precise fault address */
 		return ret;
=20
 	save_state_to_tss16(ctxt, &tss_seg);
=20
-	ret =3D ops->write_std(ctxt, old_tss_base, &tss_seg, sizeof tss_seg,
-			     &ctxt->exception);
+	ret =3D linear_write_system(ctxt, old_tss_base, &tss_seg, sizeof tss_seg);
 	if (ret !=3D X86EMUL_CONTINUE)
 		/* FIXME: need to provide precise fault address */
 		return ret;
=20
-	ret =3D ops->read_std(ctxt, new_tss_base, &tss_seg, sizeof tss_seg,
-			    &ctxt->exception);
+	ret =3D linear_read_system(ctxt, new_tss_base, &tss_seg, sizeof tss_seg);
 	if (ret !=3D X86EMUL_CONTINUE)
 		/* FIXME: need to provide precise fault address */
 		return ret;
@@ -2595,10 +2606,9 @@ static int task_switch_16(struct x86_emulate_ctxt *c=
txt,
 	if (old_tss_sel !=3D 0xffff) {
 		tss_seg.prev_task_link =3D old_tss_sel;
=20
-		ret =3D ops->write_std(ctxt, new_tss_base,
-				     &tss_seg.prev_task_link,
-				     sizeof tss_seg.prev_task_link,
-				     &ctxt->exception);
+		ret =3D linear_write_system(ctxt, new_tss_base,
+					  &tss_seg.prev_task_link,
+					  sizeof tss_seg.prev_task_link);
 		if (ret !=3D X86EMUL_CONTINUE)
 			/* FIXME: need to provide precise fault address */
 			return ret;
@@ -2717,15 +2727,13 @@ static int task_switch_32(struct x86_emulate_ctxt *=
ctxt,
 			  u16 tss_selector, u16 old_tss_sel,
 			  ulong old_tss_base, struct desc_struct *new_desc)
 {
-	const struct x86_emulate_ops *ops =3D ctxt->ops;
 	struct tss_segment_32 tss_seg;
 	int ret;
 	u32 new_tss_base =3D get_desc_base(new_desc);
 	u32 eip_offset =3D offsetof(struct tss_segment_32, eip);
 	u32 ldt_sel_offset =3D offsetof(struct tss_segment_32, ldt_selector);
=20
-	ret =3D ops->read_std(ctxt, old_tss_base, &tss_seg, sizeof tss_seg,
-			    &ctxt->exception);
+	ret =3D linear_read_system(ctxt, old_tss_base, &tss_seg, sizeof tss_seg);
 	if (ret !=3D X86EMUL_CONTINUE)
 		/* FIXME: need to provide precise fault address */
 		return ret;
@@ -2733,14 +2741,13 @@ static int task_switch_32(struct x86_emulate_ctxt *=
ctxt,
 	save_state_to_tss32(ctxt, &tss_seg);
=20
 	/* Only GP registers and segment selectors are saved */
-	ret =3D ops->write_std(ctxt, old_tss_base + eip_offset, &tss_seg.eip,
-			     ldt_sel_offset - eip_offset, &ctxt->exception);
+	ret =3D linear_write_system(ctxt, old_tss_base + eip_offset, &tss_seg.eip,
+				  ldt_sel_offset - eip_offset);
 	if (ret !=3D X86EMUL_CONTINUE)
 		/* FIXME: need to provide precise fault address */
 		return ret;
=20
-	ret =3D ops->read_std(ctxt, new_tss_base, &tss_seg, sizeof tss_seg,
-			    &ctxt->exception);
+	ret =3D linear_read_system(ctxt, new_tss_base, &tss_seg, sizeof tss_seg);
 	if (ret !=3D X86EMUL_CONTINUE)
 		/* FIXME: need to provide precise fault address */
 		return ret;
@@ -2748,10 +2755,9 @@ static int task_switch_32(struct x86_emulate_ctxt *c=
txt,
 	if (old_tss_sel !=3D 0xffff) {
 		tss_seg.prev_task_link =3D old_tss_sel;
=20
-		ret =3D ops->write_std(ctxt, new_tss_base,
-				     &tss_seg.prev_task_link,
-				     sizeof tss_seg.prev_task_link,
-				     &ctxt->exception);
+		ret =3D linear_write_system(ctxt, new_tss_base,
+					  &tss_seg.prev_task_link,
+					  sizeof tss_seg.prev_task_link);
 		if (ret !=3D X86EMUL_CONTINUE)
 			/* FIXME: need to provide precise fault address */
 			return ret;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index f37819266e81..fef8d308a5ee 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6027,8 +6027,7 @@ static int nested_vmx_check_vmptr(struct kvm_vcpu *vc=
pu, int exit_reason,
 			vmcs_read32(VMX_INSTRUCTION_INFO), &gva))
 		return 1;
=20
-	if (kvm_read_guest_virt(&vcpu->arch.emulate_ctxt, gva, &vmptr,
-				sizeof(vmptr), &e)) {
+	if (kvm_read_guest_virt(vcpu, gva, &vmptr, sizeof(vmptr), &e)) {
 		kvm_inject_page_fault(vcpu, &e);
 		return 1;
 	}
@@ -6539,8 +6538,8 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 				vmx_instruction_info, &gva))
 			return 1;
 		/* _system ok, as nested_vmx_check_permission verified cpl=3D0 */
-		kvm_write_guest_virt_system(&vcpu->arch.emulate_ctxt, gva,
-			     &field_value, (is_long_mode(vcpu) ? 8 : 4), NULL);
+		kvm_write_guest_virt_system(vcpu, gva, &field_value,
+					    (is_long_mode(vcpu) ? 8 : 4), NULL);
 	}
=20
 	nested_vmx_succeed(vcpu);
@@ -6575,8 +6574,8 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 		if (get_vmx_mem_address(vcpu, exit_qualification,
 				vmx_instruction_info, &gva))
 			return 1;
-		if (kvm_read_guest_virt(&vcpu->arch.emulate_ctxt, gva,
-			   &field_value, (is_long_mode(vcpu) ? 8 : 4), &e)) {
+		if (kvm_read_guest_virt(vcpu, gva, &field_value,
+					(is_long_mode(vcpu) ? 8 : 4), &e)) {
 			kvm_inject_page_fault(vcpu, &e);
 			return 1;
 		}
@@ -6669,9 +6668,9 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 			vmx_instruction_info, &vmcs_gva))
 		return 1;
 	/* ok to use *_system, as nested_vmx_check_permission verified cpl=3D0 */
-	if (kvm_write_guest_virt_system(&vcpu->arch.emulate_ctxt, vmcs_gva,
-				 (void *)&to_vmx(vcpu)->nested.current_vmptr,
-				 sizeof(u64), &e)) {
+	if (kvm_write_guest_virt_system(vcpu, vmcs_gva,
+					(void *)&to_vmx(vcpu)->nested.current_vmptr,
+					sizeof(u64), &e)) {
 		kvm_inject_page_fault(vcpu, &e);
 		return 1;
 	}
@@ -6723,8 +6722,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	if (get_vmx_mem_address(vcpu, vmcs_readl(EXIT_QUALIFICATION),
 			vmx_instruction_info, &gva))
 		return 1;
-	if (kvm_read_guest_virt(&vcpu->arch.emulate_ctxt, gva, &operand,
-				sizeof(operand), &e)) {
+	if (kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e)) {
 		kvm_inject_page_fault(vcpu, &e);
 		return 1;
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e959897a0f44..8fddaf37ff4f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -876,17 +876,11 @@ EXPORT_SYMBOL_GPL(kvm_rdpmc);
  *
  * This list is modified at module load time to reflect the
  * capabilities of the host cpu. This capabilities test skips MSRs that are
- * kvm-specific. Those are put in the beginning of the list.
+ * kvm-specific. Those are put in emulated_msrs; filtering of emulated_msrs
+ * may depend on host virtualization features rather than host cpu feature=
s.
  */
=20
-#define KVM_SAVE_MSRS_BEGIN	12
 static u32 msrs_to_save[] =3D {
-	MSR_KVM_SYSTEM_TIME, MSR_KVM_WALL_CLOCK,
-	MSR_KVM_SYSTEM_TIME_NEW, MSR_KVM_WALL_CLOCK_NEW,
-	HV_X64_MSR_GUEST_OS_ID, HV_X64_MSR_HYPERCALL,
-	HV_X64_MSR_TIME_REF_COUNT, HV_X64_MSR_REFERENCE_TSC,
-	HV_X64_MSR_APIC_ASSIST_PAGE, MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
-	MSR_KVM_PV_EOI_EN,
 	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
 	MSR_STAR,
 #ifdef CONFIG_X86_64
@@ -899,7 +893,14 @@ static u32 msrs_to_save[] =3D {
=20
 static unsigned num_msrs_to_save;
=20
-static const u32 emulated_msrs[] =3D {
+static u32 emulated_msrs[] =3D {
+	MSR_KVM_SYSTEM_TIME, MSR_KVM_WALL_CLOCK,
+	MSR_KVM_SYSTEM_TIME_NEW, MSR_KVM_WALL_CLOCK_NEW,
+	HV_X64_MSR_GUEST_OS_ID, HV_X64_MSR_HYPERCALL,
+	HV_X64_MSR_TIME_REF_COUNT, HV_X64_MSR_REFERENCE_TSC,
+	HV_X64_MSR_APIC_ASSIST_PAGE, MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
+	MSR_KVM_PV_EOI_EN,
+
 	MSR_IA32_TSC_ADJUST,
 	MSR_IA32_TSCDEADLINE,
 	MSR_IA32_MISC_ENABLE,
@@ -907,6 +908,8 @@ static const u32 emulated_msrs[] =3D {
 	MSR_IA32_MCG_CTL,
 };
=20
+static unsigned num_emulated_msrs;
+
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	if (efer & efer_reserved_bits)
@@ -2774,7 +2777,7 @@ long kvm_arch_dev_ioctl(struct file *filp,
 		if (copy_from_user(&msr_list, user_msr_list, sizeof msr_list))
 			goto out;
 		n =3D msr_list.nmsrs;
-		msr_list.nmsrs =3D num_msrs_to_save + ARRAY_SIZE(emulated_msrs);
+		msr_list.nmsrs =3D num_msrs_to_save + num_emulated_msrs;
 		if (copy_to_user(user_msr_list, &msr_list, sizeof msr_list))
 			goto out;
 		r =3D -E2BIG;
@@ -2786,7 +2789,7 @@ long kvm_arch_dev_ioctl(struct file *filp,
 			goto out;
 		if (copy_to_user(user_msr_list->indices + num_msrs_to_save,
 				 &emulated_msrs,
-				 ARRAY_SIZE(emulated_msrs) * sizeof(u32)))
+				 num_emulated_msrs * sizeof(u32)))
 			goto out;
 		r =3D 0;
 		break;
@@ -4009,8 +4012,7 @@ static void kvm_init_msr_list(void)
 	u32 dummy[2];
 	unsigned i, j;
=20
-	/* skip the first msrs in the list. KVM-specific */
-	for (i =3D j =3D KVM_SAVE_MSRS_BEGIN; i < ARRAY_SIZE(msrs_to_save); i++) {
+	for (i =3D j =3D 0; i < ARRAY_SIZE(msrs_to_save); i++) {
 		if (rdmsr_safe(msrs_to_save[i], &dummy[0], &dummy[1]) < 0)
 			continue;
=20
@@ -4035,6 +4037,18 @@ static void kvm_init_msr_list(void)
 		j++;
 	}
 	num_msrs_to_save =3D j;
+
+	for (i =3D j =3D 0; i < ARRAY_SIZE(emulated_msrs); i++) {
+		switch (emulated_msrs[i]) {
+		default:
+			break;
+		}
+
+		if (j < i)
+			emulated_msrs[j] =3D emulated_msrs[i];
+		j++;
+	}
+	num_emulated_msrs =3D j;
 }
=20
 static int vcpu_mmio_write(struct kvm_vcpu *vcpu, gpa_t addr, int len,
@@ -4178,11 +4192,10 @@ static int kvm_fetch_guest_virt(struct x86_emulate_=
ctxt *ctxt,
 					  exception);
 }
=20
-int kvm_read_guest_virt(struct x86_emulate_ctxt *ctxt,
+int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 			       gva_t addr, void *val, unsigned int bytes,
 			       struct x86_exception *exception)
 {
-	struct kvm_vcpu *vcpu =3D emul_to_vcpu(ctxt);
 	u32 access =3D (kvm_x86_ops->get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK : =
0;
=20
 	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
@@ -4190,26 +4203,29 @@ int kvm_read_guest_virt(struct x86_emulate_ctxt *ct=
xt,
 }
 EXPORT_SYMBOL_GPL(kvm_read_guest_virt);
=20
-static int kvm_read_guest_virt_system(struct x86_emulate_ctxt *ctxt,
-				      gva_t addr, void *val, unsigned int bytes,
-				      struct x86_exception *exception)
+static int emulator_read_std(struct x86_emulate_ctxt *ctxt,
+			     gva_t addr, void *val, unsigned int bytes,
+			     struct x86_exception *exception, bool system)
 {
 	struct kvm_vcpu *vcpu =3D emul_to_vcpu(ctxt);
-	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, 0, exception);
+	u32 access =3D 0;
+
+	if (!system && kvm_x86_ops->get_cpl(vcpu) =3D=3D 3)
+		access |=3D PFERR_USER_MASK;
+
+	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access, excepti=
on);
 }
=20
-int kvm_write_guest_virt_system(struct x86_emulate_ctxt *ctxt,
-				       gva_t addr, void *val,
-				       unsigned int bytes,
-				       struct x86_exception *exception)
+static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int=
 bytes,
+				      struct kvm_vcpu *vcpu, u32 access,
+				      struct x86_exception *exception)
 {
-	struct kvm_vcpu *vcpu =3D emul_to_vcpu(ctxt);
 	void *data =3D val;
 	int r =3D X86EMUL_CONTINUE;
=20
 	while (bytes) {
 		gpa_t gpa =3D  vcpu->arch.walk_mmu->gva_to_gpa(vcpu, addr,
-							     PFERR_WRITE_MASK,
+							     access,
 							     exception);
 		unsigned offset =3D addr & (PAGE_SIZE-1);
 		unsigned towrite =3D min(bytes, (unsigned)PAGE_SIZE - offset);
@@ -4230,6 +4246,27 @@ int kvm_write_guest_virt_system(struct x86_emulate_c=
txt *ctxt,
 out:
 	return r;
 }
+
+static int emulator_write_std(struct x86_emulate_ctxt *ctxt, gva_t addr, v=
oid *val,
+			      unsigned int bytes, struct x86_exception *exception,
+			      bool system)
+{
+	struct kvm_vcpu *vcpu =3D emul_to_vcpu(ctxt);
+	u32 access =3D PFERR_WRITE_MASK;
+
+	if (!system && kvm_x86_ops->get_cpl(vcpu) =3D=3D 3)
+		access |=3D PFERR_USER_MASK;
+
+	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
+					   access, exception);
+}
+
+int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu, gva_t addr, void *v=
al,
+				unsigned int bytes, struct x86_exception *exception)
+{
+	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
+					   PFERR_WRITE_MASK, exception);
+}
 EXPORT_SYMBOL_GPL(kvm_write_guest_virt_system);
=20
 static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
@@ -4902,8 +4939,8 @@ static void emulator_write_gpr(struct x86_emulate_ctx=
t *ctxt, unsigned reg, ulon
 static const struct x86_emulate_ops emulate_ops =3D {
 	.read_gpr            =3D emulator_read_gpr,
 	.write_gpr           =3D emulator_write_gpr,
-	.read_std            =3D kvm_read_guest_virt_system,
-	.write_std           =3D kvm_write_guest_virt_system,
+	.read_std            =3D emulator_read_std,
+	.write_std           =3D emulator_write_std,
 	.fetch               =3D kvm_fetch_guest_virt,
 	.read_emulated       =3D emulator_read_emulated,
 	.write_emulated      =3D emulator_write_emulated,
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 8bc086f5c5a6..6453f936540a 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -124,11 +124,11 @@ int kvm_inject_realmode_interrupt(struct kvm_vcpu *vc=
pu, int irq, int inc_eip);
=20
 void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr);
=20
-int kvm_read_guest_virt(struct x86_emulate_ctxt *ctxt,
+int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
=20
-int kvm_write_guest_virt_system(struct x86_emulate_ctxt *ctxt,
+int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
=20
diff --git a/arch/x86/syscalls/syscall_32.tbl b/arch/x86/syscalls/syscall_3=
2.tbl
index 50aa58be7933..81ce9baeb1e8 100644
--- a/arch/x86/syscalls/syscall_32.tbl
+++ b/arch/x86/syscalls/syscall_32.tbl
@@ -360,3 +360,4 @@
 351	i386	sched_setattr		sys_sched_setattr
 352	i386	sched_getattr		sys_sched_getattr
 353	i386	renameat2		sys_renameat2
+354	i386	seccomp			sys_seccomp
diff --git a/arch/x86/syscalls/syscall_64.tbl b/arch/x86/syscalls/syscall_6=
4.tbl
index ec255a1646d2..16272a6c12b7 100644
--- a/arch/x86/syscalls/syscall_64.tbl
+++ b/arch/x86/syscalls/syscall_64.tbl
@@ -323,6 +323,7 @@
 314	common	sched_setattr		sys_sched_setattr
 315	common	sched_getattr		sys_sched_getattr
 316	common	renameat2		sys_renameat2
+317	common	seccomp			sys_seccomp
=20
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index aac259d6e248..c61de6df44b0 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2528,7 +2528,7 @@ static int cdrom_ioctl_drive_status(struct cdrom_devi=
ce_info *cdi,
 	if (!CDROM_CAN(CDC_SELECT_DISC) ||
 	    (arg =3D=3D CDSL_CURRENT || arg =3D=3D CDSL_NONE))
 		return cdi->ops->drive_status(cdi, CDSL_CURRENT);
-	if (((int)arg >=3D cdi->capacity))
+	if (arg >=3D cdi->capacity)
 		return -EINVAL;
 	return cdrom_slot_status(cdi, arg);
 }
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 29e646836cde..9acf67de4e9a 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -180,7 +180,7 @@ static struct ucma_multicast* ucma_alloc_multicast(stru=
ct ucma_context *ctx)
 		return NULL;
=20
 	mutex_lock(&mut);
-	mc->id =3D idr_alloc(&multicast_idr, mc, 0, 0, GFP_KERNEL);
+	mc->id =3D idr_alloc(&multicast_idr, NULL, 0, 0, GFP_KERNEL);
 	mutex_unlock(&mut);
 	if (mc->id < 0)
 		goto error;
@@ -1285,6 +1285,10 @@ static ssize_t ucma_process_join(struct ucma_file *f=
ile,
 		goto err3;
 	}
=20
+	mutex_lock(&mut);
+	idr_replace(&multicast_idr, mc, mc->id);
+	mutex_unlock(&mut);
+
 	mutex_unlock(&file->mut);
 	ucma_put_ctx(ctx);
 	return 0;
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_=
scsi_host.c
index 25d0f127424d..69b75f5b2eed 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -250,6 +250,7 @@ int sas_queuecommand(struct Scsi_Host *host, struct scs=
i_cmnd *cmd)
 static void sas_eh_finish_cmd(struct scsi_cmnd *cmd)
 {
 	struct sas_ha_struct *sas_ha =3D SHOST_TO_SAS_HA(cmd->device->host);
+	struct domain_device *dev =3D cmd_to_domain_dev(cmd);
 	struct sas_task *task =3D TO_SAS_TASK(cmd);
=20
 	/* At this point, we only get called following an actual abort
@@ -258,6 +259,14 @@ static void sas_eh_finish_cmd(struct scsi_cmnd *cmd)
 	 */
 	sas_end_task(cmd, task);
=20
+	if (dev_is_sata(dev)) {
+		/* defer commands to libata so that libata EH can
+		 * handle ata qcs correctly
+		 */
+		list_move_tail(&cmd->eh_entry, &sas_ha->eh_ata_q);
+		return;
+	}
+
 	/* now finish the command and move it on to the error
 	 * handler done list, this also takes it off the
 	 * error handler pending list.
@@ -265,22 +274,6 @@ static void sas_eh_finish_cmd(struct scsi_cmnd *cmd)
 	scsi_eh_finish_cmd(cmd, &sas_ha->eh_done_q);
 }
=20
-static void sas_eh_defer_cmd(struct scsi_cmnd *cmd)
-{
-	struct domain_device *dev =3D cmd_to_domain_dev(cmd);
-	struct sas_ha_struct *ha =3D dev->port->ha;
-	struct sas_task *task =3D TO_SAS_TASK(cmd);
-
-	if (!dev_is_sata(dev)) {
-		sas_eh_finish_cmd(cmd);
-		return;
-	}
-
-	/* report the timeout to libata */
-	sas_end_task(cmd, task);
-	list_move_tail(&cmd->eh_entry, &ha->eh_ata_q);
-}
-
 static void sas_scsi_clear_queue_lu(struct list_head *error_q, struct scsi=
_cmnd *my_cmd)
 {
 	struct scsi_cmnd *cmd, *n;
@@ -288,7 +281,7 @@ static void sas_scsi_clear_queue_lu(struct list_head *e=
rror_q, struct scsi_cmnd
 	list_for_each_entry_safe(cmd, n, error_q, eh_entry) {
 		if (cmd->device->sdev_target =3D=3D my_cmd->device->sdev_target &&
 		    cmd->device->lun =3D=3D my_cmd->device->lun)
-			sas_eh_defer_cmd(cmd);
+			sas_eh_finish_cmd(cmd);
 	}
 }
=20
@@ -677,12 +670,12 @@ static void sas_eh_handle_sas_errors(struct Scsi_Host=
 *shost, struct list_head *
 		case TASK_IS_DONE:
 			SAS_DPRINTK("%s: task 0x%p is done\n", __func__,
 				    task);
-			sas_eh_defer_cmd(cmd);
+			sas_eh_finish_cmd(cmd);
 			continue;
 		case TASK_IS_ABORTED:
 			SAS_DPRINTK("%s: task 0x%p is aborted\n",
 				    __func__, task);
-			sas_eh_defer_cmd(cmd);
+			sas_eh_finish_cmd(cmd);
 			continue;
 		case TASK_IS_AT_LU:
 			SAS_DPRINTK("task 0x%p is at LU: lu recover\n", task);
@@ -693,7 +686,7 @@ static void sas_eh_handle_sas_errors(struct Scsi_Host *=
shost, struct list_head *
 					    "recovered\n",
 					    SAS_ADDR(task->dev),
 					    cmd->device->lun);
-				sas_eh_defer_cmd(cmd);
+				sas_eh_finish_cmd(cmd);
 				sas_scsi_clear_queue_lu(work_q, cmd);
 				goto Again;
 			}
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 0206b495b65e..cc4e3f1c204b 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1825,7 +1825,7 @@ sg_build_indirect(Sg_scatter_hold * schp, Sg_fd * sfp=
, int buff_size)
 		num =3D (rem_sz > scatter_elem_sz_prev) ?
 			scatter_elem_sz_prev : rem_sz;
=20
-		schp->pages[k] =3D alloc_pages(gfp_mask, order);
+		schp->pages[k] =3D alloc_pages(gfp_mask | __GFP_ZERO, order);
 		if (!schp->pages[k])
 			goto out;
=20
diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
index a3911c39ea50..9963af41b25f 100644
--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -188,30 +188,25 @@ int sr_do_ioctl(Scsi_CD *cd, struct packet_command *c=
gc)
 	struct scsi_device *SDev;
 	struct scsi_sense_hdr sshdr;
 	int result, err =3D 0, retries =3D 0;
-	struct request_sense *sense =3D cgc->sense;
+	unsigned char sense_buffer[SCSI_SENSE_BUFFERSIZE];
=20
 	SDev =3D cd->device;
=20
-	if (!sense) {
-		sense =3D kmalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
-		if (!sense) {
-			err =3D -ENOMEM;
-			goto out;
-		}
-	}
-
       retry:
 	if (!scsi_block_when_processing_errors(SDev)) {
 		err =3D -ENODEV;
 		goto out;
 	}
=20
-	memset(sense, 0, sizeof(*sense));
+	memset(sense_buffer, 0, sizeof(sense_buffer));
 	result =3D scsi_execute(SDev, cgc->cmd, cgc->data_direction,
-			      cgc->buffer, cgc->buflen, (char *)sense,
+			      cgc->buffer, cgc->buflen, sense_buffer,
 			      cgc->timeout, IOCTL_RETRIES, 0, NULL);
=20
-	scsi_normalize_sense((char *)sense, sizeof(*sense), &sshdr);
+	scsi_normalize_sense(sense_buffer, sizeof(sense_buffer), &sshdr);
+
+	if (cgc->sense)
+		memcpy(cgc->sense, sense_buffer, sizeof(*cgc->sense));
=20
 	/* Minimal error checking.  Ignore cases we know about, and report the re=
st. */
 	if (driver_byte(result) !=3D 0) {
@@ -268,8 +263,6 @@ int sr_do_ioctl(Scsi_CD *cd, struct packet_command *cgc)
=20
 	/* Wake up a process waiting for device */
       out:
-	if (!cgc->sense)
-		kfree(sense);
 	cgc->stat =3D err;
 	return err;
 }
diff --git a/drivers/staging/usbip/stub.h b/drivers/staging/usbip/stub.h
index 910f027773aa..84c0599b45b7 100644
--- a/drivers/staging/usbip/stub.h
+++ b/drivers/staging/usbip/stub.h
@@ -87,6 +87,7 @@ struct bus_id_priv {
 	struct stub_device *sdev;
 	struct usb_device *udev;
 	char shutdown_busid;
+	spinlock_t busid_lock;
 };
=20
 /* stub_priv is allocated from stub_priv_cache */
@@ -97,6 +98,7 @@ extern struct usb_device_driver stub_driver;
=20
 /* stub_main.c */
 struct bus_id_priv *get_busid_priv(const char *busid);
+void put_busid_priv(struct bus_id_priv *bid);
 int del_match_busid(char *busid);
 void stub_device_cleanup_urbs(struct stub_device *sdev);
=20
diff --git a/drivers/staging/usbip/stub_dev.c b/drivers/staging/usbip/stub_=
dev.c
index 3959633ad09c..c9183c960a06 100644
--- a/drivers/staging/usbip/stub_dev.c
+++ b/drivers/staging/usbip/stub_dev.c
@@ -340,11 +340,10 @@ static int stub_probe(struct usb_device *udev)
 {
 	struct stub_device *sdev =3D NULL;
 	const char *udev_busid =3D dev_name(&udev->dev);
-	int err =3D 0;
 	struct bus_id_priv *busid_priv;
-	int rc;
+	int rc =3D 0;
=20
-	dev_dbg(&udev->dev, "Enter\n");
+	dev_dbg(&udev->dev, "Enter probe\n");
=20
 	/* check we should claim or not by busid_table */
 	busid_priv =3D get_busid_priv(udev_busid);
@@ -359,13 +358,15 @@ static int stub_probe(struct usb_device *udev)
 		 * other matched drivers by the driver core.
 		 * See driver_probe_device() in driver/base/dd.c
 		 */
-		return -ENODEV;
+		rc =3D -ENODEV;
+		goto call_put_busid_priv;
 	}
=20
 	if (udev->descriptor.bDeviceClass =3D=3D USB_CLASS_HUB) {
 		dev_dbg(&udev->dev, "%s is a usb hub device... skip!\n",
 			 udev_busid);
-		return -ENODEV;
+		rc =3D -ENODEV;
+		goto call_put_busid_priv;
 	}
=20
 	if (!strcmp(udev->bus->bus_name, "vhci_hcd")) {
@@ -373,13 +374,16 @@ static int stub_probe(struct usb_device *udev)
 			"%s is attached on vhci_hcd... skip!\n",
 			udev_busid);
=20
-		return -ENODEV;
+		rc =3D -ENODEV;
+		goto call_put_busid_priv;
 	}
=20
 	/* ok, this is my device */
 	sdev =3D stub_device_alloc(udev);
-	if (!sdev)
-		return -ENOMEM;
+	if (!sdev) {
+		rc =3D -ENOMEM;
+		goto call_put_busid_priv;
+	}
=20
 	dev_info(&udev->dev,
 		"usbip-host: register new device (bus %u dev %u)\n",
@@ -401,23 +405,33 @@ static int stub_probe(struct usb_device *udev)
 			(struct usb_dev_state *) udev);
 	if (rc) {
 		dev_dbg(&udev->dev, "unable to claim port\n");
-		return rc;
+		goto err_port;
 	}
=20
-	err =3D stub_add_files(&udev->dev);
-	if (err) {
+	rc =3D stub_add_files(&udev->dev);
+	if (rc) {
 		dev_err(&udev->dev, "stub_add_files for %s\n", udev_busid);
-		dev_set_drvdata(&udev->dev, NULL);
-		usb_put_dev(udev);
-		kthread_stop_put(sdev->ud.eh);
-
-		busid_priv->sdev =3D NULL;
-		stub_device_free(sdev);
-		return err;
+		goto err_files;
 	}
 	busid_priv->status =3D STUB_BUSID_ALLOC;
=20
-	return 0;
+	rc =3D 0;
+	goto call_put_busid_priv;
+
+err_files:
+	usb_hub_release_port(udev->parent, udev->portnum,
+			     (struct usb_dev_state *) udev);
+err_port:
+	dev_set_drvdata(&udev->dev, NULL);
+	usb_put_dev(udev);
+	kthread_stop_put(sdev->ud.eh);
+
+	busid_priv->sdev =3D NULL;
+	stub_device_free(sdev);
+
+call_put_busid_priv:
+	put_busid_priv(busid_priv);
+	return rc;
 }
=20
 static void shutdown_busid(struct bus_id_priv *busid_priv)
@@ -442,7 +456,7 @@ static void stub_disconnect(struct usb_device *udev)
 	struct bus_id_priv *busid_priv;
 	int rc;
=20
-	dev_dbg(&udev->dev, "Enter\n");
+	dev_dbg(&udev->dev, "Enter disconnect\n");
=20
 	busid_priv =3D get_busid_priv(udev_busid);
 	if (!busid_priv) {
@@ -455,7 +469,7 @@ static void stub_disconnect(struct usb_device *udev)
 	/* get stub_device */
 	if (!sdev) {
 		dev_err(&udev->dev, "could not get device");
-		return;
+		goto call_put_busid_priv;
 	}
=20
 	dev_set_drvdata(&udev->dev, NULL);
@@ -470,12 +484,12 @@ static void stub_disconnect(struct usb_device *udev)
 				  (struct usb_dev_state *) udev);
 	if (rc) {
 		dev_dbg(&udev->dev, "unable to release port\n");
-		return;
+		goto call_put_busid_priv;
 	}
=20
 	/* If usb reset is called from event handler */
 	if (busid_priv->sdev->ud.eh =3D=3D current)
-		return;
+		goto call_put_busid_priv;
=20
 	/* shutdown the current connection */
 	shutdown_busid(busid_priv);
@@ -486,12 +500,11 @@ static void stub_disconnect(struct usb_device *udev)
 	busid_priv->sdev =3D NULL;
 	stub_device_free(sdev);
=20
-	if (busid_priv->status =3D=3D STUB_BUSID_ALLOC) {
+	if (busid_priv->status =3D=3D STUB_BUSID_ALLOC)
 		busid_priv->status =3D STUB_BUSID_ADDED;
-	} else {
-		busid_priv->status =3D STUB_BUSID_OTHER;
-		del_match_busid((char *)udev_busid);
-	}
+
+call_put_busid_priv:
+	put_busid_priv(busid_priv);
 }
=20
 #ifdef CONFIG_PM
diff --git a/drivers/staging/usbip/stub_main.c b/drivers/staging/usbip/stub=
_main.c
index 33da2c4a4bc3..87ea1365c153 100644
--- a/drivers/staging/usbip/stub_main.c
+++ b/drivers/staging/usbip/stub_main.c
@@ -28,6 +28,7 @@
 #define DRIVER_DESC "USB/IP Host Driver"
=20
 struct kmem_cache *stub_priv_cache;
+
 /*
  * busid_tables defines matching busids that usbip can grab. A user can ch=
ange
  * dynamically what device is locally used and what device is exported to a
@@ -39,6 +40,8 @@ static spinlock_t busid_table_lock;
=20
 static void init_busid_table(void)
 {
+	int i;
+
 	/*
 	 * This also sets the bus_table[i].status to
 	 * STUB_BUSID_OTHER, which is 0.
@@ -46,6 +49,9 @@ static void init_busid_table(void)
 	memset(busid_table, 0, sizeof(busid_table));
=20
 	spin_lock_init(&busid_table_lock);
+
+	for (i =3D 0; i < MAX_BUSID; i++)
+		spin_lock_init(&busid_table[i].busid_lock);
 }
=20
 /*
@@ -57,15 +63,20 @@ static int get_busid_idx(const char *busid)
 	int i;
 	int idx =3D -1;
=20
-	for (i =3D 0; i < MAX_BUSID; i++)
+	for (i =3D 0; i < MAX_BUSID; i++) {
+		spin_lock(&busid_table[i].busid_lock);
 		if (busid_table[i].name[0])
 			if (!strncmp(busid_table[i].name, busid, BUSID_SIZE)) {
 				idx =3D i;
+				spin_unlock(&busid_table[i].busid_lock);
 				break;
 			}
+		spin_unlock(&busid_table[i].busid_lock);
+	}
 	return idx;
 }
=20
+/* Returns holding busid_lock. Should call put_busid_priv() to unlock */
 struct bus_id_priv *get_busid_priv(const char *busid)
 {
 	int idx;
@@ -73,13 +84,22 @@ struct bus_id_priv *get_busid_priv(const char *busid)
=20
 	spin_lock(&busid_table_lock);
 	idx =3D get_busid_idx(busid);
-	if (idx >=3D 0)
+	if (idx >=3D 0) {
 		bid =3D &(busid_table[idx]);
+		/* get busid_lock before returning */
+		spin_lock(&bid->busid_lock);
+	}
 	spin_unlock(&busid_table_lock);
=20
 	return bid;
 }
=20
+void put_busid_priv(struct bus_id_priv *bid)
+{
+	if (bid)
+		spin_unlock(&bid->busid_lock);
+}
+
 static int add_match_busid(char *busid)
 {
 	int i;
@@ -92,15 +112,19 @@ static int add_match_busid(char *busid)
 		goto out;
 	}
=20
-	for (i =3D 0; i < MAX_BUSID; i++)
+	for (i =3D 0; i < MAX_BUSID; i++) {
+		spin_lock(&busid_table[i].busid_lock);
 		if (!busid_table[i].name[0]) {
 			strncpy(busid_table[i].name, busid, BUSID_SIZE);
 			if ((busid_table[i].status !=3D STUB_BUSID_ALLOC) &&
 			    (busid_table[i].status !=3D STUB_BUSID_REMOV))
 				busid_table[i].status =3D STUB_BUSID_ADDED;
 			ret =3D 0;
+			spin_unlock(&busid_table[i].busid_lock);
 			break;
 		}
+		spin_unlock(&busid_table[i].busid_lock);
+	}
=20
 out:
 	spin_unlock(&busid_table_lock);
@@ -121,6 +145,8 @@ int del_match_busid(char *busid)
 	/* found */
 	ret =3D 0;
=20
+	spin_lock(&busid_table[idx].busid_lock);
+
 	if (busid_table[idx].status =3D=3D STUB_BUSID_OTHER)
 		memset(busid_table[idx].name, 0, BUSID_SIZE);
=20
@@ -128,6 +154,7 @@ int del_match_busid(char *busid)
 	    (busid_table[idx].status !=3D STUB_BUSID_ADDED))
 		busid_table[idx].status =3D STUB_BUSID_REMOV;
=20
+	spin_unlock(&busid_table[idx].busid_lock);
 out:
 	spin_unlock(&busid_table_lock);
=20
@@ -140,9 +167,12 @@ static ssize_t show_match_busid(struct device_driver *=
drv, char *buf)
 	char *out =3D buf;
=20
 	spin_lock(&busid_table_lock);
-	for (i =3D 0; i < MAX_BUSID; i++)
+	for (i =3D 0; i < MAX_BUSID; i++) {
+		spin_lock(&busid_table[i].busid_lock);
 		if (busid_table[i].name[0])
 			out +=3D sprintf(out, "%s ", busid_table[i].name);
+		spin_unlock(&busid_table[i].busid_lock);
+	}
 	spin_unlock(&busid_table_lock);
 	out +=3D sprintf(out, "\n");
=20
@@ -188,6 +218,51 @@ static ssize_t store_match_busid(struct device_driver =
*dev, const char *buf,
 static DRIVER_ATTR(match_busid, S_IRUSR | S_IWUSR, show_match_busid,
 		   store_match_busid);
=20
+static int do_rebind(char *busid, struct bus_id_priv *busid_priv)
+{
+	int ret;
+
+	/* device_attach() callers should hold parent lock for USB */
+	if (busid_priv->udev->dev.parent)
+		device_lock(busid_priv->udev->dev.parent);
+	ret =3D device_attach(&busid_priv->udev->dev);
+	if (busid_priv->udev->dev.parent)
+		device_unlock(busid_priv->udev->dev.parent);
+	if (ret < 0) {
+		dev_err(&busid_priv->udev->dev, "rebind failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+static void stub_device_rebind(void)
+{
+#if IS_MODULE(CONFIG_USBIP_HOST)
+	struct bus_id_priv *busid_priv;
+	int i;
+
+	/* update status to STUB_BUSID_OTHER so probe ignores the device */
+	spin_lock(&busid_table_lock);
+	for (i =3D 0; i < MAX_BUSID; i++) {
+		if (busid_table[i].name[0] &&
+		    busid_table[i].shutdown_busid) {
+			busid_priv =3D &(busid_table[i]);
+			busid_priv->status =3D STUB_BUSID_OTHER;
+		}
+	}
+	spin_unlock(&busid_table_lock);
+
+	/* now run rebind - no need to hold locks. driver files are removed */
+	for (i =3D 0; i < MAX_BUSID; i++) {
+		if (busid_table[i].name[0] &&
+		    busid_table[i].shutdown_busid) {
+			busid_priv =3D &(busid_table[i]);
+			do_rebind(busid_table[i].name, busid_priv);
+		}
+	}
+#endif
+}
+
 static ssize_t rebind_store(struct device_driver *dev, const char *buf,
 				 size_t count)
 {
@@ -205,11 +280,17 @@ static ssize_t rebind_store(struct device_driver *dev=
, const char *buf,
 	if (!bid)
 		return -ENODEV;
=20
-	ret =3D device_attach(&bid->udev->dev);
-	if (ret < 0) {
-		dev_err(&bid->udev->dev, "rebind failed\n");
+	/* mark the device for deletion so probe ignores it during rescan */
+	bid->status =3D STUB_BUSID_OTHER;
+	/* release the busid lock */
+	put_busid_priv(bid);
+
+	ret =3D do_rebind((char *) buf, bid);
+	if (ret < 0)
 		return ret;
-	}
+
+	/* delete device from busid_table */
+	del_match_busid((char *) buf);
=20
 	return count;
 }
@@ -332,6 +413,9 @@ static void __exit usbip_host_exit(void)
 	 */
 	usb_deregister_device_driver(&stub_driver);
=20
+	/* initiate scan to attach devices */
+	stub_device_rebind();
+
 	kmem_cache_destroy(stub_priv_cache);
 }
=20
diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 1472805083de..cfb29aeab495 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -413,8 +413,7 @@ static int yurex_release(struct inode *inode, struct fi=
le *file)
 static ssize_t yurex_read(struct file *file, char *buffer, size_t count, l=
off_t *ppos)
 {
 	struct usb_yurex *dev;
-	int retval =3D 0;
-	int bytes_read =3D 0;
+	int len =3D 0;
 	char in_buffer[20];
 	unsigned long flags;
=20
@@ -422,26 +421,16 @@ static ssize_t yurex_read(struct file *file, char *bu=
ffer, size_t count, loff_t
=20
 	mutex_lock(&dev->io_mutex);
 	if (!dev->interface) {		/* already disconnected */
-		retval =3D -ENODEV;
-		goto exit;
+		mutex_unlock(&dev->io_mutex);
+		return -ENODEV;
 	}
=20
 	spin_lock_irqsave(&dev->lock, flags);
-	bytes_read =3D snprintf(in_buffer, 20, "%lld\n", dev->bbu);
+	len =3D snprintf(in_buffer, 20, "%lld\n", dev->bbu);
 	spin_unlock_irqrestore(&dev->lock, flags);
-
-	if (*ppos < bytes_read) {
-		if (copy_to_user(buffer, in_buffer + *ppos, bytes_read - *ppos))
-			retval =3D -EFAULT;
-		else {
-			retval =3D bytes_read - *ppos;
-			*ppos +=3D bytes_read;
-		}
-	}
-
-exit:
 	mutex_unlock(&dev->io_mutex);
-	return retval;
+
+	return simple_read_from_buffer(buffer, count, ppos, in_buffer, len);
 }
=20
 static ssize_t yurex_write(struct file *file, const char *user_buffer, siz=
e_t count, loff_t *ppos)
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 21d2d52a3b26..db6a57dfed44 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -158,7 +158,7 @@ static void uas_mark_cmd_dead(struct uas_dev_info *devi=
nfo,
 	struct scsi_cmnd *cmnd =3D container_of(scp, struct scsi_cmnd, SCp);
=20
 	uas_log_cmd_state(cmnd, caller);
-	WARN_ON_ONCE(!spin_is_locked(&devinfo->lock));
+	lockdep_assert_held(&devinfo->lock);
 	WARN_ON_ONCE(cmdinfo->state & COMMAND_ABORTED);
 	cmdinfo->state |=3D COMMAND_ABORTED;
 	cmdinfo->state &=3D ~IS_IN_WORK_LIST;
@@ -185,7 +185,7 @@ static void uas_add_work(struct uas_cmd_info *cmdinfo)
 	struct scsi_cmnd *cmnd =3D container_of(scp, struct scsi_cmnd, SCp);
 	struct uas_dev_info *devinfo =3D cmnd->device->hostdata;
=20
-	WARN_ON_ONCE(!spin_is_locked(&devinfo->lock));
+	lockdep_assert_held(&devinfo->lock);
 	cmdinfo->state |=3D IS_IN_WORK_LIST;
 	schedule_work(&devinfo->work);
 }
@@ -287,7 +287,7 @@ static int uas_try_complete(struct scsi_cmnd *cmnd, con=
st char *caller)
 	struct uas_cmd_info *cmdinfo =3D (void *)&cmnd->SCp;
 	struct uas_dev_info *devinfo =3D (void *)cmnd->device->hostdata;
=20
-	WARN_ON_ONCE(!spin_is_locked(&devinfo->lock));
+	lockdep_assert_held(&devinfo->lock);
 	if (cmdinfo->state & (COMMAND_INFLIGHT |
 			      DATA_IN_URB_INFLIGHT |
 			      DATA_OUT_URB_INFLIGHT |
@@ -626,7 +626,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 	struct urb *urb;
 	int err;
=20
-	WARN_ON_ONCE(!spin_is_locked(&devinfo->lock));
+	lockdep_assert_held(&devinfo->lock);
 	if (cmdinfo->state & SUBMIT_STATUS_URB) {
 		urb =3D uas_submit_sense_urb(cmnd, gfp, cmdinfo->stream);
 		if (!urb)
diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 509d452e8f91..74ac73d3a0e9 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1059,7 +1059,8 @@ static int uvesafb_setcmap(struct fb_cmap *cmap, stru=
ct fb_info *info)
 		    info->cmap.len || cmap->start < info->cmap.start)
 			return -EINVAL;
=20
-		entries =3D kmalloc(sizeof(*entries) * cmap->len, GFP_KERNEL);
+		entries =3D kmalloc_array(cmap->len, sizeof(*entries),
+					GFP_KERNEL);
 		if (!entries)
 			return -ENOMEM;
=20
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 56fe6ec409ac..e0029f1a0da8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1311,18 +1311,19 @@ static void __del_reloc_root(struct btrfs_root *roo=
t)
 	struct mapping_node *node =3D NULL;
 	struct reloc_control *rc =3D root->fs_info->reloc_ctl;
=20
-	spin_lock(&rc->reloc_root_tree.lock);
-	rb_node =3D tree_search(&rc->reloc_root_tree.rb_root,
-			      root->node->start);
-	if (rb_node) {
-		node =3D rb_entry(rb_node, struct mapping_node, rb_node);
-		rb_erase(&node->rb_node, &rc->reloc_root_tree.rb_root);
+	if (rc) {
+		spin_lock(&rc->reloc_root_tree.lock);
+		rb_node =3D tree_search(&rc->reloc_root_tree.rb_root,
+				      root->node->start);
+		if (rb_node) {
+			node =3D rb_entry(rb_node, struct mapping_node, rb_node);
+			rb_erase(&node->rb_node, &rc->reloc_root_tree.rb_root);
+		}
+		spin_unlock(&rc->reloc_root_tree.lock);
+		if (!node)
+			return;
+		BUG_ON((struct btrfs_root *)node->data !=3D root);
 	}
-	spin_unlock(&rc->reloc_root_tree.lock);
-
-	if (!node)
-		return;
-	BUG_ON((struct btrfs_root *)node->data !=3D root);
=20
 	spin_lock(&root->fs_info->trans_lock);
 	list_del_init(&root->root_list);
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 0a0f8a89d425..75aa5bac77d4 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -184,7 +184,6 @@ static int ext4_init_block_bitmap(struct super_block *s=
b,
 	unsigned int bit, bit_max;
 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 	ext4_fsblk_t start, tmp;
-	int flex_bg =3D 0;
 	struct ext4_group_info *grp;
=20
 	J_ASSERT_BH(bh, buffer_locked(bh));
@@ -217,22 +216,19 @@ static int ext4_init_block_bitmap(struct super_block =
*sb,
=20
 	start =3D ext4_group_first_block_no(sb, block_group);
=20
-	if (EXT4_HAS_INCOMPAT_FEATURE(sb, EXT4_FEATURE_INCOMPAT_FLEX_BG))
-		flex_bg =3D 1;
-
 	/* Set bits for block and inode bitmaps, and inode table */
 	tmp =3D ext4_block_bitmap(sb, gdp);
-	if (!flex_bg || ext4_block_in_group(sb, tmp, block_group))
+	if (ext4_block_in_group(sb, tmp, block_group))
 		ext4_set_bit(EXT4_B2C(sbi, tmp - start), bh->b_data);
=20
 	tmp =3D ext4_inode_bitmap(sb, gdp);
-	if (!flex_bg || ext4_block_in_group(sb, tmp, block_group))
+	if (ext4_block_in_group(sb, tmp, block_group))
 		ext4_set_bit(EXT4_B2C(sbi, tmp - start), bh->b_data);
=20
 	tmp =3D ext4_inode_table(sb, gdp);
 	for (; tmp < ext4_inode_table(sb, gdp) +
 		     sbi->s_itb_per_group; tmp++) {
-		if (!flex_bg || ext4_block_in_group(sb, tmp, block_group))
+		if (ext4_block_in_group(sb, tmp, block_group))
 			ext4_set_bit(EXT4_B2C(sbi, tmp - start), bh->b_data);
 	}
=20
@@ -453,9 +449,18 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, =
ext4_group_t block_group)
 		goto verify;
 	}
 	ext4_lock_group(sb, block_group);
-	if (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)) {
+	if (ext4_has_group_desc_csum(sb) &&
+	    (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
 		int err;
=20
+		if (block_group =3D=3D 0) {
+			ext4_unlock_group(sb, block_group);
+			unlock_buffer(bh);
+			ext4_error(sb, "Block bitmap for bg 0 marked "
+				   "uninitialized");
+			put_bh(bh);
+			return NULL;
+		}
 		err =3D ext4_init_block_bitmap(sb, bh, block_group, desc);
 		set_bitmap_uptodate(bh);
 		set_buffer_uptodate(bh);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7075d70b73af..05ea39cc4b4c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1422,11 +1422,6 @@ static inline struct timespec ext4_current_time(stru=
ct inode *inode)
 static inline int ext4_valid_inum(struct super_block *sb, unsigned long in=
o)
 {
 	return ino =3D=3D EXT4_ROOT_INO ||
-		ino =3D=3D EXT4_USR_QUOTA_INO ||
-		ino =3D=3D EXT4_GRP_QUOTA_INO ||
-		ino =3D=3D EXT4_BOOT_LOADER_INO ||
-		ino =3D=3D EXT4_JOURNAL_INO ||
-		ino =3D=3D EXT4_RESIZE_INO ||
 		(ino >=3D EXT4_FIRST_INO(sb) &&
 		 ino <=3D le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count));
 }
@@ -2706,9 +2701,6 @@ extern struct buffer_head *ext4_get_first_inline_bloc=
k(struct inode *inode,
 extern int ext4_inline_data_fiemap(struct inode *inode,
 				   struct fiemap_extent_info *fieinfo,
 				   int *has_inline);
-extern int ext4_try_to_evict_inline_data(handle_t *handle,
-					 struct inode *inode,
-					 int needed);
 extern void ext4_inline_data_truncate(struct inode *inode, int *has_inline=
);
=20
 extern int ext4_convert_inline_data(struct inode *inode);
diff --git a/fs/ext4/ext4_extents.h b/fs/ext4/ext4_extents.h
index a867f5ca9991..01e72cb0ad0d 100644
--- a/fs/ext4/ext4_extents.h
+++ b/fs/ext4/ext4_extents.h
@@ -103,6 +103,7 @@ struct ext4_extent_header {
 };
=20
 #define EXT4_EXT_MAGIC		cpu_to_le16(0xf30a)
+#define EXT4_MAX_EXTENT_DEPTH 5
=20
 #define EXT4_EXTENT_TAIL_OFFSET(hdr) \
 	(sizeof(struct ext4_extent_header) + \
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d3f542a9cda8..86ac712decf8 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -851,6 +851,12 @@ ext4_ext_find_extent(struct inode *inode, ext4_lblk_t =
block,
=20
 	eh =3D ext_inode_hdr(inode);
 	depth =3D ext_depth(inode);
+	if (depth < 0 || depth > EXT4_MAX_EXTENT_DEPTH) {
+		EXT4_ERROR_INODE(inode, "inode has invalid extent depth: %d",
+				 depth);
+		ret =3D -EIO;
+		goto err;
+	}
=20
 	/* account possible depth increase */
 	if (!path) {
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 62fbd4f0ff51..bc9b595a2d6d 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -156,7 +156,16 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_gr=
oup_t block_group)
 	}
=20
 	ext4_lock_group(sb, block_group);
-	if (desc->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT)) {
+	if (ext4_has_group_desc_csum(sb) &&
+	    (desc->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT))) {
+		if (block_group =3D=3D 0) {
+			ext4_unlock_group(sb, block_group);
+			unlock_buffer(bh);
+			ext4_error(sb, "Inode bitmap for bg 0 marked "
+				   "uninitialized");
+			put_bh(bh);
+			return NULL;
+		}
 		ext4_init_inode_bitmap(sb, bh, block_group, desc);
 		set_bitmap_uptodate(bh);
 		set_buffer_uptodate(bh);
@@ -910,7 +919,8 @@ struct inode *__ext4_new_inode(handle_t *handle, struct=
 inode *dir,
=20
 		/* recheck and clear flag under lock if we still need to */
 		ext4_lock_group(sb, group);
-		if (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)) {
+		if (ext4_has_group_desc_csum(sb) &&
+		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
 			gdp->bg_flags &=3D cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
 			ext4_free_group_clusters_set(sb, gdp,
 				ext4_free_clusters_after_init(sb, group, gdp));
@@ -1279,7 +1289,10 @@ int ext4_init_inode_table(struct super_block *sb, ex=
t4_group_t group,
 			    ext4_itable_unused_count(sb, gdp)),
 			    sbi->s_inodes_per_block);
=20
-	if ((used_blks < 0) || (used_blks > sbi->s_itb_per_group)) {
+	if ((used_blks < 0) || (used_blks > sbi->s_itb_per_group) ||
+	    ((group =3D=3D 0) && ((EXT4_INODES_PER_GROUP(sb) -
+			       ext4_itable_unused_count(sb, gdp)) <
+			      EXT4_FIRST_INO(sb)))) {
 		ext4_error(sb, "Something is wrong with group %u: "
 			   "used itable blocks: %d; "
 			   "itable unused count: %u",
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2a70860a8ad3..4f91cc419e7f 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -438,6 +438,7 @@ static int ext4_destroy_inline_data_nolock(handle_t *ha=
ndle,
=20
 	memset((void *)ext4_raw_inode(&is.iloc)->i_block,
 		0, EXT4_MIN_INLINE_DATA_SIZE);
+	memset(ei->i_data, 0, EXT4_MIN_INLINE_DATA_SIZE);
=20
 	if (EXT4_HAS_INCOMPAT_FEATURE(inode->i_sb,
 				      EXT4_FEATURE_INCOMPAT_EXTENTS)) {
@@ -876,11 +877,11 @@ int ext4_da_write_inline_data_begin(struct address_sp=
ace *mapping,
 	}
=20
 	if (ret =3D=3D -ENOSPC) {
+		ext4_journal_stop(handle);
 		ret =3D ext4_da_convert_inline_data_to_extent(mapping,
 							    inode,
 							    flags,
 							    fsdata);
-		ext4_journal_stop(handle);
 		if (ret =3D=3D -ENOSPC &&
 		    ext4_should_retry_alloc(inode->i_sb, &retries))
 			goto retry_journal;
@@ -1838,42 +1839,6 @@ int ext4_inline_data_fiemap(struct inode *inode,
 	return (error < 0 ? error : 0);
 }
=20
-/*
- * Called during xattr set, and if we can sparse space 'needed',
- * just create the extent tree evict the data to the outer block.
- *
- * We use jbd2 instead of page cache to move data to the 1st block
- * so that the whole transaction can be committed as a whole and
- * the data isn't lost because of the delayed page cache write.
- */
-int ext4_try_to_evict_inline_data(handle_t *handle,
-				  struct inode *inode,
-				  int needed)
-{
-	int error;
-	struct ext4_xattr_entry *entry;
-	struct ext4_inode *raw_inode;
-	struct ext4_iloc iloc;
-
-	error =3D ext4_get_inode_loc(inode, &iloc);
-	if (error)
-		return error;
-
-	raw_inode =3D ext4_raw_inode(&iloc);
-	entry =3D (struct ext4_xattr_entry *)((void *)raw_inode +
-					    EXT4_I(inode)->i_inline_off);
-	if (EXT4_XATTR_LEN(entry->e_name_len) +
-	    EXT4_XATTR_SIZE(le32_to_cpu(entry->e_value_size)) < needed) {
-		error =3D -ENOSPC;
-		goto out;
-	}
-
-	error =3D ext4_convert_inline_data_nolock(handle, inode, &iloc);
-out:
-	brelse(iloc.bh);
-	return error;
-}
-
 void ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 {
 	handle_t *handle;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e90fa513c14c..72213cfa8aae 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3957,7 +3957,8 @@ static int __ext4_get_inode_loc(struct inode *inode,
 	int			inodes_per_block, inode_offset;
=20
 	iloc->bh =3D NULL;
-	if (!ext4_valid_inum(sb, inode->i_ino))
+	if (inode->i_ino < EXT4_ROOT_INO ||
+	    inode->i_ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))
 		return -EIO;
=20
 	iloc->block_group =3D (inode->i_ino - 1) / EXT4_INODES_PER_GROUP(sb);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f64958efcc62..15e8ab88dfc6 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2418,7 +2418,8 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext=
4_group_t group,
 	 * initialize bb_free to be able to skip
 	 * empty groups without initialization
 	 */
-	if (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)) {
+	if (ext4_has_group_desc_csum(sb) &&
+	    (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
 		meta_group_info[i]->bb_free =3D
 			ext4_free_clusters_after_init(sb, group, desc);
 	} else {
@@ -2943,7 +2944,8 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_co=
ntext *ac,
 #endif
 	ext4_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
 		      ac->ac_b_ex.fe_len);
-	if (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)) {
+	if (ext4_has_group_desc_csum(sb) &&
+	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
 		gdp->bg_flags &=3D cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
 		ext4_free_group_clusters_set(sb, gdp,
 					     ext4_free_clusters_after_init(sb,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ca1036fb0971..92b47444728b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2086,6 +2086,7 @@ static int ext4_check_descriptors(struct super_block =
*sb,
 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 	ext4_fsblk_t first_block =3D le32_to_cpu(sbi->s_es->s_first_data_block);
 	ext4_fsblk_t last_block;
+	ext4_fsblk_t last_bg_block =3D sb_block + ext4_bg_num_gdb(sb, 0);
 	ext4_fsblk_t block_bitmap;
 	ext4_fsblk_t inode_bitmap;
 	ext4_fsblk_t inode_table;
@@ -2115,6 +2116,16 @@ static int ext4_check_descriptors(struct super_block=
 *sb,
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Block bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
+		}
+		if (block_bitmap >=3D sb_block + 1 &&
+		    block_bitmap <=3D last_bg_block) {
+			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
+				 "Block bitmap for group %u overlaps "
+				 "block group descriptors", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (block_bitmap < first_block || block_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2127,6 +2138,16 @@ static int ext4_check_descriptors(struct super_block=
 *sb,
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
+		}
+		if (inode_bitmap >=3D sb_block + 1 &&
+		    inode_bitmap <=3D last_bg_block) {
+			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
+				 "Inode bitmap for group %u overlaps "
+				 "block group descriptors", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (inode_bitmap < first_block || inode_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2139,6 +2160,16 @@ static int ext4_check_descriptors(struct super_block=
 *sb,
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode table for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
+		}
+		if (inode_table >=3D sb_block + 1 &&
+		    inode_table <=3D last_bg_block) {
+			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
+				 "Inode table for group %u overlaps "
+				 "block group descriptors", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (inode_table < first_block ||
 		    inode_table + sbi->s_itb_per_group - 1 > last_block) {
@@ -3080,6 +3111,9 @@ static ext4_group_t ext4_has_uninit_itable(struct sup=
er_block *sb)
 	ext4_group_t group, ngroups =3D EXT4_SB(sb)->s_groups_count;
 	struct ext4_group_desc *gdp =3D NULL;
=20
+	if (!ext4_has_group_desc_csum(sb))
+		return ngroups;
+
 	for (group =3D 0; group < ngroups; group++) {
 		gdp =3D ext4_get_group_desc(sb, group, NULL);
 		if (!gdp)
@@ -3737,6 +3771,11 @@ static int ext4_fill_super(struct super_block *sb, v=
oid *data, int silent)
 	} else {
 		sbi->s_inode_size =3D le16_to_cpu(es->s_inode_size);
 		sbi->s_first_ino =3D le32_to_cpu(es->s_first_ino);
+		if (sbi->s_first_ino < EXT4_GOOD_OLD_FIRST_INO) {
+			ext4_msg(sb, KERN_ERR, "invalid first ino: %u",
+				 sbi->s_first_ino);
+			goto failed_mount;
+		}
 		if ((sbi->s_inode_size < EXT4_GOOD_OLD_INODE_SIZE) ||
 		    (!is_power_of_2(sbi->s_inode_size)) ||
 		    (sbi->s_inode_size > blocksize)) {
@@ -3953,6 +3992,7 @@ static int ext4_fill_super(struct super_block *sb, vo=
id *data, int silent)
 			goto failed_mount2;
 		}
 	}
+	sbi->s_gdb_count =3D db_count;
 	if (!ext4_check_descriptors(sb, logical_sb_block, &first_not_zeroed)) {
 		ext4_msg(sb, KERN_ERR, "group descriptors corrupted!");
 		goto failed_mount2;
@@ -3965,7 +4005,6 @@ static int ext4_fill_super(struct super_block *sb, vo=
id *data, int silent)
 			goto failed_mount2;
 		}
=20
-	sbi->s_gdb_count =3D db_count;
 	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 	spin_lock_init(&sbi->s_next_gen_lock);
=20
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index d6c9cacf8fed..887611069625 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -213,12 +213,12 @@ ext4_xattr_check_block(struct inode *inode, struct bu=
ffer_head *bh)
 {
 	int error;
=20
-	if (buffer_verified(bh))
-		return 0;
-
 	if (BHDR(bh)->h_magic !=3D cpu_to_le32(EXT4_XATTR_MAGIC) ||
 	    BHDR(bh)->h_blocks !=3D cpu_to_le32(1))
 		return -EIO;
+	if (buffer_verified(bh))
+		return 0;
+
 	if (!ext4_xattr_block_csum_verify(inode, bh))
 		return -EIO;
 	error =3D ext4_xattr_check_names(BFIRST(bh), bh->b_data + bh->b_size,
@@ -610,14 +610,20 @@ static size_t ext4_xattr_free_space(struct ext4_xattr=
_entry *last,
 }
=20
 static int
-ext4_xattr_set_entry(struct ext4_xattr_info *i, struct ext4_xattr_search *=
s)
+ext4_xattr_set_entry(struct ext4_xattr_info *i, struct ext4_xattr_search *=
s,
+		     struct inode *inode)
 {
-	struct ext4_xattr_entry *last;
+	struct ext4_xattr_entry *last, *next;
 	size_t free, min_offs =3D s->end - s->base, name_len =3D strlen(i->name);
=20
 	/* Compute min_offs and last. */
 	last =3D s->first;
-	for (; !IS_LAST_ENTRY(last); last =3D EXT4_XATTR_NEXT(last)) {
+	for (; !IS_LAST_ENTRY(last); last =3D next) {
+		next =3D EXT4_XATTR_NEXT(last);
+		if ((void *)next >=3D s->end) {
+			EXT4_ERROR_INODE(inode, "corrupted xattr entries");
+			return -EIO;
+		}
 		if (!last->e_value_block && last->e_value_size) {
 			size_t offs =3D le16_to_cpu(last->e_value_offs);
 			if (offs < min_offs)
@@ -798,7 +804,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *in=
ode,
 				ce =3D NULL;
 			}
 			ea_bdebug(bs->bh, "modifying in-place");
-			error =3D ext4_xattr_set_entry(i, s);
+			error =3D ext4_xattr_set_entry(i, s, inode);
 			if (!error) {
 				if (!IS_LAST_ENTRY(s->first))
 					ext4_xattr_rehash(header(s->base),
@@ -851,7 +857,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *in=
ode,
 		s->end =3D s->base + sb->s_blocksize;
 	}
=20
-	error =3D ext4_xattr_set_entry(i, s);
+	error =3D ext4_xattr_set_entry(i, s, inode);
 	if (error =3D=3D -EIO)
 		goto bad_block;
 	if (error)
@@ -1021,23 +1027,9 @@ int ext4_xattr_ibody_inline_set(handle_t *handle, st=
ruct inode *inode,
=20
 	if (EXT4_I(inode)->i_extra_isize =3D=3D 0)
 		return -ENOSPC;
-	error =3D ext4_xattr_set_entry(i, s);
-	if (error) {
-		if (error =3D=3D -ENOSPC &&
-		    ext4_has_inline_data(inode)) {
-			error =3D ext4_try_to_evict_inline_data(handle, inode,
-					EXT4_XATTR_LEN(strlen(i->name) +
-					EXT4_XATTR_SIZE(i->value_len)));
-			if (error)
-				return error;
-			error =3D ext4_xattr_ibody_find(inode, i, is);
-			if (error)
-				return error;
-			error =3D ext4_xattr_set_entry(i, s);
-		}
-		if (error)
-			return error;
-	}
+	error =3D ext4_xattr_set_entry(i, s, inode);
+	if (error)
+		return error;
 	header =3D IHDR(inode, ext4_raw_inode(&is->iloc));
 	if (!IS_LAST_ENTRY(s->first)) {
 		header->h_magic =3D cpu_to_le32(EXT4_XATTR_MAGIC);
@@ -1059,7 +1051,7 @@ static int ext4_xattr_ibody_set(handle_t *handle, str=
uct inode *inode,
=20
 	if (EXT4_I(inode)->i_extra_isize =3D=3D 0)
 		return -ENOSPC;
-	error =3D ext4_xattr_set_entry(i, s);
+	error =3D ext4_xattr_set_entry(i, s, inode);
 	if (error)
 		return error;
 	header =3D IHDR(inode, ext4_raw_inode(&is->iloc));
@@ -1364,6 +1356,11 @@ int ext4_expand_extra_isize_ea(struct inode *inode, =
int new_extra_isize,
 		/* Find the entry best suited to be pushed into EA block */
 		entry =3D NULL;
 		for (; !IS_LAST_ENTRY(last); last =3D EXT4_XATTR_NEXT(last)) {
+			/* never move system.data out of the inode */
+			if ((last->e_name_len =3D=3D 4) &&
+			    (last->e_name_index =3D=3D EXT4_XATTR_INDEX_SYSTEM) &&
+			    !memcmp(last->e_name, "data", 4))
+				continue;
 			total_size =3D
 			EXT4_XATTR_SIZE(le32_to_cpu(last->e_value_size)) +
 					EXT4_XATTR_LEN(last->e_name_len);
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 610a3260bef1..cb16945db429 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -74,13 +74,13 @@ static struct dentry *hfsplus_lookup(struct inode *dir,=
 struct dentry *dentry,
 				cpu_to_be32(HFSP_HARDLINK_TYPE) &&
 				entry.file.user_info.fdCreator =3D=3D
 				cpu_to_be32(HFSP_HFSPLUS_CREATOR) &&
+				HFSPLUS_SB(sb)->hidden_dir &&
 				(entry.file.create_date =3D=3D
 					HFSPLUS_I(HFSPLUS_SB(sb)->hidden_dir)->
 						create_date ||
 				entry.file.create_date =3D=3D
 					HFSPLUS_I(sb->s_root->d_inode)->
-						create_date) &&
-				HFSPLUS_SB(sb)->hidden_dir) {
+						create_date)) {
 			struct qstr str;
 			char name[32];
=20
diff --git a/fs/inode.c b/fs/inode.c
index f5a842698580..2eba072f7857 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1827,8 +1827,14 @@ void inode_init_owner(struct inode *inode, const str=
uct inode *dir,
 	inode->i_uid =3D current_fsuid();
 	if (dir && dir->i_mode & S_ISGID) {
 		inode->i_gid =3D dir->i_gid;
+
+		/* Directories are special, and always inherit S_ISGID */
 		if (S_ISDIR(mode))
 			mode |=3D S_ISGID;
+		else if ((mode & (S_ISGID | S_IXGRP)) =3D=3D (S_ISGID | S_IXGRP) &&
+			 !in_group_p(inode->i_gid) &&
+			 !capable_wrt_inode_uidgid(dir, CAP_FSETID))
+			mode &=3D ~S_ISGID;
 	} else
 		inode->i_gid =3D current_fsgid();
 	inode->i_mode =3D mode;
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 3a5c29a5733d..3ab84e02c6dd 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1288,11 +1288,11 @@ int jbd2_journal_dirty_metadata(handle_t *handle, s=
truct buffer_head *bh)
 		 * of the transaction. This needs to be done
 		 * once a transaction -bzzz
 		 */
-		jh->b_modified =3D 1;
 		if (handle->h_buffer_credits <=3D 0) {
 			ret =3D -ENOSPC;
 			goto out_unlock_bh;
 		}
+		jh->b_modified =3D 1;
 		handle->h_buffer_credits--;
 	}
=20
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 46325d5c34fc..405e8c42cb1a 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -493,15 +493,17 @@ static int ea_get(struct inode *inode, struct ea_buff=
er *ea_buf, int min_size)
 	if (size > PSIZE) {
 		/*
 		 * To keep the rest of the code simple.  Allocate a
-		 * contiguous buffer to work with
+		 * contiguous buffer to work with. Make the buffer large
+		 * enough to make use of the whole extent.
 		 */
-		ea_buf->xattr =3D kmalloc(size, GFP_KERNEL);
+		ea_buf->max_size =3D (size + sb->s_blocksize - 1) &
+		    ~(sb->s_blocksize - 1);
+
+		ea_buf->xattr =3D kmalloc(ea_buf->max_size, GFP_KERNEL);
 		if (ea_buf->xattr =3D=3D NULL)
 			return -ENOMEM;
=20
 		ea_buf->flag =3D EA_MALLOC;
-		ea_buf->max_size =3D (size + sb->s_blocksize - 1) &
-		    ~(sb->s_blocksize - 1);
=20
 		if (ea_size =3D=3D 0)
 			return 0;
diff --git a/fs/xfs/xfs_attr_leaf.c b/fs/xfs/xfs_attr_leaf.c
index 26aa249529c2..671561468612 100644
--- a/fs/xfs/xfs_attr_leaf.c
+++ b/fs/xfs/xfs_attr_leaf.c
@@ -701,9 +701,8 @@ xfs_attr_shortform_to_leaf(xfs_da_args_t *args)
 	ASSERT(blkno =3D=3D 0);
 	error =3D xfs_attr3_leaf_create(args, blkno, &bp);
 	if (error) {
-		error =3D xfs_da_shrink_inode(args, 0, bp);
-		bp =3D NULL;
-		if (error)
+		/* xfs_attr3_leaf_create may not have instantiated a block */
+		if (bp && (xfs_da_shrink_inode(args, 0, bp) !=3D 0))
 			goto out;
 		xfs_idata_realloc(dp, size, XFS_ATTR_FORK);	/* try to put */
 		memcpy(ifp->if_u1.if_data, tmpbuffer, size);	/* it back */
diff --git a/fs/xfs/xfs_bmap.c b/fs/xfs/xfs_bmap.c
index 94a5c1914fb3..74af99f9cd20 100644
--- a/fs/xfs/xfs_bmap.c
+++ b/fs/xfs/xfs_bmap.c
@@ -822,6 +822,8 @@ xfs_bmap_extents_to_btree(
 	*logflagsp =3D 0;
 	if ((error =3D xfs_alloc_vextent(&args))) {
 		xfs_iroot_realloc(ip, -1, whichfork);
+		ASSERT(ifp->if_broot =3D=3D NULL);
+		XFS_IFORK_FMT_SET(ip, whichfork, XFS_DINODE_FMT_EXTENTS);
 		xfs_btree_del_cursor(cur, XFS_BTREE_ERROR);
 		return error;
 	}
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index c48df5f25b9f..c30e5946f3a3 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -132,6 +132,46 @@ xfs_inode_free(
 	call_rcu(&VFS_I(ip)->i_rcu, xfs_inode_free_callback);
 }
=20
+/*
+ * If we are allocating a new inode, then check what was returned is
+ * actually a free, empty inode. If we are not allocating an inode,
+ * then check we didn't find a free inode.
+ *
+ * Returns:
+ *	0		if the inode free state matches the lookup context
+ *	ENOENT		if the inode is free and we are not allocating
+ *	EFSCORRUPTED	if there is any state mismatch at all
+ */
+static int
+xfs_iget_check_free_state(
+	struct xfs_inode	*ip,
+	int			flags)
+{
+	if (flags & XFS_IGET_CREATE) {
+		/* should be a free inode */
+		if (ip->i_d.di_mode !=3D 0) {
+			xfs_warn(ip->i_mount,
+"Corruption detected! Free inode 0x%llx not marked free! (mode 0x%x)",
+				ip->i_ino, ip->i_d.di_mode);
+			return EFSCORRUPTED;
+		}
+
+		if (ip->i_d.di_nblocks !=3D 0) {
+			xfs_warn(ip->i_mount,
+"Corruption detected! Free inode 0x%llx has blocks allocated!",
+				ip->i_ino);
+			return EFSCORRUPTED;
+		}
+		return 0;
+	}
+
+	/* should be an allocated inode */
+	if (ip->i_d.di_mode =3D=3D 0)
+		return ENOENT;
+
+	return 0;
+}
+
 /*
  * Check the validity of the inode we just found it the cache
  */
@@ -181,12 +221,12 @@ xfs_iget_cache_hit(
 	}
=20
 	/*
-	 * If lookup is racing with unlink return an error immediately.
+	 * Check the inode free state is valid. This also detects lookup
+	 * racing with unlinks.
 	 */
-	if (ip->i_d.di_mode =3D=3D 0 && !(flags & XFS_IGET_CREATE)) {
-		error =3D ENOENT;
+	error =3D xfs_iget_check_free_state(ip, flags);
+	if (error)
 		goto out_error;
-	}
=20
 	/*
 	 * If IRECLAIMABLE is set, we've torn down the VFS inode already.
@@ -293,10 +333,14 @@ xfs_iget_cache_miss(
=20
 	trace_xfs_iget_miss(ip);
=20
-	if ((ip->i_d.di_mode =3D=3D 0) && !(flags & XFS_IGET_CREATE)) {
-		error =3D ENOENT;
+
+	/*
+	 * Check the inode free state is valid. This also detects lookup
+	 * racing with unlinks.
+	 */
+	error =3D xfs_iget_check_free_state(ip, flags);
+	if (error)
 		goto out_destroy;
-	}
=20
 	/*
 	 * Preload the radix tree so we can insert safely under the
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 489c1307f81e..f9466c152c5d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -345,7 +345,7 @@ struct kioctx_table;
 struct mm_struct {
 	struct vm_area_struct *mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
-	u32 vmacache_seqnum;                   /* per-thread vmacache */
+	u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
 	unsigned long (*get_unmapped_area) (struct file *filp,
 				unsigned long addr, unsigned long len,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 34af72b8b296..982f752bff30 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1291,7 +1291,7 @@ struct task_struct {
 	unsigned brk_randomized:1;
 #endif
 	/* per-thread vma caching */
-	u32 vmacache_seqnum;
+	u64 vmacache_seqnum;
 	struct vm_area_struct *vmacache[VMACACHE_SIZE];
 #if defined(SPLIT_RSS_COUNTING)
 	struct task_rss_stat	rss_stat;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2b2db0828ffc..6fe6f0818cf9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -866,4 +866,6 @@ asmlinkage long sys_process_vm_writev(pid_t pid,
 asmlinkage long sys_kcmp(pid_t pid1, pid_t pid2, int type,
 			 unsigned long idx1, unsigned long idx2);
 asmlinkage long sys_finit_module(int fd, const char __user *uargs, int fla=
gs);
+asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
+			    const char __user *uargs);
 #endif
diff --git a/include/linux/vmacache.h b/include/linux/vmacache.h
index c3fa0fd43949..4f58ff2dacd6 100644
--- a/include/linux/vmacache.h
+++ b/include/linux/vmacache.h
@@ -15,7 +15,6 @@ static inline void vmacache_flush(struct task_struct *tsk)
 	memset(tsk->vmacache, 0, sizeof(tsk->vmacache));
 }
=20
-extern void vmacache_flush_all(struct mm_struct *mm);
 extern void vmacache_update(unsigned long addr, struct vm_area_struct *new=
vma);
 extern struct vm_area_struct *vmacache_find(struct mm_struct *mm,
 						    unsigned long addr);
@@ -29,10 +28,6 @@ extern struct vm_area_struct *vmacache_find_exact(struct=
 mm_struct *mm,
 static inline void vmacache_invalidate(struct mm_struct *mm)
 {
 	mm->vmacache_seqnum++;
-
-	/* deal with overflows */
-	if (unlikely(mm->vmacache_seqnum =3D=3D 0))
-		vmacache_flush_all(mm);
 }
=20
 #endif /* __LINUX_VMACACHE_H */
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/u=
nistd.h
index 333640608087..65acbf0e2867 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -699,9 +699,11 @@ __SYSCALL(__NR_sched_setattr, sys_sched_setattr)
 __SYSCALL(__NR_sched_getattr, sys_sched_getattr)
 #define __NR_renameat2 276
 __SYSCALL(__NR_renameat2, sys_renameat2)
+#define __NR_seccomp 277
+__SYSCALL(__NR_seccomp, sys_seccomp)
=20
 #undef __NR_syscalls
-#define __NR_syscalls 277
+#define __NR_syscalls 278
=20
 /*
  * All syscalls below here should go away really,
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index ac2dc9f72973..b258878ba754 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -10,6 +10,10 @@
 #define SECCOMP_MODE_STRICT	1 /* uses hard-coded filter. */
 #define SECCOMP_MODE_FILTER	2 /* uses user-supplied filter. */
=20
+/* Valid operations for seccomp syscall. */
+#define SECCOMP_SET_MODE_STRICT	0
+#define SECCOMP_SET_MODE_FILTER	1
+
 /*
  * All BPF programs must return a 32-bit value.
  * The bottom 16-bits are for optional return data.
diff --git a/kernel/futex.c b/kernel/futex.c
index 2be8625d47fc..0ee2f54d74fb 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -394,6 +394,7 @@ get_futex_key(u32 __user *uaddr, int fshared, union fut=
ex_key *key, int rw)
 	unsigned long address =3D (unsigned long)uaddr;
 	struct mm_struct *mm =3D current->mm;
 	struct page *page, *page_head;
+	struct address_space *mapping;
 	int err, ro =3D 0;
=20
 	/*
@@ -472,7 +473,19 @@ get_futex_key(u32 __user *uaddr, int fshared, union fu=
tex_key *key, int rw)
 	}
 #endif
=20
-	lock_page(page_head);
+	/*
+	 * The treatment of mapping from this point on is critical. The page
+	 * lock protects many things but in this context the page lock
+	 * stabilizes mapping, prevents inode freeing in the shared
+	 * file-backed region case and guards against movement to swap cache.
+	 *
+	 * Strictly speaking the page lock is not needed in all cases being
+	 * considered here and page lock forces unnecessarily serialization
+	 * From this point on, mapping will be re-verified if necessary and
+	 * page lock will be acquired only if it is unavoidable
+	 */
+
+	mapping =3D ACCESS_ONCE(page_head->mapping);
=20
 	/*
 	 * If page_head->mapping is NULL, then it cannot be a PageAnon
@@ -489,18 +502,31 @@ get_futex_key(u32 __user *uaddr, int fshared, union f=
utex_key *key, int rw)
 	 * shmem_writepage move it from filecache to swapcache beneath us:
 	 * an unlikely race, but we do need to retry for page_head->mapping.
 	 */
-	if (!page_head->mapping) {
-		int shmem_swizzled =3D PageSwapCache(page_head);
+	if (unlikely(!mapping)) {
+		int shmem_swizzled;
+
+		/*
+		 * Page lock is required to identify which special case above
+		 * applies. If this is really a shmem page then the page lock
+		 * will prevent unexpected transitions.
+		 */
+		lock_page(page);
+		shmem_swizzled =3D PageSwapCache(page) || page->mapping;
 		unlock_page(page_head);
 		put_page(page_head);
+
 		if (shmem_swizzled)
 			goto again;
+
 		return -EFAULT;
 	}
=20
 	/*
 	 * Private mappings are handled in a simple way.
 	 *
+	 * If the futex key is stored on an anonymous page, then the associated
+	 * object is the mm which is implicitly pinned by the calling process.
+	 *
 	 * NOTE: When userspace waits on a MAP_SHARED mapping, even if
 	 * it's a read-only handle, it's expected that futexes attach to
 	 * the object not the particular process.
@@ -518,16 +544,75 @@ get_futex_key(u32 __user *uaddr, int fshared, union f=
utex_key *key, int rw)
 		key->both.offset |=3D FUT_OFF_MMSHARED; /* ref taken on mm */
 		key->private.mm =3D mm;
 		key->private.address =3D address;
+
+		get_futex_key_refs(key); /* implies smp_mb(); (B) */
+
 	} else {
+		struct inode *inode;
+
+		/*
+		 * The associated futex object in this case is the inode and
+		 * the page->mapping must be traversed. Ordinarily this should
+		 * be stabilised under page lock but it's not strictly
+		 * necessary in this case as we just want to pin the inode, not
+		 * update the radix tree or anything like that.
+		 *
+		 * The RCU read lock is taken as the inode is finally freed
+		 * under RCU. If the mapping still matches expectations then the
+		 * mapping->host can be safely accessed as being a valid inode.
+		 */
+		rcu_read_lock();
+
+		if (ACCESS_ONCE(page_head->mapping) !=3D mapping) {
+			rcu_read_unlock();
+			put_page(page_head);
+
+			goto again;
+		}
+
+		inode =3D ACCESS_ONCE(mapping->host);
+		if (!inode) {
+			rcu_read_unlock();
+			put_page(page_head);
+
+			goto again;
+		}
+
+		/*
+		 * Take a reference unless it is about to be freed. Previously
+		 * this reference was taken by ihold under the page lock
+		 * pinning the inode in place so i_lock was unnecessary. The
+		 * only way for this check to fail is if the inode was
+		 * truncated in parallel which is almost certainly an
+		 * application bug. In such a case, just retry.
+		 *
+		 * We are not calling into get_futex_key_refs() in file-backed
+		 * cases, therefore a successful atomic_inc return below will
+		 * guarantee that get_futex_key() will still imply smp_mb(); (B).
+		 */
+		if (!atomic_inc_not_zero(&inode->i_count)) {
+			rcu_read_unlock();
+			put_page(page_head);
+
+			goto again;
+		}
+
+		/* Should be impossible but lets be paranoid for now */
+		if (WARN_ON_ONCE(inode->i_mapping !=3D mapping)) {
+			err =3D -EFAULT;
+			rcu_read_unlock();
+			iput(inode);
+
+			goto out;
+		}
+
 		key->both.offset |=3D FUT_OFF_INODE; /* inode-based key */
-		key->shared.inode =3D page_head->mapping->host;
+		key->shared.inode =3D inode;
 		key->shared.pgoff =3D basepage_index(page);
+		rcu_read_unlock();
 	}
=20
-	get_futex_key_refs(key); /* implies MB (B) */
-
 out:
-	unlock_page(page_head);
 	put_page(page_head);
 	return err;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index e2eb71b1e970..d2596136b0d1 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -18,6 +18,7 @@
 #include <linux/compat.h>
 #include <linux/sched.h>
 #include <linux/seccomp.h>
+#include <linux/syscalls.h>
=20
 /* #define SECCOMP_DEBUG 1 */
=20
@@ -194,7 +195,23 @@ static u32 seccomp_run_filters(int syscall)
 	}
 	return ret;
 }
+#endif /* CONFIG_SECCOMP_FILTER */
=20
+static inline bool seccomp_may_assign_mode(unsigned long seccomp_mode)
+{
+	if (current->seccomp.mode && current->seccomp.mode !=3D seccomp_mode)
+		return false;
+
+	return true;
+}
+
+static inline void seccomp_assign_mode(unsigned long seccomp_mode)
+{
+	current->seccomp.mode =3D seccomp_mode;
+	set_tsk_thread_flag(current, TIF_SECCOMP);
+}
+
+#ifdef CONFIG_SECCOMP_FILTER
 /**
  * seccomp_attach_filter: Attaches a seccomp filter to current.
  * @fprog: BPF program to install
@@ -298,7 +315,7 @@ static long seccomp_attach_filter(struct sock_fprog *fp=
rog)
  *
  * Returns 0 on success and non-zero otherwise.
  */
-static long seccomp_attach_user_filter(char __user *user_filter)
+static long seccomp_attach_user_filter(const char __user *user_filter)
 {
 	struct sock_fprog fprog;
 	long ret =3D -EFAULT;
@@ -473,47 +490,126 @@ long prctl_get_seccomp(void)
 }
=20
 /**
- * prctl_set_seccomp: configures current->seccomp.mode
- * @seccomp_mode: requested mode to use
- * @filter: optional struct sock_fprog for use with SECCOMP_MODE_FILTER
+ * seccomp_set_mode_strict: internal function for setting strict seccomp
+ *
+ * Once current->seccomp.mode is non-zero, it may not be changed.
+ *
+ * Returns 0 on success or -EINVAL on failure.
+ */
+static long seccomp_set_mode_strict(void)
+{
+	const unsigned long seccomp_mode =3D SECCOMP_MODE_STRICT;
+	long ret =3D -EINVAL;
+
+	if (!seccomp_may_assign_mode(seccomp_mode))
+		goto out;
+
+#ifdef TIF_NOTSC
+	disable_TSC();
+#endif
+	seccomp_assign_mode(seccomp_mode);
+	ret =3D 0;
+
+out:
+
+	return ret;
+}
+
+#ifdef CONFIG_SECCOMP_FILTER
+/**
+ * seccomp_set_mode_filter: internal function for setting seccomp filter
+ * @flags:  flags to change filter behavior
+ * @filter: struct sock_fprog containing filter
  *
- * This function may be called repeatedly with a @seccomp_mode of
- * SECCOMP_MODE_FILTER to install additional filters.  Every filter
- * successfully installed will be evaluated (in reverse order) for each sy=
stem
- * call the task makes.
+ * This function may be called repeatedly to install additional filters.
+ * Every filter successfully installed will be evaluated (in reverse order)
+ * for each system call the task makes.
  *
  * Once current->seccomp.mode is non-zero, it may not be changed.
  *
  * Returns 0 on success or -EINVAL on failure.
  */
-long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
+static long seccomp_set_mode_filter(unsigned int flags,
+				    const char __user *filter)
 {
+	const unsigned long seccomp_mode =3D SECCOMP_MODE_FILTER;
 	long ret =3D -EINVAL;
=20
-	if (current->seccomp.mode &&
-	    current->seccomp.mode !=3D seccomp_mode)
+	/* Validate flags. */
+	if (flags !=3D 0)
+		goto out;
+
+	if (!seccomp_may_assign_mode(seccomp_mode))
+		goto out;
+
+	ret =3D seccomp_attach_user_filter(filter);
+	if (ret)
 		goto out;
=20
+	seccomp_assign_mode(seccomp_mode);
+out:
+	return ret;
+}
+#else
+static inline long seccomp_set_mode_filter(unsigned int flags,
+					   const char __user *filter)
+{
+	return -EINVAL;
+}
+#endif
+
+/* Common entry point for both prctl and syscall. */
+static long do_seccomp(unsigned int op, unsigned int flags,
+		       const char __user *uargs)
+{
+	switch (op) {
+	case SECCOMP_SET_MODE_STRICT:
+		if (flags !=3D 0 || uargs !=3D NULL)
+			return -EINVAL;
+		return seccomp_set_mode_strict();
+	case SECCOMP_SET_MODE_FILTER:
+		return seccomp_set_mode_filter(flags, uargs);
+	default:
+		return -EINVAL;
+	}
+}
+
+SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
+			 const char __user *, uargs)
+{
+	return do_seccomp(op, flags, uargs);
+}
+
+/**
+ * prctl_set_seccomp: configures current->seccomp.mode
+ * @seccomp_mode: requested mode to use
+ * @filter: optional struct sock_fprog for use with SECCOMP_MODE_FILTER
+ *
+ * Returns 0 on success or -EINVAL on failure.
+ */
+long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
+{
+	unsigned int op;
+	char __user *uargs;
+
 	switch (seccomp_mode) {
 	case SECCOMP_MODE_STRICT:
-		ret =3D 0;
-#ifdef TIF_NOTSC
-		disable_TSC();
-#endif
+		op =3D SECCOMP_SET_MODE_STRICT;
+		/*
+		 * Setting strict mode through prctl always ignored filter,
+		 * so make sure it is always NULL here to pass the internal
+		 * check in do_seccomp().
+		 */
+		uargs =3D NULL;
 		break;
-#ifdef CONFIG_SECCOMP_FILTER
 	case SECCOMP_MODE_FILTER:
-		ret =3D seccomp_attach_user_filter(filter);
-		if (ret)
-			goto out;
+		op =3D SECCOMP_SET_MODE_FILTER;
+		uargs =3D filter;
 		break;
-#endif
 	default:
-		goto out;
+		return -EINVAL;
 	}
=20
-	current->seccomp.mode =3D seccomp_mode;
-	set_thread_flag(TIF_SECCOMP);
-out:
-	return ret;
+	/* prctl interface doesn't have flags, so they are always zero. */
+	return do_seccomp(op, 0, uargs);
 }
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 36441b51b5df..2904a2105914 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -213,3 +213,6 @@ cond_syscall(compat_sys_open_by_handle_at);
=20
 /* compare kernel pointers */
 cond_syscall(sys_kcmp);
+
+/* operate on Secure Computing state */
+cond_syscall(sys_seccomp);
diff --git a/mm/vmacache.c b/mm/vmacache.c
index 9f25af825dec..e6e6e92d0d72 100644
--- a/mm/vmacache.c
+++ b/mm/vmacache.c
@@ -5,42 +5,6 @@
 #include <linux/mm.h>
 #include <linux/vmacache.h>
=20
-/*
- * Flush vma caches for threads that share a given mm.
- *
- * The operation is safe because the caller holds the mmap_sem
- * exclusively and other threads accessing the vma cache will
- * have mmap_sem held at least for read, so no extra locking
- * is required to maintain the vma cache.
- */
-void vmacache_flush_all(struct mm_struct *mm)
-{
-	struct task_struct *g, *p;
-
-	/*
-	 * Single threaded tasks need not iterate the entire
-	 * list of process. We can avoid the flushing as well
-	 * since the mm's seqnum was increased and don't have
-	 * to worry about other threads' seqnum. Current's
-	 * flush will occur upon the next lookup.
-	 */
-	if (atomic_read(&mm->mm_users) =3D=3D 1)
-		return;
-
-	rcu_read_lock();
-	for_each_process_thread(g, p) {
-		/*
-		 * Only flush the vmacache pointers as the
-		 * mm seqnum is already set and curr's will
-		 * be set upon invalidation when the next
-		 * lookup is done.
-		 */
-		if (mm =3D=3D p->mm)
-			vmacache_flush(p);
-	}
-	rcu_read_unlock();
-}
-
 /*
  * This task may be accessing a foreign mm via (for example)
  * get_user_pages()->find_vma().  The vmacache is task-local and this
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 32400034fed4..e989356ad905 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -429,8 +429,8 @@ static void hidp_del_timer(struct hidp_session *session)
 		del_timer(&session->timer);
 }
=20
-static void hidp_process_report(struct hidp_session *session,
-				int type, const u8 *data, int len, int intr)
+static void hidp_process_report(struct hidp_session *session, int type,
+				const u8 *data, unsigned int len, int intr)
 {
 	if (len > HID_MAX_BUFFER_SIZE)
 		len =3D HID_MAX_BUFFER_SIZE;
diff --git a/net/core/sock.c b/net/core/sock.c
index ee26a0af2327..ed7372c744b3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1512,6 +1512,8 @@ struct sock *sk_clone_lock(const struct sock *sk, con=
st gfp_t priority)
=20
 		sock_copy(newsk, sk);
=20
+		newsk->sk_prot_creator =3D sk->sk_prot;
+
 		/* SANITY */
 		get_net(sock_net(newsk));
 		sk_node_init(&newsk->sk_node);
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index b4fc9e710308..778ee1bf40ad 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -359,6 +359,7 @@ static int vti_tunnel_init(struct net_device *dev)
 	memcpy(dev->dev_addr, &iph->saddr, 4);
 	memcpy(dev->broadcast, &iph->daddr, 4);
=20
+	dev->mtu		=3D ETH_DATA_LEN;
 	dev->flags		=3D IFF_NOARP;
 	dev->iflink		=3D 0;
 	dev->addr_len		=3D 4;
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index c7ff09ed6768..2bd5b8524181 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -645,7 +645,7 @@ static int snd_rawmidi_info_select_user(struct snd_card=
 *card,
 int snd_rawmidi_output_params(struct snd_rawmidi_substream *substream,
 			      struct snd_rawmidi_params * params)
 {
-	char *newbuf;
+	char *newbuf, *oldbuf;
 	struct snd_rawmidi_runtime *runtime =3D substream->runtime;
 =09
 	if (substream->append && substream->use_count > 1)
@@ -658,13 +658,17 @@ int snd_rawmidi_output_params(struct snd_rawmidi_subs=
tream *substream,
 		return -EINVAL;
 	}
 	if (params->buffer_size !=3D runtime->buffer_size) {
-		newbuf =3D krealloc(runtime->buffer, params->buffer_size,
-				  GFP_KERNEL);
+		newbuf =3D kmalloc(params->buffer_size, GFP_KERNEL);
 		if (!newbuf)
 			return -ENOMEM;
+		spin_lock_irq(&runtime->lock);
+		oldbuf =3D runtime->buffer;
 		runtime->buffer =3D newbuf;
 		runtime->buffer_size =3D params->buffer_size;
 		runtime->avail =3D runtime->buffer_size;
+		runtime->appl_ptr =3D runtime->hw_ptr =3D 0;
+		spin_unlock_irq(&runtime->lock);
+		kfree(oldbuf);
 	}
 	runtime->avail_min =3D params->avail_min;
 	substream->active_sensing =3D !params->no_active_sensing;
@@ -675,7 +679,7 @@ EXPORT_SYMBOL(snd_rawmidi_output_params);
 int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 			     struct snd_rawmidi_params * params)
 {
-	char *newbuf;
+	char *newbuf, *oldbuf;
 	struct snd_rawmidi_runtime *runtime =3D substream->runtime;
=20
 	snd_rawmidi_drain_input(substream);
@@ -686,12 +690,16 @@ int snd_rawmidi_input_params(struct snd_rawmidi_subst=
ream *substream,
 		return -EINVAL;
 	}
 	if (params->buffer_size !=3D runtime->buffer_size) {
-		newbuf =3D krealloc(runtime->buffer, params->buffer_size,
-				  GFP_KERNEL);
+		newbuf =3D kmalloc(params->buffer_size, GFP_KERNEL);
 		if (!newbuf)
 			return -ENOMEM;
+		spin_lock_irq(&runtime->lock);
+		oldbuf =3D runtime->buffer;
 		runtime->buffer =3D newbuf;
 		runtime->buffer_size =3D params->buffer_size;
+		runtime->appl_ptr =3D runtime->hw_ptr =3D 0;
+		spin_unlock_irq(&runtime->lock);
+		kfree(oldbuf);
 	}
 	runtime->avail_min =3D params->avail_min;
 	return 0;

--gTtJ75FAzB1T2CN6--

--qLni7iB6Dl8qUSwk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBW61Tj+e/yOyVhhEJAQpvjw//VCNTj5JVjyOR/ofGJzngowYhFzqJ/z+J
viS8No1e0hZJ02vD+5QNIaOfu8vOgUQ6rtO7QP157UurPAjyRb12uUrfrt1Ppyb8
vYITckXzyFA8he2QlXkaMZrORyZgOU7hddZhiEzuGwayg14fpPYffnu9G4Ir28BY
faJCZreesLtuAmWdKpSbL1OZJ+Zz1xBwbwJmHa4heAq5oB/K8oMCGTxTyXQB4oKb
BtceFWQZFHDhaezZSjP14ytdPdKUWAerzjP4aKBX1574nGPHvAtajxcrLY4pUrLi
K5AMZ3tm7f9lHhbBeTRHwNyVCkFX3yuaJ0/deBU7LLVjvMVkY5lNgpeu4LUWrF0b
nMrblUdNu6bK/esDoiEjyatVTNEGGrrAEFjhpf2dmlPSYECE9vFR6mxvJ+LvZZ4+
uq5XFvWSDGbDfOxk5+kCuYorBIPWQoZRx6QoqTwEVWeCWBf2SU0qJaI8T7O667+7
tRX2Br4H+kcLj8Jm3jk2Uak9n7Zjlq/LdKx6cpqVgWZkfjvXRIMVUfVhhmhkylDT
cZV3IsYTeOdmMsRohfLW5vq8Lgx0DQH2aSOu9t/M4YJVlgCjnisXHjn4DI7QjwYC
RLRbJHZxB8LdT5UElCyMwqvZPH0kkr8Lol9i+szxPcwmcJWdlemRo/pDDeEPp/2u
xuoCRl8tQ/Q=
=fNma
-----END PGP SIGNATURE-----

--qLni7iB6Dl8qUSwk--
