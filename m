Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925FCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B1520874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YbI3wrvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbfAKFH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:07:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38916 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbfAKFHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:07:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so6379720pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 21:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OwRCj7PjZaXnprtMq6QV2wVOFtmvXlT2/KrfJ+jAcLc=;
        b=YbI3wrvLQlSuWKzGwcmrPMq10BLR53H4wxvnakPX7SQwU5HynxVsjGZLrCXMFIFj2x
         58k7ckLKu03eDgblFwVjoFDjwOPilyx/eCtUbQtCihPvHo6vn6DKbmZ4t8Aouyns1RmJ
         t7aPVpar4xkh27FabgEw607ccngXv9ub2bFQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OwRCj7PjZaXnprtMq6QV2wVOFtmvXlT2/KrfJ+jAcLc=;
        b=HGnddNL9JAmyNzxiy8NrrXdf4p+GheyiPo/pLugnoY66K0u//0o4N0Fwc1KMvYQmrO
         TsrgPu6bms65gF3IwxLuXSrLtsi14cjEO9wfpFubvUJNze9NuLkDY/n8vvM08ydtrUOG
         VK+eMSRfk7V9272P0P0cbdYBW90J60tP1bkOtFa4iOXBFEekWZT1JOIbJt55aqEruWqv
         bn07qnmaueV9A/ZYXG77fRhrrhlnNhdgGZqJVpkfrLvWW5QvozFNeYOjKOzQ/zLjsvle
         ZqDQEqac52KIDyuxf3bpfzVweKN1s8V2qW6nU8lZOqD/BgGingFuSKqTNWabLNLZo2Uh
         d/GQ==
X-Gm-Message-State: AJcUukfDjwGpPrppyD/wOq/kIOGU3/I+u/nbGn08gqsz/przOnMU5qg3
        QVFshgsumvRcOttzVh1K+jYrVg==
X-Google-Smtp-Source: ALg8bN4TUjGB9NckJx6746/Yf8+tklNsDUzA144cpS08G0WVS6MwRqSqItBq9OTXaCLoCaOdAmfzhQ==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr12155983pgc.165.1547183274445;
        Thu, 10 Jan 2019 21:07:54 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d6sm107520893pgc.89.2019.01.10.21.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 21:07:53 -0800 (PST)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Praveen Kumar B <praveen.b@broadcom.com>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH INTERNAL V3 3/3] ARM: dts: cygnus: Change pwm compatible to new version
Date:   Fri, 11 Jan 2019 10:38:04 +0530
Message-Id: <1547183284-19956-4-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Praveen Kumar B <praveen.b@broadcom.com>

Change pwm compatible to new version of pwm-kona
Add new compatible to check pwm configure status

Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 253df71..2a433e7 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -595,7 +595,7 @@
 		};
 
 		pwm: pwm@180aa500 {
-			compatible = "brcm,kona-pwm";
+			compatible = "brcm,kona-pwm-v2";
 			reg = <0x180aa500 0xc4>;
 			#pwm-cells = <3>;
 			clocks = <&asiu_clks BCM_CYGNUS_ASIU_PWM_CLK>;
-- 
1.9.1

