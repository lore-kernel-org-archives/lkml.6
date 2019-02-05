Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91508C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61179217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="x+8PitUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfBEOAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:00:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38363 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfBEOAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:00:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so3728218wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 06:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwFdzRkd18wMQX0It+mUaqAVIDact01q7gkgyyd7ni8=;
        b=x+8PitUv0C9NlVoPmO5LFVv0wKagTycFl+A6YE/jv79zaUlqbbsPN/3/Nn4YzNlfdM
         XihOfw7uEswC1jDERGtQvXd/Jw5bsUXji2Ftceqx+nLMUi22yUKb6Khm+8tUFZmFpI2W
         +kA8W0FYSXVHPHkoJSmvENDebBl99koxyPxljNedi6BQZqa7Dr1ww0oTTjE3TT5wZHb3
         sVNdKx3sIi2oElqeWFYgQiewL/5ny1Se42BNpSWU8585XZ2UylgJJZsT/AKM34I4KTg5
         /e2ydVfyxiCYVGz9mC2znpVyRvN0YMiIyaJK4nUFd98tWN6aSTyqPtQoAMe+93h7w6iQ
         /WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwFdzRkd18wMQX0It+mUaqAVIDact01q7gkgyyd7ni8=;
        b=dHuZm2tFXNXVP/Ktq04xXSgw+RiUXmQlDb2BcZspNk5oY0jtJlIdmEeTL9OHGVelKK
         MKvvT3tTjA9tt8bNKm8Nop4u1dDo8UKDhq6hPQ8o7X8TGJ2meNLUB8xXxd2NT49cCGwn
         1do2Rz54kW9qiXWfIBUMHxY+LTkobg8IhCEHYpWtFVWT9Aq1kwRrQHkLdACV24Jem+V0
         SClU79tsVF2xGL1fs41PWSPyySh6wla24lw9Lg6dvaVxzm6ZrlSzwzfTOjkYh5yWKlno
         5sG3g0D63cWXLES2pADdgB8gdgb3DefoD9IC/o2XyLUqpH0yWXzkOcI5zvHfbVYhBL4y
         2HIw==
X-Gm-Message-State: AHQUAubBVn3JcQYm3I1SY6C64TIIe2twBsjmr2ct4E6f/wKvSjP0F28M
        sU0c4qyFfJ6K9T0aQLzMUSenmA==
X-Google-Smtp-Source: AHgI3IbppprLpq38XVFEYjO7PXcjaXpIID36BGfdW8kSSbcXpPkx8R8KAUEx0zy1DITsfnSgyTAxBg==
X-Received: by 2002:adf:ff09:: with SMTP id k9mr3598691wrr.97.1549375203235;
        Tue, 05 Feb 2019 06:00:03 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y1sm5560379wru.4.2019.02.05.06.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 06:00:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: at24: add the 'num-addresses' property
Date:   Tue,  5 Feb 2019 14:59:33 +0100
Message-Id: <20190205135934.18841-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205135934.18841-1-brgl@bgdev.pl>
References: <20190205135934.18841-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the at24 driver only creates additional i2c dummies for
atmel,24c00 and it's hard-coded. Some other chips (like for example
Microchip's 24AA02T) also take more slave addresses despite being
otherwise compatible with already supported variants.

Add a new property to the device tree binding document that defines
the total number of i2c slave addresses taken by the device. The
addresses are counted starting from the one in the reg property.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index f9a7c984274c..0e456bbc1213 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -75,6 +75,8 @@ Optional properties:
 
   - address-width: number of address bits (one of 8, 16).
 
+  - num-addresses: total number of i2c slave addresses this device takes
+
 Example:
 
 eeprom@52 {
@@ -82,4 +84,5 @@ eeprom@52 {
 	reg = <0x52>;
 	pagesize = <32>;
 	wp-gpios = <&gpio1 3 0>;
+	num-addresses = <8>;
 };
-- 
2.20.1

