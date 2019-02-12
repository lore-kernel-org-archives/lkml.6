Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9BBC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DCD206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="G8w8fphB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfBLLY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:24:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39307 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfBLLYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:24:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so1152054pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 03:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/RnVmA/kb8L4Yz4fb0H81a9TQRGfgVwPZ/JkhxzRPgU=;
        b=G8w8fphBPXuj3iBildqXBEz+tKWOTChJi5Z+AlxcFyYgpOnhsjVpJ/YZFIoYya6bq+
         lONaDnBOTiiUn6x1Dp9fNTnutBd5UyL58GyYlmbOoy4Dmhl5Dg/h05MJx9XsA6Q/M2Hs
         hhpmeb5b+we3YP/QS1O7KyMC7vYfbvaCe49P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/RnVmA/kb8L4Yz4fb0H81a9TQRGfgVwPZ/JkhxzRPgU=;
        b=bc3AcyG4ZZNGFumFxkVbc75KathQ7M7y0syUWLKsOrBn2VY/GKD1H9gGirLM1jHlPM
         942LrDTGOxM9Zd35wq/O4lDGdFnIITKzOOp8AqU8xJbMf2SiNH5JuorlV9hbi2pS+5eH
         ijoyjK/7gnMS7i59xYyxrhxoyZPWlRl7HVF9Mn0LlOyubwUn6/YX8h7gGG03ggZyc24R
         hao/amQCaaOgaiiaFWjLiAUgsnewsVvgySCF+LzIby8BmJ3mqgz5DbQi9UDsbY1eQhko
         Y5uED7PSY15ClvN6lpbvt9EpOMFmtKykuS3SxwpogFOZGukKh2GeHWnblCHqRZSyGc6H
         6teg==
X-Gm-Message-State: AHQUAuaEUQnm7wNUXXELnsFpE8i0gObIvY/iCKzZd2PPy/s9KelPqjnQ
        jkU2o+Px0O97Lc7sDvJalZidXg==
X-Google-Smtp-Source: AHgI3IZ1KKRlIKJSIhCoNaqVEMSLdHPFzuXNCIw5K0cRVx6r/Ew/kq4DECmyPVAwmGSS0C5yhy9zag==
X-Received: by 2002:a17:902:4d46:: with SMTP id o6mr3409148plh.302.1549970694385;
        Tue, 12 Feb 2019 03:24:54 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id q28sm22399460pgl.35.2019.02.12.03.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 03:24:53 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 1/4] dt-bindings: input: touchscreen: goodix: Document AVDD28-supply property
Date:   Tue, 12 Feb 2019 16:54:36 +0530
Message-Id: <20190212112439.2025-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190212112439.2025-1-jagan@amarulasolutions.com>
References: <20190212112439.2025-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Goodix CTP controllers are supply with AVDD28 pin.
which need to supply for controllers like GT5663 on some boards
to trigger the power.

So, document the supply property so-that the require boards
that used on GT5663 can enable it via device tree.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index f7e95c52f3c7..c4622c983e08 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -23,6 +23,7 @@ Optional properties:
  - touchscreen-inverted-y  : Y axis is inverted (boolean)
  - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
                              (swapping is done after inverting the axis)
+ - AVDD28-supply	: Analog power supply regulator on AVDD28 pin
 
 Example:
 
-- 
2.18.0.321.gffc6fa0e3

