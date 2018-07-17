Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AC9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3292086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G17u6PUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3292086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbeGQJ4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:56:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35697 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbeGQJ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:56:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so387296ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HcOMcYxIdplJHBTC5bncQ7vDIvKsfPML5vZpU+7DNpM=;
        b=G17u6PUOFXUODfdo49/d0lEfVk9EgfcH4WP5CfEqPLl/FAKupRJehYMBEgJBPbTQeR
         qo3UVc8JYEDC4WIoAAteadBmb9S+433n+/UFC7M3abowDxdaaVNKi4PQgSlz5MZwpTMo
         oLG0M2D5+n1EkM1lHgsYpIZh+OOMXdWLOab088NLRpeVz/txLnMsNhtezxWAGEBNlPk9
         rK2aKLsIJFePUjljbLDkkbBs0KXhkwTuTW3vKT9+2C+D058UEfIunzIGZjhHKvVlCi3m
         A2EcEbvXgMJC4pKHH0xqXzTbYGV8JnRnxZcjQpg2ZgOBIXjxkk1N/s4XFrYEPKEg01q8
         t0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HcOMcYxIdplJHBTC5bncQ7vDIvKsfPML5vZpU+7DNpM=;
        b=VTOTVcyt/xqJtIlIZq05Rvp5TcngbRopn0VuUJQJEhOjTW6XJcqBITjp5J7dkjz4ao
         i9By4tAXbohJkN6MXBQehadI5JNVONn/DyW2qERwy052hUfTGMbiRmGSVvxRfrLi5/T1
         Mr+1KA4vPryWNkyeRvy22fICf48UDt0eeDXeqGMoHdIUvLEBKcUw02VLIKGJB6CXS1Gw
         rsGicHQPJYkP5qCIpPzBV/ND2AEbEFdf6sAVJa80TG+y5Q6lsQ1RRbahk/YKH+KPY3NT
         D1ZOWat8zvsZQlkUr9gIXk/MMY1NH4BNmmoH9U0Dm3uJ/QNhgBOR8FpAOmeV2hAJx8Gj
         qfNQ==
X-Gm-Message-State: AOUpUlGXiP3XICNP/xKjQ8+KmLKvzx1vg0OoyVYE9nvsELWesZ+JciYz
        tCzj1o+gkORus3oo47h6Tec=
X-Google-Smtp-Source: AAOMgpfCG1fTdugVyLpLk+jh3smT9WmKZg0rDCPYMEX92ZSoSBdZEcBDUugXqTfEqWm3WXcJ/2+7Iw==
X-Received: by 2002:a2e:5f5b:: with SMTP id t88-v6mr861049ljb.140.1531819495829;
        Tue, 17 Jul 2018 02:24:55 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id l1-v6sm94224lji.41.2018.07.17.02.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 02:24:55 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 1/4] ntb: idt: Alter temperature read method
Date:   Tue, 17 Jul 2018 12:24:34 +0300
Message-Id: <20180717092437.18918-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180717092437.18918-1-fancer.lancer@gmail.com>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
 <20180717092437.18918-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to create a hwmon interface for the IDT PCIe-switch temperature
sensor the already available reader method should be improved. Particularly
we need to redesign it so one would be able to read temperature/offset
values from registers of the passed types. Since IDT sensor interface
provides temperature in unsigned format 0:7:1 (7 bits for real value
and one for fraction) we also need to have helpers for the typical sysfs
temperature data type conversion to and from this format. Even though
the IDT PCIe-switch provided temperature offset got the same but signed
type it can be translated by these methods too.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 113 ++++++++++++++++++++++++++++++++++------
 drivers/ntb/hw/idt/ntb_hw_idt.h |  56 ++++++++++++++++++++
 2 files changed, 152 insertions(+), 17 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index dbe72f116017..c086ae5c601c 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1829,22 +1829,99 @@ static int idt_ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
  */
 
 /*
+ * idt_get_deg() - convert millidegree Celsius value to just degree
+ * @mdegC:	IN - millidegree Celsius value
+ *
+ * Return: Degree corresponding to the passed millidegree value
+ */
+static inline s8 idt_get_deg(long mdegC)
+{
+	return mdegC / 1000;
+}
+
+/*
+ * idt_get_frac() - retrieve 0/0.5 fraction of the millidegree Celsius value
+ * @mdegC:	IN - millidegree Celsius value
+ *
+ * Return: 0/0.5 degree fraction of the passed millidegree value
+ */
+static inline u8 idt_get_deg_frac(long mdegC)
+{
+	return (mdegC % 1000) >= 500 ? 5 : 0;
+}
+
+/*
+ * idt_get_temp_fmt() - convert millidegree Celsius value to 0:7:1 format
+ * @mdegC:	IN - millidegree Celsius value
+ *
+ * Return: 0:7:1 format acceptable by the IDT temperature sensor
+ */
+static inline u8 idt_temp_get_fmt(long mdegC)
+{
+	return (idt_get_deg(mdegC) << 1) | (idt_get_deg_frac(mdegC) ? 1 : 0);
+}
+
+/*
+ * idt_get_temp_sval() - convert temp sample to signed millidegree Celsius
+ * @data:	IN - shifted to LSB 8-bits temperature sample
+ *
+ * Return: signed millidegree Celsius
+ */
+static inline long idt_get_temp_sval(u32 data)
+{
+	return ((s8)data / 2) * 1000 + (data & 0x1 ? 500 : 0);
+}
+
+/*
+ * idt_get_temp_sval() - convert temp sample to unsigned millidegree Celsius
+ * @data:	IN - shifted to LSB 8-bits temperature sample
+ *
+ * Return: unsigned millidegree Celsius
+ */
+static inline long idt_get_temp_uval(u32 data)
+{
+	return (data / 2) * 1000 + (data & 0x1 ? 500 : 0);
+}
+
+/*
  * idt_read_temp() - read temperature from chip sensor
  * @ntb:	NTB device context.
- * @val:	OUT - integer value of temperature
- * @frac:	OUT - fraction
+ * @type:	IN - type of the temperature value to read
+ * @val:	OUT - integer value of temperature in millidegree Celsius
  */
-static void idt_read_temp(struct idt_ntb_dev *ndev, unsigned char *val,
-			  unsigned char *frac)
+static void idt_read_temp(struct idt_ntb_dev *ndev,
+			  const enum idt_temp_val type, long *val)
 {
 	u32 data;
 
-	/* Read the data from TEMP field of the TMPSTS register */
-	data = idt_sw_read(ndev, IDT_SW_TMPSTS);
-	data = GET_FIELD(TMPSTS_TEMP, data);
-	/* TEMP field has one fractional bit and seven integer bits */
-	*val = data >> 1;
-	*frac = ((data & 0x1) ? 5 : 0);
+	/* Alter the temperature field in accordance with the passed type */
+	switch (type) {
+	case IDT_TEMP_CUR:
+		data = GET_FIELD(TMPSTS_TEMP,
+				 idt_sw_read(ndev, IDT_SW_TMPSTS));
+		break;
+	case IDT_TEMP_LOW:
+		data = GET_FIELD(TMPSTS_LTEMP,
+				 idt_sw_read(ndev, IDT_SW_TMPSTS));
+		break;
+	case IDT_TEMP_HIGH:
+		data = GET_FIELD(TMPSTS_HTEMP,
+				 idt_sw_read(ndev, IDT_SW_TMPSTS));
+		break;
+	case IDT_TEMP_OFFSET:
+		/* This is the only field with signed 0:7:1 format */
+		data = GET_FIELD(TMPADJ_OFFSET,
+				 idt_sw_read(ndev, IDT_SW_TMPADJ));
+		*val = idt_get_temp_sval(data);
+		return;
+	default:
+		data = GET_FIELD(TMPSTS_TEMP,
+				 idt_sw_read(ndev, IDT_SW_TMPSTS));
+		break;
+	}
+
+	/* The rest of the fields accept unsigned 0:7:1 format */
+	*val = idt_get_temp_uval(data);
 }
 
 /*
@@ -1860,10 +1937,10 @@ static void idt_read_temp(struct idt_ntb_dev *ndev, unsigned char *val,
  */
 static void idt_temp_isr(struct idt_ntb_dev *ndev, u32 ntint_sts)
 {
-	unsigned char val, frac;
+	unsigned long mdeg;
 
 	/* Read the current temperature value */
-	idt_read_temp(ndev, &val, &frac);
+	idt_read_temp(ndev, IDT_TEMP_CUR, &mdeg);
 
 	/* Read the temperature alarm to clean the alarm status out */
 	/*(void)idt_sw_read(ndev, IDT_SW_TMPALARM);*/
@@ -1875,7 +1952,8 @@ static void idt_temp_isr(struct idt_ntb_dev *ndev, u32 ntint_sts)
 		"Temp sensor IRQ detected %#08x", ntint_sts);
 
 	/* Print temperature value to log */
-	dev_warn(&ndev->ntb.pdev->dev, "Temperature %hhu.%hhu", val, frac);
+	dev_warn(&ndev->ntb.pdev->dev, "Temperature %hhd.%hhuC",
+		idt_get_deg(mdeg), idt_get_deg_frac(mdeg));
 }
 
 /*=============================================================================
@@ -2123,9 +2201,9 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
 				   size_t count, loff_t *offp)
 {
 	struct idt_ntb_dev *ndev = filp->private_data;
-	unsigned char temp, frac, idx, pidx, cnt;
+	unsigned char idx, pidx, cnt;
+	unsigned long irqflags, mdeg;
 	ssize_t ret = 0, off = 0;
-	unsigned long irqflags;
 	enum ntb_speed speed;
 	enum ntb_width width;
 	char *strbuf;
@@ -2274,9 +2352,10 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
 	off += scnprintf(strbuf + off, size - off, "\n");
 
 	/* Current temperature */
-	idt_read_temp(ndev, &temp, &frac);
+	idt_read_temp(ndev, IDT_TEMP_CUR, &mdeg);
 	off += scnprintf(strbuf + off, size - off,
-		"Switch temperature\t\t- %hhu.%hhuC\n", temp, frac);
+		"Switch temperature\t\t- %hhd.%hhuC\n",
+		idt_get_deg(mdeg), idt_get_deg_frac(mdeg));
 
 	/* Copy the buffer to the User Space */
 	ret = simple_read_from_buffer(ubuf, count, offp, strbuf, off);
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.h b/drivers/ntb/hw/idt/ntb_hw_idt.h
index 856fd182f6f4..9dfd6b11a621 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.h
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.h
@@ -886,12 +886,42 @@
 #define IDT_SWPxMSGCTL_PART_FLD		4
 
 /*
+ * TMPCTL register fields related constants
+ * @IDT_TMPCTL_LTH_MASK:	Low temperature threshold field mask
+ * @IDT_TMPCTL_LTH_FLD:		Low temperature threshold field offset
+ * @IDT_TMPCTL_MTH_MASK:	Middle temperature threshold field mask
+ * @IDT_TMPCTL_MTH_FLD:		Middle temperature threshold field offset
+ * @IDT_TMPCTL_HTH_MASK:	High temperature threshold field mask
+ * @IDT_TMPCTL_HTH_FLD:		High temperature threshold field offset
+ * @IDT_TMPCTL_PDOWN:		Temperature sensor power down
+ */
+#define IDT_TMPCTL_LTH_MASK		0x000000FFU
+#define IDT_TMPCTL_LTH_FLD		0
+#define IDT_TMPCTL_MTH_MASK		0x0000FF00U
+#define IDT_TMPCTL_MTH_FLD		8
+#define IDT_TMPCTL_HTH_MASK		0x00FF0000U
+#define IDT_TMPCTL_HTH_FLD		16
+#define IDT_TMPCTL_PDOWN		0x80000000U
+
+/*
  * TMPSTS register fields related constants
  * @IDT_TMPSTS_TEMP_MASK:	Current temperature field mask
  * @IDT_TMPSTS_TEMP_FLD:	Current temperature field offset
  */
 #define IDT_TMPSTS_TEMP_MASK		0x000000FFU
 #define IDT_TMPSTS_TEMP_FLD		0
+#define IDT_TMPSTS_LTEMP_MASK		0x0000FF00U
+#define IDT_TMPSTS_LTEMP_FLD		8
+#define IDT_TMPSTS_HTEMP_MASK		0x00FF0000U
+#define IDT_TMPSTS_HTEMP_FLD		16
+
+/*
+ * TMPADJ register fields related constants
+ * @IDT_TMPADJ_OFFSET_MASK:	Temperature value offset field mask
+ * @IDT_TMPADJ_OFFSET_FLD:	Temperature value offset field offset
+ */
+#define IDT_TMPADJ_OFFSET_MASK		0x000000FFU
+#define IDT_TMPADJ_OFFSET_FLD		0
 
 /*
  * Helper macro to get/set the corresponding field value
@@ -951,6 +981,32 @@
 #define IDT_DIR_SIZE_ALIGN	1
 
 /*
+ * IDT PCIe-switch temperature sensor value limits
+ * @IDT_TEMP_MIN_MDEG:	Minimal integer value of temperature
+ * @IDT_TEMP_MAX_MDEG:	Maximal integer value of temperature
+ * @IDT_TEMP_MIN_OFFSET:Minimal integer value of temperature offset
+ * @IDT_TEMP_MAX_OFFSET:Maximal integer value of temperature offset
+ */
+#define IDT_TEMP_MIN_MDEG	0
+#define IDT_TEMP_MAX_MDEG	127500
+#define IDT_TEMP_MIN_OFFSET	-64000
+#define IDT_TEMP_MAX_OFFSET	63500
+
+/*
+ * Temperature sensor values enumeration
+ * @IDT_TEMP_CUR:	Current temperature
+ * @IDT_TEMP_LOW:	Lowest historical temperature
+ * @IDT_TEMP_HIGH:	Highest historical temperature
+ * @IDT_TEMP_OFFSET:	Current temperature offset
+ */
+enum idt_temp_val {
+	IDT_TEMP_CUR,
+	IDT_TEMP_LOW,
+	IDT_TEMP_HIGH,
+	IDT_TEMP_OFFSET
+};
+
+/*
  * IDT Memory Windows type. Depending on the device settings, IDT supports
  * Direct Address Translation MW registers and Lookup Table registers
  * @IDT_MW_DIR:		Direct address translation
-- 
2.12.0

