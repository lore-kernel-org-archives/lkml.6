Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B74CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068FE2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfBVNqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:46:39 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:56607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfBVNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:46:37 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.42.136]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mf0Jg-1hXrk41Kx8-00ga7M; Fri, 22 Feb 2019 14:46:06 +0100
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
Subject: [PATCH V3 1/2] dt-bindings: hwmon: Add optional regulator support to pwm-fan
Date:   Fri, 22 Feb 2019 14:45:23 +0100
Message-Id: <1550843124-10992-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550843124-10992-1-git-send-email-stefan.wahren@i2se.com>
References: <1550843124-10992-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:8sNvvteVhASqzHNQ09B0UGT5Fzlm4HOrt4iUbWxSNJsvuv+CYVs
 1PLP3q9ddTYVVrcCYQUw/9ajTVv7fxilVuxEo50PY6NxrL5s/7QPduQc/dHN7+gq2k1JPLd
 SYWqVoG265N9Qvsq+yK2587rQk7rXMefmym43sm3mDD8LeioBbxqqB+DCt/VBBCVYT7HMIE
 19dZzT4JS5kjG/Qv9Wc1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DxeKGqHloeE=:FOgaO9BRlNdIYU6uVfayzl
 KqpzRa8F9Slu4e3ssoVOHnsOd9sOJwXIH1wf6YOQpuAy1TYlhYmEri3IZQDIRjEWHRDcenkVB
 AQVLWiz/4aqK8hS7goawO4J8aqDOwo6x7q6f1IIrTTG4+Zkw/khRotoIQc43klRGs+FxtUWuT
 iiOAsDGovMT040f847HgGgp7DRaDbCSE56yaVKKo8+oUi+hbqVvfPmb30WQbIfrJ0DFekuLjE
 ZnIOnOv+i97X4nZSOCrzrYe9S/rl7o9E2rKwlyZE5g7yk6V+Qw0AfsUaV04hV9+jxPUFi+VzB
 l5g9lhQf8DACO5GGn8d169wkm2ofBrzBmdNVDo2E7LvPNmZbc1pHMUQ8M5AGhw8hqm9eAkQ3u
 fEGuvsJoIWc96PUlFPjcTBxs9ASckHzkEINzIzStBXdlhZ2oTLuE48zqCa6kUtMr7NDTZXw82
 mOt3TWikQUbze5/ORXYyC35Fhja2qT1nzM8ejgpP9vnSLlrGPAYfqM/ujcm8j03BbVj2BdTQO
 T2lCuX4XFX+Su0k40jqfK7MeoFYvywLkDnfUNxTnSutPUh2IBZPt9NTb1ciB+2oIyYw87aJLo
 c7DtX7dH6LtSIQ5Cb93V48o7p4/goIDyarRBfw9M7VCfOXo1m5FRPtgfviUdclQmcxRYENTSV
 chmmCUopmb6iKsp63Wknc/GGKu1jBF8PHcACAKPWq48D5rv3xGxTgO0+G5EceYaBIqayfLT+D
 QfhS/2BDAWW0uK4zEbrghEr9vI/dbceO4A6N1ZtSC7qzR9HeaBePencil0Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an optional regulator support (e.g. switchable supply) to the
pwm fan binding.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
index c6d5332..49ca5d8 100644
--- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
+++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
@@ -6,6 +6,9 @@ Required properties:
 - cooling-levels      : PWM duty cycle values in a range from 0 to 255
 			which correspond to thermal cooling states
 
+Optional properties:
+- fan-supply    : phandle to the regulator that provides power to the fan
+
 Example:
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
-- 
2.7.4

