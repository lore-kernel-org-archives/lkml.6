Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59F1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8719D20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QznddbBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfAKFVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:21:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33186 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfAKFVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:21:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so6418486pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 21:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OwRCj7PjZaXnprtMq6QV2wVOFtmvXlT2/KrfJ+jAcLc=;
        b=QznddbBrgj2tnWMvLRkfILQ3Z/rJLwyOYSkheShqUsZGPsNf5Hq7pmFfdzaysZD+4y
         RrWaMNMwVlIVgdkcLTQo7pUJZ7Rj6CUFe2Ecf4Y7mWE6xkGK1U5NANtoxjmwk8/AsOXa
         yJfWA2J4/YDw6EsBo4qeqWNNio6PKcE0StAj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OwRCj7PjZaXnprtMq6QV2wVOFtmvXlT2/KrfJ+jAcLc=;
        b=TDx7XtH+38m5Tr16dhX/R+l6ycoKkBGNW5R+/ozegpofNT0oW/Ja4ZF5wNYbIl3d3I
         rK7Ixj31bGt2HNht11DT6/2vdiUefk4CDVhtx7DHhO6RPv4Np4Q0KFYMcJYWztVMWR3K
         w9x4DMX+W0NXk2GBcnSpaiv3jZjmAIvu42aIqMIppG2Bbpx7UB3Wm9YMOkz5osOdHxQr
         LM+fVro4dw04StThk/4VjMMucHSb97jfjgLAiini74CsP5UQVjXNR/CBQToyYPLwAm/7
         waPCGTUu/TbfWfF4y25fgTus7TI23VlVzZFuukT1Sbb9ePbiFwfYo6BXGZZsa+N38EmG
         PGRw==
X-Gm-Message-State: AJcUukcFH+FiGpVXrkZBTsPDCceFHbc0ZMdjYqxxuRasB/qYM3vCoMDN
        pXWA2EbkWyzlCIbqSV7dGwYwxg==
X-Google-Smtp-Source: ALg8bN77KebShN+aQwtyujxJ50Qw5574a7UnuGOyfElJju3nFY377rZoh0Obnu9ahLPuF0luY/Tstg==
X-Received: by 2002:a65:6542:: with SMTP id a2mr11969178pgw.389.1547184096264;
        Thu, 10 Jan 2019 21:21:36 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 186sm148425418pga.36.2019.01.10.21.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 21:21:35 -0800 (PST)
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
Subject: [PATCH 3/3] ARM: dts: cygnus: Change pwm compatible to new version
Date:   Fri, 11 Jan 2019 10:51:16 +0530
Message-Id: <1547184076-20521-4-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
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

