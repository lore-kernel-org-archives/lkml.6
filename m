Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03283C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57DF2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is3j/ums"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57DF2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeH3XFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:05:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50975 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbeH3XFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so2999271wmc.0;
        Thu, 30 Aug 2018 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fVq+dyrEA8MCEaUSG6+R2JFZagictW0kEMK0uBAAtGE=;
        b=Is3j/umswbTely8NDeJXc6Ld/wz3HS6kpUDJMjL5/S6IgkLNI25iAb45sJojElciI8
         1WdteNhHdUipNPzgpvijNRX40X+ooAhYRxfRKKxLFLyd8JwvqA1XZ2oNb7uZdVY+1xXI
         i4vX6TWqMbi1dGAh7xY8ttM+ZK+JzQ7VjFkbdpyki4PLUZHbBP4eChr6irZkg4kW+vFK
         3HAl3LXdHxEYtfq7ToE17kDSdvkTtltuBxEmIJdCRvtJiEzLdZvCmxzkErDAI8byCW8t
         Kg7ChUAfILeMdZN/Axr8QgiP2EHi9IxrBvWK7YRl/n8DpB5WsLVQmHKGPp2/olT7n2he
         2LOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fVq+dyrEA8MCEaUSG6+R2JFZagictW0kEMK0uBAAtGE=;
        b=AvbQzOBIT2Ez3hHBPAH0T2SapfJx6mqfCbTPmNcNs8XrrRPMmwsuNw4s1SwRsPS3Yp
         WWh6eZwxzIZ5wUbTOxEM6jFKO0lw5/QJhlXAbHDcEGZMcyY1N7ld8uYkFIEWr9W8kYVo
         eYdAfdiURR9nP7wyCmEtoGeDmriazZ2jIulRv98brrS9gl/L7UYKYK+s+/FVtBNfN2JT
         e7nVb7fFRRAbCmWpsCV+GrYIilM4o1qqlMBf8KkwLh+GMeKBIJNceqHa2oUAygcguinY
         eqUz/pze/9rjlgfDlqmcjEFCpxdBKmH8JnXwtv1MoF/9s9A33esGFuI35MAYTqrBN2QN
         9fgw==
X-Gm-Message-State: APzg51Cmk38fBuUKGHfqQOcDuDeYOf3S6HRl25gxegysmjovsjoeinW4
        Bx0u8JGMfEs45RPBoVFDSDM=
X-Google-Smtp-Source: ANB0Vdbq2eOt//DRVHk9YbeHWig/yUK59pYYUnP6O+3/hkUVTHq3d2XAdxyIKgnA3JARSkZHuV3sAw==
X-Received: by 2002:a1c:c7c3:: with SMTP id x186-v6mr2653722wmf.109.1535655704028;
        Thu, 30 Aug 2018 12:01:44 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:43 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 10/13] ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI
Date:   Thu, 30 Aug 2018 21:01:17 +0200
Message-Id: <20180830190120.722-11-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable the AHCI controller.
Since this controller need two regulator, this patch add them.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index a891a387e8f1..b991b635c07d 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -105,6 +105,11 @@
 	};
 };
 
+&ahci {
+	ahci-supply = <&reg_dldo4>;
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
@@ -250,6 +255,22 @@
 	regulator-name = "vcc-wifi";
 };
 
+&reg_dldo4 {
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	regulator-name = "vdd2v5-sata";
+};
+
+&reg_eldo3 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vdd1v2-sata";
+};
+
+&sata_phy {
+	phy-supply = <&reg_eldo3>;
+};
+
 &tcon_tv0 {
 	status = "okay";
 };
-- 
2.16.4

