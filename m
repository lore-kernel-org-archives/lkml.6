Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2A7C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C75208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C75208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966923AbeFRJNG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:13:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966785AbeFRI3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:29:30 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 31E9DBBE;
        Mon, 18 Jun 2018 08:29:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 019/189] ASoC: rt5514: Add the missing register in the readable table
Date:   Mon, 18 Jun 2018 10:11:55 +0200
Message-Id: <20180618081209.987139248@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>

[ Upstream commit 5ef5ac8de125fe6b4b23293bee026ca7ea1529b9 ]

The patch adds the missing register in the readable table.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/rt5514.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -89,6 +89,7 @@ static const struct reg_default rt5514_r
 	{RT5514_PLL3_CALIB_CTRL5,	0x40220012},
 	{RT5514_DELAY_BUF_CTRL1,	0x7fff006a},
 	{RT5514_DELAY_BUF_CTRL3,	0x00000000},
+	{RT5514_ASRC_IN_CTRL1,		0x00000003},
 	{RT5514_DOWNFILTER0_CTRL1,	0x00020c2f},
 	{RT5514_DOWNFILTER0_CTRL2,	0x00020c2f},
 	{RT5514_DOWNFILTER0_CTRL3,	0x10000362},
@@ -181,6 +182,7 @@ static bool rt5514_readable_register(str
 	case RT5514_PLL3_CALIB_CTRL5:
 	case RT5514_DELAY_BUF_CTRL1:
 	case RT5514_DELAY_BUF_CTRL3:
+	case RT5514_ASRC_IN_CTRL1:
 	case RT5514_DOWNFILTER0_CTRL1:
 	case RT5514_DOWNFILTER0_CTRL2:
 	case RT5514_DOWNFILTER0_CTRL3:
@@ -238,6 +240,7 @@ static bool rt5514_i2c_readable_register
 	case RT5514_DSP_MAPPING | RT5514_PLL3_CALIB_CTRL5:
 	case RT5514_DSP_MAPPING | RT5514_DELAY_BUF_CTRL1:
 	case RT5514_DSP_MAPPING | RT5514_DELAY_BUF_CTRL3:
+	case RT5514_DSP_MAPPING | RT5514_ASRC_IN_CTRL1:
 	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER0_CTRL1:
 	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER0_CTRL2:
 	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER0_CTRL3:


