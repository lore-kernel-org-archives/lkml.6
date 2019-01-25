Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A953C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1627218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="FsmFCwOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfAYSRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:17:20 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36948 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfAYSRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:17:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so8347496oia.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ziixczQ8t4XLDxRc81EnNF1hboSAnqIXd1tODKLp5mY=;
        b=FsmFCwOelIgZvDUKMMTQK59CyyFu4pCiu3T7fIDeAOvdNeaR6XvHXBHTwsrN/lBGpe
         dsLoOCIjUYBcB4p1ul/gNO0HWEQWQv2tqjgGBdi/eV+zX7HMdlptSsxEUSDsWH+sYlBn
         AHzvufuCofwZ5qwJCPWCVupnbZW9pm2UTi+pGkUOHsAdBxIo0FxBGm9NClvoQrryKvK0
         Y9ZLRDS+Cqqup0BSVyVHDEipNhUnSfQp1gOqSmAQEpRI/tOAIeM+wJmwsgB3qKhB/MO9
         ChPNSvO+1SqWJRD10fVvBWmETv8UL4sE8asWlmIA4AagKwpC737GwU2RpalaGWMl93ho
         BDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ziixczQ8t4XLDxRc81EnNF1hboSAnqIXd1tODKLp5mY=;
        b=btKacmqoK+8qvNKBThq1rgFqLtIEXXtP/N1Wny+u/+3ugNKbSkzJKmKNCUKUAkoLu8
         E/XaIMon058bpB6Q9R32llcM6f9wiU0zUF28xVgfYxciy5kiGHJOoTcn0DOwOHCfvyGl
         aq8MEzyLTuXI66L4aSjBJoVKt/YtlXL5dGJxIK3GHlLgDbr/97GDCqX82dpW8BfpAx2J
         2DBOLuyijGmaYCUgdwYazl/QFYhQmpR5i6ENZrjHGZys5R0oh+XB+u+P0N59gSb9ECNt
         6Va4M5I2AqiIFmvWLBIECZx9EMHRKaBORnBuRURMvWqYUmfoJJyil2zM9PGc94dEvRlH
         MwoA==
X-Gm-Message-State: AJcUukcvbazLy5Q6KXXY5z8L0iyGllcOSCE+nx38LhbGJiPpuXK4gJKr
        cUBo68+ZaVbT7oQ043l/YoIkiO3L64U=
X-Google-Smtp-Source: AHgI3IZlYzd1p/UyEtE9jwMOKqLM5gzHUXnXDRjfqE04SH9PVPymZkXM8f/SGSSgmWrmvT79cGTp0Q==
X-Received: by 2002:aca:c003:: with SMTP id q3mr1885902oif.119.1548440236642;
        Fri, 25 Jan 2019 10:17:16 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id l204sm1461179oia.54.2019.01.25.10.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:17:15 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-accelerators@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        ogabbay@habana.ai, airlied@redhat.com, jglisse@redhat.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 1/5] drivers/accel: Introduce subsystem
Date:   Fri, 25 Jan 2019 10:16:12 -0800
Message-Id: <20190125181616.62609-2-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190125181616.62609-1-olof@lixom.net>
References: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
 <20190125181616.62609-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're starting to see more of these kind of devices, the current
upcoming wave will likely be around machine learning and inference
engines. A few drivers have been added to drivers/misc for this, but
it's timely to make it into a separate group of drivers/subsystem, to
make it easier to find them, and to encourage collaboration between
contributors.

Over time, we expect to build shared frameworks that the drivers will
make use of, but how that framework needs to look like to fill the needs
is still unclear, and the best way to gain that knowledge is to give the
disparate implementations a shared location.

There has been some controversy around expectations for userspace
stacks being open. The clear preference is to see that happen, and any
driver and platform stack that is delivered like that will be given
preferential treatment, and at some point in the future it might
become the requirement. Until then, the bare minimum we need is an
open low-level userspace such that the driver and HW interfaces can be
exercised if someone is modifying the driver, even if the full details
of the workload are not always available.

Bootstrapping this with myself and Greg as maintainers (since the current
drivers will be moving out of drivers/misc). Looking forward to expanding
that group over time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 MAINTAINERS            |  8 ++++++++
 drivers/Kconfig        |  2 ++
 drivers/Makefile       |  1 +
 drivers/accel/Kconfig  | 16 ++++++++++++++++
 drivers/accel/Makefile |  5 +++++
 5 files changed, 32 insertions(+)
 create mode 100644 drivers/accel/Kconfig
 create mode 100644 drivers/accel/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index ddcdc29dfe1f6..8a9bbaf8f6e90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7033,6 +7033,14 @@ W:	https://linuxtv.org
 S:	Supported
 F:	drivers/media/platform/sti/hva
 
+HW ACCELERATOR OFFLOAD SUBSYSTEM
+M:	Olof Johansson <olof@lixom.net>
+M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+L:	linux-accelerators@lists.ozlabs.org
+S:	Supported
+F:	drivers/accel/
+F:	Documentation/accelerators/
+
 HWPOISON MEMORY FAILURE HANDLING
 M:	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
 L:	linux-mm@kvack.org
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 4f9f99057ff85..3cc461f325569 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -228,4 +228,6 @@ source "drivers/siox/Kconfig"
 
 source "drivers/slimbus/Kconfig"
 
+source "drivers/accel/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 04da7876032cc..e4be06579cc5d 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -186,3 +186,4 @@ obj-$(CONFIG_MULTIPLEXER)	+= mux/
 obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
 obj-$(CONFIG_SIOX)		+= siox/
 obj-$(CONFIG_GNSS)		+= gnss/
+obj-$(CONFIG_ACCEL)		+= accel/
diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
new file mode 100644
index 0000000000000..13b36c0398895
--- /dev/null
+++ b/drivers/accel/Kconfig
@@ -0,0 +1,16 @@
+#
+# Drivers for hardware offload accelerators
+# See Documentation/accel/README.rst for more details
+#
+
+menuconfig ACCEL
+	bool "Hardware offload accelerator support"
+        help
+	  HW offload accelerators are used for high-bandwidth workloads
+	  where a higher-level kernel/userspace interface isn't suitable.
+
+if ACCEL
+
+comment "HW Accellerator drivers"
+
+endif
diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
new file mode 100644
index 0000000000000..343bbb8f45a14
--- /dev/null
+++ b/drivers/accel/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for accel devices
+#
+
-- 
2.11.0

