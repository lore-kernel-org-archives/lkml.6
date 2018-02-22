Date: Thu, 22 Feb 2018 13:31:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 4.16-rc3
Message-ID: <20180222123103.GA30924@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/ tags/usb-4.16-rc3

for you to fetch changes up to 44eb5e12b845cc8a0634f21b70ef07d774eb4b25:

  Revert "usb: musb: host: don't start next rx urb if current one failed" (2018-02-20 15:02:46 +0100)

----------------------------------------------------------------
USB fixes for 4.16-rc3

Here are a number of USB fixes for 4.16-rc3

Nothing major, but a number of different fixes all over the place in the
USB stack for reported issues.  Mostly gadget driver fixes, although the
typical set of xhci bugfixes are there, along with some new quirks
additions as well.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
AMAN DEEP (1):
      usb: ohci: Proper handling of ed_rm_list to handle race condition between usb_kill_urb() and finish_unlinks()

Andreas Kemnade (1):
      usb: musb: fix enumeration after resume

Bin Liu (1):
      Revert "usb: musb: host: don't start next rx urb if current one failed"

Brian Norris (1):
      usb: dwc3: Undo PHY init if soft reset fails

Dominik Bozek (1):
      usb: cdc_acm: prevent race at write to acm while system resumes

Enric Balletbo i Serra (1):
      usb: dwc3: of-simple: fix oops by unbalanced clk disable call

Fabio Estevam (1):
      usb: phy: mxs: Fix NULL pointer dereference on i.MX23/28

Greg Kroah-Hartman (1):
      Merge tag 'fixes-for-v4.16-rc2' of git://git.kernel.org/.../balbi/usb into usb-linus

Jack Pham (2):
      usb: gadget: f_fs: Process all descriptors during bind
      usb: gadget: f_fs: Use config_ep_by_speed()

Jack Stocker (1):
      Add delay-init quirk for Corsair K70 RGB keyboards

Joe Lee (1):
      xhci: workaround for AMD Promontory disabled ports wakeup

John Keeping (1):
      usb: gadget: f_uac2: fix bFirstInterface in composite gadget

Karsten Koop (1):
      usb: ldusb: add PIDs for new CASSY devices supported by this driver

Kristian Evensen (1):
      USB: serial: option: Add support for Quectel EP06

Manu Gautam (2):
      usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode
      usb: gadget: core: Fix use-after-free of usb_request

Mathias Nyman (1):
      xhci: Don't print a warning when setting link state for disabled ports

Minas Harutyunyan (2):
      usb: dwc2: Add safety check in setting of descriptor chain pointers
      usb: dwc2: Add safety check for STSPHSERCVD intr

Peter Chen (2):
      usb: host: ehci: use correct device pointer for dma ops
      usb: host: ehci: always enable interrupt for qtd completion at test mode

Roger Quadros (2):
      usb: dwc3: omap: don't miss events during suspend/resume
      usb: dwc3: core: Fix ULPI PHYs and prevent phy_get/ulpi_init during suspend/resume

Shigeru Yoshida (1):
      ohci-hcd: Fix race condition caused by ohci_urb_enqueue() and io_watchdog_func()

Shuah Khan (1):
      usbip: keep usbip_device sockfd state in sync with tcp_socket

Stefan Agner (1):
      usb: gadget: fsl_udc_core: fix ep valid checks

Thinh Nguyen (3):
      usb: dwc3: gadget: Set maxpacket size for ep0 IN
      usb: dwc3: ep0: Reset TRB counter for ep0 IN
      usb: dwc3: Fix GDBGFIFOSPACE_TYPE values

Ulf Magnusson (1):
      usb: gadget: udc: Remove USB_GADGET_DUALSPEED select

Vardan Mikayelyan (1):
      usb: dwc2: Fix dwc2_hsotg_core_init_disconnected()

Wei Yongjun (1):
      USB: gadget: udc: Add missing platform_device_put() on error in bdc_pci_probe()

Yoshihiro Shimoda (3):
      usb: gadget: udc: renesas_usb3: fix oops in renesas_usb3_remove()
      usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path
      usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path

Zhengjun Xing (4):
      xhci: Fix NULL pointer in xhci debugfs
      xhci: Fix xhci debugfs devices node disappearance after hibernation
      xhci: xhci debugfs device nodes weren't removed after device plugged out
      xhci: fix xhci debugfs errors in xhci_stop

 drivers/hid/hid-ids.h                 |   3 +
 drivers/hid/hid-quirks.c              |   3 +
 drivers/usb/class/cdc-acm.c           |   9 ++-
 drivers/usb/core/quirks.c             |   3 +
 drivers/usb/dwc2/gadget.c             |  26 ++++----
 drivers/usb/dwc3/core.c               |  86 +++++++++++++++++++--------
 drivers/usb/dwc3/core.h               |  21 ++++---
 drivers/usb/dwc3/dwc3-of-simple.c     |   1 +
 drivers/usb/dwc3/dwc3-omap.c          |  16 +++++
 drivers/usb/dwc3/ep0.c                |   7 ++-
 drivers/usb/dwc3/gadget.c             |   2 +
 drivers/usb/gadget/function/f_fs.c    |  44 +++-----------
 drivers/usb/gadget/function/f_uac2.c  |   2 +
 drivers/usb/gadget/udc/Kconfig        |   1 -
 drivers/usb/gadget/udc/bdc/bdc_pci.c  |   1 +
 drivers/usb/gadget/udc/core.c         |   2 +-
 drivers/usb/gadget/udc/fsl_udc_core.c |   4 +-
 drivers/usb/gadget/udc/renesas_usb3.c |   2 +-
 drivers/usb/host/ehci-hub.c           |   4 +-
 drivers/usb/host/ehci-q.c             |  12 ++--
 drivers/usb/host/ohci-hcd.c           |  10 +++-
 drivers/usb/host/ohci-hub.c           |   4 +-
 drivers/usb/host/ohci-q.c             |  17 +++---
 drivers/usb/host/pci-quirks.c         | 109 ++++++++++++++++++++++++++++++++++
 drivers/usb/host/pci-quirks.h         |   5 ++
 drivers/usb/host/xhci-debugfs.c       |   4 +-
 drivers/usb/host/xhci-hub.c           |  25 +++++---
 drivers/usb/host/xhci-pci.c           |  11 ++++
 drivers/usb/host/xhci.c               |  10 ++--
 drivers/usb/host/xhci.h               |   2 +-
 drivers/usb/misc/ldusb.c              |   6 ++
 drivers/usb/musb/musb_core.c          |   3 +-
 drivers/usb/musb/musb_host.c          |   8 +--
 drivers/usb/phy/phy-mxs-usb.c         |   3 +
 drivers/usb/renesas_usbhs/fifo.c      |   5 ++
 drivers/usb/serial/option.c           |   7 +++
 drivers/usb/usbip/stub_dev.c          |   3 +
 drivers/usb/usbip/vhci_hcd.c          |   2 +
 38 files changed, 350 insertions(+), 133 deletions(-)
