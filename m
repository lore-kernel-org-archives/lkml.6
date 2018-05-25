Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030369AbeEYUcE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:32:04 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43598 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030297AbeEYUba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:31:30 -0400
X-Google-Smtp-Source: AB8JxZrtSRumhmbPhL2+OFQN55ZaoeDRXlRMpbplDZODDINIQ6jRj7N47ZHI1swPorYtJHjsgaCTCQ==
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 10/11] dt-bindings: misc: add bindings for throttler
Date: Fri, 25 May 2018 13:30:42 -0700
Message-Id: <20180525203043.249193-11-mka@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180525203043.249193-1-mka@chromium.org>
References: <20180525203043.249193-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 .../devicetree/bindings/misc/throttler.txt    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/throttler.txt

diff --git a/Documentation/devicetree/bindings/misc/throttler.txt b/Documentation/devicetree/bindings/misc/throttler.txt
new file mode 100644
index 000000000000..92f13e94451a
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/throttler.txt
@@ -0,0 +1,41 @@
+Throttler driver
+
+The Throttler is used for non-thermal throttling of system components like
+CPUs or devfreq devices.
+
+
+Optional properties:
+--------------------
+- cpufreq:			A sub-node which is container of only cpufreq
+  Type: sub-mode		nodes, used to describe the throttling settings
+				for a CPU (or CPU group sharing the same policy).
+
+- devfreq:			A sub-node which is container of only devfreq
+  Type: sub-mode		nodes, used to describe the throttling settings
+				for a devfreq device.
+
+cpufreq node:
+=============
+
+Required properties:
+--------------------
+- cpu:				The id of the CPU to be throttled.
+  Type: unsigned
+  Size: one cell
+
+- throttling-frequencies:	Frequencies used for throttling, corresponding
+  Type: unsigned		to throttling level 1, 2, ...
+  Size: array
+
+
+devfreq node:
+=============
+
+Required properties:
+--------------------
+- devfreq:			A phandle of the devfreq device to be throttled.
+  Type: phandle
+
+- throttling-frequencies:	Frequencies used for throttling, corresponding
+  Type: unsigned		to throttling level 1, 2, ...
+  Size: array
-- 
2.17.0.921.gf22659ad46-goog
