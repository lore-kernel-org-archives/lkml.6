Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7BCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3C120869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZhDuyu8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfA2KcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:32:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35073 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbfA2KcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:32:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so14229268lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 02:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWy4IKgcVotjcGKcL+YOPtGjOTrN/OWg2WWmLAh2Cuc=;
        b=ZhDuyu8LF/gtqxDcoKYwiqntXXSEhkG/QwiwOggiz+VVa5DtPtho1bn4lO/JihJATh
         j6ogTtNTeOitU8rHlSOgzTJx9VHAShs4Q6/SjPhHeOaB7y8HR17oiklXFM+LU9ROBuWs
         IonbT2qC1maNUvIPBv+YeydRKVdZ/YKpBhl2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWy4IKgcVotjcGKcL+YOPtGjOTrN/OWg2WWmLAh2Cuc=;
        b=WU2c1QTh8C1JmI+f9pmoQn4vg5fZhTTtMpxIvDBylwuSUk5WrlXEj1Vb2tu79gW6ew
         5NXw91DLkEWvAtyxEksvDqbkqbwdbYXSLYBFXh68v7jcq93PwDizVYSmMQfR1CR0CE6Q
         QeLrYUqgsnKu6ZTLOxZq2LWthay3737vqJ6ckqciZR7jLApFr6GVLJXO/Yp0nsbslMLn
         c+7aGlYRcbWQNrBVQ10UAOiuVW0Nnvo7VRfbaNubYLL8JsgBpcapKzm3MlvbPtXhVe9E
         L+GC65r2SLzOLB8zVmQM+TXgDlpi9c7AeEMSzjxOH7UI7hVnx4fBqnn7Y/Ug5eoEwPuD
         3wAg==
X-Gm-Message-State: AJcUukfMFWsq3sqAnjfMDRXiV4dPrOgrFnOx+r7wrKZYdyBlik0o2gn7
        PFHmcHZ4sq5KftAXxr8V5gW6moiHFys=
X-Google-Smtp-Source: ALg8bN4K+T2CtCp66b/bpc8y+yLv5hELAeOZwxQ6gp4WqFYTRA8ggcLtyWCono+Q06PlfdiUZqgBFQ==
X-Received: by 2002:a19:6a13:: with SMTP id u19mr20581381lfu.46.1548757929045;
        Tue, 29 Jan 2019 02:32:09 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id y9sm3471540lfe.75.2019.01.29.02.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 02:32:07 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH 3/5 v10] regulator: fixed/gpio: Update device tree bindings
Date:   Tue, 29 Jan 2019 11:31:54 +0100
Message-Id: <20190129103156.10139-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129103156.10139-1-linus.walleij@linaro.org>
References: <20190129103156.10139-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate the open drain binding for fixed regulator and indicate
that we prefer this to be passed in the GPIO phandle flags.

Clarify that the line inversion semantics for fixed and GPIO
regulators completely overrides the active low flags in the
phandle flags.

Unfortunately this can not be changed to prefer that we pass
the flags in the phandle: the bindings have been specified and
deployed such that the presence/absence of this flag and only
that controls the line inversion semantics. The crucial semantic
is that the absence of the flag means the core will assume
the line is active low, which in GPIO terms is an exception,
as GPIO lines are normally assumed to be active high.

This special device tree semantic cannot be changed without
introducing a whole new compatible string for the fixed and
GPIO regulators, so we just contain the situation.

Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v9->v10:
- Rebase on other changes.
ChangeLog v8->v9:
- Rebased on other changes.
- Collected Marek's Tested-by.
ChangeLog v7->v8:
- Rebase on v5.0-rc1.
ChangeLog v6->v7:
- Resend with the rest.
ChangeLog v3->v6:
- Resending.
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Collect Rob's ACK.
---
 .../bindings/regulator/fixed-regulator.txt          | 13 +++++++++++--
 .../bindings/regulator/gpio-regulator.txt           |  4 ++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
index 0c2a6c8a1536..a7a1cd0dfa6e 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
@@ -8,10 +8,19 @@ Optional properties:
 - gpio: gpio to use for enable control
 - startup-delay-us: startup time in microseconds
 - enable-active-high: Polarity of GPIO is Active high
-If this property is missing, the default assumed is Active low.
+  If this property is missing, the default assumed is Active low.
+  If the phandle flags to the GPIO handle also flag the line as active
+  low or high, that will be ignored for fixed regulators and the
+  presence or absence of this flag solely controls the inversion
+  semantics.
+-vin-supply: Input supply name.
+
+Deprecated properties:
 - gpio-open-drain: GPIO is open drain type.
   If this property is missing then default assumption is false.
--vin-supply: Input supply name.
+  Do not use this property in new device trees: instead use the
+  phandle flag to indicate to the GPIO provider that the line
+  should be handled as open drain.
 
 Any property defined as part of the core regulator
 binding, defined in regulator.txt, can also be used.
diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
index 1f496159e2bb..8fef3e5358a2 100644
--- a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
@@ -14,6 +14,10 @@ Optional properties:
 			  defualt is LOW if nothing is specified.
 - startup-delay-us	: Startup time in microseconds.
 - enable-active-high	: Polarity of GPIO is active high (default is low).
+			  If the phandle flags to the GPIO handle also flag the line as
+			  active low or high, that will be ignored for fixed regulators
+			  and the presence or absence of this flag solely controls the
+			  inversion semantics.
 - regulator-type	: Specifies what is being regulated, must be either
 			  "voltage" or "current", defaults to voltage.
 
-- 
2.20.1

