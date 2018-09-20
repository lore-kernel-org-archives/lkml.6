Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33DCC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA192147C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm8Sk9as"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA192147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbeIUCd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:33:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38787 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIUCd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:33:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id z186-v6so9597447lfa.5;
        Thu, 20 Sep 2018 13:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aoU68YPWBq5ULKjjIS0MY2JHK9EjJmHwFgVyaZnB0qo=;
        b=hm8Sk9asoaL9/gYnB0INLPcQ6FbRy8OSvXHZFEbYBXg9138vUhWUqnDf2FB7xPa18T
         t+JaUm9PI20bOOw96THuvxUsalP5CEjUHrucTTR+BB5Tu8IulvZBCTJApfBhrjHRkMI1
         zhfofY6hwlTg2Wmh7h8TVUKO7+toqERA7N0kqu2eESq0KENWQoG6M2Zr0cmDsD1+VNyQ
         Apx505mN3sQwg92X8H89/RmXme9aymAZsNbLb/h5rbFinn5PNwpPCgXw/0OQlWmQwJZZ
         szTi8QYl4Np5JeeuDuqx65WLR1Uh7QQBbDwMoq0HlnjleDPGqOnhu9bh9cJF8YpjR+Do
         xWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aoU68YPWBq5ULKjjIS0MY2JHK9EjJmHwFgVyaZnB0qo=;
        b=un7mQ4t1RPHMDh/4TD8vtcnQDzo7ofGhr3jAzHqeCjeBNzo1GshKhNjPCVjaIjt0Il
         VhA/KZ/2r4CrldgCvsA+mBWro4WTvbUUjWRQ8zvuuAEitKqQ61+oj+LQ1ynSH+tmIkws
         3gArBlwDT5rWw/1CJE/KQ7n90ApCPqyFJmLua6AgslOD9hBAyK2oJf/WWEJRnHsn0leM
         0K2Vc8W+tuEbWk900pTP6PdYhl/ZZNyMrWFEbyxxveey9lhj9yypwXxTDOcgZ3mu3IIC
         mZDGI/OOvVexdrqIZI40xqzmMPmZ8Kz6GYElNpSKf640x8kv3NVSu/i2gMbrEHT1wQWv
         gKQA==
X-Gm-Message-State: APzg51B7N5aa6iRd8JYHTYQLSuzVZQtf9Gj1MVDM53grio/PuT95uYJj
        ODhs1jZNOQsenMUnzzLO3f8=
X-Google-Smtp-Source: ANB0VdZOiRYlrEi9EHaOBjij5hbm9RRITd/8wntCQ76xxdOA1p8rpgH8jH1lhkBcWSYQK1wTM8Ik0Q==
X-Received: by 2002:a19:e307:: with SMTP id a7-v6mr5735998lfh.125.1537476484529;
        Thu, 20 Sep 2018 13:48:04 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p4-v6sm1821609lfj.49.2018.09.20.13.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:48:03 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 7/7] [media] ad5820: DT new compatible devices
Date:   Thu, 20 Sep 2018 22:47:51 +0200
Message-Id: <20180920204751.29117-7-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new compatible devices.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 Documentation/devicetree/bindings/media/i2c/ad5820.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
index 9ccd96d3d5f0..cc7b10fe0368 100644
--- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
+++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
@@ -2,7 +2,10 @@
 
 Required Properties:
 
-  - compatible: Must contain "adi,ad5820"
+  - compatible: Must contain one of:
+		- "adi,ad5820"
+		- "adi,ad5821"
+		- "adi,ad5823"
 
   - reg: I2C slave address
 
-- 
2.18.0

