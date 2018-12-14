Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44B7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0DE206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeLNWNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:13:09 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:59973 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731080AbeLNWNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:13:08 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mfpf7-1h5LiI28Eb-00gJOG; Fri, 14 Dec 2018 23:13:03 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] [stable-4.19] ARM: dts: qcom-apq8064-arrow-sd-600eval fix graph_endpoint warning
Date:   Fri, 14 Dec 2018 23:10:11 +0100
Message-Id: <20181214221023.3878670-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214221023.3878670-1-arnd@arndb.de>
References: <20181214221023.3878670-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KbACA6/3U53+ACqtW59YxeL4+uMSy2Mau8CF1ky/1ylYMLnBRgQ
 RG+597tzFnANXmGMz21Vk45InUenU+DvQjuRawYtoS0Nb4RvCY184tWfHEXsUHo3fYaggRj
 YrBVyPYZlxMp5ib8d+UXrISrnrwrzesg4htMlFKh0cRpL1e1S/JOFBGfNs6+3E+eDptl0f8
 1bmB9r1ihHuhqRo21/ahw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b2k+iAtcjDk=:zYd6YHKj228Rk7HkDt3aAu
 uKZQ5t8bN9puyZKRYrsR9IpNs9dRLvAMbgTztYML2uaPqntCgGZbJu7MHhqEEMZ3L/WFyHkVV
 eb0RwkzI1WtvzwhT4Lp1zpLAgH/ksejGv48gHqMJvMEpMBJ03JH7EQn+lFFsf/rCeb/Gte8H1
 SZXp0yvWBKthugSoFbFMLUVLC5c9C3p/EKz3KRQoxuKdy7L060ERJe37YDaleA7u1fbmmxhxo
 MMFBks7894nRLVW4tuUSO/8VWXgRG0ZQpAikTLRJ56mWOEECA4KkI+3z/MrtTBWOjMzqIfZuP
 0rwqvJdu/EOFWJuWa/Q8+mqeth/YEPMU0yYrMe2A3gNJyoPCmLOgoyMmzBKn0fm2B9j0uBEwA
 g27W/jBusOOO4Jsvui8L1Zmj+2ZFn2cQG8w81p24P9d2qww4jupdLOQami/LPRbM1AeJAny4M
 doTY0G+dSZ4FysB6kWf0kKflrHlFgHpsue2cVQqzPtKYrFJk8tUfkXdH++A6MKTuZnIl1lrRG
 yJGaMe8H5qHLUgIjsU9rmoHLr2cWDN5l6oB8uhvNBBijTIBKQQVJLs8ihgtwcECSknRQvsYUG
 GK0OA0L2eqGXBfE//pKX8eygM+aG+9IX88H4bDTjDo+2bqPBf+mcmXnSXnin94Tcmba28RFWp
 pQwBRphBEpKGshY95mglrTJb6WKo5y+ip3be2h8tKlhlbUgS5yfBV6uK+Lyz+RDrty5dFDvCC
 VzTy0G5joVzKov4Wco8PdeUJTlntPRstQPry/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upstream commit 972910948fb6 ("ARM: dts: qcom: Remove Arrow SD600
eval board") removed this file because there are no known users,
but in linux-4.19.y, we still get a compile-time warnign for it:

arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dtb: Warning (graph_endpoint): /soc/mdp@5100000/ports/port@3/endpoint: graph connection to node '/soc/hdmi-tx@4a00000/ports/port@0/endpoint' is not bidirectional

Address the warning by adding the remote endpoint that makes the link
bidirectional. This is the same property that other boards use.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
index 76b56eafaab9..f714a20649d7 100644
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
@@ -387,6 +387,11 @@
 			hpd-gpio = <&tlmm_pinmux 72 GPIO_ACTIVE_HIGH>;
 
 			ports {
+				port@0 {
+					endpoint {
+						remote-endpoint = <&mdp_dtv_out>;
+					};
+				};
 				port@1 {
 					endpoint {
 						remote-endpoint = <&hdmi_con>;
-- 
2.20.0

