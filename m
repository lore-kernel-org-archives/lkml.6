Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2241tpCjgR8ED1tyUeuDHgU7cpXQP+ZdmBoDJPj+4Qb7T4A/y1K97FFCIr6b98HuPzIFpdIf
ARC-Seal: i=1; a=rsa-sha256; t=1517591733; cv=none;
        d=google.com; s=arc-20160816;
        b=s7GXwbfkgPTY6HsFR15YhUp0enwhHoszRhATcNqS4sXfKu+UduA08ET1uC+3C8zaTu
         gFb4fQru1jNBfhh/c6igc3B2iEl8V6Bi2HlwuoF3JpE8qAcHIb6ZUxrlgAsjtGQZZ2MQ
         IMP3T3IEnbobYLosf0jA/W7syKDYu3iKq5X2BiC3PFnEvhMgTRwAjp+pOIzZhqaWXLAc
         fQO1tVVQycoSQFDdeeoZ+KRuYYT/qSCdhGg+u1NExHG8h8EiJm+iaE9oRpDtDDFmBt9Y
         FRoJzYpEVZe+EUBD2SI+i22QiH5g/2hf9XSVWuILvDpGM+TOL/nHtAvkGjpL3c+U1owR
         55DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=P5Kfl7I/56ZuSFgBEW8i9SJ3d9yIkD77YUsJbXsiSU4=;
        b=ektewWkUDVzsFh6JQzinR624FUD/lwlOGA/89tGGVyhhw7cgqtKPIkZmuw6TnIIr0N
         T5xVJV9JBL9R7hImAdRAyOPCTpFDjOTB8UR5xZYzcoym7K50bO/LnXz2yfuAm/X9Ur0u
         RCG+ceHwEXHE6R1E40+5lSo0h78epAwbrJeITs8P0s99XG65Mfy2fLkhc6dnE7WUpGR8
         5ywnVLAU17Fn/bn67vbwtOdeO6SrSBo5gJ6FmM66sCLWQ3d8p5y62d69nmqxsr8bykGT
         egfIcNsNB/ce831ftfesKQ/xKuKEmLCcl3qnT13oYm0YPW2rXoxOawLqaca4IZxgsFJx
         Xqew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.15 00/55] 4.15.1-stable review
Date: Fri,  2 Feb 2018 17:58:18 +0100
Message-Id: <20180202140826.117602411@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
User-Agent: quilt/0.65
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.1-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.1-rc1
X-KernelTest-Deadline: 2018-02-04T14:08+00:00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310269711679278?=
X-GMAIL-MSGID: =?utf-8?q?1591310269711679278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.15.1 release.
There are 55 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Feb  4 14:07:50 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.1-rc1.gz
or in the git tree and branch at:
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.1-rc1

Matthew Garrett <mjg59@google.com>
    x86/efi: Clarify that reset attack mitigation needs appropriate userspace

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: synaptics-rmi4 - do not delete interrupt memory too early

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: synaptics-rmi4 - unmask F03 interrupts when port is opened

Wei Yongjun <weiyongjun1@huawei.com>
    test_firmware: fix missing unlock on error in config_num_requests_store()

Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
    iio: chemical: ccs811: Fix output of IIO_CONCENTRATION channels

Fabrice Gasnier <fabrice.gasnier@st.com>
    iio: adc: stm32: fix scan of multiple channels with DMA

Stefan Agner <stefan@agner.ch>
    spi: imx: do not access registers while clocks disabled

Fabio Estevam <fabio.estevam@nxp.com>
    serial: imx: Only wakeup via RTSDEN bit if the system has RTS/CTS

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: 8250_dw: Revert "Improve clock rate setting"

Wei Yongjun <weiyongjun1@huawei.com>
    serial: 8250_uniphier: fix error return code in uniphier_uart_probe()

Masahiro Yamada <yamada.masahiro@socionext.com>
    serial: 8250_of: fix return code when probe function fails to get reset

Tomas Winkler <tomas.winkler@intel.com>
    mei: me: allow runtime pm for platform with D0i3

Ganesh Mahendran <opensource.ganesh@gmail.com>
    android: binder: use VM_ALLOC to get vm area

Martijn Coenen <maco@android.com>
    ANDROID: binder: remove waitqueue when thread exits.

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    usb/gadget: Fix "high bandwidth" check in usb_gadget_ep_match_desc()

Oliver Neukum <oneukum@suse.com>
    usb: uas: unconditionally bring back host after reset

Hemant Kumar <hemantk@codeaurora.org>
    usb: f_fs: Prevent gadget unbind if it is already unbound

Johan Hovold <johan@kernel.org>
    USB: serial: simple: add Motorola Tetra driver

Shuah Khan <shuah@kernel.org>
    usbip: list: don't list devices attached to vhci_hcd

Shuah Khan <shuah@kernel.org>
    usbip: prevent bind loops on devices attached to vhci_hcd

Jia-Ju Bai <baijiaju1990@gmail.com>
    USB: serial: io_edgeport: fix possible sleep-in-atomic

Oliver Neukum <oneukum@suse.com>
    CDC-ACM: apply quirk for card reader

Hans de Goede <hdegoede@redhat.com>
    USB: cdc-acm: Do not log urb submission errors on disconnect

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    USB: serial: pl2303: new device id for Chilitag

OKAMOTO Yoshiaki <yokamoto@allied-telesis.co.jp>
    usb: option: Add support for FS040U modem

Gaurav Kohli <gkohli@codeaurora.org>
    tty: fix data race between tty_init_dev and flush of buf

Gilad Ben-Yossef <gilad@benyossef.com>
    staging: ccree: fix fips event irq handling build

Gilad Ben-Yossef <gilad@benyossef.com>
    staging: ccree: NULLify backup_info when unused

Dmitry Eremin <dmitry.eremin@intel.com>
    staging: lustre: separate a connection destroy from free struct kib_conn

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: storvsc: missing error code in storvsc_probe()

Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
    scsi: aacraid: Fix hang in kdump

Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
    scsi: aacraid: Fix udev inquiry race condition

Mike Rapoport <rppt@linux.vnet.ibm.com>
    ima/policy: fix parsing of fsuuid

Lyude Paul <lyude@redhat.com>
    igb: Free IRQs when device is hotplugged

Jesse Chan <jc@linux.com>
    mtd: nand: denali_pci: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jesse Chan <jc@linux.com>
    gpio: ath79: add missing MODULE_DESCRIPTION/LICENSE

Jesse Chan <jc@linux.com>
    gpio: iop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jesse Chan <jc@linux.com>
    power: reset: zx-reboot: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jason Gerecke <killertofu@gmail.com>
    HID: wacom: Fix reporting of touch toggle (WACOM_HID_WD_MUTE_DEVICE) events

Aaron Armstrong Skomra <skomra@gmail.com>
    HID: wacom: EKR: ensure devres groups at higher indexes are released

Stephan Mueller <smueller@chronox.de>
    crypto: af_alg - whitelist mask and type

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: sha3-generic - fixes for alignment and big endian operation

Antoine Tenart <antoine.tenart@free-electrons.com>
    crypto: inside-secure - avoid unmapping DMA memory that was not mapped

Antoine Tenart <antoine.tenart@free-electrons.com>
    crypto: inside-secure - fix hash when length is a multiple of a block

Junaid Shahid <junaids@google.com>
    crypto: aesni - Fix out-of-bounds access of the AAD buffer in generic-gcm-aesni

Junaid Shahid <junaids@google.com>
    crypto: aesni - Fix out-of-bounds access of the data buffer in generic-gcm-aesni

Sabrina Dubroca <sd@queasysnail.net>
    crypto: aesni - add wrapper for generic gcm(aes)

Sabrina Dubroca <sd@queasysnail.net>
    crypto: aesni - fix typo in generic_gcmaes_decrypt

Stephan Mueller <smueller@chronox.de>
    crypto: aesni - handle zero length dst buffer

Hauke Mehrtens <hauke@hauke-m.de>
    crypto: ecdh - fix typo in KPP dependency of CRYPTO_ECDH

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Reduce the suspend time consumption for ALC256

Linus Walleij <linus.walleij@linaro.org>
    gpio: Fix kernel stack leak to userspace

Patrice Chotard <patrice.chotard@st.com>
    gpio: stmpe: i2c transfer are forbiden in atomic context

Joel Stanley <joel@jms.id.au>
    tools/gpio: Fix build error with musl libc

Lukas Wunner <lukas@wunner.de>
    Bluetooth: hci_serdev: Init hci_uart proto_lock to avoid oops


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/x86/crypto/aesni-intel_asm.S                  | 199 ++++++---------------
 arch/x86/crypto/aesni-intel_glue.c                 |  70 ++++++--
 crypto/Kconfig                                     |   2 +-
 crypto/af_alg.c                                    |  10 +-
 crypto/sha3_generic.c                              |   5 +-
 drivers/android/binder.c                           |  12 ++
 drivers/android/binder_alloc.c                     |   2 +-
 drivers/bluetooth/hci_serdev.c                     |   1 +
 drivers/crypto/inside-secure/safexcel_hash.c       |  56 ++++--
 drivers/firmware/efi/Kconfig                       |   5 +-
 drivers/gpio/gpio-ath79.c                          |   3 +
 drivers/gpio/gpio-iop.c                            |   4 +
 drivers/gpio/gpio-stmpe.c                          |  20 +--
 drivers/gpio/gpiolib.c                             |   3 +
 drivers/hid/wacom_sys.c                            |  24 +--
 drivers/hid/wacom_wac.c                            |  16 +-
 drivers/iio/adc/stm32-adc.c                        |   3 +-
 drivers/iio/chemical/ccs811.c                      |  13 +-
 drivers/input/rmi4/rmi_driver.c                    |  14 +-
 drivers/input/rmi4/rmi_f03.c                       |  64 +++++--
 drivers/misc/mei/pci-me.c                          |   5 +-
 drivers/mtd/nand/denali_pci.c                      |   4 +
 drivers/net/ethernet/intel/igb/igb_main.c          |   2 +-
 drivers/power/reset/zx-reboot.c                    |   4 +
 drivers/scsi/aacraid/aachba.c                      |  15 +-
 drivers/scsi/aacraid/commsup.c                     |   9 +-
 drivers/scsi/storvsc_drv.c                         |   4 +-
 drivers/spi/spi-imx.c                              |  15 +-
 drivers/staging/ccree/ssi_cipher.c                 |   1 +
 drivers/staging/ccree/ssi_driver.c                 |   2 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |   7 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h    |   2 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |   6 +-
 drivers/tty/serial/8250/8250_dw.c                  |  30 ++--
 drivers/tty/serial/8250/8250_of.c                  |   5 +-
 drivers/tty/serial/8250/8250_uniphier.c            |   5 +-
 drivers/tty/serial/imx.c                           |  14 +-
 drivers/tty/tty_io.c                               |   8 +-
 drivers/tty/tty_ldisc.c                            |   4 +-
 drivers/usb/class/cdc-acm.c                        |   5 +-
 drivers/usb/gadget/function/f_fs.c                 |   3 +-
 drivers/usb/gadget/udc/core.c                      |   2 +-
 drivers/usb/serial/Kconfig                         |   1 +
 drivers/usb/serial/io_edgeport.c                   |   1 -
 drivers/usb/serial/option.c                        |   5 +
 drivers/usb/serial/pl2303.c                        |   1 +
 drivers/usb/serial/pl2303.h                        |   1 +
 drivers/usb/serial/usb-serial-simple.c             |   7 +
 drivers/usb/storage/uas.c                          |   7 +-
 include/linux/tty.h                                |   2 +
 lib/test_firmware.c                                |   1 +
 security/integrity/ima/ima_policy.c                |   2 +-
 sound/pci/hda/patch_realtek.c                      |   6 +-
 tools/gpio/gpio-event-mon.c                        |   1 +
 tools/usb/usbip/src/usbip_bind.c                   |   9 +
 tools/usb/usbip/src/usbip_list.c                   |   9 +
 57 files changed, 425 insertions(+), 310 deletions(-)
