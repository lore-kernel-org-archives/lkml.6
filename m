Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D34C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BB62186A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129786;
	bh=PVu073MEou4YtK1WIm7KjC2ccsI9q/UccwAqKVxMm+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q39Ffx4dCjOj5zTCTQHWqF/lbd2PZiOpdY0bvRxvhL18ne64+8tkcsdpDq+dJQKp3
	 bBdtJ0AiKNTBeoLmvIjNqwWT0K+E45kBmJp7Quc+Aepm7zjsxoKZhQ8dwcUmoVLi2G
	 8jU4xhE2suvO2CCMYPb6dtQ4KjjKVU2bc/hSiUzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfBYVXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:23:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731005AbfBYVXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4371621855;
        Mon, 25 Feb 2019 21:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129780;
        bh=PVu073MEou4YtK1WIm7KjC2ccsI9q/UccwAqKVxMm+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SX9+iqiQxPPom6x6cwojsJfpW6N2bZn3VZkuPPYv14JXcUz+gvLQiECQJL05MutaF
         SxQNwRBb6jsbSvg0r7FYTdXBtWpjhE0wv1lRmRB6raiAhC4RirJsUtMocgmflFUQSk
         YT0dmDURVNB/RMu3E+DDsAoz9IWZJ7n0BCygTsnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/152] mfd: wm5110: Add missing ASRC rate register
Date:   Mon, 25 Feb 2019 22:10:20 +0100
Message-Id: <20190225195045.605222246@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 04c801c18ded421845324255e660147a6f58dcd6 ]

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/wm5110-tables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index 1ee68bd440fbc..16c6e2accfaa5 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -1618,6 +1618,7 @@ static const struct reg_default wm5110_reg_default[] = {
 	{ 0x00000ECD, 0x0000 },    /* R3789  - HPLPF4_2 */
 	{ 0x00000EE0, 0x0000 },    /* R3808  - ASRC_ENABLE */
 	{ 0x00000EE2, 0x0000 },    /* R3810  - ASRC_RATE1 */
+	{ 0x00000EE3, 0x4000 },    /* R3811  - ASRC_RATE2 */
 	{ 0x00000EF0, 0x0000 },    /* R3824  - ISRC 1 CTRL 1 */
 	{ 0x00000EF1, 0x0000 },    /* R3825  - ISRC 1 CTRL 2 */
 	{ 0x00000EF2, 0x0000 },    /* R3826  - ISRC 1 CTRL 3 */
@@ -2869,6 +2870,7 @@ static bool wm5110_readable_register(struct device *dev, unsigned int reg)
 	case ARIZONA_ASRC_ENABLE:
 	case ARIZONA_ASRC_STATUS:
 	case ARIZONA_ASRC_RATE1:
+	case ARIZONA_ASRC_RATE2:
 	case ARIZONA_ISRC_1_CTRL_1:
 	case ARIZONA_ISRC_1_CTRL_2:
 	case ARIZONA_ISRC_1_CTRL_3:
-- 
2.19.1



