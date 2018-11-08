Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFF7ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07940206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGmvgUhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07940206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeKIFWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:22:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33040 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeKIFWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:22:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id o89so28718084qko.0;
        Thu, 08 Nov 2018 11:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y8GXMyTR7MZVo9+2nDy/iUhDA4xLhvp/vOq8kA8CSKM=;
        b=GGmvgUhqWOLHesO8JSfOiDqqkAeIbrbjvyEVBlZ2ConG8uT0yC5vG8qWY3ju3gw47Q
         B4q8JOF4tKFpNyRKj9HyzHqWKrHnBzoc9Uw2xDtwWhPCMg35YPOudGs2wzFkBWWy0gxb
         fNIzIPF0cpCQPpnrvh0dG6iWLoMHyhDlHUgMeAWIvmTKmU3op9N5MGJUzhGpYjt+60JH
         mPbLvdlxLh1RLnCqE0//r9uBQXaTi6Er1cSbqTWRH16JGz686zSNYBHIqDYJKXRb/Fo3
         B36Vnm2nO48/ReoWTO6qNCBM+iEEaj5rBep4qzgSSeNsSdEUmX9YoTASknJ3ppCHRdmz
         f1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y8GXMyTR7MZVo9+2nDy/iUhDA4xLhvp/vOq8kA8CSKM=;
        b=Qn+Py3O519wSa9LaOgPHawCGS7qn0HDMxl55PY4ZCh6nL5kjFrGwLswRfP75rA0n/Q
         GeYQI/AtCa67rctuQk8pR5T1d6aO9dvC8hSfXY8xk7rGK5EmHVEQ3al4MGAAXX95uvu8
         sYST5t5qEvH1i6otUuF00xXFT9X8O9+PHYud9580b1CF+ALzO42XVNQcJr6G76I35J11
         gRG69K8bwFoRyCYmgim0AJDZi7GswrHAXwxru7srhebqI92BaHW5kOCo2cXD8QVxqSmA
         Apb1VmJvVHCSr6yveoU3w10dLY15gIc1SK9+C1UYfCUk5TzBPZDppYgU2GrQ3xFii2XR
         Eyfw==
X-Gm-Message-State: AGRZ1gJdD4T5ysTebUyjUiJTpljhN+AfQjjyHAh/9GFSiWXSpghDdi6d
        aE7SIBWyuk+kKIFZ6FDZRTI=
X-Google-Smtp-Source: AJdET5cIA4U0nABJ5FbBpXWQpOHXQIvzDqFakBWXeuLSTYd9rrJT7QYvwAnz/xaCH1f+QJ0JKffzVw==
X-Received: by 2002:a0c:d0d7:: with SMTP id b23mr5853362qvh.67.1541706302682;
        Thu, 08 Nov 2018 11:45:02 -0800 (PST)
Received: from localhost.localdomain ([50.224.228.202])
        by smtp.gmail.com with ESMTPSA id w52sm3406414qtc.51.2018.11.08.11.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 11:45:02 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v3 2/3] dt-bindings: arm: amlogic: Add support for the Smartlabs SML-5442TW
Date:   Thu,  8 Nov 2018 23:43:52 +0400
Message-Id: <1541706240-30036-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541706240-30036-1-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-1-git-send-email-christianshewitt@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SML-5442TW is an STB for O2 Czech IPTV/VOD and DVB-S based on the
Amlogic P231 reference design using the S905D chipset. Specs:

2GB DDR3 RAM
8GB eMMC storage
10/100 Base-T Ethernet
802.11 a/b/g/n/ac + BT 4.1 HS sdio wireless module (QCA9377)
2x single colour and 1x dual colour LEDs on the front panel
1x reset button on the front panel
HDMI 2.0 (4k@60p) video
Composite video + 2-channel audio output on 3.5mm jack
S/PDIF audio output
Single DVB-S tuner (AVL6762/MxL608)
2x USB 2.0 ports
1x micro SD card slot
UART pins (internal)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 4498292..ad79f2d 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -91,6 +91,7 @@ Board compatible values (alphabetically, grouped by SoC):
 
   - "amlogic,p230" (Meson gxl s905d)
   - "amlogic,p231" (Meson gxl s905d)
+  - "smartlabs,sml5442tw" (Meson gxl s905d)
 
   - "amlogic,p241" (Meson gxl s805x)
 
-- 
2.7.4

