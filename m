Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E27CC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B741726C38
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCuJHHwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B741726C38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeF1Ehv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:37:51 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33590 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753302AbeF1Ehg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:37:36 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so1901686pgq.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 21:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JaiZxyujT9WUdKTx5/3xmJeAvPOF33obu2+Cq39dAUA=;
        b=CCuJHHwvsLAwSSUgIDjgHr2uZj81Lk7vgwmeCeYOtz+fdmOxYi8j6KgPKr2/C+G5Ta
         UXHS0eOm6aiHhIYHFhQVkVST8of9V/SHIHwYMy8TAZAClYZQ71seJbS14ZE2CI5hhHoD
         52flUf4mlJFIW7KjrPPbXN3loWC67QrutL2W2LLNA3+FaTprvDMVxMu3kZAZ1fu6cxx2
         MC6v322wL+L9uNDIdhE+DAvcV4OjiJsSj330CDMD+MHNEbirZdnlw/65T3L3YNrHw5OW
         BaYHpJeLYoAxzCmkq3On6MOrbE0/Gr2hWsdUOEmY5nIV92ujVB0O3zRY5zMUtFLHPcxI
         VesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JaiZxyujT9WUdKTx5/3xmJeAvPOF33obu2+Cq39dAUA=;
        b=Rys40Kccz1ObmJ+O/5/I067MaVXctURRR8GzUeTBQa+vst8dC9/+EDEQ7DG0/eAoDs
         WTMqEc3EaXLAxeKLa24DXFZCnA01k2sruls9vSQoltwNpe5/yewGBm/2XsVOLJETMcvr
         hL6vSbxvxDQ8hM8bIIsTjsA0tvcwbQxwQdnaqJ2eFWrmks+d3qOQdmQ3Elwmf5q5gGGW
         VsNmW6u6XiS+FG0H3lVCMciuiPFSeRKj0xAyhuIFhPMV2EnCrQzlK7iA9KG7ikCtsXuk
         rGBtU6ma29N0bU+p5u4VpC40Gpf8vldfT6LrCvKlyGMhoWQB2L6RSJjTkXC47mYF21yK
         yq7g==
X-Gm-Message-State: APt69E29MBuvN6Q99gKtC9PMuknN5gFEUI6fRLiQ4IO/2WU05vh/KkuS
        rjopVgwJ3OaB59WjKA7ijsw=
X-Google-Smtp-Source: AAOMgpfzR4zT8IwVT5/UnJZyC2WzT604G4QCrtSbdVzZkOjwhrgxfIG1KpiCCtfb1mlKTRpR+wTN0w==
X-Received: by 2002:a62:642:: with SMTP id 63-v6mr8677853pfg.222.1530160655718;
        Wed, 27 Jun 2018 21:37:35 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id j23-v6sm8366892pfh.45.2018.06.27.21.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 21:37:34 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: imx51-babbage: Make use of pinctrl_usbh1reg
Date:   Wed, 27 Jun 2018 21:37:13 -0700
Message-Id: <20180628043713.14425-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628043713.14425-1-andrew.smirnov@gmail.com>
References: <20180628043713.14425-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinctrl_usbh1reg defines pinmux setting for reset GPIO used by
usbh1phy, but is not referenced by that node. Fix that.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx51-babbage.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 541c6e67ad1a..19d3f0127f91 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -177,6 +177,8 @@
 
 		usbh1phy: usbh1phy@1 {
 			compatible = "usb-nop-xceiv";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usbh1reg>;
 			reg = <1>;
 			clocks = <&clk_usb>;
 			clock-names = "main_clk";
-- 
2.17.1

