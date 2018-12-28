Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC5BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B96220879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJx7EoKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733202AbeL1Pqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:46:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36009 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731486AbeL1Pq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:46:29 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so14802154lfg.3;
        Fri, 28 Dec 2018 07:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyuL012aMVSzztJhiL8O2OGBowL3br08/1hPFhnmrqI=;
        b=HJx7EoKEQfA1u9l1c91nZ97d3OT08ikoBUsxt/92nGPCHSWduPzbGdRyz5IbvXHmas
         jW8rz2NgjDgL5iKFhfJ9k1BVJewBo6A43vFD9jj60NlvIzoeEMqMCW38VgagMkhPvkw1
         Mj4siqhqcWczaN/N9KapL8o1RXfsUR/M1ntoR0wd9XlC4GX1tvy97rG2foqeoexWMCpG
         OG32ntIFZOn+ppcVSCloa5Y3XXyOhXK6CqbkyJoik0cNJXYzN4vkdqJtiF3A6CPgQ10C
         hOHmYwyL4ZJkitbIDNGx7W/sEfqXa2Pgj8HLZQjUrVNP/zOIvS2glWy64TeQAAfLDL1q
         hPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyuL012aMVSzztJhiL8O2OGBowL3br08/1hPFhnmrqI=;
        b=WmquRjihctn/YyfwDMtUefV7ljGn4Q2X3e01cxiHWhg2NGJZuQOTYwHBywQ8DkZcYl
         84M/yJIc3TXeKjihPo6OBfxHdy3PiRyKHvi9vfJ8yLIaGhZk/Y3I9TJq2/6C81DCsY9M
         Hk9zrietis90az+TbyDoORyWVqXYGGSvE4zrfdrjbMSPial2LFyYnhGzAAjMbNGNIw0X
         +ahnjMHd+ALjMSALbipoILIzIMOK8tOJ1BIhHYdDpatwj4ITsKt8LpYTQ95sAXQ6Knws
         Fj+Tw07bGN7+OlZqKvuDlejQstJEW3q48V4vsTckA9XgYhEPnhe7cL2juQU0TWEBqmR8
         BBZw==
X-Gm-Message-State: AA+aEWbLIfbp/eTlFOGqCES7u6zQLZk/lJfWVlJsQnIcWD8PJyck8bVG
        GZ3tLf98aK/4aBMQ1UpjjcA=
X-Google-Smtp-Source: AFSGD/Xk6TxcKx6nuAbcsQv/Q/c+W1Wj3WQTAaFXyMWw2Se/EesPY02L9bULqkbyT4t9vu40uj0E1w==
X-Received: by 2002:a19:5394:: with SMTP id h20mr14963890lfl.75.1546011986820;
        Fri, 28 Dec 2018 07:46:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id c203sm8042444lfe.95.2018.12.28.07.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:46:26 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v2 7/7] Input: dt-bindings: tm2-touchkey: Add support for aries touchkey
Date:   Fri, 28 Dec 2018 16:46:09 +0100
Message-Id: <20181228154609.14846-8-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes from v1:
  - Added Reviewed-by
---
 Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
index 15d4bf4f307e..c40a36cd29ad 100644
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

