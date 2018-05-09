Date: Wed, 9 May 2018 11:35:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.8
Message-ID: <20180509093526.GA26092@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.8 kernel.

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

 Documentation/arm64/silicon-errata.txt                        |    1=20
 Makefile                                                      |    2=20
 arch/arm64/Kconfig                                            |   14=20
 arch/arm64/include/asm/assembler.h                            |   40=20
 arch/arm64/include/asm/cputype.h                              |    2=20
 arch/arm64/mm/proc.S                                          |    5=20
 arch/x86/kernel/tsc.c                                         |   22=20
 arch/x86/kvm/lapic.c                                          |   37=20
 drivers/acpi/button.c                                         |   24=20
 drivers/gpu/drm/bridge/dumb-vga-dac.c                         |    4=20
 drivers/gpu/drm/vc4/vc4_crtc.c                                |   46 -
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                           |    1=20
 drivers/infiniband/core/ucma.c                                |    2=20
 drivers/infiniband/hw/cxgb4/cq.c                              |   11=20
 drivers/infiniband/hw/cxgb4/device.c                          |    9=20
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h                        |    6=20
 drivers/infiniband/hw/cxgb4/qp.c                              |    4=20
 drivers/infiniband/hw/cxgb4/resource.c                        |   26=20
 drivers/infiniband/hw/hfi1/driver.c                           |   19=20
 drivers/infiniband/hw/hfi1/hfi.h                              |    8=20
 drivers/infiniband/hw/hfi1/init.c                             |    2=20
 drivers/infiniband/hw/hfi1/pcie.c                             |    3=20
 drivers/infiniband/hw/hfi1/ruc.c                              |   50 -
 drivers/infiniband/hw/hfi1/ud.c                               |    4=20
 drivers/infiniband/hw/mlx4/qp.c                               |    3=20
 drivers/infiniband/hw/mlx5/Kconfig                            |    1=20
 drivers/infiniband/hw/mlx5/mr.c                               |   32=20
 drivers/infiniband/hw/mlx5/qp.c                               |   22=20
 drivers/input/input-leds.c                                    |    8=20
 drivers/input/touchscreen/atmel_mxt_ts.c                      |    9=20
 drivers/irqchip/qcom-irq-combiner.c                           |    4=20
 drivers/net/usb/qmi_wwan.c                                    |    1=20
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c |   15=20
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c           |   11=20
 drivers/net/wireless/realtek/rtlwifi/wifi.h                   |    5=20
 drivers/platform/x86/Kconfig                                  |    2=20
 drivers/platform/x86/asus-wireless.c                          |    4=20
 drivers/target/target_core_iblock.c                           |    8=20
 drivers/usb/core/config.c                                     |    4=20
 drivers/usb/dwc3/gadget.c                                     |    2=20
 drivers/usb/host/xhci.c                                       |    1=20
 drivers/usb/musb/musb_gadget.c                                |    3=20
 drivers/usb/musb/musb_host.c                                  |    4=20
 drivers/usb/serial/option.c                                   |  451 +++--=
-----
 drivers/usb/serial/visor.c                                    |   69 -
 fs/btrfs/extent-tree.c                                        |    7=20
 fs/xfs/xfs_file.c                                             |   14=20
 kernel/time/clocksource.c                                     |   57 -
 kernel/trace/trace_uprobe.c                                   |   24=20
 kernel/tracepoint.c                                           |    4=20
 lib/errseq.c                                                  |   23=20
 lib/swiotlb.c                                                 |    2=20
 sound/core/pcm_compat.c                                       |    2=20
 sound/core/seq/seq_virmidi.c                                  |    4=20
 sound/drivers/aloop.c                                         |   29=20
 sound/firewire/amdtp-stream.c                                 |    5=20
 sound/pci/hda/patch_realtek.c                                 |    2=20
 tools/power/acpi/Makefile.config                              |    1=20
 tools/testing/selftests/firmware/fw_filesystem.sh             |    6=20
 59 files changed, 673 insertions(+), 508 deletions(-)

Agustin Vega-Frias (1):
      irqchip/qcom: Fix check for spurious interrupts

Alan Stern (1):
      USB: Accept bulk endpoints with 1024-byte maxpacket

Anthoine Bourgeois (1):
      KVM: x86: remove APIC Timer periodic/oneshot spikes

Ard Biesheuvel (1):
      ACPI / button: make module loadable when booted in non-ACPI mode

Ben Hutchings (1):
      test_firmware: fix setting old custom fw path back on exit, second try

Bharat Potnuri (1):
      iw_cxgb4: Atomically flush per QP HW CQEs

Bin Liu (2):
      usb: musb: host: fix potential NULL pointer dereference
      usb: musb: trace: fix NULL pointer dereference in musb_g_tx()

Boris Brezillon (1):
      drm/vc4: Make sure vc4_bo_{inc,dec}_usecnt() calls are balanced

Bryant G Ly (1):
      scsi: target: Fix fortify_panic kernel exception

Danit Goldberg (1):
      IB/mlx5: Use unlimited rate when static rate is not supported

Darrick J. Wong (1):
      xfs: prevent creating negative-sized file via INSERT_RANGE

Dmitry Torokhov (1):
      Input: leds - fix out of bound access

Greg Kroah-Hartman (2):
      USB: serial: visor: handle potential invalid device configuration
      Linux 4.16.8

Jiri Slaby (1):
      tools: power/acpi, revert to LD =3D gcc

Johan Hovold (1):
      USB: serial: option: reimplement interface masking

Jo=C3=A3o Paulo Rechi Vita (1):
      platform/x86: asus-wireless: Fix NULL pointer dereference

Leon Romanovsky (3):
      RDMA/mlx5: Fix multiple NULL-ptr deref errors in rereg_mr flow
      RDMA/mlx4: Add missed RSS hash inner header flag
      RDMA/mlx5: Protect from shift operand overflow

Mario Limonciello (1):
      platform/x86: Kconfig: Fix dell-laptop dependency chain.

Mathias Nyman (1):
      xhci: Fix use-after-free in xhci_free_virt_device

Mathieu Desnoyers (1):
      tracepoint: Do not warn on ENOMEM

Matthew Wilcox (1):
      errseq: Always report a writeback error once

Mayank Rana (1):
      usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue

Michel D=C3=A4nzer (1):
      swiotlb: fix inversed DMA_ATTR_NO_WARN test

Mike Marciniszyn (2):
      IB/hfi1: Fix handling of FECN marked multicast packet
      IB/hfi1: Fix loss of BECN with AHG

Peter Zijlstra (5):
      x86/tsc: Always unregister clocksource_tsc_early
      x86/tsc: Fix mark_tsc_unstable()
      clocksource: Allow clocksource_mark_unstable() on unregistered clocks=
ources
      clocksource: Initialize cs->wd_list
      clocksource: Consistent de-rate when marking unstable

Ping-Ke Shih (1):
      rtlwifi: cleanup 8723be ant_sel definition

Raju Rangoju (1):
      RDMA/cxgb4: release hw resources on device removal

Randy Dunlap (1):
      infiniband: mlx5: fix build errors when INFINIBAND_USER_ACCESS=3Dm

Robert Rosengren (1):
      ALSA: aloop: Mark paused device as inactive

Roland Dreier (1):
      RDMA/ucma: Allow resolving address w/o specifying source address

SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) (2):
      NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2
      USB: serial: option: adding support for ublox R410M

Sean Paul (1):
      drm/bridge: vga-dac: Fix edid memory leak

Sebastian Sanchez (1):
      IB/hfi1: Fix NULL pointer dereference when invalid num_vls is used

Song Liu (1):
      tracing: Fix bad use of igrab in trace_uprobe.c

Suzuki K Poulose (1):
      arm64: Add work around for Arm Cortex-A55 Erratum 1024718

Takashi Iwai (4):
      ALSA: hda - Fix incorrect usage of IS_REACHABLE()
      ALSA: pcm: Check PCM state at xfern compat ioctl
      ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()
      ALSA: aloop: Add missing cable lock to ctl API callbacks

Takashi Sakamoto (1):
      ALSA: dice: fix kernel NULL pointer dereference due to invalid calcul=
ation for array index

Thomas Hellstrom (1):
      drm/vmwgfx: Fix a buffer object leak

Vittorio Gambaletta (VittGam) (1):
      Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromeb=
ook Pro

ethanwu (1):
      btrfs: Take trans lock before access running trans in check_delayed_r=
ef


--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrywN0ACgkQONu9yGCS
aT4wxg/+KdLOrUpc8r+LU32mkXlbXCe7hNa3FwcZLjf8Of3J/HEuIJfBfXueXd9i
mrnTeE6UDtHG+wwtdF4scMKMNswFGiYr2QCLIV3gl94yxj/vZGcPwwXhaepp7BbM
6/XzNLwtiGVMckEwBXIe2WGOqrlkP+ZJgZyjAO1G9N+wbvd1nVb/wvdhCW+athCQ
DdvlZdUntg+ba6MY9fXEqCZaxgDsTx5AMbukcjfQSe+ilyKLrGdPxKP3lx7V5uvA
MDasqUwgfuPiTAZxhQJIa6FDn0pHrUqjIfj1HJ19SNAiWpOxiTECtx8wT59dRd3E
RC4ddcYBA/57x7IyUY9SS7Nw58uhFbHWfI8tShxKYjX23MtAMko1KclC5gPbLVBm
ao2LGD4O1alL4WmWz2GrnIUL8ORBCdIIaPcEWPMB5YoH0Xs8wsk9EN3wz3EZDdYk
Ummg7PabiXdAZuDlgj8fSuuWIzJ0XYO54SvSXZ/Yun0kZSQUb+lfjlw0XGgHrRpP
bW9mkfaubdPYaBgr3JvRrfDan+x+WHSOsVe69XRUROgjO8bMjsMY0DddfD27IUMd
8n95iBMWFTkSnrIKT+rH/ClINwxu6VKmWy16xGJi1r6XnziM09zZOkXUleUWwkXu
+3AH4+LzafLf+imSx2dUhOy6hjoDfktNdndT/LnhloQl2IE1nb8=
=p++v
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
