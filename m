Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9067EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AD620882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N72kE8qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfA3XSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:18:09 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42032 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfA3XSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:18:08 -0500
Received: by mail-io1-f65.google.com with SMTP id x6so1039083ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTN83rpOWJ9BmqZh+1Cy4cDYbZ9G1V3zAYmNZPyjQCc=;
        b=N72kE8qm7CPyUrpF6J/iTvHUNpkQVX6nJxy2urHOxsnbQm/3D3ggR1+cVjYrOClG4B
         CZrv4LSxAeiOAz+1QuXmtcoLuAS+WSvBEuNyvqELaYi8WrPKOJraWeUvwfQAc93DtFeT
         ZIQQmzl9PCNOP0UIBiK/QAe7Cp0s+zzHVQb1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTN83rpOWJ9BmqZh+1Cy4cDYbZ9G1V3zAYmNZPyjQCc=;
        b=Wxvq7UZYaG15k/xNq/eSMbv5zRCiqS7T9szWBU49f/BjY0ovzU0ZkFs0Z2SpRB9s9p
         3U2dtD863VSbt05N4wjeRno3b391zUDGg/HVEdRbUfqXs8psPZPW0CZZVEKrsffmvIOZ
         7A8Z8mAp6qrPgBdiamMmt5c3CLYSdg4t6kRdd6ulT0ZkVTW5X/cT+/cPxP154AhxepUX
         iefP81iSePR39OQRoUBw+uDEMYsOWiFkNTaMgR+wLdx+g9CPXRtGQb3RlKfvQfxg9EMv
         +ltO8oozM/nC74j7b17qfKb8r2Zjk/W1pkhWRmezK8xjRlfJh5slXJrdvv/qUxa1GBsf
         SXrw==
X-Gm-Message-State: AJcUukc8aoVK3bXpqIPCM0t1HeQ/pN7Lh/M42xyigd0JiERK1b+anCwu
        t5w3XlD61QRT9kcDEG68WbHkpPk5/Hc=
X-Google-Smtp-Source: AHgI3IYd4KqACWtPHs0YwHfqIdZvNldyZzaYrMc6gC2ZSqZnNMEDKfHx9NwVXMDjTc9aJBKx16GdFQ==
X-Received: by 2002:a6b:38d7:: with SMTP id f206mr18265214ioa.265.1548886762521;
        Wed, 30 Jan 2019 14:19:22 -0800 (PST)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id x128sm1945475itb.8.2019.01.30.14.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:19:21 -0800 (PST)
From:   Nick Crews <ncrews@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, sjg@chromium.org, dmitry.torokhov@gmail.com,
        dlaurie@chromium.org, Nick Crews <ncrews@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Duncan Laurie <dlaurie@google.com>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH v5 0/3] platform/chrome: Add basic support for Wilco EC
Date:   Wed, 30 Jan 2019 15:19:14 -0700
Message-Id: <20190130221917.229071-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
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
sequences to the EC. Later, I will hopefully include more specialized
drivers such as an RTC driver, a keyboard backlight driver, etc.

The entry point of the driver is wilco_ec/core.c,
which is responsible for several tasks:
- Initialize the register interface that is used by wilco_ec_mailbox()
- Create a platform device which is picked up by the debugfs driver

A full thread of the development of these patches can be found at
https://chromium-review.googlesource.com/c/1323832. This thread contains
comments and revisions that could be helpful in understanding how the
driver arrived at the state it is in now. The thread also contains some
ChromeOS specific patches that actually enable the driver. If you want
to test the patch yourself, you would have to install the ChromeOS SDK
and cherry pick in these patches.

Thank you for your comments!

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

Duncan Laurie (3):
  cros_ec: Remove cros_ec dependency in lpc_mec
  platform/chrome: Add new driver for Wilco EC
  platform/chrome: Add support for raw commands in debugfs

 Documentation/ABI/testing/debugfs-wilco-ec |  23 ++
 drivers/platform/chrome/Kconfig            |   4 +-
 drivers/platform/chrome/Makefile           |   2 +
 drivers/platform/chrome/cros_ec_lpc_mec.c  |  52 ++++-
 drivers/platform/chrome/cros_ec_lpc_mec.h  |  43 ++--
 drivers/platform/chrome/cros_ec_lpc_reg.c  |  47 ++---
 drivers/platform/chrome/wilco_ec/Kconfig   |  20 ++
 drivers/platform/chrome/wilco_ec/Makefile  |   6 +
 drivers/platform/chrome/wilco_ec/core.c    | 114 ++++++++++
 drivers/platform/chrome/wilco_ec/debugfs.c | 223 ++++++++++++++++++++
 drivers/platform/chrome/wilco_ec/mailbox.c | 232 +++++++++++++++++++++
 include/linux/platform_data/wilco-ec.h     | 138 ++++++++++++
 12 files changed, 844 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-wilco-ec
 create mode 100644 drivers/platform/chrome/wilco_ec/Kconfig
 create mode 100644 drivers/platform/chrome/wilco_ec/Makefile
 create mode 100644 drivers/platform/chrome/wilco_ec/core.c
 create mode 100644 drivers/platform/chrome/wilco_ec/debugfs.c
 create mode 100644 drivers/platform/chrome/wilco_ec/mailbox.c
 create mode 100644 include/linux/platform_data/wilco-ec.h

-- 
2.20.1.495.gaa96b0ce6b-goog

