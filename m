Return-Path: <alexander.shishkin@intel.com>
X-Cyrus-Session-Id: sloti22d1t05-602900-1522322100-2-4016080557079147687
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='192.55.52.120', Host='mga04.intel.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alexander.shishkin@intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522322098; b=q65wG2uZDvm3eJfZ6wAHzg1ZCG88gfjKnFUkRkxxgBJYfHZ8iZ
    /V6WPs03SklIm70BXhugZmr8XEQrF5/aFGjXyk0P6hwOU1qK61and3gYblzgARac
    IokzzxWqXw9eU1+Vek33DwRrunPtbuZicxG8Yv4ov5M4Ql5qlcqhkZhpNYe40/y8
    TBH9h7DiaDEH5vIeQB+PQbqciHUIx8zl1m/4WcWjygrp0gy11Qiql4UrjlD2Z45+
    qMPK7r+P29DYVumzOx8S2f5zS/KLfP2WGyzHmsUxxGmyfh4oK2siU4wL2Dd2Wk9D
    uGpu3frcFnqlC8uzR4zA/QratItejqNuwA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=fm2; t=1522322098; bh=LQG+tFz6njMNJmK
    y8Vx+qQ6m+pna4AmnkG4t1P6FUAs=; b=sT2WgrwMIYSGebm6tqBmzL7qhsr0V7R
    wEx5TNlXmW9Yg7p+BYN1E9Ztkz3FSkU8Z/kppb/NjSkM5q1ckjiHnZL8ADpumuUA
    rBeIxqNIjKoMBHk7KdnyqgRvljMLCmUw8q6/aMQM2SPnVs/tvYip90hveqMoor9s
    k6d99Lhqwy/DrqFe+SjXC3jIQNtBfGUfi+yrB/Ja593OCTAzn1HVVpjibQ1vkGko
    KDAqTw0cPAs2uJnUgznZHTg+CzBUNX1zMU6JJs+bieQQeTC/JqG+QPVHMyg/7ECf
    YyjJxPDN6juEBrCg78z+Tu4/Xb38w3XZIhajHDI4QQqY5eBwYBOMq1Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.120 (mga04.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga04.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga04.intel.com x-ptr-lookup=mga04.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.120 (mga04.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga04.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga04.intel.com x-ptr-lookup=mga04.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAMDoPMbmYx4Lp37Z+JXSpg96p6JUf/jy87becrprpJzHKNRvVti+sPaO0olrgoyD+X8JZFGgnzC9zR6eqBbAA7246tj+MWOP41nuuqIhtyx5cxKeK9A
    XSn4YW0pHJb9hWKiatIvm8lF/iNq/JwGFTIrScgUO2gnuz86UIAG+aKSsOD4xicdCzlxJOeEmY/zdN0TUhUa1lWC+8OHQkHwAL4=
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=83rbKwn1RWDzQc6g+5U3cQ==:117
    a=83rbKwn1RWDzQc6g+5U3cQ==:17 a=v2DPQv5-lfwA:10 a=QyXUC8HyAAAA:8
    a=aExLWGMWlofNjBILTbQA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="212311744"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 04/10] intel_th: Add SPDX GPL-2.0 header to replace GPLv2 boilerplate
Date: Thu, 29 Mar 2018 14:14:12 +0300
Message-Id: <20180329111418.9416-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
References: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This adds SPDX GPL-2.0 header to the Trace Hub driver and removes the
GPLv2 boilerplate text.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c     | 10 +---------
 drivers/hwtracing/intel_th/debug.c    | 10 +---------
 drivers/hwtracing/intel_th/debug.h    | 10 +---------
 drivers/hwtracing/intel_th/gth.c      | 10 +---------
 drivers/hwtracing/intel_th/gth.h      | 10 +---------
 drivers/hwtracing/intel_th/intel_th.h | 10 +---------
 drivers/hwtracing/intel_th/msu.c      | 10 +---------
 drivers/hwtracing/intel_th/msu.h      | 10 +---------
 drivers/hwtracing/intel_th/pci.c      | 10 +---------
 drivers/hwtracing/intel_th/pti.c      | 10 +---------
 drivers/hwtracing/intel_th/pti.h      | 10 +---------
 drivers/hwtracing/intel_th/sth.c      | 10 +---------
 drivers/hwtracing/intel_th/sth.h      | 10 +---------
 13 files changed, 13 insertions(+), 117 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 1a023e30488c..bf1e4543c722 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel(R) Trace Hub driver core
  *
  * Copyright (C) 2014-2015 Intel Corporation.
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
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
diff --git a/drivers/hwtracing/intel_th/debug.c b/drivers/hwtracing/intel_th/debug.c
index 788a1f0a97ad..ff79063118a0 100644
--- a/drivers/hwtracing/intel_th/debug.c
+++ b/drivers/hwtracing/intel_th/debug.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel(R) Trace Hub driver debugging
  *
  * Copyright (C) 2014-2015 Intel Corporation.
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
 
 #include <linux/types.h>
diff --git a/drivers/hwtracing/intel_th/debug.h b/drivers/hwtracing/intel_th/debug.h
index 88311bad3ba4..78bd7e4bf9ce 100644
--- a/drivers/hwtracing/intel_th/debug.h
+++ b/drivers/hwtracing/intel_th/debug.h
@@ -1,16 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Intel(R) Trace Hub driver debugging
  *
  * Copyright (C) 2014-2015 Intel Corporation.
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
 
 #ifndef __INTEL_TH_DEBUG_H__
diff --git a/drivers/hwtracing/intel_th/gth.c b/drivers/hwtracing/intel_th/gth.c
index 018678ec3c13..8426b7970c14 100644
--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel(R) Trace Hub Global Trace Hub
  *
  * Copyright (C) 2014-2015 Intel Corporation.
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
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
diff --git a/drivers/hwtracing/intel_th/gth.h b/drivers/hwtracing/intel_th/gth.h
index f3d234251a12..6f2b0b930875 100644
--- a/drivers/hwtracing/intel_th/gth.h
+++ b/drivers/hwtracing/intel_th/gth.h
@@ -1,16 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Intel(R) Trace Hub Global Trace Hub (GTH) data structures
  *
  * Copyright (C) 2014-2015 Intel Corporation.
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
 
 #ifndef __INTEL_TH_GTH_H__
diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 99ad563fc40d..cdeed3b017d0 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -1,16 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Intel(R) Trace Hub data structures
  *
  * Copyright (C) 2014-2015 Intel Corporation.
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
 
 #ifndef __INTEL_TH_H__
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index dfb57eaa9f22..ede388309376 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel(R) Trace Hub Memory Storage Unit
  *
  * Copyright (C) 2014-2015 Intel Corporation.
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
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
diff --git a/drivers/hwtracing/intel_th/msu.h b/drivers/hwtracing/intel_th/msu.h
index 9b710e4aa98a..9cc8aced6116 100644
--- a/drivers/hwtracing/intel_th/msu.h
+++ b/drivers/hwtracing/intel_th/msu.h
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel(R) Trace Hub Memory Storage Unit (MSU) data structures
  *
  * Copyright (C) 2014-2015 Intel Corporation.
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
 
 #ifndef __INTEL_TH_MSU_H__
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index c2a2ce8ee541..c2e55e5d97f6 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel(R) Trace Hub pci driver
  *
  * Copyright (C) 2014-2015 Intel Corporation.
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
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
diff --git a/drivers/hwtracing/intel_th/pti.c b/drivers/hwtracing/intel_th/pti.c
index e96a1fcb57b2..56694339cb06 100644
--- a/drivers/hwtracing/intel_th/pti.c
+++ b/drivers/hwtracing/intel_th/pti.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel(R) Trace Hub PTI output driver
  *
  * Copyright (C) 2014-2016 Intel Corporation.
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
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
diff --git a/drivers/hwtracing/intel_th/pti.h b/drivers/hwtracing/intel_th/pti.h
index 30827be67b4c..e9381babc84c 100644
--- a/drivers/hwtracing/intel_th/pti.h
+++ b/drivers/hwtracing/intel_th/pti.h
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel(R) Trace Hub PTI output data structures
  *
  * Copyright (C) 2014-2015 Intel Corporation.
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
 
 #ifndef __INTEL_TH_STH_H__
diff --git a/drivers/hwtracing/intel_th/sth.c b/drivers/hwtracing/intel_th/sth.c
index b03444624648..4b7ae47789d2 100644
--- a/drivers/hwtracing/intel_th/sth.c
+++ b/drivers/hwtracing/intel_th/sth.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel(R) Trace Hub Software Trace Hub support
  *
  * Copyright (C) 2014-2015 Intel Corporation.
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
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
diff --git a/drivers/hwtracing/intel_th/sth.h b/drivers/hwtracing/intel_th/sth.h
index f1390cd4f2ed..f97fc0c51739 100644
--- a/drivers/hwtracing/intel_th/sth.h
+++ b/drivers/hwtracing/intel_th/sth.h
@@ -1,16 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Intel(R) Trace Hub Software Trace Hub (STH) data structures
  *
  * Copyright (C) 2014-2015 Intel Corporation.
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
 
 #ifndef __INTEL_TH_STH_H__
-- 
2.16.2
