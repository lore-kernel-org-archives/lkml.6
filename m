Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A50C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618C4218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="VUg5sYN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfAXKCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:02:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47000 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbfAXKCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:02:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so2718977pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 02:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yyY/2SJ7Gw5sEF17rhF96naHVX/h9JYpa4bfCxkImQM=;
        b=VUg5sYN2QB1YOit6oHgqH3PRg07lOpUAYf7GxgRH5SULeO1QFdPvNXw7xdNiwPR5F4
         AoegvQuXIBvVIeCWZS6xRuiY+uL3zYkU8ioDqPPmgNpW1+PnE332noua8rn+zHTFWabF
         5K3rokfkNNNcjzc9BD0Y+np+LZ3UgAkQjLVS0y1xWTIVozo+zESM6cYMj54v1f4uyhnG
         p3hAtqmU52T1x0boQRyiWMjqaxoU3rxMZuMTBFiU/8AbLXU20e4siPhx0rjiJLT9vk4i
         x5i3DO5WD89g2lgJ4TnaoaNQ4M4lfKwCN2O04K3x1TRx25hCGQ942w4o26vdh2RrHpfJ
         d0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yyY/2SJ7Gw5sEF17rhF96naHVX/h9JYpa4bfCxkImQM=;
        b=MEQG1+C0SC5MPCdz33+NWzlGXvkNOI0DwK9zDT2Ro12yGa+xNB/nHC0LBwWKd8X+DU
         29r8iwJQdawFSKZlSr/k+0lo3juYnpwlp3YaJvaydWXn0pEnLvgWc2Xtv2vFFJJcyKP6
         60saRmGOFLeeBCITQcw1J0obtp6WoUJa8OQrKFOMv6I+60ixRT0KiypECyDS30V0vvNX
         kNMtkuy5zYOQod1wKisE9haafrqbl1SeiJ933NHjGkLp6/GEg6VWFRcjwuIsNJ2GsSSU
         75EX4EE4mlZz4JWg54h2Lz/5CtLEE5TMnU5rpUhdyw4L3/lHtPkRhEHA+x1Qc4jhw5XU
         peyQ==
X-Gm-Message-State: AJcUukeO1eYUvC0WFHiEAwxpimDAsti22jZM/NcPP5q6vPITVM+otNpA
        sA8zliHhsziCJPFiGWx0D5PXdt2VrjQ=
X-Google-Smtp-Source: ALg8bN6GpMzCYD8WxHwr5WJialTae52qlMpoftNJH9WAxPcagoOVoX2bydfESCd3dxsq5elL+MfMZQ==
X-Received: by 2002:a63:1c61:: with SMTP id c33mr5194897pgm.354.1548324150652;
        Thu, 24 Jan 2019 02:02:30 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id h15sm24968523pgl.43.2019.01.24.02.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 02:02:29 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] regulator: bd9571mwv: Constify regulator_ops
Date:   Thu, 24 Jan 2019 18:02:09 +0800
Message-Id: <20190124100209.12275-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190124100209.12275-1-axel.lin@ingics.com>
References: <20190124100209.12275-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd9571mwv-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index e12dd1f750f3..e690c2ce5b3c 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -100,7 +100,7 @@ static int bd9571mwv_reg_set_voltage_sel_regmap(struct regulator_dev *rdev,
 }
 
 /* Operations permitted on AVS voltage regulator */
-static struct regulator_ops avs_ops = {
+static const struct regulator_ops avs_ops = {
 	.set_voltage_sel	= bd9571mwv_avs_set_voltage_sel_regmap,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= bd9571mwv_avs_get_voltage_sel_regmap,
@@ -108,7 +108,7 @@ static struct regulator_ops avs_ops = {
 };
 
 /* Operations permitted on voltage regulators */
-static struct regulator_ops reg_ops = {
+static const struct regulator_ops reg_ops = {
 	.set_voltage_sel	= bd9571mwv_reg_set_voltage_sel_regmap,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -116,13 +116,13 @@ static struct regulator_ops reg_ops = {
 };
 
 /* Operations permitted on voltage monitors */
-static struct regulator_ops vid_ops = {
+static const struct regulator_ops vid_ops = {
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
 };
 
-static struct regulator_desc regulators[] = {
+static const struct regulator_desc regulators[] = {
 	BD9571MWV_REG("VD09", "vd09", VD09, avs_ops, 0, 0x7f,
 		      0x80, 600000, 10000, 0x3c),
 	BD9571MWV_REG("VD18", "vd18", VD18, vid_ops, BD9571MWV_VD18_VID, 0xf,
-- 
2.17.1

