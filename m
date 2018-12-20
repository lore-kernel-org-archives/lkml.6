Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63158C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3054820811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545322692;
	bh=l97Ajsr8gT/pGdZbcB6dNp3k+li/JRYxt4dtufW7CBo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TGjEhgcIFy/TSl4Xd7zxxOojrt4/qotXgVo7M5hkyNKgW6WzG7BRqZ9aixieZwSar
	 UufpVaQTC/rytEXkHeXeTs8MON+08Qrwuh1vnveRJjm+/S3i8PohGyOVyC4Ews0JbG
	 n/3yoSm6rfjaxj7wvEVxPBc+7Lf877xAHs2XScMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbeLTQSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:18:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33891 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730483AbeLTQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:18:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so1807164lfc.1;
        Thu, 20 Dec 2018 08:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kAXGwxdskkQicjP8JUaBQ2ce7ziQ+N2NgrQSOQUr9d4=;
        b=s7WiLhtZAvUKWFnSpOhBb/WunIRshuM3QRDYd0qWADAIV2CMFsmXp0L7+OkGoFNBrY
         EwwcT+XhHd7E5/yKv7L/2+nRAILrngIZTdsEb3NlvjczQhJ3xI9UjvM7KGQR4NqB3+jQ
         WHuL8JU/hBf7nB0o6P+soqiFWr1a6r4eozXLBrKVzzMI4+7Q6QGha+veq6qabIFDtVV5
         52NYLZxsA3FODr3m8/y/GLN0ptBCDLUb5tY7EdXDFguDN6Ngq0+oVjUnVWmYhqZNbzGG
         5XTRCE7DaMc8lnc4ANdTreUMTAS5OJwy5PxoATlyfWjbuLPvdy1mjwCdJwLeNrRd7Mk+
         p+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=kAXGwxdskkQicjP8JUaBQ2ce7ziQ+N2NgrQSOQUr9d4=;
        b=rN8Q/eN8M/HTDAL8Zzk71t10dPjBrmNxRzKOl08jxBkTpIIkP47cq/3p/onhR/SQX7
         0ibb7JMs7BrqqOfpN2+UvLNJj1xrbbYGu3XINfDRXYmUHl2t8O2D//Ra4HamaeJszJpv
         uwdSmkdYB27ii4xnqVFIvSpLK9E4FsZNVlPXjO8TL9EuBV+f4utFcEnlO9n1/5jP/3gc
         8eI3QSvvGH5LogGC9m6iUxzt6RvoFLAFeC5t6cF4JO4VrUEEWJ3uN01ekJ3nyaQrCf/Z
         z62JVgtm9OYeRfrdFIsX3/r7GVJ2HVZ9IWbuEsnt6taGgsw97bD/BOKMlC5xb8pzaaf+
         nbaA==
X-Gm-Message-State: AA+aEWZHmh5SDKkdZm3QJo+/rK9LYAXbeFfDJv3D2CT7oVLl5Z5+deG4
        ksXxiWaa49sDCUI6mgEXzuVRmxN2
X-Google-Smtp-Source: AFSGD/Vf2VPPfrSEpVZORRLiMDzH3WaunJsfZXrwLznZ5tfXPgGnw2Cu+H8IXoMe48jkYFva768Ryg==
X-Received: by 2002:a19:5394:: with SMTP id h20mr16139313lfl.75.1545322688717;
        Thu, 20 Dec 2018 08:18:08 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x24-v6sm4642575ljc.54.2018.12.20.08.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 08:18:08 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1ga11Y-0003Hq-Ka; Thu, 20 Dec 2018 17:18:13 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: dts: msm8996: fix blsp2_uart1 4-pin pinconfig
Date:   Thu, 20 Dec 2018 17:17:50 +0100
Message-Id: <20181220161750.12587-1-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "gpiio5" typo in the (currently unused) blsp2_uart1 4-pin sleep
config.

Fixes: 22e6789f9493 ("arm64: dts: msm8996: add blsp2_uart1 pinctrl")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
index c5c42e94f387..1d1f7f91739a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -139,7 +139,7 @@
 		};
 
 		pinconf {
-			pins = "gpio4", "gpiio5", "gpio6", "gpio7";
+			pins = "gpio4", "gpio5", "gpio6", "gpio7";
 			drive-strength = <2>;
 			bias-disable;
 		};
-- 
2.20.1

