Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5554C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A7920841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A7920841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeIBOZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:24 -0400
Received: from mout.perfora.net ([74.208.4.197]:51001 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbeIBOZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:22 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lh4nx-1faUMa3js7-00oNB6; Sun, 02 Sep 2018 12:10:00 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 23/37] ARM: tegra: colibri_t20: add i2c-thermtrip
Date:   Sun,  2 Sep 2018 12:08:52 +0200
Message-Id: <20180902100906.25792-24-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:8a0DfnnhncQtYXHOAUEVzvEx0srnhqeLtb4IRhBl03efhqlsLf2
 3fqtyRLunrH3eMgKAoKMYzeIjR+Vld4OxMbaDFthMIidL+Si+mZTySCdjfYn8N9IVd4YdX5
 SxuXAY5Cp9Z3N8ON5TfctBOuNV3qThK1+ID3P3q1qrbTibdVqf5AREAUI58lLdU6gBazj3o
 6z+I57sYRNTT234vhm24A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z2UhjTbSavs=:Kokyf8CN54X4r8Ug7XkzKA
 BIBdVIdIv+osW51aSiclGclep/4awqxUQ6mtES+2kBRIr6WzsrDFZtDImYCCb9w4R0OAlsbrt
 w5YZnqT5ulIMKVS2qYOibGbfxuDnB/bytv/zayrnpAQd7CBUShCxipVmurhy3MHs2oBZyusvn
 JKAJr1fA6kOz6nkJWaWo+cPUrg1tlSniVKJvH+FhtfItaQKtOJo1aTQEoLTdPHRdfbgFrS9qU
 xcG1Yu7RhooTvDosH/726NAfdeyVZJb/J1S/pYfkcfkt1bB/8CXQ08w1p0KDxLoBHcDDVYmC7
 QitgrTgbfnTjLtLnN8rtjFr2Z8MdZcGEYQlZRUmK+XGAb2/pc+uzX7tyMDbymuLKVLYsTEZY3
 hJ4U4VIqKFSnmZTfCjrZ1uuT8DR+Apcz3CWbDjdW6demd0qJTmi/P6wIM/VmOAMq2PAIFP2KM
 tNeM4rZPxM0JwQJtBugh9MyIk3STW4IOWqKw6Ub4Jv2ENFp1K43Exu+52AdOT7UmEV+x6pjxz
 EX48yecHK7r6xHD9W7y7hpqmkaNjCan4X1NXUpzdd+38NWSgpSyJdI6OBEncgPnfVDhHRcUWp
 7Q3ARiiYl6k+F5l5vW1ZFLbFkxRfsacJCBbEtLMKpyqwJkLQr9ZKTWIFMTr4RNZF4Xg4dGtPj
 u20/AWknmqv5arRcAOke/liWBAAnlZ14UyLpbDdg5FpNWdirLPFiEHXIjf4yEkQYV2Zc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add i2c-thermtrip which would set the SLEEP MODE bit in the SUPPLYENE
register of the TPS658643 PMIC.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 477d67ff74c6..9ec56f49c30c 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -598,6 +598,14 @@
 		nvidia,core-pwr-good-time = <3845 3845>;
 		nvidia,core-pwr-off-time = <3875>;
 		nvidia,sys-clock-req-active-high;
+
+		/* Set SLEEP MODE bit in SUPPLYENE register of TPS658643 PMIC */
+		i2c-thermtrip {
+			nvidia,i2c-controller-id = <3>;
+			nvidia,bus-addr = <0x34>;
+			nvidia,reg-addr = <0x14>;
+			nvidia,reg-data = <0x8>;
+		};
 	};
 
 	memory-controller@7000f400 {
-- 
2.14.4

