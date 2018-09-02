Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B125DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 21:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E5D20835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 21:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WRtHkrR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E5D20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeICCCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 22:02:46 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52643 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeICCCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 22:02:46 -0400
Received: by mail-it0-f68.google.com with SMTP id h3-v6so13283345ita.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qJXQu4msvo+jnuYtG4bLp2V44h6Bxtr77LL+cUHoceo=;
        b=WRtHkrR7mzNYjZxC89mhtbdcqPKRESp78knzir3hU/je5opQTLPJN5HAQ1KVGnC/zO
         1zdC20Z7v8KtZLhF/SGKIQO8gBTHZuTz4aBRAwVOvxdgDismvAALU6D2K3+irdUz740h
         tLyCqkV754+E+IwHsYNPpaFiDgtb08VrvJ7zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qJXQu4msvo+jnuYtG4bLp2V44h6Bxtr77LL+cUHoceo=;
        b=Q9R2dWCHTDTiTDX8gs7AoLwWZ/vtxQClPEnti6wmrU6ovQHPLQhXbnGKHcgeGO7il4
         1CdWYBR7SKABGfG4IgCcLG9FwxxnH6osGXkXPfeG5soOcaCAOGfluj+GLd0TI210atQM
         Q+3UaKJThDjjHb7tle61hDZyP4Il6mzpYd/BX5bHEQbXECjTHZjm5KkqO8Gc6nK2p3L/
         1jNIGsf9Xf8JzeALlL1OnaU7oPiiQmDXouGmrtIflWxW1ZBVCEE6fHmLePtyg50XLoi+
         oFedAQQYFe6OzegRAVMcQHEheSODxYaknF7SSOq2EposboXSloOIRmS5B6daM4HQOcCC
         Jg6Q==
X-Gm-Message-State: APzg51Ai6VaiwsXBbQoAaJ8+amvkcWRq7mm9XAooWKIgeJZvFn7D99V5
        gZXTPHhd5NHlQ6mg74aQOfHwzLICL4iD13MCTelrwA==
X-Google-Smtp-Source: ANB0VdYIHukNEbKn3rDQ9VZVu96pfsGmpkrL63XePUrfVkgm4J1POawoO8a88DwDJja2u5uGE3iu64cBIHw0tMlTqC0=
X-Received: by 2002:a24:3046:: with SMTP id q67-v6mr3707057itq.9.1535924733393;
 Sun, 02 Sep 2018 14:45:33 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Sep 2018 14:45:22 -0700
Message-ID: <CA+55aFyG0GbDfoghEhAmKBPcZCiPu6CCpPRz9GwjCzLuP_Vv5Q@mail.gmail.com>
Subject: Linux 4.19-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As usual, the rc2 release is pretty small. People are taking a
breather after the merge window, and it takes a bit of time for bug
reports to start coming in and get identified.  Plus people were
probably still on vacation (particularly Europe), and some people were
at Open Source Summit NA last week too. Having a calm week was good.

Regardless of the reason, it's pretty quiet/ The bulk of it is drivers
(network and gpu stand out), with the rest being a random collection
all over (arch/x86 and generic networking stands out, but there's misc
stuff all over).

Go out and test.

             Linus

---

Adrian Hunter (1):
      mmc: block: Fix unsupported parallel dispatch of requests

Ahmad Fatoum (1):
      net: macb: Fix regression breaking non-MDIO fixed-link PHYs

Akshu Agrawal (1):
      clk: x86: Set default parent to 48Mhz

Andi Kleen (2):
      x86/spectre: Add missing family 6 check to microcode check
      x86/speculation/l1tf: Increase l1tf memory limit for Nehalem+

Andrey Grodzovsky (1):
      drm/amdgpu: Fix page fault and kasan warning on pci device remove.

Andy Lutomirski (1):
      x86/nmi: Fix NMI uaccess race against CR3 switching

Anirudh Venkataramanan (5):
      ice: Fix multiple static analyser warnings
      ice: Cleanup magic number
      ice: Fix bugs in control queue processing
      ice: Fix a few null pointer dereference issues
      ice: Trivial formatting fixes

Anson Huang (1):
      thermal: of-thermal: disable passive polling when thermal zone is dis=
abled

Anssi Hannula (1):
      net: macb: do not disable MDIO bus at open/close time

Ard Biesheuvel (3):
      crypto: arm64/sm4-ce - check for the right CPU feature bit
      crypto: arm64/aes-gcm-ce - fix scatterwalk API violation
      powerpc: disable support for relative ksymtab references

Arnd Bergmann (1):
      net_sched: fix unused variable warning in stmmac

Ben Hutchings (1):
      x86: Allow generating user-space headers without a compiler

Bo Chen (2):
      e1000: check on netif_running() before calling e1000_up()
      e1000: ensure to free old tx/rx rings in set_ringparam()

Brett Creeley (1):
      ice: Set VLAN flags correctly

Bruce Allan (3):
      ice: Remove unnecessary node owner check
      ice: Update to interrupts enabled in OICR
      ice: Change struct members from bool to u8

Chaitanya Kulkarni (1):
      nvmet: free workqueue object if module init fails

Chengguang Xu (1):
      block: remove unnecessary condition check

Chris Wilson (2):
      drm/i915: Stop holding a ref to the ppgtt from each vma
      drm/i915/audio: Hook up component bindings even if displays are disab=
led

Christian K=C3=B6nig (3):
      drm/amdgpu: fix VM clearing for the root PD
      drm/amdgpu: fix preamble handling
      drm/amdgpu: fix holding mn_lock while allocating memory

Colin Ian King (2):
      qed: fix spelling mistake "comparsion" -> "comparison"
      x86/xen: remove redundant variable save_pud

Cong Wang (10):
      net_sched: improve and refactor tcf_action_put_many()
      net_sched: remove unnecessary ops->delete()
      net_sched: remove unused parameter for tcf_action_delete()
      net_sched: remove unused tcf_idr_check()
      net_sched: remove list_head from tc_action
      net_sched: remove unused tcfa_capab
      Revert "net: sched: act_ife: disable bh when taking ife_mod_lock"
      act_ife: move tcfa_lock down to where necessary
      act_ife: fix a potential deadlock
      addrconf: reduce unnecessary atomic allocations

Dan Carpenter (3):
      PM / clk: signedness bug in of_pm_clk_add_clks()
      hwmon: (adt7475) Potential error pointer dereferences
      hwmon: (adt7475) Make adt7475_read_word() return errors

Daniel Borkmann (3):
      bpf, sockmap: fix sock_hash_alloc and reject zero-sized keys
      bpf, sockmap: fix sock hash count in alloc_sock_hash_elem
      bpf: use per htab salt for bucket hash

Dave Watson (1):
      crypto: aesni - Use unaligned loads from gcm_context_data

David Ahern (1):
      net/ipv6: Put lwtstate when destroying fib6_info

Emily Deng (2):
      amdgpu: fix multi-process hang issue
      drm/amdgpu: Need to set moved to true when evict bo

Eric Dumazet (1):
      ipv4: tcp: send zero IPID for RST and ACK sent in SYN-RECV and
TIME-WAIT state

Eric Sandeen (1):
      isofs: reject hardware sector size > 2048 bytes

Fabio Estevam (9):
      thermal: qoriq: Use devm_thermal_zone_of_sensor_register()
      thermal: qoriq: Simplify the 'site' variable assignment
      thermal: qoriq: Switch to SPDX identifier
      ARM: dts: imx28-evk: Move regulators outside simple-bus
      ARM: dts: imx28-evk: Convert to the new display bindings
      ARM: dts: imx23-evk: Move regulators outside simple-bus
      ARM: dts: imx23-evk: Convert to the new display bindings
      ARM: mxs_defconfig: Select CONFIG_DRM_PANEL_SEIKO_43WVF1G
      ARM: imx_v6_v7_defconfig: Select CONFIG_DRM_PANEL_SEIKO_43WVF1G

Fabrizio Castro (1):
      dt-bindings: watchdog: renesas-wdt: Document r8a774a1 support

Felix Kuehling (1):
      drm/amdgpu: Adjust the VM size based on system memory size v2

Finn Thain (1):
      m68k/mac: Use correct PMU response format

Fredrik Sch=C3=B6n (1):
      drm/i915: Increase LSPCON timeout

Ganesh Goudar (1):
      crypto: chtls - fix null dereference chtls_free_uld()

Geert Uytterhoeven (2):
      Revert "net: stmmac: fix build failure due to missing COMMON_CLK
dependency"
      mtd: rawnand: docg4: Remove wrong __init annotations

Gustavo A. R. Silva (3):
      Bluetooth: mediatek: Fix memory leak
      hwmon: (nct6775) Fix potential Spectre v1
      clk: npcm7xx: fix memory allocation

Haishuang Yan (1):
      ip6_vti: fix a null pointer deference when destroy vti6 tunnel

Hangbin Liu (1):
      net/ipv6: init ip6 anycast rt->dst.input as ip6_input

Hans de Goede (2):
      Bluetooth: Make BT_HCIUART_RTL configuration option depend on ACPI
      i2c: designware: Re-init controllers with pm_disabled set on resume

Horia Geant=C4=83 (3):
      crypto: caam/jr - fix descriptor DMA unmapping
      crypto: caam/qi - fix error path in xts setkey
      crypto: caam - fix DMA mapping direction for RSA forms 2 & 3

Huazhong Tan (6):
      net: hns: fix length and page_offset overflow when CONFIG_ARM64_64K_P=
AGES
      net: hns: modify variable type in hns_nic_reuse_page
      net: hns: fix skb->truesize underestimation
      net: hns: use eth_get_headlen interface instead of hns_nic_get_headle=
n
      net: hns3: fix page_offset overflow when CONFIG_ARM64_64K_PAGES
      net: hns3: modify variable type in hns3_nic_reuse_page

Ido Schimmel (1):
      mlxsw: spectrum_switchdev: Do not leak RIFs when removing bridge

Jacob Keller (3):
      ice: Report stats for allocated queues via ethtool stats
      ice: Use order_base_2 to calculate higher power of 2
      i40e: fix condition of WARN_ONCE for stat strings

James Morse (1):
      arm64: mm: always enable CONFIG_HOLES_IN_ZONE

James Smart (1):
      nvme-fcloop: Fix dropped LS's to removed target port

Jan Kara (3):
      fsnotify: fix false positive warning on inode delete
      udf: Remove dead code from udf_find_fileset()
      udf: Fix mounting of Win7 created UDF filesystems

Jan Kundr=C3=A1t (1):
      i2c: algos: bit: make the error messages grepable

Jann Horn (2):
      x86/entry/64: Wipe KASAN stack shadow before rewind_stack_do_exit()
      x86/dumpstack: Don't dump kernel memory based on usermode RIP

Jason Wang (1):
      vhost: correctly check the iova range when waking virtqueue

Jens Axboe (4):
      Fix up libata MAINTAINERS entry
      blk-wbt: abstract out end IO completion handler
      blk-wbt: improve waking of tasks
      blk-wbt: remove dead code

Jeremy Cline (2):
      fs/quota: Replace XQM_MAXQUOTAS usage with MAXQUOTAS
      fs/quota: Fix spectre gadget in do_quotactl

Jesse Brandeburg (1):
      ice: Fix potential return of uninitialized value

Jesus Sanchez-Palencia (1):
      igb: Use an advanced ctx descriptor for launchtime

Jia-Ju Bai (3):
      igb: Replace GFP_ATOMIC with GFP_KERNEL in igb_sw_init()
      igb: Replace mdelay() with msleep() in igb_integrated_phy_loopback()
      ixgbe: Replace GFP_ATOMIC with GFP_KERNEL

Jiri Kosina (1):
      x86/alternatives: Lockdep-enforce text_mutex in text_poke*()

Joe Jin (1):
      xen: export device state to sysfs

Joerg Roedel (1):
      x86/efi: Load fixmap GDT in efi_call_phys_epilog()

Johan Hovold (1):
      of: add helper to lookup compatible child node

John Fastabend (2):
      tls: possible hang when do_tcp_sendpages hits sndbuf is full case
      bpf: sockmap: write_space events need to be passed to TCP handler

John Pittman (1):
      block: bsg: move atomic_t ref_count variable to refcount API

Juergen Gross (7):
      x86/xen: don't write ptes directly in 32-bit PV guests
      xen/blkback: don't keep persistent grants too long
      xen/blkfront: cleanup stale persistent grants
      xen/blkfront: reorder tests in xlblk_init()
      xen/blkback: move persistent grants flags to bool
      xen/blkback: remove unused pers_gnts_lock from struct xen_blkif_ring
      x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear

Julien Grall (1):
      Documentation/arm64/sve: Couple of improvements and typos

Kai-Heng Feng (1):
      r8152: disable RX aggregation on new Dell TB16 dock

Keerthy (1):
      arm: dts: am4372: setup rtc as system-power-controller

Kees Cook (1):
      net: sched: Fix memory exposure from short TCA_U32_SEL

Kevin Yang (3):
      tcp_bbr: add bbr_check_probe_rtt_done() helper
      tcp_bbr: in restart from idle, see if we should exit PROBE_RTT
      tcp_bbr: apply PROBE_RTT cwnd cap even if acked=3D=3D0

Kuninori Morimoto (2):
      thermal: rcar_thermal: convert to SPDX identifiers
      thermal: rcar_gen3_thermal: convert to SPDX identifiers

Leonard Crestez (1):
      Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"

Linus Torvalds (1):
      Linux 4.19-rc2

Linus Walleij (2):
      ata: ftide010: Add a quirk for SQ201
      ARM: defconfig: Update the ARM Versatile defconfig

Lothar Felten (1):
      hwmon: (ina2xx) fix sysfs shunt resistor read access

Ludovic Desroches (2):
      mmc: atmel-mci: fix bad logic of sg_copy_{from,to}_buffer conversion
      mmc: android-goldfish: fix bad logic of sg_copy_{from,to}_buffer
conversion

Manish Chopra (1):
      qlge: Fix netdev features configuration.

Marc Zyngier (2):
      arm/arm64: smccc-1.1: Make return values unsigned long
      arm/arm64: smccc-1.1: Handle function result as parameters

Martyna Szapar (1):
      i40e: Fix for Tx timeouts when interface is brought up if DCB is enab=
led

Masahiro Yamada (3):
      mtd: rawnand: denali: do not pass zero maxchips to nand_scan()
      x86/build: Remove jump label quirk for GCC older than 4.5.2
      objtool: Remove workaround for unreachable warnings from old GCC

Michal Wnukowski (1):
      nvme-pci: add a memory barrier to nvme_dbbuf_update_and_check_event

Mika Westerberg (1):
      i2c: i801: Allow ACPI AML access I/O ports not reserved for SMBus

Mukesh Ojha (2):
      notifier: Remove notifier header file wherever not used
      cpu/hotplug: Remove skip_onerr field from cpuhp_step structure

Neeraj Dantu (1):
      ARM: dts: Fix file permission for am335x-osd3358-sm-red.dts

Nick Desaulniers (1):
      x86/irqflags: Mark native_restore_fl extern inline

Nikolas Nyby (1):
      x86/Kconfig: Fix trivial typo

Nishanth Menon (1):
      arm64: defconfig: Enable TI's AM6 SoC platform

Ondrej Mosnacek (1):
      crypto: vmx - Fix sleep-in-atomic bugs

Palmer Dabbelt (2):
      dt-bindings: riscv,cpu-intc: Cleanups from a missed review
      RISC-V: Use a less ugly workaround for unused variable warnings

Pavel Machek (1):
      ARM: dts: omap4-droid4: fix vibrations on Droid 4

Prashant Bhole (1):
      xsk: fix return value of xdp_umem_assign_dev()

Preethi Banala (1):
      ice: Clean control queues only when they are initialized

Quentin Monnet (1):
      tools: bpftool: return from do_event_pipe() on bad arguments

Rafael J. Wysocki (1):
      cpuidle: menu: Retain tick when shallow state is selected

Randy Dunlap (1):
      x86/pti: Fix section mismatch warning/error

Rex Zhu (6):
      drm/amd/display: Fix bug use wrong pp interface
      drm/amdgpu: Enable/disable gfx PG feature in rlc safe mode
      drm/amdgpu: Fix vce initialize failed on Kaveri/Mullins
      drm/amdgpu: Update power state at the end of smu hw_init.
      drm/amdgpu: Power on uvd block when hw_fini
      drm/amdgpu: Remove duplicated power source update

Rob Herring (2):
      of: add node name compare helper functions
      of: Add device_type access helper functions

Rodrigo Vivi (1):
      drm/i915: Free write_buf that we allocated with kzalloc.

Samuel Mendoza-Jonas (1):
      net/ncsi: Fixup .dumpit message flags and ID check in Netlink handler

Samuel Neves (1):
      x86/vdso: Fix lsl operand order

Scott Bauer (1):
      cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status

Sebastian Basierski (1):
      ixgbe: fix driver behaviour after issuing VFLR

Sergei Shtylyov (2):
      mmc: renesas_sdhi_internal_dmac: fix #define RST_RESERVED_BITS
      mmc: renesas_sdhi_internal_dmac: mask DMAC interrupts

SivapiriyanKumarasamy (1):
      drm/amd/display: Fix memory leak caused by missed dc_sink_release

Souptick Joarder (1):
      drm/mediatek: Convert drm_atomic_helper_suspend/resume()

Srikanth Jampala (1):
      crypto: cavium/nitrox - fix for command corruption in queue full
case with backlog submissions.

Stephen Hemminger (1):
      hv_netvsc: ignore devices that are not PCI

Stephen Rothwell (1):
      disable stringop truncation warnings for now

Stu Hsieh (14):
      drm/mediatek: add connection from RDMA0 to DPI1
      drm/mediatek: add connection from RDMA0 to DSI1
      drm/mediatek: add connection from RDMA1 to DSI0
      drm/mediatek: add connection from RDMA2 to DSI0
      drm/mediatek: add memory mode and layer_config for RDMA
      drm/mediatek: add RGB color format support for RDMA
      drm/mediatek: add the comment about color format setting for OVL
      drm/mediatek: add YUYV/UYVY color format support for RDMA
      drm/mediatek: add function to get layer number for component
      drm/mediatek: add function to return OVL layer number
      drm/mediatek: add function to return RDMA layer number
      drm/mediatek: use layer_nr function to get layer number to init plane
      drm/mediatek: update some variable name from ovl to comp
      drm/mediatek: fix connection from RDMA2 to DSI1

Thomas Zimmermann (1):
      drm/mediatek: Replace drm_dev_unref with drm_dev_put

Tobias Klauser (1):
      nios2: kconfig: remove duplicate DEBUG_STACK_USAGE symbol defintions

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      sch_cake: Fix TC filter flow override and expand it to hosts as well

Tomer Tayar (4):
      qed: Wait for ready indication before rereading the shmem
      qed: Wait for MCP halt and resume commands to take place
      qed: Prevent a possible deadlock during driver load and unload
      qed: Avoid sending mailbox commands when MFW is not responsive

Tony Lindgren (5):
      ARM: OMAP2+: Fix null hwmod for ti-sysc debug
      ARM: OMAP2+: Fix module address for modules using mpu_rt_idx
      bus: ti-sysc: Fix module register ioremap for larger offsets
      bus: ti-sysc: Fix no_console_suspend handling
      ARM: dts: omap4-droid4: Fix emmc errors seen on some devices

Tony Luck (1):
      x86/mce: Fix set_mce_nospec() to avoid #GP fault

Tony Nguyen (1):
      ixgbe: Prevent unsupported configurations with XDP

Uros Bizjak (1):
      x86/asm: Use CC_SET()/CC_OUT() in __gen_sigismember()

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix glk/cnl display w/a #1175

Vincent Whitchurch (1):
      watchdog: Mark watchdog touch functions as notrace

Will Deacon (1):
      riscv: tlb: Provide definition of tlb_flush() before including tlb.h

Wolfram Sang (4):
      net: ethernet: renesas: use SPDX identifier for Renesas drivers
      i2c: refactor function to release a DMA safe buffer
      i2c: sh_mobile: define start_ch() void as it only returns 0 anyhow
      i2c: sh_mobile: fix leak when using DMA bounce buffer

Yue Haibing (3):
      rhashtable: remove duplicated include from rhashtable.c
      sch_cake: Remove unused including <linux/version.h>
      rds: tcp: remove duplicated include from tcp.c

YueHaibing (1):
      ixgb: use dma_zalloc_coherent instead of allocator/memset
