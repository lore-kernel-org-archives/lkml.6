Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5762EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4C020837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4C020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeHaUq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:46:59 -0400
Received: from mout.perfora.net ([74.208.4.194]:39823 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbeHaUq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:46:58 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M8jj0-1g3Qt916XU-00C7FR; Fri, 31 Aug 2018 18:38:31 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 03/34] ARM: tegra: apalis_t30: add local-mac-address property
Date:   Fri, 31 Aug 2018 18:37:45 +0200
Message-Id: <20180831163817.23970-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Ed4KuJYfff1EGI0ZFjwrUCcox/fd/KLL+CyruzLL0VphdchqllS
 N4H+lRTdOIG+ayxwG2Wpni+nNJwO6GAYq/JyvkmuvxKYEZLrYCfS7WzZGc97tboPnldAN4F
 zsTHBVAaKFZBEEAWbyRn80zaJSnXDjWUGX8C1WIpIHw5U2xcsMmu8+tXnHz7iNRQNdygE5m
 CSRLASaZbSweznArxD2yA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3zpbD9AgCKk=:MLP2y6de5nw9ibZSxf/6kG
 7iIjY6aEl53MT+0D6FttS37kCvLnt+pFeEvfaFYzU8rWIzIDD74Bqos/JITlfkpMG5TjFQQVo
 OlxHkERjddWFwbWIwAdIH/HWu+S7pkp0SrzOliG56lqFdt3VKwaY9Mz7dvWaYIFkZq9RwiMAD
 0nNe58ObvkHBMHqKrlDORla4sBFk2rpyIOyhJlK3Wts7xeRyeCVhp/JitwFkwQtbQcLoAU76s
 TWoqAlNrfw2vOvmSmP0vor96LJno00ZCcNl5BcUhGvuiGLiET7QSkxJYHc6zIXxgwUdLyIKvU
 7F4Kun1gAoHRSL6iXHVZB012fRlS8/1kvZW9IPv0KxVVQGDXoSWu/bzbCXSpmhXWx41FiPwT7
 KW1wQDLKFX3TeGSn3k16k8nYxIM0tdHU+LoVMlccI0yBltZiN/Rf5FoCy/aBJSWSnBNxea6uF
 qco/s7khGerxyWHl3GXOR2yk77IUXvsZ5mo722N1ofmF/y1uAIAc475vnbSgNmiONV7ilX6rC
 uQk6SUyH1SwpAEaYsWa7VKW8vwONbdqw2PIc/NzVLXE3KymVTUUi4magSyDXaHnDEJeHIXT6/
 EbgJC0+o5c0dBMAltjwpPsRaQ5wJJxxnox74AzfE/2yuXHurt9D0WvehrxeoaL5PfNxAPxFN/
 nS6PUy3yWxqWLXZY5udwANAal5rlpOyETRyQrKMfk/b2qfV+dvXxni7qzkTeOWkJEDQE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add empty local-mac-address property to be filled in by boot loader
(e.g. U-Boot).

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 69bb11c31d77..f13df31b5e25 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -34,6 +34,10 @@
 
 		pci@3,0 {
 			nvidia,num-lanes = <1>;
+			pcie@0 {
+				reg = <0 0 0 0 0>;
+				local-mac-address = [00 00 00 00 00 00];
+			};
 		};
 	};
 
-- 
2.14.4

