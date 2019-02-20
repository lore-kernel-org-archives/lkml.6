Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D09C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAB72089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550656569;
	bh=4WnAQydWqDm/LcqSykB7CjY/3i0QNtWJZWRp1TTbv2g=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=w6DTAT+16uYP3gNeQxjljnid5ATli+PrqYuN/GmqcwxBO/0az0mTqZ7bewk5xD/6p
	 37goqEVY4/VfBrFVMpw8bWbgx+992FaUa1tn8LoB3rwSu7+HhkS/dlXTbYY5n4dpYJ
	 lQZ08vVv4nw/8VJimPpsq9EUPF8rzyECUrVXEF+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfBTJ4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbfBTJ4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:56:07 -0500
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BD392089F;
        Wed, 20 Feb 2019 09:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550656566;
        bh=4WnAQydWqDm/LcqSykB7CjY/3i0QNtWJZWRp1TTbv2g=;
        h=Date:From:To:Cc:Subject:From;
        b=aHL8kqQ98oygVGURgmrveBoTxt8+UjasC6NDFyZFRZ2Jcf0M4i4B8uZarCgE7yZnI
         PeBSCo38TCbhq92piKX8eZ/JpwWoLTB7IkXugUS/m09MP+qANP9EiFMX5xyG5gzy7a
         B89y9Gaam/XaPf/40IXy9Vx44lYtvbPQNHofEfVg=
Date:   Wed, 20 Feb 2019 10:56:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.102
Message-ID: <20190220095601.GA15193@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.102 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/eeprom/eeprom.txt |    5 -
 Makefile                                            |    2=20
 arch/alpha/include/asm/irq.h                        |    6 -
 arch/alpha/mm/fault.c                               |    2=20
 arch/arm/boot/dts/da850-evm.dts                     |    2=20
 arch/arm/boot/dts/da850-lcdk.dts                    |    2=20
 arch/arm/boot/dts/kirkwood-dnskw.dtsi               |    4 -
 arch/arm/include/asm/assembler.h                    |   11 ++
 arch/arm/include/asm/cputype.h                      |    1=20
 arch/arm/include/asm/proc-fns.h                     |   61 ++++++++++++---
 arch/arm/include/asm/thread_info.h                  |    4 -
 arch/arm/include/asm/uaccess.h                      |   49 ++++++++++--
 arch/arm/kernel/bugs.c                              |    4 -
 arch/arm/kernel/head-common.S                       |    6 -
 arch/arm/kernel/setup.c                             |   40 ++++++----
 arch/arm/kernel/signal.c                            |   80 +++++++++++----=
-----
 arch/arm/kernel/smp.c                               |   31 +++++++
 arch/arm/kernel/sys_oabi-compat.c                   |    8 +-
 arch/arm/lib/copy_from_user.S                       |    6 -
 arch/arm/lib/copy_to_user.S                         |    6 +
 arch/arm/lib/uaccess_with_memcpy.c                  |    3=20
 arch/arm/mach-integrator/impd1.c                    |    6 +
 arch/arm/mm/proc-macros.S                           |   10 ++
 arch/arm/mm/proc-v7-bugs.c                          |   17 ----
 arch/arm/vfp/vfpmodule.c                            |   20 ++---
 arch/x86/events/core.c                              |   14 +++
 arch/x86/events/intel/core.c                        |    9 ++
 arch/x86/events/perf_event.h                        |   16 +++-
 arch/x86/ia32/ia32_aout.c                           |    6 +
 arch/x86/include/asm/uv/bios.h                      |    8 +-
 arch/x86/kvm/vmx.c                                  |    3=20
 arch/x86/platform/uv/bios_uv.c                      |   23 +++++
 block/blk-flush.c                                   |    2=20
 drivers/acpi/numa.c                                 |    6 -
 drivers/cpufreq/cpufreq.c                           |   12 +--
 drivers/firmware/efi/runtime-wrappers.c             |    7 +
 drivers/gpu/drm/bridge/tc358767.c                   |   41 ++++++++--
 drivers/gpu/drm/i915/i915_gem.c                     |   12 ++-
 drivers/gpu/drm/nouveau/nvkm/engine/falcon.c        |    7 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c    |    7 +
 drivers/input/misc/bma150.c                         |    9 +-
 drivers/input/mouse/elan_i2c_core.c                 |    2=20
 drivers/input/mouse/elantech.c                      |    9 ++
 drivers/md/dm-crypt.c                               |    2=20
 drivers/md/dm-thin.c                                |   55 ++++++++++++-
 drivers/md/raid1.c                                  |   29 ++++---
 drivers/misc/eeprom/Kconfig                         |    2=20
 drivers/misc/eeprom/at24.c                          |    1=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c    |   18 ++++
 drivers/nvme/host/pci.c                             |   10 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                  |   23 ++++-
 fs/cifs/file.c                                      |    8 ++
 fs/cifs/smb2file.c                                  |    4 +
 fs/proc/task_mmu.c                                  |   22 +++--
 include/linux/perf_event.h                          |    5 +
 include/linux/skbuff.h                              |   16 ++++
 include/trace/events/sched.h                        |   12 ++-
 include/uapi/linux/if_ether.h                       |    7 +
 kernel/events/core.c                                |   16 ++++
 kernel/events/ring_buffer.c                         |    2=20
 kernel/futex.c                                      |   69 +++++++++++++++=
--
 kernel/signal.c                                     |    7 +
 kernel/trace/trace_uprobe.c                         |    9 ++
 net/core/skbuff.c                                   |   63 ++++++++++++---
 net/sched/sch_tbf.c                                 |   10 --
 sound/pci/hda/patch_conexant.c                      |    1=20
 sound/usb/pcm.c                                     |    9 ++
 tools/perf/tests/shell/lib/probe_vfs_getname.sh     |    3=20
 68 files changed, 747 insertions(+), 235 deletions(-)

Adrian Bunk (2):
      dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string
      eeprom: at24: add support for 24c2048

Andreas Ziegler (1):
      tracing/uprobes: Fix output for multiple string arguments

Arnaldo Carvalho de Melo (1):
      perf test shell: Use a fallback to get the pathname in vfs_getname

Borislav Petkov (1):
      x86/a.out: Clear the dump structure initially

Chao Fan (1):
      ACPI: NUMA: Use correct type for printing addresses on i386-PAE

Christian Lamparter (1):
      pinctrl: msm: fix gpio-hog related boot issues

Daniel Axtens (2):
      net: create skb_gso_validate_mac_len()
      bnx2x: disable GSO where gso_size is too big for hardware

Dmitry Torokhov (1):
      Revert "Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-=
573G"

Eric W. Biederman (1):
      signal: Restore the stop PTRACE_EVENT_EXIT

Greg Kroah-Hartman (1):
      Linux 4.14.102

Hauke Mehrtens (2):
      uapi/if_ether.h: prevent redefinition of struct ethhdr
      uapi/if_ether.h: move __UAPI_DEF_ETHHDR libc define

Hedi Berriche (1):
      x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls

Ilia Mirkin (1):
      drm/nouveau/falcon: avoid touching registers if engine is off

Ingo Molnar (1):
      perf/core: Fix impossible ring-buffer sizes warning

Jianchao Wang (1):
      blk-mq: fix a hung issue when fsync

Jiri Olsa (1):
      perf/x86: Add check_period PMU callback

Jonathan Bakker (1):
      Input: bma150 - register input device after setting private data

Joonas Lahtinen (1):
      drm/i915: Prevent a race during I915_GEM_MMAP ioctl with WC set

Julien Thierry (10):
      ARM: 8789/1: signal: copy registers using __copy_to_user()
      ARM: 8790/1: signal: always use __copy_to_user to save iwmmxt context
      ARM: 8791/1: vfp: use __copy_to_user() when saving VFP state
      ARM: 8792/1: oabi-compat: copy oabi events using __copy_to_user()
      ARM: 8793/1: signal: replace __put_user_error with __put_user
      ARM: 8794/1: uaccess: Prevent speculative use of the current addr_lim=
it
      ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()
      ARM: 8796/1: spectre-v1,v1.1: provide helpers for address sanitization
      ARM: 8797/1: spectre-v1.1: harden __copy_to_user
      ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc

Jurica Vukadin (1):
      ALSA: hda - Add quirk for HP EliteBook 840 G5

Linus Walleij (1):
      ARM: dts: kirkwood: Fix polarity of GPIO fan lines

Liviu Dudau (1):
      nvme-pci: use the same attributes when freeing host_mem_desc_bufs.

Manuel Reinhardt (1):
      ALSA: usb-audio: Fix implicit fb endpoint setup by quirk

Matti Kurkela (1):
      Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780

Mauro Ciancio (1):
      Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK

Meelis Roos (1):
      alpha: Fix Eiger NR_IRQS to 128

Mikulas Patocka (1):
      dm crypt: don't overallocate the integrity tag space

Nate Dailey (1):
      md/raid1: don't clear bitmap bits on interrupted recovery.

Nicholas Mc Guire (1):
      gpio: pl061: handle failed allocations

Nikos Tsironis (1):
      dm thin: fix bug where bio that overwrites thin block ignores FUA

Pavankumar Kondeti (1):
      sched, trace: Fix prev_state output in sched_switch tracepoint

Peter Ujfalusi (2):
      ARM: dts: da850-evm: Correct the sound card name
      ARM: dts: da850-lcdk: Correct the sound card name

Ross Lagerwall (1):
      cifs: Limit memory used by lock request calls to a page

Russell King (7):
      ARM: make lookup_processor_type() non-__init
      ARM: split out processor lookup
      ARM: clean up per-processor check_bugs method call
      ARM: add PROC_VTABLE and PROC_TABLE macros
      ARM: spectre-v2: per-CPU vtables to work around big.Little systems
      ARM: ensure that processor vtables is not lost after boot
      ARM: fix the cockup in the previous patch

Sandeep Patil (1):
      mm: proc: smaps_rollup: fix pss_locked calculation

Sergei Trofimovich (1):
      alpha: fix page fault handling for r16-r18 targets

Sudeep Holla (1):
      cpufreq: check if policy is inactive early in __cpufreq_get()

Takashi Iwai (1):
      drm/nouveau: Don't disable polling in fallback mode

Thomas Gleixner (1):
      futex: Cure exit race

Tomi Valkeinen (5):
      drm/bridge: tc358767: add defines for DP1_SRCCTRL & PHY_2LANE
      drm/bridge: tc358767: fix single lane configuration
      drm/bridge: tc358767: fix initial DP0/1_SRCCTRL value
      drm/bridge: tc358767: reject modes which require too much BW
      drm/bridge: tc358767: fix output H/V syncs

Xiaoyao Li (1):
      kvm: vmx: Fix entry number check for add_atomic_switch_msr()


--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxtJDEACgkQONu9yGCS
aT5FohAAyadlw+ZjHh5krR7X1bIDex/BVsPrZ6inpgr9n+XVFep8WLKE9tXsAWcw
Dd0kjd4lZ/9x/55HscOGhlyUnaymvfPhO69IYbNgxtOz/ZgkYyEpdpearn0QbR1F
tw84KFx0vPriUyVs6qon7ciLhdnJekF/MgpdLwTudjSHVOdpzFNVjstL49tfuBAH
dKHzO5bML12y4qu5k3bg3Ok97oUl2qgAX84h4fWrO8rUScFBKbgj53Ra6NoJ9aPJ
vuJeTWqS3nqs1tDHTd9hmIoFaQ7Bs9jBa02I2h954x5QKd3Dw/XJebDzar/Slx96
1xN9XPFlRnEc77ErWveynRGPFlQ9+sIDbbeiF6bq6M6jNykOhm0n9AHqlQhZRGww
RkZG09yylPsY2bfajBLrYS8nYbj+3umUw8lYITfaz9jDalTqd2KR5ol2GnamF7/L
c0U1JnAq3Pk/FzrkjrANausg+mJQ5peRmy3G+VwDhRbJ+tvBiZGX4OuvB8xtNxo1
ad5k1hKqWeFFGenY4ZTec9GY8v3siDg8EpznyrcPl4t+X6uZ4DJgM2vQgZgEheFW
2H/W+100DJgcM3aR2ZklrscchbJwUSlRxK/0wF3wsjCl65XoTq+LuCIIHcVbBAO0
zV8gqiMZWsQu9a6u8UCMlEQifqLLRznJUhs+9RGRv+/t1Ig+y/c=
=aHBr
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
