Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959B1C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628A3218FF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d5EQxlhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfBQJPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:15:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35146 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfBQJO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:14:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so6977581pgs.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 01:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okBCXL5ZObi1PQJODlH9Ry376R4p7BpEcaEwmiQ3GnM=;
        b=d5EQxlhq1n3AbV5nwFJNW1ItP7iVR/cZqsiNEo80YqXTTeed9blO+zHlLYD0RIz2RB
         SbpIQlLIDISRDzKMyCed1uv8MCV2uK3++YdqWXJxTkNfG2VS8YCCT18yGiemn0glqedi
         0A7ye5K1a7JWwDG/GXQ7HfNksA8rwezGB3SnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okBCXL5ZObi1PQJODlH9Ry376R4p7BpEcaEwmiQ3GnM=;
        b=BqpLLIcPlRRGHNokvWYOOwG1Pnlc9uW9lMrm7GsfPD+MzX4ML5PbIZpLMzLxP2zaMt
         HzxVAx6kxf6PSDPzdAk/0uyQ3QSyjz1ffpKVRGHLdQIwPtlOTyxBMjeWdCb4ZiKpUBtW
         ExWUK1ARoVh91f5ay4ZahVbe9aRTFcFchA8Hp/4DhhOVNten0PK0iOYX1iPQ6Mb+gXfL
         zmc1ZZmjRy17YtHvJFOb0xEQY6SQ52QniVPL5TGKoGktGwnXAwp6d/oB/v3+ZC6locKh
         UsozxNxhGORK+6Zg2vilc8zKD1XkCW7Zj8tdjae1aUrezU9FGYtggXT+dtbhFMRmVS33
         0qbQ==
X-Gm-Message-State: AHQUAuaCG4lIwHGgDSKZHN/4KeTL2CXEJVo89yfJb0bvNPuO2Cq71A9l
        HpEajU8tJofA88gpJKReSEh7qg==
X-Google-Smtp-Source: AHgI3Ia0DIu9n2dwODlYftgmBt6QfrrKaui0ah3kZHxG0NZzgLFdMTPAS0c4gY/rsnCF82KG9aefog==
X-Received: by 2002:a62:59d0:: with SMTP id k77mr18387851pfj.211.1550394898665;
        Sun, 17 Feb 2019 01:14:58 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id v15sm5565924pfa.75.2019.02.17.01.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 01:14:57 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 3/4] dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
Date:   Sun, 17 Feb 2019 14:44:35 +0530
Message-Id: <20190217091436.3702-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190217091436.3702-1-jagan@amarulasolutions.com>
References: <20190217091436.3702-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GT5663 is capacitive touch controller with customized smart
wakeup gestures, it support chipdata which is similar to
existing GT1151 and require AVDD28 supply for some boards.

Document the compatible for the same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 8f6e6eede64d..29c149d91a05 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -3,6 +3,7 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
 Required properties:
 
  - compatible		: Should be "goodix,gt1151"
+				 or "goodix,gt5663"
 				 or "goodix,gt911"
 				 or "goodix,gt9110"
 				 or "goodix,gt912"
-- 
2.18.0.321.gffc6fa0e3

