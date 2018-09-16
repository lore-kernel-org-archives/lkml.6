Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52A4ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2218B2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VkfLziSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2218B2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeIQAqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 20:46:53 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:51159 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbeIQAqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 20:46:53 -0400
Received: by mail-it0-f50.google.com with SMTP id j81-v6so8564615ite.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 12:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=R03eYWH6DGcSl6YgfS2ny+lDHp9RlR/cUFxmXpBPy58=;
        b=VkfLziSz0YoOYHE4V8rd0GO1ORtAF8QQ6sn9ZGeehE6XfMs2zdGBRhykducNlRcrVh
         iQvJs4CbH8dT0cmG1BVE/0EJmY70VBFNE6mB9SWqgDDHjiXK+l8w0FlXG77AwW1JOsYF
         qFqoGdLDRcrKQBac/8kZCC4KY6Wbpz3cKOrfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=R03eYWH6DGcSl6YgfS2ny+lDHp9RlR/cUFxmXpBPy58=;
        b=Zwic/3PyLB6esgF8AkmII9bDF8sLPX/V2phFb+bFTlBe7hYNq8AF9MTxOc8J9F/KLQ
         G8mF1M1R162d9kkwKuZCDGaHZK6p7TgkCfygrXM2X3/ru96mra+YhBVlshTvTYN0cefR
         dkLL9kQDzanLChyySy+iud1d95L3WY3H69EYcTFxC1Ad0NXdJSaqNQOcKBa6NnNMlIcW
         147+DxKdMIfmKWHQW3aFYBFMM9yRJIzLuM1hHukH6uka/RlydailKwtEdbn8ynhTAhiU
         gGYxcin5oPopSk86c0IOGqSHMVEd1JsTGSDMNCjOM0EFSEugxNtcUrPyEGQLqNqOnT+R
         BY9Q==
X-Gm-Message-State: APzg51DIm4D+iY/1jrQaoyC1qg7OKGfTcMGWwDplvDCpICNhUMyj9y3u
        0FZWbu3v2mrDl4DCuV1MkTQKFNq0jHWL9EiqcrVp+bj2
X-Google-Smtp-Source: ANB0VdY33ywUQhej1oIJx02d+5PNxdxtmEso4M0OX7QZ6rQcuWGRM9sNZQqSwmCKGvluV5ILOVxCGarx94JaC/9yFww=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr10030169ite.123.1537125774452;
 Sun, 16 Sep 2018 12:22:54 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Sep 2018 12:22:43 -0700
Message-ID: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
Subject: Linux 4.19-rc4 released, an apology, and a maintainership note
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ So this email got a lot longer than I initially thought it would
get,  but let's start out with the "regular Sunday release" part ]

Another week, another rc.

Nothing particularly odd stands out on the technical side in the
kernel updates for last week - rc4 looks fairly average in size for
this stage in the release cycle, and all the other statistics look
pretty normal too.

We've got roughly two thirds driver fixes (gpu and networking look to
be the bulk of it, but there's smaller changes all over in various
driver subsystems), with the rest being the usual mix: core
networking, perf tooling updates, arch updates, Documentation, some
filesystem, vm and minor core kernel fixes.

So it's all fairly small and normal for this stage.  As usual, I'm
appending the shortlog at the bottom for people who want to get an
overview of the details without actually having to go dig in the git
tree.

The one change that stands out and merits mention is the code of
conduct addition...

[ And here comes the other, much longer, part... ]

Which brings me to the *NOT* normal part of the last week: the
discussions (both in public mainly on the kernel summit discussion
lists and then a lot in various private communications) about
maintainership and the kernel community.  Some of that discussion came
about because of me screwing up my scheduling for the maintainer
summit where these things are supposed to be discussed.

And don't get me wrong.  It's not like that discussion itself is in
any way new to this week - we've been discussing maintainership and
community for years. We've had lots of discussions both in private and
on mailing lists.  We have regular talks at conferences - again, both
the "public speaking" kind and the "private hallway track" kind.

No, what was new last week is really my reaction to it, and me being
perhaps introspective (you be the judge).

There were two parts to that.

One was simply my own reaction to having screwed up my scheduling of
the maintainership summit: yes, I was somewhat embarrassed about
having screwed up my calendar, but honestly, I was mostly hopeful that
I wouldn't have to go to the kernel summit that I have gone to every
year for just about the last two decades.

Yes, we got it rescheduled, and no, my "maybe you can just do it
without me there" got overruled.  But that whole situation then
started a whole different kind of discussion.  And kind of
incidentally to that one, the second part was that I realized that I
had completely mis-read some of the people involved.

This is where the "look yourself in the mirror" moment comes in.

So here we are, me finally on the one hand realizing that it wasn't
actually funny or a good sign that I was hoping to just skip the
yearly kernel summit entirely, and on the other hand realizing that I
really had been ignoring some fairly deep-seated feelings in the
community.

It's one thing when you can ignore these issues.  Usually it=E2=80=99s just
something I didn't want to deal with.

This is my reality.  I am not an emotionally empathetic kind of person
and that probably doesn't come as a big surprise to anybody.  Least of
all me.  The fact that I then misread people and don't realize (for
years) how badly I've judged a situation and contributed to an
unprofessional environment is not good.

This week people in our community confronted me about my lifetime of
not understanding emotions.  My flippant attacks in emails have been
both unprofessional and uncalled for.  Especially at times when I made
it personal.  In my quest for a better patch, this made sense to me.
I know now this was not OK and I am truly sorry.

The above is basically a long-winded way to get to the somewhat
painful personal admission that hey, I need to change some of my
behavior, and I want to apologize to the people that my personal
behavior hurt and possibly drove away from kernel development
entirely.

I am going to take time off and get some assistance on how to
understand people=E2=80=99s emotions and respond appropriately.

Put another way: When asked at conferences, I occasionally talk about
how the pain-points in kernel development have generally not been
about the _technical_ issues, but about the inflection points where
development flow and behavior changed.

These pain points have been about managing the flow of patches, and
often been associated with big tooling changes - moving from making
releases with "patches and tar-balls" (and the _very_ painful
discussions about how "Linus doesn't scale" back 15+ years ago) to
using BitKeeper, and then to having to write git in order to get past
the point of that no longer working for us.

We haven't had that kind of pain-point in about a decade.  But this
week felt like that kind of pain point to me.

To tie this all back to the actual 4.19-rc4 release (no, really, this
_is_ related!) I actually think that 4.19 is looking fairly good,
things have gotten to the "calm" period of the release cycle, and I've
talked to Greg to ask him if he'd mind finishing up 4.19 for me, so
that I can take a break, and try to at least fix my own behavior.

This is not some kind of "I'm burnt out, I need to just go away"
break.  I'm not feeling like I don't want to continue maintaining
Linux. Quite the reverse.  I very much *do* want to continue to do
this project that I've been working on for almost three decades.

This is more like the time I got out of kernel development for a while
because I needed to write a little tool called "git".  I need to take
a break to get help on how to behave differently and fix some issues
in my tooling and workflow.

And yes, some of it might be "just" tooling.  Maybe I can get an email
filter in place so at when I send email with curse-words, they just
won't go out.  Because hey, I'm a big believer in tools, and at least
_some_ problems going forward might be improved with simple
automation.

I know when I really look =E2=80=9Cmyself in the mirror=E2=80=9D it will be=
 clear it's
not the only change that has to happen, but hey...  You can send me
suggestions in email.

I look forward to seeing you at the Maintainer Summit.

                Linus

---

Aaron Knister (1):
      IB/ipoib: Avoid a race condition between start_xmit and cm_rep_handle=
r

AceLan Kao (1):
      HID: i2c-hid: Fix flooded incomplete report after S3 on Rayd touchscr=
een

Adrian Hunter (1):
      perf tools: Fix maps__find_symbol_by_name()

Ahmed S. Darwish (1):
      staging: gasket: TODO: re-implement using UIO

Alan Stern (1):
      USB: net2280: Fix erroneous synchronization change

Alexander Usyskin (1):
      mei: ignore not found client in the enumeration

Amir Goldstein (6):
      ovl: respect FIEMAP_FLAG_SYNC flag
      ovl: fix GPF in swapfile_activate of file from overlayfs over xfs
      Documentation/filesystems: update documentation of file_operations
      vfs: add the fadvise() file operation
      vfs: implement readahead(2) using POSIX_FADV_WILLNEED
      ovl: add ovl_fadvise()

Andreas Bosch (1):
      HID: intel-ish-hid: Enable Sunrise Point-H ish driver

Andreas Kemnade (1):
      mmc: omap_hsmmc: fix wakeirq handling on removal

Andrew Murray (1):
      asm-generic: io: Fix ioport_map() for !CONFIG_GENERIC_IOMAP &&
CONFIG_INDIRECT_PIO

Anton Vasilyev (1):
      usb: gadget: fotg210-udc: Fix memory leak of fotg210->ep[i]

Anurag Kumar Vulisha (1):
      usb: host: xhci-plat: Iterate over parent nodes for finding quirks

Arnaldo Carvalho de Melo (7):
      perf tools: Streamline bpf examples and headers installation
      tools headers uapi: Update tools's copy of linux/perf_event.h
      tools headers uapi: Update tools's copy of asm-generic/unistd.h
      tools headers uapi: Update tools's copy of drm/drm.h
      tools headers uapi: Update tools's copies of kvm headers
      tools headers uapi: Update tools's copy of linux/vhost.h
      tools headers uapi: Update tools's copy of linux/if_link.h

Arnd Bergmann (2):
      staging: wilc1000: revert "fix TODO to compile spi and sdio
components in single module"
      usb: dwc3: of-simple: avoid unused function warnings

Artemy Kovalyov (1):
      IB/core: Release object lock if destroy failed

Ben Hutchings (3):
      USB: yurex: Fix buffer over-read in yurex_write()
      USB: yurex: Check for truncation in yurex_read()
      locking/lockdep: Delete unnecessary #include

Ben Skeggs (8):
      drm/nouveau: fix oops in client init failure path
      drm/nouveau/mmu: don't attempt to dereference vmm without valid
instance pointer
      drm/nouveau/TBDdevinit: don't fail when PMU/PRE_OS is missing from VB=
IOS
      drm/nouveau/disp: remove unused struct member
      drm/nouveau/disp: move eDP panel power handling
      drm/nouveau/disp: fix DP disable race
      drm/nouveau/disp/gm200-: enforce identity-mapped SOR assignment
for LVDS/eDP panels
      drm/nouveau/devinit: fix warning when PMU/PRE_OS is missing

Benjamin Fair (1):
      ipmi: kcs_bmc: don't change device name

Benjamin Tissoires (2):
      HID: multitouch: fix Elan panels with 2 input modes declaration
      HID: core: fix grouping by application

Bin Yang (1):
      pstore: Fix incorrect persistent ram buffer mapping

Boris Ostrovsky (1):
      x86/EISA: Don't probe EISA bus for Xen PV guests

Borislav Petkov (1):
      jump_label: Fix typo in warning message

Bruno Meirelles Herrera (1):
      usb: dwc2: Fix call location of dwc2_check_core_endianness

Bryant G. Ly (1):
      misc: ibmvsm: Fix wrong assignment of return code

Chris Phlipot (2):
      perf util: Fix bad memory access in trace info.
      perf event-parse: Use fixed size string for comms

Chris Wilson (1):
      drm/i915/overlay: Allocate physical registers from stolen

Christian K=C3=B6nig (2):
      drm/amdgpu: fix amdgpu_mn_unlock() in the CS error path
      drm/amdgpu: fix error handling in amdgpu_cs_user_fence_chunk

Chunfeng Yun (2):
      usb: mtu3: fix error of xhci port id when enable U3 dual role
      usb: xhci: fix interrupt transfer error happened on MTK platforms

Colin Ian King (1):
      locking/ww_mutex: Fix spelling mistake "cylic" -> "cyclic"

Cong Wang (6):
      tipc: orphan sock in tipc_release()
      tipc: call start and done ops directly in __tipc_nl_compat_dumpit()
      net_sched: properly cancel netlink dump on failure
      netfilter: xt_hashlimit: use s->file instead of s->private
      rds: fix two RCU related problems
      tipc: check return value of __tipc_dump_start()

Corey Minyard (3):
      ipmi: Rework SMI registration failure
      ipmi: Move BT capabilities detection to the detect call
      ipmi: Fix I2C client removal in the SSIF driver

Dan Carpenter (4):
      cifs: prevent integer overflow in nxt_dir_entry()
      CIFS: fix wrapping bugs in num_entries()
      cifs: integer overflow in in SMB2_ioctl()
      cifs: read overflow in is_valid_oplock_break()

Daniel Jurgens (1):
      net/mlx5: Consider PCI domain in search for next dev

Daniel Vetter (1):
      staging/fbtft: Update TODO and mailing lists

Davide Caratti (1):
      net/sched: fix memory leak in act_tunnel_key_init()

Dennis Dalessandro (2):
      PCI: Fix faulty logic in pci_reset_bus()
      IB/hfi1,PCI: Allow bus reset while probing

Emily Deng (1):
      drm/amdgpu: move PSP init prior to IH in gpu reset

Felix Kuehling (1):
      PCI: Fix enabling of PASID on RC integrated endpoints

Florian Westphal (5):
      netfilter: xt_checksum: ignore gso skbs
      netfilter: conntrack: place 'new' timeout in first location too
      netfilter: nf_tables: rework ct timeout set support
      netfilter: kconfig: nat related expression depend on nftables core
      netfilter: conntrack: reset tcp maxwin on re-register

Gao Xiang (2):
      Revert "staging: erofs: disable compiling temporarile"
      staging: erofs: rename superblock flags (MS_xyz -> SB_xyz)

Greg Kroah-Hartman (1):
      Code of Conduct: Let's revamp it.

Guenter Roeck (2):
      riscv: Do not overwrite initrd_start and initrd_end
      x86/efi: Load fixmap GDT in efi_call_phys_epilog() before setting %cr=
3

Gustavo A. R. Silva (4):
      ipmi: Fix NULL pointer dereference in ssif_probe
      HID: core: fix NULL pointer dereference
      switchtec: Fix Spectre v1 vulnerability
      misc: hmc6352: fix potential Spectre v1

Haishuang Yan (2):
      erspan: return PACKET_REJECT when the appropriate tunnel is not found
      erspan: fix error handling for erspan tunnel

Hans de Goede (3):
      HID: sensor-hub: Restore fixup for Lenovo ThinkPad Helix 2
sensor hub report
      staging: vboxvideo: Fix IRQs no longer working
      staging: vboxvideo: Change address of scanout buffer on page-flip

Harry Mallon (1):
      HID: hid-saitek: Add device ID for RAT 7 Contagion

Hauke Mehrtens (1):
      MIPS: lantiq: dma: add dev pointer

Heinz Mauelshagen (5):
      dm raid: fix reshape race on small devices
      dm raid: fix stripe adding reshape deadlock
      dm raid: fix rebuild of specific devices by updating superblock
      dm raid: fix RAID leg rebuild errors
      dm raid: bump target version, update comments and documentation

Hisao Tanabe (1):
      perf evsel: Fix potential null pointer dereference in
perf_evsel__new_idx()

Huang Shijie (1):
      dmaengine: mic_x100_dma: use devm_kzalloc to fix an issue

Huy Nguyen (1):
      net/mlx5: Check for error in mlx5_attach_interface

Imre Deak (1):
      drm/i915/bdw: Increase IPS disable timeout to 100ms

Ingo Franzki (1):
      s390/crypto: Fix return code checking in cbc_paes_crypt()

Jacek Tomaka (1):
      perf/x86/intel: Add support/quirk for the MISPREDICT bit on
Knights Landing CPUs

Jack Morgenstein (2):
      net/mlx5: Fix use-after-free in self-healing flow
      net/mlx5: Fix debugfs cleanup in the device init/remove flow

James Morse (1):
      arm64: kernel: arch_crash_save_vmcoreinfo() should depend on
CONFIG_CRASH_CORE

Jann Horn (1):
      RDMA/ucma: check fd type in ucma_migrate_id()

Jens Axboe (2):
      blk-cgroup: increase number of supported policies
      null_blk: fix zoned support for non-rq based operation

Jia-Ju Bai (3):
      usb: host: u132-hcd: Fix a sleep-in-atomic-context bug in u132_get_fr=
ame()
      usb: misc: uss720: Fix two sleep-in-atomic-context bugs
      usb: cdc-wdm: Fix a sleep-in-atomic-context bug in
service_outstanding_interrupt()

Jiada Wang (1):
      sched/debug: Fix potential deadlock when writing to sched_features

Jiri Olsa (5):
      perf tests: Add breakpoint modify tests
      perf/hw_breakpoint: Modify breakpoint even if the new attr has
disabled set
      perf/hw_breakpoint: Remove superfluous bp->attr.disabled =3D 0
      perf/hw_breakpoint: Enable breakpoint in modify_user_hw_breakpoint
      perf/hw_breakpoint: Simplify breakpoint enable in
perf_event_modify_breakpoint

Joao Pinto (1):
      MAINTAINERS: Add Gustavo Pimentel as DesignWare PCI maintainer

Joe Thornber (1):
      dm thin metadata: try to avoid ever aborting transactions

Joerg Roedel (1):
      Revert "x86/mm/legacy: Populate the user page-table with user pgd's"

Johan Hovold (3):
      USB: serial: io_ti: fix array underflow in completion handler
      USB: serial: ti_usb_3410_5052: fix array underflow in completion hand=
ler
      mmc: meson-mx-sdio: fix OF child-node lookup

John Hubbard (1):
      mei: fix use-after-free in mei_cl_write

Josh Abraham (1):
      xen: fix GCC warning and remove duplicate EVTCHN_ROW/EVTCHN_COL usage

Juergen Gross (2):
      xen/netfront: fix waiting for xenbus state change
      x86/xen: Disable CPU0 hotplug for Xen PV

Julian Wiedmann (6):
      net/af_iucv: drop inbound packets with invalid flags
      net/af_iucv: fix skb handling on HiperTransport xmit error
      net/iucv: declare iucv_path_table_empty() as static
      s390/qeth: indicate error when netdev allocation fails
      s390/qeth: switch on SG by default for IQD devices
      s390/qeth: don't dump past end of unknown HW header

K. Y. Srinivasan (1):
      Tools: hv: Fix a bug in the key delete code

Kai-Heng Feng (2):
      HID: i2c-hid: Don't reset device upon system resume
      r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENAB=
LED

Keith Busch (1):
      PCI: pciehp: Fix hot-add vs powerfault detection order

Kim Phillips (2):
      perf arm64: Fix include path for asm-generic/unistd.h
      perf annotate: Fix parsing aarch64 branch instructions after
objdump update

Kristian Evensen (1):
      qmi_wwan: Support dynamic config on Quectel EP06

Kuninori Morimoto (1):
      ethernet: renesas: convert to SPDX identifiers

Leon Romanovsky (1):
      RDMA/mlx4: Ensure that maximal send/receive SGE less than supported b=
y HW

Linus Torvalds (2):
      mm: get rid of vmacache_flush_all() entirely
      Linux 4.19-rc4

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: take into account ts samples in wm configuratio=
n

Louis Peens (1):
      nfp: flower: reject tunnel encap with ipv6 outer headers for offloadi=
ng

Lyude Paul (13):
      drm/nouveau/drm/nouveau: Fix bogus drm_kms_helper_poll_enable() place=
ment
      drm/nouveau: Remove duplicate poll_enable() in pmops_runtime_suspend(=
)
      drm/nouveau/drm/nouveau: Fix deadlock with fb_helper with async
RPM requests
      drm/nouveau/drm/nouveau: Use pm_runtime_get_noresume() in
connector_detect()
      drm/nouveau: Fix deadlocks in nouveau_connector_detect()
      drm/nouveau: Remove useless poll_enable() call in switcheroo_set_stat=
e()
      drm/nouveau: Remove useless poll_disable() call in switcheroo_set_sta=
te()
      drm/nouveau: Remove useless poll_enable() call in drm_load()
      drm/nouveau: Only write DP_MSTM_CTRL when needed
      drm/nouveau: Reset MST branching unit before enabling
      drm/nouveau/drm/nouveau: Prevent handling ACPI HPD events too early
      drm/nouveau/drm/nouveau: Don't forget to cancel hpd_work on suspend/u=
nload
      drm/nouveau: Fix nouveau_connector_ddc_detect()

Maciej S. Szmigiero (1):
      r8169: set TxConfig register after TX / RX is enabled, just like RxCo=
nfig

Marek Marczykowski-G=C3=B3recki (1):
      xen/balloon: add runtime control for scrubbing ballooned out pages

Martin Li=C5=A1ka (1):
      perf annotate: Properly interpret indirect call

Martin Schwidefsky (1):
      s390/zcrypt: remove VLA usage from the AP bus

Martin Willi (1):
      netfilter: xt_cluster: add dependency on conntrack module

Masahiro Yamada (1):
      xtensa: remove unnecessary KBUILD_SRC ifeq conditional

Mathias Nyman (3):
      xhci: Fix use after free for URB cancellation on a reallocated endpoi=
nt
      usb: Don't die twice if PCI xhci host is not responding in resume
      usb: Avoid use-after-free by flushing endpoints early in
usb_set_interface()

Matt Ranostay (1):
      Revert "iio: temperature: maxim_thermocouple: add MAX31856 part"

Max Filippov (2):
      xtensa: ISS: don't allocate memory in platform_setup
      xtensa: enable SG chaining in Kconfig

Maxence Dupr=C3=A8s (1):
      USB: add quirk for WORLDE Controller KS49 or Prodipe MIDI 49C
USB controller

Michal 'vorner' Vaner (1):
      netfilter: nfnetlink_queue: Solve the NFQUEUE/conntrack clash
for NF_REPEAT

Michal Hocko (1):
      xen/gntdev: fix up blockable calls to mn_invl_range_start

Miguel Ojeda (1):
      arm64: jump_label.h: use asm_volatile_goto macro instead of "asm goto=
"

Mika Westerberg (1):
      Revert "PCI: Add ACS quirk for Intel 300 series"

Mike Christie (1):
      scsi: iscsi: target: Fix conn_ops double free

Miklos Szeredi (1):
      ovl: fix oopses in ovl_fill_super() failure paths

Mikulas Patocka (2):
      dm verity: fix crash on bufio buffer that was allocated with vmalloc
      dm: disable CRYPTO_TFM_REQ_MAY_SLEEP to fix a GFP_KERNEL
recursion deadlock

Minchan Kim (1):
      android: binder: fix the race mmap and alloc_new_buf_locked

Netanel Belgazal (7):
      net: ena: fix surprise unplug NULL dereference kernel crash
      net: ena: fix driver when PAGE_SIZE =3D=3D 64kB
      net: ena: fix device destruction to gracefully free resources
      net: ena: fix potential double ena_destroy_device()
      net: ena: fix missing lock during device destruction
      net: ena: fix missing calls to READ_ONCE
      net: ena: fix incorrect usage of memory barriers

Nicholas Piggin (3):
      tty: hvc: hvc_poll() fix read loop hang
      tty: hvc: hvc_poll() fix read loop batching
      tty: hvc: hvc_write() fix break condition

Nilesh Javali (1):
      scsi: qedi: Add the CRC size within iSCSI NVM image

Olaf Hering (1):
      xen: avoid crash in disable_hotplug_cpu

Oliver Neukum (2):
      usb: uas: add support for more quirk flags
      Revert "cdc-acm: implement put_char() and flush_chars()"

Pablo Neira Ayuso (2):
      netfilter: conntrack: timeout interface depend on
CONFIG_NF_CONNTRACK_TIMEOUT
      netfilter: cttimeout: ctnl_timeout_find_get() returns incorrect
pointer to type

Parav Pandit (2):
      RDMA/uverbs: Fix error cleanup path of ib_uverbs_add_one()
      RDMA/cma: Protect cma dev list with lock

Paul Burton (1):
      pinctrl: ingenic: Fix group & function error checking

Paulo Zanoni (1):
      tracing/Makefile: Fix handling redefinition of CC_FLAGS_FTRACE

Peter Zijlstra (1):
      perf/UAPI: Clearly mark __PERF_SAMPLE_CALLCHAIN_EARLY as internal use

Petr Machata (1):
      mlxsw: spectrum_buffers: Set up a dedicated pool for BUM traffic

Petr Mladek (1):
      Revert "printk: make sure to print log on console."

Petr Oros (1):
      be2net: Fix memory leak in be_cmd_get_profile_config()

Pieter Jansen van Vuuren (1):
      nfp: flower: fix vlan match by checking both vlan id and vlan pcp

Raed Salem (1):
      net/mlx5: E-Switch, Fix memory leak when creating switchdev mode
FDB tables

Randy Dunlap (9):
      usb/dwc3/gadget: fix kernel-doc parameter warning
      usb: typec: fix kernel-doc parameter warning
      usb/typec: fix kernel-doc notation warning for typec_match_altmode
      linux/mod_devicetable.h: fix kernel-doc missing notation for
typec_device_id
      sched/fair: Fix kernel-doc notation warning
      x86/doc: Fix Documentation/x86/earlyprintk.txt
      arch/hexagon: fix kernel/dma.c build warning
      hexagon: modify ffs() and fls() to return int
      x86/APM: Fix build warning when PROC_FS is not enabled

Richard Fitzgerald (1):
      pinctrl: madera: Fix possible NULL pointer with pdata config

Rishabh Bhatnagar (1):
      firmware: Fix security issue with request_firmware_into_buf()

Rob Herring (1):
      of: fix phandle cache creation for DTs with no phandles

Roi Dayan (2):
      net/mlx5: Fix not releasing read lock when adding flow rules
      net/mlx5: Fix possible deadlock from lockdep when adding fte to fg

Saeed Mahameed (1):
      net/mlx5e: Ethtool steering, fix udp source port value

Sagi Grimberg (1):
      nvmet-rdma: fix possible bogus dereference under heavy load

Sandipan Das (1):
      perf probe powerpc: Ignore SyS symbols irrespective of endianness

Sasha Levin (3):
      tools/lib/lockdep: Update Sasha Levin email to MSFT
      tools/lib/lockdep: Add empty nmi.h
      tools/lib/lockdep: Add dummy task_struct state member

Sean O'Brien (1):
      HID: add support for Apple Magic Keyboards

Somnath Kotur (1):
      bnxt_re: Fix couple of memory leaks that could lead to IOMMU call tra=
ces

Srikar Dronamraju (1):
      sched/topology: Set correct NUMA topology type

Stefan Agner (2):
      HID: input: fix leaking custom input node name
      HID: core: fix memory leak on probe

Stefan Metzmacher (1):
      fs/cifs: require sha512

Stefan Wahren (1):
      net: qca_spi: Fix race condition in spi transfers

Stephen Boyd (1):
      pinctrl: msm: Really mask level interrupts to prevent latching

Stephen Hemminger (1):
      vmbus: don't return values for uninitalized channels

Stephen Rothwell (1):
      fs/cifs: suppress a string overflow warning

Steve Muckle (1):
      sched/fair: Fix vruntime_normalized() for remote non-migration wakeup

Steve Wise (1):
      iw_cxgb4: only allow 1 flush on user qps

Taehee Yoo (2):
      netfilter: nf_tables: release chain in flushing set
      ip: frags: fix crash in ip_do_fragment()

Tao Zhou (1):
      drm/amdgpu: Fix SDMA hang in prt mode v2

Tariq Toukan (2):
      net/mlx5: Use u16 for Work Queue buffer fragment size
      net/mlx5: Use u16 for Work Queue buffer strides offset

Tejun Heo (1):
      MAINTAINERS: Make Dennis the percpu tree maintainer

Thomas Hellstrom (1):
      locking/mutex: Fix mutex debug call and ww_mutex documentation

Tim Anderson (1):
      USB: Add quirk to support DJI CineSSD

Todd Poynor (1):
      MAINTAINERS: Switch a maintainer for drivers/staging/gasket

Tomas Winkler (2):
      mei: bus: fix hw module get/put balance
      mei: bus: need to unlink client before freeing

Trond Myklebust (5):
      NFSv4: Fix a tracepoint Oops in initiate_file_draining()
      pNFS: Ensure we return the error if someone kills a waiting layoutget
      NFSv4: Fix a tracepoint Oops in initiate_file_draining()
      NFSv4.1 fix infinite loop on I/O.
      NFS: Don't open code clearing of delegation state

Tyrel Datwyler (1):
      MAINTAINERS: Add entries for PPC64 RPA PCI hotplug drivers

Vakul Garg (1):
      net/tls: Set count of SG entries if sk_alloc_sg returns -ENOSPC

Vincent Guittot (3):
      sched/pelt: Fix update_blocked_averages() for RT and DL classes
      sched/fair: Fix scale_rt_capacity() for SMT
      sched/fair: Fix load_balance redo for !imbalance

Vincent Pelletier (1):
      scsi: iscsi: target: Set conn->sess to NULL when
iscsi_login_set_conn_values fails

Vincent Whitchurch (1):
      tcp: really ignore MSG_ZEROCOPY if no SO_ZEROCOPY

Vitaly Kuznetsov (1):
      xen/manage: don't complain about an empty value in control/sysrq node

Wei Yongjun (2):
      usb: dwc3: pci: Fix return value check in dwc3_byt_enable_ulpi_refclo=
ck()
      fpga: dfl: fme: fix return value check in in pr_mgmt_init()

Weinan Li (1):
      drm/i915/gvt: Fix the incorrect length of child_device_config issue

Wenjia Zhang (1):
      s390/qeth: use vzalloc for QUERY OAT buffer

Willem de Bruijn (1):
      tcp: rate limit synflood warnings further

Yabin Cui (1):
      perf/core: Force USER_DS when recording user stack data

Yoshihiro Shimoda (2):
      usb: gadget: udc: renesas_usb3: fix maxpacket size of ep0
      usb: Change usb_of_get_companion_dev() place to usb/common

Yue Haibing (1):
      netfilter: conntrack: remove duplicated include from
nf_conntrack_proto_udp.c

Zhenyu Wang (1):
      drm/i915/gvt: Fix life cycle reference on KVM mm
