Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C289C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F188220881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GyQCwyp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F188220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeG2XlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:41:20 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53622 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeG2XlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:41:20 -0400
Received: by mail-it0-f68.google.com with SMTP id 72-v6so14726398itw.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8HiwXOBz8eLvOtimHSc3V0NFLSgp5MEKjY/fJjFhPxE=;
        b=GyQCwyp2dZsNKGPeBfdEPzUqyyGhTDOffqXE+AGe7clMPIxzf0AZKEi3uDyT87X9sa
         +38wGuG6ocIQsc78QdJvWQAFHnQbUWJ4vtQqLmts43ue8VDkyff4HMjjk/G3vfRVPZ8A
         545KzDqHhwWGcJKsO7NahMwpiSWVqTq1+NJDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8HiwXOBz8eLvOtimHSc3V0NFLSgp5MEKjY/fJjFhPxE=;
        b=nUPuCH2msa3pCCZg51iWuA3KrE6mp7bvaIwhLerFLqr93OxwcjduDkCkfVY1ftYXAp
         wXdQD4qFt0j6WOSXH8o804uufR8doSpXKSoTKXw6vd1ajWVRDLHk5Yne5E8ie8HKA2/x
         ns+3uCM93sZtA//u75KzGUcDHV5AU7TDkavDOnUyJ68ekV5ZPEAPBISlxluF9cpTqgLL
         qzoFlm36mc+BvQgC7lNTaC7nenicf/hRLlk9zZmjXzY9VTlVKPpoizhaUqSO5dOElPUo
         G/XQDgRXoDM+wZAOixq0s7d6U6rF1ToFCvD8hgeT0J+q19HXup7TvoQ1PNY5iuzdv/l+
         vHQg==
X-Gm-Message-State: AOUpUlHQuHjCxY7byf42ZNkY7zK2B6x4Sqi0mSoWel+ttWcn+kXJEwWQ
        VSK9+GT5VuHTSZp8GKmhO/TyC6KJQ4XRqWIvMY66Ww==
X-Google-Smtp-Source: AAOMgpcgvSZR73gAIjWa6e05By4+C8b4Lzc+jqoFtLsJbGCFWuJE9XIW4vH1VIhpeaWnE1hekdx/qskXbq5UghkihgA=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr13968924jas.72.1532902156834;
 Sun, 29 Jul 2018 15:09:16 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Jul 2018 15:09:05 -0700
Message-ID: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
Subject: Linux 4.18-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So unless something odd happens, this should be the last rc for 4.18.

Nothing particularly odd happened this last week - we got the usual
random set of various minor fixes all over. About two thirds of it is
drivers - networking, staging and usb stands out, but there's a little
bit of stuff all over (clk, block, gpu, nvme..).

Outside of drivers, the bulk is some core networking stuff, with
random changes elsewhere (minor arch updates, filesystems, core
kernel, test scripts).

The appended shortlog gives a flavor of the details.

                  Linus

---

Adam Thomson (1):
      usb: typec: tcpm: Fix sink PDO starting index for PPS APDO selection

Aleksander Morgado (1):
      qmi_wwan: fix interface number for DW5821e production firmware

Alexander Sverdlin (1):
      i2c: davinci: Avoid zero value of CLKH

Amar Singhal (1):
      cfg80211: never ignore user regulatory hint

Anssi Hannula (7):
      can: xilinx_can: fix device dropping off bus on RX overrun
      can: xilinx_can: fix RX loop if RXNEMP is asserted without RXOK
      can: xilinx_can: fix recovery from error states not being propagated
      can: xilinx_can: keep only 1-2 frames in TX FIFO to fix TX accounting
      can: xilinx_can: fix RX overflow interrupt not being enabled
      can: xilinx_can: fix incorrect clear of non-processed interrupts
      can: xilinx_can: fix power management handling

Antti Sepp=C3=A4l=C3=A4 (2):
      usb: dwc2: Fix DMA alignment to start at allocated boundary
      usb: dwc2: Fix inefficient copy of unaligned buffers

Ariel Levkovich (1):
      net/mlx5: Adjust clock overflow work period

Arnd Bergmann (2):
      kasan: only select SLUB_DEBUG with SYSFS=3Dy
      include/linux/eventfd.h: include linux/errno.h

Artem Savkov (1):
      tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failu=
re

Benjamin Herrenschmidt (4):
      clk: aspeed: Treat a gate in reset as disabled
      usb: gadget: aspeed-vhub: Fix SETUP packets with OUT data phase
      usb: gadget: Fix OS descriptors support
      usb: gadget: aspeed: Workaround memory ordering issue

Bernd Edlinger (1):
      nl80211: Add a missing break in parse_station_flags

Bin Liu (1):
      usb: core: handle hub C_PORT_OVER_CURRENT condition

Carlos Maiolino (1):
      xfs: Initialize variables in xfs_alloc_get_rec before using them

Chen-Yu Tsai (1):
      Input: i8042 - add Lenovo LaVie Z to the i8042 reset list

Clint Taylor (1):
      drm/i915/glk: Add Quirk for GLK NUC HDMI port issues.

Colin Ian King (1):
      usb: dwc3: gadget: remove redundant variable maxpacket

Dan Williams (1):
      mm: fix exports that inadvertently make put_page() EXPORT_SYMBOL_GPL

Daniel Borkmann (3):
      bpf, ppc64: fix unexpected r0=3D0 exit path inside bpf_xadd
      bpf: test case to check whether src/dst regs got mangled by xadd
      sock: fix sg page frag coalescing in sk_alloc_sg

Dave Jiang (1):
      mm: disallow mappings that conflict for devm_memremap_pages()

David Ahern (1):
      net/ipv6: Fix linklocal to global address with VRF

Davidlohr Bueso (1):
      ipc/sem.c: prevent queue.status tearing in semop

Denis Kenzior (1):
      nl80211/mac80211: allow non-linear skb in rx_control_port

Dirk Mueller (1):
      arm64: Check for errata before evaluating cpu features

Dmitry Torokhov (1):
      usb: dwc2: host: do not delay retries for CONTROL IN transfers

Donald Shanty III (1):
      Input: elan_i2c - add ACPI ID for lenovo ideapad 330

Doron Roberts-Kedes (1):
      tls: check RCV_SHUTDOWN in tls_wait_data

Enric Balletbo i Serra (1):
      usb: dwc3: rockchip: Fix PHY documentation links.

Eran Ben Elisha (2):
      net/mlx5e: Fix quota counting in aRFS expire flow
      net/mlx5e: Don't allow aRFS for encapsulated packets

Eric Dumazet (6):
      net: skb_segment() should not return NULL
      tcp: free batches of packets in tcp_prune_ofo_queue()
      tcp: avoid collapses in tcp_prune_queue() if possible
      tcp: detect malicious patterns in tcp_collapse_ofo_queue()
      tcp: call tcp_drop() from tcp_data_queue_ofo()
      tcp: add tcp_ooo_try_coalesce() helper

Eric Sandeen (1):
      xfs: properly handle free inodes in extent hint validators

Esben Haabendal (1):
      i2c: imx: Fix reinit_completion() use

Eugeniu Rosca (3):
      usb: gadget: f_uac2: fix error handling in afunc_bind (again)
      usb: gadget: u_audio: fix pcm/card naming in g_audio_setup()
      usb: gadget: f_uac2: fix endianness of 'struct cntrl_*_lay3'

Fabio Estevam (1):
      usb: chipidea: Always build ULPI code

Faiz Abbas (2):
      can: m_can: Fix runtime resume call
      can: m_can: Move accessing of message ram to after clocks are enabled

Felix Fietkau (1):
      MIPS: ath79: fix register address in ath79_ddr_wb_flush()

Florian Westphal (7):
      netfilter: nf_tables: use dev->name directly
      netfilter: nf_tables: free flow table struct too
      netfilter: nf_tables: fix memory leaks on chain rename
      netfilter: nf_tables: don't allow to rename to already-pending name
      netfilter: conntrack: dccp: treat SYNC/SYNCACK as invalid if no
prior state
      atl1c: reserve min skb headroom
      netfilter: nf_tables: move dumper state allocation into ->start

Geert Uytterhoeven (2):
      MAINTAINERS: Add file patterns for serio device tree bindings
      clk: Really show symbolic clock flags in debugfs

Greg Edwards (1):
      block: reset bi_iter.bi_done after splitting bio

Gregory CLEMENT (1):
      clk: mvebu: armada-37xx-periph: Fix switching CPU rate from
300Mhz to 1.2GHz

Guenter Roeck (1):
      media: staging: omap4iss: Include asm/cacheflush.h after generic incl=
udes

Hangbin Liu (1):
      multicast: do not restore deleted record source filter mode to new on=
e

Hannes Reinecke (2):
      nvmet: fixup crash on NULL device path
      nvmet: only check for filebacking on -ENOTBLK

Hans de Goede (1):
      Revert "staging:r8188eu: Use lib80211 to support TKIP"

Heiner Kallweit (2):
      net: phy: consider PHY_IGNORE_INTERRUPT in phy_start_aneg_priv
      r8169: restore previous behavior to accept BIOS WoL settings

Jack Morgenstein (1):
      net/mlx4_core: Save the qpn from the input modifier in RST2INIT wrapp=
er

Jaedon Shin (1):
      phy: phy-brcm-usb-init: Fix power down USB 3.0 PHY when XHCI reenable=
d

James Smart (2):
      nvmet-fc: fix target sgl list on large transfers
      nvme: if_ready checks to fail io to deleting controller

Jarod Wilson (1):
      bonding: set default miimon value for non-arp modes if not set

Jerome Brunet (1):
      clk: meson: audio-divider is one based

Jerry Zhang (1):
      usb: gadget: f_fs: Only return delayed status when len is 0

Jia-Ju Bai (2):
      usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context
bugs in init_controller()
      usb: gadget: r8a66597: Fix a possible sleep-in-atomic-context
bugs in r8a66597_queue()

Joel Stanley (2):
      clk: aspeed: Mark bclk (PCIe) and dclk (VGA) as critical
      clk: aspeed: Support HPLL strapping on ast2400

Johannes Weiner (1):
      arm64: fix vmemmap BUILD_BUG_ON() triggering on !vmemmap setups

John Hurley (1):
      nfp: flower: ensure dead neighbour entries are not offloaded

John Keeping (1):
      usb: dwc2: avoid NULL dereferences

Josef Bacik (2):
      nbd: don't requeue the same request twice.
      nbd: handle unexpected replies better

Joshua Frkuska (1):
      usb: gadget: u_audio: update hw_ptr in iso_complete after data copied

KT Liao (1):
      Input: elan_i2c - add another ACPI ID for Lenovo Ideapad 330-15AST

Keith Busch (2):
      blk-mq: export setting request completion state
      scsi: set timed out out mq requests to complete

Kiran Kumar Modukuri (5):
      fscache: Allow cancelled operations to be enqueued
      cachefiles: Fix refcounting bug in backing-file read monitoring
      fscache: Fix reference overput in fscache_attach_object() error handl=
ing
      cachefiles: Fix missing clear of the CACHEFILES_OBJECT_ACTIVE flag
      cachefiles: Wait rather than BUG'ing on "Unexpected object collision"

Kirill A. Shutemov (3):
      mm: introduce vma_init()
      mm: use vma_init() to initialize VMAs on stack and data segments
      mm: fix vma_is_anonymous() false-positives

Li Wang (1):
      zswap: re-check zswap_is_full() after do zswap_shrink()

Linus Torvalds (2):
      squashfs: be more careful about metadata corruption
      Linux 4.18-rc7

Linus Walleij (1):
      gpio: of: Handle fixed regulator flags properly

Lubomir Rintel (1):
      usb: cdc_acm: Add quirk for Castles VEGA3000

Lucas Stach (2):
      drm/imx: imx-ldb: disable LDB on driver bind
      drm/imx: imx-ldb: check if channel is enabled before printing warning

Martin KaFai Lau (2):
      bpf: btf: Clean up BTF_INT_BITS() in uapi btf.h
      bpf: Use option "help" in the llvm-objcopy test

Martin Schwidefsky (1):
      s390: disable gcc plugins

Martin Wilck (3):
      block: bio_iov_iter_get_pages: fix size of last iovec
      blkdev: __blkdev_direct_IO_simple: fix leak in error case
      block: bio_iov_iter_get_pages: pin more pages for multi-segment IOs

Masahiro Yamada (1):
      gpio: uniphier: set legitimate irq trigger type in .to_irq hook

Masami Hiramatsu (2):
      ring_buffer: tracing: Inherit the tracing setting to next ring buffer
      selftests/ftrace: Add snapshot and tracing_on test case

Neil Armstrong (1):
      clk: meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL

Nicholas Mc Guire (1):
      can: mpc5xxx_can: check of_iomap return before use

Paolo Abeni (1):
      ip: hash fragments consistently

Paul Burton (1):
      MIPS: Fix off-by-one in pci_resource_to_user()

Peter Senna Tschudin (1):
      tools: usb: ffs-test: Fix build on big endian systems

Raed Salem (1):
      net/mlx5: Fix 'DON'T_TRAP' functionality

Rafael J. Wysocki (1):
      driver core: Partially revert "driver core: correct device's
shutdown order"

Rafa=C5=82 Mi=C5=82ecki (1):
      Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum"

Randy Dunlap (2):
      usb/phy: fix PPC64 build errors in phy-fsl-usb.c
      net: prevent ISA drivers from building on PPC32

Roi Dayan (1):
      net/mlx5e: Only allow offloading decap egress (egdev) flows

Roman Fietze (1):
      can: m_can.c: fix setup of CCCR register: clear CCCR NISO bit
before checking can.ctrlmode

Roopa Prabhu (4):
      rtnetlink: add rtnl_link_state check in rtnl_configure_link
      vxlan: add new fdb alloc and create helpers
      vxlan: make netlink notify in vxlan_fdb_destroy optional
      vxlan: fix default fdb entry netlink notify ordering during netdev cr=
eate

Saeed Mahameed (1):
      net/mlx5: E-Switch, UBSAN fix undefined behavior in mlx5_eswitch_mode

Samuel Thibault (1):
      staging: speakup: fix wraparound in uaccess length check

Schmauss, Erik (1):
      ACPICA: AML Parser: ignore dispatcher error status during table load

Sergio Paracuellos (1):
      staging: ks7010: call 'hostif_mib_set_request_int' instead of
'hostif_mib_set_request_bool'

Shakeel Butt (1):
      kvm, mm: account shadow page tables to kmemcg

Shay Agroskin (1):
      net/mlx5e: Refine ets validation function

Shubhrajyoti Datta (1):
      net: axienet: Fix double deregister of mdio

Snild Dolkow (1):
      kthread, tracing: Don't expose half-written comm when creating kthrea=
ds

Stephane Grosjean (1):
      can: peak_canfd: fix firmware < v3.3.0: limit allocation to
32-bit DMA addr only

Steve Longerbeam (1):
      gpu: ipu-csi: Check for field type alternate

Steven Rostedt (VMware) (3):
      tracing: Fix double free of event_trigger_data
      tracing: Fix possible double free in event_enable_trigger_func()
      tracing: Quiet gcc warning about maybe unused link variable

Sudarsana Reddy Kalluru (4):
      qed: Fix link flap issue due to mismatching EEE capabilities.
      qed: Fix possible race for the link state value.
      qed: Correct Multicast API to reflect existence of 256
approximate buckets.
      bnx2x: Fix invalid memory access in rss hash config path.

Taehee Yoo (3):
      netfilter: nf_tables: fix jumpstack depth validation
      netfilter: nft_set_hash: add rcu_barrier() in the nft_rhash_destroy()
      netfilter: nft_set_rbtree: fix panic when destroying set by GC

Taeung Song (1):
      tools/bpftool: Fix segfault case regarding 'pin' arguments

Tariq Toukan (2):
      net/mlx5: Fix QP fragmented buffer allocation
      net/page_pool: Fix inconsistent lock state warning

Tejun Heo (1):
      delayacct: fix crash in delayacct_blkio_end() after delayacct init fa=
ilure

Theodore Ts'o (6):
      ext4: fix false negatives *and* false positives in
ext4_check_descriptors()
      ext4: clear mmp sequence number when remounting read-only
      ext4: fix inline data updates with checksums enabled
      ext4: check for allocation block validity with block group locked
      random: mix rdrand with entropy sent in from userspace
      ext4: fix check to prevent initializing reserved inodes

Thomas Tai (1):
      PCI/AER: Work around use-after-free in pcie_do_fatal_recovery()

Tony Lindgren (1):
      phy: mapphone-mdm6600: Fix wrong enum used for status lines

Uwe Kleine-K=C3=B6nig (1):
      net: dsa: mv88e6xxx: fix races between lock and irq freeing

Vinod Koul (1):
      clk: qcom: gcc-msm8996: Disable halt check on UFS tx clock

Vivek Gautam (1):
      clk/mmcc-msm8996: Make mmagic_bimc_gdsc ALWAYS_ON

Vladimir Zapolskiy (3):
      usb: gadget: u_audio: remove caching of stream buffer parameters
      usb: gadget: u_audio: remove cached period bytes value
      usb: gadget: u_audio: protect stream runtime fields with stream spinl=
ock

Wei Wang (1):
      ipv6: use fib6_info_hold_safe() when necessary

Willem de Bruijn (1):
      ip: in cmsg IP(V6)_ORIGDSTADDR call pskb_may_pull

Wolfram Sang (2):
      i2c: rcar: handle RXDMA HW behaviour on Gen3
      i2c: imx: use open drain for recovery GPIO

Yuchung Cheng (3):
      tcp: helpers to send special DCTCP ack
      tcp: do not cancel delay-AcK on DCTCP special ACK
      tcp: do not delay ACK in DCTCP upon CE status change

YueHaibing (3):
      net: caif: Add a missing rcu_read_unlock() in caif_flow_cb
      bpfilter: Fix mismatch in function argument types
      cpufreq: qcom-kryo: add NULL entry to the end of_device_id array

Zhao Chen (1):
      net-next/hinic: fix a problem in hinic_xmit_frame()

Zheng Xiaowei (1):
      usb: xhci: Fix memory leak in xhci_endpoint_reset()

mpubbise@codeaurora.org (1):
      mac80211: add stations tied to AP_VLANs during hw reconfig
