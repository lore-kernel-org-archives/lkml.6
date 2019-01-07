Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D80C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC21C2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8dqIi2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfAGQbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:31:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40935 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfAGQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:30:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so857425lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 08:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1bIXk5dzdt8EoNdzwIUtN1S9PhBBOyNu5tnqMC0X+k=;
        b=V8dqIi2OuTn7zPY5f1SiBpQ5mUEoQKJCaAP/cM5f9Z2VObd8pFL2M2C4uKAvlGfs1N
         42WEi0oVlw5mNJNk9jAe7PHseQOyDzShsXb4eh0pcSbiK/OzZXLEvVabB4O0c72Mzx29
         DjGGJIV3kZLeULIM74uLVZBcv9SA1saEbE0TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1bIXk5dzdt8EoNdzwIUtN1S9PhBBOyNu5tnqMC0X+k=;
        b=AfxUYTnwK2XTYVu0b0m9BLk6paWH3WH2YC+Yezm6XTqlz3m9/KG/I26jWWHWAIOaCr
         Aw6znPoHKmYNnRGWdITz5Hpa6zLW0PYddsWiVBAWU2b9ui8nYqlYE2zi3VuJKCD1HPep
         qRJxGemaCbVl/XUV18vwPWvqxmh/t0pvuogpnnylPTaZXqAYos4Ib3qPETSomaIy7IwM
         cY260LOxozXlh4MrkIVRAh13mIqaqCi2o1BaQGdL2+6EOGOit2qY/E5smbHu/tZgz0FS
         6wafPPaskw5EPzn5eYq1Wugcsb59zndwQF+NS1+11wI80qckW7awYxuPumvc4/JISuIx
         83mA==
X-Gm-Message-State: AA+aEWYVkIfUc+q1BE8HYK8iIsBVUl85S/+ZJi1oACkg7eWQDmnnwIpQ
        9gC7tCu9NrFdpAk7Mb6VXOqK/A==
X-Google-Smtp-Source: ALg8bN44NYe1+KKt3rKCU/7Ice2YJD1JdIMdQjUrMlFttPZ8aV2p+YVsdGRwUWvkv9CvlPjezlf0vw==
X-Received: by 2002:a2e:9655:: with SMTP id z21-v6mr38115275ljh.136.1546878656349;
        Mon, 07 Jan 2019 08:30:56 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id b69sm12936594lfl.28.2019.01.07.08.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 08:30:55 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 3/5 v8] regulator: fixed/gpio: Update device tree bindings
Date:   Mon,  7 Jan 2019 17:27:44 +0100
Message-Id: <20190107162746.4444-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190107162746.4444-1-linus.walleij@linaro.org>
References: <20190107162746.4444-1-linus.walleij@linaro.org>
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
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
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
2.19.2

