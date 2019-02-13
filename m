Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BCEC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942AF218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="s876fdQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbfBMNpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:45:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37683 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390651AbfBMNn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:43:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so2553054wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJmiNfRo8EeI+C3VRiIxh9DmBCp1GcHRXWm7GuC7DQs=;
        b=s876fdQMJA7nX/v6RjR5Kj0rdfFIb8ZZUOifVmGZY5H/iAw2jlnz0LmtHelDhfNVwn
         ccyyB7rx5Xnl823ZeHWr1yQicd1BWchBpvpWBG5oHdNlepWNVQDnkGjRZb8xDK9eeuTs
         hjU7aUFhP7CiRTglo3l3NE2dnhNks66blqkmsvmhJJOpEuVWKcpWTRYrR6v9vrkGjbjz
         LgW8KCrXLLBJyfgAKA/uI2fSLKEFmr7pPIwb3m/UmphiuC3vxUjf/A6wd87crFKEnV0d
         2943kQkbkhyZxRDe1r9JncONlKaADzPe+OifoOhAr4BPrLLD5izD12oFI8OS+Ksl8a4s
         OeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJmiNfRo8EeI+C3VRiIxh9DmBCp1GcHRXWm7GuC7DQs=;
        b=BdPJ9q7O45JyDa01YAPkW5tZlWHG5BN5PjthLiy+ubGyWKfZNXliwhT4GWk5qoAZuz
         cs/6oBvf4hQAS5gn026rbpMJCrRqe5y6CTBOtbkC42V5AKvjhLPloGW0qvsbdc57kmPD
         EvUx10Fls03YKVf1j9j2uPwhchzVO/3BrJkaMRTYJNEYZMEkDG1QOTA1nOKJTjCCeavv
         eJMQbN2I7fEDp1ye6ffwwqOYGOEH1/BW77xaktER8TL17FTeINTBEbjXSBem3AyU2Yy3
         ni+uYHPJORCABR53U1fVyfChuZtnmIx0I3ixoJyv3qDKE7nOqZjGbXSO4t7tXkzoPlav
         rGew==
X-Gm-Message-State: AHQUAua5dKzI8BzzD1OdOxIwfqe4WD1gdlecpyTlgb5NBEz/9kc/W1R7
        HXuZvOsbmN/T+w5vHXMWYzBEAg==
X-Google-Smtp-Source: AHgI3IYqce5u7rqSks1vpbKzgmPPcBgvMpmT8wtMhYYrkGC9s9NGzguxV+MFJv2MrW/5QVDcOyGpVQ==
X-Received: by 2002:adf:f845:: with SMTP id d5mr494170wrq.113.1550065434678;
        Wed, 13 Feb 2019 05:43:54 -0800 (PST)
Received: from debian-brgl.home (amontpellier-652-1-54-116.w109-210.abo.wanadoo.fr. [109.210.45.116])
        by smtp.gmail.com with ESMTPSA id e7sm2046720wrw.35.2019.02.13.05.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:43:53 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 04/11] dt-bindings: input: add DT bindings for max77650
Date:   Wed, 13 Feb 2019 14:43:28 +0100
Message-Id: <20190213134335.10838-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213134335.10838-1-brgl@bgdev.pl>
References: <20190213134335.10838-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the onkey module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/input/max77650-onkey.txt         | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/max77650-onkey.txt b/Documentation/devicetree/bindings/input/max77650-onkey.txt
new file mode 100644
index 000000000000..37c80898be4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/max77650-onkey.txt
@@ -0,0 +1,26 @@
+Onkey driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The onkey controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-onkey".
+
+Optional properties:
+- linux,code:		The key-code to be reported when the key is pressed.
+			Defaults to KEY_POWER.
+- maxim,onkey-mode:	Must be "push" or "slide" depending on the type of
+			button used by the system. Defaults to "push".
+
+Example:
+--------
+
+	onkey {
+		compatible = "maxim,max77650-onkey";
+		linux,code = <KEY_END>;
+		maxim,onkey-mode = "slide";
+	};
-- 
2.20.1

