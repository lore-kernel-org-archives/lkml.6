Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB4FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82882184C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="mLYsB2dT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfAYVNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:13:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43077 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYVNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:13:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so4690320pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 13:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=KUXovKS0xIuwSgNrsoHtTs16lnhv8GpV/pYpoguqCc8=;
        b=mLYsB2dTXjJ/xD8eH9WwhTEUMq93HOwFdnaXTZ5zUQuDwFyQQBqtdWhdd3UmZZ2wz6
         9kGkdU8JOZveLAPxPd4pjBihLAAqGMRxLAuAp97FLduGYHeE1v90cuy6YC9ehasi2/fX
         gEVwcJ21I9HzIYmX0Q1cqIxHFq5ZqGw9uadml97hLHed6Awwe2DOQ0REDnBklI3gAPIu
         7NO7dkfU7plGEnFsz4DV1zEUnMsb46ELacX91RSR01v2BeqtqkK5OQR9ZdLfEHjfnunm
         3ih6eNF+rKclJDaRDoN5isMTvkvouAE57dvlZe3SkA5t5Rbot7rftSuM9s2nMVW976Bh
         Tbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=KUXovKS0xIuwSgNrsoHtTs16lnhv8GpV/pYpoguqCc8=;
        b=XZQo6FAvKBkQkBe3UuUTXrLTm+wbsHdoXYe7fVnMuU4OAun5Ps0dzveLlC22wSFsO4
         OKstC++dxucwpqnhv+IjW6n08GENNDIf5xLcj/Y3CHH+cQP8emtghsrDIVW+2Trkns45
         ZPGXffy/bzvmR1H74GStA+KoQDjFsLDYyfdvt1AXps77pTt++qw8+UQ4UEETF8BdCqrd
         tql3+YCEb/ujZeeyPZHc2u+Rd8Hhbx8E3yD1HvYPFm3pd/AMlqyjASN9MHC/NGCuRm3F
         alje3PMkRS4KhKQJIGTajzBRD4uyg/1DmslBUxgBOYrXtg57qmkHxsaLqS2/Fdy7G+qY
         +UuQ==
X-Gm-Message-State: AJcUukdQnO7vb6JaXwJec3IF2TMozVw4CpEQ69ISksM9yr1Tmvlcnsh9
        hVRuDDm608ni+emuH2GUI1/sriT1T48=
X-Google-Smtp-Source: ALg8bN597xGqmzVTaqcpRFiPOz6bLJS8pWbaJNCcn8EnxjXA+epKnJN/En5mYp38mitq9xuYb+dexQ==
X-Received: by 2002:a62:22d4:: with SMTP id p81mr12922876pfj.16.1548450828226;
        Fri, 25 Jan 2019 13:13:48 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id m19sm50414462pgn.35.2019.01.25.13.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 13:13:47 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-accelerators@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        ogabbay@habana.ai, airlied@redhat.com, jglisse@redhat.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v2 1/5] drivers/accel: Introduce subsystem
Date:   Fri, 25 Jan 2019 13:13:35 -0800
Message-Id: <20190125211335.65783-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190125181616.62609-2-olof@lixom.net>
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

v2: 
I had missed a git add of the Documentation/ piece, which is the most
important piece of this anyway. Sigh.

 Documentation/accelerators/README.rst | 42 +++++++++++++++++++++++++++++++++++
 MAINTAINERS                           |  8 +++++++
 drivers/Kconfig                       |  2 ++
 drivers/Makefile                      |  1 +
 drivers/accel/Kconfig                 | 16 +++++++++++++
 drivers/accel/Makefile                |  5 +++++
 6 files changed, 74 insertions(+)
 create mode 100644 Documentation/accelerators/README.rst
 create mode 100644 drivers/accel/Kconfig
 create mode 100644 drivers/accel/Makefile

diff --git a/Documentation/accelerators/README.rst b/Documentation/accelerators/README.rst
new file mode 100644
index 0000000000000..79049ff99e93e
--- /dev/null
+++ b/Documentation/accelerators/README.rst
@@ -0,0 +1,42 @@
+.. _readme:
+
+Hardware offload accelerator subsystem
+======================================
+
+This is a brief overview of the subsystem (grouping) of hardware
+accelerators kept under drivers/accel
+
+Types of hardware supported
+---------------------------
+
+  The general types of hardware supported are hardware devices that has
+  general interactions of sending commands and buffers to the hardware,
+  returning completions and possible filled buffers back, together
+  with the usual driver pieces around hardware control, setup, error
+  handling, etc.
+
+  Drivers that fit into other subsystems are expected to be merged
+  there, and use the appropriate userspace interfaces of said functional
+  areas. We don't expect to see drivers for network, storage, graphics
+  and similar hardware implemented by drivers here.
+
+Expectations for contributions
+------------------------------
+
+ - Platforms and hardware that has fully open stacks, from Firmware to
+   Userspace, are always going to be given preferential treatment. These
+   platforms give the best insight for behavior and interaction of all
+   layers, including ability to improve implementation across the stack
+   over time.
+
+ - If a platform is partially proprietary, it is still expected that the
+   portions that interact the driver can be shared in a form that allows
+   for exercising the hardware/driver and evolution of the interface over
+   time. This could be separated into a shared library and test/sample
+   programs, for example.
+
+ - Over time, there is an expectation to converge drivers over to shared
+   frameworks and interfaces. Until then, the general rule is that no
+   more than one driver per vendor will be acceptable. For vendors that
+   aren't participating in the work towards shared frameworks over time,
+   we reserve the right to phase out support for the hardware.
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

