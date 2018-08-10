Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8155C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B3322448
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCP2cj9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B3322448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeHJUZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:25:04 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41926 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbeHJUZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:25:04 -0400
Received: by mail-pl0-f68.google.com with SMTP id w19-v6so4339320ply.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IelGpd/z2IvduYrvYJidVrLnwEJVhcX7SHncdWlmbfM=;
        b=TCP2cj9QqPQ7vO1hqJ44Yuw3mKedscffWaBghRoY0KZCdY6fl5waNC3ILWT/r9I6Jt
         PbHrtfZ/UdDGFzLl9zUN+H5kIEOU+xrTxF5TmcTCupvEIHPToZZ6Ga+sjTKgFhSTUrhd
         RCxdLtvlAr4Acq/4xzqUnV/mXS0hOSFVSTFHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IelGpd/z2IvduYrvYJidVrLnwEJVhcX7SHncdWlmbfM=;
        b=QIZrZ5FV39TCYn1pqmWTtr+xjgmNf6WSS5UYz9c0hXqXZQ0NH5+mntjSkVRfSuFLLr
         oyEmMkcQQ7Qvq8ezaxklbXK1nD6N5TTZBdpTJitpNrEDR7o2h9o+lJ3T341F52/z8tUF
         tA8/XtMq3nDc0bUG1blOzodOMKx5BUe8Ki/CMsmhF/abisf0ERZOZfuP9D6htIGvskHl
         eaOsBu/kW/v0EO2dHnXW+hF8gIyOamIUvUYtsfiJQ0TdMmhECGKM89/sRYkqtntOqHNg
         z3md6tuSrM9ka4jQGHaR57zETZSJt4zMp7ewKP5kT3dbuqlBFFoHE/xhaqNdPpGo0fuA
         gNZw==
X-Gm-Message-State: AOUpUlH1SFsYEe+FZY/3tGnRKsGdSsbdqsq4O1jcCpwp2MAnTER54kIa
        ANW5jNiGFRDjdcQrYbuNSrIu
X-Google-Smtp-Source: AA+uWPwg0cN9Tah3XgdyCZZmBrZUsmoKRjClOVn5/rpUSFXhKqOXCOCn/SMQyLMeH4W4TJQdXqR4yg==
X-Received: by 2002:a17:902:6b44:: with SMTP id g4-v6mr6993236plt.50.1533923652070;
        Fri, 10 Aug 2018 10:54:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id l127-v6sm16981262pfc.55.2018.08.10.10.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 10:54:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/4] dt-bindings: arm: hisilicon: Add binding for HiKey970 board
Date:   Fri, 10 Aug 2018 23:23:38 +0530
Message-Id: <20180810175339.25421-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
References: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for HiKey970 board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 14f54f569c63..a97f643e7d1c 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -12,6 +12,10 @@ Hi3670 SoC
 Required root node properties:
 	- compatible = "hisilicon,hi3670";
 
+HiKey970 Board
+Required root node properties:
+	- compatible = "hisilicon,hi3670-hikey970", "hisilicon,hi3670";
+
 Hi3798cv200 SoC
 Required root node properties:
 	- compatible = "hisilicon,hi3798cv200";
-- 
2.17.1

