Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF95DC04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A327D20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ej+/3Nqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A327D20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633219AbeKXGjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:39:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38000 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbeKXGjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:39:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so9879928wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 11:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrHiabzypDdx9sXk/8fCSUY/mMOsDJBAnI+t/Q5NOr4=;
        b=Ej+/3NqgYL6iugilKeZ6Fxa/3llufEJG0Vo7RoAS8oiyiiZgNi4/WzAvt9uvp/B8oW
         D0fqd5SH8FwvgbUbOLfEbbqwekCPR98rdtwAuk6KT3VPVxmhb//Sm2+nR7QSZGJGQPQ+
         RTEW/BiVNn8L90xVaIDwGCJcx/g/WYZxoDucIf0Pr0fZUIJuE5Qc++mII0051jGS9IUF
         tqIaJot+ETjObqwUr17KpH1ZhaWlO0xBjT8p74Jt3oMACzKEF1nS7NIEELd1kR71h+ok
         BFWGjqWGJatJ9hJEqcH89yU1YvHOZNEfEWBR3IFka/aw9EYVOp9BMYfYoN/AuwHUqveC
         +mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrHiabzypDdx9sXk/8fCSUY/mMOsDJBAnI+t/Q5NOr4=;
        b=Oj+XQ7RlkBxn1AAj5RZ4So1JWMgbTI33gd0HMjTMwk/6yAQpvGVAn8ZMYpIzmSXz5A
         E0K3gKgC/7MSVEyDnOvUovHigyuWkcnzjIw/bXvuQEJPHoYUz8HrDJUTS7Y+JbSeWRRQ
         zIcuxVcB8RzE77EYwkeI7HxqoWoUxW32NW3XIyS2nOGttWu4pSSO25dcDk86GEAqvMrv
         iwofrr9nhXuMPTqOw5GkEdLXs0YNIpSlol+LYI2ohaToIgzrqbWv9hpkff8xCwxYrO1e
         PZ4/iRhn2fZvtTp57Fg34HacakV0V12AAJnx+NfnfIlPJHjNTjb0f2ius69BXC7StvAU
         cK9Q==
X-Gm-Message-State: AA+aEWYNe4oKVK7gK7ZBo/33xvX2/q/1iCQziXn2HgiXK4wiEfoPcgOy
        gZI9dfi8MYVytlyvCPyThsc=
X-Google-Smtp-Source: AFSGD/UlnQrPsB5Ujyi8MQoIsaH/g/I5gwf206RcLXExa2vxtpmhmi4D+pHqfQGRV2c9V5MDmCbpjQ==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr16323404wrw.113.1543002810075;
        Fri, 23 Nov 2018 11:53:30 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F500597D16A631573221.dip0.t-ipconnect.de. [2003:dc:d732:f500:597d:16a6:3157:3221])
        by smtp.googlemail.com with ESMTPSA id g198sm11495337wmd.23.2018.11.23.11.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 11:53:29 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     carlo@caione.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 5/6] ARM: dts: meson8b: add the ARM TWD timer
Date:   Fri, 23 Nov 2018 20:53:10 +0100
Message-Id: <20181123195311.4578-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Meson8B SoC is using four ARM Cortex-A5 cores which come with a
"TWD" (Timer-Watchdog) based timer. This adds support for the ARM TWD
Timer on this SoC.

Suggested-by: Carlo Caione <carlo@endlessm.com>
[ rebased patch from Carlo, use IRQ_TYPE_EDGE_RISING instead of
  IRQ_TYPE_LEVEL_LOW to prevent "GIC: PPI13 is secure or misconfigured"
  message during boot, use pre-processor macros to specify the IRQ,
  added the correct clock, dropped TWD watchdog node since there's no
  driver for it anymore ]
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 6b097ab8637f..a3a5649e32fa 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -349,6 +349,13 @@
 		compatible = "arm,cortex-a5-scu";
 		reg = <0x0 0x100>;
 	};
+
+	timer@600 {
+		compatible = "arm,cortex-a5-twd-timer";
+		reg = <0x600 0x20>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+		clocks = <&clkc CLKID_PERIPH>;
+	};
 };
 
 &pwm_ab {
-- 
2.19.2

