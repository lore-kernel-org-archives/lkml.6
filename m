Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0F3C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E1220835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l84XTO3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E1220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbeJMQen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 12:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbeJMQen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 12:34:43 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7A5A2098A;
        Sat, 13 Oct 2018 08:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539421101;
        bh=9RWKi4fffqFET7l1jvk7507tTiKGLOMamL/Y+oaVKBo=;
        h=Date:From:To:Cc:Subject:From;
        b=l84XTO3wBQMyLFfgDjYCFysbPKlrylMhyhaiSQa8in4wo0lYn2Nfup4CqWiWHr8gp
         ySc5k2mj+bIeeKXz4vP5wOiDH12jNlFoeuJB3ZrWiwIFnjw0VNx4kz2uUiMiFwpfm9
         NBTqqITD+SPokf4FCWoIzyHNskesUqTneh7JXNcg=
Date:   Sat, 13 Oct 2018 10:58:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.133
Message-ID: <20181013085818.GA27727@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.133 kernel.

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

 Documentation/kernel-parameters.txt             |    6 ---
 Makefile                                        |    2 -
 arch/arc/kernel/process.c                       |   20 ++++++++++++
 arch/powerpc/kernel/fadump.c                    |   23 +++++++++-----
 arch/x86/crypto/crc32c-intel_glue.c             |   17 ++--------
 arch/x86/entry/vdso/vclock_gettime.c            |   26 ++++++++--------
 arch/x86/include/asm/cpufeatures.h              |    1=20
 arch/x86/include/asm/fixmap.h                   |   10 ++++++
 arch/x86/include/asm/fpu/internal.h             |   37 -------------------=
---
 arch/x86/include/asm/fpu/types.h                |   34 --------------------
 arch/x86/include/asm/pgtable_64.h               |    3 +
 arch/x86/include/asm/trace/fpu.h                |    5 ---
 arch/x86/kernel/fpu/core.c                      |   39 ++-----------------=
-----
 arch/x86/kernel/fpu/signal.c                    |    8 +---
 arch/x86/kernel/fpu/xstate.c                    |    9 -----
 arch/x86/kernel/head_64.S                       |   16 +++++++--
 arch/x86/kvm/cpuid.c                            |    4 --
 arch/x86/kvm/x86.c                              |   10 ------
 arch/x86/mm/pgtable.c                           |    9 +++++
 arch/x86/mm/pkeys.c                             |    3 -
 arch/x86/xen/mmu.c                              |    8 +++-
 drivers/base/power/main.c                       |    5 ++-
 drivers/infiniband/core/ucma.c                  |    2 +
 drivers/md/dm-cache-metadata.c                  |    4 +-
 drivers/md/dm-cache-target.c                    |    9 ++++-
 drivers/net/wireless/ath/ath10k/debug.c         |   12 ++++++-
 drivers/net/wireless/ath/ath10k/trace.h         |   12 ++-----
 drivers/net/wireless/ath/ath10k/wmi-tlv.c       |    8 ++--
 drivers/net/wireless/ath/ath10k/wmi.c           |    2 -
 drivers/net/xen-netback/hash.c                  |   12 ++++---
 drivers/of/unittest.c                           |   28 +++++++++++------
 drivers/pci/pci.c                               |   27 +++++++++++-----
 drivers/tty/tty_io.c                            |   11 ++++--
 drivers/usb/host/xhci-mtk.c                     |    4 +-
 drivers/usb/host/xhci-pci.c                     |    2 +
 drivers/usb/serial/usb-serial-simple.c          |    3 +
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |    5 ++-
 fs/ext4/xattr.c                                 |   28 ++++++++++-------
 fs/f2fs/checkpoint.c                            |    9 +++--
 fs/ubifs/super.c                                |    3 +
 include/linux/netfilter_bridge/ebtables.h       |    5 +++
 kernel/cgroup.c                                 |    6 +++
 mm/vmstat.c                                     |    3 +
 net/bridge/netfilter/ebt_arpreply.c             |    3 +
 net/mac80211/cfg.c                              |    2 -
 tools/arch/x86/include/asm/cpufeatures.h        |    1=20
 46 files changed, 243 insertions(+), 253 deletions(-)

Andy Lutomirski (4):
      x86/vdso: Fix asm constraints on vDSO syscall fallbacks
      x86/vdso: Fix vDSO syscall fallback asm constraint regression
      x86/fpu: Remove use_eager_fpu()
      x86/fpu: Finish excising 'eagerfpu'

Carl Huang (1):
      ath10k: fix use-after-free in ath10k_wmi_cmd_send_nowait

Chao Yu (1):
      f2fs: fix invalid memory access

Chunfeng Yun (1):
      usb: xhci-mtk: resume USB3 roothub first

Cong Wang (1):
      ucma: fix a use-after-free in ucma_resolve_ip()

Daniel Drake (1):
      PCI: Reprogram bridge prefetch registers on resume

Dmitry Safonov (1):
      tty: Drop tty->count on tty_reopen() failure

Felix Fietkau (1):
      mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys

Feng Tang (1):
      x86/mm: Expand static page table for fixmap space

Gao Feng (1):
      ebtables: arpreply: Add the standard target sanity check

Greg Kroah-Hartman (2):
      Revert "perf: sync up x86/.../cpufeatures.h"
      Linux 4.9.133

Guenter Roeck (1):
      of: unittest: Disable interrupt node tests for old world MAC systems

Jan Beulich (1):
      xen-netback: fix input validation in xenvif_set_hash_mapping()

Jann Horn (1):
      mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly

Joe Thornber (1):
      dm cache metadata: ignore hints array being too small during resize

Johan Hovold (1):
      USB: serial: simple: add Motorola Tetra MTP6550 id

Mathias Nyman (1):
      xhci: Add missing CAS workaround for Intel Sunrise Point xHCI

Michal Suchanek (1):
      powerpc/fadump: Return error when fadump registration fails

Mike Snitzer (1):
      dm cache: fix resize crash if user doesn't reload cache table

Prateek Sood (1):
      cgroup: Fix deadlock in cpu hotplug path

Rafael J. Wysocki (1):
      PM / core: Clear the direct_complete flag on errors

Richard Weinberger (1):
      ubifs: Check for name being NULL while mounting

Rik van Riel (1):
      x86/fpu: Remove struct fpu::counter

Theodore Ts'o (2):
      ext4: add corruption check in ext4_xattr_set_entry()
      ext4: always verify the magic number in xattr blocks

Tomi Valkeinen (1):
      fbdev/omapfb: fix omapfb_memory_read infoleak

Vineet Gupta (1):
      ARC: clone syscall to setp r25 as thread pointer

Yu Wang (1):
      ath10k: fix kernel panic issue during pci probe

Zhi Chen (1):
      ath10k: fix scan crash due to incorrect length calculation


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvBs6oACgkQONu9yGCS
aT5eVg/7BvL0jkuceBo8epzlsmsxyJn2AvQnuw4DlBVAAw/qtT4ZJgpQqCduusco
dahq0PZPr+Pm5XhNb13EfRJkfv3h3/BhUxFyqtfsBxZ4IpF6PqbhXHBTc8wpqh8Y
jCf8CM56pHC95fFz+PI7MfliPvQ0aW8iUE3BcpwJDg5TEV2tJddd9CKmtPlkXGPx
FltBKLnV2jL0syq68MX+nTHUULFZZPkZ/Xm2LRASwFCDmUWnwaToej+iTEfiaA2E
4Zv57jnsI6QlSnYWFLPvx/A+eYhOnpGVkgBBvTFWTGAa6+rb4zDyhV8S+aHwfsqi
BAAq2d6ytuUQq7cb56pieaUMAVW7fAL5ubZbyjxpfF034J7DAlMktUgGut9Lm7oN
Zt4q/ZE9nSwlvmxk6SnbvA24Zp5Vcpg7SdI6Fp6M3jgGijHfXLDqgpNZ4VmdPJvT
Uecw16YxBvB2MaBLaWdP1cTDDWo0o4qTe/SUAwk7xYuOUUYux9ZSFCtSG9q0rS80
e9FtbEVLLRghq9zGfV444MaCbBiSHq9EOqnweCuzKgskzn6If4XLcoFk6mq47scd
vVQcL1x1tHY2BnCqVhfaCq23pxXcfmTI6LEMQ46vkV68Io/MQjZuKn8Vgo+37K0v
v85bt86y6ZpYpuA8CPg5PZ/ZEXD9rEPyRZjJIuYPdogIKmDLcN4=
=WqBr
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
