Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2336747-1525967105-2-5256217190210427505
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
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
    1525967104; b=msr1mpcxCU+JvsQ+PbY6shemXQdcFEt21z6bgUacI1eZEcy5r0
    kNLvdqkUNbFVqCeyzI28/LiH52BjacDDslS1wTIg3obnydxzZZ4zrK3C4g2Yjdo+
    omPeKWnXSR8jowW9FvmOVqx2T0KAM/HrQhMVYWyn6hAmnwpexipbSL9RSXoW9R7N
    C4YMSYGc1+8rZNqovkKRxFzc+Iv39u5y3xh7DGSghOLY+CxCUxJX6YlFfq800Wgl
    RTAfQOy0oPqbkh0GGs4R7O0WEFFALjixKs1+I2PWPZyf3j8CGoU4vDEU85Cg9y1Q
    qsQo+A+Jq6bTWLPALo43hNNN3mZTwfUe7skA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525967104; bh=CzBxpjPRYw101/WLmjQ36U8BKo55v5
    ZjmbNXeqGhm5w=; b=ibZq14OO7C61LKK94ioyNkuIgAausVWkRtHuXWAYzs50or
    8g759DR7HDOU7ZEr7sajWgB/g6fA2BX5+HOp0fM/SCZMZoBcPOf4P7dIns4afWZy
    587qBIEASvFAm7Y4HLaxepWrS/IVeeI5JO9HynvtI1cn3VRYtHg+N9ul2sIRVwoz
    52tO8MCGKK5yIrgNd9uL24SJ1GBlHAXsucEBxZ+71HQo/PFzMpbtjwn44GplG5bb
    as8+xrcen1wcQEVg/z70xEizw883b2ETCT6Z0vQKDHf1eiAl9rl9mOWfAS9AtJkH
    AC9vyViF7y3dFh9ykADvfIQMGLfTkKgfXg6UviYw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfBUgK81lbq5wf9F3fIcMMPoKjaB++LhBgU8SOOWiB2I5XJjrcXB3ROuEIkCDC9y+KS8qkKvJZ4vQPOmk+RGQbqZ3IBEzJwObSpoSwS5UHqyUOEQTkry3
    l8niKIjFy+gZJaQLjJn3R8isUFjzW9I592IZY+9dfTuq+YHXLSuzxP+OkekS5lS3FGS1cQp3ArAHC8mLCtParmnKTLXCMxIJFk8dwGDMBnN8AHIjmMNGCQ++
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=4rzqClev4zsV3xdq_LEA:9 a=oIDK3fM47IOs3w4L:21 a=3_MeU7jgnI2rQqx-:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966338AbeEJPoc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 11:44:32 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:35665 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966135AbeEJPob (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 May 2018 11:44:31 -0400
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
Subject: [patch v19 0/4] JTAG driver introduction
Date: Thu, 10 May 2018 18:44:20 +0300
Message-Id: <1525967064-10760-1-git-send-email-oleksandrs@mellanox.com>
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
- SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
- SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
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
 Documentation/jtag/overview                        |   31 +
 Documentation/jtag/transactions                    |  108 +++
 MAINTAINERS                                        |   10 +
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/jtag/Kconfig                               |   30 +
 drivers/jtag/Makefile                              |    2 +
 drivers/jtag/jtag-aspeed.c                         |  786 ++++++++++++++++++++
 drivers/jtag/jtag.c                                |  273 +++++++
 include/linux/jtag.h                               |   41 +
 include/uapi/linux/jtag.h                          |  105 +++
 14 files changed, 1440 insertions(+), 0 deletions(-)
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

