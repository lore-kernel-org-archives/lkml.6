Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02355C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBBE2064A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1lmt8rU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBBE2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbeJEX1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbeJEXNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:13:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC0521477;
        Fri,  5 Oct 2018 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756069;
        bh=Jc8TuVBiCg7DJvg6GQhqFM9x77mjpf3bXj1OqsXImDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1lmt8rU5CyxA2G95G9agYRVA628MJMY2YdVQbmFVDehmRvMe/0ClTMUUiDBC+1UOs
         s8RmNhtt+15rzExLW/1FbgLg7L1smhckz1SgRkC+sPSkAgy8+qwHbbiegINFWKmB/v
         ZXJxDf7TpFELtlBfbGO5mbsxTMG+1fWFcL/ellew=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 03/48] ASoC: rt5514: Fix the issue of the delay volume applied again
Date:   Fri,  5 Oct 2018 12:13:39 -0400
Message-Id: <20181005161424.20521-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oder Chiou <oder_chiou@realtek.com>

[ Upstream commit 6f0a256253f48095ba2e5bcdfbed41f21643c105 ]

After our evaluation, we need to modify the default values to make sure
the volume applied immediately.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/rt5514.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index dca82dd6e3bf..32fe76c3134a 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -64,8 +64,8 @@ static const struct reg_sequence rt5514_patch[] = {
 	{RT5514_ANA_CTRL_LDO10,		0x00028604},
 	{RT5514_ANA_CTRL_ADCFED,	0x00000800},
 	{RT5514_ASRC_IN_CTRL1,		0x00000003},
-	{RT5514_DOWNFILTER0_CTRL3,	0x10000352},
-	{RT5514_DOWNFILTER1_CTRL3,	0x10000352},
+	{RT5514_DOWNFILTER0_CTRL3,	0x10000342},
+	{RT5514_DOWNFILTER1_CTRL3,	0x10000342},
 };
 
 static const struct reg_default rt5514_reg[] = {
@@ -92,10 +92,10 @@ static const struct reg_default rt5514_reg[] = {
 	{RT5514_ASRC_IN_CTRL1,		0x00000003},
 	{RT5514_DOWNFILTER0_CTRL1,	0x00020c2f},
 	{RT5514_DOWNFILTER0_CTRL2,	0x00020c2f},
-	{RT5514_DOWNFILTER0_CTRL3,	0x10000352},
+	{RT5514_DOWNFILTER0_CTRL3,	0x10000342},
 	{RT5514_DOWNFILTER1_CTRL1,	0x00020c2f},
 	{RT5514_DOWNFILTER1_CTRL2,	0x00020c2f},
-	{RT5514_DOWNFILTER1_CTRL3,	0x10000352},
+	{RT5514_DOWNFILTER1_CTRL3,	0x10000342},
 	{RT5514_ANA_CTRL_LDO10,		0x00028604},
 	{RT5514_ANA_CTRL_LDO18_16,	0x02000345},
 	{RT5514_ANA_CTRL_ADC12,		0x0000a2a8},
-- 
2.17.1

