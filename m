Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x226Ptkn0DO6Ubw7kZ1KYtrkjoVtAMSTMANGQ/qNEx0EXXUr/MybYmtFs9IBLpGZtHnosdm5a
ARC-Seal: i=1; a=rsa-sha256; t=1519229785; cv=none;
        d=google.com; s=arc-20160816;
        b=O5OC1p8Mm1kbpnwyrFF3cZCjnqEOeYODPQijlXLjEavgU7LdVK/FHooR3h2m8n8hSn
         cRPG3Jwfd77HpSkrK4FXh63c0bqt3AjQIYZgKzbRZTDwd0jmz4C/J73WST1C3MWm+2tT
         U6RvlVgp5ouDYRHXpGrKWz9kppOnNOTsWIL8xGpFgoYiHh0Be+6T9TSqBgHGT9FI0vqT
         B66vNo2B+8YqhbcJtUcKkUICLu1hKPSGbDtf9o2dX7yOhmOeV31kyyXd0pfT5HGQHcP5
         VV6idzvzJGqoWZ9K4VTcdHyWL7pTyWW/LWKIhRnigAjIqBKPifsDoj2EPR2UCF2saDOZ
         iQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=IiiIusTK53NScI3iSXLoRSEHGY7ZmX1A6j+dpgw2jNo=;
        b=L+I8j4UxP7vvSTQPYW8ZdMg2OiV10ILoD9MjCk6Q9MblKPmuV98kU2OBUFqWGpbVxc
         2863qLYMVa21LM0gMBp7Fl7k1aJYv8riMFm3079a6Jkb8g4ba0ixQ8BlOsj2LK7dLNoI
         6/YdoL20bR7aiDXecdy14ujaSqAUtCO6uetzTPPIhF8Jr21XVS1fJsClPT3Y3y0D6wpl
         SPYJ65qmLmlZCs2KvYFTecL9ZUKaLOYZeE4SGjRYnYNG0Y7ywdWB3oI/l5sdieDuuRu/
         cHamXGMnC81uVFfttLVH42v2XtZeHozvoHJlRgzkrvRrZeKedayld33I/I69p11LEJwp
         LMGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="29617856"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: joel@jms.id.au,
	andrew@aj.id.au,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	benh@kernel.crashing.org,
	andrew@lunn.ch
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	openbmc@lists.ozlabs.org,
	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v2 7/8] [PATCH 7/8] drivers/hwmon: Add a generic PECI hwmon client driver
Date: Wed, 21 Feb 2018 08:16:05 -0800
Message-Id: <20180221161606.32247-8-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027891482896135?=
X-GMAIL-MSGID: =?utf-8?q?1593027891482896135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds a generic PECI hwmon client driver implementation.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/hwmon/Kconfig      |  10 +
 drivers/hwmon/Makefile     |   1 +
 drivers/hwmon/peci-hwmon.c | 928 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 939 insertions(+)
 create mode 100644 drivers/hwmon/peci-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ef23553ff5cb..f22e0c31f597 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1246,6 +1246,16 @@ config SENSORS_NCT7904
 	  This driver can also be built as a module.  If so, the module
 	  will be called nct7904.
 
+config SENSORS_PECI_HWMON
+	tristate "PECI hwmon support"
+	depends on PECI
+	help
+	  If you say yes here you get support for the generic PECI hwmon
+	  driver.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called peci-hwmon.
+
 config SENSORS_NSA320
 	tristate "ZyXEL NSA320 and compatible fan speed and temperature sensors"
 	depends on GPIOLIB && OF
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index f814b4ace138..946f54b168e5 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -135,6 +135,7 @@ obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
 obj-$(CONFIG_SENSORS_NCT7904)	+= nct7904.o
 obj-$(CONFIG_SENSORS_NSA320)	+= nsa320-hwmon.o
 obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
+obj-$(CONFIG_SENSORS_PECI_HWMON)	+= peci-hwmon.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
diff --git a/drivers/hwmon/peci-hwmon.c b/drivers/hwmon/peci-hwmon.c
new file mode 100644
index 000000000000..edd27744adcb
--- /dev/null
+++ b/drivers/hwmon/peci-hwmon.c
@@ -0,0 +1,928 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Intel Corporation
+
+#include <linux/delay.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/peci.h>
+#include <linux/workqueue.h>
+
+#define DIMM_SLOT_NUMS_MAX    12  /* Max DIMM numbers (channel ranks x 2) */
+#define CORE_NUMS_MAX         28  /* Max core numbers (max on SKX Platinum) */
+#define TEMP_TYPE_PECI        6   /* Sensor type 6: Intel PECI */
+
+#define CORE_TEMP_ATTRS       5
+#define DIMM_TEMP_ATTRS       2
+#define ATTR_NAME_LEN         24
+
+#define DEFAULT_ATTR_GRP_NUMS 5
+
+#define UPDATE_INTERVAL_MIN   HZ
+#define DIMM_MASK_CHECK_DELAY msecs_to_jiffies(5000)
+
+enum sign {
+	POS,
+	NEG
+};
+
+struct temp_data {
+	bool valid;
+	s32  value;
+	unsigned long last_updated;
+};
+
+struct temp_group {
+	struct temp_data tjmax;
+	struct temp_data tcontrol;
+	struct temp_data tthrottle;
+	struct temp_data dts_margin;
+	struct temp_data die;
+	struct temp_data core[CORE_NUMS_MAX];
+	struct temp_data dimm[DIMM_SLOT_NUMS_MAX];
+};
+
+struct core_temp_group {
+	struct sensor_device_attribute sd_attrs[CORE_TEMP_ATTRS];
+	char attr_name[CORE_TEMP_ATTRS][ATTR_NAME_LEN];
+	struct attribute *attrs[CORE_TEMP_ATTRS + 1];
+	struct attribute_group attr_group;
+};
+
+struct dimm_temp_group {
+	struct sensor_device_attribute sd_attrs[DIMM_TEMP_ATTRS];
+	char attr_name[DIMM_TEMP_ATTRS][ATTR_NAME_LEN];
+	struct attribute *attrs[DIMM_TEMP_ATTRS + 1];
+	struct attribute_group attr_group;
+};
+
+struct peci_hwmon {
+	struct peci_client *client;
+	struct device *dev;
+	struct device *hwmon_dev;
+	struct workqueue_struct *work_queue;
+	struct delayed_work work_handler;
+	char name[PECI_NAME_SIZE];
+	struct temp_group temp;
+	u8 addr;
+	uint cpu_no;
+	u32 core_mask;
+	u32 dimm_mask;
+	const struct attribute_group *core_attr_groups[CORE_NUMS_MAX + 1];
+	const struct attribute_group *dimm_attr_groups[DIMM_SLOT_NUMS_MAX + 1];
+	uint global_idx;
+	uint core_idx;
+	uint dimm_idx;
+};
+
+enum label {
+	L_DIE,
+	L_DTS,
+	L_TCONTROL,
+	L_TTHROTTLE,
+	L_TJMAX,
+	L_MAX
+};
+
+static const char *peci_label[L_MAX] = {
+	"Die\n",
+	"DTS margin to Tcontrol\n",
+	"Tcontrol\n",
+	"Tthrottle\n",
+	"Tjmax\n",
+};
+
+static int send_peci_cmd(struct peci_hwmon *priv, enum peci_cmd cmd, void *msg)
+{
+	return peci_command(priv->client->adapter, cmd, msg);
+}
+
+static int need_update(struct temp_data *temp)
+{
+	if (temp->valid &&
+	    time_before(jiffies, temp->last_updated + UPDATE_INTERVAL_MIN))
+		return 0;
+
+	return 1;
+}
+
+static s32 ten_dot_six_to_millidegree(s32 x)
+{
+	return ((((x) ^ 0x8000) - 0x8000) * 1000 / 64);
+}
+
+static int get_tjmax(struct peci_hwmon *priv)
+{
+	struct peci_rd_pkg_cfg_msg msg;
+	int rc;
+
+	if (!priv->temp.tjmax.valid) {
+		msg.addr = priv->addr;
+		msg.index = MBX_INDEX_TEMP_TARGET;
+		msg.param = 0;
+		msg.rx_len = 4;
+
+		rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, (void *)&msg);
+		if (rc < 0)
+			return rc;
+
+		priv->temp.tjmax.value = (s32)msg.pkg_config[2] * 1000;
+		priv->temp.tjmax.valid = true;
+	}
+
+	return 0;
+}
+
+static int get_tcontrol(struct peci_hwmon *priv)
+{
+	struct peci_rd_pkg_cfg_msg msg;
+	s32 tcontrol_margin;
+	int rc;
+
+	if (!need_update(&priv->temp.tcontrol))
+		return 0;
+
+	rc = get_tjmax(priv);
+	if (rc < 0)
+		return rc;
+
+	msg.addr = priv->addr;
+	msg.index = MBX_INDEX_TEMP_TARGET;
+	msg.param = 0;
+	msg.rx_len = 4;
+
+	rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, (void *)&msg);
+	if (rc < 0)
+		return rc;
+
+	tcontrol_margin = msg.pkg_config[1];
+	tcontrol_margin = ((tcontrol_margin ^ 0x80) - 0x80) * 1000;
+
+	priv->temp.tcontrol.value = priv->temp.tjmax.value - tcontrol_margin;
+
+	if (!priv->temp.tcontrol.valid) {
+		priv->temp.tcontrol.last_updated = INITIAL_JIFFIES;
+		priv->temp.tcontrol.valid = true;
+	} else {
+		priv->temp.tcontrol.last_updated = jiffies;
+	}
+
+	return 0;
+}
+
+static int get_tthrottle(struct peci_hwmon *priv)
+{
+	struct peci_rd_pkg_cfg_msg msg;
+	s32 tthrottle_offset;
+	int rc;
+
+	if (!need_update(&priv->temp.tthrottle))
+		return 0;
+
+	rc = get_tjmax(priv);
+	if (rc < 0)
+		return rc;
+
+	msg.addr = priv->addr;
+	msg.index = MBX_INDEX_TEMP_TARGET;
+	msg.param = 0;
+	msg.rx_len = 4;
+
+	rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, (void *)&msg);
+	if (rc < 0)
+		return rc;
+
+	tthrottle_offset = (msg.pkg_config[3] & 0x2f) * 1000;
+	priv->temp.tthrottle.value = priv->temp.tjmax.value - tthrottle_offset;
+
+	if (!priv->temp.tthrottle.valid) {
+		priv->temp.tthrottle.last_updated = INITIAL_JIFFIES;
+		priv->temp.tthrottle.valid = true;
+	} else {
+		priv->temp.tthrottle.last_updated = jiffies;
+	}
+
+	return 0;
+}
+
+static int get_die_temp(struct peci_hwmon *priv)
+{
+	struct peci_get_temp_msg msg;
+	int rc;
+
+	if (!need_update(&priv->temp.die))
+		return 0;
+
+	rc = get_tjmax(priv);
+	if (rc < 0)
+		return rc;
+
+	msg.addr = priv->addr;
+
+	rc = send_peci_cmd(priv, PECI_CMD_GET_TEMP, (void *)&msg);
+	if (rc < 0)
+		return rc;
+
+	priv->temp.die.value = priv->temp.tjmax.value +
+			       ((s32)msg.temp_raw * 1000 / 64);
+
+	if (!priv->temp.die.valid) {
+		priv->temp.die.last_updated = INITIAL_JIFFIES;
+		priv->temp.die.valid = true;
+	} else {
+		priv->temp.die.last_updated = jiffies;
+	}
+
+	return 0;
+}
+
+static int get_dts_margin(struct peci_hwmon *priv)
+{
+	struct peci_rd_pkg_cfg_msg msg;
+	s32 dts_margin;
+	int rc;
+
+	if (!need_update(&priv->temp.dts_margin))
+		return 0;
+
+	msg.addr = priv->addr;
+	msg.index = MBX_INDEX_DTS_MARGIN;
+	msg.param = 0;
+	msg.rx_len = 4;
+
+	rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, (void *)&msg);
+	if (rc < 0)
+		return rc;
+
+	dts_margin = (msg.pkg_config[1] << 8) | msg.pkg_config[0];
+
+	/**
+	 * Processors return a value of DTS reading in 10.6 format
+	 * (10 bits signed decimal, 6 bits fractional).
+	 * Error codes:
+	 *   0x8000: General sensor error
+	 *   0x8001: Reserved
+	 *   0x8002: Underflow on reading value
+	 *   0x8003-0x81ff: Reserved
+	 */
+	if (dts_margin >= 0x8000 && dts_margin <= 0x81ff)
+		return -1;
+
+	dts_margin = ten_dot_six_to_millidegree(dts_margin);
+
+	priv->temp.dts_margin.value = dts_margin;
+
+	if (!priv->temp.dts_margin.valid) {
+		priv->temp.dts_margin.last_updated = INITIAL_JIFFIES;
+		priv->temp.dts_margin.valid = true;
+	} else {
+		priv->temp.dts_margin.last_updated = jiffies;
+	}
+
+	return 0;
+}
+
+static int get_core_temp(struct peci_hwmon *priv, int core_index)
+{
+	struct peci_rd_pkg_cfg_msg msg;
+	s32 core_dts_margin;
+	int rc;
+
+	if (!need_update(&priv->temp.core[core_index]))
+		return 0;
+
+	rc = get_tjmax(priv);
+	if (rc < 0)
+		return rc;
+
+	msg.addr = priv->addr;
+	msg.index = MBX_INDEX_PER_CORE_DTS_TEMP;
+	msg.param = core_index;
+	msg.rx_len = 4;
+
+	rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, (void *)&msg);
+	if (rc < 0)
+		return rc;
+
+	core_dts_margin = (msg.pkg_config[1] << 8) | msg.pkg_config[0];
+
+	/**
+	 * Processors return a value of the core DTS reading in 10.6 format
+	 * (10 bits signed decimal, 6 bits fractional).
+	 * Error codes:
+	 *   0x8000: General sensor error
+	 *   0x8001: Reserved
+	 *   0x8002: Underflow on reading value
+	 *   0x8003-0x81ff: Reserved
+	 */
+	if (core_dts_margin >= 0x8000 && core_dts_margin <= 0x81ff)
+		return -1;
+
+	core_dts_margin = ten_dot_six_to_millidegree(core_dts_margin);
+
+	priv->temp.core[core_index].value = priv->temp.tjmax.value +
+					    core_dts_margin;
+
+	if (!priv->temp.core[core_index].valid) {
+		priv->temp.core[core_index].last_updated = INITIAL_JIFFIES;
+		priv->temp.core[core_index].valid = true;
+	} else {
+		priv->temp.core[core_index].last_updated = jiffies;
+	}
+
+	return 0;
+}
+
+static int get_dimm_temp(struct peci_hwmon *priv, int dimm_index)
+{
+	struct peci_rd_pkg_cfg_msg msg;
+	int channel = dimm_index / 2;
+	int dimm_order = dimm_index % 2;
+	int rc;
+
+	if (!need_update(&priv->temp.dimm[dimm_index]))
+		return 0;
+
+	msg.addr = priv->addr;
+	msg.index = MBX_INDEX_DDR_DIMM_TEMP;
+	msg.param = channel;
+	msg.rx_len = 4;
+
+	rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, (void *)&msg);
+	if (rc < 0)
+		return rc;
+
+	priv->temp.dimm[dimm_index].value = msg.pkg_config[dimm_order] * 1000;
+
+	if (!priv->temp.dimm[dimm_index].valid) {
+		priv->temp.dimm[dimm_index].last_updated = INITIAL_JIFFIES;
+		priv->temp.dimm[dimm_index].valid = true;
+	} else {
+		priv->temp.dimm[dimm_index].last_updated = jiffies;
+	}
+
+	return 0;
+}
+
+static ssize_t show_tcontrol(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	int rc;
+
+	rc = get_tcontrol(priv);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.tcontrol.value);
+}
+
+static ssize_t show_tcontrol_margin(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int rc;
+
+	rc = get_tcontrol(priv);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", sensor_attr->index == POS ?
+				    priv->temp.tjmax.value -
+				    priv->temp.tcontrol.value :
+				    priv->temp.tcontrol.value -
+				    priv->temp.tjmax.value);
+}
+
+static ssize_t show_tthrottle(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	int rc;
+
+	rc = get_tthrottle(priv);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.tthrottle.value);
+}
+
+static ssize_t show_tjmax(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	int rc;
+
+	rc = get_tjmax(priv);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.tjmax.value);
+}
+
+static ssize_t show_die_temp(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	int rc;
+
+	rc = get_die_temp(priv);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.die.value);
+}
+
+static ssize_t show_dts_margin(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	int rc;
+
+	rc = get_dts_margin(priv);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.dts_margin.value);
+}
+
+static ssize_t show_core_temp(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int core_index = sensor_attr->index;
+	int rc;
+
+	rc = get_core_temp(priv, core_index);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.core[core_index].value);
+}
+
+static ssize_t show_dimm_temp(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int dimm_index = sensor_attr->index;
+	int rc;
+
+	rc = get_dimm_temp(priv, dimm_index);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.dimm[dimm_index].value);
+}
+
+static ssize_t show_value(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+
+	return sprintf(buf, "%d\n", sensor_attr->index);
+}
+
+static ssize_t show_label(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+
+	return sprintf(buf, peci_label[sensor_attr->index]);
+}
+
+static ssize_t show_core_label(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+
+	return sprintf(buf, "Core %d\n", sensor_attr->index);
+}
+
+static ssize_t show_dimm_label(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+
+	char channel = 'A' + (sensor_attr->index / 2);
+	int index = sensor_attr->index % 2;
+
+	return sprintf(buf, "DIMM %d (%c%d)\n",
+		       sensor_attr->index, channel, index);
+}
+
+/* Die temperature */
+static SENSOR_DEVICE_ATTR(temp1_label, 0444, show_label, NULL, L_DIE);
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, show_die_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_max, 0444, show_tcontrol, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_crit, 0444, show_tjmax, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_crit_hyst, 0444, show_tcontrol_margin, NULL,
+			  POS);
+
+static struct attribute *die_temp_attrs[] = {
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group die_temp_attr_group = {
+	.attrs = die_temp_attrs,
+};
+
+/* DTS margin temperature */
+static SENSOR_DEVICE_ATTR(temp2_label, 0444, show_label, NULL, L_DTS);
+static SENSOR_DEVICE_ATTR(temp2_input, 0444, show_dts_margin, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_min, 0444, show_value, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_lcrit, 0444, show_tcontrol_margin, NULL, NEG);
+
+static struct attribute *dts_margin_temp_attrs[] = {
+	&sensor_dev_attr_temp2_label.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_lcrit.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group dts_margin_temp_attr_group = {
+	.attrs = dts_margin_temp_attrs,
+};
+
+/* Tcontrol temperature */
+static SENSOR_DEVICE_ATTR(temp3_label, 0444, show_label, NULL, L_TCONTROL);
+static SENSOR_DEVICE_ATTR(temp3_input, 0444, show_tcontrol, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp3_crit, 0444, show_tjmax, NULL, 0);
+
+static struct attribute *tcontrol_temp_attrs[] = {
+	&sensor_dev_attr_temp3_label.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group tcontrol_temp_attr_group = {
+	.attrs = tcontrol_temp_attrs,
+};
+
+/* Tthrottle temperature */
+static SENSOR_DEVICE_ATTR(temp4_label, 0444, show_label, NULL, L_TTHROTTLE);
+static SENSOR_DEVICE_ATTR(temp4_input, 0444, show_tthrottle, NULL, 0);
+
+static struct attribute *tthrottle_temp_attrs[] = {
+	&sensor_dev_attr_temp4_label.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group tthrottle_temp_attr_group = {
+	.attrs = tthrottle_temp_attrs,
+};
+
+/* Tjmax temperature */
+static SENSOR_DEVICE_ATTR(temp5_label, 0444, show_label, NULL, L_TJMAX);
+static SENSOR_DEVICE_ATTR(temp5_input, 0444, show_tjmax, NULL, 0);
+
+static struct attribute *tjmax_temp_attrs[] = {
+	&sensor_dev_attr_temp5_label.dev_attr.attr,
+	&sensor_dev_attr_temp5_input.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group tjmax_temp_attr_group = {
+	.attrs = tjmax_temp_attrs,
+};
+
+static const struct attribute_group *
+default_attr_groups[DEFAULT_ATTR_GRP_NUMS + 1] = {
+	&die_temp_attr_group,
+	&dts_margin_temp_attr_group,
+	&tcontrol_temp_attr_group,
+	&tthrottle_temp_attr_group,
+	&tjmax_temp_attr_group,
+	NULL
+};
+
+/* Core temperature */
+static ssize_t (*const core_show_fn[CORE_TEMP_ATTRS]) (struct device *dev,
+		struct device_attribute *devattr, char *buf) = {
+	show_core_label,
+	show_core_temp,
+	show_tcontrol,
+	show_tjmax,
+	show_tcontrol_margin,
+};
+
+static const char *const core_suffix[CORE_TEMP_ATTRS] = {
+	"label",
+	"input",
+	"max",
+	"crit",
+	"crit_hyst",
+};
+
+static int check_resolved_cores(struct peci_hwmon *priv)
+{
+	struct peci_rd_pci_cfg_local_msg msg;
+	int rc;
+
+	if (!(priv->client->adapter->cmd_mask & BIT(PECI_CMD_RD_PCI_CFG_LOCAL)))
+		return -EINVAL;
+
+	/* Get the RESOLVED_CORES register value */
+	msg.addr = priv->addr;
+	msg.bus = 1;
+	msg.device = 30;
+	msg.function = 3;
+	msg.reg = 0xB4;
+	msg.rx_len = 4;
+
+	rc = send_peci_cmd(priv, PECI_CMD_RD_PCI_CFG_LOCAL, (void *)&msg);
+	if (rc < 0)
+		return rc;
+
+	priv->core_mask = msg.pci_config[3] << 24 |
+			  msg.pci_config[2] << 16 |
+			  msg.pci_config[1] << 8 |
+			  msg.pci_config[0];
+
+	if (!priv->core_mask)
+		return -EAGAIN;
+
+	dev_dbg(priv->dev, "Scanned resolved cores: 0x%x\n", priv->core_mask);
+	return 0;
+}
+
+static int create_core_temp_group(struct peci_hwmon *priv, int core_no)
+{
+	struct core_temp_group *data;
+	int i;
+
+	data = devm_kzalloc(priv->dev, sizeof(struct core_temp_group),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	for (i = 0; i < CORE_TEMP_ATTRS; i++) {
+		snprintf(data->attr_name[i], ATTR_NAME_LEN,
+			 "temp%d_%s", priv->global_idx, core_suffix[i]);
+		sysfs_attr_init(&data->sd_attrs[i].dev_attr.attr);
+		data->sd_attrs[i].dev_attr.attr.name = data->attr_name[i];
+		data->sd_attrs[i].dev_attr.attr.mode = 0444;
+		data->sd_attrs[i].dev_attr.show = core_show_fn[i];
+		if (i == 0 || i == 1) /* label or temp */
+			data->sd_attrs[i].index = core_no;
+		data->attrs[i] = &data->sd_attrs[i].dev_attr.attr;
+	}
+
+	data->attr_group.attrs = data->attrs;
+	priv->core_attr_groups[priv->core_idx++] = &data->attr_group;
+	priv->global_idx++;
+
+	return 0;
+}
+
+static int create_core_temp_groups(struct peci_hwmon *priv)
+{
+	int rc, i;
+
+	rc = check_resolved_cores(priv);
+	if (!rc) {
+		for (i = 0; i < CORE_NUMS_MAX; i++) {
+			if (priv->core_mask & BIT(i)) {
+				rc = create_core_temp_group(priv, i);
+				if (rc)
+					return rc;
+			}
+		}
+
+		rc = sysfs_create_groups(&priv->hwmon_dev->kobj,
+					 priv->core_attr_groups);
+	}
+
+	return rc;
+}
+
+/* DIMM temperature */
+static ssize_t (*const dimm_show_fn[DIMM_TEMP_ATTRS]) (struct device *dev,
+		struct device_attribute *devattr, char *buf) = {
+	show_dimm_label,
+	show_dimm_temp,
+};
+
+static const char *const dimm_suffix[DIMM_TEMP_ATTRS] = {
+	"label",
+	"input",
+};
+
+static int check_populated_dimms(struct peci_hwmon *priv)
+{
+	struct peci_rd_pkg_cfg_msg msg;
+	int i, rc, pass = 0;
+
+do_scan:
+	for (i = 0; i < (DIMM_SLOT_NUMS_MAX / 2); i++) {
+		msg.addr = priv->addr;
+		msg.index = MBX_INDEX_DDR_DIMM_TEMP;
+		msg.param = i; /* channel */
+		msg.rx_len = 4;
+
+		rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, (void *)&msg);
+		if (rc < 0)
+			return rc;
+
+		if (msg.pkg_config[0]) /* DIMM #0 on the channel */
+			priv->dimm_mask |= BIT(i);
+
+		if (msg.pkg_config[1]) /* DIMM #1 on the channel */
+			priv->dimm_mask |= BIT(i + 1);
+	}
+
+	/* Do 2-pass scanning */
+	if (priv->dimm_mask && pass == 0) {
+		pass++;
+		goto do_scan;
+	}
+
+	if (!priv->dimm_mask)
+		return -EAGAIN;
+
+	dev_dbg(priv->dev, "Scanned populated DIMMs: 0x%x\n", priv->dimm_mask);
+	return 0;
+}
+
+static int create_dimm_temp_group(struct peci_hwmon *priv, int dimm_no)
+{
+	struct dimm_temp_group *data;
+	int i;
+
+	data = devm_kzalloc(priv->dev, sizeof(struct dimm_temp_group),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	for (i = 0; i < DIMM_TEMP_ATTRS; i++) {
+		snprintf(data->attr_name[i], ATTR_NAME_LEN,
+			 "temp%d_%s", priv->global_idx, dimm_suffix[i]);
+		sysfs_attr_init(&data->sd_attrs[i].dev_attr.attr);
+		data->sd_attrs[i].dev_attr.attr.name = data->attr_name[i];
+		data->sd_attrs[i].dev_attr.attr.mode = 0444;
+		data->sd_attrs[i].dev_attr.show = dimm_show_fn[i];
+		data->sd_attrs[i].index = dimm_no;
+		data->attrs[i] = &data->sd_attrs[i].dev_attr.attr;
+	}
+
+	data->attr_group.attrs = data->attrs;
+	priv->dimm_attr_groups[priv->dimm_idx++] = &data->attr_group;
+	priv->global_idx++;
+
+	return 0;
+}
+
+static int create_dimm_temp_groups(struct peci_hwmon *priv)
+{
+	int rc, i;
+
+	rc = check_populated_dimms(priv);
+	if (!rc) {
+		for (i = 0; i < DIMM_SLOT_NUMS_MAX; i++) {
+			if (priv->dimm_mask & BIT(i)) {
+				rc = create_dimm_temp_group(priv, i);
+				if (rc)
+					return rc;
+			}
+		}
+
+		rc = sysfs_create_groups(&priv->hwmon_dev->kobj,
+					 priv->dimm_attr_groups);
+		if (!rc)
+			dev_dbg(priv->dev, "Done DIMM temp group creation\n");
+	} else if (rc == -EAGAIN) {
+		queue_delayed_work(priv->work_queue, &priv->work_handler,
+				   DIMM_MASK_CHECK_DELAY);
+		dev_dbg(priv->dev, "Diferred DIMM temp group creation\n");
+	}
+
+	return rc;
+}
+
+static void create_dimm_temp_groups_delayed(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct peci_hwmon *priv = container_of(dwork, struct peci_hwmon,
+					       work_handler);
+	int rc;
+
+	rc = create_dimm_temp_groups(priv);
+	if (rc && rc != -EAGAIN)
+		dev_dbg(priv->dev, "Skipped to creat DIMM temp groups\n");
+}
+
+static int peci_hwmon_probe(struct peci_client *client)
+{
+	struct device *dev = &client->dev;
+	struct peci_hwmon *priv;
+	int rc;
+
+	if ((client->adapter->cmd_mask &
+	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG))) !=
+	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG))) {
+		dev_err(dev, "Client doesn't support temperature monitoring\n");
+		return -EINVAL;
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+	priv->client = client;
+	priv->dev = dev;
+	priv->addr = client->addr;
+	priv->cpu_no = priv->addr - PECI_BASE_ADDR;
+
+	snprintf(priv->name, PECI_NAME_SIZE, "peci_hwmon.cpu%d", priv->cpu_no);
+
+	priv->work_queue = create_singlethread_workqueue(priv->name);
+	if (!priv->work_queue)
+		return -ENOMEM;
+
+	priv->hwmon_dev = hwmon_device_register_with_groups(priv->dev,
+							    priv->name,
+							    priv,
+							   default_attr_groups);
+
+	rc = PTR_ERR_OR_ZERO(priv->hwmon_dev);
+	if (rc) {
+		dev_err(dev, "Failed to register peci hwmon\n");
+		return rc;
+	}
+
+	priv->global_idx = DEFAULT_ATTR_GRP_NUMS + 1;
+
+	rc = create_core_temp_groups(priv);
+	if (rc) {
+		dev_err(dev, "Failed to create core groups\n");
+		return rc;
+	}
+
+	INIT_DELAYED_WORK(&priv->work_handler, create_dimm_temp_groups_delayed);
+
+	rc = create_dimm_temp_groups(priv);
+	if (rc && rc != -EAGAIN)
+		dev_dbg(dev, "Skipped to creat DIMM temp groups\n");
+
+	dev_dbg(dev, "peci hwmon for CPU at 0x%x registered\n", priv->addr);
+
+	return 0;
+}
+
+static int peci_hwmon_remove(struct peci_client *client)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(&client->dev);
+
+	cancel_delayed_work(&priv->work_handler);
+	destroy_workqueue(priv->work_queue);
+	sysfs_remove_groups(&priv->hwmon_dev->kobj, priv->core_attr_groups);
+	sysfs_remove_groups(&priv->hwmon_dev->kobj, priv->dimm_attr_groups);
+	hwmon_device_unregister(priv->hwmon_dev);
+
+	return 0;
+}
+
+static const struct of_device_id peci_of_table[] = {
+	{ .compatible = "intel,peci-hwmon", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, peci_of_table);
+
+static struct peci_driver peci_hwmon_driver = {
+	.probe  = peci_hwmon_probe,
+	.remove = peci_hwmon_remove,
+	.driver = {
+		.name           = "peci-hwmon",
+		.of_match_table = of_match_ptr(peci_of_table),
+	},
+};
+module_peci_driver(peci_hwmon_driver);
+
+MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
+MODULE_DESCRIPTION("PECI hwmon driver");
+MODULE_LICENSE("GPL v2");
-- 
2.16.1
