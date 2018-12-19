Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443A8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C92B21871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="fKkQwJ6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeLSFKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 00:10:50 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:45002 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbeLSFKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 00:10:49 -0500
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2018 00:10:48 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id D11A1B75
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:04:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id khtsMYD0MIaz for <linux-kernel@vger.kernel.org>;
        Tue, 18 Dec 2018 23:04:37 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id A781FB72
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 23:04:37 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id n124so5378274itb.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 21:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3mpgbGSojf4iIUc/IhhTETIGQooT/+0wh3zwx7ZJz4A=;
        b=fKkQwJ6x315i1B/qLtzP0unrJzSJlx/BB908oigd+buspxLIFCju8oh6nVTwgLNoZY
         OjjPv9pdGuabLPFpBVjt8D10Gd0EGUjHclz3n9C3nEC434bZRZ+BEyW6t/pawJvxN1H/
         uSNmNiUG+EWZ9gWrhKNr4DFFmVvmWKj7dKVmUYFruPP7Z1x1aIblV+EkkQ1VxG+O4qXY
         TF86GgQSEBo5KfJcUZ9Ad+DU9zJyyzCIxzBi1d4iBBVYKB2lWAAMIZxN9DbNtw0zPi9Y
         GA22KHMDWrIHDMJLWa4omOHvg2mcLnvYVDlAdwUX/Zt80I+IhUVLsD+bnGuC/bU+jhBw
         npeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3mpgbGSojf4iIUc/IhhTETIGQooT/+0wh3zwx7ZJz4A=;
        b=FyaznXX+/xPtDLM9rrr2zruahSZ2cPMNS4AprH+GOdmkyAoHbAy3DBWoghWV3cEiIE
         Icd6etnPDyGqkT5CAibeH6+X4/8FLiM/rScFEy3y5TKIxaDd75qpjX/b0FF+npaDT9pN
         ssFPoCABdazIJXfSJgKYwVIsK/GM3yuC1aEdcMjuxIe7HFNjGopc5LqIED+N2x5Ms1eU
         vRNs2ShOqwylbOH1H8b2WUIE764zumn7tqaax+7LVrpJ1QVyFIh60nRaFzORD6XmgjME
         nql8UX2EMYw3rZo6RIgVPtKIjBbr3RsOmutTE244z7pF34HlKpxcrthwYAVqJ8E+tsW/
         mf8w==
X-Gm-Message-State: AA+aEWaqGHkLISRhw6j9qKAd7E0fLU5xUl9ZXhmq+r5NVrj5TjNuK/Qd
        5LoGTOqyZL+OP37HW0MVRDhesdXTyRIDkSLWLI+e1dCUOhK0DEkQ0P/b5R8eiey4dSF6oJOfs+V
        p1F5OSQlEjYyAojhI4HITvafycVLA
X-Received: by 2002:a02:84e1:: with SMTP id f88mr18608602jai.107.1545195877265;
        Tue, 18 Dec 2018 21:04:37 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UI69UnKjIRfb4TpZKUfn79gwQxJX2liDqXvlp8rCv353E4CKKcmyLLWLPc7Nki4EoOPfRbhg==
X-Received: by 2002:a02:84e1:: with SMTP id f88mr18608589jai.107.1545195876973;
        Tue, 18 Dec 2018 21:04:36 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-24.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.24])
        by smtp.gmail.com with ESMTPSA id e189sm2645340ite.17.2018.12.18.21.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 21:04:36 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/regulator: fix a missing check of return value
Date:   Tue, 18 Dec 2018 23:04:13 -0600
Message-Id: <20181219050413.16374-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If palmas_smps_read() fails, we should not use the read data in "reg"
which may contain random value. The fix inserts a check for the return
value of palmas_smps_read(): If it fails, we return the error code
upstream and stop using "reg".

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/regulator/palmas-regulator.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index bb5ab7d78895..c2cc392a27d4 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -443,13 +443,16 @@ static int palmas_ldo_write(struct palmas *palmas, unsigned int reg,
 static int palmas_set_mode_smps(struct regulator_dev *dev, unsigned int mode)
 {
 	int id = rdev_get_id(dev);
+	int ret;
 	struct palmas_pmic *pmic = rdev_get_drvdata(dev);
 	struct palmas_pmic_driver_data *ddata = pmic->palmas->pmic_ddata;
 	struct palmas_regs_info *rinfo = &ddata->palmas_regs_info[id];
 	unsigned int reg;
 	bool rail_enable = true;
 
-	palmas_smps_read(pmic->palmas, rinfo->ctrl_addr, &reg);
+	ret = palmas_smps_read(pmic->palmas, rinfo->ctrl_addr, &reg);
+	if (ret)
+		return ret;
 
 	reg &= ~PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
 
-- 
2.17.2 (Apple Git-113)

