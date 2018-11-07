Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8801FC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9B02086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=autobyte-com-br.20150623.gappssmtp.com header.i=@autobyte-com-br.20150623.gappssmtp.com header.b="bLv1f3Dw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9B02086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=autobyte.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388873AbeKGKKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:10:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37702 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388796AbeKGKKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:10:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id p35so4897750qtc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=autobyte-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9Q5Yr3zXqZaY9U9uprLNvA6g0lGjxmZMetXWD2LRck=;
        b=bLv1f3DwWFzUUQFDeFR0OFwGkYoKZVSbuPJ9ZwY9LK594Rh2YqWkMAgm18h6jEa5zE
         +aHUf46wJMrc4vIR24CfS1KaHAlFrMC122f6M45mHCyenhBZ5MhGmM04lzfnBIgg5xf/
         Y5nJD397/w3qAUGJrsq09+VejcAwTmcb0SNxOMqUkrKrGx2zuu7JiMAQaVXrTdRGUKEI
         +C2Q+l+wDiZX/UFXdrMHA4WBS6U/hg+iMb8wfwQV+NUnfg3iPX4Rn7kYBy2sCLQBedBv
         SidvMW3fy3waYsuovYxmnNcqvePXQrYG2rXSVnyktALFy/Yg75sP7iwGg89cBNnpfz/z
         rPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9Q5Yr3zXqZaY9U9uprLNvA6g0lGjxmZMetXWD2LRck=;
        b=B6dTeTHW4GWa64BazWE0dXAGISsXrBc/dF3vhZT7UKHf0X/5NUISvLmKCDOy7OLe0N
         lC5987x5dLZ1MMQRxIV1mgmC9AsoqAMPehuSrrFnHlLw3H/bgbH1awDidRqA2p+8S4OB
         BG192HocAyRGSuENFC46P4AsrIDErx4UjPOpKNI9RrEBLtLKIwg62TrTjmcRrL3lfmP+
         tFtzKwtcWq1KiCFpPJKVw/aHCpiLJBqi9j+kR2262nrA3HGTSfWwpG2sDfMfOkfDXygZ
         EZGa5s2+Nq2Q8sYuoznRgBdHikgWIX+Gje10d04nUGCtFo3G4AWNlDH47wtCyqC0dGM7
         0qUA==
X-Gm-Message-State: AGRZ1gI1opVCNRS3Ysdkd8PIlCc+B/24M6LsxJAkNPcGfKMDMVRovj7i
        RbTizpizZBt2g9BpWdy8zWuwPg==
X-Google-Smtp-Source: AJdET5dCOPNy9FSM/1UgPUW/kdd3HcviBLzS5Ppa3nL/bEFpxbadG8IvdpySIzaCUbh1CTD0dD04Uw==
X-Received: by 2002:ac8:7482:: with SMTP id v2-v6mr1479863qtq.251.1541551366763;
        Tue, 06 Nov 2018 16:42:46 -0800 (PST)
Received: from localhost (wifi-177-220-85-78.wifi.ic.unicamp.br. [177.220.85.78])
        by smtp.gmail.com with ESMTPSA id n101sm15039028qkh.61.2018.11.06.16.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 16:42:45 -0800 (PST)
From:   nicolas@autobyte.com.br
X-Google-Original-From: nfraprado@protonmail.com
To:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        pure.logic@nexus-software.ie, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: mt7621-mmc: Add blank line after declaration
Date:   Tue,  6 Nov 2018 22:42:42 -0200
Message-Id: <20181107004242.1486-1-nfraprado@protonmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nícolas F. R. A. Prado <nfraprado@protonmail.com>

Correct the following warning from checkpatch.pl:

WARNING: Missing a blank line after declarations
+		struct msdc_host *host = mmc_priv(mmc);
+		msdc_pm(state, (void *)host);

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@protonmail.com>

---

Hi, this is my first commit. Let me know if there's anything I can do
better.
---
 drivers/staging/mt7621-mmc/sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 0379f9c96..7b66f9b0a 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -1797,6 +1797,7 @@ static void msdc_drv_pm(struct platform_device *pdev, pm_message_t state)
 
 	if (mmc) {
 		struct msdc_host *host = mmc_priv(mmc);
+
 		msdc_pm(state, (void *)host);
 	}
 }
-- 
2.19.1

