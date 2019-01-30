Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCF1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA95520989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfA3PIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:08:14 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:39497 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731398AbfA3PII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:08:08 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.32.180]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MZCSt-1gbP4K00xd-00V5PO; Wed, 30 Jan 2019 16:07:37 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 1/3] dt-bindings: hwmon: Add tachometer interrupt to pwm-fan
Date:   Wed, 30 Jan 2019 16:07:05 +0100
Message-Id: <1548860827-29796-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548860827-29796-1-git-send-email-stefan.wahren@i2se.com>
References: <1548860827-29796-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:rpmX0OqnhUWw39eh95mqXLGvwhXBdHLqF9lnRb5QAST3LBzXHkj
 LSb+h/tXe+z/daqnLB1VWfnGdcm/8xHkf+m3SqSeo1AFtpLiIUmb+cVgqQBDSvoQkXnyWD4
 TVthKb7siumaFPNJf1sBACCkWOuV9mn1uA54I6OLdQumESzjRkKcUSOruVSK0Kv9qbED9ij
 bxYEoiRU08vpA0sCZ0QiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z6IWSm/u2Fc=:M8nIZ9TnFr3rhR2vRkc6vO
 y4czcvB0OmQvoYrlY2kXAOZ6X7JCq+st67oITufgPT2iYnqRYV5DRhwfWc2yIO3Ki0VeB/eEj
 DjGy2KXC2WCW5w1hYqV4GlVQgTEUl2WIK0E+bu6uavShta3bPDfldokbkR8/lehFT4JFM+nxs
 VqeZePhanPkkrmG5jYxvkrei3tebuxZWl/zzb4nde+/WoHtCPLAdfpcYPNfQszq+WvixEpebT
 GOjwW/nAN5H0C41k3luw7y4D3nGx82f1hBDMvt2NOhjanDa1fOIARyxMBZi9YtOivzvEFm3Tb
 x6lDuiEoh1ehebyUvHeutZERc631EIGdQd3mcL9CteJJTlE/JwbIP6UfXWJSQ0zaZtLSf69/p
 swvzbesdJEzCzxL9bGcg8Uo90dGbRH6yMthXVa1V/kEZtlVez/lhz67kAA/7f8AppNelbgEOe
 8GSzIijB4AhB4b7nMzXP2vPR8V1dJcFNqDvQGjOjNy3FLxCbGmKYIiivbdI7m63U7L/qYvdsC
 t8WtOHQZyifdRbUrHxvD3zMyHLU3Vl3/ecPLgQ3DliDaQ/hz4bgJ7w7eelRHa4wuDawjIjawJ
 iVeP7rDqBy/1+CNyZn1BrxrN4GEMuekPf7GPeoIBhCeMCgbWiYPyCAIUQD+F1JPy/arN34wU+
 RvU0FH/HucZHJG5T37p9lWd2kFUWSBlfyWkvj6JaDLcaKa3WKyX/C2D4tk+IGMFzDG4ng9MbT
 sYaPXusPABIydO0k6eJgjcPYe7Spi0QhhkUxhdKfH3A84aRBObkWGsRjH/0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the tachometer interrupt to the pwm-fan binding, which is
necessary for RPM support.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
index 49ca5d8..7f69b0b 100644
--- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
+++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
@@ -8,6 +8,9 @@ Required properties:
 
 Optional properties:
 - fan-supply    : phandle to the regulator that provides power to the fan
+- interrupts    : contains a single interrupt specifier which describes the
+                  tachometer pin output of a 2 pulse-per-revolution fan.
+                  See interrupt-controller/interrupts.txt for the format.
 
 Example:
 	fan0: pwm-fan {
-- 
2.7.4

