Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F4FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B51B2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfA2RIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:08:17 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:51995 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfA2RIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:08:16 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.39.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M5x9B-1gnALE0v0t-007Xu1; Tue, 29 Jan 2019 18:07:43 +0100
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
Subject: [PATCH 1/2] dt-bindings: hwmon: Add optional regulator support to pwm-fan
Date:   Tue, 29 Jan 2019 18:07:10 +0100
Message-Id: <1548781631-5736-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:D/bGLsupV5b3r63zoGfpZB1y0bOiKeGDqVzBjDV0gy2hqzd+ah0
 fvueiSueUgEb1LSX60VPGb3mgA15bxlMsQUrScDOGMHhDlZo/ab4+QJeKqfY1Ac+A4yTeEn
 ecDTs1aoqKJMc+xMlnfJmhgNS6iivusDX0LeAtBm6dRx9dzhR0LWa8rGgi4dLJUV29pmQJb
 JEhkkCnYGy6HhhjutJH3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:82/bbI+oG1s=:TsaAgi9gHreV0Srl4l5hit
 BQGl+wkm8Ss2g/6tsq1J/6BgoyX5hqnyUH7HQU9JOKjuhOG3bARBviLEmHPn4vupqllvIWEyI
 lfivJPXeycm9NivLTugScUgnPB6HEMhYpfbZh3pLCaUeSEYYAefm08VRnuueEXseo7SaB4+pi
 iBq5qIo/VPEgGQeZMvLwehSikBveLaS5kCQUbfJ5pRLBg/vkIvhTYfz6TKhzMoGhhyGsghc23
 dxdQXAbx5yQ5LWG1XHy4w7QsrvuHxuQJxAo1f14wMfsjf6/kDz03X8E1LSj3zF86fXYZPSExJ
 kIDIUckeX9tUCJeuirUb53qlq2oZLpCPlYKLnVQHXp9tDTOdVgAP9V2A9cOwlNy2dQLlhuIDt
 +p6+oR+n7BrKza9iQpgNhw+C5ogpIKQyj4rbtt73f45xk0qoLlcyq2tJBsbsIvN9io5cqQ5G+
 LnNkbgmCt/PDaUlmT3fByUdR9bWOlutja0nqganvZev1eTE9WIqSfnJUjCSw6k+nEg1FtpM83
 dwjc7W3uUr6wC+VfHVC8oODjs/A6RJ7opK+WZQ65zXdVsy+AMIJMc5kfDdtlKh0HEyOHke1LU
 ewBGJrhMEtipvquezRlt2EqBESg0DonL8EB5ZA2/hsbKeJREJcmhqF2ASrdXYPU8nX5SRpFLl
 8TYn6pHQIiqrO3UUfLzNOaMJlK0nxXXoMkKBxaZ9qMdK6Nh6pf2FZTJVVzLQS6Ye3vU51rQsc
 BBo3dfXWIXMSuXAgxEHqMUUOzgpJbRjwL+Z9pfK0otrXipa3TjASabW8KcA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an optional regulator support (e.g. switchable supply) to the
pwm fan binding.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
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

