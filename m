Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B63C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B78220821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eGaMnuND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfBEJNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:13:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34390 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbfBEJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:12:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so692310wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88EGuRhmZ5Mi0OmBRzcZ/azoI1Z+qLZaZYAJ4dxXFVk=;
        b=eGaMnuND74wXLrIiIsGtmL4V7SyxvgPB1d+lfQlkxRqxrs58oqhLSZKhSU+9SM8Q9e
         vtqmUbg5PZ5sHOPQncaN4E7YIDdFw7Gdj9YBkZ0nzWYGI6nTMyNZVjWum6uQh/nasRIq
         SubDIohX7JjH/cY7tW5T43upuqXhLrkVQnARefsp3v/vODJafEQe6pHnKuGzZtDpo7rB
         XCprgmy7sdzhT+10Fqzyp1zweCeEw3JzEiwJLm8j3ymvwa5AsHGNxpW8VJywLc8cWV6f
         HLWaTj7YMPedqKPcjDsDyjhjnSwRlMTxUpI+Oe48s8ZLINyAMRbmFcZ3gTDrjsG7wTq4
         8sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88EGuRhmZ5Mi0OmBRzcZ/azoI1Z+qLZaZYAJ4dxXFVk=;
        b=ABHUe9yorzacNvLe3zIoWym6IEhtN5kWNhxgXr183i4ZvzXFW9WTxo4o0+Z/Lezxdn
         PWfAheL27KPX2FmUAxMBvGF68ZwKd1JrhPrzeSKAHP800LrgiGc7IXco8MWygf0AHbtk
         tpeJGkVfZp3ZenffXsIbqT9IlcNtao0a/xojkr301UBJmWSVzm8GD1gKJZuvx9NjtEri
         p+ph51hHVEah0XB9wAmDKERBzh4bMzqhpzAt1/VXsTGQ2ZW9s27akRQG+ZaO/6nc14mq
         f9wwiFYz36sAO0zDiOwzo0QJbyKD4XfDKsZppl7s31xvKuIQkOk6grcMIq7h8F4ScCg5
         4mSQ==
X-Gm-Message-State: AHQUAuafsufebBjDEUpwdWGiImVyVoFUo+2K2ci9cPPtmGtXl8uCX80h
        Yiw8BvxOMJEPhpa+uEFdayYyMQ==
X-Google-Smtp-Source: AHgI3IbPG3QH2iFJBcBEE9dnz0DCsRdmGeX6TdvxMGeaEnwpcopAVpWc/DuoHe1b6o5Ny1bzD9L9Vw==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr2716027wrx.79.1549357966521;
        Tue, 05 Feb 2019 01:12:46 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s5sm10433657wmh.37.2019.02.05.01.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 01:12:45 -0800 (PST)
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
Subject: [PATCH v4 02/10] dt-bindings: power: supply: add DT bindings for max77650
Date:   Tue,  5 Feb 2019 10:12:29 +0100
Message-Id: <20190205091237.6448-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205091237.6448-1-brgl@bgdev.pl>
References: <20190205091237.6448-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the battery charger module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
new file mode 100644
index 000000000000..f3e00d41e299
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
@@ -0,0 +1,27 @@
+Battery charger driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The charger is represented as a sub-node of the PMIC node on the device tree.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-charger"
+
+Optional properties:
+--------------------
+- maxim,vchgin-min:	Minimum CHGIN regulation voltage (in microvolts). Must be
+			one of: 4000000, 4100000, 4200000, 4300000, 4400000,
+			4500000, 4600000, 4700000.
+- maxim,ichgin-lim:	CHGIN input current limit (in microamps). Must be one of:
+			95000, 190000, 285000, 380000, 475000.
+
+Example:
+--------
+
+	charger {
+		compatible = "maxim,max77650-charger";
+		maxim,vchgin-min = <4200000>;
+		maxim,ichgin-lim = <285000>;
+	};
-- 
2.20.1

