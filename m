Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ABBC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967F820844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="U0WN5fAo";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="U0WN5fAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967F820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbeGYVAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:00:09 -0400
Received: from node.akkea.ca ([192.155.83.177]:60938 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730486AbeGYVAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:00:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 4F3B5542065;
        Wed, 25 Jul 2018 19:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1532548019; bh=YEhj+yFcILxdp36tGAn5v89d1v+knRiiJBTwWnqVb84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=U0WN5fAotLPBV4roFGF8lD9y2kHTXdhbWpAxgTX/Npip7e3PwFUhfrHAvy/O6OGyv
         GP6KjeH7yqmG7sZ1DnkoNVGO9ib5+oXj1UHyvYsT+eGStr1RkP9Otbywj8kkd1iFFA
         M01Tyusokz0tS2azPYaYLi53Z5OTRFA684lMIuh4=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mOFcU6wnbn9p; Wed, 25 Jul 2018 19:46:59 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.cg.shawcable.net [68.144.56.170])
        by node.akkea.ca (Postfix) with ESMTPSA id 9D90554204A;
        Wed, 25 Jul 2018 19:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1532548019; bh=YEhj+yFcILxdp36tGAn5v89d1v+knRiiJBTwWnqVb84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=U0WN5fAotLPBV4roFGF8lD9y2kHTXdhbWpAxgTX/Npip7e3PwFUhfrHAvy/O6OGyv
         GP6KjeH7yqmG7sZ1DnkoNVGO9ib5+oXj1UHyvYsT+eGStr1RkP9Otbywj8kkd1iFFA
         M01Tyusokz0tS2azPYaYLi53Z5OTRFA684lMIuh4=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 2/4] power: bq25890_charger.c: Remove unused table
Date:   Wed, 25 Jul 2018 13:46:28 -0600
Message-Id: <20180725194630.10414-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180725194630.10414-1-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BATCMP table isn't used so drop it

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/power/supply/bq25890_charger.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 7f0b3a46c50c..641f7d779e2f 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -246,7 +246,6 @@ enum bq25890_table_ids {
 	TBL_ITERM,
 	TBL_IPRECHG,
 	TBL_VREG,
-	TBL_BATCMP,
 	TBL_VCLAMP,
 	TBL_BOOSTV,
 	TBL_SYSVMIN,
@@ -287,7 +286,6 @@ static const union {
 	[TBL_ICHG] =	{ .rt = {0,	  5056000, 64000} },	 /* uA */
 	[TBL_ITERM] =	{ .rt = {64000,   1024000, 64000} },	 /* uA */
 	[TBL_VREG] =	{ .rt = {3840000, 4608000, 16000} },	 /* uV */
-	[TBL_BATCMP] =	{ .rt = {0,	  140,     20} },	 /* mOhm */
 	[TBL_VCLAMP] =	{ .rt = {0,	  224000,  32000} },	 /* uV */
 	[TBL_BOOSTV] =	{ .rt = {4550000, 5510000, 64000} },	 /* uV */
 	[TBL_SYSVMIN] = { .rt = {3000000, 3700000, 100000} },	 /* uV */
-- 
2.17.1

