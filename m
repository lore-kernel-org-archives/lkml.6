Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88809C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CCB2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsWID0/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfBLJth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:49:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37011 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfBLJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:49:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id c8so1927148wrs.4;
        Tue, 12 Feb 2019 01:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wbtkp/xOVLLMu3e3atJBIkAN4nQ6EEguRtKAqi9HMs8=;
        b=GsWID0/DxCzdY3qzyw0efFatvgqchc63zqCWm6CQ0E5sQ6b5v+OjDzKRvCGlZe6wsm
         Ntt8X+JXUmvsVoDC4WENd8yNBqzHQGRwKOPfrA8o33tZ73JppQxt2ovMEIJxx0heWUQk
         4dhV2Bx7FXZiJNB7bB0QRSK1cpUGAjur0+TtqHYcL3ZprPthobr0sUm9PcvXrcH+u8fT
         ZFkgh+UvnvI/w3oHwTlvKSnPjZS4zPEOM4SFP9I+M9pZ+NGgMxJxU/bL6fPeotANH997
         8bi5fg+sMBZwiElym4M7HxbrfJXUiaQ/1z7GwfobuDmZMTqv4LsWbhriP4XuTjfrohzH
         2hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wbtkp/xOVLLMu3e3atJBIkAN4nQ6EEguRtKAqi9HMs8=;
        b=jlbN+hpazQc5qr/ar/MUyvGZ3FSM4xNXZ3mhpGipYNlGgjYUfvJvHRnoXPWeG35Nl5
         BR4C72O3lJXx6+gUUoQW6VM3NUfv+k2Ldtg0cjm4tG6x71HdtNGo2sHQaDQ+O9RtNv14
         2IUaKnueECjIVRwBiAaevAVxVVYSbOwSUvzlpyl4C4o1Zv16YZOR+07c8qORPQjik3Y7
         3Eu2+QZw9Q334wHqMn+fRl9EHZFntU6Qv/I4oVKO7f1G4B/X/Xg6cKjp+zl1JFOzANly
         0Ap1DtvUQQxdC/uDRy2xU/K5ByXvH/7RqLJN9uvQyt78+H2tLzQXFJfnZNSdz+EAqB61
         uvKg==
X-Gm-Message-State: AHQUAubd8N6CvWPsNreTmsd2KrlRbZFWjjt4CCQJKyBl+VF11Xduc6qY
        jY4ijlnDQKPrYKRgCNSJPIsLqig+GNM=
X-Google-Smtp-Source: AHgI3IarAXnp6wJnCi/YMfSsrJDgekKCOterDokx/85vZCkPwqG1Qvk61s1AdJSB8CkzbLeWWloZjA==
X-Received: by 2002:adf:f487:: with SMTP id l7mr2114640wro.86.1549964973364;
        Tue, 12 Feb 2019 01:49:33 -0800 (PST)
Received: from fuji.Parrot.Biz (smtp.parrot.biz. [62.23.167.188])
        by smtp.gmail.com with ESMTPSA id d2sm9299843wrs.97.2019.02.12.01.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 01:49:32 -0800 (PST)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH 1/2] dt-bindings: pwm: hibvt: Add hi3559v100 support
Date:   Tue, 12 Feb 2019 10:49:26 +0100
Message-Id: <20190212094927.5900-1-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.17.1
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

