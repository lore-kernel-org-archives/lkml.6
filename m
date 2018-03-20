Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELtvLvIex5UgJVE3UF+BQczCeSVm1++BfTej/JoGT+HhjY6yP9Wbp1NaK2fLmgiDqDYf3W3R
ARC-Seal: i=1; a=rsa-sha256; t=1521550672; cv=none;
        d=google.com; s=arc-20160816;
        b=i8/5X1wVvCsnozD4T0+QEj+CKS1wX8ZwryKve3z7a99jj9e3h/ze+q3B982RAbXyvR
         7/HZnNtkwYRsm1MHfHrEIuhalhUxqaNFMifpWVdTqfin1C/7J78WQ/ww8xD6h53XPCLa
         x6i23TuXQdTTrenBRlqWn7UouqtwUJ/7/CjR4qbCa9tBRoQtHphX0GknTJQ8jpKphL+4
         RgtEQRrF8lfC17a5Z5+wVJVkotyVJITZMfOkzEsJVPi0hV/dbhBBt2v121VTCLKoyut0
         xLJlKC5KbCTfQ/NoBXe50E1t5DP1IfdVQARpQbaWN5SpV6izZdBrW6s3bTsOkT0dcZuX
         5+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=pwu/0WELrtJmackTQOkSFwS6mGCwyYORs/4V32fN//I=;
        b=LpRDqGW2x3xkN5TxePQvH1IA8Cy9w4qlVORjSgft22nzzW/xt2TQPyRPIvIV3AJdut
         1Pu7RzQTzcFcAuQ1Anqa4Q96NWlBi7h8G0RaXAzgyazsF10hGnX4HZuApl3vwsJ+Rfi4
         or0D+tk+oZcmWx5hGqoo9AxUOoOjt2X1lEqFM8IGuVJlcnOBGd4aLZGcGvHNrANoBbPE
         i47rMuYtbNeqJXF6K0YDgFfOrZQz90Ij6aePX6N04r5XslgNJ+PFf0nrnIfvHpfjTkrY
         z/5W4vC0/w+LfaTxSAndNSUuZI4dJybQYRNwS9rY6rLT70IB6nf4RAXWbANtMx5JIAb6
         dzqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="39592607"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jun Li <jun.li@nxp.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v9 10/12] usb: typec: driver for Pericom PI3USB30532 Type-C cross switch
Date: Tue, 20 Mar 2018 15:57:11 +0300
Message-Id: <20180320125713.85465-11-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320125713.85465-1-heikki.krogerus@linux.intel.com>
References: <20180320125713.85465-1-heikki.krogerus@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595461518026851633?=
X-GMAIL-MSGID: =?utf-8?q?1595461518026851633?=
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
index e6c0a3f1c734..880b7098da42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14607,6 +14607,12 @@ F:	drivers/usb/
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
2.16.2
