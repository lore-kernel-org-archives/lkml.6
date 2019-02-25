Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA954C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB552083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyGcQgiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfBYQ6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:58:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33821 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfBYQ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:58:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id u21so7455075lfu.1;
        Mon, 25 Feb 2019 08:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9jJLc8913jCRr6FIPf3Jl8eZmhzPJoRbZ++JHz8o93Y=;
        b=NyGcQgiRse+apKqm27ifetll733blREDPysKkvtABaCl/bMjHnIzV6Xur+uFi8a3io
         8W+emYBt9+qyKj97eQ1fUBcbtCjlD853d67ZOmxKD8vUPi6wKhrs18PxkuhoRONW+Hqi
         /QRid9a7ijvA7cdGd6SSCeUg/AYV8NIgKLKwmIZUUDiJFm26TmA0iYvRNLuHH4PWIexD
         xSIGkczY6v7t26n9XM0qQquNVdRxM59tbGaVuDVY0hUL62yX1ZrR4Mh4pp12YDvnG2wk
         6zUqUZ8ROJyKKF5UUkZY1DuYS6KN2jtVsEmontuP+vHi+4ND1/kkfbBE5P9O7dW5xp/J
         m2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jJLc8913jCRr6FIPf3Jl8eZmhzPJoRbZ++JHz8o93Y=;
        b=VzLD1wPCEPtp7wrhSkaOdVPykd8qeYdssEEN6xQ9pX4ZlRwi8qkey2Cf9zDvmNquT2
         w7Q016Inc0qwYxjXOOht9HL5bZOzoY5c4R5C06KT7dHHCSrAplTAD/B78pYG/iPJM5sH
         fh+NCQr4WzWSnI5XIR3yZpnxai8M5nMaullgWM2Lsvo3aBEGgEjii35IQqZa1vUGH/Yn
         BDAtNCOqwU2hwKORzobzyzrSk6ecN2bNRb1BG+V0CjJxc1j8m5STZSHp9w6GjIEQmzgo
         L8Vd2QdAsId49QJzij21IOYqKJ87HYQVyaT6Qdgr6XDNFVZTAaQGwV7O32A+LwLBcR61
         lLLg==
X-Gm-Message-State: AHQUAuZ/hdjkWHb6Rh6nyuW8O0CVVIc4MVeJLWNqqz2rnNARiAYeIHY8
        frTbvyqCz1d4cGdWR/jKyzw=
X-Google-Smtp-Source: AHgI3IbbPp20+wvoZFMPeWzPUszFYebbfKnkp3BYK1csbTsNu190qJhUrvR+92o59e1IrPvjeVDZvA==
X-Received: by 2002:a19:2396:: with SMTP id j144mr10067796lfj.159.1551113908362;
        Mon, 25 Feb 2019 08:58:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:780d:6cb1:e20:559d])
        by smtp.googlemail.com with ESMTPSA id l30sm2597575lfk.83.2019.02.25.08.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 08:58:27 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     myungjoo.ham@samsung.com
Cc:     cw00.choi@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 1/2] dt-bindings: extcon: Add support for fsa9480 switch
Date:   Mon, 25 Feb 2019 17:58:21 +0100
Message-Id: <20190225165822.2770-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190225165822.2770-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190225165822.2770-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

This patch adds documentation for binding of extcont Fairchild
Semiconductor FSA9480 microusb switch.
This usb port accessory detector and switch, can be found for example in
some Samsung s5pv210 based phones.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 .../bindings/extcon/extcon-fsa9480.txt        | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt

diff --git a/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt b/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
new file mode 100644
index 000000000000..ebced7b18eb5
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
@@ -0,0 +1,21 @@
+FAIRCHILD SEMICONDUCTOR FSA9480 MICROUSB SWITCH
+
+The FSA9480 is a USB port accessory detector and switch. The FSA9480 is fully
+controlled using I2C and enables USB data, stereo and mono audio, video,
+microphone, and UART data to use a common connector port.
+
+Required properties:
+ - compatible : Must be "fcs,fsa9480"
+ - reg : Specifies i2c slave address. Must be 0x25.
+ - interrupt-parent : Phandle to interrupt controller to which interrupt
+   signal of the chip is connected.
+ - interrupts : Should contain one entry specifying interrupt signal of
+   interrupt parent to which interrupt pin of the chip is connected.
+
+ Example:
+	musb@25 {
+		compatible = "fcs,fsa9480";
+		reg = <0x25>;
+		interrupt-parent = <&gph2>;
+		interrupts = <7 0>;
+	};
\ No newline at end of file
-- 
2.17.1

