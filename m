Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56F9C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70201217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130530;
	bh=e5JF00NP6kwZrzDnP1IWH67GvtYa+pym/AW6SSsYeAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ndEhn1MYXjaT92Balwv6XlMHH/VaRijRsyRQESTWO4n3OMiWOZUW9otjTMYvLU/e/
	 xQBRrmEkS3LbUqoK7SA2q4TYFmkF433y4rnfTn8aacfe1za7ozJmGYdbJ5wHpE0ZJ8
	 dTyPE6jrUec31KIAShqaLHja+kQgbsLs/aywZLBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbfBYVf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:35:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732972AbfBYVfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:35:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6073C21850;
        Mon, 25 Feb 2019 21:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130523;
        bh=e5JF00NP6kwZrzDnP1IWH67GvtYa+pym/AW6SSsYeAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVRItDFsXVilLvdDFCMEA3D2BLYBLTbKyf7ExLWmopKisY/lxq/ErCmmsfo+CjvlZ
         omqz98vRK3LjLKdBh6NTTTZ2NVrHAmk9e6mdVifXI5mJ3lGT3c7BzQ3I2vEgI7VXaR
         Pzk6sFad0a7Cl05kukGuZ8xr4lSb0onu1fdANkG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.20 149/183] clk: at91: fix masterck name
Date:   Mon, 25 Feb 2019 22:12:02 +0100
Message-Id: <20190225195120.112201762@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 65a91e2e597dea62a798a8b771edc44859037e7f upstream.

The master clock is actually named masterck earlier in the driver. Having
"mck" in the parent list means that it can never be selected.

Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
Fixes: a2038077de9a ("clk: at91: add sama5d2 PMC driver")
Fixes: 084b696bb509 ("clk: at91: add sama5d4 pmc driver")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: <stable@vger.kernel.org> # v4.20+
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/at91/at91sam9x5.c |    2 +-
 drivers/clk/at91/sama5d2.c    |    4 ++--
 drivers/clk/at91/sama5d4.c    |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -210,7 +210,7 @@ static void __init at91sam9x5_pmc_setup(
 	parent_names[1] = "mainck";
 	parent_names[2] = "plladivck";
 	parent_names[3] = "utmick";
-	parent_names[4] = "mck";
+	parent_names[4] = "masterck";
 	for (i = 0; i < 2; i++) {
 		char name[6];
 
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -240,7 +240,7 @@ static void __init sama5d2_pmc_setup(str
 	parent_names[1] = "mainck";
 	parent_names[2] = "plladivck";
 	parent_names[3] = "utmick";
-	parent_names[4] = "mck";
+	parent_names[4] = "masterck";
 	for (i = 0; i < 3; i++) {
 		char name[6];
 
@@ -291,7 +291,7 @@ static void __init sama5d2_pmc_setup(str
 	parent_names[1] = "mainck";
 	parent_names[2] = "plladivck";
 	parent_names[3] = "utmick";
-	parent_names[4] = "mck";
+	parent_names[4] = "masterck";
 	parent_names[5] = "audiopll_pmcck";
 	for (i = 0; i < ARRAY_SIZE(sama5d2_gck); i++) {
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -207,7 +207,7 @@ static void __init sama5d4_pmc_setup(str
 	parent_names[1] = "mainck";
 	parent_names[2] = "plladivck";
 	parent_names[3] = "utmick";
-	parent_names[4] = "mck";
+	parent_names[4] = "masterck";
 	for (i = 0; i < 3; i++) {
 		char name[6];
 


