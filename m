Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1743198-1521033223-2-1933725902732645795
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521033222; b=Yu1951Ol2R9Hng4hbwiG6WylwEgM6yrRapzWoWQwDmfSdhY
    J7iY4wbN8N9PZXt8Cz+sGKIbnlKb+fTL/4KWh5TyeX2HZFWxMgX7wpxpQ1CHrU34
    01/Mzi1yh99lPAC99zcBa8e5GMNXkkn2e+I/11K5Rj2Afvaq/e8uNlkgcHSVN6W8
    tLQUwmv3JwloQXgB6uaGyIEu1PGB0WTMTLCX2Q2JS6PrIeSh6jXRz0li7A3DDqsx
    IpYaAlnqx1aZKJZ4azPRbCORwBpZorRaDfchYuUCwh2wxw50mKwjrdf+N3wacqpl
    m/rmcAt6sC7Kr3Cqps0RjPhG/z5GjHEdtDahrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521033222;
    bh=QQBy65f35g6nNWuIisVcOnii1X4MkQAet/1FeyppGhM=; b=lNu8QkXXZNl/
    JR1gQCPsYPdIYB9iG+REMPv2BVJAHL7zR/eRW3D0bRCIguEFcScVhOdgqnzK3iLZ
    AW6SbFaZBdcTut7gtJftFi+f3P78okZFH6djS54BPLMkSjuBrK+l4ehByolNxyCX
    CJ7fURBC7DFdq/ZAoQejTZTXnqcNuOG8QyzdEPZSUnx+qbLV5+P7/qdRsjRgeLsj
    8XPiw1fvkdc6Lc6+Dpm4bHQpQX5/NHoftT+NChRpd7VCr/a6HV2NHhfWkNuu1Wg0
    Wt0QbTYMH+nnOQJhA/4WhiD0oZMqPPcYZgnKQynpp1jjLWPyBvtztSNOdLhrkk19
    llcyQ/SxXA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeCNNM6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 09:12:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:3923 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbeCNNM4 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Mar 2018 09:12:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="37991722"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v8 10/12] usb: typec: driver for Pericom PI3USB30532 Type-C cross switch
Date: Wed, 14 Mar 2018 16:12:13 +0300
Message-Id: <20180314131215.70833-11-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
References: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

Add a driver for the Pericom PI3USB30532 Type-C cross switch /
mux chip found on some devices with a Type-C port.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v7:
- Remove unneeded semicolon

Changes in v4:
-Add Andy's Reviewed-by

Changes in v2:
-Cleanup pi3usb30532_set_conf() error handling
-Add Heikki's Reviewed-by

Changes in v1:
-This is a rewrite of my previous driver which was using the
 drivers/mux framework to use the new drivers/usb/typec/mux framework
---
 MAINTAINERS                         |   6 ++
 drivers/usb/typec/Kconfig           |   2 +
 drivers/usb/typec/Makefile          |   1 +
 drivers/usb/typec/mux/Kconfig       |  10 ++
 drivers/usb/typec/mux/Makefile      |   3 +
 drivers/usb/typec/mux/pi3usb30532.c | 178 ++++++++++++++++++++++++++++++++++++
 6 files changed, 200 insertions(+)
 create mode 100644 drivers/usb/typec/mux/Kconfig
 create mode 100644 drivers/usb/typec/mux/Makefile
 create mode 100644 drivers/usb/typec/mux/pi3usb30532.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f1988cddbe8..17b64236719f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14521,6 +14521,12 @@ F:	drivers/usb/
 F:	include/linux/usb.h
 F:	include/linux/usb/
 
+USB TYPEC PI3USB30532 MUX DRIVER
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/typec/mux/pi3usb30532.c
+
 USB TYPEC SUBSYSTEM
 M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 L:	linux-usb@vger.kernel.org
diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index a2a0684e7c82..030f88cb0c3f 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -85,4 +85,6 @@ config TYPEC_TPS6598X
 	  If you choose to build this driver as a dynamically linked module, the
 	  module will be called tps6598x.ko.
 
+source "drivers/usb/typec/mux/Kconfig"
+
 endif # TYPEC
diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index 56b2e9516ec1..1f599a6c30cc 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -6,3 +6,4 @@ obj-y				+= fusb302/
 obj-$(CONFIG_TYPEC_WCOVE)	+= typec_wcove.o
 obj-$(CONFIG_TYPEC_UCSI)	+= ucsi/
 obj-$(CONFIG_TYPEC_TPS6598X)	+= tps6598x.o
+obj-$(CONFIG_TYPEC)		+= mux/
diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
new file mode 100644
index 000000000000..9a954d2b8d8f
--- /dev/null
+++ b/drivers/usb/typec/mux/Kconfig
@@ -0,0 +1,10 @@
+menu "USB Type-C Multiplexer/DeMultiplexer Switch support"
+
+config TYPEC_MUX_PI3USB30532
+	tristate "Pericom PI3USB30532 Type-C cross switch driver"
+	depends on I2C
+	help
+	  Say Y or M if your system has a Pericom PI3USB30532 Type-C cross
+	  switch / mux chip found on some devices with a Type-C port.
+
+endmenu
diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
new file mode 100644
index 000000000000..1332e469b8a0
--- /dev/null
+++ b/drivers/usb/typec/mux/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_TYPEC_MUX_PI3USB30532)	+= pi3usb30532.o
diff --git a/drivers/usb/typec/mux/pi3usb30532.c b/drivers/usb/typec/mux/pi3usb30532.c
new file mode 100644
index 000000000000..b0e88db60ecf
--- /dev/null
+++ b/drivers/usb/typec/mux/pi3usb30532.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Pericom PI3USB30532 Type-C cross switch / mux driver
+ *
+ * Copyright (c) 2017-2018 Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/usb/tcpm.h>
+#include <linux/usb/typec_mux.h>
+
+#define PI3USB30532_CONF			0x00
+
+#define PI3USB30532_CONF_OPEN			0x00
+#define PI3USB30532_CONF_SWAP			0x01
+#define PI3USB30532_CONF_4LANE_DP		0x02
+#define PI3USB30532_CONF_USB3			0x04
+#define PI3USB30532_CONF_USB3_AND_2LANE_DP	0x06
+
+struct pi3usb30532 {
+	struct i2c_client *client;
+	struct mutex lock; /* protects the cached conf register */
+	struct typec_switch sw;
+	struct typec_mux mux;
+	u8 conf;
+};
+
+static int pi3usb30532_set_conf(struct pi3usb30532 *pi, u8 new_conf)
+{
+	int ret = 0;
+
+	if (pi->conf == new_conf)
+		return 0;
+
+	ret = i2c_smbus_write_byte_data(pi->client, PI3USB30532_CONF, new_conf);
+	if (ret) {
+		dev_err(&pi->client->dev, "Error writing conf: %d\n", ret);
+		return ret;
+	}
+
+	pi->conf = new_conf;
+	return 0;
+}
+
+static int pi3usb30532_sw_set(struct typec_switch *sw,
+			      enum typec_orientation orientation)
+{
+	struct pi3usb30532 *pi = container_of(sw, struct pi3usb30532, sw);
+	u8 new_conf;
+	int ret;
+
+	mutex_lock(&pi->lock);
+	new_conf = pi->conf;
+
+	switch (orientation) {
+	case TYPEC_ORIENTATION_NONE:
+		new_conf = PI3USB30532_CONF_OPEN;
+		break;
+	case TYPEC_ORIENTATION_NORMAL:
+		new_conf &= ~PI3USB30532_CONF_SWAP;
+		break;
+	case TYPEC_ORIENTATION_REVERSE:
+		new_conf |= PI3USB30532_CONF_SWAP;
+		break;
+	}
+
+	ret = pi3usb30532_set_conf(pi, new_conf);
+	mutex_unlock(&pi->lock);
+
+	return ret;
+}
+
+static int pi3usb30532_mux_set(struct typec_mux *mux, int state)
+{
+	struct pi3usb30532 *pi = container_of(mux, struct pi3usb30532, mux);
+	u8 new_conf;
+	int ret;
+
+	mutex_lock(&pi->lock);
+	new_conf = pi->conf;
+
+	switch (state) {
+	case TYPEC_MUX_NONE:
+		new_conf = PI3USB30532_CONF_OPEN;
+		break;
+	case TYPEC_MUX_USB:
+		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
+			   PI3USB30532_CONF_USB3;
+		break;
+	case TYPEC_MUX_DP:
+		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
+			   PI3USB30532_CONF_4LANE_DP;
+		break;
+	case TYPEC_MUX_DOCK:
+		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
+			   PI3USB30532_CONF_USB3_AND_2LANE_DP;
+		break;
+	}
+
+	ret = pi3usb30532_set_conf(pi, new_conf);
+	mutex_unlock(&pi->lock);
+
+	return ret;
+}
+
+static int pi3usb30532_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct pi3usb30532 *pi;
+	int ret;
+
+	pi = devm_kzalloc(dev, sizeof(*pi), GFP_KERNEL);
+	if (!pi)
+		return -ENOMEM;
+
+	pi->client = client;
+	pi->sw.dev = dev;
+	pi->sw.set = pi3usb30532_sw_set;
+	pi->mux.dev = dev;
+	pi->mux.set = pi3usb30532_mux_set;
+	mutex_init(&pi->lock);
+
+	ret = i2c_smbus_read_byte_data(client, PI3USB30532_CONF);
+	if (ret < 0) {
+		dev_err(dev, "Error reading config register %d\n", ret);
+		return ret;
+	}
+	pi->conf = ret;
+
+	ret = typec_switch_register(&pi->sw);
+	if (ret) {
+		dev_err(dev, "Error registering typec switch: %d\n", ret);
+		return ret;
+	}
+
+	ret = typec_mux_register(&pi->mux);
+	if (ret) {
+		typec_switch_unregister(&pi->sw);
+		dev_err(dev, "Error registering typec mux: %d\n", ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(client, pi);
+	return 0;
+}
+
+static int pi3usb30532_remove(struct i2c_client *client)
+{
+	struct pi3usb30532 *pi = i2c_get_clientdata(client);
+
+	typec_mux_unregister(&pi->mux);
+	typec_switch_unregister(&pi->sw);
+	return 0;
+}
+
+static const struct i2c_device_id pi3usb30532_table[] = {
+	{ "pi3usb30532" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pi3usb30532_table);
+
+static struct i2c_driver pi3usb30532_driver = {
+	.driver = {
+		.name = "pi3usb30532",
+	},
+	.probe_new	= pi3usb30532_probe,
+	.remove		= pi3usb30532_remove,
+	.id_table	= pi3usb30532_table,
+};
+
+module_i2c_driver(pi3usb30532_driver);
+
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_DESCRIPTION("Pericom PI3USB30532 Type-C mux driver");
+MODULE_LICENSE("GPL");
-- 
2.16.1

