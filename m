Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790A3C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB072064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB072064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeKAKxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:53:43 -0400
Received: from mout.perfora.net ([74.208.4.194]:55997 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeKAKxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:53:42 -0400
Received: from localhost.localdomain.ziswiler.net ([188.155.129.42]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MTQGn-1gA1WM0UC7-00SPSj; Thu, 01 Nov 2018 02:52:45 +0100
Received: from localhost.localdomain.ziswiler.net ([188.155.129.42]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MTQGn-1gA1WM0UC7-00SPSj; Thu, 01 Nov 2018 02:52:45 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 1/3] clk: tegra: get rid of duplicate defines
Date:   Thu,  1 Nov 2018 02:52:28 +0100
Message-Id: <20181101015230.27310-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181101015230.27310-1-marcel@ziswiler.com>
References: <20181101015230.27310-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:3wnizd8A0OqzJ27J54EHPOgL0BJzUY4k5AjZoTTCvBFgV4i91X+
 YHknjiKozGqI5gjaE5K+X2CCwEMOyMQZ28aTQdtKw8gDj2Ox1NXVPw+tg3loiVBdsUXLSon
 BNUJ3AVbCLxWG2etcGpUiuB/ncv4jyenC5YvBlZKm3KopARy5p7zYzICJs0oWOZlntzwf9G
 tM4EA+JUxbjyt7+dqghMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EMQYdtALUoQ=:H3s/EthkZrwCIdJ926409g
 zXae8gsgDlStiRK+9illoDEKv86cx6g6p53bQ7tyOs/r+pvA3k+y7ikyUSAUIwWd2axMJLA6m
 g+I9yDINLh/pC+xpziMmFi4/zuZ2vpPKYZiuQZnzulyN0Vm6fREtGdD9SvP35wTZIQ7C2f/xe
 YwNYHmEzPFazVPLk8d0yhYPbblY1Ib0aRvyHQxDH4Jd/EpQNVUismIscavVADbDhxNaeNoOR2
 MGb74iYkbcIRJiJ9+ijx8mGgnMZMRI7y9hVrOlBO2q+d7N5nBFgHlSqYJjlwqhi/+EogNpBPL
 AkDhhd6qvXmEmIZ3r2VonSrk14gjn0E3tMeCc9D6GR4ZX6tA6/Zl5SiwG4++10JEhHGWxdc3w
 OHCL/aYwT9dmkV8hYpNS/8Wx34K48mJGyNossIMzXtDps/QVWTsoZtmrlsHfBGEsWbaoV9sy8
 zFXyskgdv/tdRZJM7FTbEcr8UOsdF+wjeWSDPrqTLxHtyS+dXtzwc1EIWUUp7M/Ip1DpyIeWZ
 kLLgCfnsCXdzXMbJOGDsSGRazwi9cmnsvmrF9aMP+nhH5Rm5hAweBZPEs2Uiw9oJpf47IAG5X
 bQStMC9igSJUZXvtQf2mgQVFXlOSmpBRf4Qq1oFK8U3u4WcCVpc2k75oliTXbPrRoEpl4CYGD
 S9CiRPnuIvbF/dSPAnfwcqmIIQm9YCKbISibD0tt47mgHg8BIZRIZFjy9bE/Pf9sqPv4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Get rid of 3 duplicate defines.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/clk/tegra/clk-tegra-periph.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
index 38c4eb28c8bf..cc5275ec2c01 100644
--- a/drivers/clk/tegra/clk-tegra-periph.c
+++ b/drivers/clk/tegra/clk-tegra-periph.c
@@ -79,7 +79,6 @@
 #define CLK_SOURCE_3D 0x158
 #define CLK_SOURCE_2D 0x15c
 #define CLK_SOURCE_MPE 0x170
-#define CLK_SOURCE_UARTE 0x1c4
 #define CLK_SOURCE_VI_SENSOR 0x1a8
 #define CLK_SOURCE_VI 0x148
 #define CLK_SOURCE_EPP 0x16c
@@ -117,8 +116,6 @@
 #define CLK_SOURCE_ISP 0x144
 #define CLK_SOURCE_SOR0 0x414
 #define CLK_SOURCE_DPAUX 0x418
-#define CLK_SOURCE_SATA_OOB 0x420
-#define CLK_SOURCE_SATA 0x424
 #define CLK_SOURCE_ENTROPY 0x628
 #define CLK_SOURCE_VI_SENSOR2 0x658
 #define CLK_SOURCE_HDMI_AUDIO 0x668
-- 
2.14.5

