Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F842C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4C626AFE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIe5WvlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4C626AFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbeF1EZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:25:23 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44379 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753230AbeF1EYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:24:52 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so2103240pls.11;
        Wed, 27 Jun 2018 21:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/1/3gpX7m4CEJ9O8AomjJRI72OGjg+qD4//mIB9xrtw=;
        b=XIe5WvlBxtBtbO2lTIsqTWFmW3B3q3yD9WrDO+RLbDCBgXAJmvp56zMD/r0cpbahbE
         34vPUJjxlj7H9VH1lMcdp519cHrV9H+pSmEFRRc1AY1pMveYcqAJz20pKYHlWRjascv5
         aAt+aIvqpyEZqSXPq3HVivwXKzgazr49HF5Kh6gHlnfOjt21kYKBI+mnphPgMJQMNq+A
         3gFfYmrhh3Ms4UHt2G4ztL27yOLRbUjbL48n0qkEt0++pV/YRFlx8Mlvm2NWbhaqcTU2
         pnzbnzOZydyQ6wZ9dJTgxDirtBt0xgMVo3lxkiXWD8rMF6LFRRctze2OfVs9gz9pBurT
         RzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/1/3gpX7m4CEJ9O8AomjJRI72OGjg+qD4//mIB9xrtw=;
        b=cQsOzDgTpw5aqnNpJWeKbilhDCARXOiJS3ws6Snj4LjgnxttyGHncjAeqoC1hd/sK7
         l8wMidV/R31DYRCeoKNsv9xwkudHkjtlaKXCaE7zSzNw3rCEKlfuCXl7joah5Gz1uiwc
         LWdibISZOZYXAVhffxcD/yCIHvYogsYWnWNToJv+TrHQPwCYV6K4LGImx8SUKfRdRPo3
         HzGiku2xPHtdhDmG3PWyEyFa31H+R+TjfuURmSS+CUINn5/PNPVdpdVcvCIraavI5M4f
         nxTgEjJDWy4OnYWC7rakYE/Wr6BGkHhCAWQ72Kg3qB0nQjsxCLMzpio6GB9AQnw+/k+Z
         THNg==
X-Gm-Message-State: APt69E0r6TtcEutBS8WBxhvOxGQr/kd99K2DYUB0oNiGi5oukdov2GIY
        R+B3WIjGC/PMu1y6Hn+zWax8XN8h
X-Google-Smtp-Source: ADUXVKK1C7T+Ye0pgXe0K/VDj/gxCOA1pmjebCk58Bu3yDF7nBxmJJ0SAq1jN5S3cRWOnQHsTxBzBw==
X-Received: by 2002:a17:902:b946:: with SMTP id h6-v6mr8631889pls.1.1530159891725;
        Wed, 27 Jun 2018 21:24:51 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t19-v6sm12328577pfj.169.2018.06.27.21.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 21:24:50 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, cphealy@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP backlight node
Date:   Wed, 27 Jun 2018 21:24:23 -0700
Message-Id: <20180628042424.12664-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628042424.12664-1-andrew.smirnov@gmail.com>
References: <20180628042424.12664-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RAVE SP found on RDU2 implements backlight control compatible with the
rave-sp-backlight driver. Add a node to make it availible.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: cphealy@gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index e4630481d951..48da4b15da09 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -327,6 +327,10 @@
 			compatible = "zii,rave-sp-watchdog";
 		};
 
+		backlight {
+			compatible = "zii,rave-sp-backlight";
+		};
+
 		eeprom@a3 {
 			compatible = "zii,rave-sp-eeprom";
 			reg = <0xa3 0x4000>;
-- 
2.17.1

