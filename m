Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23869ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD07F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD07F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389176AbeGWNik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:40 -0400
Received: from mout.perfora.net ([74.208.4.197]:48853 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388424AbeGWNii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:38 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LdFWZ-1gPCaB3LUX-00iSyq; Mon, 23 Jul 2018 14:37:31 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 13/26] ARM: tegra: colibri_t30: use proper irq-gpio for stmpe811
Date:   Mon, 23 Jul 2018 14:36:44 +0200
Message-Id: <20180723123658.980-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:vK5OYIzTO+1Pmp0qHbTEXNVeCHRVQdwevMWP8XD5cPiEhqKIznw
 x/oLWJMR0wc1+RHD0dC4sz6avC1RVpOBpYWWEpUET1mhB2RN5WBF5PVoSftSl/uo+tLpnFp
 MUcC9ZFkT4Hro5Q3oS3+PEPQwcT8xqejONkg2HvnGFzt356l38IOdhPMQ4KZ0A65LJMNvjw
 IUgEE2HnqNHM5NH/wMVsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D8uMVRGxUkY=:o8zDiT2S9sux4WpcYHOljL
 Tg9gdEJ9IeGQRM3sCiY1XfArZU8/7fSYKBLuF++mWxgg0aI8cEi4r+M7vrlyUOv3VH+qNC0yw
 y5vZPG6uCcT6Wb8w9Jo+a01QsDNka45179UfgvFaqfyIl6Yi7xCqagAbW+lj5l1u+OxMcFOcB
 Lv8xp3tK38FZbCEBlDCtfL5Mrqc+IE7lRJcTYlrH2q/VWHw1T6PhKvdcUdAlTkMhuZNM48v72
 MHIs8GIYxf+QdrqMndAeZUaYtWimRHhAYuhsqhCH7gtXToXCyedBm93COdLDZ2G0beQR7XdSs
 TMAYg2QG5LeMrjJ9fJEtCub+qcrdbtrx67/rsxnHvxPtoFK5CgV7tm6ps8MC4HFXQBs4F24OR
 Gt+Hz9ulr90rT2wBuvzHfavn/m2+vVyo/90HiaE+4DB7NHxkLXzHPt/TcMGlKgcym7aqiHmqR
 CL4xhTpgkIEnohd74kLhfZ/BtLQAD484rpR7MyOVIm7DmHrTVaZUaBXUi+Xg6+cI4Nt98u7lL
 Dlb0DKS6lEJui+1RJ0WWgsly2bOKZNgYK0+YapIaLJ4l0WvlL/z/LLHciepDrbmUTy/mwg5qe
 +vfaE5C/+IYhurYlcPkLs1V5HSPPKbF5KomoeciEVHG+amJI6LsBkPVOF4xjQxt2MSV08KTl/
 IipeyxITEu8eLVhkoDQksauNQ0qAUHDbqD2GzrCLXUt6q5NCuaikc/bVB2Y6bdP9Yl4o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Use proper irq-gpio for stmpe811 touch controller.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index c80b9bf44752..ace72a53186a 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -836,8 +836,7 @@
 		stmpe811@41 {
 			compatible = "st,stmpe811";
 			reg = <0x41>;
-			interrupts = <TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
-			interrupt-parent = <&gpio>;
+			irq-gpio = <&gpio TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
 			id = <0>;
 			blocks = <0x5>;
-- 
2.14.4

