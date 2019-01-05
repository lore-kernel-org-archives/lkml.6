Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE46C43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C773222F5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh+xa6lA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfAEU1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:27:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44731 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfAEU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:27:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so18927520pgr.11;
        Sat, 05 Jan 2019 12:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ITJnq0jkMqFZWzphLPumG2g4Zi5EIDeMIWXIqCmZHM=;
        b=Qh+xa6lA/U1LALY5xqfWMdX0Rtu0Xj3mJUUkZe846WybJJWGTmEhoCfooF24HmWsbZ
         rZVttGT4+CYqeYPWpeXgM8xzmx/nfHxp6lbf8OMM8UhgjWavje0WYq59CBSRsA6ghtQQ
         i/9mb1bczngRR2+qhToaO7loHZYfEN7QR4955vXJclXla2cMUjFvX7W8ZUgBUKxNus/D
         eC6P7xuBzJYfr2DgX3Ml0cJFzGNfzKL/qivKFvubezcveNFE2xtb2dlqZAIaYw0ezSfS
         ncNeb9ZC2g4FhMTH+aAA1dmj+X1IOE8m076X0KvLDyIOYbteAPrO0hslmoFw3tOUVoCS
         iGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ITJnq0jkMqFZWzphLPumG2g4Zi5EIDeMIWXIqCmZHM=;
        b=mntFRyZ11XzQsXaqJJ5MbA34BGYKv0yEzOwxjMzDZaMpoZK3nbs64SHPkOHOLz8pyd
         TEGJHkXdbWp8uogdeP7nWFWJ/pMEQyR9Hv/hZjMcSI8ZtL+ndNmZENE5Z4Qe79OpXzP1
         c28GI3Jn7rtTerulSF/bLYx7FsyboDOcmXpjLkrPp8cUYoS/2Sg63Yf5ADH6QSqyDTSm
         cmhzSMWUY25m5qozXL48umUgYc1uBBg0wfcBOKb026NeA1sI5IvnTKE7bv7rDuOkGMoB
         CBlt3cV/HEJkv7kg5yyiP36f9cniKfPUJQoR7EPyYn7nzC3pFcwJSFNdzRUABs258n4L
         X2ZA==
X-Gm-Message-State: AJcUukfuC2Eji9YALtWGVWlUJwQPWtYp3VqTpLXv2xA5uox+qqU2wnap
        AIcIE2TjChGzN3x2BPWUZrX2kVgW
X-Google-Smtp-Source: ALg8bN6coslDhJgecI9PHDfjqCfMs/yeDkJJQe0bGt9ZEzuqpw1rukbxt1oC6RJ0MBXfIcw07O7Kxg==
X-Received: by 2002:a63:a064:: with SMTP id u36mr5884470pgn.145.1546720029304;
        Sat, 05 Jan 2019 12:27:09 -0800 (PST)
Received: from localhost.localdomain ([121.161.238.230])
        by smtp.gmail.com with ESMTPSA id d129sm94559165pfc.31.2019.01.05.12.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 12:27:08 -0800 (PST)
From:   Donghoon Han <nazgul33@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: rotaty-encoder - Add DT binding document
Date:   Sun,  6 Jan 2019 05:26:59 +0900
Message-Id: <20190105202659.20198-3-nazgul33@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105202659.20198-1-nazgul33@gmail.com>
References: <20190105202659.20198-1-nazgul33@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding document for rotary-encoder, keycode options.

Signed-off-by: Donghoon Han <nazgul33@gmail.com>
---
 .../devicetree/bindings/input/rotary-encoder.txt     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index f99fe5cdeaec..113640079de3 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -12,6 +12,10 @@ Optional properties:
 - rotary-encoder,relative-axis: register a relative axis rather than an
   absolute one. Relative axis will only generate +1/-1 events on the input
   device, hence no steps need to be passed.
+- rotary-encoder,relative-keys : generate pair of key events. This setting
+  behaves just like relative-axis, generating key events. keycode[2]
+  corresponds -1/1 events.
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

