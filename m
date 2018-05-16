Date: Wed, 16 May 2018 18:03:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.100
Message-ID: <20180516160337.GA18576@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.100 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
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
 arch/arm64/include/asm/cputype.h        |    5 +
 arch/arm64/mm/proc.S                    |    5 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    8 +
 arch/x86/events/core.c                  |    8 +
 arch/x86/events/intel/cstate.c          |    2=20
 arch/x86/events/msr.c                   |    9 +
 crypto/af_alg.c                         |    8 -
 drivers/ata/libata-core.c               |    3=20
 drivers/atm/zatm.c                      |    3=20
 drivers/bluetooth/btusb.c               |    2=20
 drivers/gpio/gpio-aspeed.c              |    2=20
 drivers/gpio/gpiolib.c                  |    7 -
 drivers/gpu/drm/i915/intel_lvds.c       |    3=20
 drivers/gpu/drm/vc4/vc4_plane.c         |    2=20
 drivers/infiniband/core/device.c        |    3=20
 drivers/net/can/usb/kvaser_usb.c        |    2=20
 drivers/thermal/samsung/exynos_tmu.c    |   14 ++
 fs/f2fs/data.c                          |    2=20
 fs/fs-writeback.c                       |    2=20
 include/net/inet_timewait_sock.h        |    1=20
 include/net/nexthop.h                   |    2=20
 kernel/events/callchain.c               |   10 --
 kernel/events/ring_buffer.c             |    7 +
 kernel/trace/trace_events_filter.c      |    3=20
 kernel/trace/trace_uprobe.c             |    2=20
 net/atm/lec.c                           |    9 +
 net/core/dev_addr_lists.c               |    4=20
 net/core/skbuff.c                       |    1=20
 net/dccp/ipv4.c                         |    1=20
 net/dccp/ipv6.c                         |    1=20
 net/ipv4/inet_timewait_sock.c           |    1=20
 net/ipv4/tcp.c                          |    2=20
 net/kcm/kcmsock.c                       |    1=20
 net/netfilter/ipvs/ip_vs_ctl.c          |    8 -
 net/netfilter/ipvs/ip_vs_sync.c         |  155 ++++++++++++++++-----------=
-----
 net/netlink/af_netlink.c                |    2=20
 net/rfkill/rfkill-gpio.c                |    7 +
 41 files changed, 237 insertions(+), 127 deletions(-)

Boris Brezillon (1):
      drm/vc4: Fix scaling of uni-planar formats

Eric Dumazet (8):
      crypto: af_alg - fix possible uninit-value in alg_bind()
      netlink: fix uninit-value in netlink_sendmsg
      net: fix rtnh_ok()
      net: initialize skb->peeked when cloning
      net: fix uninit-value in __hw_addr_add_ex()
      dccp: initialize ireq->ir_mark
      soreuseport: initialise timewait reuseport field
      tcp: fix TCP_REPAIR_QUEUE bound checking

Florent Flament (1):
      drm/i915: Fix drm:intel_enable_lvds ERROR message in kernel log

Govert Overgaauw (1):
      gpio: fix aspeed_gpio unmask irq

Greg Kroah-Hartman (1):
      Linux 4.9.100

Gustavo A. R. Silva (2):
      net: atm: Fix potential Spectre v1
      atm: zatm: Fix potential Spectre v1

Hans de Goede (2):
      libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs
      Revert "Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174"

Jan Kara (1):
      bdi: Fix oops in wb_workfn()

Jimmy Assarsson (1):
      can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_=
msg()

Jiri Olsa (1):
      perf: Remove superfluous allocation error check

Johan Hovold (1):
      rfkill: gpio: fix memory leak in probe error path

Julian Anastasov (1):
      ipvs: fix rtnl_lock lockups caused by start_sync_thread

Marek Szyprowski (2):
      thermal: exynos: Reading temperature makes sense only when TMU is tur=
ned on
      thermal: exynos: Propagate error value from tmu_read()

Masami Hiramatsu (1):
      tracing/uprobe_event: Fix strncpy corner case

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Fix trap number return from __kvmppc_vcore_entry

Peter Zijlstra (5):
      perf/x86: Fix possible Spectre-v1 indexing for hw_perf_event cache_*
      perf/x86/cstate: Fix possible Spectre-v1 indexing for pkg_msr
      perf/x86/msr: Fix possible Spectre-v1 indexing in the MSR driver
      perf/core: Fix possible Spectre-v1 indexing for ->aux_pages[]
      perf/x86: Fix possible Spectre-v1 indexing for x86_pmu::event_map()

Sagi Grimberg (1):
      IB/device: Convert ib-comp-wq to be CPU-bound

Steven Rostedt (VMware) (1):
      tracing: Fix regex_match_front() to not over compare the test string

Suzuki K Poulose (1):
      arm64: Add work around for Arm Cortex-A55 Erratum 1024718

Timur Tabi (1):
      gpioib: do not free unrequested descriptors

Tom Herbert (1):
      kcm: Call strp_stop before strp_done in kcm_attach

Uwe Kleine-K=F6nig (1):
      gpio: fix error path in lineevent_create

Wei Fang (1):
      f2fs: fix a dead loop in f2fs_fiemap()


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlr8VlgACgkQONu9yGCS
aT7QQQ//TbRAAT9vz+8cYewoeunphnIpsPpyoWEFZkjwId2rkBgJ2CiLoXrjrnC8
aoZkIvsANvZQ+80aJUY9Z/StF56SAhRlmIe/UQFKpm14THMgI5CUW2TIlrUgITJj
d/86YzAatw6U8+tbqcH28nk+f6BY/CEKRpZ4abQip7PdDBiR1/PI0Szo7Fcn0/D9
ewgazCzZXXcxbNEZP/OdmehI64iy5k+tiXqfu1AM/BQ0A2EzsZP6SXZgyp8HFnY2
E/JVIlKGtwd/ditss21AR558X3zhJmTEegzkbczN6wKsIwwN71fms/WSlVzSF4YZ
GM479e82mePOxSaPtvbJBOsxvrBWyDe8W5FuBMj/wfSDwNfwsskrINFT//URV3HF
tDe0+yeeCr+6aD07niYvsLjo46QQB3tQcgPO3UKKUmloxR/gGXvdzYFJ0Da/9l/2
UsRmvmdSB4aedFB1WEzCGq6NZQC4gcwbZ3hbUAXqe5OYb014WN/VAc4im7h0P6OB
1HFcrrvtAPwtHwadKH5uX4mKICfC0iuGS6dUOSIqcFwCPW23/HbLcQF/6qVlVc2S
OrIfhzqwiMVBXXuUyFLUF2f0sZHL774NqrnhTVQ+kA9lXUZnkOpx9jiHNCMYtfeS
UpSyYzVy/YY0Y88Ll0iIP7j5WhBU+E1gjrf7Y97F3RYWLNNwh/0=
=xNaV
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
