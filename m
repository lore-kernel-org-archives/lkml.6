Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80971C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C412217F5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFDlZdx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfAEDGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 22:06:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37260 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfAEDGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 22:06:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so18248322pgb.4;
        Fri, 04 Jan 2019 19:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wop6KpWlwvxvZAv7XAUU5J2ClAasEuR4THaU6YiR25E=;
        b=HFDlZdx/6Q2Vdv839xRQ83Aud6nia6Pna9ashOKFFicjg5XIj9iba8c6rehBKV2xH5
         iqsJZmWT5nZ2A6iQ5W+agRBYAJ3DvVPbzp1qv2lFnxACeOqJhIWKoLAx/jvFYOInWvXU
         Xg1RoBo6ewOijZdmeEFnkJ97GA8EIcmwCBI48Yoil0dCPZYZNwFt/Ygh/7Tn4y1FzfYN
         h/5ULhQRryu2vhrBXkZN/vHuoCqYJqkVyxngJWYFWCS+/p3Lk1V9av+8XGMTdmySPX8K
         WGNVVKonLIS1Mcx6jKAmXI3wrA/jTK2sKZSYD9DJdtmToX3Mbh9KOOfOmOmPIkRBiS5W
         ZD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wop6KpWlwvxvZAv7XAUU5J2ClAasEuR4THaU6YiR25E=;
        b=WRzi/hFCmsnwdJipf8YWl4h1t5k2PyFvLinBnMJrtjm+L+BA7DIHKKPAHrYteOgC2i
         Ojxy+oRxOA68pQzFSO8iJpPKm0+T7vyz+c6JdQmY/5sKoEpc0QcS+gPeFlASqbskt5y1
         F4iDDzFRhhnC+emsMntiHZGx2CESOE3QJTDhc6+cgL8W429bza3r3wnc/5u+tGN8wWui
         HtOzCan7OuXJl2U7H7a5s51K3aKunRs93O1rk/NuZsMNJ4gP39khntNMkeIcbvSFPfhw
         5ZHxRLDvR/9A3bUIo3Kdym0cGPU3KudK1R/Yt2fnGVNS5iIrHKcZ0BPtWALwlL0XwCNR
         1y6w==
X-Gm-Message-State: AJcUukfJ1aBgLRR+8ZH1iNjd9iYTscM+tj7w6IvIsXWn1TYq0g8lpDPO
        KJouLgBGajEO04OtwgzIj0Yz6/pE
X-Google-Smtp-Source: ALg8bN5n44R1LLegwn/fiUrUZNL2QrovsU+SF07if9ZXadiXsea2DvQp2G2PWp2pNwFuj/P+jXRPJw==
X-Received: by 2002:a63:ea15:: with SMTP id c21mr48300416pgi.361.1546657602529;
        Fri, 04 Jan 2019 19:06:42 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id h82sm102885099pfa.105.2019.01.04.19.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 19:06:42 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: hwmon: ina3221: Add ti,single-shot property
Date:   Fri,  4 Jan 2019 19:06:35 -0800
Message-Id: <20190105030636.533-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105030636.533-1-nicoleotsuka@gmail.com>
References: <20190105030636.533-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, ina3221, as a hardware monitor, continuously measures
the inputs and generates corresponding data. However, for battery
powered devices, this mode might be power consuming.

This patch adds a "ti,single-shot" property to allow changing the
default continuous mode to single-shot operating mode.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/ina3221.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
index a7b25caa2b8e..fa63b6171407 100644
--- a/Documentation/devicetree/bindings/hwmon/ina3221.txt
+++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
@@ -6,6 +6,16 @@ Texas Instruments INA3221 Device Tree Bindings
   - reg: I2C address
 
   Optional properties:
+  - ti,single-shot: This chip has two power modes: single-shot (chip takes one
+                    measurement and then shuts itself down) and continuous (
+                    chip takes continuous measurements). The continuous mode is
+                    more reliable and suitable for hardware monitor type device,
+                    but the single-shot mode is more power-friendly and useful
+                    for battery-powered device which cares power consumptions
+                    while still needs some measurements occasionally.
+                    If this property is present, the single-shot mode will be
+                    used, instead of the default continuous one for monitoring.
+
   = The node contains optional child nodes for three channels =
   = Each child node describes the information of input source =
 
-- 
2.17.1

