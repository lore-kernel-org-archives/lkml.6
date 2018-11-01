Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F84FECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3AA20866
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="XC5CzHrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3AA20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeKAJMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:12:44 -0400
Received: from onstation.org ([52.200.56.107]:44742 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbeKAJMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:12:42 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 1EECAB0E;
        Thu,  1 Nov 2018 00:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1541031131;
        bh=JKRzn4hB51JavjKXAcCuu9R+loG5zy8+v/t1MioEhq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XC5CzHrlOyHyi8sc7r6JiF5rWhGGMy5PqWYd29mhskp+d2PNQQVDJMztjP0tlS9qC
         G+FfiT+Xh7Hp9ngLgHaHaJ0L8Nh4nIkK003femI4V4oMhIf6bbwriu4K2HKEzerOXm
         I3a030/oHtQZ9WSakxojpyILuFybw9UNXipcLz+o=
From:   Brian Masney <masneyb@onstation.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        jonathan@marek.ca, masneyb@onstation.org
Subject: [PATCH v2 3/7] power: supply: bq24190_charger: add of_match for usb-otg-vbus regulator
Date:   Wed, 31 Oct 2018 20:11:45 -0400
Message-Id: <20181101001149.13453-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181101001149.13453-1-masneyb@onstation.org>
References: <20181101001149.13453-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

This patch adds an of_match for the usb-otg-vbus regulator to
bq24190_charger.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/power/supply/bq24190_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 44d3aff32885..9e7f3e33458a 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -577,6 +577,7 @@ static const struct regulator_ops bq24190_vbus_ops = {
 
 static const struct regulator_desc bq24190_vbus_desc = {
 	.name = "usb_otg_vbus",
+	.of_match = "usb-otg-vbus",
 	.type = REGULATOR_VOLTAGE,
 	.owner = THIS_MODULE,
 	.ops = &bq24190_vbus_ops,
-- 
2.17.2

