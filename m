Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C53C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480EE214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480EE214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbeHNMEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:04:46 -0400
Received: from mout.perfora.net ([74.208.4.196]:51107 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbeHNMEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:04:46 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LxdxF-1fvloe45X9-017EOD; Tue, 14 Aug 2018 11:18:12 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>, Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH v2] clk: tegra: probe deferral error reporting
Date:   Tue, 14 Aug 2018 11:18:05 +0200
Message-Id: <20180814091805.1363-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:leenUwfY9zhx3LVhmjRRrp/MfI2wtTLbSrxBmwWW/rP8KfUahMt
 tQZNiI6j2J0Jpe//yiJDCQO/iYWucnAm2xO7lcEeFMClmgGhML6RDFNIOKbtSkBBV6S6Seh
 leMt4JOw6inGaOyyNQHftYkvf9c2hrtigpn1L/5gYHlua8Dk8O9WsfSIBsE5C0zoyzJoA0J
 hkQi44Cje3+45BOELY85w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QUqMc7+8G4M=:apF1MNPIQLA9uAFFUsLW/4
 kehhrh9TJYgG72q/9EMCFZKRqIbxJehqfVkTgTMdlErbH8wD5mHrNe4jGdl433pCdYPvjz8vG
 5gjive/oNou17TWw7KsBS5PrzFETP+RmefLRxQtGJ5wdTOSfXx3G/45QpSQJMKMmxGtZvXNc0
 7Kuvbz7EuNRbsQ7GUQvik2cVPepYW6rp4asg14v8rltp0jjxuvGsrvpxhdgbDKkAmTxWQzfWz
 7iEsXWS2ojwgDX31NbG/uCcd+iVLlThyK8FugVe8592ogl8+9s/ROwt0L42sFeZT6eT+sy2zF
 Z9F2lzvsz5SxocgO5glSzmwc8Id1CNFy7mmPjEwaIq6opD+rZeh3+d/M+wo7MqbAjK6iCZhvt
 WKQgNpkOCerD3uj6xSKO0wxMXCnkgdWDUdYHQCAyAdA7WoEWieUluNkyAFwVeh5FC8iLbDUkf
 dkwJSoegl3swRqymvzB/Y7Dj0oPrDNzXheO6wwAYBDjM7gv/jJq0ciUhEAjXyIci+vN+g4ZrC
 +sMYyrNXqTApIhmM3+S6UcIL3U/Iwj4VElmIfM95fAu9fDBnTLWqBo6kpg+SfN6CAjABerSu+
 aDnvh8VppAfcSQVM0xzsUbgoj1d5GogSzbNTyQjoIVzMJtRSANoi9NbZb2tvFfezOI/c0frvZ
 dqi4ZPT1t7HkybSHR6mO1jMcupaGLJSGsYnn28uD0vi6Xs9jenuI1jWDwbFC+i4UqwW4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Actually report the error code from devm_regulator_get() which may as
well just be a probe deferral.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Silence probe deferral as discussed between Peter, Stefan and Stephen.
- Fix line over 80 characters as reported by checkpatch.

 drivers/clk/tegra/clk-dfll.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index 48ee43734e05..ebb0e1b6bf01 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -1609,8 +1609,12 @@ int tegra_dfll_register(struct platform_device *pdev,
 
 	td->vdd_reg = devm_regulator_get(td->dev, "vdd-cpu");
 	if (IS_ERR(td->vdd_reg)) {
-		dev_err(td->dev, "couldn't get vdd_cpu regulator\n");
-		return PTR_ERR(td->vdd_reg);
+		ret = PTR_ERR(td->vdd_reg);
+		if (ret != -EPROBE_DEFER)
+			dev_err(td->dev, "couldn't get vdd_cpu regulator: %d\n",
+				ret);
+
+		return ret;
 	}
 
 	td->dvco_rst = devm_reset_control_get(td->dev, "dvco");
-- 
2.14.4

