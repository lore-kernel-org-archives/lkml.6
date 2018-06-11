Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8DAF3C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AC22089C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBm4N5HK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AC22089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932598AbeFKWrj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 18:47:39 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39988 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754231AbeFKWrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 18:47:31 -0400
Received: by mail-qk0-f194.google.com with SMTP id r66-v6so13977322qkr.7;
        Mon, 11 Jun 2018 15:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nJcpS577kemnhYkonAfZpTjfH3tkSeWgyLyJguhfT/Y=;
        b=BBm4N5HKfDaEmXMnhU9REW9j2DzUbdqyNXrrUX6OU1QFwkvkC9mn7wX+NyxI6k+lSV
         UpdNUeFSwzc0usZE4a23uRuhoV8qS8N6L3fPEGHbDdzWBjStFxf0V0erK/bVxeAnZBb5
         FUllNG943QZ1pBntGY/qPXkPM87OvByQF27ocfNw6vuDqEihghVBLAoYi/pza6vYIgDp
         0xDhGNRwvUqAc5KcD+Ih6FOZkoYM/Y6M6xc2aEexhlcfujiHsRsf2zKKEU6SjRcf7QVr
         TGBrSUHqGQ7ZlXTgDbf02FYgOAtqXSBYEVKkp0N00LLD9x9FSUHZA5GRCGc3hsz8Ik5k
         ipDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nJcpS577kemnhYkonAfZpTjfH3tkSeWgyLyJguhfT/Y=;
        b=HEXrm/YfRzMpLG4G2eu5wNQcUS905Tu4FXAMN/G4tPeKPfbfbwDRM3N4xiLBpuxeIp
         0+uKIpMsrIn+RElJJWI6X88hLPwuccp/5Hv5fb1W9zS9xthB+QWp7Eh07axFvK27TJxr
         ZpqNeovd3hkEsE62jqnQLFlCA8Y+GHodypnYUJ418Bhtj1uQ6wWlF3PX9SFbSmHBlGUT
         vLbRIM/7fBAhKbW8Pwy/yAbG00KBKfGxnztWnWb59n+2p3nefScyQZKDZbOzZCnqHw7o
         aBLDtJGX8VWLoYKsHHub+EaN0wqsZkam+WAxjHvAc1pxe57vrojidRauZDjGm8SwIgKd
         1i8A==
X-Gm-Message-State: APt69E086mP/iKJrXXzI1+D+GqzoENrZo5YhhvX/qb7CzOx4d33yL0BB
        H3Vtprwe/EeinRxizDgk4QP/nd2Q
X-Google-Smtp-Source: ADUXVKKYQvK6uipo7lVa6OkfqrjELUzVZhrTBqtosNCkgcqyxv4JMKUsfJKMGC3T90T7qKeCrVd1Mg==
X-Received: by 2002:a37:4f85:: with SMTP id d127-v6mr1046781qkb.183.1528757250204;
        Mon, 11 Jun 2018 15:47:30 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i10-v6sm35645869qtf.20.2018.06.11.15.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 15:47:29 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] ARM: dts: NSP: Fix i2c controller interrupt type
Date:   Mon, 11 Jun 2018 15:47:12 -0700
Message-Id: <20180611224714.7007-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180611224714.7007-1-f.fainelli@gmail.com>
References: <20180611224714.7007-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c controller should use IRQ_TYPE_LEVEL_HIGH instead of
IRQ_TYPE_NONE.

Fixes: 0f9f27a36d09 ("ARM: dts: NSP: Add I2C support to the DT")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index dcc55aa84583..c6aa62386941 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -391,7 +391,7 @@
 			reg = <0x38000 0x50>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			dma-coherent;
 			status = "disabled";
-- 
2.14.1

