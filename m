Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839345-2-6552764507014056293
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839344; b=MsPzdkwPxQF68enhD+iu6BgxQWRPW1Y7KKgo/50bbO3VRwZbsC
    vjnbeK7QNf9mKxTBvWNAoqfI1jtr4aT/K3Ovj5hN/K6iNJk7Y7gN9hH4wiz9yekZ
    vIouu/RYj0pPd3+EPXaEw4CRywwygYScsMMndvQmbjUe7DNVGs8DRe2aK7WZtJhY
    o4VMlf4spHrAPhN+3C4+rqAR7Mqcywjs1GaXpVrORWP+2RJBDWGAyW2PpMunJPBg
    mnRL6jhldnP/v4E/jIC/mOH31KBTby1gIzd3uxQNiGP3fepWIpgEWre0kJRHSYK9
    +zZDUIfPQBBxg9kIZwDTOqiBwU59vKP+NYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1524839344; bh=Gl/5UBXqfhHwRHEjc18FMCrP1yGBOC
    7AFVEm1tFdJUI=; b=mw6C4V+Zh3XFZ4MaFf1k6f2Xd8Q3oXeFrcz0Byj/3z4mZp
    jKDQLgrInV792XI8+kUxs5l77ie+csn0GdM0r0y2UIUwZGphhMdTBHiq+3WWTfuN
    VrLEchK4MqWsPHvStV1sA8n9alB3K3YaN4b79PQap8e6vZc44HUFTj1IXPGYfg8V
    1Ro5fhgIV7BYh1Ck/kTxk67vmNLHO6O4AU8gnsvWQYTRJvtrLmfBy5IgFk686PMO
    INALEcWg0bV+pspziCKQnE4SwsU0aPNJ99wQ33DMdjAzqcvUqpfft8TQkMOKA+8b
    lp5MgytasuVkyJWb3iO06l+7wl2zKcDdj5s7ZaSQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFmnABsQ5sZc2ahHqzO2xIztgbQN/BTinSjDHNxbsMzJgBonIeiQ5d/opUeLnPU7PmHyaLkWUojsjRMz0orZsQ8tZWPlvlwH9HlLphoBD8XJJHBRaGrx
    PHxqZJJadv5pHZt1MC5bV2tSvqNYo1kX55DHYXlAYr3Dc9jZOfOESFxrurPXYgn7KrAhLtAEXJblOfmUb75UgwHodOTLrajOU91yGoGO6Plfl6el6lW1XVyF
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=9hA1FEcAjjIA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8
    a=VnNF1IyMAAAA:8 a=_jlGtV7tAAAA:8 a=8981fWPbAAAA:8 a=1XWaLZrsAAAA:8
    a=yPCof4ZbAAAA:8 a=kZbXAlMlAAAA:8 a=Q-fNiiVtAAAA:8 a=KKAkSRfTAAAA:8
    a=pGLkceISAAAA:8 a=A7XncKjpAAAA:8 a=zd2uoN0lAAAA:8 a=eh1Yez-EAAAA:8
    a=FOH2dFAWAAAA:8 a=jIQo8A4GAAAA:8 a=P-IC7800AAAA:8 a=Qm8iP6mkAAAA:8
    a=s69QxFRhAAAA:8 a=LpQP-O61AAAA:8 a=bLk-5xynAAAA:8 a=QyXUC8HyAAAA:8
    a=IpJZQVW2AAAA:8 a=9EOGntltfqTCvZp9Si0A:9 a=NNCz4_OucdMHg_At:21
    a=HFGRabAl-oQINQGy:21 a=QEXdDO2ut3YA:10 a=opcdESBofxgA:10 a=FeohvXjoa2cA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=nlm17XC03S6CtCLSeiRr:22
    a=o72u2rHnfW5qNJ_4I8LD:22 a=1K0MQvXYBBII1NMywDO_:22 a=Fp8MccfUoT0GBdDC_Lng:22
    a=cvBusfyB2V15izCimMoJ:22 a=R9rPLQDAdC6-Ub70kJmZ:22 a=i3VuKzQdj-NEYjvDI-p3:22
    a=Lf5xNeLK5dgiOs8hzIjU:22 a=d3PnA9EDa4IxuAV0gXij:22 a=kDhhxE42lZnxL3pOKqYK:22
    a=FzsZaHqyxIPyk0jfoVVe:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934960AbeD0OLJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934949AbeD0OLG (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:11:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1036218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.16 00/81] 4.16.6-stable review
Date: Fri, 27 Apr 2018 15:58:02 +0200
Message-Id: <20180427135743.216853156@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.6-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.6-rc1
X-KernelTest-Deadline: 2018-04-29T13:57+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.16.6 release.
There are 81 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Apr 29 13:57:21 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.6-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.6-rc1

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Only default only_lcd to true on Win8-ready _desktops_

Thomas Richter <tmricht@linux.ibm.com>
    kprobes: Fix random address output of blacklist file

André Wild <wild@linux.ibm.com>
    s390/cpum_cf: rename IBM z13/z14 counter names

Heiko Carstens <heiko.carstens@de.ibm.com>
    s390/uprobes: implement arch_uretprobe_is_alive()

Stefan Haberland <sth@linux.vnet.ibm.com>
    s390/dasd: fix IO error for newly defined devices

Sebastian Ott <sebott@linux.ibm.com>
    s390/cio: update chpid descriptor after resource accessibility event

Guenter Roeck <linux@roeck-us.net>
    hwmon: (k10temp) Add support for AMD Ryzen w/ Vega graphics

Guenter Roeck <linux@roeck-us.net>
    hwmon: (k10temp) Add temperature offset for Ryzen 2700X

Peter Xu <peterx@redhat.com>
    tracing: Fix missing tab for hwlat_detector print format

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Fix IO error at end of medium

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Fix array bounds check

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Select appropriate drive on device open

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Rename macros to avoid inconsistent inverted logic

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Remove extra put_disk() call from error path

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Don't log an error message for an invalid ioctl

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Check drive type

Finn Thain <fthain@telegraphics.com.au>
    m68k/mac: Don't remap SWIM MMIO region

Robert Kolchmeyer <rkolchmeyer@google.com>
    fsnotify: Fix fsnotify_mark_connector race

Dan Carpenter <dan.carpenter@oracle.com>
    cdrom: information leak in cdrom_ioctl_media_changed()

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: mptsas: Disable WRITE SAME

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    commoncap: Handle memory allocation failure.

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "mm/hmm: fix header file if/else/endif maze"

Michael S. Tsirkin <mst@redhat.com>
    virtio_net: fix adding vids on big-endian

Michael S. Tsirkin <mst@redhat.com>
    virtio_net: split out ctrl buffer

Igor Russkikh <igor.russkikh@aquantia.com>
    net: aquantia: oops when shutdown on already stopped device

Bjørn Mork <bjorn@mork.no>
    tun: fix vlan packet truncation

Igor Russkikh <igor.russkikh@aquantia.com>
    net: aquantia: Regression on reset with 1.x firmware

Stefan Hajnoczi <stefanha@redhat.com>
    VSOCK: make af_vsock.ko removable again

Jason Wang <jasowang@redhat.com>
    virtio-net: add missing virtqueue kick when flushing packets

Vasundhara Volam <vasundhara-v.volam@broadcom.com>
    bnxt_en: Fix memory fault in bnxt_ethtool_init()

Eric Dumazet <edumazet@google.com>
    net: validate attribute sizes in neigh_dump_table()

Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
    net: ethernet: ti: cpsw: fix tx vlan priority mapping

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: handle failure on workqueue creation

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: avoid control IO completion stalls

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix error handling in adapter command callbacks

Cong Wang <xiyou.wangcong@gmail.com>
    llc: fix NULL pointer deref for SOCK_ZAPPED

Cong Wang <xiyou.wangcong@gmail.com>
    llc: hold llc_sap before release_sock()

Guillaume Nault <g.nault@alphalink.fr>
    l2tp: fix {pppol2tp, l2tp_dfs}_seq_stop() in case of seq_file overflow

Guillaume Nault <g.nault@alphalink.fr>
    l2tp: hold reference on tunnels printed in l2tp/tunnels debugfs file

Guillaume Nault <g.nault@alphalink.fr>
    l2tp: hold reference on tunnels printed in pppol2tp proc file

Guillaume Nault <g.nault@alphalink.fr>
    l2tp: hold reference on tunnels in netlink dumps

Alexander Aring <aring@mojatatu.com>
    net: sched: ife: check on metadata length

Alexander Aring <aring@mojatatu.com>
    net: sched: ife: handle malformed tlv length

Alexander Aring <aring@mojatatu.com>
    net: sched: ife: signal not finding metaid

Tom Lendacky <thomas.lendacky@amd.com>
    amd-xgbe: Only use the SFP supported transceiver signals

Tom Lendacky <thomas.lendacky@amd.com>
    amd-xgbe: Improve KR auto-negotiation and training

Tom Lendacky <thomas.lendacky@amd.com>
    amd-xgbe: Add pre/post auto-negotiation phy hooks

Ronak Doshi <doshir@vmware.com>
    vmxnet3: fix incorrect dereference when rxvlan is disabled

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    vlan: Fix reading memory beyond skb->tail in skb_vlan_tagged_multi

Eric Dumazet <edumazet@google.com>
    tipc: add policy for TIPC_NLA_NET_ADDR

Xin Long <lucien.xin@gmail.com>
    team: fix netconsole setup over team

Paolo Abeni <pabeni@redhat.com>
    team: avoid adding twice the same option to the event list

Eric Dumazet <edumazet@google.com>
    tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets

Jann Horn <jannh@google.com>
    tcp: don't read out-of-bounds opsize

Soheil Hassas Yeganeh <soheil@google.com>
    tcp: clear tp->packets_out when purging write queue

Doron Roberts-Kedes <doronrk@fb.com>
    strparser: Fix incorrect strp->need_bytes value.

Doron Roberts-Kedes <doronrk@fb.com>
    strparser: Do not call mod_delayed_work with a timeout of LONG_MAX

Xin Long <lucien.xin@gmail.com>
    sctp: do not check port in sctp_inet6_cmp_addr

Dan Carpenter <dan.carpenter@oracle.com>
    Revert "macsec: missing dev_put() on error in macsec_newlink()"

Guillaume Nault <g.nault@alphalink.fr>
    pppoe: check sockaddr length in pppoe_connect()

Willem de Bruijn <willemb@google.com>
    packet: fix bitfield update race

Jose Abreu <Jose.Abreu@synopsys.com>
    net: stmmac: Disable ACS Feature for GMAC >= 4

Ursula Braun <ubraun@linux.vnet.ibm.com>
    net/smc: fix shutdown in state SMC_LISTEN

Pawel Dembicki <paweldembicki@gmail.com>
    net: qmi_wwan: add Wistron Neweb D19Q1

Maxime Chevallier <maxime.chevallier@bootlin.com>
    net: mvpp2: Fix DMA address mask size

Wolfgang Bumiller <w.bumiller@proxmox.com>
    net: fix deadlock while clearing neighbor proxy table

Eric Dumazet <edumazet@google.com>
    net: af_packet: fix race in PACKET_{R|T}X_RING

Cong Wang <xiyou.wangcong@gmail.com>
    llc: delete timers synchronously in llc_sk_free()

Guillaume Nault <g.nault@alphalink.fr>
    l2tp: check sockaddr length in pppol2tp_connect()

Eric Biggers <ebiggers@google.com>
    KEYS: DNS: limit the length of option strings

Ahmed Abdelsalam <amsalam20@gmail.com>
    ipv6: sr: fix NULL pointer dereference in seg6_do_srh_encap()- v4 pkts

Eric Dumazet <edumazet@google.com>
    ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy

Olivier Gayot <olivier.gayot@sigexec.com>
    docs: ip-sysctl.txt: fix name of some ipv6 variables

Xin Long <lucien.xin@gmail.com>
    bonding: do not set slave_dev npinfo before slave_enable_netpoll in bond_enslave

Karthikeyan Periyasamy <periyasa@codeaurora.org>
    Revert "ath10k: send (re)assoc peer command when NSS changed"

James Bottomley <James.Bottomley@HansenPartnership.com>
    tpm: add retry logic

Winkler, Tomas <tomas.winkler@intel.com>
    tpm: tpm-interface: fix tpm_transmit/_cmd kdoc

Tomas Winkler <tomas.winkler@intel.com>
    tpm: cmd_ready command can be issued only after granting locality

Paweł Jabłoński <pawel.jablonski@intel.com>
    i40e: Fix attach VF to VM issue

Neil Armstrong <narmstrong@baylibre.com>
    drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX SoCs

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "pinctrl: intel: Initialize GPIO properly when used through irqchip"


-------------

Diffstat:

 Documentation/networking/ip-sysctl.txt             |   8 +-
 Makefile                                           |   4 +-
 arch/s390/kernel/perf_cpum_cf_events.c             |   8 +-
 arch/s390/kernel/uprobes.c                         |   9 +
 drivers/acpi/acpi_video.c                          |  27 ++-
 drivers/block/swim.c                               |  49 +++---
 drivers/block/swim3.c                              |   6 +-
 drivers/cdrom/cdrom.c                              |   2 +-
 drivers/char/tpm/tpm-interface.c                   | 131 +++++++++++---
 drivers/char/tpm/tpm.h                             |   1 +
 drivers/char/tpm/tpm_crb.c                         | 108 ++++++++----
 drivers/char/tpm/tpm_tis_core.c                    |   4 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   3 +
 drivers/hwmon/k10temp.c                            |  17 +-
 drivers/message/fusion/mptsas.c                    |   1 +
 drivers/net/bonding/bond_main.c                    |   3 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h        |   8 +
 drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c       |  16 ++
 drivers/net/ethernet/amd/xgbe/xgbe-main.c          |   1 +
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  24 ++-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           |   2 +
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        | 196 +++++++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h               |   9 +
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   8 +-
 .../aquantia/atlantic/hw_atl/hw_atl_utils.c        |  16 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  49 +++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_nvm_defs.h |   2 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  11 ++
 drivers/net/ethernet/marvell/mvpp2.c               |  12 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   7 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   7 +-
 drivers/net/ethernet/ti/cpsw.c                     |   2 +-
 drivers/net/macsec.c                               |   5 +-
 drivers/net/ppp/pppoe.c                            |   4 +
 drivers/net/team/team.c                            |  38 +++-
 drivers/net/tun.c                                  |   7 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/virtio_net.c                           |  79 +++++----
 drivers/net/vmxnet3/vmxnet3_drv.c                  |  17 +-
 drivers/net/vmxnet3/vmxnet3_int.h                  |   4 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   5 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |  23 +--
 drivers/s390/block/dasd_alias.c                    |  13 +-
 drivers/s390/cio/chsc.c                            |  14 +-
 drivers/s390/net/qeth_core.h                       |   2 -
 drivers/s390/net/qeth_core_main.c                  | 115 ++++++------
 include/linux/fsnotify_backend.h                   |   4 +-
 include/linux/hmm.h                                |   9 +-
 include/linux/if_vlan.h                            |   7 +-
 include/linux/tpm.h                                |   2 +-
 include/net/ife.h                                  |   3 +-
 include/net/llc_conn.h                             |   1 +
 kernel/kprobes.c                                   |   2 +-
 kernel/trace/trace_entries.h                       |   2 +-
 net/core/dev.c                                     |   2 +-
 net/core/neighbour.c                               |  40 +++--
 net/dns_resolver/dns_key.c                         |  12 +-
 net/ife/ife.c                                      |  38 +++-
 net/ipv4/tcp.c                                     |   8 +-
 net/ipv4/tcp_input.c                               |   7 +-
 net/ipv6/route.c                                   |   2 +
 net/ipv6/seg6_iptunnel.c                           |   2 +-
 net/l2tp/l2tp_core.c                               |  40 ++---
 net/l2tp/l2tp_core.h                               |   3 +-
 net/l2tp/l2tp_debugfs.c                            |  18 +-
 net/l2tp/l2tp_netlink.c                            |  11 +-
 net/l2tp/l2tp_ppp.c                                |  34 +++-
 net/llc/af_llc.c                                   |  14 +-
 net/llc/llc_c_ac.c                                 |   9 +-
 net/llc/llc_conn.c                                 |  22 ++-
 net/packet/af_packet.c                             |  83 ++++++---
 net/packet/internal.h                              |  10 +-
 net/sched/act_ife.c                                |   9 +-
 net/sctp/ipv6.c                                    |  60 +++----
 net/smc/af_smc.c                                   |  10 +-
 net/strparser/strparser.c                          |   9 +-
 net/tipc/netlink.c                                 |   3 +-
 net/vmw_vsock/af_vsock.c                           |   6 +
 security/commoncap.c                               |   2 +
 80 files changed, 1084 insertions(+), 480 deletions(-)
