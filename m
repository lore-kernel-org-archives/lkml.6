Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F407C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D2220874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D2220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbeGVRrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:37 -0400
Received: from mout.perfora.net ([74.208.4.197]:43815 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730090AbeGVRrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:37 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M3TZW-1fyoNS2YU4-00r46J; Sun, 22 Jul 2018 18:50:15 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 15/28] ARM: tegra: apalis_t30: move dr_mode property from phy to controller
Date:   Sun, 22 Jul 2018 18:49:23 +0200
Message-Id: <20180722164936.20581-16-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:lqJCUBkBjcBkUpc9KIOGKuFbaMsK6E17y1Jlb7Zxiy77Fm4uZrI
 Q25XwM/TRjRS6xkXq9lGdV3uvu8S7FjSn4ZnoRx6tejII3KsiU998H8b8U0cfrt7saktyFV
 abUB+7VqE7nUO8GHc87XDTHcejytVZV0C52n5i/L9l/tI8vz6wZR/v+xOsF7SPznsx+mUqI
 IrkW8s91QBcy3EEMKsN5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I+ZCsUNK+2Y=:/FjYp7HBr609g+TWpZUa8E
 2ckugEjBxaFGH5X4g6bCme8D7eOqqx8jhAkrXVD/dnDDhGEOZSnA5Z0O/AnDOnvl+iXIxmyCi
 8zeP+nUa7y9a2uXsAbnL92jFRv3b72ZXmDVCI1Sax9G4jEKYwSjjdAqg7PrA9bg28SNvsn+mi
 M+kshTqBKqvl06geQEEP6YJpNC2PAAv7KPsIcJ4ccwdIN9P1yq+64mD9l32Pyaj83+RQmiyOP
 twhM2EdIWrEgJyEgYxfIpNgmQXOyRI2uTAybeivpDwWrvJEWWiaYz0GT/8O13iY1gZon1kpTk
 HfjuhuocKyD98kTEzBEWiR1reAtjIL4nWalbJliCzBNy6nVtou8WV3stVWSFoac1pnmVKv6H5
 QhiVtTMGV87qyFz5tUXLoUzPIDGfUvDF2vqhuZgu3KAujlJXW+vPqUVkHl4FKpIei7cPNn3fS
 WVVyNvdj6sIYJdjXMdcmiICnnSneinKMZloxG4GZP4d6Phy4xNy4rFcgEIgiLrgc3HYcsPjnO
 CHcXH483OFDQIBSpYKj8+qYNlUdxhWMB0M+hxPO+RgK1eIC6VSqzQZI0Hbt/RYLODULQD/LmH
 pr/Cq5KRmS+QcqH/Qgvwd0w58LJqU5CV7gihrBMnujsNo7jpKVKfRWq28qe3xlXv9LFtdIfqo
 dtHdybZr2/CdVLWsPWWHe9OW7ekOImyQZ5IS5fPjZtO0SQK+OHGXV56hwA5sGZvPQWkk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Move dr_mode property from USB PHY node to controller.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index a1ae4c3ee39c..4bb571bffc7f 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -163,11 +163,11 @@
 	/* EHCI instance 0: USB1_DP/N -> USBO1_DP/N */
 	usb@7d000000 {
 		status = "okay";
+		dr_mode = "otg";
 	};
 
 	usb-phy@7d000000 {
 		status = "okay";
-		dr_mode = "otg";
 		vbus-supply = <&reg_usbo1_vbus>;
 	};
 
-- 
2.14.4

