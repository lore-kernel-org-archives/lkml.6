Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48DCECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0B520825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP6+xTTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0B520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeKIBKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:10:24 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35618 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeKIBKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:10:24 -0500
Received: by mail-qk1-f193.google.com with SMTP id w204so2154750qka.2;
        Thu, 08 Nov 2018 07:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y8GXMyTR7MZVo9+2nDy/iUhDA4xLhvp/vOq8kA8CSKM=;
        b=XP6+xTTbjX/LuWWd+HngIL0pkmaOx5esPTc7xvDl6QgaZTOUgeB4CNM5lzUauMcZC4
         S29TQmWeRvhUif+Lvy10tYZMue0oQdXppi4J9yQT8BCs3wr0MLByFtAP8HPOCRQjF25y
         75Kkt7xYG6B3N5gEo4A1C2nPd4vVaMZRSYxYlKA3te5BlRhlvY2EsxHFx7nkXjpav38Z
         PmgnuCrDD4IQk1RKJszSZiX5xlqjF6hmYkQIhI+i7Cgsx5n/gcNqy7BaWsAim8LMlfv8
         idoCEa912OV4bYGOnWIn/LtN8FuaAHWlWToMUjWAIVixxC/JMVapuQO/MkATwGMWByO8
         IU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y8GXMyTR7MZVo9+2nDy/iUhDA4xLhvp/vOq8kA8CSKM=;
        b=Cnyiy5mkAFlpsOpqGqSXCXBZP30Qde+bNbeHPCMzJWV8l0ahcej5Ykp/vS/IsRkOTW
         1krH17poII2c6/rHEfgRWT6oqkMymz0/dJHx6AkX6y1gQanoFti4nh04tABQuYE14fFe
         DeRjwfUvMOw4qYRb11k8lQk2/lwC9otSKSxAxqupZ1WnRLoTZM/uVPwi5AIyrAqP3cug
         3KLarm2hjBg6PrFRdvvTNl3Ee6mWI4aym+AQYhKDQGlHWLFF8DY80xHeCLSFyJ/kZLiq
         PTiI3XAR7x3n0KPWyTgdtpZmd4H+g/tca8T9l55fxfw+r9EbtK8rHWTjV/SpoLnzSrR1
         Y3lQ==
X-Gm-Message-State: AGRZ1gIiE8b533Mw5LBgkWibqxvhvxnPpH+oRs5zSMq/s1SuGf5jjVJ0
        W8g9YUOuEJ8TA8tt8FOWBxE=
X-Google-Smtp-Source: AJdET5dEkNkr/t5u1y6uwoch0knck/zXPq+ImVD8jA0VkE8oAdKQUQQxrTbXE/vgOaLThsTE5D1VbA==
X-Received: by 2002:a0c:9023:: with SMTP id o32mr4783619qvo.17.1541691261867;
        Thu, 08 Nov 2018 07:34:21 -0800 (PST)
Received: from localhost.localdomain ([50.224.228.202])
        by smtp.gmail.com with ESMTPSA id u90sm2407127qki.39.2018.11.08.07.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 07:34:21 -0800 (PST)
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
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 2/3] dt-bindings: arm: amlogic: Add support for the Smartlabs SML-5442TW
Date:   Thu,  8 Nov 2018 19:33:21 +0400
Message-Id: <1541691207-24768-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
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

