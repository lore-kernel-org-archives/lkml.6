Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbeDPTfk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 15:35:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38520 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753435AbeDPTfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 15:35:34 -0400
X-Google-Smtp-Source: AIpwx49RAGKkKUzlTNPVffA2aGYSA1zlS6aknUOCG5l11I1UWkXQmAQsCTzABjJcaTPYKLkeRZWvTw==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben.Gainey@arm.com
Subject: [PATCH 3/3] coresight: Grouping all perf tools oriented section together
Date: Mon, 16 Apr 2018 13:35:27 -0600
Message-Id: <1523907327-20979-4-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523907327-20979-1-git-send-email-mathieu.poirier@linaro.org>
References: <1523907327-20979-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch groups together section pertaining to the perf tools.  That way
everything is at the same place rather than spread out.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight.txt | 72 +++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 8caae8050a60..32c5b159e8fc 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -345,42 +345,7 @@ More information on the above and other example on how to use Coresight with
 the perf tools can be found in the "HOWTO.md" file of the openCSD gitHub
 repository [3].
 
-How to use the STM module
--------------------------
-
-Using the System Trace Macrocell module is the same as the tracers - the only
-difference is that clients are driving the trace capture rather
-than the program flow through the code.
-
-As with any other CoreSight component, specifics about the STM tracer can be
-found in sysfs with more information on each entry being found in [1]:
-
-root@genericarmv8:~# ls /sys/bus/coresight/devices/20100000.stm
-enable_source   hwevent_select  port_enable     subsystem       uevent
-hwevent_enable  mgmt            port_select     traceid
-root@genericarmv8:~#
-
-Like any other source a sink needs to be identified and the STM enabled before
-being used:
-
-root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20010000.etf/enable_sink
-root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20100000.stm/enable_source
-
-From there user space applications can request and use channels using the devfs
-interface provided for that purpose by the generic STM API:
-
-root@genericarmv8:~# ls -l /dev/20100000.stm
-crw-------    1 root     root       10,  61 Jan  3 18:11 /dev/20100000.stm
-root@genericarmv8:~#
-
-Details on how to use the generic STM API can be found here [2].
-
-[1]. Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
-[2]. Documentation/trace/stm.txt
-
-
-Using perf tools
-----------------
+2.1) AutoFDO analysis using the perf tools:
 
 perf can be used to record and analyze trace of programs.
 
@@ -428,3 +393,38 @@ sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tuto
 	$ taskset -c 2 ./sort_autofdo
 	Bubble sorting array of 30000 elements
 	5806 ms
+
+
+How to use the STM module
+-------------------------
+
+Using the System Trace Macrocell module is the same as the tracers - the only
+difference is that clients are driving the trace capture rather
+than the program flow through the code.
+
+As with any other CoreSight component, specifics about the STM tracer can be
+found in sysfs with more information on each entry being found in [1]:
+
+root@genericarmv8:~# ls /sys/bus/coresight/devices/20100000.stm
+enable_source   hwevent_select  port_enable     subsystem       uevent
+hwevent_enable  mgmt            port_select     traceid
+root@genericarmv8:~#
+
+Like any other source a sink needs to be identified and the STM enabled before
+being used:
+
+root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20010000.etf/enable_sink
+root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20100000.stm/enable_source
+
+From there user space applications can request and use channels using the devfs
+interface provided for that purpose by the generic STM API:
+
+root@genericarmv8:~# ls -l /dev/20100000.stm
+crw-------    1 root     root       10,  61 Jan  3 18:11 /dev/20100000.stm
+root@genericarmv8:~#
+
+Details on how to use the generic STM API can be found here [2].
+
+[1]. Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
+[2]. Documentation/trace/stm.txt
+[3]. https://github.com/Linaro/perf-opencsd
-- 
2.7.4
