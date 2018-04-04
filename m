Date: Wed, 4 Apr 2018 12:31:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY driver patches for 4.17-rc1
Message-ID: <20180404103121.GA7420@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit c698ca5278934c0ae32297a8725ced2e27585d7f:

  Linux 4.16-rc6 (2018-03-18 17:48:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/ tags/usb-4.17-rc1

for you to fetch changes up to 5267c5e09c25e2ee6242b37833a9bdf9d97f54a2:

  Revert "USB: serial: ftdi_sio: add Id for Physik Instrumente E-870" (2018-03-29 18:37:28 +0200)

----------------------------------------------------------------
USB/PHY patches for 4.17-rc1

Here is the big set of USB and PHY driver patches for 4.17-rc1.

Lots of USB typeC work happened this round, with code moving from the
staging directory into the "real" part of the kernel, as well as new
infrastructure being added to be able to handle the different types of
"roles" that typeC requires.

There is also the normal huge set of USB gadget controller and driver
updates, along with XHCI changes, and a raft of other tiny fixes all
over the USB tree.  And the PHY driver updates are merged in here as
well as they interacted with the USB drivers in some places.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Thomson (3):
      typec: tcpm: Add PD Rev 3.0 definitions to PD header
      typec: tcpm: Add ADO header for Alert message handling
      typec: tcpm: Add SDB header for Status message handling

Alban Bedel (1):
      usb: host: Remove the deprecated ATH79 USB host config options

Alex Hung (1):
      usb: clarify ACPI spec version and section number for _UPC & _PLD

Alexander Monakov (1):
      phy: berlin-usb: adjust USB_PHY_RX_CTRL init flags

Alexey Khoroshilov (1):
      phy: lpc18xx-usb-otg: error handling in lpc18xx_usb_otg_phy_power_on()

Amelie Delaunay (3):
      usb: dwc2: add support for host mode external vbus supply
      dt-bindings: phy: add support for STM32 USB PHY Controller (USBPHYC)
      phy: stm32: add support for STM32 USB PHY Controller (USBPHYC)

Andy Shevchenko (19):
      USB: dwc2: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: gadget: bcm63xx: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: gadget: gr: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: gadget: pxa25x: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: gadget: pxa27x: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: chipidea: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: dwc2: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: musb: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: gadget: bcm63xx: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: gadget: gr: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: gadget: pxa25x: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: gadget: pxa27x: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: host: fhci: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: host: imx21: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: host: isp116x: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: host: whci: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: typec: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      uwb: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      USB: host: sl811: Re-use DEFINE_SHOW_ATTRIBUTE() macro

Ben Hutchings (1):
      usbip: Correct maximum value of CONFIG_USBIP_VHCI_HC_PORTS

Benjamin Herrenschmidt (1):
      usb/gadget: Add an EP dispose() callback for EP lifetime tracking

Benson Leung (1):
      USB: announce bcdDevice as well as idVendor, idProduct.

Chen-Yu Tsai (1):
      phy: allwinner: sun4i-usb: poll vbus changes on A23/A33 when driving VBUS

Chris Dickens (2):
      usb: gadget: composite: fix incorrect handling of OS desc requests
      usb: gadget: composite: remove duplicated code in OS desc handling

Chris Zhong (2):
      phy: rockchip-typec: force to USB2 if DP at 4 lanes mode
      phy: rockchip-typec: support DP phy switch

Chunfeng Yun (4):
      phy: phy-mtk-tphy: keep default value of mcu_bus_ck_gate_en
      phy: phy-mtk-tphy: add configurable parameters for slew rate calibrate
      dt-bindings: phy-mtk-tphy: add properties for U2 slew rate calibrate
      usb: skip phys initialization of shared hcd

Clemens Werther (1):
      USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator

Colin Ian King (4):
      phy: tegra: remove redundant self assignment of 'map'
      USB: gadget: function: remove redundant initialization of 'tv_nexus'
      USB: wusbcore: remove redundant re-assignment to pointer 'dev'
      usb: dwc2: fix spelling mistake: "genereted" -> "generated"

Dan Carpenter (1):
      usb: xhci: Clean up error code in xhci_dbc_tty_register_device()

Daniel Gimpelevich (1):
      USB: misc: uss720: more vendor/product ID's

Dmitry Osipenko (1):
      usb: phy: tegra: Increase PHY clock stabilization timeout

Dov Levenglick (1):
      phy: fix structure documentation

Enric Balletbo i Serra (4):
      phy: rockchip-typec: deprecate some DT properties for various register fields.
      dt-bindings: phy-rockchip-typec: deprecate some register properties.
      dt-bindings: phy-rockchip-typec: move extcon property to be optional.
      phy: rockchip-typec: fall back to working in host-mode if extcon is missing.

Fabio Estevam (1):
      usb: phy: mxs: Staticize mxs_charger_secondary_detection()

Felipe Balbi (4):
      usb: dwc3: debugfs: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      usb: dwc3: Makefile: fix link error on randconfig
      usb: gadget: udc: core: update usb_ep_queue() documentation
      usb: dwc3: gadget: never call ->complete() from ->ep_queue()

Gevorg Sahakyan (1):
      usb: dwc2: Remove version check in GSNPSID

Greg Kroah-Hartman (6):
      Merge 4.16-rc3 into usb-next
      Revert "usb: core: Add "quirks" parameter for usbcore"
      Merge branch 4.16-rc6 into usb-next
      Merge tag 'phy-for-4.17' of git://git.kernel.org/.../kishon/linux-phy into usb-next
      Merge tag 'usb-for-v4.17' of git://git.kernel.org/.../balbi/usb into usb-testing
      Merge tag 'usb-serial-4.17-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next

Grigor Tovmasyan (5):
      usb: dwc2: Delete unused functionality
      usb: dwc2: Fix interval type issue
      usb: dwc2: Add call_gadget() function call
      usb: dwc2: Add core state checking
      usb: dwc2: Make dwc2_force_mode() static

Gustavo A. R. Silva (2):
      usb: dwc2: gadget: Use true and false for boolean values
      USB: wusbcore: crypto: Remove VLA usage

Hans de Goede (7):
      usb: typec: tcpm: Set USB role switch to device mode when configured as such
      usb: typec: tcpm: Use new Type-C switch/mux and usb-role-switch functions
      xhci: Add Intel extended cap / otg phy mux handling
      usb: roles: Add Intel xHCI USB role switch driver
      usb: typec: driver for Pericom PI3USB30532 Type-C cross switch
      platform/x86: intel_cht_int33fe: Add device connections for the Type-C port
      extcon: axp288: Set USB role where necessary

Heikki Krogerus (5):
      usb: typec: Start using ERR_PTR
      drivers: base: Unified device connection lookup
      usb: typec: API for controlling USB Type-C Multiplexers
      usb: common: Small class for USB role switches
      usb: typec: Separate the definitions for data and power roles

Heinrich Schuchardt (2):
      usb: dwc3: ep0: remove redundant assignment
      usb: musb: gadget: misplaced out of bounds check

Himanshu Jha (1):
      usb: isp1760: Use kasprintf

Icenowy Zheng (1):
      phy: sun4i-usb: add support for R40 USB PHY

Jaejoong Kim (1):
      usb: gadget: udc: Use scnprintf() instead of snprintf()

Jianguo Sun (2):
      dt-bindings: add bindings doc for hi3798cv200 combphy
      phy: add combo phy driver for HiSilicon STB SoCs

Johan Hovold (5):
      USB: serial: option: reimplement interface masking
      USB: serial: option: drop redundant interface-class test
      USB: serial: option: use mass-storage class define
      USB: serial: cp210x: add ELDAT Easywave RX09 id
      Revert "USB: serial: ftdi_sio: add Id for Physik Instrumente E-870"

John Youn (3):
      usb: dwc2: Enable LPM
      usb: dwc2: Enable power down
      MAINTAINERS: Update maintainer for dwc2

Kai-Heng Feng (4):
      usb: core: Add "quirks" parameter for usbcore
      usb: core: Add "quirks" parameter for usbcore
      usb: core: Copy parameter string correctly and remove superfluous null check
      usb: core: Add USB_QUIRK_DELAY_CTRL_MSG to usbcore quirks

Kees Cook (1):
      USB: chaoskey: Use kasprintf() over strcpy()/strcat()

Kirill Kapranov (2):
      USB: adutux: Delete a misleading comment
      USB: adutux: Add waiting in transfer abortion

Ladislav Michl (1):
      usb: gadget: udc: atmel: Use devm_ioremap_resource()

Lars-Peter Clausen (2):
      usb: gadget: ffs: Execute copy_to_user() with USER_DS set
      usb: gadget: ffs: Let setup() return USB_GADGET_DELAYED_STATUS

Linus Walleij (2):
      usb: phy: ab8500: Drop AB8540/9540 support
      usb: phy: ab8500: Drop AB8540/9540 support

Lu Baolu (2):
      usb: xhci: Remove ep_trb from xhci_cleanup_halted_endpoint()
      usb: xhci: Remove ep_trb from finish_td()

Ludovic Desroches (2):
      usb: gadget: udc: atmel: remove code related to platform stuff
      usb: gadget: udc: atmel: convert to use GPIO descriptors

Major Hayden (1):
      USB: serial: ftdi_sio: add RT Systems VX-8 cable

Manu Gautam (15):
      phy: qcom-qmp: Power-on PHY before initialization
      phy: qcom-qusb2: Power-on PHY before initialization
      phy: qcom-qmp: Fix PHY block reset sequence
      phy: qcom-qmp: Move SERDES/PCS START after PHY reset
      phy: qcom-qusb2: Add support for different register layouts
      dt-bindings: phy-qcom-qusb2: Update binding for QUSB2 V2 version
      phy: qcom-qusb2: Add support for QUSB2 V2 version
      phy: qcom-qmp: Move register offsets to header file
      phy: qcom-qmp: Add register offsets for QMP V3 PHY
      dt-bindings: phy-qcom-qmp: Update bindings for QMP V3 USB PHY
      phy: qcom-qmp: Add support for QMP V3 USB3 PHY
      phy: Add USB speed related PHY modes
      phy: qcom-qusb2: Add support for runtime PM
      phy: qcom-qmp: Add support for runtime PM
      phy: add SPDX identifier to QMP and QUSB2 PHY drivers

Marcus Folkesson (1):
      usb: usb-skeleton: make MODULE_LICENSE and SPDX tag match

Martin Blumenstingl (18):
      dt-bindings: phy: meson-gxl-usb2-phy: add the reset line and clock
      phy: amlogic: phy-meson-gxl-usb2: don't log an error on -EPROBE_DEFER
      phy: amlogic: phy-meson-gxl-usb2: support the clock and reset line
      phy: amlogic: phy-meson-gxl-usb2: default to host mode
      phy: amlogic: phy-meson-gxl-usb2: rename some of the U2P_R2 registers
      dt-bindings: usb: add the documentation for USB HCDs
      usb: add a flag to skip PHY initialization to struct usb_hcd
      usb: core: add a wrapper for the USB PHYs on the HCD
      usb: core: hcd: integrate the PHY wrapper into the HCD core
      usb: host: xhci-mtk: remove custom USB PHY handling
      usb: host: ehci-platform: remove custom USB PHY handling
      usb: host: ohci-platform: remove custom USB PHY handling
      usb: core: hcd: remove support for initializing a single PHY
      dt-bindings: usb: add support for dwc3 controller on Amlogic Meson GX
      usb: dwc3: of-simple: add support for shared and pulsed reset lines
      usb: dwc3: of-simple: add support for the Amlogic Meson GXL and AXG SoCs
      dt-bindings: phy: Add support for the USB3 PHY on Amlogic Meson GXL SoCs
      phy: amlogic: add USB3 PHY support for Meson GXL and GXM

Masahiro Yamada (1):
      phy: add 'depends on HAS_IOMEM' to fix unmet dependency

Mathias Nyman (7):
      usb: Don't disable Latency tolerance Messaging (LTM) before port reset
      xhci: zero usb device slot_id member when disabling and freeing a xhci slot
      xhci: Don't always run the default stop endpoint command completion handler
      xhci: refactor xhci_urb_enqueue a bit with minor changes
      xhci: Clear the host side toggle manually when endpoint is soft reset
      xhci: Show what USB release number the xHC supports from protocol capablity
      xhci: Add option to get next extended capability in list by passing id = 0

Michael Trimarchi (3):
      usb: chipidea: usbmisc: evdo is only specific to OTG port
      usb: chipidea: usbmisc: evdo can be set e/o reset
      usb: chipidea: usbmisc: small clean up

Mike Looijmans (1):
      usb: phy-generic: Use gpiod_set_value_cansleep

Minas Harutyunyan (3):
      usb: dwc2: hcd: Fix host channel halt flow
      usb: dwc2: host: Fix transaction errors in host mode
      usb: dwc2: Change TxFIFO and RxFIFO flushing flow

Pengcheng Li (2):
      dt-bindings: add bindings doc for HiSilicon INNO USB2 PHY
      phy: add inno-usb2-phy driver for hi3798cv200 SoC

Razmik Karapetyan (9):
      usb: dwc2: Use AHB burst size parameter
      usb: dwc2: Set AHB burst size to INCR
      usb: dwc2: Update dwc2_handle_incomplete_isoc_in() function
      usb: dwc2: Update dwc2_handle_incomplete_isoc_out() function
      usb: dwc2: Update GINTSTS_GOUTNAKEFF interrupt handling
      usb: dwc2: Rename bit set/clear function names
      usb: dwc2: Remove unnecessary debug prints
      usb: dwc2: Add ACG support to the driver
      usb: dwc2: Backup and restore PCGCCTL1 register

Richard Leitner (1):
      usb: core: introduce per-port over-current counters

Roger Quadros (5):
      usb: dwc3: core.h: add some register definitions
      usb: dwc3: prevent setting PRTCAP to OTG from debugfs
      usb: dwc3: add dual role support using OTG block
      usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
      usb: dwc3: core: Fix broken system suspend/resume on AM437x

Sebastian Reichel (2):
      usb: chipidea: imx: Cleanup ci_hdrc_imx_platform_flag
      usb: chipidea: imx: Fix ULPI on imx53

Sevak Arakelyan (7):
      usb: dwc2: Update bit polling functionality
      usb: dwc2: Rename GLPMCFG... definitions
      usb: dwc2: Add core parameters for LPM support
      usb: dwc2: gadget: Add functionality to exit from LPM L1 state
      usb: dwc2: gadget: LPM interrupt handler
      usb: dwc2: Enable LPM Transaction Received interrupt
      usb: dwc2: gadget: Configure the core to enable LPM

Shawn Guo (1):
      dt-bindings: hisilicon: add doc for Hi3798CV200 peripheral controller

Shawn Lin (2):
      phy: rockchip-emmc: retry calpad busy trimming
      phy: rockchip-emmc: use regmap_read_poll_timeout to poll dllrdy

ShuFan Lee (2):
      staging: typec: handle vendor defined part and modify drp toggling flow
      staging: typec: modify parameter of tcpci_irq

Shuah Khan (6):
      usbip: tools usbip_attach: Fix cryptic error messages
      usbip: tools usbip_network: Fix cryptic error messages
      usbip: tools: add more error codes for usbip request/reply messages
      usbip: usbip_host_common: Use new error codes to return request status
      usbip: tools: change to use new error codes in server reply messages
      usbip: tools: usbipd: exclude exported devices from exportable device list

Souptick Joarder (2):
      usb: host: ehci: Use dma_pool_zalloc()
      usb: gadget: udc: bdc: Use dma_pool_zalloc

Stefan Agner (1):
      usb: phy: ab8500: use correct enum type

Stefan Wahren (1):
      usb: dwc2: Print error if unable to set DMA coherent mask

Teichmann, Martin (1):
      USB: serial: ftdi_sio: add Id for Physik Instrumente E-870

Thierry Reding (1):
      phy: tegra: xusb: Uncomment register write

Thinh Nguyen (13):
      usb: gadget: mass_storage: Set max_speed to SSP
      usb: core: urb: Check SSP isoc ep comp descriptor
      usb: dwc3: pci: Properly cleanup resource
      usb: dwc3: Add SoftReset PHY synchonization delay
      usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields
      usb: dwc3: Check IP revision for GTXFIFOSIZ
      usb: dwc3: Add DWC_usb31 GRXTHRCFG bit fields
      usb: dwc3: gadget: Check IP revision for GRXTHRCFG
      usb: dwc3: Add DWC_usb31 GTXTHRCFG reg fields
      usb: dwc3: Make TX/RX threshold configurable
      usb: dwc3: Check for ESS TX/RX threshold config
      usb: dwc3: Dump LSP and BMU debug info
      usb: dwc3: Check controller type before setting speed

Tobin C. Harding (1):
      usb: usbtest: Remove stack VLA usage

Tomeu Vizoso (1):
      usb: hub: Reduce warning to notice on power loss

Tony Lindgren (1):
      phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on Droid 4

Ulf Magnusson (1):
      phy: Remove SOC_EXYNOS4212 dep. from PHY_EXYNOS4X12_USB

Vardan Mikayelyan (19):
      usb: dwc2: eliminate irq parameter from dwc2_gadget_init
      usb: dwc2: pci: Replace kzalloc() with devm_kzalloc()
      usb: dwc2: pci: Move usb_phy_generic_register()
      usb: dwc2: pci: Move devm_kzalloc() before platform_device_add()
      usb: dwc2: pci: Handle error cleanup in probe
      usb: dwc2: Rename hibernation to partial_power_down
      usb: dwc2: Add hibernation field into dwc2_hw_params
      usb: dwc2: gadget: Moved dtxfsiz backup array place
      usb: dwc2: gadget: Fix dwc2_restore_device_registers
      usb: dwc2: core: Add hibernated flag
      usb: dwc2: gadget: Add remote_wakeup_allowed flag
      usb: dwc2: Changes in registers backup/restore functions
      usb: dwc2: Add helper functions for restore routine
      usb: dwc2: Add host/device hibernation functions
      usb: dwc2: Add dwc2_enter_hibernation(), dwc2_exit_hibernation()
      usb: dwc2: Allow entering hibernation from USB_SUSPEND interrupt
      usb: dwc2: Add dwc2_handle_gpwrdn_intr() handler
      usb: dwc2: Change hub-control to allow hibernation
      usb: dwc2: Force mode optimizations

Vivek Gautam (2):
      phy: qcom-qmp: Fix phy pipe clock gating
      phy: qcom-qmp: Adapt to clk_bulk_* APIs

Wei Yongjun (1):
      usb: roles: Fix return value check in intel_xhci_usb_probe()

William wu (1):
      phy: rockchip-typec: enable usb3 host during usb3 phy power on

Wolfram Sang (1):
      usb: gadget: udc: change comparison to bitshift when dealing with a mask

Yavuz, Tuba (1):
      USB: gadget: f_midi: fixing a possible double-free in f_midi

Yoshihiro Shimoda (3):
      dt-bindings: rcar-gen3-phy-usb2: Add bindings for r8a77965
      phy: rcar-gen3-usb2: Add support for r8a77965
      dt-bindings: rcar-gen3-phy-usb3: Add bindings for r8a77965

Zhengjun Xing (1):
      USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw

 Documentation/ABI/testing/sysfs-bus-usb            |  10 +
 Documentation/ABI/testing/sysfs-class-usb_role     |  21 +
 Documentation/admin-guide/kernel-parameters.txt    |  58 ++
 .../bindings/arm/hisilicon/hisilicon.txt           |  23 +
 .../devicetree/bindings/phy/meson-gxl-usb2-phy.txt |   4 +
 .../devicetree/bindings/phy/meson-gxl-usb3-phy.txt |  31 +
 .../bindings/phy/phy-hi3798cv200-combphy.txt       |  59 ++
 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  71 +++
 .../bindings/phy/phy-mapphone-mdm6600.txt          |  29 +
 .../devicetree/bindings/phy/phy-mtk-tphy.txt       |   4 +
 .../devicetree/bindings/phy/phy-rockchip-typec.txt |  35 +-
 .../devicetree/bindings/phy/phy-stm32-usbphyc.txt  |  73 +++
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   6 +-
 .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |   5 +-
 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |   2 +
 .../devicetree/bindings/phy/rcar-gen3-phy-usb3.txt |   2 +
 .../devicetree/bindings/phy/sun4i-usb-phy.txt      |   1 +
 .../devicetree/bindings/usb/amlogic,dwc3.txt       |  42 ++
 Documentation/devicetree/bindings/usb/dwc3.txt     |  16 +
 .../devicetree/bindings/usb/mediatek,mtk-xhci.txt  |   5 +-
 .../devicetree/bindings/usb/mediatek,mtu3.txt      |   5 +-
 Documentation/devicetree/bindings/usb/usb-ehci.txt |   6 +-
 Documentation/devicetree/bindings/usb/usb-hcd.txt  |   9 +
 Documentation/devicetree/bindings/usb/usb-ohci.txt |   6 +-
 Documentation/devicetree/bindings/usb/usb-uhci.txt |   3 +
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   5 +
 Documentation/driver-api/device_connection.rst     |  43 ++
 Documentation/driver-api/usb/typec.rst             |  73 ++-
 MAINTAINERS                                        |  14 +-
 arch/mips/Kconfig                                  |   1 +
 drivers/base/Makefile                              |   3 +-
 drivers/base/devcon.c                              | 136 +++++
 drivers/extcon/Kconfig                             |   3 +-
 drivers/extcon/extcon-axp288.c                     | 176 +++++-
 drivers/phy/allwinner/phy-sun4i-usb.c              |  22 +-
 drivers/phy/amlogic/Kconfig                        |  13 +-
 drivers/phy/amlogic/Makefile                       |   1 +
 drivers/phy/amlogic/phy-meson-gxl-usb2.c           |  78 ++-
 drivers/phy/amlogic/phy-meson-gxl-usb3.c           | 282 +++++++++
 drivers/phy/hisilicon/Kconfig                      |  20 +
 drivers/phy/hisilicon/Makefile                     |   2 +
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         | 197 +++++++
 drivers/phy/hisilicon/phy-histb-combphy.c          | 289 +++++++++
 drivers/phy/marvell/phy-berlin-usb.c               |   2 +-
 drivers/phy/mediatek/phy-mtk-tphy.c                |  23 +-
 drivers/phy/motorola/Kconfig                       |   8 +
 drivers/phy/motorola/Makefile                      |   1 +
 drivers/phy/motorola/phy-mapphone-mdm6600.c        | 542 +++++++++++++++++
 drivers/phy/phy-core.c                             |   2 +
 drivers/phy/phy-lpc18xx-usb-otg.c                  |   8 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 647 ++++++++++++++-------
 drivers/phy/qualcomm/phy-qcom-qmp.h                | 280 +++++++++
 drivers/phy/qualcomm/phy-qcom-qusb2.c              | 418 ++++++++++---
 drivers/phy/ralink/Kconfig                         |   1 +
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   4 +
 drivers/phy/rockchip/Kconfig                       |   1 +
 drivers/phy/rockchip/phy-rockchip-emmc.c           |  60 +-
 drivers/phy/rockchip/phy-rockchip-typec.c          | 160 +++--
 drivers/phy/samsung/Kconfig                        |   2 +-
 drivers/phy/st/Kconfig                             |  14 +
 drivers/phy/st/Makefile                            |   1 +
 drivers/phy/st/phy-stm32-usbphyc.c                 | 461 +++++++++++++++
 drivers/phy/tegra/xusb-tegra210.c                  |   6 +-
 drivers/phy/tegra/xusb.c                           |   2 +-
 drivers/platform/x86/intel_cht_int33fe.c           |  24 +
 drivers/staging/typec/tcpci.c                      | 127 +++-
 drivers/staging/typec/tcpci.h                      |  14 +
 drivers/usb/Kconfig                                |   5 +
 drivers/usb/Makefile                               |   2 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |  15 +-
 drivers/usb/chipidea/debug.c                       |  65 +--
 drivers/usb/chipidea/host.c                        |   6 +-
 drivers/usb/chipidea/usbmisc_imx.c                 |  26 +-
 drivers/usb/common/Makefile                        |   1 +
 drivers/usb/common/roles.c                         | 305 ++++++++++
 drivers/usb/core/Makefile                          |   2 +-
 drivers/usb/core/generic.c                         |   9 +-
 drivers/usb/core/hcd.c                             |  64 +-
 drivers/usb/core/hub.c                             |  26 +-
 drivers/usb/core/hub.h                             |   1 +
 drivers/usb/core/phy.c                             | 158 +++++
 drivers/usb/core/phy.h                             |   7 +
 drivers/usb/core/port.c                            |  10 +
 drivers/usb/core/quirks.c                          | 186 +++++-
 drivers/usb/core/urb.c                             |   8 +
 drivers/usb/core/usb-acpi.c                        |   4 +-
 drivers/usb/core/usb.c                             |   1 +
 drivers/usb/core/usb.h                             |   1 +
 drivers/usb/dwc2/core.c                            | 395 +++++++++----
 drivers/usb/dwc2/core.h                            | 136 +++--
 drivers/usb/dwc2/core_intr.c                       | 304 +++++++++-
 drivers/usb/dwc2/debugfs.c                         |  91 +--
 drivers/usb/dwc2/gadget.c                          | 403 ++++++++++---
 drivers/usb/dwc2/hcd.c                             | 445 ++++++++++----
 drivers/usb/dwc2/hcd.h                             |  56 --
 drivers/usb/dwc2/hw.h                              |  44 +-
 drivers/usb/dwc2/params.c                          |  91 ++-
 drivers/usb/dwc2/pci.c                             |  27 +-
 drivers/usb/dwc2/platform.c                        |  16 +-
 drivers/usb/dwc3/Makefile                          |   2 +-
 drivers/usb/dwc3/core.c                            | 134 ++++-
 drivers/usb/dwc3/core.h                            | 146 +++++
 drivers/usb/dwc3/debugfs.c                         |  84 ++-
 drivers/usb/dwc3/drd.c                             | 489 +++++++++++++++-
 drivers/usb/dwc3/dwc3-of-simple.c                  |  31 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   2 +-
 drivers/usb/dwc3/ep0.c                             |   2 +-
 drivers/usb/dwc3/gadget.c                          |  82 ++-
 drivers/usb/gadget/composite.c                     | 126 ++--
 drivers/usb/gadget/function/f_fs.c                 |   6 +-
 drivers/usb/gadget/function/f_midi.c               |   3 +-
 drivers/usb/gadget/function/f_tcm.c                |   2 +-
 drivers/usb/gadget/legacy/mass_storage.c           |   2 +-
 drivers/usb/gadget/u_f.h                           |   2 +
 drivers/usb/gadget/udc/atmel_usba_udc.c            | 158 ++---
 drivers/usb/gadget/udc/atmel_usba_udc.h            |   4 +-
 drivers/usb/gadget/udc/bcm63xx_udc.c               |  33 +-
 drivers/usb/gadget/udc/bdc/bdc_ep.c                |   3 +-
 drivers/usb/gadget/udc/core.c                      |   7 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |   2 +-
 drivers/usb/gadget/udc/goku_udc.h                  |   2 +-
 drivers/usb/gadget/udc/gr_udc.c                    |  17 +-
 drivers/usb/gadget/udc/pxa25x_udc.c                |  20 +-
 drivers/usb/gadget/udc/pxa27x_udc.c                |  42 +-
 drivers/usb/host/Kconfig                           |  25 -
 drivers/usb/host/Makefile                          |   2 +-
 drivers/usb/host/ehci-fsl.c                        |   2 +
 drivers/usb/host/ehci-mem.c                        |   3 +-
 drivers/usb/host/ehci-platform.c                   |  55 +-
 drivers/usb/host/ehci-sched.c                      |   6 +-
 drivers/usb/host/ehci-tegra.c                      |   1 +
 drivers/usb/host/fhci-dbg.c                        |  26 +-
 drivers/usb/host/imx21-dbg.c                       |  65 +--
 drivers/usb/host/isp116x-hcd.c                     |  15 +-
 drivers/usb/host/ohci-omap.c                       |   1 +
 drivers/usb/host/ohci-platform.c                   |  56 +-
 drivers/usb/host/sl811-hcd.c                       |  17 +-
 drivers/usb/host/whci/debug.c                      |  48 +-
 drivers/usb/host/xhci-dbgtty.c                     |   5 +-
 drivers/usb/host/xhci-ext-caps.c                   |  90 +++
 drivers/usb/host/xhci-ext-caps.h                   |   7 +-
 drivers/usb/host/xhci-mem.c                        |   2 +
 drivers/usb/host/xhci-mtk.c                        |  98 +---
 drivers/usb/host/xhci-pci.c                        |   5 +
 drivers/usb/host/xhci-plat.c                       |   1 +
 drivers/usb/host/xhci-ring.c                       |  27 +-
 drivers/usb/host/xhci.c                            | 139 ++++-
 drivers/usb/host/xhci.h                            |   4 +
 drivers/usb/isp1760/isp1760-udc.c                  |   6 +-
 drivers/usb/misc/adutux.c                          |   4 +-
 drivers/usb/misc/chaoskey.c                        |   8 +-
 drivers/usb/misc/usbtest.c                         |   5 +-
 drivers/usb/misc/uss720.c                          |   7 +-
 drivers/usb/musb/musb_debugfs.c                    |  13 +-
 drivers/usb/musb/musb_gadget_ep0.c                 |  14 +-
 drivers/usb/phy/phy-ab8500-usb.c                   | 508 +---------------
 drivers/usb/phy/phy-generic.c                      |   6 +-
 drivers/usb/phy/phy-mxs-usb.c                      |   2 +-
 drivers/usb/phy/phy-tegra-usb.c                    |  14 +-
 drivers/usb/roles/Kconfig                          |  14 +
 drivers/usb/roles/Makefile                         |   1 +
 drivers/usb/roles/intel-xhci-usb-role-switch.c     | 192 ++++++
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/ftdi_sio.c                      |   2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   9 +
 drivers/usb/serial/option.c                        | 457 +++++----------
 drivers/usb/typec/Kconfig                          |   3 +
 drivers/usb/typec/Makefile                         |   2 +
 drivers/usb/typec/{typec.c => class.c}             | 168 ++++--
 drivers/usb/typec/fusb302/fusb302.c                |  19 +-
 drivers/usb/typec/mux.c                            | 191 ++++++
 drivers/usb/typec/mux/Kconfig                      |  10 +
 drivers/usb/typec/mux/Makefile                     |   3 +
 drivers/usb/typec/mux/pi3usb30532.c                | 178 ++++++
 drivers/usb/typec/tcpm.c                           |  96 +--
 drivers/usb/typec/tps6598x.c                       |  41 +-
 drivers/usb/typec/typec_wcove.c                    |   1 +
 drivers/usb/typec/ucsi/ucsi.c                      |  44 +-
 drivers/usb/usb-skeleton.c                         |   2 +-
 drivers/usb/usbip/Kconfig                          |   2 +-
 drivers/usb/wusbcore/crypto.c                      |   8 +-
 drivers/usb/wusbcore/wa-nep.c                      |   1 -
 drivers/uwb/uwb-debug.c                            |  32 +-
 include/linux/device.h                             |  22 +
 include/linux/phy/phy.h                            |  31 +-
 include/linux/usb/composite.h                      |   3 +
 include/linux/usb/gadget.h                         |   1 +
 include/linux/usb/hcd.h                            |   8 +-
 include/linux/usb/pd.h                             | 185 +++++-
 include/linux/usb/pd_ado.h                         |  42 ++
 include/linux/usb/pd_ext_sdb.h                     |  31 +
 include/linux/usb/role.h                           |  53 ++
 include/linux/usb/tcpm.h                           |  15 +-
 include/linux/usb/typec.h                          |  28 +-
 include/linux/usb/typec_mux.h                      |  55 ++
 tools/usb/usbip/libsrc/usbip_common.c              |  23 +
 tools/usb/usbip/libsrc/usbip_common.h              |  11 +
 tools/usb/usbip/libsrc/usbip_host_common.c         |   5 +-
 tools/usb/usbip/src/usbip_attach.c                 |  10 +-
 tools/usb/usbip/src/usbip_list.c                   |   6 +-
 tools/usb/usbip/src/usbip_network.c                |  10 +-
 tools/usb/usbip/src/usbip_network.h                |   6 +-
 tools/usb/usbip/src/usbipd.c                       |  34 +-
 203 files changed, 9264 insertions(+), 3082 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-usb_role
 create mode 100644 Documentation/devicetree/bindings/phy/meson-gxl-usb3-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
 create mode 100644 Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-hcd.txt
 create mode 100644 Documentation/driver-api/device_connection.rst
 create mode 100644 drivers/base/devcon.c
 create mode 100644 drivers/phy/amlogic/phy-meson-gxl-usb3.c
 create mode 100644 drivers/phy/hisilicon/phy-hisi-inno-usb2.c
 create mode 100644 drivers/phy/hisilicon/phy-histb-combphy.c
 create mode 100644 drivers/phy/motorola/phy-mapphone-mdm6600.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp.h
 create mode 100644 drivers/phy/st/phy-stm32-usbphyc.c
 create mode 100644 drivers/usb/common/roles.c
 create mode 100644 drivers/usb/core/phy.c
 create mode 100644 drivers/usb/core/phy.h
 create mode 100644 drivers/usb/host/xhci-ext-caps.c
 create mode 100644 drivers/usb/roles/Kconfig
 create mode 100644 drivers/usb/roles/Makefile
 create mode 100644 drivers/usb/roles/intel-xhci-usb-role-switch.c
 rename drivers/usb/typec/{typec.c => class.c} (91%)
 create mode 100644 drivers/usb/typec/mux.c
 create mode 100644 drivers/usb/typec/mux/Kconfig
 create mode 100644 drivers/usb/typec/mux/Makefile
 create mode 100644 drivers/usb/typec/mux/pi3usb30532.c
 create mode 100644 include/linux/usb/pd_ado.h
 create mode 100644 include/linux/usb/pd_ext_sdb.h
 create mode 100644 include/linux/usb/role.h
 create mode 100644 include/linux/usb/typec_mux.h
