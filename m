Return-Path: <alexander.shishkin@intel.com>
X-Cyrus-Session-Id: sloti22d1t05-602900-1522322093-2-12082036522603864583
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='192.55.52.115', Host='mga14.intel.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alexander.shishkin@intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522322093; b=aaofu7b6egTRgpninBNGTGtLfV6LjkI5eyB/9X/iwtAdLdKIPp
    0/JqcZitl8pWSFnMx2ICgAwWtq8QSL6JGB+LL0AltyXThqFJLSOY4LrKm56pbbP/
    Zc0rUp5vgeZ3G7kc4jUAq2BZDM0PPNFm9TH3douFfW79Ln37R6nLORguoqYZzSdH
    zW5QArjQKlhc/BhZsGXkE+OXQi+KwdArGk1D4JYIUcr/3AvV3d5X10Neh6GPiRHb
    /IrNmxBCtCo1LpWqaB21Y5OsnexZScCtqSiavqcdOuDlPl4Tp0LTuHu3A/+N4auB
    3NCMz5t92GQEl4T6NIt2dgBJzormAY3sVHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=fm2; t=1522322093; bh=gVXxAGYGenmNwtk
    YqNcXVPDbvUyOK+QD+1JFpQ97tX0=; b=I3wD6WXEHxEpggce/h/JkVGjm0nrH2+
    ixxjo2zSfKLvfJfrQ4FH4w/uR7XbhCzSO0EqUEN9JtLq6egB0NJPcxmj4PV3TAKE
    dB+Fo7LICgaA13pqF073GHvu8SOXEoWAGxBV005AQIHMaiKHuvBVZllsjV1aoPi+
    48rTlSaYIGOqlviMrE3HwxS4iuv6/9nYKQ226L9ahAcrba4L/1vFFn5KahLo5HRL
    REA0DhwOrZ07jEcw1zYVt5h7hJ8q9KJdpV6+XiqZTQCVwxk12dDU8uOk1JJK+WNG
    753ZHk+kmjKRoWcVJI8V5YqhJ5Q5q/iTP4wslcoH0GdqY+9h3A/DfjQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.115 (mga14.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga14.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga14.intel.com x-ptr-lookup=mga14.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.115 (mga14.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga14.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga14.intel.com x-ptr-lookup=mga14.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM2x7CoshoORj7nn5Be4PxF1Qs5QJCcMhWOeHq9sV0D62qsddTlYCcXeKEpNVctQ2zr38xqjRUh5OsB56yphuWBxtd2PVHFar4OG2h+toR2M18e5/oFq
    KfX5UcR2zKCEeHVRhkVru650Fr6R6ITbSXb7gmJiiagW67zds6T3LUeQPNnoJ4JJyFaFD2K7kaUSQLU23XEFh7lB7udIk3FQXb8=
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=yPSvGpHfZI9xrpk/7ex/9g==:117
    a=yPSvGpHfZI9xrpk/7ex/9g==:17 a=v2DPQv5-lfwA:10 a=QyXUC8HyAAAA:8
    a=kBxi59hnBVbXfqtExjIA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="39127692"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 02/10] stm class: Add SPDX GPL-2.0 header to replace GPLv2 boilerplate
Date: Thu, 29 Mar 2018 14:14:10 +0300
Message-Id: <20180329111418.9416-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
References: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This adds SPDX GPL-2.0 header to to stm core files and removes the
GPLv2 boilerplate text.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/console.c   | 10 +---------
 drivers/hwtracing/stm/core.c      | 10 +---------
 drivers/hwtracing/stm/dummy_stm.c | 10 +---------
 drivers/hwtracing/stm/heartbeat.c | 10 +---------
 drivers/hwtracing/stm/policy.c    | 10 +---------
 drivers/hwtracing/stm/stm.h       | 10 +---------
 include/linux/stm.h               | 10 +---------
 include/uapi/linux/stm.h          |  9 ---------
 8 files changed, 7 insertions(+), 72 deletions(-)

diff --git a/drivers/hwtracing/stm/console.c b/drivers/hwtracing/stm/console.c
index c9d9a8d2ff52..a00f65e21747 100644
--- a/drivers/hwtracing/stm/console.c
+++ b/drivers/hwtracing/stm/console.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Simple kernel console driver for STM devices
  * Copyright (c) 2014, Intel Corporation.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  * STM console will send kernel messages over STM devices to a trace host.
  */
 
diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index f129869e05a9..05386b76465e 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * System Trace Module (STM) infrastructure
  * Copyright (c) 2014, Intel Corporation.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  * STM class implements generic infrastructure for  System Trace Module devices
  * as defined in MIPI STPv2 specification.
  */
diff --git a/drivers/hwtracing/stm/dummy_stm.c b/drivers/hwtracing/stm/dummy_stm.c
index c5f94ca31c4d..63288020ea5b 100644
--- a/drivers/hwtracing/stm/dummy_stm.c
+++ b/drivers/hwtracing/stm/dummy_stm.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * A dummy STM device for stm/stm_source class testing.
  * Copyright (c) 2014, Intel Corporation.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  * STM class implements generic infrastructure for  System Trace Module devices
  * as defined in MIPI STPv2 specification.
  */
diff --git a/drivers/hwtracing/stm/heartbeat.c b/drivers/hwtracing/stm/heartbeat.c
index 3da7b673aab2..7db42395e131 100644
--- a/drivers/hwtracing/stm/heartbeat.c
+++ b/drivers/hwtracing/stm/heartbeat.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Simple heartbeat STM source driver
  * Copyright (c) 2016, Intel Corporation.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  * Heartbeat STM source will send repetitive messages over STM devices to a
  * trace host.
  */
diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index 33e9a1b6ea7c..3fd07e275b34 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * System Trace Module (STM) master/channel allocation policy management
  * Copyright (c) 2014, Intel Corporation.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  * A master/channel allocation policy allows mapping string identifiers to
  * master and channel ranges, where allocation can be done.
  */
diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
index 4e8c6926260f..923571adc6f4 100644
--- a/drivers/hwtracing/stm/stm.h
+++ b/drivers/hwtracing/stm/stm.h
@@ -1,16 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * System Trace Module (STM) infrastructure
  * Copyright (c) 2014, Intel Corporation.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  * STM class implements generic infrastructure for  System Trace Module devices
  * as defined in MIPI STPv2 specification.
  */
diff --git a/include/linux/stm.h b/include/linux/stm.h
index 210ff2292361..c6f577ab6f21 100644
--- a/include/linux/stm.h
+++ b/include/linux/stm.h
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * System Trace Module (STM) infrastructure apis
  * Copyright (C) 2014 Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 
 #ifndef _STM_H_
diff --git a/include/uapi/linux/stm.h b/include/uapi/linux/stm.h
index dbffdc23d804..29c89be72275 100644
--- a/include/uapi/linux/stm.h
+++ b/include/uapi/linux/stm.h
@@ -3,15 +3,6 @@
  * System Trace Module (STM) userspace interfaces
  * Copyright (c) 2014, Intel Corporation.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  * STM class implements generic infrastructure for  System Trace Module devices
  * as defined in MIPI STPv2 specification.
  */
-- 
2.16.2
