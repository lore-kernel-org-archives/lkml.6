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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D840C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5911621535
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q36Ufa9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5911621535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388567AbeIUCbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:31:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36436 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:31:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id v17-v6so5695502lfe.3;
        Thu, 20 Sep 2018 13:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aoU68YPWBq5ULKjjIS0MY2JHK9EjJmHwFgVyaZnB0qo=;
        b=q36Ufa9hYCPcBxD/SuFbUyaN3gGwRHLTsA4zRYWHnDjPNuFHnel+SmIFgB4WPpNQ+7
         9ZpoG6j6Nl0G0V+qF25hkVDJI7Zl0xCcMXUVzYhtk3xXf7dS1I6jdR2rD+nMhpxhDmZb
         7lPe8+5P7O7bYjzGinX5vHJw+eUJ7fbkInhVzn64wUAd/r5NTOACXPkf1UaQOaLr0hHb
         VcAXscLFCDizLxe+QLM5B7crUILPKesFR+k6itwXzNYDhP4a+SqsV1h1owxvzM6rYCh8
         0+szp388bvLMucZ53oAtCQeSuCyAVm8fxjOqhO4JyEPgRhz+Ta1dJ8pFuF4b0kOc1xje
         k90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aoU68YPWBq5ULKjjIS0MY2JHK9EjJmHwFgVyaZnB0qo=;
        b=hXRjaHb56NX4LobCf1qcykifzZIPn6JZcTEWU+PescQabFSPRXEIHr7/OPAVVziSh/
         12gM7oomJFEWXQ40MdDculKm+BT379bTTXFLLgIKt7zq6L+5n29JGWD7UktAef/lnGjI
         m1xB2G9gZJXDZm7Q1vdiJiM3CHWkqxDujodelGYA0h2YIIgT1rVggcZfHOzYh+wqaDh5
         0gCwGTzKXiIdHqCi+3vqZ2gnlFdnlQPqr2pWqyY4/jtW88fIB7GOM9XXXDtKj+FZMHek
         waBVOaGdkFU4lDbFyeh3ld49+oNMCV4yPcesqzNhBDQAIJmKFkr72nP9XydLfSTJLuca
         Epiw==
X-Gm-Message-State: APzg51DnGaBMOO+2k+CZFbB3+ef/by0FMlY/Ex9Ks8Qa0KouCd5VVAKd
        lRmBVT3k1G7juA+urGTSka8=
X-Google-Smtp-Source: ANB0VdZeGR0HPbGHkXTLsGmr+u1mJW1h6nbdoHkjCP+u+TmwpnOcrxMWF4OFo667neuqZJUZm8jnyA==
X-Received: by 2002:a19:d8e8:: with SMTP id r101-v6mr27354530lfi.37.1537476360320;
        Thu, 20 Sep 2018 13:46:00 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id r23-v6sm4470355ljc.15.2018.09.20.13.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:45:59 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [[PATCH v3] 6/6] [media] ad5820: DT new compatible devices
Date:   Thu, 20 Sep 2018 22:45:40 +0200
Message-Id: <20180920204540.28832-6-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920204540.28832-1-ricardo.ribalda@gmail.com>
References: <20180920204540.28832-1-ricardo.ribalda@gmail.com>
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

