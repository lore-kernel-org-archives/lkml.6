Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TndaBTX5GFvCZQAAmS7hNA
	; Thu, 07 Jun 2018 09:22:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 66F68608B8; Thu,  7 Jun 2018 09:22:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n04fjTKN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 92D3A60115;
	Thu,  7 Jun 2018 09:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92D3A60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932831AbeFGJWM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:22:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753533AbeFGJWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:22:09 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CB1E20874;
        Thu,  7 Jun 2018 09:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528363328;
        bh=Je9BmhbQstlETFnq5L/rAFRrF9+y+pNLcej0eQbyoZ4=;
        h=Date:From:To:Cc:Subject:From;
        b=n04fjTKN/WdEuz23o/rJMVctHCJYlsBaJm3mZMLZFLUyHYKr6y4fwxZcmLkgGsASz
         Y1K7Y2F9z7ati4PqsJotH2Bj5RVxuQJfv27x+W9WkPxvoZNii2x7Tn9bbup/AgI9cf
         v53a2Ri8XVGZ1tn0RTZ5ICTDgzQGEE/dpRD0jurk=
Date: Thu, 7 Jun 2018 11:21:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.107
Message-ID: <20180607092144.GA21227@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.107 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                            |    2=20
 arch/arm64/include/asm/atomic_lse.h                 |   22 -
 arch/arm64/include/asm/cpufeature.h                 |   27 +
 arch/arm64/include/asm/kvm_host.h                   |   10=20
 arch/arm64/include/asm/kvm_mmu.h                    |    2=20
 arch/arm64/include/asm/mmu.h                        |    2=20
 arch/arm64/kernel/cpufeature.c                      |   28 +-
 arch/arm64/kernel/process.c                         |    2=20
 arch/mips/kernel/process.c                          |    4=20
 arch/mips/kernel/ptrace.c                           |    2=20
 arch/mips/kernel/ptrace32.c                         |    2=20
 arch/powerpc/include/asm/exception-64s.h            |   29 ++
 arch/powerpc/include/asm/feature-fixups.h           |   19 +
 arch/powerpc/include/asm/hvcall.h                   |    3=20
 arch/powerpc/include/asm/security_features.h        |   85 ++++++
 arch/powerpc/include/asm/setup.h                    |    2=20
 arch/powerpc/kernel/Makefile                        |    2=20
 arch/powerpc/kernel/cpu_setup_power.S               |    6=20
 arch/powerpc/kernel/exceptions-64s.S                |   16 +
 arch/powerpc/kernel/security.c                      |  237 +++++++++++++++=
++
 arch/powerpc/kernel/setup_64.c                      |   37 +-
 arch/powerpc/kernel/vmlinux.lds.S                   |   14 +
 arch/powerpc/lib/feature-fixups.c                   |  124 +++++++++
 arch/powerpc/platforms/powernv/setup.c              |   92 ++++--
 arch/powerpc/platforms/pseries/mobility.c           |    3=20
 arch/powerpc/platforms/pseries/pseries.h            |    2=20
 arch/powerpc/platforms/pseries/setup.c              |   81 ++++-
 arch/sparc/kernel/ds.c                              |    2=20
 arch/sparc/lib/multi3.S                             |   24 -
 arch/x86/xen/enlighten.c                            |   14 -
 drivers/dma-buf/dma-buf.c                           |    2=20
 drivers/gpu/drm/drm_dp_helper.c                     |    1=20
 drivers/gpu/drm/i915/intel_lvds.c                   |    8=20
 drivers/hwtracing/stm/core.c                        |    7=20
 drivers/iio/buffer/kfifo_buf.c                      |    7=20
 drivers/infiniband/core/cache.c                     |    2=20
 drivers/input/mouse/elan_i2c_smbus.c                |   22 -
 drivers/irqchip/irq-gic-v3.c                        |   13=20
 drivers/net/ethernet/mellanox/mlx4/en_rx.c          |   32 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c |    3=20
 drivers/pinctrl/qcom/pinctrl-msm.c                  |    2=20
 drivers/platform/chrome/cros_ec_lpc.c               |    3=20
 drivers/scsi/scsi_transport_srp.c                   |   22 +
 drivers/scsi/ufs/ufs.h                              |   34 +-
 drivers/scsi/ufs/ufs_quirks.h                       |   28 --
 drivers/scsi/ufs/ufshcd.c                           |  272 +++++++++++++++=
-----
 drivers/scsi/ufs/ufshcd.h                           |   16 +
 drivers/tty/serial/amba-pl011.c                     |   55 ++++
 drivers/usb/serial/cp210x.c                         |    8=20
 fs/aio.c                                            |    3=20
 fs/xfs/libxfs/xfs_alloc.c                           |   94 ++++++
 fs/xfs/xfs_mount.h                                  |    1=20
 fs/xfs/xfs_trace.h                                  |    9=20
 include/linux/tcp.h                                 |    2=20
 include/uapi/linux/nl80211.h                        |    2=20
 kernel/trace/trace_events_trigger.c                 |    5=20
 mm/vmscan.c                                         |    2=20
 net/ipv4/tcp_input.c                                |   10=20
 security/integrity/ima/ima_appraise.c               |    8=20
 security/selinux/ss/services.c                      |    2=20
 sound/soc/intel/common/sst-firmware.c               |    2=20
 61 files changed, 1276 insertions(+), 296 deletions(-)

Al Viro (1):
      fix io_destroy()/aio_complete() race

Aleksey Makarov (1):
      serial: pl011: add console matching function

Alexander Shishkin (1):
      stm class: Use vmalloc for the master map

Bart Van Assche (1):
      scsi: scsi_transport_srp: Fix shost to rport translation

Benjamin Tissoires (1):
      Input: elan_i2c_smbus - fix corrupted stack

Brian Foster (1):
      xfs: detect agfl count corruption and reset agfl

Colin Ian King (3):
      dma-buf: remove redundant initialization of sg_table
      ASoC: Intel: sst: remove redundant variable dma_dev_name
      platform/chrome: cros_ec_lpc: remove redundant pointer request

David S. Miller (2):
      sparc64: Fix build warnings with gcc 7.
      sparc64: Don't clibber fixed registers in __multi4.

Dhinakaran Pandiyan (1):
      drm/psr: Fix missed entry in PSR setup time table.

Eric Biggers (1):
      cfg80211: further limit wiphy names to 64 bytes

Eric Dumazet (1):
      tcp: avoid integer overflows in tcp_rcv_space_adjust()

Geert Uytterhoeven (1):
      USB: serial: cp210x: use tcflag_t to fix incompatible pointer type

Greg Kroah-Hartman (3):
      Revert "pinctrl: msm: Use dynamic GPIO numbering"
      hwtracing: stm: fix build error on some arches
      Linux 4.9.107

Hugh Dickins (1):
      mm: fix the NULL mapping case in __isolate_lru_page()

Juergen Gross (3):
      x86/amd: revert commit 944e0fc51a89c9827b9
      xen: set cpu capabilities from xen_start_kernel()
      x86/amd: don't set X86_BUG_SYSRET_SS_ATTRS when running under Xen

Maciej W. Rozycki (2):
      MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
      MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE requests

Mark Rutland (1):
      arm64/cpufeature: don't use mutex in bringup path

Martin Kelly (1):
      iio:kfifo_buf: check for uint overflow

Matthias Kaehlcke (1):
      rtlwifi: rtl8192cu: Remove variable self-assignment in rf.c

Mauricio Faria de Oliveira (4):
      powerpc/rfi-flush: Differentiate enabled and patched flush types
      powerpc/pseries: Fix clearing of security feature flags
      powerpc: Move default security feature flags
      powerpc/pseries: Restore default security feature flags on setup

Michael Ellerman (18):
      powerpc/rfi-flush: Move out of HARDLOCKUP_DETECTOR #ifdef
      powerpc/pseries: Support firmware disable of RFI flush
      powerpc/powernv: Support firmware disable of RFI flush
      powerpc/rfi-flush: Move the logic to avoid a redo into the debugfs co=
de
      powerpc/rfi-flush: Make it possible to call setup_rfi_flush() again
      powerpc/rfi-flush: Always enable fallback flush on pseries
      powerpc/rfi-flush: Call setup_rfi_flush() after LPM migration
      powerpc/pseries: Add new H_GET_CPU_CHARACTERISTICS flags
      powerpc: Add security feature flags for Spectre/Meltdown
      powerpc/pseries: Set or clear security feature flags
      powerpc/powernv: Set or clear security feature flags
      powerpc/64s: Move cpu_show_meltdown()
      powerpc/64s: Enhance the information in cpu_show_meltdown()
      powerpc/powernv: Use the security flags in pnv_setup_rfi_flush()
      powerpc/pseries: Use the security flags in pseries_setup_rfi_flush()
      powerpc/64s: Wire up cpu_show_spectre_v1()
      powerpc/64s: Wire up cpu_show_spectre_v2()
      powerpc/64s: Fix section mismatch warnings from setup_rfi_flush()

Michael Neuling (1):
      powerpc/64s: Clear PCR on boot

Mimi Zohar (1):
      Revert "ima: limit file hash setting by user to fix and log modes"

Nicholas Piggin (1):
      powerpc/64s: Add support for a store forwarding barrier at kernel ent=
ry/exit

Ondrej Zary (1):
      drm/i915: Disable LVDS on Radiant P845

Parav Pandit (1):
      IB/core: Fix error code for invalid GID entry

Potomski, MichalX (1):
      scsi: ufs: Factor out ufshcd_read_desc_param

Sachin Grover (1):
      selinux: KASAN: slab-out-of-bounds in xattr_getsecurity

Sarah Newman (1):
      net/mlx4_en: fix potential use-after-free with dma_unmap_page

Steven Rostedt (VMware) (1):
      tracing: Fix crash when freeing instances with event triggers

Subhash Jadavani (1):
      scsi: ufs: fix failure to read the string descriptor

Suzuki K Poulose (1):
      arm64: Add hypervisor safe helper for checking constant capabilities

Tomas Winkler (1):
      scsi: ufs: refactor device descriptor reading

Will Deacon (1):
      arm64: lse: Add early clobbers to some input/output asm operands


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsY+SQACgkQONu9yGCS
aT405Q//VMgd9RJZXBBi4LgdiZLFYc01AKsCik56qJmCJLSZSaaPY6htoMibIsMd
XBXeiUvvBQjnyhzMnCOWzpW1fp89pdL+Jvqdfjt3i7/XmL8DouI6rWEIYPH/iV8o
jBF6+rdhgd39NSKdruCehNoxJ/Zz/LvmUwAqf51d/sFpY0pOQKba7k4YWsDZiayb
f+emdh91GZQNEEY/HUSea76kn6EotL86Cqhn7gJ9pnSnESXxOT4MoDVwsXnw1Yyk
GcDU3M8bKRp2pjXQYTOxg+qYML1q5EBwfCWDJ1RecadMd+mb27Qpi1GH9bv+GaiU
9CM/pEM2qerUiedEBGbLAgdh5v5DteVJaVbaHzgv2oDbJq5NUWKQYtWQVI1e7Fyf
90Dm+dM18OZ8bh5y1rL4iSFiKksvwHnJN1f6hrfMdLp8VyXwnISKZ3HthJtTCO5e
eZk/fqZnKLeW5hkk8Pr7gPntRPs7UpQe1dlL8M9LpiDLQVlAdwOForCkM8BuKU/r
ESyWiE9YU6xyCaFdCfUUi0aAY+3xHZQS0U09f/SAB/kSujcBN0n/JjtnrPJOY37M
XwXFhdhinqwnOZfKP0RJ3Bob5rCB6QXhs7ylqYNNkCTYPV2jMTdVnucbeGdWOahR
aEQWnSnXymUra8E4ZvFGaHTYJaavk4PWRNpjF5bax//XvEWgWe4=
=h3cq
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
