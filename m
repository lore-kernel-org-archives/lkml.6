Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE493C282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBD9218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="epI3CYK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfAZDkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:40:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33964 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfAZDkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:40:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so5001716pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 19:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DgFZuwfshLHc7utNU5nuDD2e99FORvCI3LXHtS07dm8=;
        b=epI3CYK8WtgqY4ACMBan4HfH3OUsyNPz9j+Ljw+4QHLD4FKxqKctl4XevGBaYPSNdy
         kt1ZJc/03nUg4MfdiopGfXR//jrwefmwAHJ3cwbCOlwN+0YTOlOa7xjGmi6+U1G6E/+x
         wQuEHBzQ2J4UDrsRZpu9lcXjZSIri9Z6qx3mm4DCU2nMSf+NP4dP0v+d815H94/VIziZ
         ttc/m2rvmuYE3JU4uWUCGkLZKm5zleiZ8k2WOlYOBb34psnLK3+HgoyTF0rxTulbeMmx
         gAb8qfGpHSvgmAuHQGpALAzLbbH/MjjaF2HI4KhAQ0bbkeTFIIJCP2MofUepp6gmD+zr
         +qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DgFZuwfshLHc7utNU5nuDD2e99FORvCI3LXHtS07dm8=;
        b=MZEYeHRHgsOetDrtqnpT/ZCFadhBQpdH5y+HQkrWwazhEvIxR8Z2RlbDJDssdU62C0
         wXSUxc2njSSppJtTQDZdZx0yxKB2hfq1UVeCppGtV/nnD3iUrpM8yR5AhPE5ykd0uzcz
         qJrtKOzaxRxDMgh+lcJx2rjot8+zE8LRo2Z1cVuPfz1qEEvw6jIcPFFY8WnWn07xK9ey
         NeVa+wV7glvXoHoetjgYTGQ6HzrNWR/ZePRxayvldsL63xWlTGWflwZJuJlTjlzEti5H
         qGUZlu7X1UFyaux3wf/Eqx7Jc0tAUvmOoAhFquYNuWj37yKzwoh+YPjoLlk77Y5/W5zA
         Y//g==
X-Gm-Message-State: AJcUukekviD7SaGq40M3WUd1foT745IpYR1lCVQOdX1D8YjDC/7tOIIX
        qO2Yb2IMsyx+pBpMalHyulOoUQ==
X-Google-Smtp-Source: ALg8bN6aaSawJcsQ5Jx1vdcbDEU3zIjdtpc6X4Lvi8BllFSDZtZYFXRmyl0O68tp1/Xz19V51UWXQw==
X-Received: by 2002:a63:cb4a:: with SMTP id m10mr11846655pgi.105.1548474003522;
        Fri, 25 Jan 2019 19:40:03 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id 24sm37460086pfr.75.2019.01.25.19.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 19:40:02 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/8] regulator: lp3972: Constify lp3972_ldo_ops and lp3972_dcdc_ops
Date:   Sat, 26 Jan 2019 11:39:01 +0800
Message-Id: <20190126033907.18427-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126033907.18427-1-axel.lin@ingics.com>
References: <20190126033907.18427-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp3972.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lp3972.c b/drivers/regulator/lp3972.c
index ff0c275f902e..fb098198b688 100644
--- a/drivers/regulator/lp3972.c
+++ b/drivers/regulator/lp3972.c
@@ -305,7 +305,7 @@ static int lp3972_ldo_set_voltage_sel(struct regulator_dev *dev,
 	return ret;
 }
 
-static struct regulator_ops lp3972_ldo_ops = {
+static const struct regulator_ops lp3972_ldo_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.is_enabled = lp3972_ldo_is_enabled,
@@ -386,7 +386,7 @@ static int lp3972_dcdc_set_voltage_sel(struct regulator_dev *dev,
 				LP3972_VOL_CHANGE_FLAG_MASK, 0);
 }
 
-static struct regulator_ops lp3972_dcdc_ops = {
+static const struct regulator_ops lp3972_dcdc_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.is_enabled = lp3972_dcdc_is_enabled,
-- 
2.17.1

