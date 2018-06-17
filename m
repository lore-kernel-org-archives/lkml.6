Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091E4C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C469E20891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C469E20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934192AbeFQPU4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 11:20:56 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:55296 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933774AbeFQPU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 11:20:29 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 17 Jun 2018 18:03:48 +0300
Received: from r-mgtswh-226.mtr.labs.mlnx. (r-mgtswh-226.mtr.labs.mlnx [10.209.1.51])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w5HF1D6i002833;
        Sun, 17 Jun 2018 18:01:19 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v6 8/8] Documentation/ABI: Add documentation mlxreg-io sysfs interfaces
Date:   Sun, 17 Jun 2018 16:56:55 +0000
Message-Id: <1529254615-88124-3-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1529254615-88124-1-git-send-email-vadimp@mellanox.com>
References: <1529254615-88124-1-git-send-email-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for mlxreg-io platform driver sysfs interfaces to allow
user space access for system resets control, reset causes monitoring,
programmable devices version reading and device selection control.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
v5-v6:
 Changes added by Vadim:
 - Change kernel version from 4.18 to 4.19.
v4-v5:
 Comments pointed out by Darren:
 - Rename cause to reset.
 - Extend explanation in doc file.
 Changes added by Vadim:
 - Add two new attributes.
 - Re-arrange in alphabetic order after changes.
 - Change date from May to June.
v4:
 Comments pointed out by Greg:
 Add Documentation/ABI/ entries for the new sysfs files.
---
 Documentation/ABI/stable/sysfs-driver-mlxreg-io | 77 +++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-mlxreg-io

diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
new file mode 100644
index 0000000..815689b
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -0,0 +1,77 @@
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
+							asic_health
+
+Date:		June 2018
+KernelVersion:	4.19
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	This file shows ASIC health status. The possible values are:
+		0 - health failed, 2 - health OK, 3 - ASIC in booting state.
+
+		The files are read only.
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
+							cpld1_version
+							cpld2_version
+
+Date:		June 2018
+KernelVersion:	4.19
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	These files show with which CPLD versions have been burned
+		on carrier and switch boards.
+
+		The files are read only.
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/select_iio
+Date:		June 2018
+KernelVersion:	4.19
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	This file allows iio devices selection.
+
+		Attribute select_iio can be written with 0 or with 1. It
+		selects which one of iio devices can be accessed.
+
+		The file is read/write.
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/psu1_on
+		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/psu2_on
+		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/pwr_cycle
+		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/pwr_down
+Date:		June 2018
+KernelVersion:	4.19
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	These files allow asserting system power cycling, switching
+		power supply units on and off and system's main power domain
+		shutdown.
+		Expected behavior:
+		When pwr_cycle is written 1: auxiliary power domain will go
+		down and after short period (about 1 second) up.
+		When  psu1_on or psu2_on is written 1, related unit will be
+		disconnected from the power source, when written 0 - connected.
+		If both are written 1 - power supplies main power domain will
+		go down.
+		When pwr_down is written 1, system's main power domain will go
+		down.
+
+		The files are write only.
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
+							reset_aux_pwr_or_ref
+							reset_asic_thermal
+							reset_hotswap_or_wd
+							reset_fw_reset
+							reset_long_pb
+							reset_main_pwr_fail
+							reset_short_pb
+							reset_sw_reset
+Date:		June 2018
+KernelVersion:	4.19
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	These files show the system reset cause, as following: power
+		auxiliary outage or power refresh, ASIC thermal shutdown,
+		hotswap or watchdog, firmware reset, long press power button,
+		short press power button, software reset. Value 1 in file means
+		this is reset cause, 0 - otherwise. Only one of the above
+		causes could be 1 at the same time, representing only last
+		reset cause.
+
+		The files are read only.
-- 
2.1.4

