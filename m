Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A6CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6F620840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DgTDQ2Y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbfAPUPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:15:14 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45911 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732397AbfAPUPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:15:11 -0500
Received: by mail-yw1-f67.google.com with SMTP id d190so2913218ywd.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 12:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ffaxKx8sodfXLl/Ae5Fx/GunKh8JaBz2jFEkjCzH1IA=;
        b=DgTDQ2Y0IsxBDo5xlkskqj1A2nFOd9YLpXJzXlBQKltATqy6Tcf5qO8TSAjRfE+p7Y
         Jf2bTIjO7U9Pjej1nGrTyRhKWM7YxTXVwWAl9rT7AobVB5z0yxgnYzLtGB/Ck2/e9w6B
         EiWqCBb6tq5W9IFz/HbwyfOBHOkmkQZRW6Aq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ffaxKx8sodfXLl/Ae5Fx/GunKh8JaBz2jFEkjCzH1IA=;
        b=GL3KtB/tXLtKzZiaDYbwem9oNRPReXM7yPPPVDfB1yxcoftOMBChvWo22F33jmri+D
         fALq2WFG7ygVBeq2FV67Eu097bBb4ArEG6C8s8NxHOeFE5PWGfQGm7mCQPGvVWHO1lAQ
         MS7sBKb2J9RWr9w5hd1xHWjHq6YWD4R/tXWZxItCsMG48ZkcQKo4f+uBmOghr7KMjDzJ
         Dwz+nnRNBTA7zKpQJ7nldct70m/Qte5NWBrhcdkc9Hzt5qfcYqMI8Cw8fB6MJpWCrv4L
         zDryj0g9RZiqik8sp908xA9hF7QCgF6xL6rmp3ZIH+sJYh8Zzhq1Dic61TLSFC/df0Nl
         J1DQ==
X-Gm-Message-State: AJcUukeWbgcOzGrq+7gvHbFfRkKD2wT04gUdWOOJNXA3wNqXFVJI0vEK
        V0xki1up85NVNLqPOpoGVxprkQ==
X-Google-Smtp-Source: ALg8bN7vBkQr02Su0vaWXmLOZSm1JT1r23yhisXUBqeoJFY5Xs7r71YBS9BQPKq3yH6tnoZXPBLLgQ==
X-Received: by 2002:a0d:e0c5:: with SMTP id j188mr9769018ywe.164.1547669710159;
        Wed, 16 Jan 2019 12:15:10 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w63sm2541026ywc.46.2019.01.16.12.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 12:15:09 -0800 (PST)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Praveen Kumar B <praveen.b@broadcom.com>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH V2 4/4] ARM: dts: cygnus: Change pwm compatible to new version
Date:   Thu, 17 Jan 2019 01:45:16 +0530
Message-Id: <1547669716-20070-5-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Praveen Kumar B <praveen.b@broadcom.com>

Change pwm compatible to new version pwm-cygnus
Add new compatible to check pwm configure status

Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 253df71..0a0ec5b 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -595,7 +595,7 @@
 		};
 
 		pwm: pwm@180aa500 {
-			compatible = "brcm,kona-pwm";
+			compatible = "brcm,cygnus-pwm";
 			reg = <0x180aa500 0xc4>;
 			#pwm-cells = <3>;
 			clocks = <&asiu_clks BCM_CYGNUS_ASIU_PWM_CLK>;
-- 
1.9.1

