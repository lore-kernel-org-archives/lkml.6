Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE774C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4832174D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4832174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeHUJoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:44:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55332 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeHUJoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:44:03 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E30EB516;
        Tue, 21 Aug 2018 06:25:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.17 00/42] 4.17.18-stable review
Date:   Tue, 21 Aug 2018 08:20:32 +0200
Message-Id: <20180821055017.596264829@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.18-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.17.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.17.18-rc1
X-KernelTest-Deadline: 2018-08-23T05:50+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.17.18 release.
There are 42 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Aug 23 05:50:04 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.18-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.17.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.17.18-rc1

Jisheng Zhang <Jisheng.Zhang@synaptics.com>
    net: mvneta: fix mvneta_config_rss on armada 3700

Andrew Lunn <andrew@lunn.ch>
    net: ethernet: mvneta: Fix napi structure mixup on armada 3700

Hangbin Liu <liuhangbin@gmail.com>
    cls_matchall: fix tcf_unbind_filter missing

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    ip_vti: fix a null pointer deferrence when create vti fallback tunnel

Jian-Hong Pan <jian-hong@endlessm.com>
    r8169: don't use MSI-X on RTL8106e

Jeremy Cline <jcline@redhat.com>
    net: sock_diag: Fix spectre v1 gadget in __sock_diag_cmd()

Kees Cook <keescook@chromium.org>
    isdn: Disable IIOCDBGVAR

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    Bluetooth: avoid killing an already killed socket

Johan Hovold <johan@kernel.org>
    misc: sram: fix resource leaks in probe error path

Srinath Mannam <srinath.mannam@broadcom.com>
    serial: 8250_dw: Add ACPI support for uart on Broadcom SoC

Chen Hu <hu1.chen@intel.com>
    serial: 8250_dw: always set baud rate in dw8250_set_termios

Aaron Sierra <asierra@xes-inc.com>
    serial: 8250_exar: Read INT0 from slave device, too

Mark <dmarkh@cfl.rr.com>
    tty: serial: 8250: Revert NXP SC16C2552 workaround

Willy Tarreau <w@1wt.eu>
    ACPI / PM: save NVS memory for ASUS 1025C laptop

Aleksander Morgado <aleksander@aleksander.es>
    USB: option: add support for DW5821e

Movie Song <MovieSong@aten-itlab.cn>
    USB: serial: pl2303: add a new device id for ATEN

John Ogness <john.ogness@linutronix.de>
    USB: serial: sierra: fix potential deadlock at close

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix poll() error return

Takashi Iwai <tiwai@suse.de>
    ALSA: vxpocket: Fix invalid endian conversions

Takashi Iwai <tiwai@suse.de>
    ALSA: memalloc: Don't exceed over the requested size

Hans de Goede <hdegoede@redhat.com>
    ALSA: hda: Correct Asrock B85M-ITX power_save blacklist entry

Takashi Iwai <tiwai@suse.de>
    ALSA: cs5535audio: Fix invalid endian conversion

Takashi Iwai <tiwai@suse.de>
    ALSA: virmidi: Fix too long output trigger loop

Takashi Iwai <tiwai@suse.de>
    ALSA: vx222: Fix invalid endian conversions

Park Ju Hyung <qkrwngud825@gmail.com>
    ALSA: hda - Turn CX8200 into D3 as well upon reboot

Park Ju Hyung <qkrwngud825@gmail.com>
    ALSA: hda - Sleep for 10ms after entering D3 on Conexant codecs

David Howells <dhowells@redhat.com>
    rxrpc: Fix the keepalive generator [ver #2]

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: don't use MSI-X on RTL8168g

Or Gerlitz <ogerlitz@mellanox.com>
    net/mlx5e: Properly check if hairpin is possible between two functions

Nir Dotan <nird@mellanox.com>
    mlxsw: core_acl_flex_actions: Remove redundant mirror resource destruction

Nir Dotan <nird@mellanox.com>
    mlxsw: core_acl_flex_actions: Remove redundant counter destruction

Nir Dotan <nird@mellanox.com>
    mlxsw: core_acl_flex_actions: Remove redundant resource destruction

Xin Long <lucien.xin@gmail.com>
    ip6_tunnel: use the right value for ipv4 min mtu check in ip6_tnl_xmit

Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
    net: aquantia: Fix IFF_ALLMULTI flag functionality

Nir Dotan <nird@mellanox.com>
    mlxsw: core_acl_flex_actions: Return error for conflicting actions

Jason Wang <jasowang@redhat.com>
    vhost: reset metadata cache when initializing new IOTLB

Hangbin Liu <liuhangbin@gmail.com>
    net_sched: Fix missing res info when create new tc_index filter

Cong Wang <xiyou.wangcong@gmail.com>
    vsock: split dwork to avoid reinitializations

Hangbin Liu <liuhangbin@gmail.com>
    net_sched: fix NULL pointer dereference when delete tcindex filter

Cong Wang <xiyou.wangcong@gmail.com>
    llc: use refcount_inc_not_zero() for llc_sap_find()

Wei Wang <weiwan@google.com>
    l2tp: use sk_dst_check() to avoid race on sk->sk_dst_cache

Alexey Kodanev <alexey.kodanev@oracle.com>
    dccp: fix undefined behavior with 'cwnd' shift in ccid2_cwnd_restart()


-------------

Diffstat:

 Makefile                                           |   4 +-
 drivers/acpi/sleep.c                               |   8 ++
 drivers/isdn/i4l/isdn_common.c                     |   8 +-
 drivers/misc/sram.c                                |   9 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |   2 +-
 drivers/net/ethernet/marvell/mvneta.c              |  53 ++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   8 +-
 .../mellanox/mlxsw/core_acl_flex_actions.c         |  51 ++++---
 drivers/net/ethernet/realtek/r8169.c               |  12 +-
 drivers/tty/serial/8250/8250_dw.c                  |   3 +-
 drivers/tty/serial/8250/8250_exar.c                |   6 +-
 drivers/tty/serial/8250/8250_port.c                |   3 +-
 drivers/usb/serial/option.c                        |   4 +
 drivers/usb/serial/pl2303.c                        |   2 +
 drivers/usb/serial/pl2303.h                        |   1 +
 drivers/usb/serial/sierra.c                        |   4 +-
 drivers/vhost/vhost.c                              |   9 +-
 include/net/af_vsock.h                             |   4 +-
 include/net/llc.h                                  |   5 +
 net/bluetooth/sco.c                                |   3 +-
 net/core/sock_diag.c                               |   2 +
 net/dccp/ccids/ccid2.c                             |   6 +-
 net/ipv4/ip_vti.c                                  |   3 +-
 net/ipv6/ip6_tunnel.c                              |   8 +-
 net/l2tp/l2tp_core.c                               |   2 +-
 net/llc/llc_core.c                                 |   4 +-
 net/rxrpc/ar-internal.h                            |   8 +-
 net/rxrpc/conn_event.c                             |   4 +-
 net/rxrpc/net_ns.c                                 |   6 +-
 net/rxrpc/output.c                                 |  12 +-
 net/rxrpc/peer_event.c                             | 156 ++++++++++++---------
 net/rxrpc/peer_object.c                            |   8 +-
 net/rxrpc/rxkad.c                                  |   4 +-
 net/sched/cls_matchall.c                           |   2 +
 net/sched/cls_tcindex.c                            |   8 +-
 net/socket.c                                       |   3 +-
 net/vmw_vsock/af_vsock.c                           |  15 +-
 net/vmw_vsock/vmci_transport.c                     |   3 +-
 sound/core/memalloc.c                              |   8 +-
 sound/core/seq/oss/seq_oss.c                       |   2 +-
 sound/core/seq/seq_clientmgr.c                     |   2 +-
 sound/core/seq/seq_virmidi.c                       |  10 ++
 sound/pci/cs5535audio/cs5535audio.h                |   6 +-
 sound/pci/cs5535audio/cs5535audio_pcm.c            |   4 +-
 sound/pci/hda/hda_intel.c                          |   2 +-
 sound/pci/hda/patch_conexant.c                     |   4 +-
 sound/pci/vx222/vx222_ops.c                        |   8 +-
 sound/pcmcia/vx/vxp_ops.c                          |  10 +-
 48 files changed, 296 insertions(+), 213 deletions(-)


