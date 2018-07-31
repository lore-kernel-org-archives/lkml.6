Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AA1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D38C20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="p5zdYt1s";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="p5zdYt1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D38C20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGaSZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:25:11 -0400
Received: from node.akkea.ca ([192.155.83.177]:53316 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729725AbeGaSYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:24:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id E33D6542066;
        Tue, 31 Jul 2018 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1533055426; bh=XJ+h1g4x9wkaSaqNu/MnZDLfTUp1YAwMyJlmfR/qO0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=p5zdYt1s26TDNhziBScArmuVX1HTph3f5ctq2pKQzQ1nlWR+aKAnsFW+qWWrl8PQK
         pefE/w9z6j1VvHB99aDVOgTpLdjL1yxNlaoAmcdCHdM0KWU5pUVczkcX04WJwKw9s4
         XLsGr7Rc9mEtv08Y0ASk1uJ1UpLpGWLtpwlX/Sxo=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id grmTHfDmWWr0; Tue, 31 Jul 2018 16:43:46 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.cg.shawcable.net [68.144.56.170])
        by node.akkea.ca (Postfix) with ESMTPSA id 34A5A54204A;
        Tue, 31 Jul 2018 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1533055426; bh=XJ+h1g4x9wkaSaqNu/MnZDLfTUp1YAwMyJlmfR/qO0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=p5zdYt1s26TDNhziBScArmuVX1HTph3f5ctq2pKQzQ1nlWR+aKAnsFW+qWWrl8PQK
         pefE/w9z6j1VvHB99aDVOgTpLdjL1yxNlaoAmcdCHdM0KWU5pUVczkcX04WJwKw9s4
         XLsGr7Rc9mEtv08Y0ASk1uJ1UpLpGWLtpwlX/Sxo=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v3 2/4] power: bq25890_charger.c: Remove unused table entries
Date:   Tue, 31 Jul 2018 10:43:14 -0600
Message-Id: <20180731164316.32696-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731164316.32696-1-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731164316.32696-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few table entries that aren't used. Drop them.

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

