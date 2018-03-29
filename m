Return-Path: <alexander.shishkin@intel.com>
X-Cyrus-Session-Id: sloti22d1t05-602900-1522322113-2-6606414557633922400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='134.134.136.20', Host='mga02.intel.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alexander.shishkin@intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522322113; b=ndEW2JO3TK5eNOHxpdOBPEIgyOpn0Ac3W2oKrCpd5VbkzLD4j/
    KWITRcF91S5UEw1xykEOF9jdWQvAZpLDi080JdtQi96LXroxDSlOo3uxRLSHjIZd
    ax/SMXlVV7olUu/n6WCtLDFNAzUazpHgcwmZEHIT37Uhw4UqsIU/ITYWlYnAdrMp
    zKOSpGvZ2QMFc4XmUNCcT8z5pJ6CgUb3N2r8BxwOtpUAWLALvIVfUITLgSyeM12X
    HDbqFkxxXoCo9j7G5rOGi8QL88q3dgqnASVIGi/4jqDm63NpENulzRfH4CSmmGOT
    WnZyNKYIyrs26BjEORMtaPhHInZYQxLUw/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=fm2; t=1522322113; bh=t3GFruyDCP9dgFO
    lF5dV4im8BNv1lF7usN2q0U2kKuQ=; b=HmTMrjVD59HtkalV8RQuluXV3afsFDd
    GLKtInFX2T5qTfdIxelWn2/bcTtfIqF+hg/WQKXxxQk5OaVT2br+vFISGREUpkc5
    ZViaPmQy8maitydbnvGDVnsBxwtXyNc3747dT/JwstpQrbf5UTH021c1fdNqJD2f
    MySuVtVXdzUa7/pTgXDvxi+0bObH1OG8nZW3vHkOUnkSyBSP/sMWhh8qSbJit/R3
    vMii8R2o9LNEaBnBnEIYdjPZdjV7lIIUURbXC75QUsZVV/FGHmblM3TQizE/XPWQ
    a79zGjeB8BxnuK6s0W6I2LnZtX4hTjY2B+Tt0MycBhS4q7YqcYy02Ag==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.20 (mga02.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga02.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga02.intel.com x-ptr-lookup=mga02.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.20 (mga02.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga02.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga02.intel.com x-ptr-lookup=mga02.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPuoddT9bGXJGOxk5TEonJ0CgFqX0TkWTkYGgIbknFErzzBqWRsMj715jNr6ZG2iI1fPqQtGmAJ2qWR8tuGttAb3VXCOHkwPhTKnH96MLmylrWc20jbO
    OI9KCew/JKOTIXsnLb97Kkin4T/Ra5yojy5/1trfxgy8jwk+vfs0tCNFa5Hp6hanB0t+y1we50vgUBrUlK9ALhdTPFMHbrYW5Dk=
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=h8G49c9N0KxIvQoKHXEdPQ==:117
    a=h8G49c9N0KxIvQoKHXEdPQ==:17 a=v2DPQv5-lfwA:10 a=QyXUC8HyAAAA:8
    a=fNXhSR_6l_v1xuvgjp0A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="29060085"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 09/10] intel_th: Add ACPI glue layer
Date: Thu, 29 Mar 2018 14:14:17 +0300
Message-Id: <20180329111418.9416-10-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
References: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Trace Hub devices now can be enumerated as ACPI devices, which
translates into "Host Debugger mode". There are two IDs: one for
PCH Trace Hub, and one for the uncore Trace Hub. These are expected
to stay the same across all platforms.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/Kconfig  | 12 ++++++
 drivers/hwtracing/intel_th/Makefile |  3 ++
 drivers/hwtracing/intel_th/acpi.c   | 79 +++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 drivers/hwtracing/intel_th/acpi.c

diff --git a/drivers/hwtracing/intel_th/Kconfig b/drivers/hwtracing/intel_th/Kconfig
index 1b412f8a56b5..ca0527d588e9 100644
--- a/drivers/hwtracing/intel_th/Kconfig
+++ b/drivers/hwtracing/intel_th/Kconfig
@@ -25,6 +25,18 @@ config INTEL_TH_PCI
 
 	  Say Y here to enable PCI Intel TH support.
 
+config INTEL_TH_ACPI
+	tristate "Intel(R) Trace Hub ACPI controller"
+	depends on ACPI
+	help
+	  Intel(R) Trace Hub may exist as an ACPI device. This option enables
+	  support glue layer for ACPI-based Intel TH. This typically implies
+	  'host debugger' mode, that is, the trace configuration and capture
+	  is handled by an external debug host and corresponding controls will
+	  not be available on the target.
+
+	  Say Y here to enable ACPI Intel TH support.
+
 config INTEL_TH_GTH
 	tristate "Intel(R) Trace Hub Global Trace Hub"
 	help
diff --git a/drivers/hwtracing/intel_th/Makefile b/drivers/hwtracing/intel_th/Makefile
index 880c9b5e8566..d9252fa8d9ca 100644
--- a/drivers/hwtracing/intel_th/Makefile
+++ b/drivers/hwtracing/intel_th/Makefile
@@ -6,6 +6,9 @@ intel_th-$(CONFIG_INTEL_TH_DEBUG) += debug.o
 obj-$(CONFIG_INTEL_TH_PCI)	+= intel_th_pci.o
 intel_th_pci-y			:= pci.o
 
+obj-$(CONFIG_INTEL_TH_ACPI)	+= intel_th_acpi.o
+intel_th_acpi-y			:= acpi.o
+
 obj-$(CONFIG_INTEL_TH_GTH)	+= intel_th_gth.o
 intel_th_gth-y			:= gth.o
 
diff --git a/drivers/hwtracing/intel_th/acpi.c b/drivers/hwtracing/intel_th/acpi.c
new file mode 100644
index 000000000000..87bc3744755f
--- /dev/null
+++ b/drivers/hwtracing/intel_th/acpi.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel(R) Trace Hub ACPI driver
+ *
+ * Copyright (C) 2017 Intel Corporation.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+
+#include "intel_th.h"
+
+#define DRIVER_NAME "intel_th_acpi"
+
+static const struct intel_th_drvdata intel_th_acpi_pch = {
+	.host_mode_only	= 1,
+};
+
+static const struct intel_th_drvdata intel_th_acpi_uncore = {
+	.host_mode_only	= 1,
+};
+
+static const struct acpi_device_id intel_th_acpi_ids[] = {
+	{ "INTC1000",	(kernel_ulong_t)&intel_th_acpi_uncore },
+	{ "INTC1001",	(kernel_ulong_t)&intel_th_acpi_pch },
+	{ "",		0 },
+};
+
+MODULE_DEVICE_TABLE(acpi, intel_th_acpi_ids);
+
+static int intel_th_acpi_probe(struct platform_device *pdev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	const struct acpi_device_id *id;
+	struct intel_th *th;
+
+	id = acpi_match_device(intel_th_acpi_ids, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	th = intel_th_alloc(&pdev->dev, (void *)id->driver_data,
+			    pdev->resource, pdev->num_resources, -1);
+	if (IS_ERR(th))
+		return PTR_ERR(th);
+
+	adev->driver_data = th;
+
+	return 0;
+}
+
+static int intel_th_acpi_remove(struct platform_device *pdev)
+{
+	struct intel_th *th = platform_get_drvdata(pdev);
+
+	intel_th_free(th);
+
+	return 0;
+}
+
+static struct platform_driver intel_th_acpi_driver = {
+	.probe		= intel_th_acpi_probe,
+	.remove		= intel_th_acpi_remove,
+	.driver		= {
+		.name			= DRIVER_NAME,
+		.acpi_match_table	= intel_th_acpi_ids,
+	},
+};
+
+module_platform_driver(intel_th_acpi_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel(R) Trace Hub ACPI controller driver");
+MODULE_AUTHOR("Alexander Shishkin <alexander.shishkin@intel.com>");
-- 
2.16.2
