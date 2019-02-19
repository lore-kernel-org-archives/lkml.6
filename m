Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF66C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7BC21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFrXQsWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfBSJ6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:58:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54966 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfBSJ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:58:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so1859405wmh.4;
        Tue, 19 Feb 2019 01:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=amVLtslKah8NEqXbibYVvTbqGmihSwq/9ou54c3QAlI=;
        b=SFrXQsWQ6pJtOaMbI77sTKLmvWZOqqmTF3ubxMbaxpZE5qhShMLj3ySRuoeB70M+As
         /iNAcPyZBK0O6miuMNnTlx8BrYoe3jxQ4BsyXK8U2TNaEQqjGDCYfgAEOaV7SY4ei4CR
         GM4HnsN3PnhF4jXLvYxDFmCSJ/Q7Ap4NauGf5EHCb9hHvp2XgTnSMjdJvEiUXgUCkD1m
         OP012LjGF0GkEqfaBIvPinyQl5vfpVwkBWc/JXDNadQlB+CMz6dJsPjKHIgdjChQJ2vp
         NsBz5bOmWEcffbIGmXhunPSKu2fS54HSJ6JCAPp+mYLkqxdEVdt0WiGT4rnBbl+wbr64
         +mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=amVLtslKah8NEqXbibYVvTbqGmihSwq/9ou54c3QAlI=;
        b=t1W2uHGDShdCFZE3QdGK76A5wY2RmbyWONe1q4fUfgBfGDjGMiORINoa8M0q/d8GuB
         xXu/nBE6WLWLyBezk4WCYxIegKbRztyxKsb0RHS/C91DCSdMIG4hvPCct0p+8p8FXTzF
         Rq8cM58D/0KCMJdCS2249j0BrwvtVjfThlZgyQznL6pGLNov7en45B5JdSQdzimPNYk2
         kbEebmXrzZc2m2RR/sybutu/9xPULfDOO1UYLWjam/l1VW8kPhjAEaRrOWZOMKWHhINt
         l3YZaDaNBPU6S/Guzy7B9FB53MDpBy9tE3R05rNLpbqvXsS7Y3ribrXt38CoMEb6BVkF
         7JsQ==
X-Gm-Message-State: AHQUAuYvawVMWuEak0ExnykLSrvWXkOC6bwkYOF6ZQNWO+Ztww7oU9VO
        sV4m/B0RwfOd2+/vGUtLX+A=
X-Google-Smtp-Source: AHgI3IaG8kH7aNjpLP+9JFVuG4cu4TlonE73wfIZBFZs2dWneDLXs6Ml51vxv73i3awxWX3aSxsrXw==
X-Received: by 2002:a1c:6589:: with SMTP id z131mr2140274wmb.120.1550570305849;
        Tue, 19 Feb 2019 01:58:25 -0800 (PST)
Received: from fuji.Parrot.Biz (smtp.parrot.biz. [62.23.167.188])
        by smtp.gmail.com with ESMTPSA id k20sm31639220wre.41.2019.02.19.01.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 01:58:24 -0800 (PST)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: pwm: hibvt: Add hi3559v100 support
Date:   Tue, 19 Feb 2019 10:58:07 +0100
Message-Id: <20190219095808.12059-2-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219095808.12059-1-m.othacehe@gmail.com>
References: <20190219095808.12059-1-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
platforms.

Reviewed-by: Rob Herring <robh@kernel.org>
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

