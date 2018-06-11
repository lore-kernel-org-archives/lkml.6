Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id H79XHHNIHlsVFQAAmS7hNA
	; Mon, 11 Jun 2018 10:01:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 055FA607A4; Mon, 11 Jun 2018 10:01:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5748E606FA;
	Mon, 11 Jun 2018 10:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5748E606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932788AbeFKKBu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:01:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:35169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932263AbeFKKBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:01:46 -0400
Received: from [213.128.98.93] ([213.128.98.93]) by
 3c-app-gmx-bs27.server.lan (via HTTP); Mon, 11 Jun 2018 12:01:43 +0200
MIME-Version: 1.0
Message-ID: <trinity-5eab4708-85af-4a10-911f-86b9afc2c0cc-1528711303734@3c-app-gmx-bs27>
From: st6589@public-files.de
To: linux-kernel@vger.kernel.org
Cc: linux-amlogic@lists.infradead.org
Subject: [BUG] Pinning in pinctrl-meson-gxbb.c for uart_C is wrong
Content-Type: multipart/mixed;
 boundary=refeik-b4421615-3be7-45eb-a938-7f1e82e91fd3
Date: Mon, 11 Jun 2018 12:01:43 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:QDs9JIOnupg8cWvj0TovdAFI0KSA1wC8NXSn1j1grlr
 dPYdSgQBYsSobhZgcaTfsacVdCfLCkA9cTWwSr/sMi2aR/jR2l
 pdkFtGtOB/U86e2NSBiqm0eChQZ6BSDrNOM2gASVtEMtLrjgXL
 c2hyKBg0lhO4nmLrja8g91bgyCyu/o73c9R3r6kfA6BoOm+mck
 yJmqWkL9hGxFRXrHGp110I0QAuAYYtAFgDDrzgRzd87ql1qA70
 2OnXDa5Lp+5DKy+SY3dOOLKXSmKSF80fzwKHvBecfnFQRJE+XM Hu9cgk=
X-UI-Out-Filterresults: notjunk:1;V01:K0:pQ1fnFdLSa8=:cwwSmGXHvM2deD0jC1dG01
 4bfbXGFHYD3sDaR6ps60dDiWRmm8YvC6sH0zVt4sC4xNnqGRZnGLKRCjjmfdPIrJD6AXUHonE
 MWKm0GUHXszOWGAciLOYsw/2NziUrRZQzBj80UPa8KFhzMiaMHovpvUnyi6xLx0tyZ3v+1zkZ
 8Wx0IbsQ30UYJg4ZebH38oUk7e422EbS8OSPGJWTVYgDp7lDUDbqkhw1do8X5tAQEEuf+GLcG
 p4lhArryp9441BoJnc5DTlERta5PXrX6HjxUTD5G9ZiobfULeWagY+toqd23wkwuS+eM/3ltW
 SaVQ5y8BfiMl1JEZ+44WPyfmCwkEqiEYxEMFxi04MrIVsAbiMy8QptKeqiy4khHFkmdTOmJ50
 8Ps5mSIzonusm0JpmLUf+tSs0LBT7MlPNy6Jsj4ehcybHpHqXkgStRTwronmcnArDFuPL6E0u
 E5DwElmQur0WqYnE0Vy0b3oRrJbf/kl/Mw3M8WNgx28dss3X24Yj
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--refeik-b4421615-3be7-45eb-a938-7f1e82e91fd3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Hello with the actuel Pinning definition in=C2=A0 pinctrl-meson-gxbb=2Ec f=
or the uart_c
the system crashes when activated=2E The seams to be a depency with mmc dr=
iver for SD cards=2E
=C2=A0
according to the comment here: https://forum=2Eodroid=2Ecom/viewtopic=2Eph=
p?f=3D137&t=3D25373#p177855
the seams to be an error in the amlogic datasheets regarding uart_c
=C2=A0
with the attached patch everything works as it should=2E
=C2=A0
Best regards
=C2=A0
=C2=A0
##
#    https://forum=2Eodroid=2Ecom/viewtopic=2Ephp?f=3D137&t=3D25373#p17785=
5
#
--- linux-next-20180608/drivers/pinctrl/meson/pinctrl-meson-gxbb=2Ec=2Eori=
g 2018-06-09 12:03:58=2E921540445 +0200
+++ linux-next-20180608/drivers/pinctrl/meson/pinctrl-meson-gxbb=2Ec      =
2018-06-10 18:51:52=2E080665271 +0200
@@ -198,8 +198,8 @@
=20
 static const unsigned int uart_tx_c_pins[]     =3D { GPIOY_13 };
 static const unsigned int uart_rx_c_pins[]     =3D { GPIOY_14 };
-static const unsigned int uart_cts_c_pins[]    =3D { GPIOX_11 };
-static const unsigned int uart_rts_c_pins[]    =3D { GPIOX_12 };
+static const unsigned int uart_cts_c_pins[]    =3D { GPIOY_11 };
+static const unsigned int uart_rts_c_pins[]    =3D { GPIOY_12 };
=20
 static const unsigned int i2c_sck_a_pins[]     =3D { GPIODV_25 };
 static const unsigned int i2c_sda_a_pins[]     =3D { GPIODV_24 };
@@ -443,10 +443,10 @@
        GROUP(pwm_f_x,          3,      18),
=20
        /* Bank Y */
-       GROUP(uart_cts_c,       1,      19),
-       GROUP(uart_rts_c,       1,      18),
-       GROUP(uart_tx_c,        1,      17),
-       GROUP(uart_rx_c,        1,      16),
+       GROUP(uart_cts_c,       1,      17),
+       GROUP(uart_rts_c,       1,      16),
+       GROUP(uart_tx_c,        1,      19),
+       GROUP(uart_rx_c,        1,      18),
        GROUP(pwm_a_y,          1,      21),
        GROUP(pwm_f_y,          1,      20),
        GROUP(i2s_out_ch23_y,   1,      5),

--refeik-b4421615-3be7-45eb-a938-7f1e82e91fd3
Content-Type: text/x-patch
Content-Disposition: attachment; filename=my-diff-4.17-uac-pin.diff

##
#    https://forum.odroid.com/viewtopic.php?f=137&t=25373#p177855
#
--- linux-next-20180608/drivers/pinctrl/meson/pinctrl-meson-gxbb.c.orig	2018-06-09 12:03:58.921540445 +0200
+++ linux-next-20180608/drivers/pinctrl/meson/pinctrl-meson-gxbb.c	2018-06-10 18:51:52.080665271 +0200
@@ -198,8 +198,8 @@
 
 static const unsigned int uart_tx_c_pins[]	= { GPIOY_13 };
 static const unsigned int uart_rx_c_pins[]	= { GPIOY_14 };
-static const unsigned int uart_cts_c_pins[]	= { GPIOX_11 };
-static const unsigned int uart_rts_c_pins[]	= { GPIOX_12 };
+static const unsigned int uart_cts_c_pins[]	= { GPIOY_11 };
+static const unsigned int uart_rts_c_pins[]	= { GPIOY_12 };
 
 static const unsigned int i2c_sck_a_pins[]	= { GPIODV_25 };
 static const unsigned int i2c_sda_a_pins[]	= { GPIODV_24 };
@@ -443,10 +443,10 @@
 	GROUP(pwm_f_x,		3,	18),
 
 	/* Bank Y */
-	GROUP(uart_cts_c,	1,	19),
-	GROUP(uart_rts_c,	1,	18),
-	GROUP(uart_tx_c,	1,	17),
-	GROUP(uart_rx_c,	1,	16),
+	GROUP(uart_cts_c,	1,	17),
+	GROUP(uart_rts_c,	1,	16),
+	GROUP(uart_tx_c,	1,	19),
+	GROUP(uart_rx_c,	1,	18),
 	GROUP(pwm_a_y,		1,	21),
 	GROUP(pwm_f_y,		1,	20),
 	GROUP(i2s_out_ch23_y,	1,	5),

--refeik-b4421615-3be7-45eb-a938-7f1e82e91fd3--
