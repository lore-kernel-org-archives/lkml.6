Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-872240-1523536659-2-1138489228974052351
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523536657; b=RvbYpbbvu2+4AjbtO2e9xuR5+pAn6sTSPgGRUBxBaPHfNxK0Bc
    1mw6HkhPI4kAOrrNBmwYh9FWcdKLvwOEfk6GD9PF1E/VzPN0BUxX5I9l8YO6VXLU
    TXQW+2ZOn4H9EpE3irOvZUtEo6RsPv2POFhsh7tEQZ5DOGQJtRWf7gW7hjgzQpHw
    lV5hXjEQdwdZdTZan0eof4dEe0tE8X+0vHdhW1eED+LIYOfqUWMDRZgiDlh0glAX
    1YoPXNm08GR4avknNkrJv5i6BX/x5fqTBmAISeJIjLh9x5ufTjVYXAd3B2x6wEwf
    i43FLS/F7irrRJlFeYzgMwibMcUorM0T+cAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1523536657;
    bh=wGZynKP8vAEXUTchopOODBMj2kXlnjYlPqRspF14Ags=; b=JJgAgl7H1GPo
    6VikfIUlSscObIzx8srUg6J8g7ej67nbUaVXXuYN7/N5Tt20P9kUEDsT1Nbe/o4l
    UMNsKVqg6pdUh9UqamjDNqAZsa7nrcxTfGYfvTQY+NHiyNXdaRGZGd24u9GGZJrB
    NXBc6wy01WxIQJo6iRW3ORURvewosGE4Rm4YkHsj8IkYYx8fpwS75rROOGlIiXlG
    omjxJtRy0vJUFH4C8TI+yYM1KVMv/MnHAiPJY+rxUjkbmqrlaXnriEz4gxwTx/Qh
    VawYUMgNkm9W84sOC7+Xq5DTJigTyyHrzwXBJ4qO1+cEahX0Gcz/r28tb7NDssnV
    Ntfj1/lbIQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL83d9MiJNOWxpxLBZKPEt4rrAWzJoL1p13dYF5Qbl+zYXNEp2BAlOTh5EzYvTrfEKTbr2MMTXGgwtKfhJjKBSHd3kHCzQDaohAwwNFzjuv8nF2djjyE
    /AjAkmM8gm0861iFE6gx53eKSX9+ETnIETG2lNhAcij8P3N08OiOKwqI2epnB9EGwubdrkp8rmkYvTnj4VtzniWG5ZznAe3lkJLTcQcDTlok0bl3zRUaF4B5
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=e92Y5vKnjsun6OePxyIA:9 a=-LfZX19nWICHY8OD:21 a=qW_--b5izXdep9V5:21
    a=QEXdDO2ut3YA:10 a=UKdj6niELId1Wxbuw6cA:9 a=ONNS8QRKHyMA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeDLMhZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 08:37:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50794 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeDLMhP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 08:37:15 -0400
Date: Thu, 12 Apr 2018 14:37:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.34
Message-ID: <20180412123706.GA21271@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.34 kernel.

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

 Makefile                                                  |    2=20
 arch/arm/boot/dts/ls1021a.dtsi                            |    2=20
 arch/arm64/crypto/Makefile                                |    2=20
 arch/arm64/crypto/aes-ce-cipher.c                         |  281 ---------=
-----
 arch/arm64/crypto/aes-ce-core.S                           |   87 ++++
 arch/arm64/crypto/aes-ce-glue.c                           |  190 +++++++++
 arch/x86/include/asm/microcode.h                          |   10=20
 arch/x86/include/asm/processor.h                          |    1=20
 arch/x86/kernel/aperture_64.c                             |   46 ++
 arch/x86/kernel/cpu/common.c                              |   30 +
 arch/x86/kernel/cpu/microcode/amd.c                       |   44 +-
 arch/x86/kernel/cpu/microcode/core.c                      |  181 ++++++---
 arch/x86/kernel/cpu/microcode/intel.c                     |   62 ++-
 arch/x86/xen/mmu_hvm.c                                    |    2=20
 block/bfq-cgroup.c                                        |    7=20
 block/blk-mq.c                                            |   29 +
 crypto/Makefile                                           |    1=20
 drivers/acpi/acpi_video.c                                 |   14=20
 drivers/acpi/ec.c                                         |    2=20
 drivers/acpi/ec_sys.c                                     |    2=20
 drivers/acpi/internal.h                                   |    2=20
 drivers/bluetooth/btusb.c                                 |    1=20
 drivers/char/tpm/tpm-interface.c                          |   28 -
 drivers/char/tpm/tpm.h                                    |    5=20
 drivers/clk/clk-divider.c                                 |    7=20
 drivers/clk/hisilicon/clkdivider-hi6220.c                 |    2=20
 drivers/clk/meson/clk-mpll.c                              |    2=20
 drivers/clk/nxp/clk-lpc32xx.c                             |    2=20
 drivers/clk/qcom/clk-regmap-divider.c                     |    2=20
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c                     |    4=20
 drivers/clk/sunxi-ng/ccu_div.c                            |    2=20
 drivers/cpufreq/powernv-cpufreq.c                         |   37 +
 drivers/devfreq/devfreq.c                                 |    3=20
 drivers/edac/mv64x60_edac.c                               |    2=20
 drivers/gpio/gpio-thunderx.c                              |    4=20
 drivers/gpio/gpiolib.c                                    |    3=20
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c                |    2=20
 drivers/hwmon/ina2xx.c                                    |   87 ++--
 drivers/infiniband/core/cma.c                             |    1=20
 drivers/infiniband/core/ucma.c                            |    7=20
 drivers/infiniband/hw/i40iw/i40iw_cm.c                    |    5=20
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c                  |    6=20
 drivers/infiniband/hw/i40iw/i40iw_d.h                     |    1=20
 drivers/infiniband/hw/i40iw/i40iw_puda.c                  |    2=20
 drivers/infiniband/sw/rdmavt/cq.c                         |   10=20
 drivers/input/touchscreen/goodix.c                        |    8=20
 drivers/irqchip/irq-gic-v3.c                              |   11=20
 drivers/md/bcache/alloc.c                                 |   19=20
 drivers/md/bcache/request.c                               |   22 +
 drivers/md/bcache/super.c                                 |    6=20
 drivers/media/v4l2-core/videobuf2-core.c                  |    4=20
 drivers/mmc/host/sdhci-pci-core.c                         |    2=20
 drivers/mmc/host/sdhci.c                                  |    7=20
 drivers/mtd/tests/oobtest.c                               |   21 +
 drivers/net/bonding/bond_main.c                           |   73 +--
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c                |   23 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |    4=20
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c    |   17=20
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c |   13=20
 drivers/net/ethernet/ibm/ibmvnic.c                        |    6=20
 drivers/net/ethernet/intel/i40evf/i40evf_main.c           |   20=20
 drivers/net/ethernet/marvell/sky2.c                       |    2=20
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c            |   77 ++-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c           |   33 -
 drivers/net/ethernet/mellanox/mlx4/en_main.c              |    4=20
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c            |    7=20
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h              |    1=20
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c     |    1=20
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c         |   10=20
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c          |   26 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c           |   18=20
 drivers/net/ethernet/mellanox/mlx5/core/vport.c           |   33 +
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c      |    9=20
 drivers/net/ethernet/realtek/r8169.c                      |    4=20
 drivers/net/ppp/pptp.c                                    |    1=20
 drivers/net/team/team.c                                   |   12=20
 drivers/net/usb/lan78xx.c                                 |   23 +
 drivers/net/vrf.c                                         |    5=20
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c            |   22 -
 drivers/net/wireless/ti/wl1251/main.c                     |    3=20
 drivers/nvme/target/fcloop.c                              |   47 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c                  |    6=20
 drivers/power/supply/axp288_charger.c                     |   13=20
 drivers/rtc/rtc-ac100.c                                   |    6=20
 drivers/scsi/libiscsi.c                                   |   24 +
 drivers/scsi/libsas/sas_expander.c                        |    4=20
 drivers/scsi/megaraid/megaraid_sas_base.c                 |    2=20
 drivers/scsi/megaraid/megaraid_sas_fp.c                   |   16=20
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                      |   28 -
 drivers/spi/spi-sh-msiof.c                                |   12=20
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c      |   13=20
 drivers/target/target_core_user.c                         |    7=20
 drivers/thermal/int340x_thermal/int3400_thermal.c         |   10=20
 drivers/thermal/power_allocator.c                         |    2=20
 drivers/tty/n_gsm.c                                       |   17=20
 drivers/uio/uio_hv_generic.c                              |    7=20
 drivers/vhost/net.c                                       |    4=20
 drivers/vhost/vhost.c                                     |   17=20
 drivers/video/backlight/corgi_lcd.c                       |    2=20
 drivers/video/backlight/tdo24m.c                          |    2=20
 drivers/video/backlight/tosa_lcd.c                        |    2=20
 drivers/video/fbdev/vfb.c                                 |   17=20
 drivers/watchdog/dw_wdt.c                                 |   18=20
 fs/dcache.c                                               |   23 -
 include/linux/clk-provider.h                              |    2=20
 include/linux/mlx5/driver.h                               |    2=20
 net/8021q/vlan_dev.c                                      |    6=20
 net/core/dev.c                                            |    4=20
 net/ipv4/arp.c                                            |    2=20
 net/ipv4/fib_semantics.c                                  |   20=20
 net/ipv4/ip_tunnel.c                                      |   11=20
 net/ipv6/ip6_gre.c                                        |    8=20
 net/ipv6/ip6_output.c                                     |   28 +
 net/ipv6/ip6_tunnel.c                                     |   11=20
 net/ipv6/ip6_vti.c                                        |    7=20
 net/ipv6/route.c                                          |    3=20
 net/ipv6/seg6_iptunnel.c                                  |   16=20
 net/ipv6/sit.c                                            |    8=20
 net/l2tp/l2tp_netlink.c                                   |    2=20
 net/mac80211/cfg.c                                        |   28 +
 net/mac80211/driver-ops.h                                 |    3=20
 net/netlink/af_netlink.c                                  |    3=20
 net/rds/bind.c                                            |    1=20
 net/sched/act_api.c                                       |    4=20
 net/sched/act_bpf.c                                       |   12=20
 net/sched/act_skbmod.c                                    |    3=20
 net/sched/act_tunnel_key.c                                |    9=20
 net/sctp/ipv6.c                                           |    4=20
 net/sctp/socket.c                                         |   13=20
 net/strparser/strparser.c                                 |    4=20
 sound/soc/intel/atom/sst/sst_stream.c                     |    2=20
 sound/soc/intel/boards/cht_bsw_rt5645.c                   |    7=20
 sound/soc/intel/skylake/skl-messages.c                    |    4=20
 sound/soc/intel/skylake/skl-pcm.c                         |    4=20
 tools/objtool/check.c                                     |   11=20
 tools/perf/arch/powerpc/util/sym-handling.c               |    8=20
 tools/perf/builtin-record.c                               |    4=20
 tools/perf/builtin-report.c                               |   18=20
 tools/perf/util/evsel.c                                   |   47 ++
 tools/perf/util/probe-event.c                             |   28 +
 tools/perf/util/symbol.c                                  |    5=20
 tools/perf/util/symbol.h                                  |    1=20
 tools/perf/util/util.c                                    |    2=20
 tools/testing/selftests/net/msg_zerocopy.c                |   21 -
 144 files changed, 1662 insertions(+), 782 deletions(-)

Alexander Potapenko (1):
      netlink: make sure nladdr has correct size in netlink_connect()

Alexey Khoroshilov (1):
      thermal: int3400_thermal: fix error handling in int3400_thermal_probe=
()

Andy Shevchenko (1):
      sdhci: Advertise 2.0v supply on SDIO host controller

Ard Biesheuvel (1):
      crypto: arm64/aes-ce-cipher - move assembler code to .S file

Arjun Vynipadath (1):
      cxgb4vf: Fix SGE FL buffer initialization logic for 64K pages

Arnd Bergmann (1):
      crypto: aes-generic - build with -Os on gcc-7+

Ashok Raj (4):
      x86/microcode/intel: Check microcode revision before updating sibling=
 threads
      x86/microcode/intel: Writeback and invalidate caches before updating =
microcode
      x86/microcode: Do not upload microcode if CPUs are offline
      x86/microcode: Synchronize late microcode loading

Borislav Petkov (8):
      x86/microcode: Propagate return value from updating functions
      x86/CPU: Add a microcode loader callback
      x86/CPU: Check CPU feature bits after microcode upgrade
      x86/microcode: Get rid of struct apply_microcode_ctx
      x86/microcode/intel: Look into the patch cache first
      x86/microcode: Request microcode on the BSP
      x86/microcode: Attempt late loading only when new microcode is present
      x86/microcode: Fix CPU synchronization routine

Chaitra P B (1):
      scsi: mpt3sas: Proper handling of set/clear of "ATA command pending" =
flag.

Christophe JAILLET (2):
      ASoC: Intel: sst: Fix the return value of 'sst_send_byte_stream_mrfld=
()'
      EDAC, mv64x60: Fix an error handling path

Colin Ian King (1):
      wl1251: check return from call to wl1251_acx_arp_ip_filter

Craig Dillabaugh (1):
      net sched actions: fix dumping which requires several messages to use=
r space

Daniel Jurgens (1):
      net/mlx5: Fix race for multiple RoCE enable

Dave Watson (1):
      strparser: Fix sign of err codes

David Ahern (2):
      net/ipv6: Fix route leaking between VRFs
      vrf: Fix use after free and double free in vrf_finish_output

David Lebrun (1):
      ipv6: sr: fix seg6 encap performances with TSO enabled

Davide Caratti (3):
      net/sched: fix NULL dereference in the error path of tcf_bpf_init()
      net/sched: fix NULL dereference in the error path of tunnel_key_init()
      net/sched: fix NULL dereference on the error path of tcf_skbmod_init()

Dirk van der Merwe (1):
      nfp: use full 40 bits of the NSP buffer address

Eran Ben Elisha (1):
      net/mlx4_en: Fix mixed PFC and Global pause user control requests

Eric Dumazet (10):
      net: fix possible out-of-bound read in skb_network_protocol()
      pptp: remove a buggy dst release in pptp_connect()
      sctp: do not leak kernel memory to user space
      sctp: sctp_sockaddr_af must check minimal addr length for AF_INET6
      net: fool proof dev_valid_name()
      ip_tunnel: better validate user provided tunnel names
      ipv6: sit: better validate user provided tunnel names
      ip6_gre: better validate user provided tunnel names
      ip6_tunnel: better validate user provided tunnel names
      vti6: better validate user provided tunnel names

Fuyun Liang (2):
      net: hns3: fix for getting auto-negotiation state in hclge_get_autoneg
      net: hns3: fix for changing MTU

Gautham R. Shenoy (1):
      powernv-cpufreq: Add helper to extract pstate from PMSR

Geert Uytterhoeven (2):
      spi: sh-msiof: Fix timeout failures for TX-only DMA transfers
      ACPI: EC: Fix debugfs_create_*() usage

Greg Kroah-Hartman (1):
      Linux 4.14.34

Gustavo A. R. Silva (1):
      PM / devfreq: Fix potential NULL pointer dereference in governor_store

Hangbin Liu (2):
      l2tp: fix missing print session offset info
      vlan: also check phy_driver ts_info for vlan's real device

Hans de Goede (5):
      ACPI / video: Default lcd_only to true on Win8-ready and newer machin=
es
      ASoC: Intel: cht_bsw_rt5645: Analog Mic support
      pinctrl: baytrail: Enable glitch filter for GPIOs used as interrupts
      power: supply: axp288_charger: Properly stop work on probe-error / re=
move
      Input: goodix - disable IRQs while suspended

Heiner Kallweit (1):
      r8169: fix setting driver_data after register_netdev

Ioan Moldovan (1):
      Bluetooth: Add a new 04ca:3015 QCA_ROME device

Jacob Keller (1):
      i40evf: don't rely on netif_running() outside rtnl_lock()

James Smart (2):
      nvme_fcloop: disassocate local port structs
      nvme_fcloop: fix abort race condition

Jason Wang (3):
      vhost: correctly remove wait queue during poll failure
      vhost: validate log when IOTLB is enabled
      vhost_net: add missing lock nesting notation

Jason Yan (2):
      scsi: libsas: fix memory leak in sas_smp_get_phy_events()
      scsi: libsas: fix error when getting phy events

Javier Martinez Canillas (1):
      tpm: return a TPM_RC_COMMAND_CODE response if command is not implemen=
ted

Jeff Barnhill (1):
      net/ipv6: Increment OUTxxx counters after netfilter hook

Jernej =C5=A0krabec (1):
      clk: sunxi-ng: a83t: Add M divider to TCON1 clock

Jerome Brunet (1):
      clk: divider: fix incorrect usage of container_of

Jian Shen (3):
      net: hns3: Fix an error of total drop packet statistics
      net: hns3: Fix a loop index error of tqp statistics query
      net: hns3: Fix an error macro definition of HNS3_TQP_STAT

Jianbo Liu (2):
      net/mlx5e: Fix memory usage issues in offloading TC flows
      net/mlx5e: Don't override vport admin link state in switchdev mode

Jin Yao (1):
      perf report: Fix a no annotate browser displayed issue

Jiri Bohac (1):
      x86/gart: Exclude GART aperture from vmcore

Jiri Olsa (1):
      perf tools: Fix copyfile_offset update of output offset

Josh Poimboeuf (1):
      objtool: Add Clang support

Kai-Heng Feng (1):
      sky2: Increase D3 delay to sky2 stops working after suspend

Leon Romanovsky (1):
      RDMA/cma: Mark end of CMA ID messages

Linus Walleij (1):
      gpio: label descriptors using the device name

Maciej Purski (1):
      hwmon: (ina2xx) Make calibration register value fixed

Martin Blumenstingl (1):
      clk: meson: mpll: use 64-bit maths in params_from_rate

Masami Hiramatsu (2):
      perf probe: Find versioned symbols from map
      perf probe: Add warning message if there is unexpected event name

Mauro Carvalho Chehab (1):
      media: videobuf2-core: don't go out of the buffer range

Mengting Zhang (1):
      perf evsel: Enable ignore_missing_thread for pid option

Miguel Fadon Perlines (1):
      arp: fix arp_filter on l3slave devices

Mike Christie (1):
      tcmu: release blocks for partially setup cmds

Mike Marciniszyn (1):
      IB/rdmavt: Allocate CQ memory on the correct node

Ming Lei (3):
      blk-mq: avoid to map CPU into stale hw queue
      blk-mq: fix race between updating nr_hw_queues and switching io sched
      blk-mq: fix kernel oops in blk_mq_tag_idle()

Miquel Raynal (1):
      mtd: mtd_oobtest: Handle bitflips during reads

Moni Shoua (1):
      net/mlx4_en: Change default QoS settings

Moshe Shemesh (1):
      net/mlx4_core: Fix memory leak while delete slave's resources

Nathan Fontenot (1):
      ibmvnic: Don't handle RX interrupts when not up.

NeilBrown (2):
      VFS: close race between getcwd() and d_move()
      staging: lustre: disable preempt while sampling processor id.

Oleksij Rempel (1):
      watchdog: dw_wdt: add stop watchdog operation

Or Gerlitz (1):
      net/mlx5e: Avoid using the ipv6 stub in the TC offload neigh update p=
ath

Paolo Abeni (1):
      ipv6: the entire IPv6 header chain must fit the first fragment

Paolo Valente (1):
      block, bfq: put async queues for root bfq groups too

Parav Pandit (1):
      RDMA/cma: Fix rdma_cm path querying for RoCE

Pardha Saradhi K (1):
      ASoC: Intel: Skylake: Disable clock gating during firmware and librar=
y download

Peng Li (1):
      net: hns3: free the ring_data structrue when change tqps

Peter Gro=C3=9Fe (1):
      mac80211: Fix setting TX power on monitor interfaces

Pieter \"PoroCYon\" Sluys (1):
      vfb: fix video mode and line_length being set when loaded

Rafael David Tinoco (1):
      scsi: libiscsi: Allow sd_shutdown on bad transport

Raghuram Chary J (1):
      lan78xx: Crash in lan78xx_writ_reg (Workqueue: events lan78xx_deferre=
d_multicast_write)

Rasmus Villemoes (1):
      ARM: dts: ls1021a: add "fsl,ls1021a-esdhc" compatible string to esdhc=
 node

Robert Jarzmik (1):
      backlight: tdo24m: Fix the SPI CS between transfers

Roi Dayan (1):
      net/mlx5e: Fix traffic being dropped on VF representor

Rui Hua (1):
      bcache: ret IOERR when read meets metadata error

Shahar Klein (1):
      net/mlx5e: Sync netdev vxlan ports at open

Shanker Donthineni (1):
      irqchip/gic-v3: Fix the driver probe() fail due to disabled GICC entry

Shiraz Saleem (2):
      i40iw: Fix sequence number for the first partial FPDU
      i40iw: Correct Q1/XF object count equation

Shivasharan S (2):
      scsi: megaraid_sas: Error handling for invalid ldcount provided by fi=
rmware in RAID map
      scsi: megaraid_sas: unload flag should be set after scsi_remove_host =
is called

Sowmini Varadhan (2):
      rds; Reset rs->rs_bound_addr in rds_add_bound() failure path
      selftests/net: fix bugs in address and port initialization

Stanislaw Gruszka (1):
      rt2x00: do not pause queue unconditionally on error path

Stephen Hemminger (1):
      uio_hv_generic: check that host supports monitor page

Tang Junhui (2):
      bcache: stop writeback thread after detaching
      bcache: segregate flash only volume write streams

Tatyana Nikolova (1):
      i40iw: Validate correct IRD/ORD connection parameters

Tobias Brunner (1):
      ipv6: Reinject IPv6 packets if IPsec policy matches after SNAT

Tony Lindgren (1):
      tty: n_gsm: Allow ADM response in addition to UA for control dlci

Wei Yongjun (1):
      gpio: thunderx: fix error return code in thunderx_gpio_probe()

Xin Long (5):
      bonding: fix the err path for dev hwaddr sync in bond_enslave
      bonding: move dev_mc_sync after master_upper_dev_link in bond_enslave
      bonding: process the err returned by dev_set_allmulti properly in bon=
d_enslave
      route: check sysctl_fib_multipath_use_neigh earlier than hash
      team: move dev_mc_sync after master_upper_dev_link in team_port_add

Yi Zeng (1):
      thermal: power_allocator: fix one race condition issue for thermal_in=
stances list

chenxiang (1):
      scsi: libsas: initialize sas_phy status according to response of DISC=
OVER


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrPUvEACgkQONu9yGCS
aT4YrxAA2EX1Y0UjeOdj/33vxu7Dmq6RGfHatjPDWZg+XWDbUD9zC6ipDHax1SRM
NMiDWknt828mpVHiLL8NRTe2e7Q98LmIADMiFtPCWd6QnrM0LEmvj9RCDyE+jZQh
ksOfzc0vqXlusiqXQv/MDfKvDaqAfKTGO8GKi6JkhvDtV2YUC9cvL5acA/UcsxQl
opV/ri5O9NzftoXyJf4pOXpRkag4tm1EswlKUSFxbjQPMxKC05xNmgEzHXXxga75
qa69260fdMBY7J43H5wEGWEBpNE+oW4j/0ZhpbVQ2xBJavEO823RwfR1bKJxQ89l
1csdzxoKH8fWkPjwgkQV7q5dVjaluPn81WuE+G64grTbannMLThsp2sazIJ6IKne
0S+woAI7S+IQ4AM7m7kaMX+xpNfKDLeH7UBiSl8nMidhdoNj0i536/8I7etzJ91J
n0DObT7cixLdhiIRP91BkejpziNVxIgLuiWWsfkgKZfLZQrKo255FgsINpTM6FC5
TdFvBz6jRmtPdNBW34QK0j0k8ZOiWo1I7DCiPEpzEfwJxXDZufDMgWwz//OwsR1U
Pk6rbnPmNwMldjEuhUagCTuMx+im0rk3dQ79Soi33ccj8NFtQeKF/8NpFgFJ+zLn
j/4/NpA3Z+6hWV+jxgvR4Z/WciFAK4AQXINgDg33EvA7R5rMolY=
=1jDU
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
