Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3C1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3F22082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3gwxVG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3F22082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeH3XFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:05:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41141 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeH3XFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so9015115wrb.8;
        Thu, 30 Aug 2018 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sraoSY6qZjrZRIfeRh62DTHFySBoXzTSH2FTf7JXmOs=;
        b=W3gwxVG6IISFkXvk50OeRiiIKJA6zOn/hELmx9a7gjYunq70QBl9w6xb9/XbQDuTaI
         sTxImBCJZ7a7cOIOxQt3ApwJMphWPsnh+/SA44zC5g5TelXPhAjiOvg0vGPJ/VWuDyVm
         Ez3ennhJ9LOkawNrfmbHUKgcc0qmD7VPai4AInAhdt0sCj0LRLafCcoHna7se4SO8X6T
         7REyZjl44Scu0fUKk25nmMW5v7Nuw/ccYotp83wb0abHc0xEHh3YoQkcuNK9Dp4dautw
         R+NgL700rFtUoh7w52ApupxdXqDCc8ziCynD81jIebVVOqku3yepzzPVkOYNZBzhm1vQ
         ZE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sraoSY6qZjrZRIfeRh62DTHFySBoXzTSH2FTf7JXmOs=;
        b=fGw4eYp/kA5KnJ/BBYnRX7uS1kVL2KB4gLVDTBz5qUIMjLmsUdWq165SKo8yYXUZHV
         Z+SssA4hvXr6NYjA7N8NGk17FKJzNG7FwCxoPMObuySJHlpr6V2nSz8qTO0OCerU5gzx
         NZN/wMdH4JNCwh8s21ZQEMFSm2m2HiYyR+F9J85KXBKJEIpHPONYpvPbCvxGI8iJS10W
         jtWTWufOPZ7zSXxrGfz/xI4LNPPcCzoTjH4xfFO35V/1h6RE1p5rHkluUsKCNp+05Idg
         U5Im8Ng8AKSCipzetu7mEuqFoURTibF7zL1RCMFlAXf1kJCwF+fzOpSia89tUEOuMGCq
         Q6Pg==
X-Gm-Message-State: APzg51CHORnraTB/punGQnFVQpW82mhsPgtygFMh7Fj6dM6OE+uN9wt8
        6G8r1pq2wCzzgXxN7d9xh8s=
X-Google-Smtp-Source: ANB0VdYq5m6QUBe0qXoMff/xa6xeZAMyVi3hjE5Bm4I9MaXpBsy3diZ+NRb/7qwi6Y5erix7EOZ3nw==
X-Received: by 2002:a5d:6103:: with SMTP id v3-v6mr8719102wrt.265.1535655696549;
        Thu, 30 Aug 2018 12:01:36 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:35 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 05/13] dt-bindings: phy: document sun4i-a10-sata-phy
Date:   Thu, 30 Aug 2018 21:01:12 +0200
Message-Id: <20180830190120.722-6-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch document the sun4i-a10-sata-phy bindings.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 .../devicetree/bindings/phy/sun4i-sata-phy.txt       | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sun4i-sata-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/sun4i-sata-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-sata-phy.txt
new file mode 100644
index 000000000000..f031542717c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/sun4i-sata-phy.txt
@@ -0,0 +1,20 @@
+Allwinner sun4i SATA PHY
+-----------------------
+
+Required properties:
+- compatible : should be one of
+  * allwinner,sun4i-a10-sata-phy
+  * allwinner,sun8i-r40-sata-phy
+- reg : a list of offset + length pairs
+- #phy-cells : from the generic phy bindings, must be 0
+
+Optional properties:
+- phy-supply : from the generic phy bindings, a phandle to a regulator that
+	       provides power to the PHY.
+
+Example:
+	sata_phy0: sata-phy@a01800 {
+		compatible = "allwinner,sun8i-r40-sata-phy";
+		reg = <0x00a01800 0x4>;
+		#phy-cells = <0>;
+	};
-- 
2.16.4

