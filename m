Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A63C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4B920842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfBYQAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:00:50 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:60233 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfBYQAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:00:49 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.53.79]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7Jj2-1guzoG1ske-007kBs; Mon, 25 Feb 2019 16:59:56 +0100
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
Subject: [PATCH RFC V2 1/3] dt-bindings: hwmon: Add tachometer interrupt to pwm-fan
Date:   Mon, 25 Feb 2019 16:59:17 +0100
Message-Id: <1551110359-19860-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551110359-19860-1-git-send-email-stefan.wahren@i2se.com>
References: <1551110359-19860-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:eQ6be8+xN/Kp+WdWtHteev5zaicZG8qo2dkAXGE1IW8/s/jeT5h
 9yvyLGBTulrXXKI0eBgBGkQtyhZM2cC7e2r327/hYsvalgR7DrwoQldzuGF3g8B1uPIbZUs
 vvvjZE13Ws94I8YsZqOphX1wh/Qf8pd1W6LL38iUGujbal9CDy2VN1yQc6Wixd7kbsYVwk3
 uL5iHge0hZhwktbXSWGwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VNLDuthaZDg=:1Ek/LC5E/KdBMYdlGAmMb6
 sQ3MKCbop9trcckHGb97Aop6PehW0jNFRXlhj4se+7jv3S6Gw5+gbYBMzc9tuyAccPvKKcUPa
 UzumIFE3SR6N/z/tTMhh8DcebzSo89pZ9gDOhevHnrA5K/NHPEaPNubbsPwzZP7psfCYGFHLC
 rzCAaTcMu6vgs9iGGAnmHnvfDDnz1mUjd6VGh97PqXZR18j4LtC45+URGQuKy8HPBHSKkx+t2
 fQNrwly5kZSx8OJx52tUdLRya1goIKflgUqd7esN1D+PFEVqJGqkavN3DT0zW9bUOcr7/15ry
 /oVSJgbxFBMhTelP891lvrxs5oLiRs+XkmaUYZBVaZjB5s6TpTWRvLyeNrUY0xrXv4m+JWvzq
 tTTT1r4YbUpcg8XPJtZrzEYlGJsDg4wjglaAfxJDH1T4pynbsCgVP+96il3XsKRKzvnudqn0a
 BoBEmwJGwrCo9m/n7DGAvSSvMHRBD5z5gMgbWSzleqYV4R4x4yKEXQsKYwqedeDuLo8TOOhWe
 fXWP7UIyXZjkXTiWOmydeqxkuMkrIr+MeTSoB3+yazOk+9sDRiIaJ0DqEdBl0RTYfljdL5JkE
 h3GM0cNHx4fcQo2+zaeqsagv0XFbAUXw7GEcaVQMxHpqxNSIj7di1+YEK6f4R8jDwLvexbyon
 D66f2s1Fk3zmN50ZwTrvCKyf7NAsLH8SdHX+Wlqj0smkhEtOKFAe0UlqZKsq4PLAJvXNi2O/R
 b4hDus7oWE/iOSb5YusX65b66tgBBFIVqGaC7excUv9xw1E5/2kg0Rn1xIc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the tachometer interrupt to the pwm-fan binding, which is
necessary for RPM support.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
index 49ca5d8..7d09623 100644
--- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
+++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
@@ -8,6 +8,14 @@ Required properties:
 
 Optional properties:
 - fan-supply    : phandle to the regulator that provides power to the fan
+- interrupts      : This contains a single interrupt specifier which
+		    describes the tachometer output of the fan as an
+		    interrupt source. The output signal must generate a
+		    defined number of interrupts per fan revolution, which
+		    require that it must be self resetting edge interrupts.
+		    See interrupt-controller/interrupts.txt for the format.
+- interrupt-ratio : defines the ratio interrupts per fan revolution as an
+		    integer (default is 2 interrupts per revolution)
 
 Example:
 	fan0: pwm-fan {
@@ -38,3 +46,14 @@ Example:
 					};
 			     };
 		};
+
+Example 2:
+	fan0: pwm-fan {
+		fan0: pwm-fan {
+		compatible = "pwm-fan";
+		pwms = <&pwm 0 40000 0>;
+		fan-supply = <&reg_fan>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-ratio = <2>;
+	};
-- 
2.7.4

