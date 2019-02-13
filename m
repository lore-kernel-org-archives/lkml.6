Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0067DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C348D222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fitHZwNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbfBME0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 23:26:12 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36212 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfBME0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 23:26:12 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so1821547otk.3;
        Tue, 12 Feb 2019 20:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sd5Ml0besxYMG4NkLF0fkNk0tH0yX+PUzLjCoBwLSJo=;
        b=fitHZwNjBXnqfYHVIgOBoCsG5KP3gzis3h+VVLdEZWYK3zEwKG06TvZtlFmJo9mk/8
         Rk7BjgyZsPFpn7DAAgilkl/4GghSc5UP9TjWxMf/riwSPZE8YHQZz2wPOcni0yl+ob9q
         UckGC+ZrVbmF1VpzoafWNJc8LOrzEVZYP/UW0rIy5vPnu1wXkBJWaOpEsazoIZZs4frf
         k0gL6kXv52Tw2YpGsqh2PQY5X3k5MEq23e1njEFwcuvhPZRqnuA9LWJnAnEqRS14uEDH
         VOVN9K8bzt5jG4YbylxKPmUGQUJaDHgGELd5C/lMHlxg1U+gLNcBvnE4RSgH0RjUJHwq
         ekCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sd5Ml0besxYMG4NkLF0fkNk0tH0yX+PUzLjCoBwLSJo=;
        b=tp1BiB+Npggcxc6s9dRojlCMdWGQeceBzPAeSJev0K/7hWOKnIEs8MAGcrUuOQY3jo
         zP8d101qosg4m6cOIR4qE2Vi0drrap07cJhx1IhgKF30Qlbahlz9obBi/+hgMyhBUzGK
         zhDSv1wDuJ5Wk2h7gPokYYel+/EsmbQnnAgYuXZ4nslI1aIeCLlPToPz9UiSs5eu63+5
         PEolGN+P4zj6K5zG6+jLEhD11OJm75fBh92cytAhf8notTT6w1H/7Xu/cePk+3v1UANX
         0l1iYfEw95IEGvoz7yhHZP5CtCqfF1dJR86NkLGDfa4LAooPKz3ohGMPgRUXj8QJlrsS
         m5ZA==
X-Gm-Message-State: AHQUAub+49akMlnyNHL0HNzT6im1cDxxVnA0ikr5nstn7R/A1ShBxmab
        ZnX/t6zGF0uDWfheDsY2dxw=
X-Google-Smtp-Source: AHgI3IYUMerUKeJf7klbBxZ9mlo5bjz3DbQFIK30ipqXQFVV2SPbWAUnBXYy5RIqVC5bvi7hP+noxQ==
X-Received: by 2002:a9d:7141:: with SMTP id y1mr6825013otj.177.1550031971225;
        Tue, 12 Feb 2019 20:26:11 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id a12sm6470650otl.39.2019.02.12.20.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 20:26:10 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM5301X ARM
        ARCHITECTURE), Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: BCM5301X: Change Ethernet switch management port
Date:   Tue, 12 Feb 2019 20:25:59 -0800
Message-Id: <20190213042600.27729-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM5301X has 3 Ethernet controllers: GMAC0, 1, 2 which map to ports 5, 7
and 8 respectively of the internal switch. Future changes will turn on
management mode in the Ethernet switch driver (b53) which will require
us to use port 8.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index 3fced3b7f1a8..affa9cc7422d 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -150,10 +150,15 @@
 			label = "wan";
 		};
 
-		port@5 {
-			reg = <5>;
+		port@8 {
+			reg = <8>;
 			label = "cpu";
-			ethernet = <&gmac0>;
+			ethernet = <&gmac2>;
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
 		};
 	};
 };
-- 
2.19.1

