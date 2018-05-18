Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZrbSAgyTWwmxIGleSF9JvU9q13vG9La1F8mCnjrkA8NFkU8sXleuboeuferKNH96nVxCGTw
ARC-Seal: i=1; a=rsa-sha256; t=1526606465; cv=none;
        d=google.com; s=arc-20160816;
        b=ZkdyitjH+ZbtN7vDhsbJ4gxejSdPfjVfzP+55rh6Rq/q5xj8dtN/rYV1eHoVraBjmc
         5WBYJ+8m8lSVQzT/qqpbBuR4vLf0nc3Ql0w5YFlgxwYF7ycZksECbZxOinMy2M6JQw6w
         d3awrLRgjKuDSP9QLXARlVz6tEy5rZ2ORn6bFaxZNUfhr5Z+btXfsvK64sArt7Ugtuou
         ZGPKgcpVjBYYd4Q4jxG0NeJYG3M/cAlQKaKzdgL4zo622QST9lVfuSMSIxs8AZSYOJ+T
         PGxK7Jy2WdAA8xnRn3jSM43USceEcnpZr+GwGmuFIowPRVzj7eHe4EhOlRYU9e6BNINg
         fSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3Mcv6EvYSab+wfHdoJPUgg0/1xIKwPWynBvaKsUsXu4=;
        b=iJFtl3+oAd6V8nwzK313U/fugER3WYYZTFVqX2EpHzcxNASYJjIZNv9EcY/XWZuafE
         a2oPLeox5YEuzDY22TeNZYOkhA+wDmUnm8VYw0QBEFyVbIf2qqtwuqHUtFqYzsQAHF6a
         JuqbbnfBgT5xikYlHjEeMa2PZpQBcNLVKlFJ7oLisJOmT6vLoB0HCrVnmbCqzFkJbsvE
         5Tg9xen0/6No8Q7bw68KFGcI52ylNn4ZC5aqmaZRFg4jrVDVQDJ832PKZzWJ1YuQyyAK
         FpDJocw+JIrhIANyfBDJGWbiI5Pb1OMgcQ5wSybyP79Ctde+Y1j7Uen4dn31656Xhfm+
         0u3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
From: Kim Phillips <kim.phillips@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Rik van Riel <riel@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <treding@nvidia.com>,
	Todd Kjos <tkjos@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kim Phillips <kim.phillips@arm.com>
Subject: [PATCH 1/6] coresight: remove CORESIGHT_LINKS_AND_SINKS dependencies and selections
Date: Thu, 17 May 2018 20:20:19 -0500
Message-Id: <20180518012024.22645-1-kim.phillips@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517070643.GC13919@kroah.com>
References: <20180517070643.GC13919@kroah.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600762901299441866?=
X-GMAIL-MSGID: =?utf-8?q?1600762901299441866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A coresight topology doesn't need to include links, i.e., a source can
be directly connected to a sink.  As such, selecting and/or depending on
LINKS_AND_SINKS is no longer needed.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index ef9cb3c164e1..83fb78651ef9 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -23,7 +23,6 @@ config CORESIGHT_LINKS_AND_SINKS
 
 config CORESIGHT_LINK_AND_SINK_TMC
 	bool "Coresight generic TMC driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for the Trace Memory Controller driver.
 	  Depending on its configuration the device can act as a link (embedded
@@ -33,7 +32,6 @@ config CORESIGHT_LINK_AND_SINK_TMC
 
 config CORESIGHT_SINK_TPIU
 	bool "Coresight generic TPIU driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for the Trace Port Interface Unit driver,
 	  responsible for bridging the gap between the on-chip coresight
@@ -44,7 +42,6 @@ config CORESIGHT_SINK_TPIU
 
 config CORESIGHT_SINK_ETBV10
 	bool "Coresight ETBv1.0 driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for the Embedded Trace Buffer version 1.0 driver
 	  that complies with the generic implementation of the component without
@@ -53,7 +50,6 @@ config CORESIGHT_SINK_ETBV10
 config CORESIGHT_SOURCE_ETM3X
 	bool "CoreSight Embedded Trace Macrocell 3.x driver"
 	depends on !ARM64
-	select CORESIGHT_LINKS_AND_SINKS
 	help
 	  This driver provides support for processor ETM3.x and PTM1.x modules,
 	  which allows tracing the instructions that a processor is executing
@@ -63,7 +59,6 @@ config CORESIGHT_SOURCE_ETM3X
 config CORESIGHT_SOURCE_ETM4X
 	bool "CoreSight Embedded Trace Macrocell 4.x driver"
 	depends on ARM64
-	select CORESIGHT_LINKS_AND_SINKS
 	help
 	  This driver provides support for the ETM4.x tracer module, tracing the
 	  instructions that a processor is executing. This is primarily useful
@@ -72,7 +67,6 @@ config CORESIGHT_SOURCE_ETM4X
 
 config CORESIGHT_DYNAMIC_REPLICATOR
 	bool "CoreSight Programmable Replicator driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for dynamic CoreSight replicator link driver.
 	  The programmable ATB replicator allows independent filtering of the
@@ -81,7 +75,6 @@ config CORESIGHT_DYNAMIC_REPLICATOR
 config CORESIGHT_STM
 	bool "CoreSight System Trace Macrocell driver"
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
-	select CORESIGHT_LINKS_AND_SINKS
 	select STM
 	help
 	  This driver provides support for hardware assisted software
-- 
2.17.0
