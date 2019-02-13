Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDFFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D609E222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2E1taFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404141AbfBMPFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:05:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40272 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403979AbfBMPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:05:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id q21so2756632wmc.5;
        Wed, 13 Feb 2019 07:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wbtkp/xOVLLMu3e3atJBIkAN4nQ6EEguRtKAqi9HMs8=;
        b=l2E1taFxfQ2PtNmNnbtpqWAdYO0FoeKInQ721fGAkNruTe4uZYO/VXLkuXy+fjfTlQ
         R0oZ4rWvqu/vgergkcP5uWjCqZR9A8mZ8UTkNa5Imgkf7ZfOjAXtm/+muucjfS3AQ+gw
         G+WlolF4pNgukgfRGbGhBFzEuQHcTQQBsu4cae95otAxfYTE8uKK+3eiGWuiheKzm59a
         VvVb3HoXl5UMj4pQYEbZo/9CH+GnMMZkDUooQMaPHOrxLaigQsfsuOMU6iuy6ijotB28
         p5Xx93c4JbEMLnb4bQvwTlIcwefERouWKkmWJUYZUZAPH+TZofaqbD0qOVQrT0jsPtPZ
         35Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wbtkp/xOVLLMu3e3atJBIkAN4nQ6EEguRtKAqi9HMs8=;
        b=Nss6tDf+wzMlj726cATk1uIq0fAp+znZ3S8Md05xjHo28F+dUvT+reoaFxZFpS1XSO
         sRkWOfk7uf4HGnw2wv8yJcXdxEFXylyV5VSr8BdMowwQaOoJVUoMRn/oqTiQRN1i8JMo
         rc/ksf0T73kYT0gCyNkWubEYTpbaq23YlJ78snFnY+Vt3dKcGz3icaP1S45GS+5r7hvs
         YuO1oZxAXvQGuAfMoUbA/ganjG474focOTOCur43t5OnYCJ7xIYxjky+UMH6H2lzmTMa
         +NpDPDM2c8GfbHRkXumNzhNSInXqszqQ2ZjQI1aZ2Ceg0AHzj4ZQIpg9dEGXnciDNvAe
         zRsQ==
X-Gm-Message-State: AHQUAuYBJsOsTjuSyoALm15+lMNKDBVyHlpuFYqB2ZQ7I7n95HZeZkDO
        ZIGbtJ0hZnxC1qeRDxGH0lzZHZ0d5qw=
X-Google-Smtp-Source: AHgI3IaDWUR1WcJxntCLabLnlHt1qr+gTZ2HJEqns7w5EJHFt/w7SxRCqoPnA9fp43TnmSpSsfJ6Sw==
X-Received: by 2002:a1c:2547:: with SMTP id l68mr668153wml.11.1550070315598;
        Wed, 13 Feb 2019 07:05:15 -0800 (PST)
Received: from fuji.Parrot.Biz (smtp.parrot.biz. [62.23.167.188])
        by smtp.gmail.com with ESMTPSA id f187sm7533959wma.4.2019.02.13.07.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 07:05:14 -0800 (PST)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: pwm: hibvt: Add hi3559v100 support
Date:   Wed, 13 Feb 2019 16:05:07 +0100
Message-Id: <20190213150508.11499-2-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213150508.11499-1-m.othacehe@gmail.com>
References: <20190213150508.11499-1-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
platforms.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
index fa7849d67836..daedfef09bb6 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
@@ -5,6 +5,8 @@ Required properties:
  The SoC specific strings supported including:
 	"hisilicon,hi3516cv300-pwm"
 	"hisilicon,hi3519v100-pwm"
+	"hisilicon,hi3559v100-shub-pwm"
+	"hisilicon,hi3559v100-pwm
 - reg: physical base address and length of the controller's registers.
 - clocks: phandle and clock specifier of the PWM reference clock.
 - resets: phandle and reset specifier for the PWM controller reset.
-- 
2.17.1

