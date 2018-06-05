Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeFES6B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:58:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:32974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751812AbeFES55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:57:57 -0400
Date: Tue, 5 Jun 2018 20:57:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY driver patches for 4.18-rc1
Message-ID: <20180605185734.GA24892@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 771c577c23bac90597c685971d7297ea00f99d11:

  Linux 4.17-rc6 (2018-05-20 15:31:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/ tags/usb-4.18-rc1

for you to fetch changes up to c2ef60fea2dc7f903450926aee1f9c282ea529ca:

  Revert "xhci: Reset Renesas uPD72020x USB controller for 32-bit DMA issue" (2018-06-01 13:24:51 +0200)

----------------------------------------------------------------
USB/PHY patches for 4.18-rc1

Here is the big USB pull request for 4.18-rc1.

Lots of stuff here, the highlights are:
	- phy driver updates and new additions
	- usual set of xhci driver updates
	- normal set of musb updates
	- gadget driver updates and new controllers
	- typec work, it's getting closer to getting fully out of the
	  staging portion of the tree.
	- lots of minor cleanups and bugfixes.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Thomson (8):
      typec: tcpm: Add core support for sink side PPS
      Documentation: power: Initial effort to document power_supply ABI
      power: supply: Add error checking of psy desc during registration
      power: supply: Add 'usb_type' property and supporting code
      typec: tcpm: Represent source supply through power_supply
      typec: tcpm: Add support for sink PPS related messages
      power: supply: Add fwnode pointer to power_supply_config struct
      typec: tcpm: Provide fwnode pointer as part of psy_cfg

Adam Wallis (1):
      usb: xhci: force all memory allocations to node

Alan Stern (1):
      usb: gadget: udc: core: Document the relation between usb_ep_queue() and completion callback

Alban Bedel (1):
      phy: Add a driver for the ATH79 USB phy

Alexander Kappner (2):
      usb-storage: Add support for FL_ALWAYS_SYNC flag in the UAS driver
      usb-storage: Add compatibility quirk flags for G-Technologies G-Drive

Amelie Delaunay (1):
      phy: stm32: fix usbphyc static checker and checkpatch warnings

Andrey Smirnov (1):
      usb: chipidea: Fix ULPI on imx51

Andrzej Hajda (1):
      USB: dwc3: get extcon device by OF graph bindings

Andy Shevchenko (1):
      phy: tegra: Convert to use match_string() helper

Anurag Kumar Vulisha (2):
      usb: dwc3: gadget: Correct handling of scattergather lists
      usb: dwc3: gadget: Correct the logic for queuing sgs

Arnd Bergmann (2):
      usb: musb: remove an unused variable
      phy: tegra: select USB_COMMON

Artur Petrosyan (3):
      usb: dwc2: Fix crash in incomplete isoc intr handlers.
      usb: dwc2: Change reading of current frame number flow.
      usb: dwc2: WA for Full speed ISOC IN in DDMA mode.

Benjamin Herrenschmidt (2):
      usb/gadget: Constify usb_gadget_get_string "table" argument
      usb/gadget: Add driver for Aspeed SoC virtual hub

Bin Liu (13):
      usb: musb: merge musbhsdma.h into musbhsdma.c
      usb: musb: remove readl/writel from struct musb_platform_ops
      usb: musb: remove adjust_channel_params() callback from musb_platform_ops
      usb: musb: remove some register access wrapper functions
      usb: musb: remove duplicated quirks flag
      usb: musb: dsps: remove duplicated get_musb_port_mode()
      usb: musb: remove duplicated port mode enum
      usb: musb: remove unused members in struct musb_hdrc_config
      usb: musb: break the huge isr musb_stage0_irq() into small functions
      usb: musb: remove references to default_a of struct usb_otg
      usb: musb: disable otg protocol support
      usb: musb: gadget: fix to_musb_request() to not return NULL
      usb: musb: gadget: fix to_musb_ep() to not return NULL

Chunfeng Yun (14):
      usb: mtu3: avoid TX data length truncated in SS/SSP mode
      usb: mtu3: remove repeated setting of gadget state
      usb: mtu3: fix an unrecognized issue when connected with PC
      usb: mtu3: fix operation failure when test TEST_J/K
      usb: mtu3: make USB_MTU3_DUAL_ROLE depend on EXTCON but not USB_MTU3
      usb: gadget: composite: fill bcdUSB as 0x0320 for SuperSpeed or higher speeds
      dt-bindings: add MediaTek XS-PHY binding
      phy: mediatek: add XS-PHY driver
      usb: mtu3: re-enable controller to accept LPM request after LPM resume
      usb: mtu3: fix uncontinuous SeqN issue after disable EP
      usb: mtu3: clear test_mode flag when reset
      usb: mtu3: avoid sleep in atomic context when enter test mode
      usb: mtu3: reset gadget when VBUS_FALL interrupt arises
      usb: mtu3: fix warning of sleep in atomic context in notifier callback

Colin Ian King (1):
      usb-misc: sisusbvga: fix spelling mistake: "asymmeric" -> "asymmetric"

Dmitry Osipenko (6):
      usb: phy: tegra: Cleanup error messages
      usb: tegra: Move utmi-pads reset from ehci-tegra to tegra-phy
      usb: phy: Add Kconfig entry for Tegra PHY driver
      usb: phy: tegra: Cleanup error messages
      usb: tegra: Move utmi-pads reset from ehci-tegra to tegra-phy
      usb: phy: Add Kconfig entry for Tegra PHY driver

Dominik Bozek (1):
      usb: hub: Don't wait for connect state at resume for powered-off ports

Douglas Anderson (1):
      usb: dwc3: Remove DEBUG define from Qualcomm DWC3 glue driver

Felipe Balbi (43):
      usb: dwc3: gadget: pre-issue Start Transfer for Interrupt EPs too
      usb: dwc3: gadget: XferNotReady is Isoc-only
      usb: dwc3: gadget: XferComplete only for EP0
      usb: dwc3: gadget: rename dwc3_endpoint_transfer_complete()
      usb: dwc3: gadget: don't kick transfer all the time
      usb: dwc3: gadget: rename done_trbs and done_reqs
      usb: dwc3: gadget: remove allocated/queued request tracking
      usb: dwc3: gadget: remove some pointless checks
      usb: dwc3: gadget: rename dwc3_gadget_start_isoc()
      usb: dwc3: gadget: move handler closer to calling site
      usb: dwc3: gadget: remove unnecessary 'dwc' parameter
      usb: dwc3: gadget: always use frame number from XferNotReady
      usb: dwc3: gadget: update dep->frame_number from XferInprogress too
      usb: dwc3: gadget: start removing BUSY flag
      usb: dwc3: gadget: remove DWC3_EP_BUSY flag
      usb: dwc3: gadget: make cleanup_completed_requests() return nothing
      usb: dwc3: gadget: remove unnecessary 'ioc' variable
      usb: dwc3: gadget: check for Missed Isoc from event status
      usb: dwc3: gadget: remove duplicated missed isoc handling
      usb: dwc3: gadget: simplify queueing of isoc transfers
      usb: dwc3: gadget: simplify isoc case on cleanup_completed_requests
      usb: dwc3: gadget: split scatterlist and linear handlers
      usb: dwc3: gadget: remove PENDING handling from cleanup_completed
      usb: dwc3: gadget: remove unnecessary 'chain' variable
      usb: dwc3: gadget: simplify unaligned and zlp handling
      usb: dwc3: trace: print out event status too
      usb: dwc3: gadget: simplify short packet event
      usb: dwc3: gadget: simplify IOC handling
      usb: dwc3: gadget: one declaration per line
      usb: dwc3: gadget: reduce scope of ret variable
      usb: dwc3: gadget: get rid of the length variable
      usb: dwc3: gadget: split dwc3_gadget_ep_cleanup_completed_requests()
      usb: dwc3: gadget: refactor dwc3_gadget_init_endpoints()
      usb: dwc3: gadget: combine modify & restore into single argument
      usb: dwc3: gadget: remove a few more dwc arguments
      usb: dwc3: gadget: move set_xfer_resource() in place of prototype
      usb: dwc3: gadget: move dwc3_calc_trbs_left() in place of prototype
      usb: dwc3: debug: decode uFrame from event too
      usb: dwc3: gadget: don't issue End Transfer if we have started reqs
      usb: dwc3: gadget: always start isochronous aligned to dep->interval
      usb: dwc3: gadget: assign resource_index inside get_transfer_index()
      usb: dwc3: gadget: initialize transfer index from send_gadget_ep_cmd()
      usb: dwc3: gadget: init req->{direction,epnum} from alloc_request()

Florian Zumbiehl (1):
      USB: serial: pl2303: add support for tx xon/xoff flow control

Geert Uytterhoeven (1):
      usb: Remove depends on HAS_DMA in case of platform dependency

Giuseppe Lippolis (1):
      USB: serial: option: blacklist unused dwm-158 interfaces

Greg Kroah-Hartman (30):
      typec: tcpm: fix compiler warning about stupid things
      Merge 4.17-rc3 into usb-next
      Merge 4.17-rc4 into usb-next
      Merge 4.17-rc6 into usb-next
      Merge tag 'usb-for-v4.18' of git://git.kernel.org/.../balbi/usb into usb-next
      Merge tag 'phy-for-4.18' of git://git.kernel.org/.../kishon/linux-phy into usb-next
      Merge tag 'usb-serial-4.18-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next
      NFC: pn533: don't send USB data off of the stack
      USB: typec: tcpm: no need to check return value of debugfs_create_dir()
      USB: musb: clean up debugfs file and directory creation
      USB: mtu3: no need to check return value of debugfs_create_dir()
      USB: mon: no need to check return value of debugfs_create functions
      USB: uhci: no need to check return value of debugfs_create functions
      USB: ohci: no need to check return value of debugfs_create functions
      USB: isp116x-hcd: no need to check return value of debugfs_create functions
      USB: imx21-hcd: no need to check return value of debugfs_create functions
      USB: fotg210-hcd: no need to check return value of debugfs_create functions
      USB: fhci-hcd: no need to check return value of debugfs_create functions
      USB: ehci-hcd: no need to check return value of debugfs_create functions
      USB: chipidea: no need to check return value of debugfs_create functions
      USB: core: no need to check return value of debugfs_create functions
      USB: dwc2: no need to check return value of debugfs_create functions
      USB: dwc3: no need to check return value of debugfs_create functions
      USB: udc: atmel_usba_udc: no need to check return value of debugfs_create functions
      USB: gadget: udc: bcm63xx_udc: no need to check return value of debugfs_create functions
      USB: gadget: udc: gr_udc: no need to check return value of debugfs_create functions
      USB: gadget: udc: pxa27x_udc: no need to check return value of debugfs_create functions
      USB: gadget: udc: renesas_usb3: no need to check return value of debugfs_create functions
      USB: gadget: udc: s3c2410_udc: no need to check return value of debugfs_create functions
      USB: typec: fsusb302: no need to check return value of debugfs_create_dir()

Gregory CLEMENT (2):
      usb: host: xhci-plat: Remove useless test before clk_disable_unprepare
      usb: host: xhci-plat: Fix clock resource by adding a register clock

Grigor Tovmasyan (3):
      usb: dwc2: Add Interpacket Gap(IPG) feature support
      usb: dwc2: Fix kernel doc's warnings.
      usb: dwc2: gadget: Fix coverity issue

Guido Kiener (1):
      usb: usbtmc: Remove rigol_quirk

Gustavo A. R. Silva (3):
      usb: core: hcd: mark expected switch fall-through
      typec: tcpm: Fix incorrect 'and' operator
      usbip: vhci_sysfs: fix potential Spectre v1

Heikki Krogerus (6):
      usb: typec: Fix htmldocs warning
      usb: roles: intel_xhci: Always allow user control
      platform: x86: intel_cht_int33fe: Fix dependencies
      usb: typec: fusb302: Fix debugfs issue
      usb: roles: intel_xhci: Enable runtime PM
      usb: typec: wcove: Remove dependency on HW FSM

Icenowy Zheng (1):
      usb: dwc3: of-simple: Add compatible for Allwinner H6 platform

Jerry Zhang (2):
      usb: gadget: f_midi: Use refcount when freeing f_midi_opts
      usb: gadget: f_fs: Add compat_ioctl to epfiles

Jia-Ju Bai (3):
      usb: storage: Replace mdelay with msleep in init_freecom
      usb: isp1760: Replace mdelay with msleep in isp1760_init_core
      usb: isp1760: Replace mdelay with msleep in isp1760_stop

Jianguo Sun (2):
      dt-bindings: usb: add bindings doc for HiSilicon STB xHCI host controller
      xhci: hisilicon: support HiSilicon STB xHCI host controller

Joel Pepper (1):
      usb: gadget: composite Allow for larger configuration descriptors

Johan Hovold (13):
      USB: phy: drop unused legacy controller-phy bind helper
      USB: core: hcd: drop support for legacy phys
      USB: ehci-omap: drop unused legacy phy support
      USB: musb: omap2430: drop non-DT support
      USB: renesas_usbhs: drop unused legacy-phy support
      USB: phy: drop legacy board-file support
      USB: serial: use tty_port_register_device()
      USB: serial: ftdi_sio: fix IXON/IXOFF mixup
      USB: serial: ftdi_sio: use non-underscore fixed types
      USB: serial: ftdi_sio: drop unnecessary urb_ variable prefixes
      USB: serial: ftdi_sio: clean up flow control management
      tty: add missing const to termios hw-change helper
      USB: musb: dsps: propagate device-tree node

John Greb (1):
      USB: Gadget Ethernet: Re-enable Jumbo frames.

John Stultz (1):
      usb: dwc2: Fix HiKey regression caused by power_down feature

Jon Hunter (4):
      usb: xhci: tegra: Prepare for adding runtime PM support
      usb: xhci: tegra: Add runtime PM support
      usb: xhci: tegra: Add support for managing powergates
      usb: xhci: tegra: Fix runtime PM support

Li Jun (5):
      usb: typec: tcpm: pdo matching optimization
      usb: typec: fusb302: remove max_snk_* for sink config
      dt-bindings: usb: fusb302: remove max-sink-* properties
      usb: typec: wcove: remove max_snk_* for sink config
      usb: typec: tcpm: remove max_snk_mv/ma/mw

Lu Baolu (1):
      usb: xhci: dbc: Add SPDX identifiers to dbc files

Luc Van Oostenryck (1):
      usb: gadget: f_phonet: fix pn_net_xmit()'s return type

Lukasz Nowak (1):
      usb: gadget: f_ecm: fix host mac address for multiple instances

Manu Gautam (10):
      phy: core: Allow phy_pm_runtime_xxx API calls with NULL phy
      dt-bindings: usb: Update documentation for Qualcomm DWC3 driver
      usb: dwc3: Add Qualcomm DWC3 glue driver
      usb: dwc3: core: Suspend PHYs on runtime suspend in host mode
      phy: qcom-qmp: Enable pipe_clk before PHY initialization
      phy: qcom-qusb2: Fix crash if nvmem cell not specified
      dt-bindings: phy-qcom-qmp: Update bindings for sdm845
      phy: qcom-qmp: Add QMP V3 USB3 UNI PHY support for sdm845
      dt-bindings: phy-qcom-usb2: Add support to override tuning values
      phy: qcom-qusb2: Add QUSB2 PHYs support for sdm845

Marc Zyngier (3):
      xhci: Allow more than 32 quirks
      xhci: Add quirk to zero 64bit registers on Renesas PCIe controllers
      Revert "xhci: Reset Renesas uPD72020x USB controller for 32-bit DMA issue"

Masahiro Yamada (2):
      usb: dwc3: use local copy of resource to fix-up register offset
      usb: dwc3: support clocks and resets for DWC3 core

Mathias Nyman (21):
      usb: define HCD_USB32 speed option for hosts that support USB 3.2 dual-lane
      USB: Add support to store lane count used by USB 3.2
      usb: set root hub lane counts
      USB: show USB 3.2 Dual-lane devices as Gen Xx2 during device enumeration
      USB: USB 3.2 Add sysfs entries for a usb device rx_lanes and tx_lanes
      Documentation sysfs-bus-usb: Add rx_lanes and tx_lanes introduced in USB 3.2
      xhci: Create new structures to store xhci port information
      xhci: set hcd pointers for xhci usb2 and usb3 roothub structures
      xhci: Add helper to get xhci roothub from hcd
      xhci: xhci-hub: use new port structures to get port address instead of port array
      xhci: xhci-hub: use new port structures for cas and wake mask functions.
      xhci: xhci-ring: use port structures for port event handler
      xhci: rename faked_port_index to hcd_portnum
      xhci: change xhci_set_link_state() to work with port structures
      xhci: change xhci_test_and_clear_bit() to use new port structure
      xhci: use port structures instead of port arrays in xhci.c functions
      xhci: xhci-hub: use port structure members instead of xhci_get_ports()
      xhci-mtk: use xhci hub structures to get number of ports in roothubs
      xhci: xhci-mem: remove port_arrays and the code initializing them
      xhci: debugfs: add usb ports to xhci debugfs
      xhci: debugfs: add debugfs interface to enable compliance mode for a port

Maxim Moseychuk (1):
      usb: do not reset if a low-speed or full-speed device timed out

Mayank Rana (1):
      usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue

Michael Grzeschik (1):
      usbip: dynamically allocate idev by nports found in sysfs

Michel Pollet (1):
      USB: rndis: Fix for handling garbled messages

Minas Harutyunyan (2):
      usb: dwc2: Change ISOC DDMA flow
      usb: dwc2: Enable BNA interrupt for IN endpoints

Nicolas Boichat (2):
      usb: hub: Per-port setting to use old enumeration scheme
      usb: hub: Per-port setting to reduce TRSTRCY to 10 ms

Nikhil Badola (1):
      usb: gadget: fsl: Introduce FSL_USB2_PHY_UTMI_DUAL for usb gadget

Prasanthi Chellakumar (1):
      usb: host: ohci: fix sfr kernel warning in ohci-at91 driver

Romain Izard (3):
      usb: gadget: udc: atmel: GPIO inversion is handled by gpiod
      usb: gadget: udc: atmel: Remove obsolete include
      usb: gadget: udc: atmel: Fix indenting

Ruslan Bilovol (1):
      usb: core: message: remove extra endianness conversion in usb_set_isoch_delay

ShuFan Lee (2):
      staging: typec: rt1711h typec chip driver
      dt-bindings: usb: rt1711h device tree binding document

Shuah Khan (1):
      usbip: usbip_host: refine probe and disconnect debug msgs to be useful

Shuah Khan (Samsung OSG) (5):
      usbip: usbip_host: delete device from busid_table after rebind
      usbip: usbip_host: run rebind from exit when module is removed
      usbip: usbip_detach: Fix memory, udev context and udev leak
      usbip: usbip_detach: fix to check for invalid ports
      selftests: add test for USB over IP driver

Souptick Joarder (1):
      usb: mon: Change return type to vm_fault_t

Stefan Wahren (1):
      usb: dwc2: debugfs: Don't touch RX FIFO during register dump

Sylwester Nawrocki (1):
      phy: exynos-mipi-video: Simplify code by using regmap_update_bits()

Takashi Iwai (1):
      usb: audio-v2: Correct the comment for struct uac_clock_selector_descriptor

Tomeu Vizoso (1):
      usb: dwc2: dwc2_vbus_supply_init: fix error check

Tony Lindgren (1):
      phy: mapphone-mdm6600: Add runtime PM support for n_gsm on USB suspend

Wei Yongjun (3):
      usb: roles: Fix potential NULL dereference in intel_xhci_usb_probe()
      usb: dwc2: pci: Fix error return code in dwc2_pci_probe()
      usb: dwc3: gadget: dwc3_gadget_del_and_unmap_request() can be static

Wolfram Sang (4):
      usb: phy: simplify getting .drvdata
      usb: mtu3: simplify getting .drvdata
      usb: mtu3: simplify getting .drvdata
      usb: phy: simplify getting .drvdata

Yoshihiro Shimoda (7):
      usb: gadget: udc: renesas_usb3: should remove debugfs
      usb: gadget: udc: renesas_usb3: should call pm_runtime_enable() before add udc
      usb: gadget: udc: renesas_usb3: should call devm_phy_get() before add udc
      usb: gadget: udc: renesas_usb3: should fail if devm_phy_get() returns error
      usb: gadget: udc: renesas_usb3: disable the controller's irqs for reconnecting
      usb: gadget: udc: renesas_usb3: fix double phy_put()
      usb: gadget: function: printer: avoid wrong list handling in printer_write()

Yossi Mansharoff (1):
      doc: usb: ci-hdrc-usb2: Add property "mux-controls"

kbuild test robot (1):
      usb: dwc3: dwc3_get_extcon() can be static

 Documentation/ABI/testing/sysfs-bus-usb            |   40 +
 Documentation/ABI/testing/sysfs-class-power        |  455 +++++++++
 .../devicetree/bindings/phy/phy-mtk-xsphy.txt      |  109 ++
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |    3 +-
 .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |   23 +-
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |    6 +
 Documentation/devicetree/bindings/usb/dwc3.txt     |   21 +
 .../devicetree/bindings/usb/fcs,fusb302.txt        |    6 -
 .../bindings/usb/hisilicon,histb-xhci.txt          |   45 +
 .../devicetree/bindings/usb/qcom,dwc3.txt          |   85 +-
 .../devicetree/bindings/usb/richtek,rt1711h.txt    |   17 +
 Documentation/driver-api/usb/dwc3.rst              |    3 +-
 MAINTAINERS                                        |   10 +
 drivers/i2c/busses/Kconfig                         |    3 +-
 drivers/nfc/pn533/usb.c                            |   42 +-
 drivers/phy/mediatek/Kconfig                       |    9 +
 drivers/phy/mediatek/Makefile                      |    1 +
 drivers/phy/mediatek/phy-mtk-xsphy.c               |  600 +++++++++++
 drivers/phy/motorola/phy-mapphone-mdm6600.c        |   85 ++
 drivers/phy/phy-core.c                             |   18 +
 drivers/phy/qualcomm/Kconfig                       |   11 +-
 drivers/phy/qualcomm/Makefile                      |    1 +
 drivers/phy/qualcomm/phy-ath79-usb.c               |  108 ++
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  169 ++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |    5 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |  130 ++-
 drivers/phy/samsung/phy-exynos-mipi-video.c        |   34 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |    9 +-
 drivers/phy/tegra/xusb.c                           |   15 +-
 drivers/platform/x86/Kconfig                       |    4 +-
 drivers/power/supply/power_supply_core.c           |   15 +-
 drivers/power/supply/power_supply_sysfs.c          |   45 +
 drivers/staging/typec/Kconfig                      |    8 +
 drivers/staging/typec/Makefile                     |    1 +
 drivers/staging/typec/tcpci.h                      |    1 +
 drivers/staging/typec/tcpci_rt1711h.c              |  312 ++++++
 drivers/tty/tty_ioctl.c                            |    2 +-
 drivers/usb/chipidea/ci.h                          |    2 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |    3 +-
 drivers/usb/chipidea/core.c                        |    4 +-
 drivers/usb/chipidea/debug.c                       |   56 +-
 drivers/usb/class/usbtmc.c                         |   81 +-
 drivers/usb/core/hcd.c                             |   49 +-
 drivers/usb/core/hub.c                             |   42 +-
 drivers/usb/core/hub.h                             |    1 +
 drivers/usb/core/message.c                         |    2 +-
 drivers/usb/core/port.c                            |   23 +
 drivers/usb/core/sysfs.c                           |   22 +
 drivers/usb/core/usb.c                             |   26 +-
 drivers/usb/dwc2/core.c                            |    7 +
 drivers/usb/dwc2/core.h                            |  188 +++-
 drivers/usb/dwc2/core_intr.c                       |    8 +
 drivers/usb/dwc2/debug.h                           |    2 +-
 drivers/usb/dwc2/debugfs.c                         |  100 +-
 drivers/usb/dwc2/gadget.c                          |  334 +++---
 drivers/usb/dwc2/hcd.c                             |    3 +-
 drivers/usb/dwc2/hcd.h                             |   14 +-
 drivers/usb/dwc2/hcd_ddma.c                        |    1 +
 drivers/usb/dwc2/hcd_intr.c                        |   12 +
 drivers/usb/dwc2/hcd_queue.c                       |    5 +-
 drivers/usb/dwc2/hw.h                              |    2 +
 drivers/usb/dwc2/params.c                          |   14 +-
 drivers/usb/dwc2/pci.c                             |    6 +
 drivers/usb/dwc3/Kconfig                           |   12 +
 drivers/usb/dwc3/Makefile                          |    1 +
 drivers/usb/dwc3/core.c                            |  154 ++-
 drivers/usb/dwc3/core.h                            |   25 +-
 drivers/usb/dwc3/debug.h                           |   26 +-
 drivers/usb/dwc3/debugfs.c                         |   43 +-
 drivers/usb/dwc3/drd.c                             |   34 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |    2 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |  619 +++++++++++
 drivers/usb/dwc3/ep0.c                             |    6 +-
 drivers/usb/dwc3/gadget.c                          |  773 +++++++-------
 drivers/usb/dwc3/gadget.h                          |    5 +-
 drivers/usb/dwc3/trace.h                           |   12 +-
 drivers/usb/gadget/composite.c                     |    2 +-
 drivers/usb/gadget/function/f_ecm.c                |    3 +-
 drivers/usb/gadget/function/f_fs.c                 |   11 +
 drivers/usb/gadget/function/f_midi.c               |   26 +-
 drivers/usb/gadget/function/f_printer.c            |    6 +-
 drivers/usb/gadget/function/rndis.c                |    3 +
 drivers/usb/gadget/function/u_ether.c              |    4 +
 drivers/usb/gadget/udc/Kconfig                     |    6 +-
 drivers/usb/gadget/udc/Makefile                    |    1 +
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig         |    7 +
 drivers/usb/gadget/udc/aspeed-vhub/Makefile        |    4 +
 drivers/usb/gadget/udc/aspeed-vhub/core.c          |  425 ++++++++
 drivers/usb/gadget/udc/aspeed-vhub/dev.c           |  589 +++++++++++
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c           |  486 +++++++++
 drivers/usb/gadget/udc/aspeed-vhub/epn.c           |  843 +++++++++++++++
 drivers/usb/gadget/udc/aspeed-vhub/hub.c           |  829 +++++++++++++++
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h          |  514 ++++++++++
 drivers/usb/gadget/udc/atmel_usba_udc.c            |   93 +-
 drivers/usb/gadget/udc/atmel_usba_udc.h            |    5 -
 drivers/usb/gadget/udc/bcm63xx_udc.c               |   37 +-
 drivers/usb/gadget/udc/core.c                      |    6 +
 drivers/usb/gadget/udc/fsl_udc_core.c              |    1 +
 drivers/usb/gadget/udc/gr_udc.c                    |    7 +-
 drivers/usb/gadget/udc/gr_udc.h                    |    1 -
 drivers/usb/gadget/udc/pxa27x_udc.c                |   43 +-
 drivers/usb/gadget/udc/pxa27x_udc.h                |    3 -
 drivers/usb/gadget/udc/renesas_usb3.c              |   45 +-
 drivers/usb/gadget/udc/s3c2410_udc.c               |   17 +-
 drivers/usb/gadget/usbstring.c                     |    2 +-
 drivers/usb/host/Kconfig                           |   11 +-
 drivers/usb/host/Makefile                          |    1 +
 drivers/usb/host/ehci-dbg.c                        |   30 +-
 drivers/usb/host/ehci-hcd.c                        |    5 -
 drivers/usb/host/ehci-omap.c                       |    5 +-
 drivers/usb/host/ehci-tegra.c                      |   87 +-
 drivers/usb/host/fhci-dbg.c                        |   23 +-
 drivers/usb/host/fhci.h                            |    2 -
 drivers/usb/host/fotg210-hcd.c                     |   34 +-
 drivers/usb/host/imx21-dbg.c                       |   44 +-
 drivers/usb/host/isp116x-hcd.c                     |   17 +-
 drivers/usb/host/ohci-at91.c                       |    2 +-
 drivers/usb/host/ohci-dbg.c                        |   45 +-
 drivers/usb/host/ohci-hcd.c                        |    5 -
 drivers/usb/host/ohci.h                            |    3 -
 drivers/usb/host/pci-quirks.c                      |   20 -
 drivers/usb/host/pci-quirks.h                      |    1 -
 drivers/usb/host/uhci-hcd.c                        |   15 +-
 drivers/usb/host/xhci-dbgcap.c                     |    1 +
 drivers/usb/host/xhci-dbgcap.h                     |    2 +-
 drivers/usb/host/xhci-dbgtty.c                     |    1 +
 drivers/usb/host/xhci-debugfs.c                    |   85 ++
 drivers/usb/host/xhci-histb.c                      |  410 ++++++++
 drivers/usb/host/xhci-hub.c                        |  244 ++---
 drivers/usb/host/xhci-mem.c                        |  193 ++--
 drivers/usb/host/xhci-mtk-sch.c                    |    4 +-
 drivers/usb/host/xhci-pci.c                        |   15 +-
 drivers/usb/host/xhci-ring.c                       |  126 +--
 drivers/usb/host/xhci-tegra.c                      |  176 +++-
 drivers/usb/host/xhci.c                            |  123 ++-
 drivers/usb/host/xhci.h                            |  106 +-
 drivers/usb/isp1760/isp1760-core.c                 |    2 +-
 drivers/usb/isp1760/isp1760-hcd.c                  |    2 +-
 drivers/usb/misc/sisusbvga/sisusb.c                |    2 +-
 drivers/usb/mon/mon_bin.c                          |    2 +-
 drivers/usb/mon/mon_text.c                         |   37 +-
 drivers/usb/mtu3/Kconfig                           |    3 +-
 drivers/usb/mtu3/mtu3.h                            |   15 +-
 drivers/usb/mtu3/mtu3_core.c                       |   26 +-
 drivers/usb/mtu3/mtu3_dr.c                         |   73 +-
 drivers/usb/mtu3/mtu3_gadget.c                     |    9 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c                 |   12 +-
 drivers/usb/mtu3/mtu3_plat.c                       |    6 +-
 drivers/usb/musb/am35x.c                           |    3 -
 drivers/usb/musb/da8xx.c                           |    3 -
 drivers/usb/musb/davinci.c                         |   49 +-
 drivers/usb/musb/musb_core.c                       |  838 +++++++--------
 drivers/usb/musb/musb_core.h                       |   16 +-
 drivers/usb/musb/musb_cppi41.c                     |    4 +-
 drivers/usb/musb/musb_debug.h                      |    5 +-
 drivers/usb/musb/musb_debugfs.c                    |   44 +-
 drivers/usb/musb/musb_dma.h                        |   10 +-
 drivers/usb/musb/musb_dsps.c                       |   39 +-
 drivers/usb/musb/musb_gadget.c                     |    8 +-
 drivers/usb/musb/musb_gadget.h                     |   10 +-
 drivers/usb/musb/musb_host.c                       |    8 +-
 drivers/usb/musb/musb_io.h                         |    6 +-
 drivers/usb/musb/musb_regs.h                       |   55 -
 drivers/usb/musb/musb_virthub.c                    |    2 +-
 drivers/usb/musb/musbhsdma.c                       |   74 +-
 drivers/usb/musb/musbhsdma.h                       |   72 --
 drivers/usb/musb/omap2430.c                        |  100 +-
 drivers/usb/musb/sunxi.c                           |   14 +-
 drivers/usb/musb/ux500.c                           |    2 -
 drivers/usb/phy/Kconfig                            |   10 +
 drivers/usb/phy/Makefile                           |    2 +-
 drivers/usb/phy/phy-am335x.c                       |    6 +-
 drivers/usb/phy/phy-tegra-usb.c                    |  140 ++-
 drivers/usb/phy/phy.c                              |  133 +--
 drivers/usb/renesas_usbhs/common.h                 |    1 -
 drivers/usb/renesas_usbhs/rcar2.c                  |   29 -
 drivers/usb/roles/intel-xhci-usb-role-switch.c     |   39 +-
 drivers/usb/serial/bus.c                           |    3 +-
 drivers/usb/serial/ftdi_sio.c                      |  194 ++--
 drivers/usb/serial/option.c                        |    3 +-
 drivers/usb/serial/pl2303.c                        |   16 +-
 drivers/usb/serial/usb-serial.c                    |    2 +-
 drivers/usb/storage/freecom.c                      |    4 +-
 drivers/usb/storage/uas.c                          |    6 +
 drivers/usb/storage/unusual_devs.h                 |    9 +
 drivers/usb/storage/unusual_uas.h                  |    9 +
 drivers/usb/typec/Kconfig                          |    1 +
 drivers/usb/typec/fusb302/Kconfig                  |    2 +-
 drivers/usb/typec/fusb302/fusb302.c                |  121 +--
 drivers/usb/typec/mux.c                            |    2 +-
 drivers/usb/typec/tcpm.c                           | 1072 ++++++++++++++++++--
 drivers/usb/typec/typec_wcove.c                    |   34 +-
 drivers/usb/usbip/vhci_sysfs.c                     |   24 +-
 include/dt-bindings/phy/phy-qcom-qusb2.h           |   37 +
 include/linux/power_supply.h                       |   18 +
 include/linux/tty.h                                |    2 +-
 include/linux/usb.h                                |   14 +
 include/linux/usb/atmel_usba_udc.h                 |   24 -
 include/linux/usb/audio-v2.h                       |    2 +-
 include/linux/usb/gadget.h                         |    2 +-
 include/linux/usb/hcd.h                            |    2 +-
 include/linux/usb/musb.h                           |   15 -
 include/linux/usb/pd.h                             |    4 +-
 include/linux/usb/phy.h                            |   36 -
 include/linux/usb/tcpm.h                           |   10 +-
 include/linux/usb/tegra_usb_phy.h                  |    2 +
 include/uapi/linux/usb/ch11.h                      |    5 +
 .../selftests/drivers/usb/usbip/usbip_test.sh      |  198 ++++
 tools/usb/usbip/libsrc/vhci_driver.c               |   32 +-
 tools/usb/usbip/libsrc/vhci_driver.h               |    3 +-
 tools/usb/usbip/src/usbip_detach.c                 |   46 +-
 211 files changed, 11404 insertions(+), 3486 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
 create mode 100644 Documentation/devicetree/bindings/usb/hisilicon,histb-xhci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
 create mode 100644 drivers/phy/mediatek/phy-mtk-xsphy.c
 create mode 100644 drivers/phy/qualcomm/phy-ath79-usb.c
 create mode 100644 drivers/staging/typec/tcpci_rt1711h.c
 create mode 100644 drivers/usb/dwc3/dwc3-qcom.c
 create mode 100644 drivers/usb/gadget/udc/aspeed-vhub/Kconfig
 create mode 100644 drivers/usb/gadget/udc/aspeed-vhub/Makefile
 create mode 100644 drivers/usb/gadget/udc/aspeed-vhub/core.c
 create mode 100644 drivers/usb/gadget/udc/aspeed-vhub/dev.c
 create mode 100644 drivers/usb/gadget/udc/aspeed-vhub/ep0.c
 create mode 100644 drivers/usb/gadget/udc/aspeed-vhub/epn.c
 create mode 100644 drivers/usb/gadget/udc/aspeed-vhub/hub.c
 create mode 100644 drivers/usb/gadget/udc/aspeed-vhub/vhub.h
 create mode 100644 drivers/usb/host/xhci-histb.c
 delete mode 100644 drivers/usb/musb/musbhsdma.h
 create mode 100644 include/dt-bindings/phy/phy-qcom-qusb2.h
 delete mode 100644 include/linux/usb/atmel_usba_udc.h
 create mode 100755 tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
