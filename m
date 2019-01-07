Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5E7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D2D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO/XE8/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfAGQne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:43:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42528 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfAGQnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:43:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so392305plp.9;
        Mon, 07 Jan 2019 08:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iTXKezavfd1/8uh6u+UUWRqnfi0okDbl6ln27kN1WUE=;
        b=GO/XE8/nuZmHgZU7hFnddfFS//MJQrg3pyrilzu4JG/5INqvl7mkwiTLA/+yXclzSE
         nxj9aS+7OTeNi949+BQhEyMJufqxrjoeAt3Bq7bmbYTl7sGWNBoEZRH6Tlxw51Qt7j7t
         A+nO6HPIDRK5mpSqivE/o9sD/vTwR0LPNFwiKPVNcXsMiPOLu6Tz0bTr+KeEzh6dSU6Q
         +ar+S3F8fAARlJDL6ZVUe2oRvNynskbDHqInhyBAR2iL18JfXgNxB0/u/UKm4hvmQ0u6
         PSyj54/5nUSg7RijrPEyVYOAOn0iz6N/1Nr66eBuY+v6hGRTtkC/tx/akYHTrsH4f8Km
         agPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iTXKezavfd1/8uh6u+UUWRqnfi0okDbl6ln27kN1WUE=;
        b=J60MHk6W0aGi7/YTga3fIl3lW8owHeZ37k4Fx8swQ2d7od+SfWuvrfbVc8/T71ZQL/
         KuvzjdsR5+4QWB+eqCzjFjGWZ9q5cUo9Pa+vqnm0/22GQTWeC1HQEZLB1gZtAEIwpgyf
         5t+4Q2WOsmOy8lZ2p/PGQWIiIjFyDclCFnHAGBzYaYn83O3rrHLcToTZlQfuOFpjuWk2
         K9IXqdMo/3vNzLnDyoWGBWjtBNdFoq4RAwT3jqAH5dIImjVOxgBudAD55GQfuh1HYOpo
         xGZg5CzF9vAwy/4gW/MW7oVjb4FvwFt+92kFiWSOntuEeVF432xrVS+oNrxfq1loKcpT
         7hWA==
X-Gm-Message-State: AJcUukegCks/6iolDb9KmN1xoUCt+R8sDNQ/hpWzE7rWDGD3pqaGqh6A
        nuWNYgx+CAo2CR7hMMpJOizD9l8e
X-Google-Smtp-Source: ALg8bN6EJu6JUv3CwrN7tnCDHYXbg1g9cy5QKTNwJJLjSTGvFkUQ4+G0tL4nTl3DxV1daUzGP9AyDA==
X-Received: by 2002:a17:902:1d4a:: with SMTP id u10mr59444329plu.122.1546879412609;
        Mon, 07 Jan 2019 08:43:32 -0800 (PST)
Received: from localhost.localdomain ([121.161.238.230])
        by smtp.gmail.com with ESMTPSA id c72sm118865326pfb.107.2019.01.07.08.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:43:32 -0800 (PST)
From:   Donghoon Han <nazgul33@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH V2 2/2] Input: rotaty-encoder - Add DT binding document
Date:   Tue,  8 Jan 2019 01:42:49 +0900
Message-Id: <20190107164249.2342-3-nazgul33@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107164249.2342-1-nazgul33@gmail.com>
References: <20190107164249.2342-1-nazgul33@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding document for rotary-encoder, keycode options.

Signed-off-by: Donghoon Han <nazgul33@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>
Cc: devicetree@vger.kernel.org
To: linux-input@vger.kernel.org
---
 .../devicetree/bindings/input/rotary-encoder.txt     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index f99fe5cdeaec..9986ec2af2d4 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -12,6 +12,10 @@ Optional properties:
 - rotary-encoder,relative-axis: register a relative axis rather than an
   absolute one. Relative axis will only generate +1/-1 events on the input
   device, hence no steps need to be passed.
+- rotary-encoder,relative-keys : generate pair of key events. This setting
+  behaves just like relative-axis, generating key events instead.
+  (Keycodes[2] corresponds to -1/1 events.)
+- rotary-encoder,relative-keycodes : keycodes for relative-keys
 - rotary-encoder,rollover: Automatic rollover when the rotary value becomes
   greater than the specified steps or smaller than 0. For absolute axis only.
 - rotary-encoder,steps-per-period: Number of steps (stable states) per period.
@@ -48,3 +52,11 @@ Example:
 			rotary-encoder,encoding = "binary";
 			rotary-encoder,rollover;
 		};
+
+		rotary@2 {
+			compatible = "rotary-encoder";
+			gpios = <&gpio 21 0>, <&gpio 22 0>;
+			rotary-encoder,relative-keys;
+			rotary-encoder,relative-keycode = <103>, <108>;
+			rotary-encoder,steps-per-period = <2>;
+		};
-- 
2.17.1

