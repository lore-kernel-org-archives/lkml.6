Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DB2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35852184A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfBRHdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:33:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727875AbfBRHdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:33:24 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8F759C59CF292B4C3BE1;
        Mon, 18 Feb 2019 15:33:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 15:33:06 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman <james.schulman@cirrus.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: cs35l36: Make some symbols static
Date:   Mon, 18 Feb 2019 07:46:53 +0000
Message-ID: <20190218074653.181365-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warnings:

sound/soc/codecs/cs35l36.c:135:20: warning:
 symbol 'cs35l36_reg' was not declared. Should it be static?
sound/soc/codecs/cs35l36.c:248:6: warning:
 symbol 'cs35l36_readable_reg' was not declared. Should it be static?
sound/soc/codecs/cs35l36.c:398:6: warning:
 symbol 'cs35l36_precious_reg' was not declared. Should it be static?
sound/soc/codecs/cs35l36.c:410:6: warning:
 symbol 'cs35l36_volatile_reg' was not declared. Should it be static?

Fixes: 6ba9dd6c893b ("ASoC: cs35l36: Add support for Cirrus CS35L36 Amplifier")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/cs35l36.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
index 4f880a678812..005f1adc80b8 100644
--- a/sound/soc/codecs/cs35l36.c
+++ b/sound/soc/codecs/cs35l36.c
@@ -132,7 +132,7 @@ static const struct cs35l36_pll_config cs35l36_pll_sysclk[] = {
 	{27000000,	0x3F, 0x0A},
 };
 
-struct reg_default cs35l36_reg[] = {
+static struct reg_default cs35l36_reg[] = {
 	{CS35L36_TESTKEY_CTRL,			0x00000000},
 	{CS35L36_USERKEY_CTL,			0x00000000},
 	{CS35L36_OTP_CTRL1,			0x00002460},
@@ -245,7 +245,7 @@ struct reg_default cs35l36_reg[] = {
 	{CS35L36_PAC_INT7_CTRL,			0x00000001},
 };
 
-bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
+static bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case CS35L36_SW_RESET:
@@ -395,7 +395,7 @@ bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
+static bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case CS35L36_TESTKEY_CTRL:
@@ -407,7 +407,7 @@ bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-bool cs35l36_volatile_reg(struct device *dev, unsigned int reg)
+static bool cs35l36_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case CS35L36_SW_RESET:



