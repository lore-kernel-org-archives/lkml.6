Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbeCISmq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:42:46 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:40784 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751543AbeCISmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:42:43 -0500
X-Google-Smtp-Source: AG47ELvQf/5twqoDvzRuT5at6ObMPlie3+EErmmwSPR416f74jT0H0LtqzdzQDVpRu0g65KUzvTmeg==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc: benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 2/8] counter: Documentation: Add Generic Counter sysfs documentation
Date: Fri,  9 Mar 2018 13:42:35 -0500
Message-Id: <06d985b7f63471c5c5b74c11eb6c76b5ff32fdd5.1520614431.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1520614431.git.vilhelm.gray@gmail.com>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds standard documentation for the userspace sysfs
attributes of the Generic Counter interface.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 120 ++++++++++++++++++++++++++++
 MAINTAINERS                                 |   1 +
 2 files changed, 121 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
new file mode 100644
index 000000000000..64785aab1763
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -0,0 +1,120 @@
+What:		/sys/bus/counter/devices/counterX/countY/count
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count data of Count Y. The following data types are available:
+
+		COUNT_POSITION_UNSIGNED:
+			Unsigned integer value representing position.
+
+		COUNT_POSITION_SIGNED:
+			Signed integer value representing position.
+
+What:		/sys/bus/counter/devices/counterX/countY/function
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count function mode of Count Y; count function evaluation is
+		triggered by conditions specified by the countY_signalZ_action
+		attributes. The following count functions are available:
+
+		Increase:
+			Accumulated count is incremented.
+
+		Decrease:
+			Accumulated count is decremented.
+
+		Pulse-Direction:
+			Rising edges on quadrature pair signal A updates the
+			respective count. The input level of quadrature pair
+			signal B determines direction.
+
+		Quadrature x1:
+			If direction is forward, rising edges on quadrature pair
+			signal A updates the respective count; if the direction
+			is backward, falling edges on quadrature pair signal A
+			updates the respective count. Quadrature encoding
+			determines the direction.
+
+		Quadrature x2:
+			Any state transition on quadrature pair signal A updates
+			the respective count. Quadrature encoding determines the
+			direction.
+
+		Quadrature x4:
+			Any state transition on either quadrature pair signals
+			updates	the respective count. Quadrature encoding
+			determines the direction.
+
+What:		/sys/bus/counter/devices/counterX/countY/function_available
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available count function modes for the
+		configuration of the respective Count Y are listed in this file.
+
+What:		/sys/bus/counter/devices/counterX/countY/name
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Count Y. If possible, this should match the name of the
+		respective channel as it appears in the device datasheet
+		documentation text.
+
+What:		/sys/bus/counter/devices/counterX/countY/signalZ_action
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Action mode of Count Y for Signal Z. This attribute indicates
+		the condition of Signal Z that triggers the count function
+		evaluation for Count Y. The following action modes are
+		available:
+
+		None:
+			Signal does not trigger the count function. In
+			Pulse-Direction count function mode, this Signal is
+			evaluated as Direction.
+
+		Rising Edge:
+			Low state transitions to high state.
+
+		Falling Edge:
+			High state transitions to low state.
+
+		Both Edges:
+			Any state transition.
+
+What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available action modes are listed in this file
+		for the configuration of the respective Synapse associating
+		Signal Z to Count Y.
+
+What:		/sys/bus/counter/devices/counterX/name
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		the Counter. This should match the name of the device as it
+		appears in its respective datasheet documentation text.
+
+What:		/sys/bus/counter/devices/counterX/signalY/signal
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Signal data of Signal Y. The following data types are available:
+
+		SIGNAL_LEVEL:
+			Respective input has two discrete states: Low and High.
+
+What:		/sys/bus/counter/devices/counterX/signalY/name
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Signal Y. If possible, this should match the name of the
+		respective signal as it appears in the device datasheet
+		documentation text.
diff --git a/MAINTAINERS b/MAINTAINERS
index 2be01a95b7a5..2a7bf2f84272 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3672,6 +3672,7 @@ COUNTER SUBSYSTEM
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-counter*
 F:	drivers/counter/
 F:	include/linux/counter.h
 
-- 
2.16.2
