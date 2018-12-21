Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C34DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13254218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ludmSIzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbeLUG3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 01:29:43 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:47986 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbeLUG3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 01:29:43 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id EC410C7B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:29:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cssXRRq-gMDM for <linux-kernel@vger.kernel.org>;
        Fri, 21 Dec 2018 00:29:41 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id BA4169A6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 00:29:41 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id i12so4071543ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 22:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GyCf0+JGZZewWFEvo6aoME0rP8a9l7e6l9yI2i7GQn8=;
        b=ludmSIzRLL96m1KrINuwN6odlGR/1OdBPcDlCnFKoWt0Cs7PjukR1uA5bWAaHngzF4
         PtZdb6LxmvMDK9nC1N4AZpjQd0X7sY34mQs7dZsnPxpz8SgcOTUnt0lGJI0kTdbTTXyd
         3sPIY1mtgZw+7ibeJR/AJYn5htdzs/lFt6aZXirNSl61AklLBFruiQoWySlEvzkHSjUz
         qjF5L4DGGOw5HAosypNmGDDiFWrIj5IVD8ZHJZz/7Q1Fi6menFcHjQF/MftZR0HsbLCG
         eaSkI2PfFy4/7uckpeV9hMHp0TNmFx7KJjuvR8wlFvHaiFaN2a+Zhts/yVPVk0OwNstZ
         CLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GyCf0+JGZZewWFEvo6aoME0rP8a9l7e6l9yI2i7GQn8=;
        b=EJxDwAQzjuh2g/R+0GaRD0cgUan38ZwVgrsuTCbTmxZwcNAovBM+c8v8Jy5i3iW/rm
         494lsnbicUeKbfiN2zJvcSPWjqoP7mrNHokCQLcy1FyIyekZY4xrIVgDx4fboApA7XfT
         SQXXJjjyWUWU0sSnvqmHpyE6tuH7XE08jTBtFeYkJq2p8Glq/bX8aQqR/T45Cq6kqfYl
         6feceaSBQdt4gftHL7oyoomKUjtQIH9RFvBlJGA1xawcVDX5ongcuOX1sGl9vB7rnUSq
         PmNcibJnRWKmCx6PIJhWtMHcpx1ttBD6rN3m1vEEF9+fv2d3z/oJqsw3rkJkaPHtH3w6
         S4GA==
X-Gm-Message-State: AJcUukeaDlWaMwf1tzfLG7/hrZ4vVMEW73BpqdXDgZtbD2zAPpOIV8Pt
        a0ptTZ+iGUMVnkW4CHprdBgWbSTspe9cC+sGa/YMNTAFMAXiuTQySBFn10ubjMVDc29QvfyFcEy
        WFRi2uyTv8HUkcsFiw9d4eS1Wwepx
X-Received: by 2002:a6b:720f:: with SMTP id n15mr801564ioc.175.1545373781354;
        Thu, 20 Dec 2018 22:29:41 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5SUVfiiML3Qp9nKdKLtPIn2fI4qZ4PNwrjYAqzxBpGz6HXFR0XIycswLWE0MmQWFkjPlJMtQ==
X-Received: by 2002:a6b:720f:: with SMTP id n15mr801554ioc.175.1545373781101;
        Thu, 20 Dec 2018 22:29:41 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-23.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.23])
        by smtp.gmail.com with ESMTPSA id x128sm6145606itb.8.2018.12.20.22.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 22:29:40 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: tps65910: fix a missing check of return value
Date:   Fri, 21 Dec 2018 00:29:19 -0600
Message-Id: <20181221062919.59871-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tps65910_reg_set_bits() may fail. The fix checks if it fails, and if so,
returns with its error code.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/regulator/tps65910-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 02ccdaa226a7..5ebb6ee73f07 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -1102,8 +1102,10 @@ static int tps65910_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pmic);
 
 	/* Give control of all register to control port */
-	tps65910_reg_set_bits(pmic->mfd, TPS65910_DEVCTRL,
+	err = tps65910_reg_set_bits(pmic->mfd, TPS65910_DEVCTRL,
 				DEVCTRL_SR_CTL_I2C_SEL_MASK);
+	if (err < 0)
+		return err;
 
 	switch (tps65910_chip_id(tps65910)) {
 	case TPS65910:
-- 
2.17.2 (Apple Git-113)

