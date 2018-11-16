Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B2CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C089020854
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="n0vakKae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C089020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeKQG4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:56:53 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43455 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeKQG4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:56:51 -0500
Received: by mail-wr1-f51.google.com with SMTP id r10so8622131wrs.10;
        Fri, 16 Nov 2018 12:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dm8SNVlCKr6Ckk9KEr1fcnOwJc1nkaFN9aiZa/NAWns=;
        b=n0vakKaeLfRNTnvkh1725cuKfcGsdsQ8eCTaqwwAeAn/l8ichnG+1UZcdX+RnMYmFo
         2odMCxLxv1HJYqxTgGXsis1Qyj4n0AE3Dd8t3qGc2xWpWJzO+5gzNW4W4gZR7UG7ph7x
         Guz0pI3ZSHi6v9IfJSI/JQl9tw8nk25V3R114E/6lZlan0M3bE8NcwQNjS4ClzxErNE+
         m2PvJFPqF77YQyTdqXnUk54i2/yWLGYcQkssDhj0HaOIpMaN9q0xRVEs1AKe3l/T+Nj/
         wJMPGsBXiaF6yvP9tk/XVD35uuXmhloWaswCFC/IvnnFDh7GVoeVvlq0WYtxe3ZUMVgy
         yNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dm8SNVlCKr6Ckk9KEr1fcnOwJc1nkaFN9aiZa/NAWns=;
        b=V5W5Ygd+M2YiNbU6rAEm3Rk5lvrysi3Zye76peebXQxPkgj0L5v2lKiiTzT/JFKluC
         bKQIVMSkGia1a5D6UANpO4AoYaJZUBRpNt4VbuPbuT97XFomJQJR4/rByCHRed+xkwEw
         lEZD6UWYO8iKxISPNs0F+Zvw1YoTXe5ptoFgCFH4Tjw9Z0GuQU2zwfzWAYccV/3ii5jH
         llv9UWg6z4v+oW8ShMRGhGlqLoDf0oMqgs2/KajtyhkAjXg3ouS1WlEihSBY/S10CdQO
         skvN+HFRkAzAQ9sGrqa/4nPTqHGaH9iytUu3G/UrbD8E38zin4c6n/WYZiWMSXFSr0dU
         ufZQ==
X-Gm-Message-State: AGRZ1gJ7FOdYQHQPm/jWjcK3yXwdA8ZaSyFszkrvk6KbdR6DO21GuiEv
        ekhqo6/I5/3uSklx7ZClf6w+Ob/L
X-Google-Smtp-Source: AJdET5eetc0Jv7+B260nnIE+S093nFg3vWG3xA2cVbJuLrntqL40aCucbUbCNkcH+27Ty7BKezNnCw==
X-Received: by 2002:adf:aa94:: with SMTP id h20-v6mr9201219wrc.216.1542400974323;
        Fri, 16 Nov 2018 12:42:54 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A1006D214A3B023844E6.dip0.t-ipconnect.de. [2003:dc:d717:a100:6d21:4a3b:238:44e6])
        by smtp.googlemail.com with ESMTPSA id y34sm6000758wrd.68.2018.11.16.12.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 12:42:53 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        carlo@caione.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] ARM: dts: meson: add the TIMER B/C/D interrupts
Date:   Fri, 16 Nov 2018 21:42:34 +0100
Message-Id: <20181116204235.3925-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116204235.3925-1-martin.blumenstingl@googlemail.com>
References: <20181116204235.3925-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer on Meson6/Meson8/Meson8b SoCs has four internal timer events.
For each of these a separate interrupt exists.
Pass these interrupts to allow using the timers other than TIMER A.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 0d9faf1a51ea..f0255450bcb2 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -200,7 +200,10 @@
 			timer@9940 {
 				compatible = "amlogic,meson6-timer";
 				reg = <0x9940 0x18>;
-				interrupts = <GIC_SPI 10 IRQ_TYPE_EDGE_RISING>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_EDGE_RISING>,
+					     <GIC_SPI 11 IRQ_TYPE_EDGE_RISING>,
+					     <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>,
+					     <GIC_SPI 29 IRQ_TYPE_EDGE_RISING>;
 			};
 		};
 
-- 
2.19.1

