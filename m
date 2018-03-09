Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932625AbeCISn3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:43:29 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:42001 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeCISn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:43:26 -0500
X-Google-Smtp-Source: AG47ELuVvhDoLtkUQ23tFlTcIPs7/YptNMU9Ioub+Xtqz8JXI0jvXhmb5ZHReygZu7N0NSIzaV2HHw==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc: benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 5/8] counter: 104-quad-8: Documentation: Add Generic Counter sysfs documentation
Date: Fri,  9 Mar 2018 13:43:19 -0500
Message-Id: <c821777fbc8399583f49fe4058ca75a9b7d4581b.1520614431.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1520614431.git.vilhelm.gray@gmail.com>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds standard documentation for the Generic Counter interface
userspace sysfs attributes of the 104-QUAD-8 driver.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-counter-104-quad-8       | 115 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 116 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
new file mode 100644
index 000000000000..4269b438185a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
@@ -0,0 +1,115 @@
+What:		/sys/bus/counter/devices/counterX/countY_count_mode
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count mode for channel Y. The preset value for channel Y is used
+		by the count mode where required. The following count modes are
+		available:
+
+		Normal:
+			Counting is continuous in either direction.
+
+		Range Limit:
+			An upper or lower limit is set, mimicking limit switches
+			in the mechanical counterpart. The upper limit is set to
+			the preset value, while the lower limit is set to 0. The
+			counter freezes at count = preset when counting up, and
+			at count = 0 when counting down. At either of these
+			limits, the counting is resumed only when the count
+			direction is reversed.
+
+		Non-recycle:
+			Counter is disabled whenever a 24-bit count overflow or
+			underflow takes place. The counter is re-enabled when a
+			new count value is loaded to the counter via a preset
+			operation or write to raw.
+
+		Modulo-N:
+			A count boundary is set between 0 and the preset value.
+			The counter is reset to 0 at count = preset when
+			counting up, while the counter is set to the preset
+			value at count = 0 when counting down; the counter does
+			not freeze at the bundary points, but counts
+			continuously throughout.
+
+What:		/sys/bus/counter/devices/counterX/countY_count_mode_available
+What:		/sys/bus/counter/devices/counterX/countY_noise_error_available
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Count Y
+		configuration are listed in this file.
+
+What:		/sys/bus/counter/devices/counterX/countY_direction
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the count direction of
+		Count Y. Two count directions are available: Forward and
+		Backward.
+
+What:		/sys/bus/counter/devices/counterX/countY_enable
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether channel Y inputs A and B are enabled. Valid attribute
+		values are boolean.
+
+What:		/sys/bus/counter/devices/counterX/countY_noise_error
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates whether excessive noise is
+		present at the channel Y count inputs in quadrature clock mode;
+		irrelevant in non-quadrature (Pulse-Direction) clock mode.
+
+What:		/sys/bus/counter/devices/counterX/countY_preset
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If the counter device supports preset registers, the preset
+		count for channel Y is provided by this attribute.
+
+What:		/sys/bus/counter/devices/counterX/countY_preset_enable
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether to set channel Y counter with channel Y preset value
+		when channel Y index input is active, or continuously count.
+		Valid attribute values are boolean.
+
+What:		/sys/bus/counter/devices/counterX/signalY_index_polarity
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Active level of channel Y-16 index input; irrelevant in
+		non-synchronous load mode.
+
+What:		/sys/bus/counter/devices/counterX/signalY_index_polarity_available
+What:		/sys/bus/counter/devices/counterX/signalY_synchronous_mode_available
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Signal Y
+		configuration are listed in this file.
+
+What:		/sys/bus/counter/devices/counterX/signalY_synchronous_mode
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configure channel Y-16 counter for non-synchronous or
+		synchronous load mode. Synchronous load mode cannot be selected
+		in non-quadrature (Pulse-Direction) clock mode.
+
+		Non-synchronous:
+			A logic low level is the active level at this index
+			input. The index function (as enabled via preset_enable)
+			is performed directly on the active level of the index
+			input.
+
+		Synchronous:
+			Intended for interfacing with encoder Index output in
+			quadrature clock mode. The active level is configured
+			via index_polarity. The index function (as enabled via
+			preset_enable) is performed synchronously with the
+			quadrature clock on the active level of the index input.
diff --git a/MAINTAINERS b/MAINTAINERS
index febe27a9962e..8134050d175a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -270,6 +270,7 @@ ACCES 104-QUAD-8 DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
 F:	drivers/counter/104-quad-8.c
 
-- 
2.16.2
