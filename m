Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZZyrC0ViHluOVQAAmS7hNA
	; Mon, 11 Jun 2018 11:52:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 874DB607A4; Mon, 11 Jun 2018 11:52:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRklG2LM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B89A860351;
	Mon, 11 Jun 2018 11:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B89A860351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeFKLwz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:52:55 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34099 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932906AbeFKLww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:52:52 -0400
Received: by mail-lf0-f65.google.com with SMTP id o9-v6so30094970lfk.1;
        Mon, 11 Jun 2018 04:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4yTnUIRQqW2qzf9vr96/0NqE1LgtoIc82s8o/BboLOA=;
        b=TRklG2LMmiwJ70M7xQE/rQAEf2Swz7zRaM44DDFFks6jVhxXDuCJntgNbPewMbK2eE
         vc29CGzhIlMKFvOwZJ8CVHuPo++OKVcoEjrF3ZkniJ9vG6cX/6zuZHqipftM7YfSaaan
         Jmtcw3mX+xlZYTlo1KbmYNfXnfKeEKtZDQzxqOxpUam9Fc/MNik55g3dOQ+2Ske2B+LT
         S95FnfjhtuwtZs0ym6R23pQCbAO/WoFpLdU9D3q6k7HPWjyAXYz16gVOYfjDX0NGj85a
         6pgtP87vms1WQGloge+Hq9InTP6WKQQgCPUJowV38oRTNShEnNw4/gvJjDJMSE61BZbI
         3f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4yTnUIRQqW2qzf9vr96/0NqE1LgtoIc82s8o/BboLOA=;
        b=ZPTVdkGvKkfdcOFApzGZGzjP7ZTJHot1kK32YwtueJnCLjmjWYxZq18RhuQOs2At/Y
         id4bfgO2ndl0H8cTlCLcG5IQAbkGtC+Qnoyo2vMGMnYrYQ1SW9T8S69TR2i7lGijrRr3
         wvZVL+JAYH0SfRAKcQAj1mYxLizIoj/FqCJnbHKD0vswf3c519I8yGkTuGGq0cBoxyib
         vX0vp/MmSZrepe2l1VkHDwLouMqtGsaEFcIVgbr7Y2dZ7SiHydsjEF376ucu2Qrr+Xhq
         nIBogm8GENNGIyYx8PbgLNBAPlVIKxaj4ehs0cnBpxE5Dddm5hSK0wkuqpwVsDE8lByq
         oPIw==
X-Gm-Message-State: APt69E0jIsHJK0XQN0NO6aSLgINu7DM8hUeTOzXFf1+4PCbVPSMhRxIL
        eBvUbPfFpdQmbe9LWGSiYw3wRFdK
X-Google-Smtp-Source: ADUXVKJw7eTMe336XGhSvBD1P1Jsfb7CeYrighAhuffJYJkZUzQmjDPq68aVkHLDVdY2ERkgHVbyig==
X-Received: by 2002:a2e:9ed3:: with SMTP id h19-v6mr781325ljk.88.1528717970722;
        Mon, 11 Jun 2018 04:52:50 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:52:49 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 00/19] Dynamically load/remove serdev devices via sysfs*
Date: Mon, 11 Jun 2018 13:52:16 +0200
Message-Id: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some situations where it is interesting to load/remove serdev
devices dynamically, like during board bring-up or when we are
developing a new driver or for devices that are neither described via
ACPI or device tree.

This implementation allows the creation of serdev devices via sysfs,
in a similar way as the i2c bus allows sysfs instantiation [1].

It also opens the door to create platform drivers for specific
platforms, such us notebooks or industrial computers, when their serial
devices are not described via DT or ACPI.

This patchset also supports automatic module load via udev/modprobe,
simplifying its use by the final user.

Currently, serdev does not manage ports that do not have a serdev device
defined at boot time. This implementation adds a new serdev module,
ttydev, that provides the same functionality of tty (it calls the
original one), but can be unloaded.

TL/DR:

When we want to create a new device, we just run:
root@qt5022:~# echo ttydev > /sys/bus/serial/devices/serial0/new_device

This will create a new device:
root@qt5022:~# ls /sys/bus/serial/devices/serial0-0/
driver	modalias  power  subsystem  tty  uevent

And load the required driver to use it:
root@qt5022:~# lsmod | grep serdev_ttydev
serdev_ttydev          16384  0

The device can be removed:
root@qt5022:~#
	echo serial0-0 > /sys/bus/serial/devices/serial0/delete_device

And now we can connect a new device:
root@qt5022:~# echo hci-ti > /sys/bus/serial/devices/serial0/new_device


Changelog v2:

New functionality:
- New functions: get/put controller add_probed_device
- Rave_sp: Match all the variants

Changes proposed by Andy Shevchenko <andy.shevchenko@gmail.com>
- Avoid strchr
- Terminators with no comma

[1] https://www.kernel.org/doc/Documentation/i2c/instantiating-devices

Ricardo Ribalda Delgado (24):
  serdev: Add id_table to serdev_device_driver
  Bluetooth: hci_bcm: Add serdev_id_table
  Bluetooth: hci_ll: Add serdev_id_table
  Bluetooth: hci_nokia: Add serdev_id_table
  serdev: Introduce modalias field
  serdev: Support bus matching with modalias field
  serdev: Allows dynamic creation of devices via sysfs
  serdev: Provide modalias attribute for modalias devices
  serdev: Provide modalias uevent for modalias devices
  file2alias: Support for serdev devices
  Bluetooth: hci_bcm: MODULE_DEVICE_TABLE(serdev)
  Bluetooth: hci_ll: MODULE_DEVICE_TABLE(serdev)
  Bluetooth: hci_nokia: MODULE_DEVICE_TABLE(serdev)
  mfd: rave-sp: MODULE_DEVICE_TABLE(serdev)
  net: qualcomm: MODULE_DEVICE_TABLE(serdev)
  serdev: ttyport: Move serport structure to its own header
  serdev: Mark controllers compatible with ttyport
  serdev: ttydev: Serdev driver that creates an standard TTY port
  serdev: Instantiate a ttydev serdev if acpi and of fails
  serdev: Make match_id accessible by drivers
  rave-sp: Support for variants on modalias drivers
  serdev: Replace IDA functions with IDR
  serdev: get/put controller
  serdev: serdev_controller_add_probed_device

 drivers/bluetooth/hci_bcm.c              |   8 +
 drivers/bluetooth/hci_ll.c               |  19 +++
 drivers/bluetooth/hci_nokia.c            |   8 +
 drivers/mfd/rave-sp.c                    |  25 ++-
 drivers/net/ethernet/qualcomm/qca_uart.c |   7 +
 drivers/tty/serdev/Kconfig               |  10 ++
 drivers/tty/serdev/Makefile              |   2 +
 drivers/tty/serdev/core.c                | 186 ++++++++++++++++++++---
 drivers/tty/serdev/serdev-ttydev.c       |  60 ++++++++
 drivers/tty/serdev/serdev-ttyport.c      |  10 +-
 drivers/tty/serdev/serport.h             |  16 ++
 include/linux/mod_devicetable.h          |  10 ++
 include/linux/serdev.h                   |  11 ++
 scripts/mod/devicetable-offsets.c        |   3 +
 scripts/mod/file2alias.c                 |  11 ++
 15 files changed, 360 insertions(+), 26 deletions(-)
 create mode 100644 drivers/tty/serdev/serdev-ttydev.c
 create mode 100644 drivers/tty/serdev/serport.h

-- 
2.17.1
