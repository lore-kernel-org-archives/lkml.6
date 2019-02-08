Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA221C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E48320818
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouTXEYES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfBHExK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:53:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38908 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfBHExK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:53:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so1107383plb.5;
        Thu, 07 Feb 2019 20:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rpzmCrCCRh5H8Rk3RCk4uWnUOxgX8YuCWRGT7Fo1MN8=;
        b=ouTXEYESrT8iocW9YTsJdLSH7ih8t2u+K5VjvW2kM8GuLrzG3cXnHTKa2RdqiPK+kQ
         K1ahCeUruvEMhc57+Oa1i0/HO9Nlju5c9dPyDb30i949gpzRh+P3+3Bv5lijCi9Owhi4
         AoxiePscvGZlRyxWjsBzplc7+8eHKX+kQ2jrbbQCJfTWEX7SXx/UsuM4R1/lldXf+WN0
         MftwCAhXPtFXzAMmGwIgUJ6iIjT43tM18ltaO3Ver5nriry3WNWfVcpT3SlPa6FEOPRT
         YNdIyKwkL8hfrunDV3DfFedMfGZJb16Jji2+Dqs1hIRfC+CUg2Jv4RApy49gn+Pwqdb0
         OMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rpzmCrCCRh5H8Rk3RCk4uWnUOxgX8YuCWRGT7Fo1MN8=;
        b=qXgvkEbsNXNP85xFIVGgsO7X+oSY0NcJXWYadwSPYlZPkMDrZKW2z+F5KJZf61FLck
         feQrM5vp+X4qL6Rv7iFk+VMBTKQgacCe5NydvezPpBIMauQW6lD2JawVMbI/k+jUYCQR
         X31C/LJcFSesLkVIxmBw90DH1hFmlPCu989Ckp69n+kHNa5dekZCkwo0NAxqvFjbtOZe
         HLMf47X1+OBCHHf0507S69Oea4HUAxPwezZ4bqC4hlYxNH/qkAgauueDxH4GqI17z/IP
         m1OrPoH3oSQsqsTjB40iZUms95nbi8gVvLdA3FnYNzAG3YENqFPJf4QjjqaomCx0brNl
         jXHQ==
X-Gm-Message-State: AHQUAuagJcKdFakQDYaud6BDhwe1gAMdOtd5S6+53xrHtbKRO6aVb3Fa
        A4+/GFDi4Y134YtWNtfZL698MByGzQ6MrQ==
X-Google-Smtp-Source: AHgI3Iaoy/gFVd3rejGUTvwmTw58VVf0/asXZhRvF9pT3az/2chaNMNcONgvA6vVDjrtrd8N5bugKg==
X-Received: by 2002:a17:902:8ec9:: with SMTP id x9mr20871832plo.27.1549601588862;
        Thu, 07 Feb 2019 20:53:08 -0800 (PST)
Received: from kria.dcoles.net.com ([2600:3c01::f03c:91ff:fe93:faaa])
        by smtp.gmail.com with ESMTPSA id j21sm986212pfn.175.2019.02.07.20.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 20:53:08 -0800 (PST)
From:   David Coles <coles.david@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Coles <coles.david@gmail.com>
Subject: [PATCH] ARM: dts: add description of Netgear RN NV+v2 LCD
Date:   Thu,  7 Feb 2019 20:53:05 -0800
Message-Id: <20190208045305.8759-1-coles.david@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO pin mapping taken from NetGear NV+ v2 5.3.13 kernel sources[1]
(see arch/arm/plat-feroceon/mv_hal/rtc/ext_rtc/usiLCD.c).

1. https://www.downloads.netgear.com/files/GPL/RND_5.3.13_WW.src.zip

Signed-off-by: David Coles <coles.david@gmail.com>
---
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
index 8cc8550242ef..a61b56f44ec7 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
@@ -184,6 +184,20 @@
 		gpios = <&gpio0 30 GPIO_ACTIVE_LOW>;
 	};
 
+	auxdisplay {
+		compatible = "hit,hd44780";
+		data-gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>,
+			     <&gpio1 1 GPIO_ACTIVE_HIGH>,
+			     <&gpio1 3 GPIO_ACTIVE_HIGH>,
+			     <&gpio1 17 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+		rs-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		rw-gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
+		backlight-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+		display-height-chars = <2>;
+		display-width-chars = <16>;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.17.1

