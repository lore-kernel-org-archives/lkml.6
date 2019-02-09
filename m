Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C01C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D06821841
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mpyZHyLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBIAh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:37:28 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55289 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfBIAh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:37:28 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so13340435ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 16:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AwDFctvkVP4qZVeFKRxLFrV3QexC5S+ygXP8FqycL0=;
        b=mpyZHyLiCI0al8zZXvE0bKBaz3dzid7B//eb5RVi9yk07DvKRAzbGOm3cpVGe3ql4W
         FFJX+rAtsWNaGaKrb4/FnTCjxKhB4uHnA0j2Uow0Tl4Y0WA1FB4yAyvbPEHizA1Attre
         PhT1R+08yeHrWmDgGrddRg+daMLHsNBozpPQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AwDFctvkVP4qZVeFKRxLFrV3QexC5S+ygXP8FqycL0=;
        b=Hm9MgrrmA8QDyBzmengy7/BnvogShgA1DDb5hRc7kdKMo9jJH0y7ORrHpghnQqQ/Vl
         dp5cNKfIkv3RB5cKfM5zrIrDW2sb6B9ngSJbuDAzpQ0YGmuPYO8et3kNDHvskNU//Jmb
         unxOElHE4NF3eAabhYey5lJY5+7wObA8iyEuXdfQty0XmV5oDeE/gH3uUul0oawpGOvG
         Hmi9FoMsipPuGepva8FW7jlllYKhKB0yDlhhDo0idJphNDt/SLfdnhm7KrULf8h3lTDX
         WyuhyLsG8IrJweCfJr+ffZRC1+WcmspoBgdGeTLOK6eXae76v2n22T2no6Knm7TIiPeK
         kDHA==
X-Gm-Message-State: AHQUAuYPinLjtOI04aQJdH3MG2M31LfWMgJVGe1reF4KYtm2+EMFYR55
        NOMkguu6kCtcBttr6I3Vfp2OKmNqACc=
X-Google-Smtp-Source: AHgI3IaZrkBa1atlhXdtGSsolWd7iTc1QJ0/AZHrNlVuAKpUO+wYDO3v7K7v1JLKszNZxkkItZvkog==
X-Received: by 2002:a6b:914:: with SMTP id t20mr2361974ioi.63.1549672646339;
        Fri, 08 Feb 2019 16:37:26 -0800 (PST)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id s26sm1599631ioe.86.2019.02.08.16.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:37:25 -0800 (PST)
From:   Nick Crews <ncrews@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     alexandre.belloni@bootlin.com, eballetbo@gmail.com,
        sjg@chromium.org, dmitry.torokhov@gmail.com, groeck@chromium.org,
        dlaurie@chromium.org, Nick Crews <ncrews@chromium.org>,
        linux-rtc@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Duncan Laurie <dlaurie@google.com>
Subject: [PATCH v8 0/4] platform/chrome: Add basic support for Wilco EC
Date:   Fri,  8 Feb 2019 17:37:15 -0700
Message-Id: <20190209003719.161500-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There is a new chromebook that contains a different Embedded Controller
(codename Wilco) than the rest of the chromebook series. Thus the kernel
requires a different driver than the already existing and generalized
cros_ec_* drivers. The core of the communication with the EC
is implemented in wilco_ec/mailbox.c, using a simple byte-level protocol
with a checksum, transmitted over an eSPI bus.

In this patch series I only introduce a very barebones
driver with a debugfs interface for sending/receiving raw byte
sequences to the EC, as well as a standard RTC driver with read/write
functionality.  Later, I will hopefully include more specialized
drivers such as a keyboard backlight driver, an EC event notification node,
telemetry data query node, etc.

The entry point of the driver is wilco_ec/core.c,
which is responsible for several tasks:
- Initialize the register interface that is used by wilco_ec_mailbox()
- Create a platform device which is picked up by the debugfs driver
- Create a platform device which is picked up by the RTC driver

A full thread of the development of these patches can be found at
https://chromium-review.googlesource.com/c/1356082. This thread contains
comments and revisions that could be helpful in understanding how the
driver arrived at the state it is in now. The thread also contains some
ChromeOS specific patches that actually enable the driver. If you want
to test the patch yourself, you would have to install the ChromeOS SDK
and cherry pick in these patches, and even then you would need a Sarien
device to actually run it.

Thank you for your comments!

Changes in v8:
- Fix a comment about registering the debugfs driver

Changes in v7:
- Switch to #define for MAX_WORD_SIZE so array size
  can be determined at compile time.

Changes in v6:
- Re-added WILCO_EC_FLAG_EXTENDED_DATA and went back to always
  reading either EC_MAILBOX_DATA_SIZE or EC_MAILBOX_DATA_SIZE_EXTENDED
  bytes, since it turns out the EC always expects you to calculate the
  checksum over all of them.
- Split WILCO_EC_MSG_TELEMETRY into WILCO_EC_MSG_TELEMETRY_SHORT and
  WILCO_EC_MSG_TELEMETRY_LONG, since there will be two different
  commands.
- A couple comment and err message polishes
- s/4.19/5.1/ for kernel version in documentation, since that is
  the version this patch should land in.
- Instead of requiring at least 3 bytes for msg type and command,
  now just require two for msg type. We can skip the command.
- Fixed error checking in probe() so that errors are hidden, without
  causing more errors or unextpected behavior.
- Some comment polishing.
- In the core, actually unregister the debugfs child platform_device
- In the core, actually unregister the RTC child platform_device.

Changes in v5:
- move checking of NO_RESPONSE flag before timeout check,
  so now timeout doesn't always happen when EC isn't supposed
  to respond.
- rm WILCO_EC_FLAG_EXTENDED_DATA, that is already obvious from
  wilco_ec_message.response_size
- core now always continues regardless of debugfs failure
- mv documentation to file header
- Check for OOM
- rm unneeded check if debug_info is allocqated
- rm bogus comment
- add space around "+"
- rm WILCO_EC_FLAG_EXTENDED_DATA, that is already obvious from
  wilco_ec_message.response_size

Changes in v4:
- add #define DRV_NAME
- remove redundant Kconfig nesting
- changed my email to @chromium.org
- Add better explanation of what core.c does
- Change debugfs driver to be a separate module
- Change me email to @chromium.org from @google.com
- Change CONFIG_WILCO_EC_SYSFS_RAW to
  CONFIG_WILCO_EC_DEBUGFS
- Change me email to @chromium.org from @google.com
- Move "Add RTC driver" before "Add sysfs attributes" so that
  it could get accepted earlier, since it is less contentious

Changes in v3:
- Change <= to >= in mec_in_range()
- Add " - EC_HOST_CMD_REGION0" to offset arg for io_bytes_mec()
- remove unused ret in probe()
- Add newline spacer in probe()
- rm unnecessary res in get_resource()
- s/8bit/8-bit
- rm first sleep when sending command to EC
- Move the attribute to the debugfs system
- Move the implementation to debugfs.c
- Improve the raw hex parsing
- Encapsulate global variables in one object
- Add safety check when passing less than 3 bytes
- Move documentation to debugfs-wilco-ec
- rm #define for driver name
- Don't compute weekday when reading from RTC.
  Still set weekday when writing, as RTC needs this
  to control advanced power scheduling
- rm check for invalid month data
- Set range_min and range_max on rtc_device

Changes in v2:
- Fixed kernel-doc comments
- Fixed include of linux/mfd/cros_ec_lpc_mec.h
- cros_ec_lpc_mec_in_range() returns -EINVAL on error
- Added parens around macro variables
- Remove COMPILE_TEST from Kconfig because inb()/outb()
won't work on anything but X86
- Add myself as module author
- Tweak mailbox()
- Add sysfs documentation
- rm duplicate EC_MAILBOX_DATA_SIZE defs
- Make docstrings follow kernel style
- Fix tags in commit msg
- Move Kconfig to subdirectory
- Reading raw now includes ASCII translation
- rm license boiler plate
- rm "wilco_ec_rtc -" prefix in docstring
- Make rtc driver its own module within the drivers/rtc/ directory
- Register a rtc device from core.c that is picked up by this driver

Nick Crews (4):
  cros_ec: Remove cros_ec dependency in lpc_mec
  platform/chrome: Add new driver for Wilco EC
  platform/chrome: Add support for raw commands in debugfs
  platform/chrome: rtc: Add RTC driver

 Documentation/ABI/testing/debugfs-wilco-ec |  23 ++
 drivers/platform/chrome/Kconfig            |   4 +-
 drivers/platform/chrome/Makefile           |   2 +
 drivers/platform/chrome/cros_ec_lpc_mec.c  |  52 ++++-
 drivers/platform/chrome/cros_ec_lpc_mec.h  |  43 ++--
 drivers/platform/chrome/cros_ec_lpc_reg.c  |  47 ++--
 drivers/platform/chrome/wilco_ec/Kconfig   |  21 ++
 drivers/platform/chrome/wilco_ec/Makefile  |   6 +
 drivers/platform/chrome/wilco_ec/core.c    | 136 ++++++++++++
 drivers/platform/chrome/wilco_ec/debugfs.c | 238 +++++++++++++++++++++
 drivers/platform/chrome/wilco_ec/mailbox.c | 236 ++++++++++++++++++++
 drivers/rtc/Kconfig                        |  11 +
 drivers/rtc/Makefile                       |   1 +
 drivers/rtc/rtc-wilco-ec.c                 | 177 +++++++++++++++
 include/linux/platform_data/wilco-ec.h     | 144 +++++++++++++
 15 files changed, 1081 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-wilco-ec
 create mode 100644 drivers/platform/chrome/wilco_ec/Kconfig
 create mode 100644 drivers/platform/chrome/wilco_ec/Makefile
 create mode 100644 drivers/platform/chrome/wilco_ec/core.c
 create mode 100644 drivers/platform/chrome/wilco_ec/debugfs.c
 create mode 100644 drivers/platform/chrome/wilco_ec/mailbox.c
 create mode 100644 drivers/rtc/rtc-wilco-ec.c
 create mode 100644 include/linux/platform_data/wilco-ec.h

-- 
2.20.1.791.gb4d0f1c61a-goog

