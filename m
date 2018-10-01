Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93F0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D5E2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="iR6Tq/M1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D5E2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeJAMGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:06:44 -0400
Received: from onstation.org ([52.200.56.107]:35956 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbeJAMG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:06:28 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id A7D92974;
        Mon,  1 Oct 2018 05:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1538371829;
        bh=AxR+CxANBerBe8pSJs/TaI4wXbWbORTJHzrKXskNfTg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iR6Tq/M1dWySw3AImqEFje48wYv8fqAScxJdOCTNCqcWWnUAlD/lkU1XFCn8RHTnw
         hPYEiBcFlr7Zy+u+XBzc7368tzd0gn9311yqYjPZzZrnvunRLSFe5HeBmxkcgFEaRo
         f0JLnCsLbfCRP7LN853zPHY0EXB3lKj8lO+B/Ay8=
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org, sre@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, david.brown@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca
Subject: [PATCH RFC 3/5] power: supply: bq24190_charger: add of_match for usb-otg-vbus regulator
Date:   Mon,  1 Oct 2018 01:30:03 -0400
Message-Id: <20181001053005.18906-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001053005.18906-1-masneyb@onstation.org>
References: <20181001053005.18906-1-masneyb@onstation.org>
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
index e3836145286d..933d1cded697 100644
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
2.17.1

