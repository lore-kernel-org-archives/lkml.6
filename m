Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039319-1523472290-2-7597782737873464057
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
    1523472288; b=djUT7M3oNdzdi1A5UyfGHvjkbbTBoc9LqsrN3QtGeaw8EC0EAe
    6BLuEJQKIme+g2hZSZZ8SkrtK28RzubFteye4vTV5ng6PvTMOACV5f10lVbc2DE5
    G/GlE+EgNm+Ga4bGqiwJHYgmlo1Gj3mN/IZnIfEnW7h0M9tkjWISix7omPbq2BPj
    yUL2WHWTw46SMsxTVoaCV6cPN6ebKIN2cRRusY0J4I2NW0gVvOntHP+RPuczwGnT
    D2YAt9us29ailiPVCVM5Qr0eLjklp5eZ0Z2DgAeBdY3nWtzaR8pXDaZV4CkujGsr
    ffmJG40H0mEQmhSnQX0tQ4TH3fL+fYqtNbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1523472288; bh=rLW/NrTJu6verxNvoO/rz05VPXzdIs
    7kr8P7fA4ID/E=; b=f6xy3KW1bwKpMseISZxCWNYelPPZTvtb7qNQEdLLT3ACQN
    t+sj2bbO7+Vlpmtiolmfm5RldHJjF14pGtl96Df5Lbyduz3/0y0/cA9jx+jXG0xU
    RV1MBLZqCxs1PAQEuX3Obiu1a+tQzYGlBb3tUTOb9rk1F4T2j94eEYPFzgJ+B02f
    4+dWCt6K/+XXkdOE3pVs2RT/l5UV6O7j1eeNHXwoqoE4JnsJ8Oar9axlRP+BMLoR
    Q31FH48RYpJKrOzcgWX5Cw8ChLiWz/tuYpLhrDM09/6qSD9tfi/A6Z8Ekptascsa
    FT+mb+fhhJQ+X+7Ga+LkxzV+YaMMrPXI0hyU0tIg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfGOSmt3uN6N8A4Y4w1PvIaEkc8YOKcBBDmi0PPHoMqfB8dUpsc9HxenRVfrOTj6SmRyZ3HLopkUjw2qBGt9DQOtZu2SvcemKCs0GXawz7zNmdkyjcXvv
    uwOfu8Mpn/FbTE8ZxNVEKv5YJmy2twUVbNLdHTwFOp6eI9l4yhis+iBW1i3xXQLKHbY5NXQtiFFHvp5FONtu114lb4cqTmhCMdPgSsYft/b6x84vo3pygyKs
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=vPLX6U1NJuQA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=pGLkceISAAAA:8
    a=20KFwNOVAAAA:8 a=A7XncKjpAAAA:8 a=1XWaLZrsAAAA:8 a=DfNHnWVPAAAA:8
    a=-COPsrLyAAAA:8 a=UGG5zPGqAAAA:8 a=AGRr4plBAAAA:8 a=2KMo9-giAAAA:8
    a=BTeA3XvPAAAA:8 a=i0EeH86SAAAA:8 a=1RTuLK3dAAAA:8 a=CDq0vqnqAAAA:8
    a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=Dei6p5SHAAAA:8 a=yPCof4ZbAAAA:8
    a=zAyngx5bAAAA:8 a=mK_AVkanAAAA:8 a=iox4zFpeAAAA:8 a=r_1tXGB3AAAA:8
    a=JfrnYn6hAAAA:8 a=taGs_qngAAAA:8 a=8AirrxEcAAAA:8 a=PHq6YzTAAAAA:8
    a=C_IRinGWAAAA:8 a=Byx-y9mGAAAA:8 a=G2B6q9MqAAAA:8 a=CbDCq_QkAAAA:8
    a=R5C9hjxsAAAA:8 a=6rqHouBjAAAA:8 a=sozttTNsAAAA:8 a=7CQSdrXTAAAA:8
    a=YHR9agUoAAAA:8 a=_Wotqz80AAAA:8 a=KKAkSRfTAAAA:8 a=Q-fNiiVtAAAA:8
    a=vQBBkBfzAAAA:8 a=hD80L64hAAAA:8 a=C8Vud2rhAAAA:8 a=Gxa0E6KgAAAA:8
    a=vrZRev11AAAA:8 a=Iz6zksb9AAAA:8 a=yC-0_ovQAAAA:8 a=ZVUqWHHvAAAA:8
    a=cm27Pg_UAAAA:8 a=6R7veym_AAAA:8 a=AMTvMMonAAAA:8 a=HSIkpTvyAAAA:8
    a=M5GUcnROAAAA:8 a=uP1ucDPQAAAA:8 a=vmLDa1wCAAAA:8 a=voM4FWlXAAAA:8
    a=5mpuRNi4AAAA:8 a=3-RhneuVAAAA:8 a=VZJtwKKvAAAA:8 a=TYBLyS7eAAAA:8
    a=9Wbp7B8dAAAA:8 a=7ZN4cI0QAAAA:8 a=InJrZTXqAAAA:8 a=gVGD3344AAAA:8
    a=GsPEFLG45B7nijCH97wA:9 a=RWZ7J7StoLsjn5KE:21 a=ri7xS-LDIPNprIlw:21
    a=QEXdDO2ut3YA:10 a=EOjQJoPH5SwA:10 a=YvGC9c-t7e4A:10 a=--zZkfMNmG8A:10
    a=UadM04RvI7AA:10 a=R2tBe8qpMIAA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=R9rPLQDAdC6-Ub70kJmZ:22 a=rjTVMONInIDnV1a_A2c_:22
    a=ksTjKdeKf_QrTKGjYr5L:22 a=17ibUXfGiVyGqR_YBevW:22 a=bOnWt3ThIoLzEnqt84vq:22
    a=UeCTMeHK7YUBiLmz_SX7:22 a=tafbbOV3vt1XuEhzTjGK:22 a=kRpfLKi8w9umh8uBmg1i:22
    a=Xn7iXEen_xUG9zZOO_Hb:22 a=M-Yerj1wOn-OpK7r_3ei:22 a=4LA4qAFo6bo561LpWNDU:22
    a=3gWm3jAn84ENXaBijsEo:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755445AbeDKSom (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:44:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755456AbeDKSoj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:44:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 000/190] 4.4.128-stable review
Date: Wed, 11 Apr 2018 20:34:06 +0200
Message-Id: <20180411183550.114495991@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.128-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.128-rc1
X-KernelTest-Deadline: 2018-04-13T18:36+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.128 release.
There are 190 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Apr 13 18:34:54 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.128-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.128-rc1

David Ahern <dsahern@gmail.com>
    vrf: Fix use after free and double free in vrf_finish_output

Paolo Abeni <pabeni@redhat.com>
    ipv6: the entire IPv6 header chain must fit the first fragment

Jeff Barnhill <0xeffeff@gmail.com>
    net/ipv6: Increment OUTxxx counters after netfilter hook

Craig Dillabaugh <cdillaba@mojatatu.com>
    net sched actions: fix dumping which requires several messages to user space

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix setting driver_data after register_netdev

Eric Dumazet <edumazet@google.com>
    vti6: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    ip6_tunnel: better validate user provided tunnel names

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

Hangbin Liu <liuhangbin@gmail.com>
    vlan: also check phy_driver ts_info for vlan's real device

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

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix NULL dereference in the error path of tcf_bpf_init()

Alexander Potapenko <glider@google.com>
    netlink: make sure nladdr has correct size in netlink_connect()

David Ahern <dsahern@gmail.com>
    net/ipv6: Fix route leaking between VRFs

Eric Dumazet <edumazet@google.com>
    net: fix possible out-of-bound read in skb_network_protocol()

Miguel Fadon Perlines <mfadon@teldat.com>
    arp: fix arp_filter on l3slave devices

Arnd Bergmann <arnd@arndb.de>
    Kbuild: provide a __UNIQUE_ID for clang

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

Jiri Olsa <jolsa@kernel.org>
    perf tools: Fix copyfile_offset update of output offset

Arjun Vynipadath <arjun@chelsio.com>
    cxgb4vf: Fix SGE FL buffer initialization logic for 64K pages

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    EDAC, mv64x60: Fix an error handling path

Tony Lindgren <tony@atomide.com>
    tty: n_gsm: Allow ADM response in addition to UA for control dlci

Ming Lei <ming.lei@redhat.com>
    blk-mq: fix kernel oops in blk_mq_tag_idle()

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

Stefan Haberland <sth@linux.vnet.ibm.com>
    s390/dasd: fix hanging safe offline

Bob Moore <robert.moore@intel.com>
    ACPICA: Disassembler: Abort on an invalid/unknown AML opcode

Lv Zheng <lv.zheng@intel.com>
    ACPICA: Events: Add runtime stub support for event APIs

Christophe Jaillet <christophe.jaillet@wanadoo.fr>
    cpuidle: dt: Add missing 'of_node_put()'

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

Willem de Bruijn <willemb@google.com>
    skbuff: only inherit relevant tx_flags

Namhyung Kim <namhyung@kernel.org>
    perf tests: Decompress kernel module before objdump

Christian Lamparter <chunkeey@googlemail.com>
    net: emac: fix reset timeout with AR8035 phy

James Wang <jnwang@suse.com>
    Fix loop device flush before configure v3

Marcin Nowakowski <marcin.nowakowski@imgtec.com>
    MIPS: kprobes: flush_insn_slot should flush only if probe initialised

Marcin Nowakowski <marcin.nowakowski@imgtec.com>
    MIPS: mm: adjust PKMAP location

Marcin Nowakowski <marcin.nowakowski@imgtec.com>
    MIPS: mm: fixed mappings: correct initialisation

Peter Zijlstra <peterz@infradead.org>
    perf/core: Correct event creation with PERF_FORMAT_GROUP

Chris Wilson <chris@chris-wilson.co.uk>
    e1000e: Undo e1000e_pm_freeze if __e1000_shutdown fails

Leonard Crestez <leonard.crestez@nxp.com>
    ARM: imx: Add MXC_CPU_IMX6ULL and cpu_is_imx6ull

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

Namhyung Kim <namhyung@kernel.org>
    perf header: Set proper module name when build-id event found

Ido Shamay <idos@mellanox.com>
    net/mlx4: Check if Granular QoS per VF has been enabled before updating QP qos_vport

Talat Batheesh <talatb@mellanox.com>
    net/mlx4: Fix the check in attaching steering rules

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    sit: reload iphdr in ipip6_rcv

Jason A. Donenfeld <Jason@zx2c4.com>
    skbuff: return -EMSGSIZE in skb_to_sgvec to prevent overflow

Dmitry Monakhov <dmonakhov@openvz.org>
    bio-integrity: Do not allocate integrity context for bio w/o data

Thomas Bogendoerfer <tsbogend@alpha.franken.de>
    Fix serial console on SNI RM400 machines

Ganesh Goudar <ganeshgr@chelsio.com>
    cxgb4: fix incorrect cim_la output for T6

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

Bryan O'Donoghue <pure.logic@nexus-software.ie>
    clk: Fix __set_clk_rates error print-string

Sudeep Holla <sudeep.holla@arm.com>
    clk: scpi: fix return type of __scpi_dvfs_round_rate

Roman Pen <roman.penyaev@profitbricks.com>
    KVM: SVM: do not zero out segment attributes if segment is unusable or not present

Gustavo A. R. Silva <garsilva@embeddedor.com>
    net: freescale: fix potential null pointer dereference

NeilBrown <neilb@suse.com>
    SUNRPC: ensure correct error is reported by xs_tcp_setup_socket()

Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
    rtc: interface: Validate alarm-time before handling rollover

Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
    rtc: opal: Handle disabled TPO in opal_get_tpo_time()

Arjun Vynipadath <arjun@chelsio.com>
    cxgb4: FW upgrade fixes

Arnd Bergmann <arnd@arndb.de>
    net/mlx5: avoid build warning for uniprocessor

Will Deacon <will.deacon@arm.com>
    arm64: futex: Fix undefined behaviour with FUTEX_OP_OPARG_SHIFT usage

Arvind Yadav <arvind.yadav.cs@gmail.com>
    dmaengine: imx-sdma: Handle return value of clk_prepare_enable

Ivan Mikhaylov <ivan@de.ibm.com>
    powerpc/[booke|4xx]: Don't clobber TCR[WP] when setting TCR[DIE]

Miklos Szeredi <mszeredi@redhat.com>
    ovl: filter trusted xattr for non-admin

Firo Yang <firogm@gmail.com>
    hdlcdrv: Fix divide by zero in hdlcdrv_ioctl

Colin Ian King <colin.king@canonical.com>
    wl1251: check return from call to wl1251_acx_arp_ip_filter

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ASoC: Intel: sst: Fix the return value of 'sst_send_byte_stream_mrfld()'

Linus Walleij <linus.walleij@linaro.org>
    gpio: label descriptors using the device name

Pieter \"PoroCYon\" Sluys <pcy@national.shitposting.agency>
    vfb: fix video mode and line_length being set when loaded

Chaitra P B <chaitra.basappa@broadcom.com>
    scsi: mpt3sas: Proper handling of set/clear of "ATA command pending" flag.

Rafael David Tinoco <rafael.tinoco@canonical.com>
    scsi: libiscsi: Allow sd_shutdown on bad transport

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: cht_bsw_rt5645: Analog Mic support

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: videobuf2-core: don't go out of the buffer range

Maciej Purski <m.purski@samsung.com>
    hwmon: (ina2xx) Make calibration register value fixed

Sowmini Varadhan <sowmini.varadhan@oracle.com>
    rds; Reset rs->rs_bound_addr in rds_add_bound() failure path

Hangbin Liu <liuhangbin@gmail.com>
    l2tp: fix missing print session offset info

Masami Hiramatsu <mhiramat@kernel.org>
    perf probe: Add warning message if there is unexpected event name

Yi Zeng <yizeng@asrmicro.com>
    thermal: power_allocator: fix one race condition issue for thermal_instances list

Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    ARM: dts: ls1021a: add "fsl,ls1021a-esdhc" compatible string to esdhc node

linzhang <xiaolou4617@gmail.com>
    net: llc: add lock_sock in llc_ui_bind to avoid a race condition

Jan H. Schönherr <jschoenh@amazon.de>
    KVM: nVMX: Fix handling of lmsw instruction

Nithin Sujir <nsujir@tintri.com>
    bonding: Don't update slave->link until ready to commit

KT Liao <kt.liao@emc.com.tw>
    Input: elan_i2c - clear INT before resetting controller

Roman Kapl <roman.kapl@sysgo.com>
    net: move somaxconn init from sysctl code

Eric Dumazet <edumazet@google.com>
    tcp: better validation of received ack sequences

Eryu Guan <eguan@redhat.com>
    ext4: fix off-by-one on max nr_pages in ext4_find_unwritten_pgoff()

Michael Schmitz <schmitzmic@gmail.com>
    fix race in drivers/char/random.c:get_reg()

Maurizio Lombardi <mlombard@redhat.com>
    scsi: bnx2fc: fix race condition in bnx2fc_get_host_stats()

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: SSI PIO adjust to 24bit mode

Dan Carpenter <dan.carpenter@oracle.com>
    pNFS/flexfiles: missing error code in ff_layout_alloc_lseg()

Liping Zhang <zlpnobody@gmail.com>
    netfilter: ctnetlink: fix incorrect nf_ct_put during hash resize

Dan Carpenter <dan.carpenter@oracle.com>
    libceph: NULL deref on crush_decode() error path

Lin Zhang <xiaolou4617@gmail.com>
    net: ieee802154: fix net_device reference release too early

Jesper Dangaard Brouer <brouer@redhat.com>
    mlx5: fix bug reading rss_hash_type from CQE

Dan Carpenter <dan.carpenter@oracle.com>
    block: fix an error code in add_partition()

Stephen Smalley <sds@tycho.nsa.gov>
    selinux: do not check open permission on sockets

Tariq Toukan <tariqt@mellanox.com>
    net/mlx5: Tolerate irq_set_affinity_hint() failures

Vlastimil Babka <vbabka@suse.cz>
    sched/numa: Use down_read_trylock() for the mmap_sem

Tin Huynh <tnhuynh@apm.com>
    leds: pca955x: Correct I2C Functionality

Kees Cook <keescook@chromium.org>
    ray_cs: Avoid reading past end of buffer

Suman Anna <s-anna@ti.com>
    ARM: davinci: da8xx: Create DSP device only when assigned memory

Guoqing Jiang <gqjiang@suse.com>
    md-cluster: fix potential lock issue in add_new_disk

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    ext4: handle the rest of ext4_mb_load_buddy() ENOMEM errors

Nikita Yushchenko <nikita.yoush@cogentembedded.com>
    iio: hi8435: cleanup reset gpio

Nikita Yushchenko <nikita.yoush@cogentembedded.com>
    iio: hi8435: avoid garbage event at first enable

Antony Antony <antony@phenome.org>
    xfrm: fix state migration copy replay sequence numbers

Michael Ellerman <mpe@ellerman.id.au>
    selftests/powerpc: Fix TM resched DSCR test with some compilers

Colin Ian King <colin.king@canonical.com>
    ath5k: fix memory leak on buf on failed eeprom read

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Fix virt_addr_valid() etc. on 64-bit hash

Varun Prakash <varun@chelsio.com>
    scsi: csiostor: fix use after free in csio_hw_use_fwconfig()

Geert Uytterhoeven <geert+renesas@glider.be>
    sh_eth: Use platform device for printing before register_netdev()

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: sh-sci: Fix race condition causing garbage during shutdown

Vignesh R <vigneshr@ti.com>
    serial: 8250: omap: Disable DMA for console UART

Alan Stern <stern@rowland.harvard.edu>
    USB: ene_usb6250: fix SCSI residue overwriting

linzhang <xiaolou4617@gmail.com>
    net: x25: fix one potential use-after-free issue

Alan Stern <stern@rowland.harvard.edu>
    USB: ene_usb6250: fix first command execution

Jisheng Zhang <jszhang@marvell.com>
    usb: chipidea: properly handle host or gadget initialization failure

Ihar Hrachyshka <ihrachys@redhat.com>
    arp: honour gratuitous ARP _replies_

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

Fabio Estevam <fabio.estevam@nxp.com>
    ARM: dts: imx53-qsrb: Pulldown PMIC IRQ pin

Dan Carpenter <dan.carpenter@oracle.com>
    PowerCap: Fix an error code in powercap_register_zone()

Doug Berger <opendmb@gmail.com>
    bus: brcmstb_gisb: correct support for 64-bit address output

Doug Berger <opendmb@gmail.com>
    bus: brcmstb_gisb: Use register offsets with writes too

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    SMB2: Fix share type handling

Neil Horman <nhorman@tuxdriver.com>
    vmxnet3: ensure that adapter is in proper state during force_close

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S PR: Check copy_to/from_user return values

KT Liao <kt.liao@emc.com.tw>
    Input: elantech - force relative mode on a certain module

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: elan_i2c - check if device is there before really probing

Colin Ian King <colin.king@canonical.com>
    netxen_nic: set rcode to the return status from the call to netxen_issue_cmd

Stefan Wahren <stefan.wahren@i2se.com>
    net: qca_spi: Fix alignment issues in rx path

Wen Xiong <wenxiong@linux.vnet.ibm.com>
    blk-mq: NVMe 512B/4K+T10 DIF/DIX format returns I/O error on dd with split op

Rabin Vincent <rabinv@axis.com>
    CIFS: silence lockdep splat in cifs_relock_file()

Trond Myklebust <trond.myklebust@primarydata.com>
    NFSv4.1: Work around a Linux server bug...

Talat Batheesh <talatb@mellanox.com>
    net/mlx4_en: Avoid adding steering rules with invalid ring

Heiko Carstens <heiko.carstens@de.ibm.com>
    s390: move _text symbol to address higher than zero

Kirill Tkhai <ktkhai@virtuozzo.com>
    pidns: disable pid allocation if pid_ns_prepare_proc() is failed in alloc_pid()

Dan Carpenter <dan.carpenter@oracle.com>
    drivers/misc/vmw_vmci/vmci_queue_pair.c: fix a couple integer overflow tests

J. Bruce Fields <bfields@redhat.com>
    lockd: fix lockd shutdown race

Grygorii Strashko <grygorii.strashko@ti.com>
    net: ethernet: ti: cpsw: adjust cpsw fifos depth for fullduplex flow control

Jim Baxter <jim_baxter@mentor.com>
    net: cdc_ncm: Fix TX zero padding

Dan Carpenter <dan.carpenter@oracle.com>
    ipmi_ssif: unlock on allocation failure

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

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/asm: Don't use RBP as a temporary register in csum_partial_copy_generic()

Pan Bian <bianpan2016@163.com>
    rtc: snvs: fix an incorrect check of return value

Julia Cartwright <julia@ni.com>
    md/raid5: make use of spin_lock_irq over local_irq_disable + spin_lock

Johannes Berg <johannes.berg@intel.com>
    cfg80211: make RATE_INFO_BW_20 the default


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/boot/dts/imx53-qsrb.dts                   |  2 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |  1 +
 arch/arm/boot/dts/ls1021a.dtsi                     |  2 +-
 arch/arm/include/asm/xen/events.h                  |  2 +-
 arch/arm/mach-davinci/devices-da8xx.c              | 10 +++
 arch/arm/mach-imx/cpu.c                            |  3 +
 arch/arm/mach-imx/mxc.h                            |  6 ++
 arch/arm64/include/asm/futex.h                     |  8 +-
 arch/mips/include/asm/kprobes.h                    |  3 +-
 arch/mips/include/asm/pgtable-32.h                 |  7 +-
 arch/mips/mm/pgtable-32.c                          |  6 +-
 arch/powerpc/include/asm/page.h                    | 12 +++
 arch/powerpc/kernel/time.c                         | 14 +++-
 arch/powerpc/kvm/book3s_pr_papr.c                  | 34 ++++++--
 arch/powerpc/platforms/cell/spufs/coredump.c       |  2 +
 arch/s390/kernel/vmlinux.lds.S                     |  8 +-
 arch/sparc/kernel/ldc.c                            |  7 +-
 arch/x86/kernel/tsc.c                              |  2 +
 arch/x86/kvm/svm.c                                 | 24 +++---
 arch/x86/kvm/vmx.c                                 |  7 +-
 arch/x86/lib/csum-copy_64.S                        | 12 +--
 block/bio-integrity.c                              |  3 +
 block/blk-mq.c                                     |  7 +-
 block/partition-generic.c                          |  4 +-
 crypto/async_tx/async_pq.c                         |  5 +-
 drivers/acpi/acpica/evxfevnt.c                     | 18 ++++
 drivers/acpi/acpica/psobject.c                     | 14 ++++
 drivers/ata/libahci_platform.c                     |  5 +-
 drivers/block/loop.c                               |  3 +
 drivers/bus/brcmstb_gisb.c                         | 42 +++++-----
 drivers/char/ipmi/ipmi_ssif.c                      |  2 +
 drivers/char/random.c                              | 10 ++-
 drivers/clk/clk-conf.c                             |  2 +-
 drivers/clk/clk-scpi.c                             |  6 +-
 drivers/cpuidle/dt_idle_states.c                   |  4 +-
 drivers/dma/imx-sdma.c                             | 23 +++--
 drivers/edac/mv64x60_edac.c                        |  2 +-
 drivers/gpio/gpiolib.c                             |  3 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                 |  4 +-
 drivers/hwmon/ina2xx.c                             | 87 +++++++++++--------
 drivers/iio/adc/hi8435.c                           | 27 ++++--
 drivers/iio/magnetometer/st_magn_spi.c             |  2 -
 drivers/infiniband/ulp/srpt/ib_srpt.c              |  6 +-
 drivers/input/mouse/elan_i2c_core.c                |  7 ++
 drivers/input/mouse/elan_i2c_i2c.c                 |  9 +-
 drivers/input/mouse/elantech.c                     | 11 +++
 drivers/isdn/mISDN/stack.c                         |  2 +-
 drivers/leds/leds-pca955x.c                        |  2 +-
 drivers/md/bcache/alloc.c                          | 19 +++--
 drivers/md/bcache/super.c                          |  6 ++
 drivers/md/md-cluster.c                            |  4 +-
 drivers/md/raid5.c                                 | 17 ++--
 drivers/media/i2c/cx25840/cx25840-core.c           | 36 ++++----
 drivers/media/rc/mceusb.c                          |  9 +-
 drivers/media/v4l2-core/videobuf2-core.c           |  4 +
 drivers/misc/vmw_vmci/vmci_queue_pair.c            | 10 ++-
 drivers/net/bonding/bond_main.c                    | 84 ++++++++++---------
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    | 19 ++++-
 drivers/net/ethernet/brocade/bna/bfa_ioc.c         |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         | 32 ++++++-
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c         | 23 +++--
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |  9 +-
 drivers/net/ethernet/ibm/emac/core.c               | 26 +++++-
 drivers/net/ethernet/intel/e1000e/netdev.c         | 17 +++-
 drivers/net/ethernet/marvell/sky2.c                |  2 +-
 drivers/net/ethernet/mellanox/mlx4/mcg.c           | 15 +++-
 drivers/net/ethernet/mellanox/mlx4/qp.c            | 19 +++++
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  | 16 ++--
 drivers/net/ethernet/mellanox/mlx5/core/main.c     | 14 +---
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
 drivers/net/usb/cdc_ncm.c                          | 11 ++-
 drivers/net/virtio_net.c                           | 16 +++-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |  5 ++
 drivers/net/vrf.c                                  |  8 +-
 drivers/net/vxlan.c                                |  2 +-
 drivers/net/wireless/ath/ath5k/debug.c             |  5 +-
 drivers/net/wireless/ray_cs.c                      |  7 +-
 drivers/net/wireless/ti/wl1251/main.c              |  3 +-
 drivers/powercap/powercap_sys.c                    |  1 +
 drivers/rtc/interface.c                            |  9 +-
 drivers/rtc/rtc-opal.c                             | 10 +++
 drivers/rtc/rtc-snvs.c                             |  2 +-
 drivers/s390/block/dasd.c                          |  8 +-
 drivers/scsi/bnx2fc/bnx2fc.h                       |  1 +
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  | 10 ++-
 drivers/scsi/csiostor/csio_hw.c                    |  5 +-
 drivers/scsi/libiscsi.c                            | 24 +++++-
 drivers/scsi/libsas/sas_expander.c                 |  4 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               | 28 ++++---
 drivers/staging/wlan-ng/prism2mgmt.c               |  2 +-
 drivers/thermal/power_allocator.c                  |  2 +
 drivers/tty/n_gsm.c                                | 17 +++-
 drivers/tty/serial/8250/8250_omap.c                |  4 +
 drivers/tty/serial/sccnxp.c                        | 15 ++--
 drivers/tty/serial/sh-sci.c                        | 16 +++-
 drivers/usb/chipidea/core.c                        | 29 +++++--
 drivers/usb/dwc3/dwc3-keystone.c                   |  4 +
 drivers/usb/storage/ene_ub6250.c                   | 11 ++-
 drivers/vhost/vhost.c                              |  3 +-
 drivers/video/fbdev/vfb.c                          | 17 ++++
 fs/btrfs/extent_io.c                               |  2 +-
 fs/cifs/file.c                                     |  2 +-
 fs/cifs/smb2pdu.c                                  | 14 ++--
 fs/ext4/file.c                                     |  2 +-
 fs/ext4/mballoc.c                                  | 23 +++--
 fs/lockd/svc.c                                     |  6 +-
 fs/nfs/flexfilelayout/flexfilelayout.c             |  1 +
 fs/nfs/nfs4proc.c                                  | 13 ++-
 fs/nfs/nfs4state.c                                 | 10 ++-
 fs/overlayfs/inode.c                               | 12 ++-
 include/linux/compiler-clang.h                     |  5 ++
 include/linux/mlx4/qp.h                            |  1 +
 include/linux/mlx5/device.h                        | 10 ++-
 include/linux/skbuff.h                             |  8 +-
 include/net/cfg80211.h                             |  2 +-
 include/net/x25.h                                  |  4 +-
 kernel/events/core.c                               | 15 ++--
 kernel/futex.c                                     | 98 ++++++++++++++++++++--
 kernel/pid.c                                       |  4 +-
 kernel/sched/fair.c                                |  3 +-
 net/8021q/vlan_dev.c                               |  6 +-
 net/bluetooth/hci_core.c                           | 17 +++-
 net/ceph/osdmap.c                                  |  1 +
 net/core/dev.c                                     |  4 +-
 net/core/neighbour.c                               | 14 +++-
 net/core/net_namespace.c                           | 19 +++++
 net/core/skbuff.c                                  | 75 +++++++++++------
 net/core/sysctl_net_core.c                         |  2 -
 net/ieee802154/socket.c                            |  8 +-
 net/ipv4/ah4.c                                     |  8 +-
 net/ipv4/arp.c                                     | 18 +++-
 net/ipv4/esp4.c                                    | 13 +--
 net/ipv4/ip_tunnel.c                               | 11 +--
 net/ipv4/tcp_input.c                               | 24 +++---
 net/ipv6/addrconf.c                                |  5 +-
 net/ipv6/ah6.c                                     |  8 +-
 net/ipv6/esp6.c                                    | 12 ++-
 net/ipv6/ip6_gre.c                                 |  8 +-
 net/ipv6/ip6_output.c                              | 19 +++--
 net/ipv6/ip6_tunnel.c                              | 11 ++-
 net/ipv6/ip6_vti.c                                 |  7 +-
 net/ipv6/route.c                                   |  3 +
 net/ipv6/sit.c                                     |  9 +-
 net/key/af_key.c                                   |  2 +-
 net/l2tp/l2tp_netlink.c                            |  2 +
 net/llc/af_llc.c                                   |  3 +
 net/mac80211/mlme.c                                |  4 +
 net/netfilter/nf_conntrack_netlink.c               |  7 +-
 net/netlink/af_netlink.c                           |  3 +
 net/rds/bind.c                                     |  1 +
 net/rxrpc/rxkad.c                                  | 21 +++--
 net/sched/act_api.c                                |  4 +-
 net/sched/act_bpf.c                                | 12 ++-
 net/sctp/ipv6.c                                    |  4 +-
 net/sctp/socket.c                                  | 17 ++--
 net/sunrpc/xprtsock.c                              |  7 +-
 net/x25/af_x25.c                                   | 24 ++++--
 net/x25/sysctl_net_x25.c                           |  5 +-
 net/xfrm/xfrm_state.c                              |  2 +
 scripts/tags.sh                                    |  1 +
 security/selinux/hooks.c                           | 10 ++-
 sound/soc/intel/atom/sst/sst_stream.c              |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |  7 ++
 sound/soc/sh/rcar/ssi.c                            | 11 ++-
 tools/perf/builtin-trace.c                         |  4 +
 tools/perf/tests/code-reading.c                    | 20 ++++-
 tools/perf/util/header.c                           | 12 ++-
 tools/perf/util/probe-event.c                      |  8 ++
 tools/perf/util/unwind-libdw.c                     |  8 ++
 tools/perf/util/util.c                             |  2 +-
 .../testing/selftests/powerpc/tm/tm-resched-dscr.c |  2 +-
 181 files changed, 1416 insertions(+), 523 deletions(-)
