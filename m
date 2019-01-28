Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A564C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD88214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWY9dYgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbfA1REH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:04:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50922 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbfA1QNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so14635177wmd.0;
        Mon, 28 Jan 2019 08:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L2gKyLYkowozqfijDGFMP55qaLskmB+BRZLlU0AhdSc=;
        b=nWY9dYgO6UiwryAAXlREPXPFwRMlr1tqiOAdxRTXONzioloYS9i0ughc6wnw7PrDeD
         GAL/0j5bZ9j6Pv7KO+4x5fGyNPp0viMihy4/oQdLJnnaP+Cgac1BAoHYfg+rnZEmLjHN
         ciqWuupTZB0cHEljbowL4124PuV4vvd1BMHvDXEjXfWxs2h+Whz+HjBiV8LfrOyEOOoP
         b3sy90u0vET1RH8LcJTbE5zj/sDEdqC5EiVLLS96svsZYaqJjjR/bd6ZMMuqGk+2on7L
         wHQtnmgtbBxErLEOreRFFyiiNgOkWbqAWPeeiYzJB0yV/4cbCYwAhQMqcJAXVKIrjCkS
         eKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=L2gKyLYkowozqfijDGFMP55qaLskmB+BRZLlU0AhdSc=;
        b=j5By9P0xLn5E5nP6qpExoKfeu9ST7Qpi1oKNiZR1RZKJ/J5E0vn73KzTukgGf9GZWU
         xVQhCol8mCe2ajJAHfdYwZrLa4jivAjzqM7MDf3F5IPXNE+OersGfg09HT+DDf8RjJvF
         7+ubRRsbSHqdwYPxUptkFHaTmHBvB4leExqmK9CfsZuhNqVhlDsNy6agexpVB43o+sTW
         5bIV9QxItUb2KuBVtuLCGw0zQ7klNQn6UPncC1KihnWMKdxlD6VC7PVPW/o8wTCoLTB4
         EcClnsHUE7bTqOLU1GAZc5lW8Mo5OQcRt+b+PQ5X+pac61c5NsMjxth/6YsCWRbfbwSW
         Dftw==
X-Gm-Message-State: AJcUukdTHJdnioR0piIGXbiZyDeV3039Miu28/o6/enJO1PNRqTupqWJ
        SP74I0DSmiHlukx76wZ/jWc=
X-Google-Smtp-Source: ALg8bN5Z/tQEsqHAY7YrRtIUgtyqu4CHMPSSZw9br+HnebYEFXQezfp7QBR+GM28vUWKYUWzwyMd3w==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr17096099wmj.127.1548692030062;
        Mon, 28 Jan 2019 08:13:50 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id l20sm246445944wrb.93.2019.01.28.08.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:13:49 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH lora-next 04/11] net: lora: sx130x: add helper function for writing to the SX130x MCU
Date:   Mon, 28 Jan 2019 16:12:58 +0000
Message-Id: <20190128161306.27805-5-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128161306.27805-1-ben.whitten@lairdtech.com>
References: <20190128161306.27805-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

The transaction to the internal MCU starts with CMD_WAIT to start a
transaction, written to CHRS followed by writing the value, the status of
the command is read back from AGCSTS.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 drivers/net/lora/sx130x.c | 28 ++++++++++++++++++++++++++++
 drivers/net/lora/sx130x.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 529ca6622878..818a1c9192b3 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -337,6 +337,34 @@ static int sx130x_load_firmware(struct sx130x_priv *priv, int mcu, const struct
 	return 0;
 }
 
+static int sx130x_agc_transaction(struct sx130x_priv *priv, unsigned int val,
+				  unsigned int *status)
+{
+	int ret;
+
+	ret = regmap_write(priv->regmap, SX1301_CHRS, SX1301_AGC_CMD_WAIT);
+	if (ret) {
+		dev_err(priv->dev, "AGC transaction start failed\n");
+		return ret;
+	}
+	usleep_range(1000, 2000);
+
+	ret = regmap_write(priv->regmap, SX1301_CHRS, val);
+	if (ret) {
+		dev_err(priv->dev, "AGC transaction value failed\n");
+		return ret;
+	}
+	usleep_range(1000, 2000);
+
+	ret = regmap_read(priv->regmap, SX1301_AGCSTS, status);
+	if (ret) {
+		dev_err(priv->dev, "AGC status read failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int sx130x_agc_calibrate(struct sx130x_priv *priv)
 {
 	const struct firmware *fw;
diff --git a/drivers/net/lora/sx130x.h b/drivers/net/lora/sx130x.h
index 6330777f4eac..69bb9cbd1aba 100644
--- a/drivers/net/lora/sx130x.h
+++ b/drivers/net/lora/sx130x.h
@@ -18,6 +18,8 @@
 #define SX1301_MCU_AGC_FW_VERSION 4
 #define SX1301_MCU_AGC_CAL_FW_VERSION 2
 
+#define SX1301_AGC_CMD_WAIT 16
+
 #define SX1301_TX_GAIN_LUT_MAX 16
 
 /* Page independent */
-- 
2.17.1

