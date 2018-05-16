Date: Wed, 16 May 2018 18:04:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.41
Message-ID: <20180516160418.GA18660@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.41 kernel.

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

 Documentation/arm64/silicon-errata.txt  |    1=20
 Makefile                                |    2=20
 arch/arm64/Kconfig                      |   14 ++
 arch/arm64/include/asm/assembler.h      |   40 ++++++++
 arch/arm64/include/asm/cputype.h        |    2=20
 arch/arm64/mm/proc.S                    |    5 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c  |   72 +++++++++-----
 arch/powerpc/kvm/book3s_hv.c            |   17 +--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    8 +
 arch/x86/events/core.c                  |    8 +
 arch/x86/events/intel/cstate.c          |    2=20
 arch/x86/events/msr.c                   |    9 +
 arch/x86/kvm/lapic.c                    |   37 ++++---
 crypto/af_alg.c                         |    8 -
 drivers/ata/libata-core.c               |    3=20
 drivers/atm/zatm.c                      |    3=20
 drivers/bluetooth/btusb.c               |   19 +++
 drivers/gpio/gpio-aspeed.c              |    2=20
 drivers/gpio/gpiolib.c                  |    7 -
 drivers/gpu/drm/drm_atomic.c            |    8 +
 drivers/gpu/drm/i915/intel_lvds.c       |    3=20
 drivers/gpu/drm/nouveau/nv50_display.c  |    7 -
 drivers/gpu/drm/vc4/vc4_plane.c         |    2=20
 drivers/md/dm-integrity.c               |    2=20
 drivers/net/can/spi/hi311x.c            |   11 +-
 drivers/net/can/usb/kvaser_usb.c        |    2=20
 drivers/nvme/host/nvme.h                |    5 +
 drivers/nvme/host/pci.c                 |   12 ++
 drivers/pci/pci.c                       |   37 +++++--
 drivers/thermal/samsung/exynos_tmu.c    |   14 ++
 fs/ceph/file.c                          |   10 +-
 fs/cifs/cifsfs.c                        |   13 ++
 fs/fs-writeback.c                       |    2=20
 include/linux/oom.h                     |    2=20
 include/linux/wait_bit.h                |   17 +++
 include/net/inet_timewait_sock.h        |    1=20
 include/net/nexthop.h                   |    2=20
 kernel/compat.c                         |    1=20
 kernel/events/callchain.c               |   10 --
 kernel/events/ring_buffer.c             |    7 +
 kernel/sched/autogroup.c                |    7 +
 kernel/sched/cpufreq_schedutil.c        |    3=20
 kernel/trace/trace_events_filter.c      |    3=20
 kernel/trace/trace_uprobe.c             |    2=20
 mm/backing-dev.c                        |    2=20
 mm/memcontrol.c                         |    3=20
 mm/mmap.c                               |   44 +++++----
 mm/oom_kill.c                           |   74 ++++++++-------
 mm/sparse.c                             |    2=20
 mm/z3fold.c                             |   42 ++++++--
 net/atm/lec.c                           |    9 +
 net/bridge/netfilter/ebtables.c         |   11 +-
 net/core/dev_addr_lists.c               |    4=20
 net/core/skbuff.c                       |    1=20
 net/dccp/ipv4.c                         |    1=20
 net/dccp/ipv6.c                         |    1=20
 net/ipv4/inet_timewait_sock.c           |    1=20
 net/ipv4/inetpeer.c                     |    1=20
 net/ipv4/route.c                        |   11 +-
 net/ipv4/tcp.c                          |    2=20
 net/kcm/kcmsock.c                       |    1=20
 net/netfilter/ipvs/ip_vs_ctl.c          |    8 -
 net/netfilter/ipvs/ip_vs_sync.c         |  155 ++++++++++++++++-----------=
-----
 net/netlink/af_netlink.c                |    2=20
 net/rfkill/rfkill-gpio.c                |    7 +
 65 files changed, 542 insertions(+), 282 deletions(-)

Anthoine Bourgeois (1):
      KVM: x86: remove APIC Timer periodic/oneshot spikes

Boris Brezillon (1):
      drm/vc4: Fix scaling of uni-planar formats

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
      Linux 4.14.41

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

Laurent Vivier (1):
      KVM: PPC: Book3S HV: Fix guest time accounting with VIRT_CPU_ACCOUNTI=
NG_GEN

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

Mikulas Patocka (1):
      dm integrity: use kvfree for kvmalloc'd memory

Paul Mackerras (3):
      KVM: PPC: Book3S HV: Fix trap number return from __kvmppc_vcore_entry
      KVM: PPC: Book3S HV: Fix VRMA initialization with 2MB or 1GB memory b=
acking
      KVM: PPC: Book3S HV: Fix handling of large pages in radix page fault =
handler

Pavel Tatashin (1):
      mm: sections are not offlined during memory hotremove

Peter Zijlstra (6):
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

Steve French (1):
      smb3: directory sync should not return an error

Steven Rostedt (VMware) (1):
      tracing: Fix regex_match_front() to not over compare the test string

Suzuki K Poulose (1):
      arm64: Add work around for Arm Cortex-A55 Erratum 1024718

Tetsuo Handa (1):
      bdi: wake up concurrent wb_shutdown() callers.

Timur Tabi (1):
      gpioib: do not free unrequested descriptors

Tom Herbert (1):
      kcm: Call strp_stop before strp_done in kcm_attach

Uwe Kleine-K=F6nig (1):
      gpio: fix error path in lineevent_create

Ville Syrj=E4l=E4 (2):
      drm/atomic: Clean old_state/new_state in drm_atomic_state_default_cle=
ar()
      drm/atomic: Clean private obj old_state/new_state in drm_atomic_state=
_default_clear()

Vitaly Wool (1):
      z3fold: fix reclaim lock-ups


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlr8VoEACgkQONu9yGCS
aT6NNhAAzfAPNc/ULxynBGmpcpjHv9Hh5CgqHyqRY3p4qoCeSko7/+HTpgC+MW7g
3Nl3g/UK3ybzEsGKzxFlpYzB/bGVbuRpaTrQ6f2/XMImuX57Mk75Ff5WGqydRsi6
z9EjBnKp8szIaXLm0jS26dtnzrLkfMMGns3AdvQxd3YMD41+9A6DVo5cnxv0zL8M
IsP1hbjdLj8pdB89jzu36/T8mbhujor4a+m999DHI9kN8W/pegpdr4uAmJdgFjcc
8/Nonucf+2DIXNQOw5itYzny0UAqrNqrA5ryQf6sifpwG+rYu6m15mYRTGakVsAA
nvE+XgAXHRW2sUAnqKZEjau7GDl5yKTFP7F73YxlT2UDBct8WTu3ebC2nE2es2P+
2a0+UvJZefEMFXFmvHcaBn6lU6Lsdp2s8KEVs76bVUuPszWDAdWc38RWEwIpMsWE
vbDXHHn74ODgTnONnXsEhCYYFM1G8S11VKDoZC4H757OCEGvEjZnPbW2D5yKidDE
4MEtIxAlkAFRAmQvYUIKGdYw+T549gykDH8qJMh8IlrQSEFXE3D0TKka//uRVXEk
7XTc2fV1R5C76q8YnaPxbiW5cJLuikLn5t03l9Age0D3gFAl5d5swjx58L2Q0x5q
ES/dqREw5L1Bs1KeGLTe2EZsdcPxo0K0d2vIo4k8FEodzAumkzs=
=bw8q
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
