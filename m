Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZpYf51kOoiqfP04sq4xvv2UmQH66c3TZU3WGTYWo3VbaU2CYHIWmtMdYAwgHsV2pXclkk/4
ARC-Seal: i=1; a=rsa-sha256; t=1525806417; cv=none;
        d=google.com; s=arc-20160816;
        b=pxk3L16Kfvcfs3qyjJIGZQHYsWUqBy8bHDJKOVKwkkLFgDzX0tgfbm/8P5xcuCxBG8
         gQqj7E7CHCILbia6ZB25rDTfLrhHm5DRZKdtJkdTgvwMS0o5yn5/RyefpUsUyn19+Q9C
         nrUgJ8jklb4checu6YcKFOrPGcGQ2MG8FZQXpgFmQbipVfNsPSR4EksUJTzF+nhOFLHO
         8q6YFkUS5+Tl1AuFiyFgVSYgTRJNBN1nyz3Eb8+LRDwXCkFOeIajwVFWP6yNu9u8Yxg2
         8Fg9Nsj/s5zifQvJDldIvgnKX1FXVBVzzkzPUoqWUQ/rFNt15pfGDY51uEIFrQK3UUwN
         p8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=uwWjrYCe2jUvk/SG5tqmFUNOHEPZ50ht4CQ+iv+KKgY=;
        b=xg0oejLVc+qYolPyiTY0rC6uicI6rDGpYi32n7mS+xkm8rsv5jFlhTYsmIgfLXHBL5
         0G8AATsKCO+f5LI7j3pehmfPB8y5FGYUTgUzftbQFC2Z0NRjsHDDc0ZPtdF/YlGr3C6/
         CFlZecOwKKFOJOdBEQc0wOLlZODDcsoX1aJMEgurUtJVesL1BuYxtJYIM1XNkUOzS4Y4
         B79GWAyxAC8tizpMpP10FuVvuK3ZlFbsvZdcL5Hpl1z7uqOPCLpDQI5K5p5zzUOJSqQz
         urIl9xU3hvNJfucHF0GRgIMTUszsF/Akm7d17UWj5k8Bb20nGBp+aVPIKo1QNQBDWOhg
         qq0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Date: Tue, 8 May 2018 14:06:55 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Kim
 Phillips <kim.phillips@arm.com>, Kirill Tkhai <ktkhai@virtuozzo.com>, Mike
 Rapoport <rppt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Pavel
 Tatashin <pasha.tatashin@oracle.com>, Rik van Riel <riel@redhat.com>, Robin
 Murphy <robin.murphy@arm.com>, Russell King <linux@armlinux.org.uk>,
 Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] coresight: remove CORESIGHT_LINKS_AND_SINKS
 dependencies
Message-Id: <20180508140655.b6d065db6670669336e00db8@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923990258486157?=
X-GMAIL-MSGID: =?utf-8?q?1599923990258486157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A coresight topology doesn't need to include links anymore, i.e., a source can
be directly connected to a sink.  As such the dependency is no longer needed.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 09a682013ea2..f1e05fbef257 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -30,7 +30,7 @@ config CORESIGHT_LINKS_AND_SINKS
 
 config CORESIGHT_LINK_AND_SINK_TMC
 	tristate "Coresight generic TMC driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
+	depends on CORESIGHT
 	help
 	  This enables support for the Trace Memory Controller driver.
 	  Depending on its configuration the device can act as a link (embedded
@@ -43,7 +43,7 @@ config CORESIGHT_LINK_AND_SINK_TMC
 
 config CORESIGHT_SINK_TPIU
 	tristate "Coresight generic TPIU driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
+	depends on CORESIGHT
 	help
 	  This enables support for the Trace Port Interface Unit driver,
 	  responsible for bridging the gap between the on-chip coresight
@@ -57,7 +57,7 @@ config CORESIGHT_SINK_TPIU
 
 config CORESIGHT_SINK_ETBV10
 	tristate "Coresight ETBv1.0 driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
+	depends on CORESIGHT
 	help
 	  This enables support for the Embedded Trace Buffer version 1.0 driver
 	  that complies with the generic implementation of the component without
@@ -68,7 +68,7 @@ config CORESIGHT_SINK_ETBV10
 
 config CORESIGHT_SOURCE_ETM3X
 	tristate "CoreSight Embedded Trace Macrocell 3.x driver"
-	depends on !ARM64 && CORESIGHT_LINKS_AND_SINKS
+	depends on CORESIGHT && !ARM64
 	help
 	  This driver provides support for processor ETM3.x and PTM1.x modules,
 	  which allows tracing the instructions that a processor is executing
@@ -80,7 +80,7 @@ config CORESIGHT_SOURCE_ETM3X
 
 config CORESIGHT_SOURCE_ETM4X
 	tristate "CoreSight Embedded Trace Macrocell 4.x driver"
-	depends on ARM64 && CORESIGHT_LINKS_AND_SINKS
+	depends on CORESIGHT && ARM64
 	help
 	  This driver provides support for the ETM4.x tracer module, tracing the
 	  instructions that a processor is executing. This is primarily useful
@@ -92,7 +92,7 @@ config CORESIGHT_SOURCE_ETM4X
 
 config CORESIGHT_DYNAMIC_REPLICATOR
 	tristate "CoreSight Programmable Replicator driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
+	depends on CORESIGHT
 	help
 	  This enables support for dynamic CoreSight replicator link driver.
 	  The programmable ATB replicator allows independent filtering of the
@@ -104,7 +104,7 @@ config CORESIGHT_DYNAMIC_REPLICATOR
 config CORESIGHT_STM
 	tristate "CoreSight System Trace Macrocell driver"
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
-	depends on STM && CORESIGHT_LINKS_AND_SINKS
+	depends on STM
 	help
 	  This driver provides support for hardware assisted software
 	  instrumentation based tracing. This is primarily used for
-- 
2.17.0
