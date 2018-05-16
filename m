Date: Wed, 16 May 2018 18:04:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.9
Message-ID: <20180516160442.GA18736@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.9 kernel.

All users of the 4.16 kernel series must upgrade.

The updated 4.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.16.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                 |    2=20
 arch/arm/boot/dts/imx35.dtsi             |    4=20
 arch/arm/boot/dts/imx53.dtsi             |    4=20
 arch/x86/events/core.c                   |    8 +
 arch/x86/events/intel/cstate.c           |    2=20
 arch/x86/events/msr.c                    |    9 +
 crypto/af_alg.c                          |    8 -
 drivers/ata/libata-core.c                |    3=20
 drivers/atm/zatm.c                       |    3=20
 drivers/bluetooth/btusb.c                |   19 +++
 drivers/clk/ti/clock.h                   |    9 +
 drivers/gpio/gpio-aspeed.c               |    2=20
 drivers/gpio/gpiolib.c                   |    7 -
 drivers/gpu/drm/drm_atomic.c             |    8 +
 drivers/gpu/drm/i915/intel_cdclk.c       |   41 +++++++-
 drivers/gpu/drm/i915/intel_dp.c          |   20 ----
 drivers/gpu/drm/i915/intel_lvds.c        |    3=20
 drivers/gpu/drm/nouveau/nouveau_bo.c     |    1=20
 drivers/gpu/drm/nouveau/nouveau_bo.h     |    2=20
 drivers/gpu/drm/nouveau/nouveau_ttm.c    |    6 -
 drivers/gpu/drm/nouveau/nv50_display.c   |    7 -
 drivers/gpu/drm/ttm/ttm_page_alloc.c     |   11 +-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |    3=20
 drivers/gpu/drm/vc4/vc4_plane.c          |    2=20
 drivers/i2c/i2c-dev.c                    |    2=20
 drivers/md/dm-integrity.c                |    2=20
 drivers/mtd/nand/marvell_nand.c          |   12 +-
 drivers/net/can/flexcan.c                |   26 ++---
 drivers/net/can/spi/hi311x.c             |   11 +-
 drivers/net/can/usb/kvaser_usb.c         |    2=20
 drivers/nvme/host/core.c                 |    3=20
 drivers/nvme/host/nvme.h                 |    5 +
 drivers/nvme/host/pci.c                  |   12 ++
 drivers/pci/pci.c                        |   37 +++++--
 drivers/thermal/samsung/exynos_tmu.c     |   14 ++
 fs/ceph/file.c                           |   10 +-
 fs/cifs/cifsfs.c                         |   13 ++
 fs/fs-writeback.c                        |    2=20
 include/linux/bpf.h                      |    4=20
 include/linux/oom.h                      |    2=20
 include/linux/wait_bit.h                 |   17 +++
 include/net/inet_timewait_sock.h         |    1=20
 include/net/nexthop.h                    |    2=20
 kernel/bpf/core.c                        |   45 +++++----
 kernel/compat.c                          |    1=20
 kernel/events/callchain.c                |   10 --
 kernel/events/ring_buffer.c              |    7 +
 kernel/sched/autogroup.c                 |    7 +
 kernel/sched/core.c                      |    7 +
 kernel/sched/cpufreq_schedutil.c         |    3=20
 kernel/trace/bpf_trace.c                 |   25 ++++-
 kernel/trace/trace_events_filter.c       |    3=20
 kernel/trace/trace_uprobe.c              |    2=20
 lib/swiotlb.c                            |    2=20
 mm/backing-dev.c                         |    3=20
 mm/memcontrol.c                          |    3=20
 mm/mmap.c                                |   44 +++++---
 mm/oom_kill.c                            |   81 ++++++++--------
 mm/sparse.c                              |    2=20
 mm/z3fold.c                              |   42 ++++++--
 net/atm/lec.c                            |    9 +
 net/bridge/netfilter/ebtables.c          |   11 +-
 net/core/dev_addr_lists.c                |    4=20
 net/core/skbuff.c                        |    1=20
 net/dccp/ipv4.c                          |    1=20
 net/dccp/ipv6.c                          |    1=20
 net/ipv4/inet_timewait_sock.c            |    1=20
 net/ipv4/inetpeer.c                      |    1=20
 net/ipv4/route.c                         |   11 +-
 net/ipv4/tcp.c                           |    2=20
 net/kcm/kcmsock.c                        |    1=20
 net/netfilter/ipvs/ip_vs_ctl.c           |    8 -
 net/netfilter/ipvs/ip_vs_sync.c          |  155 ++++++++++++++++----------=
-----
 net/netlink/af_netlink.c                 |    2=20
 net/rds/tcp.c                            |   17 +--
 net/rfkill/rfkill-gpio.c                 |    7 +
 76 files changed, 557 insertions(+), 323 deletions(-)

Alexander Popov (1):
      i2c: dev: prevent ZERO_SIZE_PTR deref in i2cdev_ioctl_rdwr()

Ben Skeggs (1):
      drm/nouveau/ttm: don't dereference nvbo::cli, it can outlive client

Boris Brezillon (1):
      drm/vc4: Fix scaling of uni-planar formats

Charles Machalow (1):
      nvme: Fix sync controller reset return

Chris Packham (1):
      mtd: rawnand: marvell: pass ms delay to wait_op

David Rientjes (1):
      mm, oom: fix concurrent munlock and oom reaper unmap, v3

Eric Dumazet (10):
      crypto: af_alg - fix possible uninit-value in alg_bind()
      netlink: fix uninit-value in netlink_sendmsg
      net: fix rtnh_ok()
      net: initialize skb->peeked when cloning
      net: fix uninit-value in __hw_addr_add_ex()
      dccp: initialize ireq->ir_mark
      ipv4: fix uninit-value in ip_route_output_key_hash_rcu()
      soreuseport: initialise timewait reuseport field
      inetpeer: fix uninit-value in inet_getpeer
      tcp: fix TCP_REPAIR_QUEUE bound checking

Florent Flament (1):
      drm/i915: Fix drm:intel_enable_lvds ERROR message in kernel log

Florian Westphal (1):
      netfilter: ebtables: don't attempt to allocate 0-sized compat array

Govert Overgaauw (1):
      gpio: fix aspeed_gpio unmask irq

Greg Kroah-Hartman (1):
      Linux 4.16.9

Gustavo A. R. Silva (2):
      net: atm: Fix potential Spectre v1
      atm: zatm: Fix potential Spectre v1

Hans de Goede (4):
      libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs
      Revert "Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174"
      Bluetooth: btusb: Add Dell XPS 13 9360 to btusb_needs_reset_resume_ta=
ble
      Bluetooth: btusb: Only check needs_reset_resume DMI table for QCA rom=
e chipsets

Ilya Dryomov (1):
      ceph: fix rsize/wsize capping in ceph_direct_read_write()

Jan Kara (1):
      bdi: Fix oops in wb_workfn()

Jann Horn (1):
      compat: fix 4-byte infoleak via uninitialized struct field

Jean Delvare (1):
      swiotlb: silent unwanted warning "buffer is full"

Jens Axboe (1):
      nvme: add quirk to force medium priority for SQ creation

Jimmy Assarsson (1):
      can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_=
msg()

Jiri Olsa (1):
      perf: Remove superfluous allocation error check

Johan Hovold (1):
      rfkill: gpio: fix memory leak in probe error path

Julian Anastasov (1):
      ipvs: fix rtnl_lock lockups caused by start_sync_thread

Kai Heng Feng (1):
      PCI / PM: Always check PME wakeup capability for runtime wakeup suppo=
rt

Lukas Wunner (2):
      can: hi311x: Acquire SPI lock on ->do_get_berr_counter
      can: hi311x: Work around TX complete interrupt erratum

Lyude Paul (1):
      drm/nouveau: Fix deadlock in nv50_mstm_register_connector()

Marek Szyprowski (2):
      thermal: exynos: Reading temperature makes sense only when TMU is tur=
ned on
      thermal: exynos: Propagate error value from tmu_read()

Masami Hiramatsu (1):
      tracing/uprobe_event: Fix strncpy corner case

Michal Hocko (1):
      memcg: fix per_node_info cleanup

Michel D=E4nzer (1):
      drm/ttm: Use GFP_TRANSHUGE_LIGHT for allocating huge pages

Mikulas Patocka (1):
      dm integrity: use kvfree for kvmalloc'd memory

Miquel Raynal (1):
      mtd: rawnand: marvell: fix command xtype in BCH write hook

Pavel Tatashin (1):
      mm: sections are not offlined during memory hotremove

Peter Zijlstra (7):
      sched/core: Fix possible Spectre-v1 indexing for sched_prio_to_weight=
[]
      sched/autogroup: Fix possible Spectre-v1 indexing for sched_prio_to_w=
eight[]
      perf/x86: Fix possible Spectre-v1 indexing for hw_perf_event cache_*
      perf/x86/cstate: Fix possible Spectre-v1 indexing for pkg_msr
      perf/x86/msr: Fix possible Spectre-v1 indexing in the MSR driver
      perf/core: Fix possible Spectre-v1 indexing for ->aux_pages[]
      perf/x86: Fix possible Spectre-v1 indexing for x86_pmu::event_map()

Rafael J. Wysocki (2):
      PCI / PM: Check device_may_wakeup() in pci_enable_wake()
      cpufreq: schedutil: Avoid using invalid next_freq

Rodrigo Vivi (1):
      drm/i915: Adjust eDP's logical vco in a reliable place.

Sowmini Varadhan (1):
      rds: tcp: must use spin_lock_irq* and not spin_lock_bh with rds_tcp_c=
onn_lock

Steve French (1):
      smb3: directory sync should not return an error

Steven Rostedt (VMware) (1):
      tracing: Fix regex_match_front() to not over compare the test string

Tero Kristo (1):
      clk: ti: fix flag space conflict with clkctrl clocks

Tetsuo Handa (2):
      bdi: wake up concurrent wb_shutdown() callers.
      bdi: Fix use after free bug in debugfs_remove()

Timur Tabi (1):
      gpioib: do not free unrequested descriptors

Tom Herbert (1):
      kcm: Call strp_stop before strp_done in kcm_attach

Uwe Kleine-K=F6nig (3):
      gpio: fix error path in lineevent_create
      can: flexcan: fix endianess detection
      arm: dts: imx[35]*: declare flexcan devices to be compatible to imx25=
's flexcan

Ville Syrj=E4l=E4 (2):
      drm/atomic: Clean old_state/new_state in drm_atomic_state_default_cle=
ar()
      drm/atomic: Clean private obj old_state/new_state in drm_atomic_state=
_default_clear()

Vitaly Wool (1):
      z3fold: fix reclaim lock-ups

Yonghong Song (1):
      bpf/tracing: fix a deadlock in perf_event_detach_bpf_prog


--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlr8VpoACgkQONu9yGCS
aT75jBAAkpv2epbvPkaWad0Co2mBXyw1UItJ4HzDG8VdXZV0+D2AqvkMNnmUFJVj
aQcHQ9RmAZZin6kJWafVkhkfMluuqx95cVJiLBTWs4P2bffoBducVyG1aMH/2ahz
D0MpAmg5J8dSglZiwq7cwUGnG24N82IteyFUcnTa5x5sSxKMitDyN8nADCzUp2b8
DNvN3l1sYBLuTMWaYIgXfP6l9ZGZdmXYTluUZwEAiB75JtAuaoKRxh30hhEX4vBr
KGykGFTxi5HTu2RFqq+KMSLSqE0ZUnmsVGYcgmb1j4rIzjTVMDLLBXLGe6mjOiCr
LMuAXG7X8heodzeq0MYaKsPX0P4WwOE13/4LFb9oFKryp4qOPBjjBC8w8LkGG0xy
54ErXeCqxvckLsf3oo/zMIv8eCXCV8cU+cirt8c9/21BK9rdqJw/PdIArGzElJJo
T+HX7/XPywGRuIMRLwlWHZHEzds5T+ccWSx/u5+5WThdAaukOak9Njw5RtkP1CUN
FqyKQdQxMH0Fej2L9ceh8YQnEGSlVygxurD0rD0u0bL/+AkLetA4Shr/SbyhzRy6
VyccfDSqSoc/Om4yOyaAKm1cW40BCkgnhui6tJ+QJiDnac+Yr0mLlNGA3Uym7jpX
VaA16Gzt8gv0i8oYl+bwzyF255fZ5AtKJuW7sdUgC5ivwU8Z4vU=
=AglW
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
