Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4AEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6671E21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTgOsLGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6671E21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeKONEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:04:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36298 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKONEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 08:04:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so1128636pgm.3;
        Wed, 14 Nov 2018 18:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vnGKn21GuxPuJAqQR+VJ5kBIIu+qIP1/T0+dJpk5kfE=;
        b=hTgOsLGtfidqlz84RYneEfHeM62wHoZNQK0Ig/ZU6GhnmnIKT3kI8A+nYs/Fwa5Mwg
         Ip0r473P1jFvUp/muMn9KWG8d3wnzxUTN5bZbZMkFRbNEk0nh8EOQ/uubLu7VUADyeNh
         +cA/qGgVCIvFKDo0svVWD3Kw52oMXVTibrILQ4Q8qfsmDOxCkYFA/pxwOQxVsyc5lNsQ
         nqKgl64OF6fb/acV7PmxdMBTa7WB1GH39ntlrGDs76B37DHiv63Vzt8kUg1xRJNBT2vy
         YykxJS6jDxaDpn/5vofmgCs1hox1+l7f+F1YxVA5dCuDmvjWDDXtDaG8fzTGnqrnObDl
         laAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vnGKn21GuxPuJAqQR+VJ5kBIIu+qIP1/T0+dJpk5kfE=;
        b=cHXgFWhEjigh8G+4V+K+Cl1vAhPU/0dqzK4lalrYByQTOAL6LWw8Aaa7g0172uahFv
         l6MjSwaCiaYwl+noNpKAJEpseDVBoLnEyHPLUhlSMmp37MeDZAXXQ9Hx61ApfKI2kShS
         Q+ONbE4SOaF8DNvypSmKTsJnR3p3D2dqmW3C2kze2FMoUPfCcQwDyC2Lf8XLvc6IJU1J
         NqJAXbWQYiuSj8LQPVPPYW4T5Y1D/w2yXrs3s8XQ+/rkw2lGeaeaWScEcYOCwW0ohflF
         RbMNdMaY9iNtX7/Ls62Z5DtGZGLfJVerVJO1QggTT0we/TYolLjOaV+E7qC/mpaYT44G
         pCLg==
X-Gm-Message-State: AGRZ1gJVFFzvvAgXeQscUqjlljxgOJrs2K+GIkKhxXIWy7wob/8cxJ3K
        MwVTaS909N4aUN2tGGyVaoA=
X-Google-Smtp-Source: AJdET5c8wakfesr5l1SWUs0KxGRThRGcFWaUSpv0qgL1HqxHEFS16+skgjfZH6MFCO6a976L/NsVaA==
X-Received: by 2002:a63:6782:: with SMTP id b124mr4199101pgc.151.1542250732313;
        Wed, 14 Nov 2018 18:58:52 -0800 (PST)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id i193sm32940204pgc.22.2018.11.14.18.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 18:58:51 -0800 (PST)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V1 1/1] USB: serial: f81534: fix reading old/new IC config
Date:   Thu, 15 Nov 2018 10:58:44 +0800
Message-Id: <1542250724-11667-1-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The F81532/534 had a internal configuration space to save & control
IC state with address F81534_CUSTOM_ADDRESS_START (0x2f00). Layout
as following:
	+00h: to indicate the section is valid
	+01h~04h: UART Mode & port availability
	+05h~08h: Output pin control on IC power on
	+09h~12h: Output pin control on working <-- New added

Old driver will use +05~08h as default on working, but newer IC will
configed with shutdown mode(7) in 05h~08h and working mode with RS232(1)
in 09h~12h. It'll make mainstream driver not working.

This patch will make mainstream driver compatible older and newer IC.
If using a old IC, the +05h~08h will be 00h~06h, we'll direct apply it.
If using a new IC, the +05h~08h will be 07h or larger, we'll read +09h~12h
to apply newer configuration.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81534.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index 380933db34dd..2b39bda035c7 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -45,14 +45,17 @@
 #define F81534_CONFIG1_REG		(0x09 + F81534_UART_BASE_ADDRESS)
 
 #define F81534_DEF_CONF_ADDRESS_START	0x3000
-#define F81534_DEF_CONF_SIZE		8
+#define F81534_DEF_CONF_SIZE		12
 
 #define F81534_CUSTOM_ADDRESS_START	0x2f00
 #define F81534_CUSTOM_DATA_SIZE		0x10
 #define F81534_CUSTOM_NO_CUSTOM_DATA	0xff
 #define F81534_CUSTOM_VALID_TOKEN	0xf0
 #define F81534_CONF_OFFSET		1
-#define F81534_CONF_GPIO_OFFSET		4
+#define F81534_CONF_INIT_GPIO_OFFSET	4
+#define F81534_CONF_WORK_GPIO_OFFSET	8
+#define F81534_CONF_GPIO_SHUTDOWN	7
+#define F81534_CONF_GPIO_RS232		1
 
 #define F81534_MAX_DATA_BLOCK		64
 #define F81534_MAX_BUS_RETRY		20
@@ -1337,8 +1340,19 @@ static int f81534_set_port_output_pin(struct usb_serial_port *port)
 	serial_priv = usb_get_serial_data(serial);
 	port_priv = usb_get_serial_port_data(port);
 
-	idx = F81534_CONF_GPIO_OFFSET + port_priv->phy_num;
+	idx = F81534_CONF_INIT_GPIO_OFFSET + port_priv->phy_num;
 	value = serial_priv->conf_data[idx];
+	if (value >= F81534_CONF_GPIO_SHUTDOWN) {
+		/*
+		 * Newer IC configure will make transceiver in shutdown mode on
+		 * initial power on. We need enable it before using UARTs.
+		 */
+		idx = F81534_CONF_WORK_GPIO_OFFSET + port_priv->phy_num;
+		value = serial_priv->conf_data[idx];
+		if (value >= F81534_CONF_GPIO_SHUTDOWN)
+			value = F81534_CONF_GPIO_RS232;
+	}
+
 	pins = &f81534_port_out_pins[port_priv->phy_num];
 
 	for (i = 0; i < ARRAY_SIZE(pins->pin); ++i) {
-- 
2.7.4

