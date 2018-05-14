Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065765-1526314811-2-5318372553519043833
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526314810; b=BaPRsQAY+3QlZOXqEl2aUhgkoSS1BE12WpqATLXgkQVE3iR3Y+
    hzMSi77dpkM+oqYDWvHk4lmJvnHyhQWvxC6MgZoefVrhSnzh/CUWfIr8Db5pj8Ot
    Jyhab9xFpuEPzPVaxyM5oU7gJno/eaMoBw5GbcHz69fTvWQi1OJv/HXLwqCBYn7z
    QRNu58Nz2Wi/zNz9iDBlU3ylufKrjoorUasat3z8Pr9AvV/bRVzAeeMTnZcnjt99
    Xd755WdVkpQsdl+Mehxgcb+gwTXdOd4lhmo8IFf4DGHTc707PQjrt1KonrkvJKlN
    aANzEPr1z7HEutMY3N3ZlgHrMLYy17ptn39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526314810; bh=BpEos6tLcz4WXgq+NNvP9Xyk0ZuIB1
    hiV6cJfdDhO2g=; b=GLl0UtMUlIf32Rk8LFefMSM/8w0B0oPTorT3RQ9kiRVfRQ
    njyUg2lqA5xOnQ4Bor87MH5SW8nE3m/nzdm5o34W7+jfenFVNIj37OR+uoP6kkkc
    Xw4i97WOwpADU8EMqRRCU8V0IQV4v/Bz0Jq1Ztri9HB6SvAmUhhVGJZKqlhj3qIc
    RX6bD2LYN54bamKIgmhH5LN/LS4k9BEbdYBCIuZRbq6ZTQq8BpU8oOcLIQ0FxBnd
    kDGurIhGyae6bE16buojCl1nWsEhqZMVtfqWQKXEGaAeCjA+ZqF7UzgxJiVoBt+j
    EjsIpcfVpzR35kPaHnZHD/cxPFeNFmVvqj1HxyEg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mellanox.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mellanox.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM37FkoLva+MoJTYgoZk6xYaW8hCHCM23lzhVNbDlpPiTEmaavFwCfbRQnAW7Odwd2UxWYwXk0+H0Axn+qyiP7NjpxVH5rvZ1u8wJRFcmPNCN45OCQ1y
    vmRlOatDyP/Ods0XczqCMhZgTMD4A0vtFeE913OQoyTJAw+/P7hl775HYII8eIqFQ1vk08PbeQcFgoNiyvSZIX2Y7wzTDNN5jxsM97OjTppln7jcUXhcxSyV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=4rzqClev4zsV3xdq_LEA:9 a=fYPFoBLIL-eBt70y:21 a=3_MeU7jgnI2rQqx-:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754556AbeENQUH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 12:20:07 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39759 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753773AbeENQUG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 May 2018 12:20:06 -0400
From: Oleksandr Shamray <oleksandrs@mellanox.com>
To: gregkh@linuxfoundation.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        joel@jms.id.au, jiri@resnulli.us, tklauser@distanz.ch,
        linux-serial@vger.kernel.org, vadimp@mellanox.com,
        system-sw-low-level@mellanox.com, robh+dt@kernel.org,
        openocd-devel-owner@lists.sourceforge.net,
        linux-api@vger.kernel.org, davem@davemloft.net, mchehab@kernel.org,
        Oleksandr Shamray <oleksandrs@mellanox.com>
Subject: [patch v20 0/4] JTAG driver introduction
Date: Mon, 14 May 2018 19:19:59 +0300
Message-Id: <1526314803-3532-1-git-send-email-oleksandrs@mellanox.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When a need raise up to use JTAG interface for system's devices
programming or CPU debugging, usually the user layer
application implements jtag protocol by bit-bang or using a 
proprietary connection to vendor hardware.
This method can be slow and not generic.
 
We propose to implement general JTAG interface and infrastructure
to communicate with user layer application. In such way, we can
have the standard JTAG interface core part and separation from
specific HW implementation.
This allow new capability to debug the CPU or program system's 
device via BMC without additional devices nor cost. 

This patch purpose is to add JTAG master core infrastructure by 
defining new JTAG class and provide generic JTAG interface
to allow hardware specific drivers to connect this interface.
This will enable all JTAG drivers to use the common interface
part and will have separate for hardware implementation.

The JTAG (Joint Test Action Group) core driver provides minimal generic
JTAG interface, which can be used by hardware specific JTAG master
controllers. By providing common interface for the JTAG controllers,
user space device programing is hardware independent.
 
Modern SoC which in use for embedded system' equipped with
internal JTAG master interface.
This interface is used for programming and debugging system's
hardware components, like CPLD, FPGA, CPU, voltage and
industrial controllers.
Firmware for such devices can be upgraded through JTAG interface during
Runtime. The JTAG standard support for multiple devices programming,
is in case their lines are daisy-chained together.

For example, systems which equipped with host CPU, BMC SoC or/and 
number of programmable devices are capable to connect a pin and
select system components dynamically for programming and debugging,
This is using by the BMC which is equipped with internal SoC master
controller.
For example:

BMC JTAG master --> pin selected to CPLDs chain for programming (filed
upgrade, production) 
BMC JTAG master --> pin selected to voltage monitors for programming 
(field upgrade, production) 
BMC JTAG master --> pin selected to host CPU (on-site debugging 
and developers debugging)

For example, we can have application in user space which using calls
to JTAG driver executes CPLD programming directly from SVF file
 
The JTAG standard (IEEE 1149.1) defines the next connector pins:
- TDI (Test Data In);
- TDO (Test Data Out);
- TCK (Test Clock);
- TMS (Test Mode Select);
- TRST (Test Reset) (Optional);

The SoC equipped with JTAG master controller, performs
device programming on command or vector level. For example
a file in a standard SVF (Serial Vector Format) that contains
boundary scan vectors, can be used by sending each vector
to the JTAG interface and the JTAG controller will execute
the programming.

Initial version provides the system calls set for:
- SIR (Scan Instruction Register, IEEE 1149.1 Instruction Register scan);
- SDR (Scan Data Register, IEEE 1149.1 Data Register scan);
- RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified
  number of clocks.

SoC which are not equipped with JTAG master interface, can be built
on top of JTAG core driver infrastructure, by applying bit-banging of
TDI, TDO, TCK and TMS pins within the hardware specific driver.

Oleksandr Shamray (4):
  drivers: jtag: Add JTAG core driver
  drivers: jtag: Add Aspeed SoC 24xx and 25xx families JTAG master
    driver
  Documentation: jtag: Add bindings for Aspeed SoC 24xx and 25xx
    families     JTAG master driver
  Documentation: jtag: Add ABI documentation

 Documentation/ABI/testing/jtag-dev                 |   27 +
 .../devicetree/bindings/jtag/aspeed-jtag.txt       |   22 +
 Documentation/ioctl/ioctl-number.txt               |    2 +
 Documentation/jtag/overview                        |   28 +
 Documentation/jtag/transactions                    |  109 +++
 MAINTAINERS                                        |   10 +
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/jtag/Kconfig                               |   32 +
 drivers/jtag/Makefile                              |    2 +
 drivers/jtag/jtag-aspeed.c                         |  786 ++++++++++++++++++++
 drivers/jtag/jtag.c                                |  274 +++++++
 include/linux/jtag.h                               |   41 +
 include/uapi/linux/jtag.h                          |  105 +++
 14 files changed, 1441 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/jtag-dev
 create mode 100644 Documentation/devicetree/bindings/jtag/aspeed-jtag.txt
 create mode 100644 Documentation/jtag/overview
 create mode 100644 Documentation/jtag/transactions
 create mode 100644 drivers/jtag/Kconfig
 create mode 100644 drivers/jtag/Makefile
 create mode 100644 drivers/jtag/jtag-aspeed.c
 create mode 100644 drivers/jtag/jtag.c
 create mode 100644 include/linux/jtag.h
 create mode 100644 include/uapi/linux/jtag.h

