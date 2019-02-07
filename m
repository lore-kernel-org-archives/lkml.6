Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DBEC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFD82173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfBGQjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:39:06 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:35289 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGQjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:39:06 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.54.161]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N6c0W-1hB6Zh03rS-0180L1; Thu, 07 Feb 2019 17:38:35 +0100
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
Subject: [PATCH V2 1/2] dt-bindings: hwmon: Add optional regulator support to pwm-fan
Date:   Thu,  7 Feb 2019 17:37:59 +0100
Message-Id: <1549557480-14436-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549557480-14436-1-git-send-email-stefan.wahren@i2se.com>
References: <1549557480-14436-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:9SE9Scaz/eUPndRGn/nsIoE0MCcvkmpj7I6FmAxL1U5R9M2kbdQ
 cPpvoRKdvTEPSZTtR3gg9sUwDSlJoDrnq8hdDZNHvy6aEWh97zCC4xPaQiY62+SPvVrK8Nh
 SOlZgIMzZq0xhC/QhEsRKqwShATwMp94C2I9C4+tTtAMMghWF4WIUnmX9oWwtMZn8LVPZBW
 nez3U5jJaj6vZ8FLa7Iwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8T6IrMmgIOo=:gbTUXbWMLVDBggkTMwBpzD
 Uoi0lgythT3MI8mJXt0ICaKUd2/zI0UwA6fCnJjm+CYo8YyfL1tUQTmNyYAbyA5JMMdWC1zCy
 p0o7nMUsoWWo8sXMUYXOuvNnbjPhdkfy76nRvFYT+U3VDRp1v+BuO+x+xvuoAt6dAPYuC9ff1
 nC4nehOsT3N+LUrZVFNgegq9ruW5vTrdHloOGPQVz1Aj6FFIUzvnrpSfDPTrKzgkZstIPLlHI
 iSgxFCuqFMIDm+7t6gsZwqMuMklTzaC9MPRkmB5tPO+v4B28X9WnEn3r7lYsmHG7VBm9pdZXH
 p/uQeXZA/lZIjXNj0uZIsxzhdJ+oUbpyUDpqdbhrTIh3TmOeay3bev2lV8iL6yO0KBRWV4Jgr
 FU/42lYcpLgEi96RWGXRZdWDpjZl9bjAb1bJ9C0+v/3NHoDKr9wOOO/zD752VVVP7zoxgFrGF
 JU9OiXgdxVBsB9Gp54+WfydLjypIQ0BJvBL/tcUVIDSu8ddVldmGBi2US38SvjKAeHu+1cKD/
 p0KAZ1FvfwI13l5UpK9VOuPb28s/a+9f7RmsqVfkoax5Qylep90R/JWsV5q5OZpgJlHZychKT
 F0wXnfJsPgRVsTrEP142HKlriNAKuQbY4EvSSX0ZH5eJFgaoA7kp0yPFrhlRenPhgkrIW1vJ3
 QkHs4T3+Q9GWCdbEGJWD3WZTd+KigLd1ROOHvXUlW+EzPHzZQAGCp1xviFwCkqEuw+ZmZUnKB
 uT1nmroL11nvLuWRzmGnRobOYfG3NKXEO/Y4inF/e0yH30nwSU6/wURW51A=
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

