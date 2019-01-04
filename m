Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52084C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FF52184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfADBk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 20:40:56 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46427 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfADBkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 20:40:55 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so20750869qkf.13;
        Thu, 03 Jan 2019 17:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=LksFObJE0mBLcVa6R9U5mgdf0LK5awzANil+vII+HXM=;
        b=kwwbWSdIJkg68X942sN84LDnmcXW+2Vhuru5YzdvlaKUCV8dQlSMtnb9IUxBBNMc8a
         3smY8Njai3eUyA9g1bFsXzgfXa3AmU6lHncHEAECjBUuDOkMaPDZZPeka6O6qYmRO3FJ
         9ThbRXSjdhzVOZl6+x37jp6YmJLtTgYcGWTfOA+ybmeT3StAbs7++rXWZeKleb0xz/wO
         fQYmAjGwu5X3rZI8fWQz+hafjWxxKETMgl1Cw0XMerYuVYGNJHLFqi6GuidUpU/Ro5aZ
         GBmbxgE/e8mhooI3vTN9ubuHMXihPNCaIqZmjGUVJ1DtGwcW7xkQ0Sohvg2uHMapMExW
         vbVA==
X-Gm-Message-State: AJcUukeg4wIZ7LYjfrpQ8cTwMW6xWK8JYZrWaaOd1J3ge9vSs3tDgGNT
        O17GRg8ZkW/6uuuP7YvR5tM=
X-Google-Smtp-Source: ALg8bN7xcR468FeHnzVMB+JK0tGKz071m+pbAcx+a1Q/uo9unYcK672F3Vw5wL+RUldjnBzJbEu+hA==
X-Received: by 2002:a37:34f:: with SMTP id 76mr46283480qkd.347.1546566054011;
        Thu, 03 Jan 2019 17:40:54 -0800 (PST)
Received: from localhost.localdomain ([181.220.84.254])
        by smtp.gmail.com with ESMTPSA id k6sm45300385qkk.60.2019.01.03.17.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 17:40:53 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 03 Jan 2019 23:40:47 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Jason Zhu <jason.zhu@rock-chips.com>,
        Vicent Chi <vicent.chi@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/4] ARM: dts: rockchip: rv1108: Add spim0 and spim1 pinctrl groups
Date:   Thu,  3 Jan 2019 23:40:21 -0200
Message-Id: <20190104014023.17973-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104014023.17973-1-otavio@ossystems.com.br>
References: <20190104014023.17973-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pin settings for the SPI pins so they can be used across
multiple boards.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index cb26d9d98c34..f47ac86d2852 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -834,6 +834,42 @@
 			};
 		};
 
+		spim0 {
+			spim0_clk: spim0-clk {
+				rockchip,pins = <1 RK_PD0 RK_FUNC_2 &pcfg_pull_up>;
+			};
+
+			spim0_cs0: spim0-cs0 {
+				rockchip,pins = <1 RK_PD1 RK_FUNC_2 &pcfg_pull_up>;
+			};
+
+			spim0_tx: spim0-tx {
+				rockchip,pins = <1 RK_PD3 RK_FUNC_2 &pcfg_pull_up>;
+			};
+
+			spim0_rx: spim0-rx {
+				rockchip,pins = <1 RK_PD2 RK_FUNC_2 &pcfg_pull_up>;
+			};
+		};
+
+		spim1 {
+			spim1_clk: spim1-clk {
+				rockchip,pins = <0 RK_PA3 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			spim1_cs0: spim1-cs0 {
+				rockchip,pins = <0 RK_PA4 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			spim1_rx: spim1-rx {
+				rockchip,pins = <0 RK_PB0 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			spim1_tx: spim1-tx {
+				rockchip,pins = <0 RK_PA7 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
 		tsadc {
 			otp_out: otp-out {
 				rockchip,pins = <0 RK_PB7 RK_FUNC_1 &pcfg_pull_none>;
-- 
2.20.1

