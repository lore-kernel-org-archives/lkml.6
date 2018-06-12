Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 292D6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C20208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5VSXW6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C20208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935028AbeFLQwe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934655AbeFLQwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:52:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92716208B4;
        Tue, 12 Jun 2018 16:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822351;
        bh=ks9N9bx5kZJBcHeLbuIjf/wR7C6OKLbQ5VHeOQNXLg8=;
        h=From:To:Cc:Subject:Date:From;
        b=H5VSXW6pTP8nRgKSwF6ck1taeewu+5IqqhUPaVWT+nn3OFPaQ0wWnRVHODu/VZN1W
         HUZGXONJOaOq1nyjXoTqD9YhMaCCRQVi+tP5akW6LJpBc6aMsRDXJc6zDSBSpUlEF9
         B7wDXYfqCOxQ6xaM3lIxHs7mv8CVG1S9eATH1qP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/24] 4.4.137-stable review
Date:   Tue, 12 Jun 2018 18:51:44 +0200
Message-Id: <20180612164816.587001852@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.137-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.137-rc1
X-KernelTest-Deadline: 2018-06-14T16:48+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.137 release.
There are 24 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jun 14 16:48:07 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.137-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.137-rc1

Eric Dumazet <edumazet@google.com>
    net: metrics: add proper netlink validation

Florian Fainelli <f.fainelli@gmail.com>
    net: phy: broadcom: Fix bcm_write_exp()

Eric Dumazet <edumazet@google.com>
    rtnetlink: validate attributes in do_setlink()

Dan Carpenter <dan.carpenter@oracle.com>
    team: use netdev_features_t instead of u32

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4: Fix irq-unsafe spinlock usage

Shahed Shaikh <shahed.shaikh@cavium.com>
    qed: Fix mask for physical address in ILT entry

Willem de Bruijn <willemb@google.com>
    packet: fix reserve calculation

Daniele Palmas <dnlplm@gmail.com>
    net: usb: cdc_mbim: add flag FLAG_SEND_ZLP

Eric Dumazet <edumazet@google.com>
    net/packet: refine check for priv area size

Cong Wang <xiyou.wangcong@gmail.com>
    netdev-FAQ: clarify DaveM's position for stable backports

Wenwen Wang <wang6495@umn.edu>
    isdn: eicon: fix a missing-check bug

Willem de Bruijn <willemb@google.com>
    ipv4: remove warning in ip_recv_error

Sabrina Dubroca <sd@queasysnail.net>
    ip6mr: only set ip6mr_table from setsockopt when ip6mr_new_table succeeds

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: set DMA mask to 47 bit

Alexey Kodanev <alexey.kodanev@oracle.com>
    dccp: don't free ccid2_hc_tx_sock struct in dccp_disconnect()

Julia Lawall <Julia.Lawall@lip6.fr>
    bnx2x: use the right constant

Stefan Wahren <stefan.wahren@i2se.com>
    brcmfmac: Fix check for ISO3166 code

Dave Airlie <airlied@redhat.com>
    drm: set FMODE_UNSIGNED_OFFSET for drm files

Amir Goldstein <amir73il@gmail.com>
    xfs: fix incorrect log_flushed on fsync

Nathan Chancellor <natechancellor@gmail.com>
    kconfig: Avoid format overflow warning from GCC 8.1

Linus Torvalds <torvalds@linux-foundation.org>
    mmap: relax file size limit for regular files

Linus Torvalds <torvalds@linux-foundation.org>
    mmap: introduce sane default mmap limits

Chris Chiu <chiu@endlessm.com>
    tpm: self test failure should not cause suspend to fail

Enric Balletbo i Serra <enric.balletbo@collabora.com>
    tpm: do not suspend/resume if power stays on


-------------

Diffstat:

 Documentation/networking/netdev-FAQ.txt            |  9 ++++++
 Makefile                                           |  4 +--
 drivers/char/tpm/tpm-chip.c                        | 13 +++++++++
 drivers/char/tpm/tpm-interface.c                   |  7 +++++
 drivers/char/tpm/tpm.h                             |  1 +
 drivers/gpu/drm/drm_fops.c                         |  1 +
 drivers/isdn/hardware/eicon/diva.c                 | 22 ++++++++++-----
 drivers/isdn/hardware/eicon/diva.h                 |  5 ++--
 drivers/isdn/hardware/eicon/divasmain.c            | 18 +++++++-----
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c   |  2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |  8 +++---
 drivers/net/ethernet/mellanox/mlx4/qp.c            |  4 +--
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |  2 +-
 drivers/net/phy/bcm-cygnus.c                       |  6 ++--
 drivers/net/phy/bcm-phy-lib.h                      |  7 +++++
 drivers/net/phy/bcm7xxx.c                          |  4 +--
 drivers/net/team/team.c                            |  3 +-
 drivers/net/usb/cdc_mbim.c                         |  2 +-
 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c |  2 +-
 fs/xfs/xfs_log.c                                   |  7 -----
 mm/mmap.c                                          | 32 ++++++++++++++++++++++
 net/core/rtnetlink.c                               |  8 +++---
 net/dccp/proto.c                                   |  2 --
 net/ipv4/fib_semantics.c                           |  2 ++
 net/ipv4/ip_sockglue.c                             |  2 --
 net/ipv6/ip6mr.c                                   |  3 +-
 net/packet/af_packet.c                             |  4 +--
 scripts/kconfig/confdata.c                         |  2 +-
 28 files changed, 129 insertions(+), 53 deletions(-)


