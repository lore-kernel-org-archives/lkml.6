Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9446AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B0E2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edA8xuaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B0E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbeLGK6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:58:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40413 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeLGK6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:58:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so3170581lji.7;
        Fri, 07 Dec 2018 02:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YPVI7ddGXHL/sI3LM7P/pieE7PZRuOllK+/qgFw2o3c=;
        b=edA8xuaBfJ7ZjqT6mf607UJU6PslZiLYY94/NRu4lJykOjbjR0Vjpx8VZmniSLwJFH
         e3QL6gTdR2n0mWP7fWbCJvrmZynofHOLWogzsUrlD/J+azJ2UDbYSpbI3SeO7fs+WEfJ
         1k8n0y/6soev/AFRKMsVghr3gbhW64LND1+xA+wQRQAqn7aH6O8ILtrCtCHqMgE+K5yR
         yUgnXjrcFyEFQLCA/LUISRkKZvKbGoIj3U0aGNA4JRYXajwCsGzXc9cy0VmxY5wyC3d8
         3aEEGv6AdttyMadg7JZCOjhnSEID7r3T9H/0l8GgAJMmqBiR3tYlarhasMEy4eIkb0a0
         Q1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPVI7ddGXHL/sI3LM7P/pieE7PZRuOllK+/qgFw2o3c=;
        b=Y6heh3JhVV1NdDEk7UdUpt+jW4/qNYE1LQMSoinpKqvPAkAkqv6cuadrtlawcld6Ip
         gLQmasOY26dhJlcd62fLPEQEiniyFE3nkt6WVpYbD/591woIawZNjFmH6llNe9Ceb/n2
         9F7vKrMFTkRQ/OMDvUMPKLt804zQLPK0tAjto7xrDmgEtjJptYMMWZl3E0822UeucQqK
         4blhmaDLhBJEeD/tGNXrl/lPOdCeaXcate24EmV9iVNejmqcr7eH4KXECOK8SVAQrpse
         GLBwJSS3KZ0Khp1IJFMnVnC36rsY5mfi0Bd2FOpebUucnxb+69HQILcfaXaMtEEsB4eT
         LybQ==
X-Gm-Message-State: AA+aEWaNHQ2nLX6Y+qTt499g8MlGfrC1bglUy2npr6OgSPSrsQ+qgtCk
        OUWKzNSUa8qMTjwCfojPmes=
X-Google-Smtp-Source: AFSGD/Vqf5bmnnG/s/gAGo+cvOvunecLn0S1Vx0OD2bMUQby6DWb9CWFXzTsdJw93oSdG2oKwIjqQA==
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr1027901lja.170.1544180310849;
        Fri, 07 Dec 2018 02:58:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
        by smtp.googlemail.com with ESMTPSA id a20-v6sm523362ljf.28.2018.12.07.02.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 02:58:30 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH 8/8] Input: dt-bindings: tm2-touchkey: Add support for aries touchkey
Date:   Fri,  7 Dec 2018 11:58:11 +0100
Message-Id: <20181207105811.1831-9-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Document compatible for aries touchkey.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
index 3b54d997b8de..c518125d16f5 100644
--- a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
+++ b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible:
     * "cypress,tm2-touchkey" - for the touchkey found on the tm2 board
     * "cypress,midas-touchkey" - for the touchkey found on midas boards
+    * "cypress,aries-touchkey" - for the touchkey found on aries boards
 - reg: I2C address of the chip.
 - interrupts: interrupt to which the chip is connected (see interrupt
 	binding[0]).
-- 
2.17.1

