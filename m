Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481964-2-13354420336357109875
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
    1523481963; b=oNXGt1YkII32U+5lRjWrZWqPonOXgbTXeoVV6x2kiBPjjoVjl1
    vMD8PiikgMVR2cs4csXuChpY2UY7qe8kde6CiLTeLSQpKF7z9Di6aMui/D8jiGw3
    b7xZzDR3b3jSp+VZ2psi6L3DKAZ+cyYuOjwdIlF6yaD1nuAzGvyPxIULr1Zg8x8J
    C+S7pvysMrU/p8Yz0Y+o9WVnXIkpkE8SNtetRMX+fTqTSoO2kLia6/fzmBpW8XSY
    YehXILKRheoA52rDCeelh91lxxPv+/ijX2CZllsFE5k67kCUO2ssirp0aSPNA/n7
    UmEf/0bXs6il+1DICkb1vMOvzz2KXHy61YzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1523481963; bh=omnMLcsQJjf31M6/nUNMvi2St8IWoL
    X9r1XqFxjBEz4=; b=HoFKEn5AJqcyTAOMTOFGTiiv1mhjP7bO1yPeTpEk/4/P5x
    p2rSBI6EapYOlgc7pu50GjCWvXwQwbpahsZCzurn3Qs6GFcAakXyghj+gh9PdjWV
    tFWAksDYDfKJAIMTweSvZxzh2FYX6lm0Sbhj9WWF7QYWQJZri8hkjXkmL/upy7S7
    hQ1OCziurZgVTETO3MtUanEsFfzdPlHXhSCQy9KMRAjZn43r/B5cZmEmDeYaQPyM
    y9QesRG6nlwtF2Wjy5GgwEwhf1LHEVf455BovlWLDAD7LwElWKVY7Sz/ZR1iM3cB
    GstT2Qx1eNkkFTIU2Iphm9YChNva5GktmkrKf9Ow==
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
X-CM-Envelope: MS4wfFd9/HBBvIAl5s9T+Qtuj1Xbid4OXZ4Rj0U2vgIVpJdUizza3JpNDUIIZyO64poeKlogeT3pkPnU7fpRPHzBWWU6rnCha55eZWS8i+l93WeEu2cYrWiS
    gY4RY6QHcvntxUp1/KLALTLvHsWiGcJbhPijtXdgJvXWRdcCGm+/sJ+byqrHyIuf6Lfpw9cE/+S75l0mra9k1ahukA9YIsgMuVpjTGXBzskEyIHtLSVUyoPI
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=USzuPbOPRRIA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8
    a=A7XncKjpAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=DfNHnWVPAAAA:8
    a=UGG5zPGqAAAA:8 a=2KMo9-giAAAA:8 a=BTeA3XvPAAAA:8 a=i0EeH86SAAAA:8
    a=1RTuLK3dAAAA:8 a=CDq0vqnqAAAA:8 a=QyXUC8HyAAAA:8 a=Dei6p5SHAAAA:8
    a=yPCof4ZbAAAA:8 a=zAyngx5bAAAA:8 a=mK_AVkanAAAA:8 a=r_1tXGB3AAAA:8
    a=JfrnYn6hAAAA:8 a=taGs_qngAAAA:8 a=PHq6YzTAAAAA:8 a=C_IRinGWAAAA:8
    a=Byx-y9mGAAAA:8 a=G2B6q9MqAAAA:8 a=CbDCq_QkAAAA:8 a=6rqHouBjAAAA:8
    a=sozttTNsAAAA:8 a=YHR9agUoAAAA:8 a=_Wotqz80AAAA:8 a=VnNF1IyMAAAA:8
    a=7CQSdrXTAAAA:8 a=Gxa0E6KgAAAA:8 a=Iz6zksb9AAAA:8 a=ZVUqWHHvAAAA:8
    a=cm27Pg_UAAAA:8 a=HSIkpTvyAAAA:8 a=M5GUcnROAAAA:8 a=uP1ucDPQAAAA:8
    a=Q-fNiiVtAAAA:8 a=8AirrxEcAAAA:8 a=vmLDa1wCAAAA:8 a=voM4FWlXAAAA:8
    a=5mpuRNi4AAAA:8 a=3-RhneuVAAAA:8 a=TYBLyS7eAAAA:8 a=7ZN4cI0QAAAA:8
    a=InJrZTXqAAAA:8 a=VZJtwKKvAAAA:8 a=OCkUrp7ITIHe9fvPBgMA:9
    a=gGySMOluAlV1MYaN:21 a=xyrGZx2wuV73nWGN:21 a=QEXdDO2ut3YA:10
    a=C7lipPgOzLIA:10 a=YvGC9c-t7e4A:10 a=--zZkfMNmG8A:10 a=UadM04RvI7AA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=R9rPLQDAdC6-Ub70kJmZ:22
    a=rjTVMONInIDnV1a_A2c_:22 a=17ibUXfGiVyGqR_YBevW:22 a=UeCTMeHK7YUBiLmz_SX7:22
    a=tafbbOV3vt1XuEhzTjGK:22 a=kRpfLKi8w9umh8uBmg1i:22 a=Xn7iXEen_xUG9zZOO_Hb:22
    a=M-Yerj1wOn-OpK7r_3ei:22 a=4LA4qAFo6bo561LpWNDU:22 a=3gWm3jAn84ENXaBijsEo:22
    a=t8nPyN_e6usw4ciXM-Pk:22 a=1CNFftbPRP8L7MoqJWF3:22 a=DM_PlaNYpjARcMQr2apF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbeDKSiY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:38:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55318 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753958AbeDKSiT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:38:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 000/121] 3.18.105-stable review
Date: Wed, 11 Apr 2018 20:35:03 +0200
Message-Id: <20180411183456.195010921@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.105-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.105-rc1
X-KernelTest-Deadline: 2018-04-13T18:35+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.105 release.
There are 121 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Apr 13 18:34:28 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.105-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.105-rc1

Paolo Abeni <pabeni@redhat.com>
    ipv6: the entire IPv6 header chain must fit the first fragment

Craig Dillabaugh <cdillaba@mojatatu.com>
    net sched actions: fix dumping which requires several messages to user space

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix setting driver_data after register_netdev

Eric Dumazet <edumazet@google.com>
    ip6_tunnel: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    vti6: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    ip6_gre: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    ipv6: sit: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    ip_tunnel: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    net: fool proof dev_valid_name()

Xin Long <lucien.xin@gmail.com>
    bonding: process the err returned by dev_set_allmulti properly in bond_enslave

Xin Long <lucien.xin@gmail.com>
    bonding: move dev_mc_sync after master_upper_dev_link in bond_enslave

Xin Long <lucien.xin@gmail.com>
    bonding: fix the err path for dev hwaddr sync in bond_enslave

Jason Wang <jasowang@redhat.com>
    vhost: correctly remove wait queue during poll failure

Kai-Heng Feng <kai.heng.feng@canonical.com>
    sky2: Increase D3 delay to sky2 stops working after suspend

Eric Dumazet <edumazet@google.com>
    sctp: sctp_sockaddr_af must check minimal addr length for AF_INET6

Eric Dumazet <edumazet@google.com>
    sctp: do not leak kernel memory to user space

Eric Dumazet <edumazet@google.com>
    pptp: remove a buggy dst release in pptp_connect()

Alexander Potapenko <glider@google.com>
    netlink: make sure nladdr has correct size in netlink_connect()

Eric Dumazet <edumazet@google.com>
    net: fix possible out-of-bound read in skb_network_protocol()

Mel Gorman <mgorman@suse.de>
    futex: Remove requirement for lock_page() in get_futex_key()

Theodore Ts'o <tytso@mit.edu>
    random: use lockless method of accessing and updating f->reg_idx

Nathan Chancellor <natechancellor@gmail.com>
    virtio_net: check return value of skb_to_sgvec in one more location

Jason A. Donenfeld <Jason@zx2c4.com>
    virtio_net: check return value of skb_to_sgvec always

Jason A. Donenfeld <Jason@zx2c4.com>
    rxrpc: check return value of skb_to_sgvec always

Jason A. Donenfeld <Jason@zx2c4.com>
    ipsec: check return value of skb_to_sgvec always

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    EDAC, mv64x60: Fix an error handling path

Tony Lindgren <tony@atomide.com>
    tty: n_gsm: Allow ADM response in addition to UA for control dlci

chenxiang <chenxiang66@hisilicon.com>
    scsi: libsas: initialize sas_phy status according to response of DISCOVER

Jason Yan <yanaijie@huawei.com>
    scsi: libsas: fix error when getting phy events

Jason Yan <yanaijie@huawei.com>
    scsi: libsas: fix memory leak in sas_smp_get_phy_events()

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: segregate flash only volume write streams

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: stop writeback thread after detaching

Roopa Prabhu <roopa@cumulusnetworks.com>
    vxlan: dont migrate permanent fdb entries during learn

Bob Moore <robert.moore@intel.com>
    ACPICA: Disassembler: Abort on an invalid/unknown AML opcode

Lv Zheng <lv.zheng@intel.com>
    ACPICA: Events: Add runtime stub support for event APIs

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: Send HCI Set Event Mask Page 2 command only when needed

Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
    iio: magnetometer: st_magn_spi: fix spi_device_id table

Jag Raman <jag.raman@oracle.com>
    sparc64: ldc abort during vds iso boot

Xin Long <lucien.xin@gmail.com>
    sctp: fix recursive locking warning in sctp_do_peeloff

Mintz, Yuval <Yuval.Mintz@cavium.com>
    bnx2x: Allow vfs to disable txvlan offload

Arnd Bergmann <arnd@arndb.de>
    xen: avoid type warning in xchg_xen_ulong

Namhyung Kim <namhyung@kernel.org>
    perf tests: Decompress kernel module before objdump

Christian Lamparter <chunkeey@googlemail.com>
    net: emac: fix reset timeout with AR8035 phy

Marcin Nowakowski <marcin.nowakowski@imgtec.com>
    MIPS: kprobes: flush_insn_slot should flush only if probe initialised

Marcin Nowakowski <marcin.nowakowski@imgtec.com>
    MIPS: mm: fixed mappings: correct initialisation

Peter Zijlstra <peterz@infradead.org>
    perf/core: Correct event creation with PERF_FORMAT_GROUP

Chris Wilson <chris@chris-wilson.co.uk>
    e1000e: Undo e1000e_pm_freeze if __e1000_shutdown fails

Russell King <rmk+kernel@armlinux.org.uk>
    net: phy: avoid genphy_aneg_done() for PHYs without clause 22 support

A Sun <as1033x@comcast.net>
    mceusb: sporadic RX truncation corruption fix

Pan Bian <bianpan2016@163.com>
    cx25840: fix unchecked return values

Jacob Keller <jacob.e.keller@intel.com>
    e1000e: fix race condition around skb_tstamp_tx()

Robert Jarzmik <robert.jarzmik@free.fr>
    tags: honor COMPILED_SOURCE with apart output directory

Milian Wolff <milian.wolff@kdab.com>
    perf report: Ensure the perf DSO mapping matches what libdw sees

Talat Batheesh <talatb@mellanox.com>
    net/mlx4: Fix the check in attaching steering rules

Jason A. Donenfeld <Jason@zx2c4.com>
    skbuff: return -EMSGSIZE in skb_to_sgvec to prevent overflow

Dmitry Monakhov <dmonakhov@openvz.org>
    bio-integrity: Do not allocate integrity context for bio w/o data

Thomas Bogendoerfer <tsbogend@alpha.franken.de>
    Fix serial console on SNI RM400 machines

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/omap: fix tiled buffer stride calculations

Jia-Ju Bai <baijiaju1990@163.com>
    mISDN: Fix a sleep-in-atomic bug

Jia-Ju Bai <baijiaju1990@163.com>
    qlcnic: Fix a sleep-in-atomic bug in qlcnic_82xx_hw_write_wx_2M and qlcnic_82xx_hw_read_wx_2M

Jiri Olsa <jolsa@kernel.org>
    perf trace: Add mmap alias for s390

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/spufs: Fix coredump of SPU contexts

Roman Pen <roman.penyaev@profitbricks.com>
    KVM: SVM: do not zero out segment attributes if segment is unusable or not present

Gustavo A. R. Silva <garsilva@embeddedor.com>
    net: freescale: fix potential null pointer dereference

Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
    rtc: interface: Validate alarm-time before handling rollover

Will Deacon <will.deacon@arm.com>
    arm64: futex: Fix undefined behaviour with FUTEX_OP_OPARG_SHIFT usage

Ivan Mikhaylov <ivan@de.ibm.com>
    powerpc/[booke|4xx]: Don't clobber TCR[WP] when setting TCR[DIE]

Miklos Szeredi <mszeredi@redhat.com>
    ovl: filter trusted xattr for non-admin

Firo Yang <firogm@gmail.com>
    hdlcdrv: Fix divide by zero in hdlcdrv_ioctl

Colin Ian King <colin.king@canonical.com>
    wl1251: check return from call to wl1251_acx_arp_ip_filter

Pieter \"PoroCYon\" Sluys <pcy@national.shitposting.agency>
    vfb: fix video mode and line_length being set when loaded

Rafael David Tinoco <rafael.tinoco@canonical.com>
    scsi: libiscsi: Allow sd_shutdown on bad transport

Hangbin Liu <liuhangbin@gmail.com>
    l2tp: fix missing print session offset info

linzhang <xiaolou4617@gmail.com>
    net: llc: add lock_sock in llc_ui_bind to avoid a race condition

Jan H. Schönherr <jschoenh@amazon.de>
    KVM: nVMX: Fix handling of lmsw instruction

Nithin Sujir <nsujir@tintri.com>
    bonding: Don't update slave->link until ready to commit

Roman Kapl <roman.kapl@sysgo.com>
    net: move somaxconn init from sysctl code

Eryu Guan <eguan@redhat.com>
    ext4: fix off-by-one on max nr_pages in ext4_find_unwritten_pgoff()

Michael Schmitz <schmitzmic@gmail.com>
    fix race in drivers/char/random.c:get_reg()

Maurizio Lombardi <mlombard@redhat.com>
    scsi: bnx2fc: fix race condition in bnx2fc_get_host_stats()

Liping Zhang <zlpnobody@gmail.com>
    netfilter: ctnetlink: fix incorrect nf_ct_put during hash resize

Dan Carpenter <dan.carpenter@oracle.com>
    libceph: NULL deref on crush_decode() error path

Dan Carpenter <dan.carpenter@oracle.com>
    block: fix an error code in add_partition()

Tin Huynh <tnhuynh@apm.com>
    leds: pca955x: Correct I2C Functionality

Kees Cook <keescook@chromium.org>
    ray_cs: Avoid reading past end of buffer

Suman Anna <s-anna@ti.com>
    ARM: davinci: da8xx: Create DSP device only when assigned memory

Antony Antony <antony@phenome.org>
    xfrm: fix state migration copy replay sequence numbers

Michael Ellerman <mpe@ellerman.id.au>
    selftests/powerpc: Fix TM resched DSCR test with some compilers

Colin Ian King <colin.king@canonical.com>
    ath5k: fix memory leak on buf on failed eeprom read

Geert Uytterhoeven <geert+renesas@glider.be>
    sh_eth: Use platform device for printing before register_netdev()

Alan Stern <stern@rowland.harvard.edu>
    USB: ene_usb6250: fix SCSI residue overwriting

linzhang <xiaolou4617@gmail.com>
    net: x25: fix one potential use-after-free issue

Alan Stern <stern@rowland.harvard.edu>
    USB: ene_usb6250: fix first command execution

Jisheng Zhang <jszhang@marvell.com>
    usb: chipidea: properly handle host or gadget initialization failure

Ihar Hrachyshka <ihrachys@redhat.com>
    neighbour: update neigh timestamps iff update is effective

Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
    ata: libahci: properly propagate return value of platform_get_irq()

Colin Ian King <colin.king@canonical.com>
    btrfs: fix incorrect error return ret being passed to mapping_set_error

Pan Bian <bianpan2016@163.com>
    usb: dwc3: keystone: check return value

Anup Patel <anup.patel@broadcom.com>
    async_tx: Fix DMA_PREP_FENCE usage in do_async_gen_syndrome()

Mahesh Bandewar <maheshb@google.com>
    ipv6: avoid dad-failures for addresses with NODAD

Fabio Estevam <fabio.estevam@nxp.com>
    ARM: dts: imx6qdl-wandboard: Fix audio channel swap

Peter Zijlstra <peterz@infradead.org>
    x86/tsc: Provide 'tsc=unstable' boot parameter

Andrea della Porta <sfaragnaus@gmail.com>
    staging: wlan-ng: prism2mgmt.c: fixed a double endian conversion before calling hfa384x_drvr_setconfig16, also fixes relative sparse warning

Dan Carpenter <dan.carpenter@oracle.com>
    PowerCap: Fix an error code in powercap_register_zone()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    SMB2: Fix share type handling

Neil Horman <nhorman@tuxdriver.com>
    vmxnet3: ensure that adapter is in proper state during force_close

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S PR: Check copy_to/from_user return values

Colin Ian King <colin.king@canonical.com>
    netxen_nic: set rcode to the return status from the call to netxen_issue_cmd

Stefan Wahren <stefan.wahren@i2se.com>
    net: qca_spi: Fix alignment issues in rx path

Rabin Vincent <rabinv@axis.com>
    CIFS: silence lockdep splat in cifs_relock_file()

Talat Batheesh <talatb@mellanox.com>
    net/mlx4_en: Avoid adding steering rules with invalid ring

Heiko Carstens <heiko.carstens@de.ibm.com>
    s390: move _text symbol to address higher than zero

Kirill Tkhai <ktkhai@virtuozzo.com>
    pidns: disable pid allocation if pid_ns_prepare_proc() is failed in alloc_pid()

J. Bruce Fields <bfields@redhat.com>
    lockd: fix lockd shutdown race

Grygorii Strashko <grygorii.strashko@ti.com>
    net: ethernet: ti: cpsw: adjust cpsw fifos depth for fullduplex flow control

Kees Cook <keescook@chromium.org>
    qlge: Avoid reading past end of buffer

Kees Cook <keescook@chromium.org>
    bna: Avoid reading past end of buffer

Luca Coelho <luciano.coelho@intel.com>
    mac80211: bail out from prep_connection() if a reconfig is ongoing

Steffen Klassert <steffen.klassert@secunet.com>
    af_key: Fix slab-out-of-bounds in pfkey_compile_policy.

Bart Van Assche <bart.vanassche@sandisk.com>
    IB/srpt: Fix abort handling

Trond Myklebust <trond.myklebust@primarydata.com>
    NFSv4.1: RECLAIM_COMPLETE must handle NFS4ERR_CONN_NOT_BOUND_TO_SESSION


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |  1 +
 arch/arm/include/asm/xen/events.h                  |  2 +-
 arch/arm/mach-davinci/devices-da8xx.c              | 10 +++
 arch/arm64/include/asm/futex.h                     |  8 +-
 arch/mips/include/asm/kprobes.h                    |  3 +-
 arch/mips/mm/pgtable-32.c                          |  6 +-
 arch/powerpc/kernel/time.c                         | 14 +++-
 arch/powerpc/kvm/book3s_pr_papr.c                  | 34 ++++++--
 arch/powerpc/platforms/cell/spufs/coredump.c       |  2 +
 arch/s390/kernel/vmlinux.lds.S                     |  8 +-
 arch/sparc/kernel/ldc.c                            |  7 +-
 arch/x86/kernel/tsc.c                              |  2 +
 arch/x86/kvm/svm.c                                 | 24 +++---
 arch/x86/kvm/vmx.c                                 |  7 +-
 block/bio-integrity.c                              |  3 +
 block/partition-generic.c                          |  4 +-
 crypto/async_tx/async_pq.c                         |  5 +-
 drivers/acpi/acpica/evxfevnt.c                     | 18 ++++
 drivers/acpi/acpica/psobject.c                     | 14 ++++
 drivers/ata/libahci_platform.c                     |  5 +-
 drivers/char/random.c                              | 10 ++-
 drivers/edac/mv64x60_edac.c                        |  2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                 |  4 +-
 drivers/iio/magnetometer/st_magn_spi.c             |  2 -
 drivers/infiniband/ulp/srpt/ib_srpt.c              |  6 +-
 drivers/isdn/mISDN/stack.c                         |  2 +-
 drivers/leds/leds-pca955x.c                        |  2 +-
 drivers/md/bcache/alloc.c                          | 19 +++--
 drivers/md/bcache/super.c                          |  6 ++
 drivers/media/i2c/cx25840/cx25840-core.c           | 36 ++++----
 drivers/media/rc/mceusb.c                          |  9 +-
 drivers/net/bonding/bond_main.c                    | 84 ++++++++++---------
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    | 19 ++++-
 drivers/net/ethernet/brocade/bna/bfa_ioc.c         |  2 +-
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |  9 +-
 drivers/net/ethernet/ibm/emac/core.c               | 26 +++++-
 drivers/net/ethernet/intel/e1000e/netdev.c         | 17 +++-
 drivers/net/ethernet/marvell/sky2.c                |  2 +-
 drivers/net/ethernet/mellanox/mlx4/mcg.c           | 15 +++-
 drivers/net/ethernet/mellanox/mlx4/qp.c            | 13 +++
 .../net/ethernet/qlogic/netxen/netxen_nic_ctx.c    |  2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c     |  2 +-
 drivers/net/ethernet/qlogic/qlge/qlge_dbg.c        |  4 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            | 10 ++-
 drivers/net/ethernet/realtek/r8169.c               |  4 +-
 drivers/net/ethernet/renesas/sh_eth.c              |  2 +-
 drivers/net/ethernet/ti/cpsw.c                     | 16 ++++
 drivers/net/hamradio/hdlcdrv.c                     |  2 +
 drivers/net/phy/phy.c                              |  6 ++
 drivers/net/ppp/pptp.c                             |  1 -
 drivers/net/virtio_net.c                           | 16 +++-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |  5 ++
 drivers/net/vxlan.c                                |  2 +-
 drivers/net/wireless/ath/ath5k/debug.c             |  5 +-
 drivers/net/wireless/ray_cs.c                      |  7 +-
 drivers/net/wireless/ti/wl1251/main.c              |  3 +-
 drivers/powercap/powercap_sys.c                    |  1 +
 drivers/rtc/interface.c                            |  9 +-
 drivers/scsi/bnx2fc/bnx2fc.h                       |  1 +
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  | 10 ++-
 drivers/scsi/libiscsi.c                            | 24 +++++-
 drivers/scsi/libsas/sas_expander.c                 |  4 +-
 drivers/staging/wlan-ng/prism2mgmt.c               |  2 +-
 drivers/tty/n_gsm.c                                | 17 +++-
 drivers/tty/serial/sccnxp.c                        | 15 ++--
 drivers/usb/chipidea/core.c                        | 29 +++++--
 drivers/usb/dwc3/dwc3-keystone.c                   |  4 +
 drivers/usb/storage/ene_ub6250.c                   | 11 ++-
 drivers/vhost/vhost.c                              |  3 +-
 drivers/video/fbdev/vfb.c                          | 17 ++++
 fs/btrfs/extent_io.c                               |  2 +-
 fs/cifs/file.c                                     |  2 +-
 fs/cifs/smb2pdu.c                                  | 14 ++--
 fs/ext4/file.c                                     |  2 +-
 fs/lockd/svc.c                                     |  6 +-
 fs/nfs/nfs4proc.c                                  |  7 +-
 fs/nfs/nfs4state.c                                 | 10 ++-
 fs/overlayfs/inode.c                               | 12 ++-
 include/linux/mlx4/qp.h                            |  1 +
 include/linux/skbuff.h                             |  8 +-
 include/net/x25.h                                  |  4 +-
 kernel/events/core.c                               | 15 ++--
 kernel/futex.c                                     | 98 ++++++++++++++++++++--
 kernel/pid.c                                       |  4 +-
 net/bluetooth/hci_core.c                           | 17 +++-
 net/ceph/osdmap.c                                  |  1 +
 net/core/dev.c                                     |  4 +-
 net/core/neighbour.c                               | 14 +++-
 net/core/net_namespace.c                           | 19 +++++
 net/core/skbuff.c                                  | 65 +++++++++-----
 net/core/sysctl_net_core.c                         |  2 -
 net/ipv4/ah4.c                                     |  8 +-
 net/ipv4/esp4.c                                    | 12 ++-
 net/ipv4/ip_tunnel.c                               | 11 +--
 net/ipv6/addrconf.c                                |  5 +-
 net/ipv6/ah6.c                                     |  8 +-
 net/ipv6/esp6.c                                    | 12 ++-
 net/ipv6/ip6_gre.c                                 |  8 +-
 net/ipv6/ip6_output.c                              | 13 ++-
 net/ipv6/ip6_tunnel.c                              |  7 +-
 net/ipv6/ip6_vti.c                                 |  7 +-
 net/ipv6/sit.c                                     |  8 +-
 net/key/af_key.c                                   |  2 +-
 net/l2tp/l2tp_netlink.c                            |  2 +
 net/llc/af_llc.c                                   |  3 +
 net/mac80211/mlme.c                                |  4 +
 net/netfilter/nf_conntrack_netlink.c               |  7 +-
 net/netlink/af_netlink.c                           |  3 +
 net/rxrpc/rxkad.c                                  | 21 +++--
 net/sched/act_api.c                                |  4 +-
 net/sctp/ipv6.c                                    |  4 +-
 net/sctp/socket.c                                  | 17 ++--
 net/x25/af_x25.c                                   | 24 ++++--
 net/x25/sysctl_net_x25.c                           |  5 +-
 net/xfrm/xfrm_state.c                              |  2 +
 scripts/tags.sh                                    |  1 +
 tools/perf/builtin-trace.c                         |  4 +
 tools/perf/tests/code-reading.c                    | 20 ++++-
 tools/perf/util/unwind-libdw.c                     |  8 ++
 .../testing/selftests/powerpc/tm/tm-resched-dscr.c |  2 +-
 121 files changed, 925 insertions(+), 314 deletions(-)
