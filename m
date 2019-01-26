Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B222C282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0452218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="RW1K2pz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfAZDkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:40:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39268 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfAZDkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:40:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so5422477pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 19:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uceH0uGyVetYoty7rSqnWkKOtUZ+xLmDOal5cOhHjzY=;
        b=RW1K2pz2Oc6EOVAbGLa+f0Xrm5mFj3saBUvqdStOE24vyPZr1Xqp1grXj+h6BrgjYw
         gPeVy4oRIj1vAdhhW0gna5wgJDsaKo0ubj0wUPA1bep6J2sjv1iqkPdXReDYjeG6KgXH
         C+2B/JPSNPOd1K1l19wBXD+8FZSlcEEAbLFFgNYTHjcB1CnMi7L+oLfH/DHvlHd/+K2H
         /B42jzIxOHzXadkaNU81UEBDZVL8V26T1tI5UE2aeW4J+iJakojUXdItuYRlfrY/UpnN
         fn24Jxgt7I12PWO9mWf6sUYAnftJXQGjpMOf4Nxu9scZGMvyeWLaPegs+0keIiujJL2e
         od9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uceH0uGyVetYoty7rSqnWkKOtUZ+xLmDOal5cOhHjzY=;
        b=DECFTrDzdGFi8BSUei76Fuwpd4D8HoGghXsPnJtfxqBxqqd6N9Tp4buwMiMsjKGIue
         22ZGQ0fdjcF+NjmPoZjfxMLrJrornqKwXTQG6jjfyHpkTO3W/zCDEy+TVQhko/yJ92D4
         FCzC6c8Il7PeKi6sgQUnZh97fLMVr60EnF9eJM5ia4gwMVhmCPK9rHCuAdj7l6QZFzJE
         EArQv3B9KQILQPOJjCY2NI4i4SXL5fy6mCxsWUvjVEJhihe6vjbyRKp5N7bxEUdMF8BN
         EwdS6EwfBoDS4N19AWuLHSChIxtODGjH7remo+wSb7ohKEUpQ+/jIKXKZMLybW4hMdEg
         kVGw==
X-Gm-Message-State: AJcUukeI4e9ktcqGRaSFx/fnLNXOjrPeHCjeGa3gwDNrOqVg5c8rA6XU
        9xtdyB980D/3P1PaFMaNzA+suA==
X-Google-Smtp-Source: ALg8bN4uzgs/SnyYuJsBM0euSHLhoogxyd1bksJfDxy9dGTefoFxwXHMUMUwK7WFgjseHG6VztR2aw==
X-Received: by 2002:a17:902:ac8f:: with SMTP id h15mr13231169plr.245.1548474000018;
        Fri, 25 Jan 2019 19:40:00 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id 24sm37460086pfr.75.2019.01.25.19.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 19:39:58 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/8] regulator: lp3971: Constify lp3971_ldo_ops and lp3971_dcdc_ops
Date:   Sat, 26 Jan 2019 11:39:00 +0800
Message-Id: <20190126033907.18427-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp3971.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lp3971.c b/drivers/regulator/lp3971.c
index 204b5c5270e0..9e45112658ba 100644
--- a/drivers/regulator/lp3971.c
+++ b/drivers/regulator/lp3971.c
@@ -159,7 +159,7 @@ static int lp3971_ldo_set_voltage_sel(struct regulator_dev *dev,
 			selector << LDO_VOL_CONTR_SHIFT(ldo));
 }
 
-static struct regulator_ops lp3971_ldo_ops = {
+static const struct regulator_ops lp3971_ldo_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.is_enabled = lp3971_ldo_is_enabled,
@@ -233,7 +233,7 @@ static int lp3971_dcdc_set_voltage_sel(struct regulator_dev *dev,
 	       0 << BUCK_VOL_CHANGE_SHIFT(buck));
 }
 
-static struct regulator_ops lp3971_dcdc_ops = {
+static const struct regulator_ops lp3971_dcdc_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.is_enabled = lp3971_dcdc_is_enabled,
-- 
2.17.1

