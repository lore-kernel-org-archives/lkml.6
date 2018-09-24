Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADE5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E8221486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E8221486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387931AbeIXScq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:32:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57866 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbeIXScp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:32:45 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EAB0A1099;
        Mon, 24 Sep 2018 12:30:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 068/235] ASoC: rt5514: Fix the issue of the delay volume applied
Date:   Mon, 24 Sep 2018 13:50:54 +0200
Message-Id: <20180924113112.057409261@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oder Chiou <oder_chiou@realtek.com>

[ Upstream commit d96f8bd28cd0bae3e6702ae90df593628ef6906f ]

The patch fixes the issue of the delay volume applied.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/rt5514.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -64,8 +64,8 @@ static const struct reg_sequence rt5514_
 	{RT5514_ANA_CTRL_LDO10,		0x00028604},
 	{RT5514_ANA_CTRL_ADCFED,	0x00000800},
 	{RT5514_ASRC_IN_CTRL1,		0x00000003},
-	{RT5514_DOWNFILTER0_CTRL3,	0x10000362},
-	{RT5514_DOWNFILTER1_CTRL3,	0x10000362},
+	{RT5514_DOWNFILTER0_CTRL3,	0x10000352},
+	{RT5514_DOWNFILTER1_CTRL3,	0x10000352},
 };
 
 static const struct reg_default rt5514_reg[] = {
@@ -92,10 +92,10 @@ static const struct reg_default rt5514_r
 	{RT5514_ASRC_IN_CTRL1,		0x00000003},
 	{RT5514_DOWNFILTER0_CTRL1,	0x00020c2f},
 	{RT5514_DOWNFILTER0_CTRL2,	0x00020c2f},
-	{RT5514_DOWNFILTER0_CTRL3,	0x10000362},
+	{RT5514_DOWNFILTER0_CTRL3,	0x10000352},
 	{RT5514_DOWNFILTER1_CTRL1,	0x00020c2f},
 	{RT5514_DOWNFILTER1_CTRL2,	0x00020c2f},
-	{RT5514_DOWNFILTER1_CTRL3,	0x10000362},
+	{RT5514_DOWNFILTER1_CTRL3,	0x10000352},
 	{RT5514_ANA_CTRL_LDO10,		0x00028604},
 	{RT5514_ANA_CTRL_LDO18_16,	0x02000345},
 	{RT5514_ANA_CTRL_ADC12,		0x0000a2a8},


