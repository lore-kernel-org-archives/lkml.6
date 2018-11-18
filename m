Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710B1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CF62086A
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXSUS3jB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CF62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeKSAit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:38:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33128 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbeKSAis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:38:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id u9-v6so29297882wrr.0;
        Sun, 18 Nov 2018 06:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L7disfZwJpJaA7NqMC6kfvhVOWre7g7q0LUqHzEF3x8=;
        b=UXSUS3jBxNvlL0S4FRmzzLmqyOZszsDLcgxyS6OvpDUCx2nWiVH/phjaBNq+TK/Bf/
         S2XZEUleQ/N9tY2hTJoDRivYaWm1Fp9oXqnZ4tkGH4Nudr27cxSmwyNQjIrWPdzWB9Nu
         FdTxk3wQOUmgS/p5ERFStN83KEpkO4q/vGDgwz345gZIHcqHvU6H6HpVBcNwuY3w76mQ
         NzGZMwqGREoZz58cZLvAkgJzHLvV/n+Xim+EynxjPlE118263N2piEgh8LA7orTHKzN7
         QEXlJDTcHAavzAEQUQEqz6r0tr+2OxVQkN3bggZiOcnWx6IOpe3ohFQh/hgufBghfjYn
         BtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L7disfZwJpJaA7NqMC6kfvhVOWre7g7q0LUqHzEF3x8=;
        b=dmSMyGWwCqMntjnD3by1mdpt1PsS1n1nIpniKV7PH+zAbc3d1Nt9Gh6UaYRnI+NpJY
         /YRrvgeb7eduL4ue7/XFngI3O4+a9Sif7rwcUVs/5PQ7CxXFwCvG6ECHbk0hjLMvkGys
         9i2xH4wC7cqxt+87UL/7XqjRlKsg7t///1Zz4+MkLBY4SVuFa2m5MdVzq0BBYH7zh22x
         A31XBwh992t+kj3beqqHP89garh/9k8Wav5VDHmt7IuoFY01/umrhhgrleymp2h9FAi6
         nAGAVdPJ6sSANREty25VNsFGUXA7rws5B6NJLQ1boRUrH3PyzNQOWK2JRZB5Rdu1wyLH
         wWOA==
X-Gm-Message-State: AA+aEWYh1qKzHnTIs9ZxDRH7Fs3Teq06U66CR+htfJng9J5sY19S8VIw
        bstfYuAihatR1kOCx4AhT8+IeTKHgjQ=
X-Google-Smtp-Source: AFSGD/UhGiLAQxkG3pr2EU/1My2itONvpnPhsXAfhgYMOHH4hiUQ++NgKc8a9q5qoPSRsIUP1XhOvg==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr7744208wrw.132.1542550700822;
        Sun, 18 Nov 2018 06:18:20 -0800 (PST)
Received: from ThinkPad.home ([185.219.176.209])
        by smtp.gmail.com with ESMTPSA id d4sm29814412wrp.89.2018.11.18.06.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:18:20 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [RFC PATCH v2 02/14] dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
Date:   Sun, 18 Nov 2018 17:17:01 +0300
Message-Id: <5ef0af61c17ae1fd523f15673042f63461e57cff.1542546735.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new Allwinner ARMv5 F1C100s SoC's compatible string

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index e4beec3..12f1b00 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -3,6 +3,7 @@ Allwinner sunXi Platforms Device Tree Bindings
 Each device tree must specify which Allwinner SoC it uses,
 using one of the following compatible strings:
 
+  allwinner,suniv-f1c100s
   allwinner,sun4i-a10
   allwinner,sun5i-a10s
   allwinner,sun5i-a13
-- 
2.7.4

