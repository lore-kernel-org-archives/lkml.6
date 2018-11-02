Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF97CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677CF2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/X837ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677CF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeKCCUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:20:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34377 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKCCUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:20:06 -0400
Received: by mail-io1-f68.google.com with SMTP id d80-v6so1890178iof.1;
        Fri, 02 Nov 2018 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lg0RdFKFcY4Jp4ZL+q2U57zb3Gn7jrfWcv7D1W5oLho=;
        b=A/X837jasT0wnmAh5X8KnNwy/jz7QdPFAbbzFZRTewYjk1jBdkuauyaa58K50YGkfX
         FsSDBpR/ctXyG0Rg7Fb4F1hOIx/j+5S2xWJZAD5LyIs78fXmmK5+8yXaPOiXd/d7iqiP
         DVagz/U0aOcmlHQAbOQNEUYD2e69uNB/19kL9DX8Lu2TBx5hPQVx7In1Ho+PFC4LE/lr
         BJ/nKx9Gxp3D7RBVFvYEM2kkAo6sgOiWrslv9S2vEqtn2KUsGa7wWIUNFSjPs8yttjeT
         q2qiamTLx5cYDQOmn7CkEkQ60CNhf77ZpG+8/nbpP+dCN0/vqMpfNnRcn6nTINfQnImm
         u7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lg0RdFKFcY4Jp4ZL+q2U57zb3Gn7jrfWcv7D1W5oLho=;
        b=cYmsJKRqTj+qjV4xbuYSG++rzX05x749128ZcSZ++kS25e3s5rjznh9jkgi4bQz6tz
         2cv1rJKYRXnt1oeh841sa/XvJaYPLAaLstZSR96I7B4VX5y6CJj+7h/XyjS1ev5tyE12
         mRXPmrRTKfb7a9IB8Oym5i5C9UPK8L8g/sPT1ppt9SYEGHVvD9PfBr3/mDybqnSW3yEz
         sJQU5ELH0rEs9i5Z/O1YDfHrz9eOkuY26w60AYVQF5fmZEuEuasBcDVX+hGJxRZldpQn
         AcQ+l6UtKHaNrsEqjerEZ6N8FsZH1NRll+/ghCl9HKxkmeWSJvDefMHufJYnHJLl4x1x
         yEiA==
X-Gm-Message-State: AGRZ1gKhwP69/cTwhdDzeYvd2UN/sFbtfpyBUS/QUmIlAmYk+6ZkwnM+
        4440DeYdP+eqXoJzeuFI/e4=
X-Google-Smtp-Source: AJdET5dpK/5uDZAp8FvOV5JofVTs1SRRdMEc7/J3+1U5sGQr/M6+gyAS0boPqvh612oXx/+MLgJ5PQ==
X-Received: by 2002:a5e:8c19:: with SMTP id n25-v6mr10698567ioj.122.1541178735376;
        Fri, 02 Nov 2018 10:12:15 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id 64-v6sm13831164itm.29.2018.11.02.10.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 10:12:14 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, mark.rutland@arm.com,
        george.mccollister@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1] regulator: pfuze100-regulator: add coin support for pfuze100
Date:   Fri,  2 Nov 2018 13:12:08 -0400
Message-Id: <20181102171208.29658-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PF0100 coin cell/super capacitor charger which works as
a current limited voltage source via the LICELL pin. When VIN goes below
a certain threshold LICELL is used to provide power for VSNVS which is
usually used to hold up secure non-volatile storage and the real-time
clock on the SoC.

This extends a previous commit, where coin support was added for PF0200
only.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
References: c6182ac9609 ("regulator: pfuze100-regulator: add coin support")
---
 Documentation/devicetree/bindings/regulator/pfuze100.txt | 4 ++++
 drivers/regulator/pfuze100-regulator.c                   | 2 ++
 include/linux/regulator/pfuze100.h                       | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
index c7610718adff..a69f7626e650 100644
--- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.txt
@@ -127,6 +127,10 @@ Example 1: PFUZE100
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
+			coin_reg: coin {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3300000>;
+			};
 		};
 	};
 
diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 31c3a236120a..d8eb59fe3ab6 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -357,6 +357,7 @@ static struct pfuze_regulator pfuze100_regulators[] = {
 	PFUZE100_VGEN_REG(PFUZE100, VGEN4, PFUZE100_VGEN4VOL, 1800000, 3300000, 100000),
 	PFUZE100_VGEN_REG(PFUZE100, VGEN5, PFUZE100_VGEN5VOL, 1800000, 3300000, 100000),
 	PFUZE100_VGEN_REG(PFUZE100, VGEN6, PFUZE100_VGEN6VOL, 1800000, 3300000, 100000),
+	PFUZE100_COIN_REG(PFUZE100, COIN, PFUZE100_COINVOL, 0x7, pfuze100_coin),
 };
 
 static struct pfuze_regulator pfuze200_regulators[] = {
@@ -423,6 +424,7 @@ static struct of_regulator_match pfuze100_matches[] = {
 	{ .name = "vgen4",	},
 	{ .name = "vgen5",	},
 	{ .name = "vgen6",	},
+	{ .name = "coin",	},
 };
 
 /* PFUZE200 */
diff --git a/include/linux/regulator/pfuze100.h b/include/linux/regulator/pfuze100.h
index cb5aecd40f07..331d7d940c7a 100644
--- a/include/linux/regulator/pfuze100.h
+++ b/include/linux/regulator/pfuze100.h
@@ -33,7 +33,8 @@
 #define PFUZE100_VGEN4		12
 #define PFUZE100_VGEN5		13
 #define PFUZE100_VGEN6		14
-#define PFUZE100_MAX_REGULATOR	15
+#define PFUZE100_COIN		15
+#define PFUZE100_MAX_REGULATOR	16
 
 #define PFUZE200_SW1AB		0
 #define PFUZE200_SW2		1
-- 
2.17.1

