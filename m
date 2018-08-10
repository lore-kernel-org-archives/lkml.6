Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F5EC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8BD21DEC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UnNvFeiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8BD21DEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeHJPrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:47:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36041 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeHJPrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:47:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id w24-v6so1876076wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ODfbYiBimtCudMwySoSntsM6ZvN5scsZHFcuMUJGLzU=;
        b=UnNvFeiL+T3lFcA9NnkL9jmAEtCyDqz2HJoasgZkV0RRkpVclTt32PN72z4CmGWbST
         ZAgDdGhTjt+Iss6nEirsdRUuQlW+MOf22ZK8WVvDIhZY7yblqhUOwGoZMQsie+VkwRJv
         Ekq0QB9MgIV1dV82crwcWrZgTl2iN/wlP02ryrWULnLDPqdb6ECIhGEioHIiHMs4aN3X
         HTHg/jgdIe2Lbd5pbtceE/9JaxkENo6vElreHYlrxXLGK4OZR+gMWTJKDfhzuNdbXZi7
         O1lMyoDVg6mDDt0Oocty2abubf+oof+ST/hm7nreXDCfz3dHa0FgJlvTFvvc7FKkZQQP
         TJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ODfbYiBimtCudMwySoSntsM6ZvN5scsZHFcuMUJGLzU=;
        b=YbgWJs9IN9v2s2VYoIJy03c+B3RVsARfPBBjy+W0BZf3XwITSCCDy6B8CWDt4C4xWd
         Ztc9CVcjCIacS+Tuw8iDH100J5P4T0ZSRpgnwU3WldLIs8HeKtzk4cDjWA/CvndCDcq7
         4v6pp8r2DEU/HteCq43Dj/FRj8btIBT8VosXJRwdKwoJTXbnx55xMznpzq9MOqcDPge9
         zO8BrgRhaZxKRkG6c65KGBOeuxL/Pcc1hFC5r4chwIExEnYSsWwJV9P5X/SlvjongH6m
         ojbbxY4ZfzDz3kAU3ceeDMlKpZ6IQ56qcmxvfeJyr4+4gLpeJAoj2CvqNu7lKt7CMWXJ
         cjXA==
X-Gm-Message-State: AOUpUlFeJcUxHXJgjtqqT6PRLi20cYxJFu3thDez0JMCUdS2lvzspycY
        Zf1wJKBQIHc4kN5KTrcCxhxSMw==
X-Google-Smtp-Source: AA+uWPzn68Y3B8xyBWg+dE6ICZ/2z3Lb+T9lBhm69iaB6xT5hMPftIMPBK0GbWG+VTcFfbNnMUUzgw==
X-Received: by 2002:a1c:ea9b:: with SMTP id g27-v6mr1434389wmi.152.1533907040084;
        Fri, 10 Aug 2018 06:17:20 -0700 (PDT)
Received: from radium.baylibre.local (AStLambert-681-1-8-155.w90-86.abo.wanadoo.fr. [90.86.13.155])
        by smtp.gmail.com with ESMTPSA id i205-v6sm2069523wmf.30.2018.08.10.06.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 06:17:19 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gpain@baylibre.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 3/3] power: supply: cros: add property to detect connected ports
Date:   Fri, 10 Aug 2018 15:13:49 +0200
Message-Id: <20180810131349.3883-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810131349.3883-1-fparent@baylibre.com>
References: <20180810131349.3883-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a port is connected but acting as a source, its 'online' and
'status' properties are identical to a port that is not connected. This
makes it tedious for userspace to know for sure whether a port is
connected or not.

This commit adds a new property 'present' to reflect whether a port
is connected or not.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V1 -> V2:
  * No change

---
 drivers/power/supply/cros_usbpd-charger.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index fe1502715e46..6307424f36ec 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -32,6 +32,7 @@ struct port_data {
 	struct power_supply_desc psy_desc;
 	int psy_usb_type;
 	int psy_online;
+	int psy_present;
 	int psy_status;
 	int psy_current_max;
 	int psy_voltage_max_design;
@@ -54,6 +55,7 @@ struct charger_data {
 
 static enum power_supply_property cros_usbpd_charger_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
@@ -65,6 +67,7 @@ static enum power_supply_property cros_usbpd_charger_props[] = {
 
 static enum power_supply_property cros_usbpd_dedicated_charger_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
@@ -205,18 +208,22 @@ static int cros_usbpd_charger_get_power_info(struct port_data *port)
 	case USB_PD_PORT_POWER_DISCONNECTED:
 		port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		port->psy_online = 0;
+		port->psy_present = 0;
 		break;
 	case USB_PD_PORT_POWER_SOURCE:
 		port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		port->psy_online = 0;
+		port->psy_present = 1;
 		break;
 	case USB_PD_PORT_POWER_SINK:
 		port->psy_status = POWER_SUPPLY_STATUS_CHARGING;
 		port->psy_online = 1;
+		port->psy_present = 1;
 		break;
 	case USB_PD_PORT_POWER_SINK_NOT_CHARGING:
 		port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		port->psy_online = 1;
+		port->psy_present = 1;
 		break;
 	default:
 		dev_err(dev, "Unknown role %d\n", resp.role);
@@ -363,6 +370,7 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
 		if (ec_device->mkbp_event_supported || port->psy_online)
 			break;
 		/* fall through */
+	case POWER_SUPPLY_PROP_PRESENT:
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
@@ -381,6 +389,9 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = port->psy_online;
 		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = port->psy_present;
+		break;
 	case POWER_SUPPLY_PROP_STATUS:
 		val->intval = port->psy_status;
 		break;
-- 
2.18.0

