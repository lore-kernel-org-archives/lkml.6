Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C2CC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9439C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="axkO1twA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfAUI03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:26:29 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:32999 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfAUI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:26:28 -0500
Received: by mail-lj1-f179.google.com with SMTP id v1-v6so16778112ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oKDF3Pptnv62QV92T2PMlUsDobTT8nK0uQZXAOxdEMI=;
        b=axkO1twAi0wS2QhamOQYF6JsgrfFYjhNb7vFbIo30uWnfshPKExsa8ybhPn8UfvWSp
         kn8DKgIgBA/8SrO6mXW0k9bmHKkm1s7vw03AYifQHmnpRahx3+pLP9pTLCLezL5iQ/C8
         NbxZEZ5gF8EOUkowbNrkrdFjrF7ux3tgXy7zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oKDF3Pptnv62QV92T2PMlUsDobTT8nK0uQZXAOxdEMI=;
        b=Hp2yF1NHaOXkihmybQxhH8Y4QGFUbLyRsZdM3fSEEWphovutbN2GuTwYJFse2D+VV5
         8KowrsWTele0eS8XGQm9rQad/q1NYavcbNMahZB5kc2KhuVbn35PD/s9yd36k90PxZlt
         2vhzQq1xqmNNS8ex47PSfnlSLh2Y4ogd+wUI97yJI8capn5SWX/YW2KwYoeY9AbnuChq
         y5Hg7J/zi06kt9EgOEY4x7Tp0S5goXnRCVl4u9dvlv9f1011AfJGETFEZBRQgUsgbFk3
         t6eBj9uGlqi+QcKa1fM07gamMM+TBoA9T5GH6SIc6skmh4mHSU/6mpztA3YJPbXBe7Ou
         SxIQ==
X-Gm-Message-State: AJcUukdJXITK8twocHPA+BbVnunVIbPNM5lWbkuAep09ZSpZysxqPL+9
        VKM97fNFUTpFU7GvGjM9O+7cbiX5pp35xQ==
X-Google-Smtp-Source: ALg8bN6xFQ47+Aiu0amWP2azJObFMbHIDhr3VpeRilpjRawulvx8kDVcoqCRFPw8n9YytRdpanlOVQ==
X-Received: by 2002:a2e:3a04:: with SMTP id h4-v6mr16230816lja.81.1548031262617;
        Sun, 20 Jan 2019 16:41:02 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id a19sm1992235lfi.57.2019.01.20.16.41.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 16:41:01 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id x85-v6so16086017ljb.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 16:41:01 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr2428969lja.148.1548031261049;
 Sun, 20 Jan 2019 16:41:01 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Jan 2019 13:40:45 +1300
X-Gmail-Original-Message-ID: <CAHk-=whS=6Z_UxzoMjLANupOk3u-8ycERLPnaZxShMTviW0jkQ@mail.gmail.com>
Message-ID: <CAHk-=whS=6Z_UxzoMjLANupOk3u-8ycERLPnaZxShMTviW0jkQ@mail.gmail.com>
Subject: Linux 5.0-rc3
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm keeping to the usual "Sunday afternoon on the US west coast"
release schedule, even if it's actually already Monday afternoon in
here New Zealand. I'm traveling for LCA 2019.

This rc is a bit bigger than usual. Partly because I missed a
networking pull request for rc2, and as a result rc3 now contains
_two_ networking pull updates. But part of it may also just be that it
took a while for people to find and then fix bugs after the holiday
season.

So we have more commits than usual for rc3, although certainly not
breaking any records. And things look fairly normal, except that the
diffs are unusually big in the tooling department, with lots of bpf
test additions.

On the "kernel proper" side, things look fairly normal,  although with
the above caveat that we have two weeks worth of networking fixes, and
that shows up as both core networking and network driver updates.

But we've got other driver updates too (gpu, rdma, scsi, crypto,
acpi..) some arch updates (mainly some mips fixes), and various
smaller filesystem fixes.

The appended shortlog gives an overview of the details for people who
want to quickly just scroll down the kinds of things that got fixed.

Nothing particularly odd strikes me.

               Linus

---

Adit Ranadive (1):
      RDMA/vmw_pvrdma: Return the correct opcode when creating WR

Alban Bedel (1):
      MIPS: ath79: Enable OF serial ports in the default config

Alex Deucher (1):
      Revert "drm/amdgpu: validate user GEM object size"

Alexey Kodanev (2):
      udp: add missing rehash callback to udplite
      udp6: add missing rehash callback to udplite

Anders Roxell (1):
      selftests: bpf: install files tcp_(server|client)*.py

Andrea Righi (1):
      tracing/kprobes: Fix NULL pointer dereference in trace_kprobe_create(=
)

Andrew Lunn (4):
      net: dsa: mv88x6xxx: mv88e6390 errata
      net: phy: marvell: Errata for mv88e6390 internal PHYs
      net: phy: marvell: Fix deadlock from wrong locking
      net: phy: Add missing features to PHY drivers

Andrey Ignatov (2):
      bpf: Fix [::] -> [::1] rewrite in sys_sendmsg
      selftests/bpf: Test [::] -> [::1] rewrite in sys_sendmsg in test_sock=
_addr

Andrey Konovalov (1):
      kasan, arm64: remove redundant ARCH_SLAB_MINALIGN define

Ard Biesheuvel (3):
      arm64: kaslr: ensure randomized quantities are clean to the PoC
      gcc-plugins: arm_ssp_per_task_plugin: sign extend the SP mask
      gcc-plugins: arm_ssp_per_task_plugin: fix for GCC 9+

Arnd Bergmann (1):
      mips: fix n32 compat_ipc_parse_version

Arthur Gautier (1):
      netlink: fixup regression in RTM_GETADDR

Aurelien Jarno (1):
      MIPS: OCTEON: fix kexec support

Avri Altman (1):
      scsi: ufs: Fix geometry descriptor size

Aymen Sghaier (1):
      crypto: caam - fix zero-length buffer DMA mapping

Ben Skeggs (1):
      drm/nouveau/core: recognise TU102

Beomho Seo (1):
      mfd: exynos-lpass: Enable UART module support

Bijan Mottahedeh (1):
      vhost/scsi: Use copy_to_iter() to send control queue response

Bj=C3=B8rn Mork (1):
      cdc_ether: trivial whitespace readability fix

Breno Leitao (1):
      powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM

Bryan Whitehead (1):
      lan743x: Remove phy_read from link status change function

Camelia Groza (2):
      net: phy: add missing phy driver features
      net: phy: phy driver features are mandatory

Charlene Liu (1):
      drm/amd/display: fix PME notification not working in RV desktop

Charles Keepax (1):
      mfd: wm5110: Add missing ASRC rate register

Chen-Yu Tsai (1):
      mfd: axp20x: Re-align MFD cell entries

Cheng-Min Ao (1):
      hwmon: (tmp421) Correct the misspelling of the tmp442 compatible
attribute in OF device ID table

Cheng-Yi Chiang (1):
      mfd: cros_ec: Add commands to control codec

Christoph Hellwig (1):
      swiotlb: clear io_tlb_start and io_tlb_end in swiotlb_exit

Christophe JAILLET (2):
      octeontx2-af: Fix a resource leak in an error handling path in
'cgx_probe()'
      i3c: master: Fix an error checking typo in 'cdns_i3c_master_probe()'

Christophe Leroy (3):
      crypto: talitos - reorder code in talitos_edesc_alloc()
      crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK
      powerpc/8xx: fix setting of pagetable for Abatron BDI debug tool.

Chuck Lever (1):
      SUNRPC: Address Kerberos performance/behavior regression

Claudiu Beznea (1):
      net: macb: remove unnecessary code

Colin Ian King (3):
      net: cxgb3: fix various indentation issues
      net: cxgb4: fix various indentation issues
      atm: he: fix sign-extension overflow on large shift

Colin Xu (1):
      drm/i915/gvt: Allow F_CMD_ACCESS on mmio 0x21f0

Cong Wang (3):
      smc: move unhash as early as possible in smc_release()
      net_sched: refetch skb protocol for each filter
      net/mlx5e: Force CHECKSUM_UNNECESSARY for short ethernet frames

Cornelia Huck (2):
      virtio: fix virtio_config_ops description
      virtio: document virtio_config_ops restrictions

Dan Carpenter (7):
      mfd: ab8500-core: Return zero in get_register_interruptible()
      watchdog: tqmx86: Fix a couple IS_ERR() vs NULL bugs
      xprtrdma: Fix error code in rpcrdma_buffer_create()
      xprtrdma: Double free in rpcrdma_sendctxs_create()
      crypto: cavium/nitrox - Use after free in process_response_list()
      powerpc/powernv/npu: Allocate enough memory in
pnv_try_setup_npu_table_group()
      selftests/txtimestamp: Fix an equals vs assign bug

Dan Williams (1):
      libnvdimm/dimm: Fix security capability detection for non-Intel NVDIM=
Ms

Daniel Borkmann (6):
      bpf: fix sanitation of alu op with pointer / scalar type from
different paths
      bpf: add various test cases for alu op on mixed dst register types
      bpf, doc: update design qa to reflect kern_version requirement
      bpf, doc: add note for libbpf's stand-alone build
      bpf: pull in pkt_sched.h header for tooling to fix bpftool build
      bpf: fix inner map masking to prevent oob under speculation

Daniele Palmas (1):
      qmi_wwan: add MTU default to qmap network interface

Dave Jiang (1):
      libnvdimm/security: Fix nvdimm_security_state() state request selecti=
on

David Ahern (2):
      ipv6: Consider sk_bound_dev_if when binding a socket to a v4
mapped address
      ipv6: Take rcu_read_lock in __inet6_bind for mapped addresses

David Francis (1):
      drm/amd/display: Detach backlight from stream

David Howells (4):
      Revert "rxrpc: Allow failed client calls to be retried"
      afs: Fix key refcounting in file locking code
      afs: Provide a function to get a ref on a call
      afs: Fix race in async call refcounting

David Rientjes (1):
      net, skbuff: do not prefer skb allocation fails early

David Sterba (1):
      Revert "btrfs: balance dirty metadata pages in btrfs_finish_ordered_i=
o"

Davide Caratti (4):
      net/sched: act_tunnel_key: fix memory leak in case of action replace
      selftests: tc-testing: drop test on missing tunnel key id
      selftests: tc-testing: fix tunnel_key failure if dst_port is unspecif=
ied
      selftests: tc-testing: fix parsing of ife type

Denis Bolotin (2):
      qed: Fix qed_chain_set_prod() for PBL chains with non power of 2
page count
      qed: Fix qed_ll2_post_rx_buffer_notify_fw() by adding a write
memory barrier

Dien Pham (1):
      mfd: bd9571mwv: Add volatile register to make DVFS work

Dmitry Bezrukov (1):
      net: usb: aqc111: Extend HWID table by TRENDnet device

Eli Britstein (1):
      net/mlx5e: Fix cb_ident duplicate in indirect block register

Enric Balletbo i Serra (1):
      mfd: cros_ec_dev: Add missing mfd_remove_devices() call in remove

Eric Biggers (5):
      crypto: authenc - fix parsing key with misaligned rta_len
      crypto: bcm - convert to use crypto_authenc_extractkeys()
      crypto: ccree - convert to use crypto_authenc_extractkeys()
      crypto: adiantum - initialize crypto_spawn::inst
      crypto: sm3 - fix undefined shift by >=3D width of value

Eric Dumazet (3):
      ipv6: make icmp6_send() robust against null skb->dev
      ipv6: fix kernel-infoleak in ipv6_local_error()
      fou, fou6: do not assume linear skbs

Eugene Syromiatnikov (2):
      ptp: check that rsv field is zero in struct ptp_sys_offset_extended
      ptp: uapi: change _IOW to IOWR in PTP_SYS_OFFSET_EXTENDED definition

Felix Kuehling (2):
      drm/amdkfd: Allow building KFD on ARM64 (v2)
      drm/amdkfd: Don't assign dGPUs to APU topology devices

Felix Manlunas (1):
      MAINTAINERS: update email addresses of liquidio driver maintainers

Florian La Roche (1):
      fix int_sqrt64() for very large numbers

Frederic Barrat (1):
      powerpc/powernv/npu: Fix oops in pnv_try_setup_npu_table_group()

Gal Pressman (1):
      RDMA/uverbs: Fix post send success return value in case of error

Geert Uytterhoeven (1):
      mfd: tmio: Typo s/use use/use/

Gerd Hoffmann (2):
      drm/qxl: drop prime import/export callbacks
      drm/virtio: drop prime import/export callbacks

Greg Kroah-Hartman (1):
      IN_BADCLASS: fix macro to actually work

Guenter Roeck (2):
      hwmon: (nct6775) Fix chip ID for NCT6798D
      hwmon: (nct6775) Enable IO mapping for NCT6797D and NCT6798D

Gustavo A. R. Silva (6):
      tipc: fix memory leak in tipc_nl_compat_publ_dump
      hwmon: (occ) Fix potential integer overflow
      scsi: smartpqi_init: fix boolean expression in pqi_device_remove_star=
t
      scsi: lpfc: lpfc_sli: Mark expected switch fall-throughs
      afs: Use struct_size() in kzalloc()
      mISDN: hfcsusb: Use struct_size() in kzalloc()

Hang Yuan (1):
      drm/i915/gvt: free VFIO region space in vgpu detach

Hangbin Liu (1):
      ip6_gre: update version related info when changing link

Hans Verkuil (1):
      media: vim2m: only cancel work if it is for right context

Hans de Goede (1):
      gpiolib-acpi: Remove unnecessary WARN_ON from
acpi_gpiochip_free_interrupts

Harsh Jain (1):
      crypto: authencesn - Avoid twice completion call in decrypt path

Hauke Mehrtens (2):
      MIPS: lantiq: Fix IPI interrupt handling
      MIPS: lantiq: Use CP0_LEGACY_COMPARE_IRQ

Heiko Stuebner (2):
      backlight: pwm_bl: Re-add driver internal enabled tracking
      backlight: pwm_bl: Fix devicetree parsing with auto-generated
brightness tables

Heiner Kallweit (5):
      r8169: don't try to read counters if chip is in a PCI power-save stat=
e
      r8169: load Realtek PHY driver module before r8169
      net: ethernet: mediatek: fix warning in phy_start_aneg
      net: phy: fix too strict check in phy_start_aneg
      net: phy: micrel: set soft_reset callback to genphy_soft_reset for KS=
Z9031

Henry Yen (1):
      netfilter: nft_flow_offload: fix checking method of conntrack helper

Horia Geant=C4=83 (1):
      crypto: caam - fix SHA support detection

Ido Schimmel (14):
      mlxsw: spectrum: Add VXLAN dependency for spectrum
      mlxsw: spectrum_switchdev: Avoid returning errors in commit phase
      mlxsw: spectrum_nve: Replace error code with EINVAL
      selftests: mlxsw: Add a test case for VLAN addition error flow
      net: bridge: Fix VLANs memory leak
      selftests: forwarding: Fix test for different devices
      mlxsw: spectrum_switchdev: Set PVID correctly during VLAN deletion
      selftests: forwarding: Add a test for VLAN deletion
      net: ipv4: Fix memory leak in network namespace dismantle
      mlxsw: pci: Ring CQ's doorbell before RDQ's
      net: bridge: Mark FDB entries that were added by user as such
      mlxsw: spectrum_switchdev: Do not treat static FDB entries as sticky
      selftests: mlxsw: Test FDB offload indication
      selftests: forwarding: Add a test case for externally learned FDB ent=
ries

Ioana Ciornei (1):
      samples: bpf: user proper argument index

Ivan Mironov (1):
      scsi: sd: Fix cache_type_store()

Ivan Vecera (1):
      net/sched: cls_flower: allocate mask dynamically in fl_change()

Jacob Wen (1):
      rds: use DIV_ROUND_UP instead of ceil

Jakub Kicinski (2):
      ipv6: route: place a warning with duplicated string with correct exta=
ck
      Documentation: timestamping: correct path to net_tstamp.h

James Morris (1):
      LSM: Check for NULL cred-security on free

James Morse (1):
      arm64: kpti: Update arm64_kernel_use_ng_mappings() when forced on

Jan Kara (2):
      nbd: Use set_blocksize() to set device blocksize
      blockdev: Fix livelocks on loop device

Jason A. Donenfeld (1):
      powerpc/pseries: Fix build break due to pnv_npu2_init()

Jason Gunthorpe (4):
      phy: ti: Fix compilation failures without REGMAP
      packet: Do not leak dev refcounts on error exit
      RDMA/uverbs: Mark ioctl responses with UVERBS_ATTR_F_VALID_OUTPUT
      clang-format: Update .clang-format with the latest for_each macro lis=
t

Jason Wang (1):
      vhost: log dirty page correctly

Jean Delvare (1):
      mfd: at91-usart: Add platform dependency

Jeff Kirsher (2):
      ixgbe: fix Kconfig when driver is not a module
      Revert "igb: reduce CPU0 latency when updating statistics"

Jerome Brunet (1):
      dt-bindings: reset: meson-axg: fix SPDX license id

Jia-Ju Bai (1):
      isdn: i4l: isdn_tty: Fix some concurrency double-free bugs

JianJhen Chen (1):
      net: bridge: fix a bug on using a neighbour cache entry without
checking its state

Jiri Pirko (1):
      mlxsw: spectrum: Disable lag port TX before removing it

Johan Hovold (1):
      net: dsa: realtek-smi: fix OF child-node lookup

John Garry (1):
      scsi: hisi_sas: Set protection parameters prior to adding SCSI host

Jonathan Hunter (1):
      mfd: tps6586x: Handle interrupts on suspend

Jonathan Marek (1):
      mfd: qcom_rpm: write fw_version to CTRL_REG

Jonathan Neusch=C3=A4fer (1):
      net: Fix typo in NET_FAILOVER help text

Jose Abreu (5):
      net: stmmac: Fix PCI module removal leak
      net: stmmac: dwxgmac2: Only clear interrupts that are active
      net: stmmac: Check if CBS is supported before configuring
      net: stmmac: Fix the logic of checking if RX Watchdog must be enabled
      net: stmmac: Prevent RX starvation in stmmac_napi_poll()

Josef Bacik (4):
      btrfs: handle delayed ref head accounting cleanup in abort
      btrfs: wait on ordered extents on abort cleanup
      btrfs: run delayed iputs before committing
      btrfs: wakeup cleaner thread when adding delayed iput

Josip Pavic (1):
      drm/amd/display: Pack DMCU iRAM alignment

Juergen Gross (1):
      xen: Fix x86 sched_clock() interface for xen

Julia Lawall (5):
      scsi: pm80xx: reduce indentation
      drm/rockchip: add missing of_node_put
      drm/meson: add missing of_node_put
      drm/sun4i: backend: add missing of_node_puts
      OF: properties: add missing of_node_put

Kai-Heng Feng (1):
      r8169: Add support for new Realtek Ethernet

Kangjie Lu (2):
      mfd: mc13xxx: Fix a missing check of a register-read failure
      leds: lp5523: fix a missing check of return value of lp55xx_read

Keerthy (1):
      mfd: tps65218: Use devm_regmap_add_irq_chip and clean up error
path in probe()

Kees Cook (2):
      Yama: Check for pid death before checking ancestry
      pstore/ram: Avoid allocation and leak of platform data

Kenneth Feng (1):
      drm/amd/powerplay: run acg btc for Vega12

Konstantin Khlebnikov (2):
      net/core/neighbour: tell kmemleak about hash tables
      net/core/neighbour: fix kmemleak minimal reference count for hash tab=
les

Krzysztof Kazimierczak (1):
      xsk: Check if a queue exists during umem setup

Krzysztof Kozlowski (1):
      dt-bindings: soc: qcom: Fix trivial language typos

Lendacky, Thomas (1):
      amd-xgbe: Fix mdio access for non-zero ports and clause 45 PHYs

Leo Zhang (1):
      scsi: target/iscsi: fix error msg typo when create lio_qr_cache faile=
d

Leon Romanovsky (2):
      RDMA/nldev: Don't expose unsafe global rkey to regular user
      RDMA/mthca: Clear QP objects during their allocation

Linus Torvalds (1):
      Linux 5.0-rc3

Linus Walleij (3):
      net: dsa: microchip: Drop unused GPIO includes
      net: dsa: mt7530: Drop unused GPIO include
      mtd: rawnand: fsmc: Keep bank enable bit set

Logan Gunthorpe (2):
      scsi: isci: initialize shost fully before calling scsi_add_host()
      PCI: Fix __initdata issue with "pci=3Ddisable_acs_redir" parameter

Lorenz Bauer (1):
      bpf: libbpf: retry loading program on EAGAIN

Lubomir Rintel (1):
      dt-bindings: marvell,mmp2: fix typos in bindings doc

Luc Van Oostenryck (1):
      mtd: nand: jz4740: fix '__iomem *' vs. '* __iomem'

Madalin Bucur (1):
      dpaa_eth: NETIF_F_LLTX requires to do our own update of trans_start

Madhavan Srinivasan (1):
      powerpc/perf: Update perf_regs structure to include MMCRA

Manish Rangankar (1):
      scsi: qedi: Add ep_state for login completion on un-reachable targets

Marc Dionne (2):
      afs: Set correct lock type for the yfs CreateFile
      afs: Don't set vnode->cb_s_break in afs_validate()

Marcos Paulo de Souza (1):
      md: Make bio_alloc_mddev use bio_alloc_bioset

Mark Zhang (1):
      regmap-irq: do not write mask register if mask_base is zero

Martin Blumenstingl (1):
      mmc: core: don't override the CD GPIO level when "cd-inverted" is set

Masahiro Yamada (8):
      kconfig: clean generated *conf-cfg files
      kbuild: remove unused baseprereq
      kbuild: remove unused archmrproper
      ia64: remove redundant 'export AWK'
      nds32: remove unneeded code in arch/nds32/Makefile
      openrisc: remove unneeded code in arch/openrisc/Makefile
      kbuild: mark prepare0 as PHONY to fix external module build
      mtd: rawnand: denali: get ->setup_data_interface() working again

Mathieu Malaterre (3):
      bpf: Make function btf_name_offset_valid static
      bpf: Annotate implicit fall through in cgroup_dev_func_proto
      bpf: Correctly annotate implicit fall through in bpf_base_func_proto

Matti Vaittinen (1):
      regmap: regmap-irq: silently ignore unsupported type settings

Michael Chan (2):
      bnxt_en: Fix ring checking logic on 57500 chips.
      bnxt_en: Fix context memory allocation.

Michael Ellerman (2):
      powerpc/4xx/ocm: Fix fix for phys_addr_t printf warnings
      powerpc/syscalls: Fix syscall tracing

Michael S. Tsirkin (2):
      include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
      virtio_net: bulk free tx skbs

Michel D=C3=A4nzer (1):
      Revert "drm/amdgpu: validate user pitch alignment"

Ming Lei (5):
      scsi: qla2xxx: Use correct number of vectors for online CPUs
      sbitmap: Protect swap_lock from hardirq
      PCI/MSI: Return -ENOSPC from pci_alloc_irq_vectors_affinity()
      block: don't lose track of REQ_INTEGRITY flag
      nvme-pci: fix nvme_setup_irqs()

Nathan Chancellor (4):
      mfd: twl-core: Fix section annotations on {,un}protect_pm_master
      mfd: db8500-prcmu: Fix some section annotations
      nfit: Mark some functions as __maybe_unused
      isdn: avm: Fix string plus integer warning from Clang

Neil Armstrong (1):
      drm/meson: Fix atomic mode switching regression

NeilBrown (1):
      watchdog: mt7621_wdt/rt2880_wdt: Fix compilation problem

Nicholas Kazlauskas (2):
      drm/amd/display: Only get the connector state for VRR when toggled
      drm/amd/display: Fix disabled cursor on top screen edge

Nicolas Boichat (1):
      mfd: mt6397: Do not call irq_domain_remove if PMIC unsupported

Nicolas Dichtel (1):
      af_packet: fix raw sockets over 6in4 tunnel

Nir Dotan (5):
      mlxsw: spectrum_acl: Add cleanup after C-TCAM update error condition
      mlxsw: spectrum_acl: Remove ASSERT_RTNL()s in module removal flow
      mlxsw: pci: Increase PCI SW reset timeout
      mlxsw: pci: Return error on PCI reset timeout
      mlxsw: spectrum_fid: Update dummy FID index

Olga Kornievskaia (1):
      NFSv4.2 fix unnecessary retry in nfs4_copy_file_range

Oliver Hartkopp (1):
      can: gw: ensure DLC boundaries after CAN frame modification

Olivier Matz (1):
      ip6_gre: fix tunnel list corruption for x-netns

Oskari Lemmela (2):
      mfd: axp20x: Add AC power supply cell for AXP813
      mfd: axp20x: Add supported cells for AXP803

Otto Sabart (3):
      doc: bindings: fix bad reference to ARM CPU bindings
      doc: gpio-mvebu: fix broken reference to cp110-system-controller0.txt=
 file
      doc: net: fix bad references to network drivers

Pablo Neira Ayuso (1):
      netfilter: nf_tables: selective rule dump needs table to be specified

Paolo Abeni (1):
      net: clear skb->tstamp in bridge forwarding path

Paolo Valente (1):
      block, bfq: fix comments on __bfq_deactivate_entity

Paul Burton (1):
      kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with ftrace & GCC <=3D =
4.7

Paul Cercueil (1):
      mfd: ingenic-tcu: Fix bit field description in header

Pavel Tikhomirov (1):
      vhost: return EINVAL if iovecs size does not match the message size

Peter Oskolkov (2):
      selftests: net: fix/improve ip_defrag selftest
      bpf: bpf_setsockopt: reset sock dst on SO_MARK changes

Peter Rosin (1):
      fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd line option

Phil Sutter (1):
      netfilter: nf_tables: Fix for endless loop when dumping ruleset

Rafael J. Wysocki (1):
      ACPI: EC: Look for ECDT EC after calling acpi_load_tables()

Rafa=C5=82 Mi=C5=82ecki (1):
      MIPS: BCM47XX: Setup struct device for the SoC

Richard Fitzgerald (2):
      mfd: madera: Add shared data for accessory detection
      mfd: madera: Remove spurious semicolon in while loop

Rob Herring (6):
      backlight: 88pm860x_bl: Use of_node_name_eq for node name comparisons
      mfd: Use of_node_name_eq() for node name comparisons
      of: Remove struct device_node.type pointer
      fbdev: offb: Fix OF node name handling
      PCI: Fix PCI kconfig menu organization
      powerpc: chrp: Use of_node_is_type to access device_type

Roman Li (1):
      drm/amd/display: fix warning on raven hotplug

Ross Lagerwall (2):
      openvswitch: Avoid OOB read when parsing flow nlattrs
      net: Fix usage of pskb_trim_rcsum

Sagi Grimberg (1):
      nvmet-tcp: fix uninitialized variable access

Sai Prakash Ranjan (1):
      pstore/ram: Fix console ramoops to show the previous boot logs

Sakari Ailus (2):
      media: v4l: ioctl: Validate num_planes before using it
      media: v4l: ioctl: Validate num_planes for debug messages

Santosh kumar pradhan (1):
      sunrpc: kernel BUG at kernel/cred.c:825!

Shakeel Butt (1):
      netfilter: ebtables: account ebt_table_info to kmemcg

Shay Agroskin (1):
      net/mlx5e: Fix wrong error code return on FEC query failure

Shivasharan S (1):
      scsi: megaraid_sas: Retry reads of outbound_intr_status reg

Sinan Kaya (8):
      ACPI / LPSS: Make PCI dependency explicit
      ata: pata_acpi: Make PCI dependency explicit
      vga-switcheroo: make PCI dependency explicit
      platform/x86: intel_ips: make PCI dependency explicit
      platform/x86: intel_pmc: Make PCI dependency explicit
      platform/x86: apple-gmux: Make PCI dependency explicit
      x86/intel/lpss: Make PCI dependency explicit
      drivers: thermal: int340x_thermal: Make PCI dependency explicit

Song Liu (1):
      bpf: fix panic in stack_map_get_build_id() on i386 and arm32

Stanislav Fomichev (8):
      selftests/bpf: fix incorrect users of create_and_get_cgroup
      tun: publish tfile after it's fully initialized
      selftests/bpf: add missing executables to .gitignore
      selftests/bpf: install with_tunnels.sh for test_flow_dissector.sh
      tools/bpf: properly account for libbfd variations
      bpf: don't assume build-id length is always 20 bytes
      bpf: zero out build_id for BPF_STACK_BUILD_ID_IP
      selftests/bpf: retry tests that expect build-id

Stanley Chu (2):
      scsi: core: Synchronize request queue PM status only on successful re=
sume
      scsi: ufs: Fix system suspend status

Stefano Brivio (2):
      fou: Prevent unbounded recursion in GUE error handler also with UDP-L=
ite
      fou6: Prevent unbounded recursion in GUE error handler

Stefano Stabellini (5):
      pvcalls-front: read all data before closing the connection
      pvcalls-front: don't try to free unallocated rings
      pvcalls-front: properly allocate sk
      pvcalls-front: don't return error when the ring is full
      pvcalls-back: set -ENOTCONN in pvcalls_conn_back_read

Stephen Smalley (1):
      selinux: fix GPF on invalid policy

Stephen Warren (2):
      net/mlx4: Get rid of page operation after dma_alloc_coherent
      net/mlx4: replace pci_{,un}map_sg with dma_{,un}map_sg

Steve Wise (1):
      RDMA/cma: Add cm_id restrack resource based on kernel or user cm_id t=
ype

Steven Rostedt (VMware) (1):
      sbitmap: Protect swap_lock from softirqs

Taehee Yoo (6):
      netfilter: nf_tables: fix leaking object reference count
      umh: add exit routine for UMH process
      net: bpfilter: use cleanup callback to release umh_info
      net: bpfilter: restart bpfilter_umh when error occurred
      net: bpfilter: disallow to remove bpfilter module while being used
      net: bpfilter: change section name of bpfilter UMH blob.

Talons Lee (1):
      always clear the X2APIC_ENABLE bit for PV guest

Tariq Toukan (1):
      net/mlx5e: Fix wrong (zero) TX drop counter indication for represento=
r

Thierry Reding (1):
      media: v4l2-ioctl: Clear only per-plane reserved fields

Thomas Bogendoerfer (2):
      MIPS: jazz: fix 64bit build
      scsi: qla1280: set 64bit coherent mask

Thomas Gleixner (2):
      block: Cleanup license notice
      tools: bpftool: Cleanup license mess

Thomas Petazzoni (1):
      net: phy: mdio_bus: add missing device_del() in
mdiobus_register() error handling

Timotej Lazar (1):
      net: phy: meson-gxl: Use the genphy_soft_reset callback

Toke H=C3=B8iland-J=C3=B8rgensen (3):
      sched: Avoid dereferencing skb pointer after child enqueue
      sched: Fix detection of empty queues in child qdiscs
      sch_cake: Correctly update parent qlen when splitting GSO packets

Tomas Henzl (1):
      scsi: megaraid_sas: correct an info message

Tony Luck (1):
      acpi/nfit: Fix race accessing memdev in nfit_get_smbios_id()

Trond Myklebust (3):
      SUNRPC: Fix TCP receive code on archs with flush_dcache_page()
      SUNRPC: Ensure rq_bytes_sent is reset before request transmission
      SUNRPC: Ensure we respect the RPCSEC_GSS sequence number limit

Tycho Andersen (1):
      seccomp: fix UAF in user-trap code

Varun Prakash (1):
      scsi: cxgb4i: add wait_for_completion()

Vignesh R (2):
      mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd =
cells
      iio: adc: ti_am335x_tscadc: Improve accuracy of measurement

Vitor Soares (1):
      i3c: master: dw-i3c-master: fix i3c_attach/reattach

Vlad Tsyrklevich (1):
      omap2fb: Fix stack memory disclosure

Wei Wang (3):
      virtio_pci: use queue idx instead of array idx to set up the vq
      virtio: don't allocate vqs when names[i] =3D NULL
      virtio-balloon: tweak config_changed implementation

Wei Yang (1):
      acpi/nfit: Remove duplicate set nd_set in acpi_nfit_init_interleave_s=
et()

Wei Yongjun (2):
      hwmon: (lm80) Fix missing unlock on error in set_fan_div()
      gpio: pca953x: Make symbol 'pca953x_i2c_regmap' static

Wen Yang (3):
      soc/fsl/qe: fix err handling of ucc_of_parse_tdm
      pvcalls-front: Avoid get_free_pages(GFP_KERNEL) under spinlock
      pvcalls-front: fix potential null dereference

Will Deacon (1):
      x86: uaccess: Inhibit speculation past access_ok() in user_access_beg=
in()

Willem de Bruijn (5):
      ip: on queued skb use skb_header_pointer instead of pskb_may_pull
      bonding: update nest level on unlink
      tcp: allow MSG_ZEROCOPY transmission also in CLOSE_WAIT state
      udp: with udp_segment release on error path
      bpf: in __bpf_redirect_no_mac pull mac only if present

Xiaochun Lee (2):
      ACPI/nfit: delete the redundant header file
      ACPI/nfit: delete the function to_acpi_nfit_desc

Xin Long (2):
      erspan: build the header with the right proto according to erspan_ver
      sctp: allocate sctp_sockaddr_entry with kzalloc

Xiubo Li (1):
      scsi: tcmu: avoid cmd/qfull timers updated whenever a new cmd comes

Yang Wei (2):
      neighbour: Do not perturb drop profiles when neigh_probe
      macvlan: replace kfree_skb by consume_skb for drop profiles

Yangtao Li (1):
      mfd: rave-sp: Fix typo in rave_sp_checksum comment

Yi-Hung Wei (1):
      openvswitch: Fix IPv6 later frags parsing

Ying Xue (6):
      tipc: fix uninit-value in in tipc_conn_rcv_sub
      tipc: fix uninit-value in tipc_nl_compat_link_reset_stats
      tipc: fix uninit-value in tipc_nl_compat_bearer_enable
      tipc: fix uninit-value in tipc_nl_compat_link_set
      tipc: fix uninit-value in tipc_nl_compat_name_table_dump
      tipc: fix uninit-value in tipc_nl_compat_doit

Yonghong Song (4):
      bpf: fix bpffs bitfield pretty print
      tools/bpf: test btf bitfield with >=3D256 struct member offset
      tools/bpf: fix bpftool map dump with bitfields
      samples/bpf: workaround clang asm goto compilation errors

Yonglong Liu (2):
      net: hns: Fix WARNING when hns modules installed
      net: hns: Fix use after free identified by SLUB debug

Yuchung Cheng (3):
      bpf: correctly set initial window on active Fast Open sender
      tcp: change txhash on SYN-data timeout
      bpf: fix SO_MAX_PACING_RATE to support TCP internal pacing

YueHaibing (2):
      xen/pvcalls: remove set but not used variable 'intf'
      scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param

YunQiang Su (1):
      Disable MSI also when pcie-octeon.pcie_disable on

Yunjian Wang (1):
      net: bridge: Fix ethernet header pointer before check skb forwardable

Zha Bin (1):
      vhost/vsock: fix vhost vsock cid hashing inconsistent

Zhenyu Wang (1):
      drm/i915/gvt: Fix mmap range check

wenxu (2):
      netfilter: nft_flow_offload: Fix reverse route lookup
      netfilter: nft_flow_offload: fix interaction with vrf slave device

yupeng (1):
      net: add document for several snmp counters
