Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEB7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81B1214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTYbkCmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81B1214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeK1GRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbeK1GRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:17:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40932148E;
        Tue, 27 Nov 2018 19:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543346318;
        bh=sSQdbjlKDKe3k7/BxfmVtFQc2MLmk3Rj0dfm/gCIZyw=;
        h=Date:From:To:Cc:Subject:From;
        b=QTYbkCmfhvbYgvpV+Nh2eZtpgnF+6rVDEGoxFNcNSNtX8kpIKoOJybzSlRAnawWlR
         U4NxrbOITz+4oTetSLzIPIQyxk+7NLcvGiq/+9Jm4JfhA0d6AEfdHCQ/Rp/QTXya/L
         ZG0j5e0ROQnNnnK87jMpbHpMgUkyy6QImdSQ800Y=
Date:   Tue, 27 Nov 2018 20:18:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.84
Message-ID: <20181127191835.GA1799@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.84 kernel.

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

 Documentation/admin-guide/kernel-parameters.txt   |    6 -
 Documentation/x86/x86_64/mm.txt                   |   10 +
 Makefile                                          |    2=20
 arch/arm64/include/asm/percpu.h                   |    3=20
 arch/arm64/kernel/probes/kprobes.c                |   27 +++--
 arch/mips/configs/cavium_octeon_defconfig         |    1=20
 arch/s390/kernel/perf_cpum_cf.c                   |    2=20
 arch/s390/kernel/vdso32/Makefile                  |    6 -
 arch/s390/kernel/vdso64/Makefile                  |    6 -
 arch/s390/numa/numa.c                             |    1=20
 arch/um/os-Linux/skas/process.c                   |    5=20
 arch/x86/include/asm/page_64_types.h              |   12 +-
 arch/x86/include/asm/pgtable_64_types.h           |    7 -
 arch/x86/kernel/early_printk.c                    |   29 +++--
 arch/x86/kernel/ldt.c                             |   49 ++++++---
 arch/x86/xen/mmu_pv.c                             |    6 -
 drivers/acpi/acpi_platform.c                      |    1=20
 drivers/acpi/acpi_watchdog.c                      |   72 ++++++++-----
 drivers/block/zram/zram_drv.c                     |   26 +---
 drivers/clk/clk-fixed-factor.c                    |    1=20
 drivers/clk/clk-fixed-rate.c                      |    1=20
 drivers/clk/samsung/clk-exynos5420.c              |    1=20
 drivers/gpu/drm/drm_edid.c                        |    3=20
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c     |    9 -
 drivers/gpu/drm/exynos/exynos_drm_crtc.c          |   11 --
 drivers/gpu/drm/exynos/exynos_drm_drv.h           |    1=20
 drivers/hid/uhid.c                                |   12 ++
 drivers/hwmon/ibmpowernv.c                        |    7 -
 drivers/media/v4l2-core/v4l2-event.c              |   43 ++++----
 drivers/misc/atmel-ssc.c                          |    2=20
 drivers/misc/sgi-gru/grukdump.c                   |    4=20
 drivers/net/ethernet/intel/i40e/i40e_main.c       |    2=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c    |    4=20
 drivers/net/ethernet/qlogic/qed/qed_sp.h          |    3=20
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c |   16 ++-
 drivers/net/ethernet/qlogic/qed/qed_spq.c         |   69 ++++++------
 drivers/net/ethernet/stmicro/stmmac/common.h      |    3=20
 drivers/net/ethernet/stmicro/stmmac/descs_com.h   |    2=20
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    |    2=20
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c   |    2=20
 drivers/platform/x86/acerhdf.c                    |    1=20
 drivers/platform/x86/intel_telemetry_debugfs.c    |    8 +
 drivers/s390/net/qeth_l3_main.c                   |    8 -
 drivers/uio/uio.c                                 |    7 -
 drivers/usb/class/cdc-acm.c                       |    3=20
 drivers/usb/core/quirks.c                         |    8 +
 drivers/usb/misc/appledisplay.c                   |    1=20
 fs/cifs/cifsfs.c                                  |    7 -
 fs/cifs/smb2ops.c                                 |   11 +-
 fs/exofs/super.c                                  |    5=20
 fs/hfs/brec.c                                     |    4=20
 fs/hfsplus/brec.c                                 |    4=20
 fs/reiserfs/xattr.c                               |    7 +
 include/linux/netfilter/ipset/ip_set.h            |    2=20
 include/linux/netfilter/ipset/ip_set_comment.h    |    4=20
 kernel/sched/core.c                               |    5=20
 lib/raid6/test/Makefile                           |    4=20
 net/ceph/messenger.c                              |   12 +-
 net/netfilter/ipset/ip_set_core.c                 |   23 ++--
 net/netfilter/ipset/ip_set_hash_netportnet.c      |    8 -
 net/netfilter/ipset/ip_set_list_set.c             |   17 ++-
 net/netfilter/xt_IDLETIMER.c                      |   20 +++
 net/sunrpc/xdr.c                                  |    2=20
 security/apparmor/lib.c                           |    6 -
 tools/perf/jvmti/jvmti_agent.c                    |   49 +++++++--
 tools/perf/tests/code-reading.c                   |    1=20
 tools/perf/util/env.c                             |   32 ++++++
 tools/perf/util/env.h                             |    4=20
 tools/perf/util/machine.c                         |  117 +++++++++++++++++=
++++-
 tools/perf/util/machine.h                         |    6 +
 tools/perf/util/symbol-elf.c                      |   12 ++
 tools/perf/util/symbol.c                          |   12 +-
 72 files changed, 624 insertions(+), 255 deletions(-)

Aaro Koskinen (1):
      MIPS: OCTEON: cavium_octeon_defconfig: re-enable OCTEON USB driver

Adrian Hunter (5):
      perf machine: Add machine__is() to identify machine arch
      perf tools: Fix kernel_start for PTI on x86
      perf machine: Add nr_cpus_avail()
      perf machine: Workaround missing maps for x86 PTI entry trampolines
      perf test code-reading: Fix perf_env setup for PTI entry trampolines

Alan Tull (1):
      clk: fixed-rate: fix of_node_get-put imbalance

Anders Roxell (1):
      arm64: kprobe: make page to RO mode when allocate it

Chengguang Xu (1):
      fs/exofs: fix potential memory leak in mount option parsing

Colin Ian King (1):
      cifs: don't dereference smb_file_target before null check

Dan Carpenter (1):
      uio: Fix an Oops on load

David Miller (1):
      perf symbols: Set PLT entry/header sizes properly on Sparc

Denis Bolotin (2):
      qed: Fix memory/entry leak in qed_init_sp_request()
      qed: Fix blocking/unlimited SPQ entries leak

Emmanuel Pescosta (1):
      usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB

Eric Biggers (1):
      HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges

Eric Westbrook (1):
      netfilter: ipset: actually allow allowable CIDR 0 in hash:net,port,net

Ernesto A. Fern=E1ndez (2):
      hfs: prevent btree data loss on root split
      hfsplus: prevent btree data loss on root split

Feng Tang (1):
      x86/earlyprintk: Add a force option for pciserial device

Geert Uytterhoeven (1):
      hwmon: (ibmpowernv) Remove bogus __init annotations

Greg Kroah-Hartman (1):
      Linux 4.14.84

Gustavo A. R. Silva (1):
      drivers/misc/sgi-gru: fix Spectre v1 vulnerability

Gustavo Romero (1):
      perf tools: Fix undefined symbol scnprintf in libperf-jvmti.so

Hans de Goede (1):
      ACPI / platform: Add SMB0001 HID to forbidden_id_list

Ilya Dryomov (1):
      libceph: fall back to sendmsg for slab pages

Inki Dae (1):
      Revert "drm/exynos/decon5433: implement frame counter"

Jacob Keller (1):
      i40e: restore NETIF_F_GSO_IPXIP[46] to netdev features

Jann Horn (1):
      reiserfs: propagate errors from fill_with_dentries() properly

Jeremy Linton (1):
      lib/raid6: Fix arm64 test build

Jozsef Kadlecsik (1):
      netfilter: ipset: Correct rcu_dereference() call in ip_set_put_commen=
t()

Julian Wiedmann (1):
      s390/qeth: fix HiperSockets sniffer

Justin M. Forbes (1):
      s390/mm: Fix ERROR: "__node_distance" undefined!

Kai-Heng Feng (1):
      USB: quirks: Add no-lpm quirk for Raydium touchscreens

Kirill A. Shutemov (2):
      x86/mm: Move LDT remap out of KASLR region on 5-level paging
      x86/ldt: Unmap PTEs for the slot before freeing LDT pages

Lee, Shawn C (1):
      drm/edid: Add 6 bpc quirk for BOE panel.

Maarten Jacobs (1):
      usb: cdc-acm: add entry for Hiro (Conexant) modem

Marek Szyprowski (1):
      clk: samsung: exynos5420: Enable PERIS clocks for suspend

Mattias Jacobsson (1):
      USB: misc: appledisplay: add 20" Apple Cinema Display

Mika Westerberg (1):
      ACPI / watchdog: Prefer iTCO_wdt always when WDAT table uses RTC SRAM

Minchan Kim (1):
      zram: close udev startup race condition as default groups

Nathan Chancellor (2):
      arm64: percpu: Initialize ret in the default case
      misc: atmel-ssc: Fix section annotation on atmel_ssc_get_driver_data

Paul Gortmaker (1):
      platform/x86: acerhdf: Add BIOS entry for Gateway LT31 v1.3307

Radoslaw Tyl (1):
      ixgbe: fix MAC anti-spoofing filter after VFLR

Rajneesh Bhardwaj (1):
      platform/x86: intel_telemetry: report debugfs failure

Ricardo Ribalda Delgado (1):
      clk: fixed-factor: fix of_node_get-put imbalance

Richard Weinberger (1):
      um: Give start_idle_thread() a return code

Ronnie Sahlberg (1):
      cifs: fix return value for cifs_listxattr

Sagiv Ozeri (1):
      qed: Fix potential memory corruption

Sakari Ailus (1):
      media: v4l: event: Add subscription to list before calling "add" oper=
ation

Stefano Brivio (1):
      netfilter: ipset: list:set: Decrease refcount synchronously on deleti=
on and replace

Taehee Yoo (1):
      netfilter: xt_IDLETIMER: add sysfs filename checking routine

Thomas Richter (1):
      s390/perf: Change CPUM_CF return code in event init function

Thor Thayer (1):
      net: stmmac: Fix RX packet size > 8191

Valentin Schneider (1):
      sched/core: Take the hotplug lock in sched_init_smp()

Vasily Gorbik (1):
      s390/vdso: add missing FORCE to build targets

YueHaibing (1):
      SUNRPC: drop pointless static qualifier in xdr_get_next_encode_buffer=
()

Zubin Mithra (1):
      apparmor: Fix uninitialized value in aa_split_fqname


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlv9mIsACgkQONu9yGCS
aT6kOxAAlm6BIGR1BZwnV8G++lNYAQKyTYujVsETJOTFCKJeUMAPKPltzhJgL7kB
YL9/wGRueh728jNRycc9/LMpfmv0o3anWEO3WcE3DbfyQPOMdCOhf/iJ4x7Amvag
9l0+HE6B4EGzH8RbFl8XRHm0DDwqYo3xK2a9cluY6n9hkqzOkDkFOUPVLkIANkjW
EdcWMHZ1SfFv4j0yzwEIJW2eiAD9pPSP+Wn+8D542Jz/7RUfcuJKY58a0j2Ws73l
LmXSrlp3zjY3NRS7WI80pnOtkxJG3MEEjSIi9+l3xEbHyquDy8ElQ7oxYIPYFMAN
mWBzBfnLmS135/Ge275kqP1U5Mr9wIz8Pwfr5wMMBKfV1VAXxv8ah9JihswvLN/j
vu7HC+Xd1RIdSXcjGHh3kYlhaFC8zaXNiQmc4a+rS9ZUWnMrpX3seOmdsLaqYkaz
eEO+jwobliJOkxmirnRzXFI2rSILl/DRX12J3KOog1I6S2PJQQh4liDVBDk/MkLy
shf+Q2kv0oljJHef/3EtXvsARcZd2+UP12mFYATKfx5KmgkxD3f6IfUo1f8b2aBZ
an29F1+c3crtjEsHus96NX09F1OlUbqkf2MbiIfyJB7KlJMGi7y6EsuHRjF/ep+d
txGYNdOVAxMvkiGHdvsxhymosZZwKmLvC5QU8WF7dXXWCJ7U47I=
=bxSK
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
