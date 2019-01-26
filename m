Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9CAC282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F900218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="0XDvGimx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfAZDkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:40:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46709 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbfAZDkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:40:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so5603435pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 19:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rUYeF7/yVivumcJoEGIoQFFgBPf9Gu0zem633y5c8Gc=;
        b=0XDvGimxP3AkIR8c3zZCs06NMe7QZN3LEDSq1Ep3lEbmDzlM9QJxFBKUzbMY63bbeT
         9BDd8QQtc7khvBYLABhq815h09WUbTELpG4f0LpaWqQbScqZbKSSRmFQEbUzUpB8/nPG
         rUQydGpAFZp2rhl66jludGOGws/lfY0AD6zGXgKOF3TaC1IPaWZr4m/Tkfl4JyrOXXcn
         luQoHIUgDoG6XY4FEepdR7IwloCMuin+cYfExKUYSHP98G52xB3kn3l1qm0YgziQzDdV
         ALNdp2nkxrXZVKIQ63Rq0ANnzuVbog/airl5qDM7Or+SJD24oyiirh2lz1d6faVLdiOr
         QaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rUYeF7/yVivumcJoEGIoQFFgBPf9Gu0zem633y5c8Gc=;
        b=Zd1QlCLc6HKZuqNcWa8RdBc6ez02BGSjSK3DXaYwFO7ZlrtBojWhwsq8C24VawfDyp
         VWXgIIXy0oBLgQ2+mJasvF5ribOgHdp1zTN2Do/yMrzpTYxYLGmXCdgHElN6wUDg5nHY
         wIyWRaMWkHyOp31T5wPwXrUbFQZAlGuS2ja/rjnH9Gu+weNJvN/DWKp7uNDPXumHqEsp
         N87XmE/Bplor0ao9HnazJgVo7NmyNLadAvlz9bMD+DhJ4JlmnB1rmOWh/tIJeyZWKBl3
         nLhExXr19qPxg/A0e0GDC+Vxlrai4jMa79NriyuSAa3h/Sgrb+DYe4es3alCS/ol8YGD
         54Pg==
X-Gm-Message-State: AJcUukeDcxLKFcAS2pE0WL+26DPsl/8M+9sMGWkb9HDq0MXNngF0bLTd
        R5Eaxai1HLVTH3EXpC/ihA3BJw==
X-Google-Smtp-Source: ALg8bN6yW9ztEIW0/7KKbwNsV5WjdjyKI7W7wqoW09XVYJYb6DF3lzHpwsepI3cW9I2rdZwaZhlTZQ==
X-Received: by 2002:a63:86c1:: with SMTP id x184mr12192620pgd.305.1548474012734;
        Fri, 25 Jan 2019 19:40:12 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id 24sm37460086pfr.75.2019.01.25.19.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 19:40:11 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 5/8] regulator: lp8755: Constify lp8755_regulators
Date:   Sat, 26 Jan 2019 11:39:04 +0800
Message-Id: <20190126033907.18427-5-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126033907.18427-1-axel.lin@ingics.com>
References: <20190126033907.18427-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp8755.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp8755.c b/drivers/regulator/lp8755.c
index 6d229ad4ef3e..14fd38807134 100644
--- a/drivers/regulator/lp8755.c
+++ b/drivers/regulator/lp8755.c
@@ -315,7 +315,7 @@ static int lp8755_init_data(struct lp8755_chip *pchip)
 	.vsel_mask = LP8755_BUCK_VOUT_M,\
 }
 
-static struct regulator_desc lp8755_regulators[] = {
+static const struct regulator_desc lp8755_regulators[] = {
 	lp8755_buck_desc(0),
 	lp8755_buck_desc(1),
 	lp8755_buck_desc(2),
-- 
2.17.1

