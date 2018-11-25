Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78DDC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1022084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1022084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbeKZIMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:12:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34391 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZIMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:12:06 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so15492214qtp.1;
        Sun, 25 Nov 2018 13:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=nmDsCwmLl9glebqfbdHQbTbjn61d+ZdVRN7Yo+KoZyA=;
        b=iAjy5Ty1EEwO9OEcg4DpIppPsIKaShIaN6BSbn3e3x0+bE24hmJE1zMetEPRaU2bjF
         RjtB7kbVX0TMkC/SgePhdpM98oiy+RRuhtPjIE3EYe8Dxht3HMd2GNAIftL1ENxP26dL
         k1h/QzN7vYlgMb2ztBWxaoL4RzFcmlVatLwqWwNGGI+K57uBtTruGwR4elAgXFrRhAbN
         b+gRcZvH+whDNK8bRJvejY8zaPkx7Hurj/9AdLKuYAzYqK7GQo4tdIxo9pQcGffmPaqh
         3ox1fr+ClUoP1ZTMKOUDgERS/DyJCQm3dAZZlDcT2mhz/aXBrFSzMJgL9CT8nFaXoAyE
         YLTA==
X-Gm-Message-State: AA+aEWaI+/zHz7BmWdkdufcaKN8tmEQO3AGJ+kmnOmWfKlo3C5n1CFBo
        Qur3VDHylecB06tiVoU2qe5mh/0U
X-Google-Smtp-Source: AFSGD/XznogjlgsGgEQZb8x/jbClRWLqDhe9tcidG+VeB3lKjiakl0UsP6s5RGUlVUA3cpr9yRu6Vg==
X-Received: by 2002:a0c:f8c7:: with SMTP id h7mr23765681qvo.134.1543180806752;
        Sun, 25 Nov 2018 13:20:06 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id v186sm15358914qkd.13.2018.11.25.13.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:20:06 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:20:00 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Berton <fabio.berton@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 08/13] ARM: dts: rv1108: Fix the PMU interrupt number
Date:   Sun, 25 Nov 2018 19:19:02 -0200
Message-Id: <20181125211907.9895-8-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Rockchip vendor tree the PMU interrupt number is
76, so fix it accordingly.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 7b331766120d..442b749eb2e9 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -66,7 +66,7 @@
 
 	arm-pmu {
 		compatible = "arm,cortex-a7-pmu";
-		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	timer {
-- 
2.19.1

