Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14D6C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F63222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083233;
	bh=9K6rbO8qx8C6otpoJxTXkSMOHw2vEoq6opu11erBssc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ObGRg2itcB/yBaRAfDTTb3TkmwGbDtbQP1OTsE3F5GkRe33xRrvbO0TYvn4gXIJaJ
	 K5agPhTK3HQ1LtNtNLKrRCE5rTG/Zc6DMJTWUXzEXEspOyGwPQY0jMrgH54tA5RFC/
	 KBXLD1VaPbAvE6Vx9iV+iL2TI2R00gx7rXJG4Urs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405422AbfBMSkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbfBMSka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:40:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7420C222D7;
        Wed, 13 Feb 2019 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083229;
        bh=9K6rbO8qx8C6otpoJxTXkSMOHw2vEoq6opu11erBssc=;
        h=From:To:Cc:Subject:Date:From;
        b=DT2RIAiOqU4IT4dxfjMRq5Bcf/JveXPAjPRUrJzIZI7n6u10+PVaPgkmBiPrO1lwP
         /biIVbcDzsNSUIhR9FgYGXUiWxgJdUV+djMQEz3l7Zq2Gn8V0w+miocyxBooUHpjoX
         U0y3xHI/oFp8qIDPdR5s46LLkrV0E511KhnnHUR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/24] 4.9.157-stable review
Date:   Wed, 13 Feb 2019 19:37:57 +0100
Message-Id: <20190213183647.333441569@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.157-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.157-rc1
X-KernelTest-Deadline: 2019-02-15T18:36+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.157 release.
There are 24 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Feb 15 18:36:26 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.157-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.157-rc1

Sven Eckelmann <sven@narfation.org>
    batman-adv: Force mac header to start of data on xmit

Sven Eckelmann <sven@narfation.org>
    batman-adv: Avoid WARN on net_device without parent in netns

Florian Westphal <fw@strlen.de>
    xfrm: refine validation of template and selector families

Ilya Dryomov <idryomov@gmail.com>
    libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure cifs)"

Vladis Dronov <vdronov@redhat.com>
    HID: debug: fix the ring buffer implementation

J. Bruce Fields <bfields@redhat.com>
    nfsd4: catch some false session retries

J. Bruce Fields <bfields@redhat.com>
    nfsd4: fix cached replies to solo SEQUENCE compounds

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix setting of dma masks

Tina Zhang <tina.zhang@intel.com>
    drm/modes: Prevent division by zero htotal

Felix Fietkau <nbd@nbd.name>
    mac80211: ensure that mgmt tx skbs have tailroom for encryption

Marc Gonzalez <marc.w.gonzalez@free.fr>
    ARM: tango: Improve ARCH_MULTIPLATFORM compatibility

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: iop32x/n2100: fix PCI IRQ mapping

Paul Burton <paul.burton@mips.com>
    MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds builds

Aaro Koskinen <aaro.koskinen@iki.fi>
    MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled

Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
    mips: cm: reprime error cause

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    debugfs: fix debugfs_rename parameter checking

Tomas Winkler <tomas.winkler@intel.com>
    samples: mei: use /dev/mei0 instead of /dev/mei

Dan Carpenter <dan.carpenter@oracle.com>
    misc: vexpress: Off by one in vexpress_syscfg_exec()

Eric W. Biederman <ebiederm@xmission.com>
    signal: Better detection of synchronous signals

Eric W. Biederman <ebiederm@xmission.com>
    signal: Always notice exiting tasks

Matt Ranostay <matt.ranostay@konsulko.com>
    iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsius

Martin Kepplinger <martin.kepplinger@ginzinger.com>
    mtd: rawnand: gpmi: fix MX28 bus master lockup problem


-------------

Diffstat:

 Makefile                                |   4 +-
 arch/arm/mach-iop32x/n2100.c            |   3 +-
 arch/arm/mach-tango/pm.c                |   6 +-
 arch/arm/mach-tango/pm.h                |   7 ++
 arch/arm/mach-tango/setup.c             |   2 +
 arch/mips/kernel/mips-cm.c              |   2 +-
 arch/mips/pci/pci-octeon.c              |  10 +--
 arch/mips/vdso/Makefile                 |   4 +-
 drivers/gpu/drm/drm_modes.c             |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |   9 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c |   2 +-
 drivers/hid/hid-debug.c                 | 122 +++++++++++++-------------------
 drivers/iio/chemical/atlas-ph-sensor.c  |   7 +-
 drivers/misc/vexpress-syscfg.c          |   2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c   |  15 ++--
 fs/cifs/Kconfig                         |   2 +-
 fs/debugfs/inode.c                      |   7 ++
 fs/nfsd/nfs4state.c                     |  57 +++++++++++++--
 fs/nfsd/state.h                         |   2 +
 fs/nfsd/xdr4.h                          |  13 +++-
 include/linux/hid-debug.h               |   9 ++-
 kernel/signal.c                         |  58 ++++++++++++++-
 net/batman-adv/hard-interface.c         |   5 +-
 net/batman-adv/soft-interface.c         |   2 +
 net/ceph/messenger.c                    |   5 +-
 net/mac80211/tx.c                       |  12 +++-
 net/xfrm/xfrm_user.c                    |  13 ++--
 samples/mei/mei-amt-version.c           |   2 +-
 28 files changed, 249 insertions(+), 135 deletions(-)


