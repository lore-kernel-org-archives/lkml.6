Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F8CC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A533D2403A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A533D2403A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbeGESku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:40:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754066AbeGESkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:40:46 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65IYOC9012831
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 14:40:45 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k1rnyg9y6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 14:40:45 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 12:40:44 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 12:40:41 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65IeeuM12190154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 11:40:40 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8698313604F;
        Thu,  5 Jul 2018 12:40:40 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD030136051;
        Thu,  5 Jul 2018 12:40:39 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 12:40:39 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v11 3/8] i2c: fsi: Add port structures
Date:   Thu,  5 Jul 2018 13:40:25 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070518-0036-0000-0000-00000A0B6318
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009314; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01057019; UDB=6.00542279; IPR=6.00834939;
 MB=3.00022012; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-05 18:40:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070518-0037-0000-0000-000047FEFCC4
Message-Id: <1530816030-13010-4-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=997 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and initialize I2C adapters for each port on the FSI-attached I2C
master. Ports for each master are defined in the devicetree.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 91 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 694bbb4..89b7349 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -17,7 +17,10 @@
 #include <linux/fsi.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
 
 #define FSI_ENGID_I2C		0x7
 
@@ -128,6 +131,14 @@
 struct fsi_i2c_master {
 	struct fsi_device	*fsi;
 	u8			fifo_size;
+	struct list_head	ports;
+};
+
+struct fsi_i2c_port {
+	struct list_head	list;
+	struct i2c_adapter	adapter;
+	struct fsi_i2c_master	*master;
+	u16			port;
 };
 
 static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
@@ -181,9 +192,38 @@ static int fsi_i2c_dev_init(struct fsi_i2c_master *i2c)
 	return fsi_i2c_write_reg(i2c->fsi, I2C_FSI_WATER_MARK, &watermark);
 }
 
+static int fsi_i2c_set_port(struct fsi_i2c_port *port)
+{
+	int rc;
+	struct fsi_device *fsi = port->master->fsi;
+	u32 mode, dummy = 0;
+
+	rc = fsi_i2c_read_reg(fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return rc;
+
+	if (FIELD_GET(I2C_MODE_PORT, mode) == port->port)
+		return 0;
+
+	mode = (mode & ~I2C_MODE_PORT) | FIELD_PREP(I2C_MODE_PORT, port->port);
+	rc = fsi_i2c_write_reg(fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return rc;
+
+	/* reset engine when port is changed */
+	return fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
+}
+
 static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			int num)
 {
+	int rc;
+	struct fsi_i2c_port *port = adap->algo_data;
+
+	rc = fsi_i2c_set_port(port);
+	if (rc)
+		return rc;
+
 	return -EOPNOTSUPP;
 }
 
@@ -202,23 +242,73 @@ static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
 static int fsi_i2c_probe(struct device *dev)
 {
 	struct fsi_i2c_master *i2c;
+	struct fsi_i2c_port *port;
+	struct device_node *np;
 	int rc;
+	u32 port_no;
 
 	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
 	i2c->fsi = to_fsi_dev(dev);
+	INIT_LIST_HEAD(&i2c->ports);
 
 	rc = fsi_i2c_dev_init(i2c);
 	if (rc)
 		return rc;
 
+	/* Add adapter for each i2c port of the master. */
+	for_each_available_child_of_node(dev->of_node, np) {
+		rc = of_property_read_u32(np, "reg", &port_no);
+		if (rc || port_no > USHRT_MAX)
+			continue;
+
+		port = kzalloc(sizeof(*port), GFP_KERNEL);
+		if (!port)
+			break;
+
+		port->master = i2c;
+		port->port = port_no;
+
+		port->adapter.owner = THIS_MODULE;
+		port->adapter.dev.of_node = np;
+		port->adapter.dev.parent = dev;
+		port->adapter.algo = &fsi_i2c_algorithm;
+		port->adapter.algo_data = port;
+
+		snprintf(port->adapter.name, sizeof(port->adapter.name),
+			 "i2c_bus-%u", port_no);
+
+		rc = i2c_add_adapter(&port->adapter);
+		if (rc < 0) {
+			dev_err(dev, "Failed to register adapter: %d\n", rc);
+			kfree(port);
+			continue;
+		}
+
+		list_add(&port->list, &i2c->ports);
+	}
+
 	dev_set_drvdata(dev, i2c);
 
 	return 0;
 }
 
+static int fsi_i2c_remove(struct device *dev)
+{
+	struct fsi_i2c_master *i2c = dev_get_drvdata(dev);
+	struct fsi_i2c_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &i2c->ports, list) {
+		list_del(&port->list);
+		i2c_del_adapter(&port->adapter);
+		kfree(port);
+	}
+
+	return 0;
+}
+
 static const struct fsi_device_id fsi_i2c_ids[] = {
 	{ FSI_ENGID_I2C, FSI_VERSION_ANY },
 	{ }
@@ -230,6 +320,7 @@ static int fsi_i2c_probe(struct device *dev)
 		.name = "i2c-fsi",
 		.bus = &fsi_bus_type,
 		.probe = fsi_i2c_probe,
+		.remove = fsi_i2c_remove,
 	},
 };
 
-- 
1.8.3.1

