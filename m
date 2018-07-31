Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B1CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1DC208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="fuBZKvK1";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Xof2GUL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1DC208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbeGaTbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:31:06 -0400
Received: from node.akkea.ca ([192.155.83.177]:55584 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731427AbeGaTbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:31:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 1D42E542065;
        Tue, 31 Jul 2018 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1533059381; bh=eGjVHN5dJ/AAJ+Uw4UJm1HijtSUo9scBVBSqzOAKby0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fuBZKvK1S9VAE538IK+ZZZPcF16KwxQwEMPoIGgv83p6KSAjBzvszozUb5xJEejf5
         QNa1eNeKVV+E5sj00LnC4ADDFDtgm5KauPPQUb0dOzGrO7DBn4XrEh10Tt6j04wHzb
         j28oFK1LOYLxr4WMcY+BU6Z0lsUSP2HXgQ4ayBIs=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R8qLmtwpxl8P; Tue, 31 Jul 2018 17:49:40 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.cg.shawcable.net [68.144.56.170])
        by node.akkea.ca (Postfix) with ESMTPSA id 5FD6854204A;
        Tue, 31 Jul 2018 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1533059380; bh=eGjVHN5dJ/AAJ+Uw4UJm1HijtSUo9scBVBSqzOAKby0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Xof2GUL1mO52Bv0ws2YgF8bTF5v3OJhy/G6L3p6g8awCUeP/WEOX/A8sKpXWr+8Dm
         PDgewAQLjF6RkTQuwzYKV/SOnAXWVlWbMy2rM88WXuqN9D722nJ1K36chTCVJ0QQwQ
         suVoVcOOq0v+uujjqB9bQTdVdyz5isQFLBO/Bhqo=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v4 2/4] power: bq25890_charger.c: Remove unused table entries
Date:   Tue, 31 Jul 2018 11:49:07 -0600
Message-Id: <20180731174909.9392-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731174909.9392-1-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731174909.9392-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few table entries that aren't used. Drop them.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/power/supply/bq25890_charger.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 7f0b3a46c50c..ca61278e932e 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -244,10 +244,7 @@ enum bq25890_table_ids {
 	/* range tables */
 	TBL_ICHG,
 	TBL_ITERM,
-	TBL_IPRECHG,
 	TBL_VREG,
-	TBL_BATCMP,
-	TBL_VCLAMP,
 	TBL_BOOSTV,
 	TBL_SYSVMIN,
 
@@ -287,8 +284,6 @@ static const union {
 	[TBL_ICHG] =	{ .rt = {0,	  5056000, 64000} },	 /* uA */
 	[TBL_ITERM] =	{ .rt = {64000,   1024000, 64000} },	 /* uA */
 	[TBL_VREG] =	{ .rt = {3840000, 4608000, 16000} },	 /* uV */
-	[TBL_BATCMP] =	{ .rt = {0,	  140,     20} },	 /* mOhm */
-	[TBL_VCLAMP] =	{ .rt = {0,	  224000,  32000} },	 /* uV */
 	[TBL_BOOSTV] =	{ .rt = {4550000, 5510000, 64000} },	 /* uV */
 	[TBL_SYSVMIN] = { .rt = {3000000, 3700000, 100000} },	 /* uV */
 
-- 
2.17.1

