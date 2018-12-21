Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D236C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC75A21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ju6ieaqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbeLUPbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:31:24 -0500
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:56925
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732894AbeLUPbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFM2tQwGJF8eQRG0oAa6pjooJV+4+Ndr/Du0/0nWvFU=;
 b=ju6ieaqZHSgHigpwNe5VeRXvzuhvIeugaxNrye40NjH1lxvdGAFsgQNspRu/n1rbWrSzy3vWUgtMsbSOH82iwYBXdVP6+CnamnSSZsQp3A7/UQ081K2nKX2d1gA6alGLkCI3dCJ7UQiP+6IZKUOzf3tn/Qq1bhlf7aptk2Iaz84=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3488.eurprd04.prod.outlook.com (52.134.4.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Fri, 21 Dec 2018 15:31:13 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9%6]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 15:31:13 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/3] soc: fsl: add DPAA2 console support
Thread-Topic: [PATCH 3/3] soc: fsl: add DPAA2 console support
Thread-Index: AQHUmUI0CNZtplWE40CdxaJlcs+b1A==
Date:   Fri, 21 Dec 2018 15:31:13 +0000
Message-ID: <1545406240-3061-4-git-send-email-ioana.ciornei@nxp.com>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0082.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::26) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3488;6:P/gRuC9Cf9obWn6CSl1heMYZPQDUkI5velM1yVYW5IduZ8xDQxD8B1WCwWgj67jUgECOdrkmYI/iC5BdEj0Kt7NX7w9hUltcBjTepgNEVPfOXUIbbl+Dtr/HY65hh16+5OIA+VsFDuvblbXwAaiMveL1H1pQCa0ScpDEqOqYCnmVVLT7IYFLwdZRuYwZ4esrzD8NRqYrGHPazxGSpZQ0fVp+FJnCgowTaa8NpA3nEgAaM4wJy7Gnjza6Ox55U3tmUjUrfkRP0S2j8dz4LI7EbgaOxVwyYPh37zX6YqADj5ZuttFgmymjo928ESRohOu3GT+tkK65VkVBcoIcg2qoa5ucmwGu7tCDUXrtPhaKG2l+ZUuD2ZcM3on735GccB/HwYVMtCcShYYCd2pyPcDwynmEnYQdyM2aPL4jrY3HXdy2NaeAGyqnAlUwmQLGd/8nrSSoAO6futReDcPXD2liTw==;5:GKrxl0klzzWroUBcUJ+vtcOre7hbjdeZ+UrXMUxTRmj/xZEW0p9ZLNWQRmuqAgbfTjd7Q/wQyXKQsA661IFeeWuhqHMGBv6NcIRSYAZa2b1cXo4GRgEpZHUSdtC3znkCdXCZc1psNsCIxGZVUJQTh8HTp/zMOq7oliuW1OsthHM=;7:vZOwh46xzXuvX0vXPoGI40IBu1XSGrFtoJQKwl9IMNbQ21q+RFuWXLmxy8OKa4McnabWmVH7F51bePLM9dXxZrgmbuXlWpMWAOnR2Jtwvxg+whLrWUVFMxosjG4OHxiAyK4XH+5rlU+pK8uhYkpVtg==
x-ms-office365-filtering-correlation-id: 54743026-e872-437c-4419-08d66759570c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3488;
x-ms-traffictypediagnostic: VI1PR0402MB3488:
x-microsoft-antispam-prvs: <VI1PR0402MB3488E13A54AA3CC7E8CB9C9CE0B80@VI1PR0402MB3488.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3488;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3488;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(6512007)(53936002)(2906002)(71200400001)(71190400001)(86362001)(2201001)(26005)(14444005)(97736004)(256004)(102836004)(6486002)(110136005)(186003)(386003)(68736007)(99286004)(316002)(52116002)(305945005)(446003)(76176011)(36756003)(6116002)(25786009)(11346002)(66066001)(8936002)(105586002)(6436002)(106356001)(2616005)(476003)(54906003)(81166006)(81156014)(14454004)(44832011)(3846002)(6506007)(8676002)(478600001)(5660300001)(486006)(2501003)(4326008)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3488;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XLCFTzfgxKKlr2QED8X2sXgwPANQg6N8lAdXDsVdkeICiTZqvzg9XErFXe9zm7RBdhPSe7AmwcjA4VBK8ydM3tEDmHhQZSqqeOdKVGyLupgb1CciZsytD0B1p0PpJjrPG1f+JeIlGSiCs059WwD6ztfvv9uzpg4CR0Uq+5YZBBlvBZiacWWXrDhx0283AhA11FJSseeWxOqeP4tz5SBTGRQ81glMi3Q2G+1L/pWflRBkHdsJ71tQg1bwheZcyZSmx9aF+S8xnM3pJfLOchbxavVtq6mF0fHGGGua7zJdUMEHBJEZtoo/QeaTHuGR2JSp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54743026-e872-437c-4419-08d66759570c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 15:31:13.2175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3488
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DPAA2 MC and AIOP console log support.

The platform driver probes on the "dpaa2-console" device tree node
which describes the base firmware address needed in order to infer the
start address of both firmware logs: MC and AIOP.
It then exports two misc char devices which can be used to dump
the needed logs.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/Kconfig         |  10 ++
 drivers/soc/fsl/Makefile        |   1 +
 drivers/soc/fsl/dpaa2-console.c | 306 ++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 317 insertions(+)
 create mode 100644 drivers/soc/fsl/dpaa2-console.c

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 8f80e8b..94229a0 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -28,4 +28,14 @@ config FSL_MC_DPIO
 	  other DPAA2 objects. This driver does not expose the DPIO
 	  objects individually, but groups them under a service layer
 	  API.
+
+config DPAA2_CONSOLE
+	tristate "QorIQ DPAA2 console driver"
+	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X8=
6_LOCAL_APIC || PPC)))
+	default y
+	help
+	  Console driver for DPAA2 platforms. Exports 2 char devices,
+	  /dev/dpaa2_mc_console and /dev/dpaa2_aiop_console,
+	  which can be used to dump the Management Complex and AIOP
+	  firmware logs.
 endmenu
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 803ef1b..57762c9 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)		+=3D qe/
 obj-$(CONFIG_CPM)			+=3D qe/
 obj-$(CONFIG_FSL_GUTS)			+=3D guts.o
 obj-$(CONFIG_FSL_MC_DPIO) 		+=3D dpio/
+obj-$(CONFIG_DPAA2_CONSOLE)		+=3D dpaa2-console.o
diff --git a/drivers/soc/fsl/dpaa2-console.c b/drivers/soc/fsl/dpaa2-consol=
e.c
new file mode 100644
index 0000000..b088834
--- /dev/null
+++ b/drivers/soc/fsl/dpaa2-console.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* Copyright 2015-2016 Freescale Semiconductor Inc.
+ * Copyright 2018 NXP
+ */
+
+#define pr_fmt(fmt) "dpaa2-console: " fmt
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/miscdevice.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Roy Pledge <roy.pledge@nxp.com>");
+MODULE_DESCRIPTION("DPAA2 console driver");
+
+/* MC firmware base low/high registers indexes */
+#define MCFBALR_OFFSET 0
+#define MCFBAHR_OFFSET 1
+
+/* Bit masks used to get the most/least significant part of the MC base ad=
dr */
+#define MC_FW_ADDR_MASK_HIGH 0x1FFFF
+#define MC_FW_ADDR_MASK_LOW  0xE0000000
+
+#define MC_BUFFER_OFFSET 0x01000000
+#define MC_BUFFER_SIZE   (1024 * 1024 * 16)
+#define MC_OFFSET_DELTA  MC_BUFFER_OFFSET
+
+#define AIOP_BUFFER_OFFSET 0x06000000
+#define AIOP_BUFFER_SIZE   (1024 * 1024 * 16)
+#define AIOP_OFFSET_DELTA  0
+
+#define LOG_HEADER_FLAG_BUFFER_WRAPAROUND 0x80000000
+#define LAST_BYTE(a) ((a) & ~(LOG_HEADER_FLAG_BUFFER_WRAPAROUND))
+
+/* MC and AIOP Magic words */
+#define MAGIC_MC   0x4d430100
+#define MAGIC_AIOP 0x41494F50
+
+struct log_header {
+	__le32 magic_word;
+	char reserved[4];
+	__le32 buf_start;
+	__le32 buf_length;
+	__le32 last_byte;
+};
+
+struct console_data {
+	char *map_addr;
+	struct log_header *hdr;
+	char *start_addr;
+	char *end_addr;
+	char *end_of_data;
+	char *cur_ptr;
+};
+
+struct resource mc_base_addr;
+
+static inline void adjust_end(struct console_data *cd)
+{
+	u32 last_byte =3D readl(&cd->hdr->last_byte);
+
+	cd->end_of_data =3D cd->start_addr + LAST_BYTE(last_byte);
+}
+
+static u64 get_mc_fw_base_address(void)
+{
+	u64 mcfwbase =3D 0ULL;
+	u32 *mcfbaregs;
+
+	mcfbaregs =3D (u32 *)ioremap(mc_base_addr.start,
+				   resource_size(&mc_base_addr));
+	if (!mcfbaregs) {
+		pr_err("could not map MC Firmaware Base registers\n");
+		return -EIO;
+	}
+
+	mcfwbase  =3D readl(mcfbaregs + MCFBAHR_OFFSET) & MC_FW_ADDR_MASK_HIGH;
+	mcfwbase <<=3D 32;
+	mcfwbase |=3D readl(mcfbaregs + MCFBALR_OFFSET) & MC_FW_ADDR_MASK_LOW;
+	iounmap(mcfbaregs);
+
+	pr_debug("MC base address at 0x%016llx\n", mcfwbase);
+	return mcfwbase;
+}
+
+static ssize_t dpaa2_console_size(struct console_data *cd)
+{
+	ssize_t size;
+
+	if (cd->cur_ptr <=3D cd->end_of_data)
+		size =3D cd->end_of_data - cd->cur_ptr;
+	else
+		size =3D (cd->end_addr - cd->cur_ptr) +
+			(cd->end_of_data - cd->start_addr);
+
+	return size;
+}
+
+static int dpaa2_generic_console_open(struct inode *node, struct file *fp,
+				      u64 offset, u64 size,
+				      u32 expected_magic,
+				      u32 offset_delta)
+{
+	u32 read_magic, wrapped, last_byte, buf_start, buf_length;
+	struct console_data *cd;
+	u64 base_addr;
+	int err;
+
+	cd =3D kmalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+
+	base_addr =3D get_mc_fw_base_address();
+	if (base_addr < 0)
+		return -EIO;
+
+	cd->map_addr =3D ioremap(base_addr + offset, size);
+	if (!cd->map_addr) {
+		pr_err("cannot map console log memory\n");
+		err =3D -EIO;
+		goto err_ioremap;
+	}
+
+	cd->hdr =3D (struct log_header *)cd->map_addr;
+	read_magic =3D readl(&cd->hdr->magic_word);
+	last_byte =3D readl(&cd->hdr->last_byte);
+	buf_start =3D readl(&cd->hdr->buf_start);
+	buf_length =3D readl(&cd->hdr->buf_length);
+
+	if (read_magic !=3D expected_magic) {
+		pr_warn("expected =3D %08x, read =3D %08x\n",
+			expected_magic, read_magic);
+		err =3D -EIO;
+		goto err_magic;
+	}
+
+	cd->start_addr =3D cd->map_addr + buf_start - offset_delta;
+	cd->end_addr =3D cd->start_addr + buf_length;
+
+	wrapped =3D last_byte & LOG_HEADER_FLAG_BUFFER_WRAPAROUND;
+
+	adjust_end(cd);
+	if (wrapped && cd->end_of_data !=3D cd->end_addr)
+		cd->cur_ptr =3D cd->end_of_data + 1;
+	else
+		cd->cur_ptr =3D cd->start_addr;
+
+	fp->private_data =3D cd;
+
+	return 0;
+
+err_magic:
+	iounmap(cd->map_addr);
+
+err_ioremap:
+	kfree(cd);
+
+	return err;
+}
+
+static int dpaa2_mc_console_open(struct inode *node, struct file *fp)
+{
+	return dpaa2_generic_console_open(node, fp,
+					  MC_BUFFER_OFFSET, MC_BUFFER_SIZE,
+					  MAGIC_MC, MC_OFFSET_DELTA);
+}
+
+static int dpaa2_aiop_console_open(struct inode *node, struct file *fp)
+{
+	return dpaa2_generic_console_open(node, fp,
+					  AIOP_BUFFER_OFFSET, AIOP_BUFFER_SIZE,
+					  MAGIC_AIOP, AIOP_OFFSET_DELTA);
+}
+
+static int dpaa2_console_close(struct inode *node, struct file *fp)
+{
+	struct console_data *cd =3D fp->private_data;
+
+	iounmap(cd->map_addr);
+	kfree(cd);
+	return 0;
+}
+
+static ssize_t dpaa2_console_read(struct file *fp, char __user *buf,
+				  size_t count, loff_t *f_pos)
+{
+	struct console_data *cd =3D fp->private_data;
+	size_t bytes =3D dpaa2_console_size(cd);
+	size_t bytes_end =3D cd->end_addr - cd->cur_ptr;
+	size_t written =3D 0;
+
+	/* Check if we need to adjust the end of data addr */
+	adjust_end(cd);
+
+	if (cd->end_of_data =3D=3D cd->cur_ptr)
+		return 0;
+
+	if (count < bytes)
+		bytes =3D count;
+
+	if (bytes > bytes_end) {
+		if (copy_to_user(buf, cd->cur_ptr, bytes_end))
+			return -EFAULT;
+		buf +=3D bytes_end;
+		cd->cur_ptr =3D cd->start_addr;
+		bytes -=3D bytes_end;
+		written +=3D bytes_end;
+	}
+
+	if (copy_to_user(buf, cd->cur_ptr, bytes))
+		return -EFAULT;
+	cd->cur_ptr +=3D bytes;
+	written +=3D bytes;
+
+	return written;
+}
+
+static const struct file_operations dpaa2_mc_console_fops =3D {
+	.owner          =3D THIS_MODULE,
+	.open           =3D dpaa2_mc_console_open,
+	.release        =3D dpaa2_console_close,
+	.read           =3D dpaa2_console_read,
+};
+
+static struct miscdevice dpaa2_mc_console_dev =3D {
+	.minor =3D MISC_DYNAMIC_MINOR,
+	.name =3D "dpaa2_mc_console",
+	.fops =3D &dpaa2_mc_console_fops
+};
+
+static const struct file_operations dpaa2_aiop_console_fops =3D {
+	.owner          =3D THIS_MODULE,
+	.open           =3D dpaa2_aiop_console_open,
+	.release        =3D dpaa2_console_close,
+	.read           =3D dpaa2_console_read,
+};
+
+static struct miscdevice dpaa2_aiop_console_dev =3D {
+	.minor =3D MISC_DYNAMIC_MINOR,
+	.name =3D "dpaa2_aiop_console",
+	.fops =3D &dpaa2_aiop_console_fops
+};
+
+static int dpaa2_console_probe(struct platform_device *pdev)
+{
+	int error;
+
+	error =3D of_address_to_resource(pdev->dev.of_node, 0, &mc_base_addr);
+	if (error < 0) {
+		pr_err("of_address_to_resource() failed for %pOF with %d\n",
+		       pdev->dev.of_node, error);
+		return error;
+	}
+
+	error =3D misc_register(&dpaa2_mc_console_dev);
+	if (error) {
+		pr_err("dpaa2-console: cannot register device %s\n",
+		       dpaa2_mc_console_dev.name);
+		goto err_register_mc;
+	}
+
+	error =3D misc_register(&dpaa2_aiop_console_dev);
+	if (error) {
+		pr_err("dpaa2-console: cannot register device %s\n",
+		       dpaa2_aiop_console_dev.name);
+		goto err_register_aiop;
+	}
+
+	return 0;
+
+err_register_aiop:
+	misc_deregister(&dpaa2_mc_console_dev);
+err_register_mc:
+	return error;
+}
+
+static int dpaa2_console_remove(struct platform_device *pdev)
+{
+	misc_deregister(&dpaa2_mc_console_dev);
+	misc_deregister(&dpaa2_aiop_console_dev);
+
+	return 0;
+}
+
+static const struct of_device_id dpaa2_console_match_table[] =3D {
+	{ .compatible =3D "dpaa2-console",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, dpaa2_console_match_table);
+
+static struct platform_driver dpaa2_console_driver =3D {
+	.driver =3D {
+		   .name =3D "dpaa2-console",
+		   .pm =3D NULL,
+		   .of_match_table =3D dpaa2_console_match_table,
+		   },
+	.probe =3D dpaa2_console_probe,
+	.remove =3D dpaa2_console_remove,
+};
+module_platform_driver(dpaa2_console_driver);
--=20
1.9.1

