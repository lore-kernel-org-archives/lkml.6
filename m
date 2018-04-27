Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524839992-2-17297262627907351711
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839992; b=WWhRgu6dSCXUVjDWsl1UjmT3ez5pStV8w5qspy2Syy9wRvXGsN
    xATP+xlLiVKaEatRc/7A6Q8U+tYiSmMYbU0ioWVvD3a1LaPa4l1Yd0CMu4fSBlsA
    kKurRtKUwVU9DdpigCseqDpXg5DxCaxHTNgQ5JUYAu9tv2T3wfOUphPkGY1JmvwK
    Mm+s6xNqtfcgJJOIwiZt9m9AQnLkLFTsIHUNDm510N7jiREa/RHlSODsDfYi3BX8
    O6OB6HmgZdf5qJxbmM3omj1YHXaBUcm+K9hDH0CnJGi9tuvZTX/zduV9nCK/xWwo
    1FI5zmSFrcrq5rjXvKNNnv0uSpFg19M5lAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524839992;
    bh=m44JEoYAIz/6fyBzfrboo1L99lQ5/jfEbe8pPhYgKEU=; b=j1Zj7xBe8Cxj
    8amivGzCgtpqQuc3SWOUsY7yGlD4MQzhkLKi5/c5OIs7ps7pKX2EUkYIQVm18rRm
    7XWWrWONtz0t20fL0JT+mwkstNybWNtZ214iwWAKXnpO9pq857Hwwf+mlxBM2l1/
    ZVGrD5W7y2h6chl3iVfgQxe6H7+yWFr2TfpOW+IxlwoFI3hTViDSn/b30dJZI30N
    8E56ZAz7SeNDHC6vblu0RrmJRa+OkknuLPuuxENB1k4dxV5YZQwhtl97X0kUDuiG
    KuYF58jTHUGpx+t0kD4Rjz3PMm4eJl3EpurWRgdBubbFAkxPFO31sb0k2AG1omPt
    BK1vmS4FMg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBTf+IaXMOzOJ1DTf/uKXFpH+Ri9+M4QqBkx+NcALmsnURpN9keU5iZlvnNeiOk+zpvvFkUNaexmkyPmQl2td0FhrADT92YteqqNEYoOpZF+gbXANahT
    cr0lmQhsz3cacMmbKTkdQt3j1fGvumMWCqCuZP1RX77TP8wOIUNGJqorS6PL1tmBqh1q1LPPeu/F665gRBg3gwh8FfOhWYYx38dOv9O7Q1XCpJPPaDySvJqE
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=7J6YCC1aKYcPC-pG1cwA:9
    a=X2IAwd98RYCOGon7:21 a=qne_75HObxP21Bzy:21 a=CjuIK1q_8ugA:10
    a=l_KOVhCsiiEA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934649AbeD0Ojf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934239AbeD0Ojd (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 27 Apr 2018 10:39:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C505A2189F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Fri, 27 Apr 2018 16:39:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 4.17-rc3
Message-ID: <20180427143924.GA8988@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/ tags/usb-4.17-rc3

for you to fetch changes up to 573a094873752d225041b1059a662eca013a54f4:

  Merge tag 'usb-serial-4.17-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2018-04-26 19:29:24 +0200)

----------------------------------------------------------------
USB fixes for 4.17-rc3

Here are a number of USB driver fixes for reported problems for
4.17-rc3.

The "largest" here is a number of phy core changes for reported problems
with the -rc1 release.  There's also the usual musb and xhci fixes, as
well as new device id updates.  There are also some usbip fixes for
reported problems as more people start to use that code with containers.

All of these have been in linux-next with no reported issues, except the
last few new device ids, which are "obviously correct" :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      usb: select USB_COMMON for usb role switch config

Collin May (1):
      USB: serial: simple: add libtransistor console

Greg Kroah-Hartman (2):
      Revert "xhci: plat: Register shutdown for xhci_plat"
      Merge tag 'usb-serial-4.17-rc3' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Gregory CLEMENT (2):
      usb: host: xhci-plat: Remove useless test before clk_disable_unprepare
      usb: host: xhci-plat: Fix clock resource by adding a register clock

Heikki Krogerus (2):
      Documentation: typec.rst: Use literal-block element with ascii art
      usb: typec: ucsi: Increase command completion timeout value

Johan Hovold (2):
      USB: musb: host: prevent core phy initialisation
      USB: musb: dsps: drop duplicate phy initialisation

Kai-Heng Feng (1):
      xhci: Fix USB ports for Dell Inspiron 5775

Kamil Lulko (1):
      usb: core: Add quirk for HP v222w 16GB Mini

Kyle Roeschley (1):
      USB: serial: cp210x: add ID for NI USB serial console

Martin Blumenstingl (6):
      usb: core: phy: fix return value of usb_phy_roothub_exit()
      usb: core: split usb_phy_roothub_{init,alloc}
      usb: core: use phy_exit during suspend if wake up is not supported
      usb: core: phy: make it a no-op if CONFIG_GENERIC_PHY is disabled
      usb: core: phy: add missing forward declaration for "struct device"
      usb: core: phy: add the SPDX-License-Identifier and include guard

Ravi Chandra Sadineni (1):
      USB: Increment wakeup count on remote wakeup.

Shuah Khan (4):
      usbip: vhci_hcd: check rhport before using in vhci_hub_control()
      usbip: vhci_hcd: Fix usb device and sockfd leaks
      usbip: usbip_host: fix to hold parent lock for device_attach() calls
      usbip: usbip_event: fix to not print kernel pointer address

Tobias Regnery (1):
      usb: typec: ucsi: fix tracepoint related build error

Vasyl Vavrychuk (1):
      USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster

Zhengjun Xing (1):
      xhci: Fix Kernel oops in xhci dbgtty

 Documentation/devicetree/bindings/usb/usb-xhci.txt |  5 +-
 Documentation/driver-api/usb/typec.rst             |  2 +-
 drivers/usb/Kconfig                                |  1 +
 drivers/usb/core/hcd.c                             | 19 +++--
 drivers/usb/core/hub.c                             | 10 ++-
 drivers/usb/core/phy.c                             | 93 +++++++++++++++-------
 drivers/usb/core/phy.h                             | 22 ++++-
 drivers/usb/core/quirks.c                          |  3 +
 drivers/usb/host/xhci-dbgtty.c                     |  8 +-
 drivers/usb/host/xhci-pci.c                        |  5 +-
 drivers/usb/host/xhci-plat.c                       | 32 +++++---
 drivers/usb/host/xhci.h                            |  3 +-
 drivers/usb/musb/musb_dsps.c                       |  2 -
 drivers/usb/musb/musb_host.c                       |  1 +
 drivers/usb/serial/Kconfig                         |  1 +
 drivers/usb/serial/cp210x.c                        |  1 +
 drivers/usb/serial/ftdi_sio.c                      |  3 +-
 drivers/usb/serial/usb-serial-simple.c             |  7 ++
 drivers/usb/typec/ucsi/Makefile                    |  2 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  2 +-
 drivers/usb/usbip/stub_main.c                      |  5 ++
 drivers/usb/usbip/usbip_common.h                   |  2 +-
 drivers/usb/usbip/usbip_event.c                    |  4 -
 drivers/usb/usbip/vhci_hcd.c                       | 13 +++
 24 files changed, 185 insertions(+), 61 deletions(-)
