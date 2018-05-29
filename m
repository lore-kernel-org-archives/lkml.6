Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754844AbeE2HDc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:03:32 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:35840 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754780AbeE2HDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:03:24 -0400
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v4 8/8] Documentation/ABI: Add documentation mlxreg-io sysfs interfaces
Date: Tue, 29 May 2018 08:59:07 +0000
Message-Id: <1527584347-167548-3-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527584347-167548-1-git-send-email-vadimp@mellanox.com>
References: <1527584347-167548-1-git-send-email-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for mlxreg-io driver sysfs interfaces for user space
access to system's power resets control, reset causes monitoring,
programmable devices version reading and devices selection control.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
v4:
 Comments pointed out by Greg:
 Add Documentation/ABI/ entries for the new sysfs files.
---
 Documentation/ABI/stable/sysfs-driver-mlxreg-io | 51 +++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-mlxreg-io

diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
new file mode 100644
index 0000000..fcd659e
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -0,0 +1,51 @@
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
+							cause_aux_pwr_or_ref
+							cause_asic_thermal
+							cause_hotswap_or_wd
+							cause_fw_reset
+							cause_long_pb
+							cause_main_pwr_fail
+							cause_short_pb
+							cause_sw_reset
+Date:		May 2018
+KernelVersion:	4.18
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
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
+							cpld1_version
+							cpld2_version
+Date:		May 2018
+KernelVersion:	4.18
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	These files show with which CPLD versions have been burned
+		on carrier and switch boards.
+
+		The files are read only.
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/select_iio
+Date:		May 2018
+KernelVersion:	4.18
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	This file allows iio devices selection.
+
+		The file is read/write.
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/psu1_on
+		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/psu2_on
+		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/pwr_cycle
+Date:		May 2018
+KernelVersion:	4.18
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	These files allow assert system's power cycling and PS units
+		on/off switching.
+
+		The files are write only.
-- 
2.1.4
