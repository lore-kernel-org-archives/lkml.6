Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC05C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEFC20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn5D22rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfARODp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:03:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41876 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfARODm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:03:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so15157635wrs.8;
        Fri, 18 Jan 2019 06:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCzxSPy+FzZRjZn8HTA+OyQdWgf2KeAGuCfMKZTF/eE=;
        b=Dn5D22rdXlUC6LOdZ47CDE0REV4rkFHQYoewqEmLB5+xhG3c/URKIKSJeBu2IrTuhZ
         uWGsEmlBX/4jOxv/GYapduBe89+uM5VBcoGsr+icLa91eG9bxHq2Kt0WqazBmNkKZG3a
         NpeoGd4cycMby8azEw0+RWujKsZlXSo/YGyv4JOHV4SdyT32hJBRoc8Vk0wASWPWjyEv
         0c8eyWfVuVgX+Twq5CltUZ3D3ztJ1aclyxYiKos7VTCbm/9+vQ2agPQHf22nwtCFxkg4
         DZdSuJn9/W9OBEOKXbsGPlnDCqHM2+nUS1XTMOTE8zW5tOEHHSgl7zUy5GDXFlR8QivK
         PoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCzxSPy+FzZRjZn8HTA+OyQdWgf2KeAGuCfMKZTF/eE=;
        b=oi6ClTGrucA08grSGXY9Kq7nMklHcjKGkQPQcV/VxaIgkmJQPys8+9Z9946gPghBMr
         ld4T/3NFDABqBFmCs3zyFq88fyWt0sAfc6jsqWEgNpOnYk9heVGnlL77AwB6VokVK8K/
         iDRv0FZDWL5M0ToTV5/UhoWlyxVl5etcxQQMXRwSPv3a0wMsNR1iRT90z1zYykAB20S2
         xvtS1I2muxZ9Ay+KKDPHyMfrOj/h9Hob3jngP9ihEQHuIUAGbfTC+HaUghssjoOYID6/
         25tU1OLG53A51hIfNsnuYAUTsa8Cs8VxTK4RO1DnODlm3qQ64lVx2Xb2BBQLaN0ESFej
         DCCQ==
X-Gm-Message-State: AJcUukfPfMtkgigThelCLRpKjhjYrhaVVSiJJ4cG8Nv14OwEaSkR6Gz0
        20PA7S46SOuUea62nrEE900=
X-Google-Smtp-Source: ALg8bN4U3nqZAn5zFGzeXhSPpMnuC3pPR08rqSo/CW4odgYwwnO+fxSiLg5fsj2KmPUmc2ZGvu5qVQ==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr17624308wrt.141.1547820220427;
        Fri, 18 Jan 2019 06:03:40 -0800 (PST)
Received: from Red.local ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g197sm8464676wmd.29.2019.01.18.06.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:03:39 -0800 (PST)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 4/7] hwmon: adm1029: Add blank line after declarations
Date:   Fri, 18 Jan 2019 15:03:26 +0100
Message-Id: <20190118140329.18970-5-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
References: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As requested by checkpatch, this patch adds a blank line after declarations

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/hwmon/adm1029.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 092f16ad774f..f9f4f1f4a4c7 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -171,6 +171,7 @@ show_temp(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm1029_data *data = adm1029_update_device(dev);
+
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index]));
 }
 
@@ -180,6 +181,7 @@ show_fan(struct device *dev, struct device_attribute *devattr, char *buf)
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm1029_data *data = adm1029_update_device(dev);
 	u16 val;
+
 	if (data->fan[attr->index] == 0
 	    || (data->fan_div[attr->index] & 0xC0) == 0
 	    || data->fan[attr->index] == 255) {
@@ -196,6 +198,7 @@ show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm1029_data *data = adm1029_update_device(dev);
+
 	if ((data->fan_div[attr->index] & 0xC0) == 0)
 		return sprintf(buf, "0\n");
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[attr->index]));
@@ -210,6 +213,7 @@ static ssize_t set_fan_div(struct device *dev,
 	u8 reg;
 	long val;
 	int ret = kstrtol(buf, 10, &val);
+
 	if (ret < 0)
 		return ret;
 
-- 
2.19.2

