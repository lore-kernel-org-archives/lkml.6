Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39340C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3A52133D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT8WfW2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3A52133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934673AbeGFSen (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:34:43 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43607 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934448AbeGFSdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:33:32 -0400
Received: by mail-lf0-f65.google.com with SMTP id m12-v6so10510801lfc.10;
        Fri, 06 Jul 2018 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXEVhtVTb8SribB7mXS/puyWjY6YBc4dZdD7/tqgO5U=;
        b=LT8WfW2ZvWmPpcBe4NONSpocrzCIVaYNPfy5RA7VIEHY9w2K19BeAAkwgDSDcFEAY6
         G3NJAtai9S0F+h5dvKOQ/affeJEDdJu6Ej8CB9Zse27UD4LRweycPwsOCXRPYcUYb9Lh
         m1vX8XZ9Fc+X5qgRP73YW7zA0fIKAe2Ny9lGKelMx+a9rrzQlFwzd2rECG0DtMVJ0xq0
         bf+ydzhy7ViE789y5LHmtGBBg0dDB9qtSFZDVRrRUU+k6/J1DYLA4fbaCVb6FXEb3bkT
         Y55Im5Tkonyc7iyG9DqNq/5CuCtctQbhmd4xZCLDpCJ2NlCsKTRDrCTYzmusHA6+h10Q
         EWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXEVhtVTb8SribB7mXS/puyWjY6YBc4dZdD7/tqgO5U=;
        b=JpV9WsqNgamL6rT/BfVzyd+TsUhL8niJOwmrboUtv3RvUGJHfjXXzq31Nm3Tf1EpiN
         V8SqyCeeJI12ZNo+1FfFp7XzPCqvBG+dG06IZH6A7xOT4Nk7vw0YTNJIB8mRuRdqI9GA
         nCvuKTUiGr/e62p9CKK+my6vif43kXQhM/MsyX0nh1XLUbEwC1+NS16P+A3/47YUWz6f
         dLcJSjUqppMkr78liXzwxyCeQunJW4dJJlVEXYyz2ebapMBevblkRtk7tQ+STdHaYXEg
         8g1Av3enzcAn2++oqA99pzqvIHvOdY5ZKLcgtPvClwRDITudvcLo5UysjY12WAl2+2Zx
         Epbw==
X-Gm-Message-State: APt69E1lr+2eDZ/IX60yH5f5Yz+2E+Zoxx3e/4qtw8PVoPJiR5ghoClc
        B9BtHxLQVuoNXee8304Cgns=
X-Google-Smtp-Source: AAOMgpeprNYKWJHbLwu+T7w7+KI3suhi4zVTVhdcEnOlL6jW1XnEm+TpzwQqCne9gsmnE8jv+Dqupg==
X-Received: by 2002:a19:4419:: with SMTP id r25-v6mr8024615lfa.144.1530902010975;
        Fri, 06 Jul 2018 11:33:30 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id l82-v6sm2314697lfb.8.2018.07.06.11.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 11:33:30 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v3 6/9] dt-bindings: samsung: Document bindings for SGH-T959P board
Date:   Fri,  6 Jul 2018 20:32:47 +0200
Message-Id: <1530901970-14972-7-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Document the binding for Samsung Galaxy S Fascinate 4G (SGH-T959P).

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
--
Changes from v2:
  - Added Acked-by

Changes from v1:
  - Added missing commit msg.
--
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 3fa287a86300..37e96e48c48c 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -3,6 +3,7 @@
 Required root node properties:
     - compatible = should be one or more of the following.
 	- "samsung,aries"	- for S5PV210-based Samsung Aries board.
+	- "samsung,fascinate4g"	- for S5PV210-based Samsung Galaxy S Fascinate 4G (SGH-T959P) board.
 	- "samsung,galaxys"	- for S5PV210-based Samsung Galaxy S (i9000)  board.
 	- "samsung,artik5"	- for Exynos3250-based Samsung ARTIK5 module.
 	- "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eval board.
-- 
2.7.4

