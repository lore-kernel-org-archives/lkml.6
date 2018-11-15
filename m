Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B39EC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E0C2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvlvOjJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E0C2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeKOSId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:08:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35757 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbeKOSIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:08:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so16495219ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 00:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cAwx3JluMiA0iJvkhQszcUv3GhWr9rTeqVCy2GiE8hw=;
        b=TvlvOjJ/Zgo0LdmbtYzcDsIdUYyzEf0hNaJ2NmWBqWexv46nSLtHA7R0ZN7gmTZM9k
         PzuxIxMHn43xPFXHW4AUwpJov7jzxrhkMkEmquxscq1fpoYFV/x6avSikxWqAaPQWkza
         w6y9lEnrQnWC1hIbZi/Br05i4iIgo5h/lLnU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cAwx3JluMiA0iJvkhQszcUv3GhWr9rTeqVCy2GiE8hw=;
        b=F/A0DzSelti9EGg4WdVuKgLG6KsFa/+Rnt9+0BYbGPQnaPNy5mP7/GPeSUiIeAu9hb
         04u1umQGwQoO95dRqyZyHv+XYW8HsPewFIlg47i8ttf2vsQ3WwfuYu2fFzLzeqyzGCkY
         4f4JQ4Ag1zGAz00nijmZ4GAsrXbaP2WhQrOcirNXfvMW6Yyxu0N/ZMbqmplltiOtFQ8v
         mON+fmhLubtRAszPCtFLaWtkR+uklnhbOFwDCYK0caFIsSVksrQ8hTKQOU56NfnCBFu0
         P284u8FVpq+FnqMO45jMfXN4v4PHXRFUc/UgkE313sH0PaYzgxxCwa7tp/xgVFTTTVVE
         fqoA==
X-Gm-Message-State: AA+aEWZILsqopyrcPgHXOPp8gzdBcRgHbFMJGJNx/6eJjNkRkmeq9SYq
        c0ss1UBiYFxFTzUmXzviM6V/2A==
X-Google-Smtp-Source: AJdET5fqThLuvIuXgVf3n9fDK4HnqP16HMWYd9Ih6rfgkwW1+KXl6XSwSQ/evfuo4zFZFvQ3hJAuGw==
X-Received: by 2002:a2e:82d7:: with SMTP id n23-v6mr1273959ljh.143.1542268905506;
        Thu, 15 Nov 2018 00:01:45 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id o25sm4003427lfd.29.2018.11.15.00.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 00:01:44 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 6/8 v6] regulator: fixed/gpio: Update device tree bindings
Date:   Thu, 15 Nov 2018 09:01:22 +0100
Message-Id: <20181115080124.7789-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181115080124.7789-1-linus.walleij@linaro.org>
References: <20181115080124.7789-1-linus.walleij@linaro.org>
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
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
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
2.17.2

