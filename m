Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5307CC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C00822402
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FlWt0QWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C00822402
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeHJPrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:47:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52508 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeHJPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:47:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so1853272wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EKERvPyccN5L6jSux9V7ILEhqtIjCsSZuoPK0qXWjtQ=;
        b=FlWt0QWQkvC2jCEGddZZXlWvOtTIqPrS7CDfGSQlO2pWIwqxoGMx2LcsyV+45S40ng
         61Ev0E6Vwl+a3BykxHy65WOTDZMPveZ35Xts0aRCTZyRt15pY5uIbg8B2RsqYXXJ1I2W
         wz3YkhyIwVjODK5aBCF/y4PPVx5trIAyerNtr1CFducwBVJjpRzCoIx8pxjz7AKqEo+H
         30AaZMivqxGiwGhUlfm7dVm3Koop4+Hgahh8s5DmU1CqbMtnazRM1yQXg6hs+geEagi6
         sA/ImXOtBXoOiWVvJ/l3AQGAJH46Skjm6OaFSd2zUDZZ6lMeWGwXvSnCZ8LZzfaYERI8
         gSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EKERvPyccN5L6jSux9V7ILEhqtIjCsSZuoPK0qXWjtQ=;
        b=ud/pODTR09BR78LolDe+jDoQxnoWhMy3LKhb7jlZhhb9G968mktnSzIjpmaks43Ptq
         c0okMAwMjJ1F1DexXzxb7mz14liynWNuGdM2jWR0oUUb0jQIuxx20VTwy91LsfJg18qn
         bJM0obMCTBdxJA7c3J9G7lSZWy9K1XgPMID69ixmmdZjmedyU+/rGcEgNV/zntvfexZR
         n3zIeH/46cHNVgEIQlLivbFDHRUP5qvgTuqsZHa3gvizFWXN+7IpWLnkefnSyailOz2A
         yxgXsGtf73tNNnoF5xs4ZWFFg4owXvC4i9iujnyVBQ0VwkctQ0lQqZR29ZaLoo5BOiLn
         64Gg==
X-Gm-Message-State: AOUpUlHJiY5Ajtv2pGaJKXy0qSMyE7xCpxwnaqAGEpffzkBCfk1lscxV
        X/wR78c3DL+CJDFQy4/MK2JnAAadDdh7Xg==
X-Google-Smtp-Source: AA+uWPwZMBbBYV9iQpzCSTR+viV+cpv+hcJT13Eunir9doqtLsTkcGhw8Dznxne+PMdiBDMcIKnGWA==
X-Received: by 2002:a1c:b213:: with SMTP id b19-v6mr1443257wmf.141.1533907037844;
        Fri, 10 Aug 2018 06:17:17 -0700 (PDT)
Received: from radium.baylibre.local (AStLambert-681-1-8-155.w90-86.abo.wanadoo.fr. [90.86.13.155])
        by smtp.gmail.com with ESMTPSA id i205-v6sm2069523wmf.30.2018.08.10.06.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 06:17:17 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gpain@baylibre.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 1/3] mfd: cros: add charger port count command definition
Date:   Fri, 10 Aug 2018 15:13:47 +0200
Message-Id: <20180810131349.3883-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810131349.3883-1-fparent@baylibre.com>
References: <20180810131349.3883-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new more command has been added to the ChromeOS embedded controller
that allows to get the number of charger port count. Unlike
EC_CMD_USB_PD_PORTS, this new command also includes the dedicated
port if present.

This command will be used to expose the dedicated charger port
in the ChromeOS charger driver.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V1 -> V2:
  * No change
---
 include/linux/mfd/cros_ec_commands.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 0d926492ac3a..e3187f8bdb7e 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -3005,6 +3005,16 @@ struct ec_params_usb_pd_info_request {
 	uint8_t port;
 } __packed;
 
+/*
+ * This command will return the number of USB PD charge port + the number
+ * of dedicated port present.
+ * EC_CMD_USB_PD_PORTS does NOT include the dedicated ports
+ */
+#define EC_CMD_CHARGE_PORT_COUNT 0x0105
+struct ec_response_charge_port_count {
+	uint8_t port_count;
+} __packed;
+
 /* Read USB-PD Device discovery info */
 #define EC_CMD_USB_PD_DISCOVERY 0x0113
 struct ec_params_usb_pd_discovery_entry {
-- 
2.18.0

