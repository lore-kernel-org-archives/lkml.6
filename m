Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CA7C64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366E92084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVnGhdz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366E92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeJDTyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:54:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38656 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeJDTyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:54:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id v7-v6so7841188ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZtPppqn0cObkHfFqeBrroPaPD+bDud26pGAf+e3d480=;
        b=gVnGhdz5rRnqns1IeCrrykSU1dGUv5BbH7cz4Lca+1Lwr8v5uYGWH17mZroSeIkczQ
         SvEJOoVzF5ZtHqQuNBISKy4Yf/u1xPgSO8+3YkztmEgh8G1Pb80x/Jz0vDrc5/wcOf/5
         uJ7mPAT3D+FIpyg6kKtwA/s8/ICdAavPKc1SgSQzdx5iV2CEXFmcCbMXK8KaetQFOSkj
         HHu9QLWdWtmgRtCfRsnQJhy2binTxpqAfsXW/g6GxofMJzIS7HzD2Yanhj1jIZ3u9ews
         5vXDIJTQ4pYOWS7r1gkmuSn5o8hKQhv9fMafHAbmfLjaB+qwK/kGTACMvknFID4RV6ek
         +flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZtPppqn0cObkHfFqeBrroPaPD+bDud26pGAf+e3d480=;
        b=onvqNl2c1lyBIX1emMmh4ciMeAn0dQRqVuU+EDqpp7zVMpSO+1k/Ioxn1WzdrT/NcH
         muYVZS+bsi5otS9Nng8nkV2D2ovEVOnQ7+gofiDN+fV+ujzkslYJZIAf9zQIs/+j01/e
         RXcCn2B1ZuQl6r3SQhSHacsQQKJMFxbN5b7AHisjwEdUd/0M8xVAmZq9lw9pUApIzvov
         atzfj6YceKyqO7p8sLunUDPHtJqkpMQHC4jwXDDuaqRo+x7vy5LCy1n0j57sAS6E2SEP
         8qsopDi99v8JpP1Ky7VbY665sK2vc3AQtxd02VIm0BeHtdtzH/mKeW1XcvpEAoPitXla
         kAFA==
X-Gm-Message-State: ABuFfojKLKCZ0ECXLlNsYewUe2n5DGGWQrRIp4aN+zRlTEwImgj/oyLc
        IaxbYZrBNmKLsoWjt61uAXw=
X-Google-Smtp-Source: ACcGV60FvoXuq7WLemLa+Yt5oJNrO/91NoFrZa3ddgSHkEl7JYXjqVYspBDq85k4qq/vIMYfBsq0XQ==
X-Received: by 2002:a2e:7e07:: with SMTP id z7-v6mr4202020ljc.84.1538658084848;
        Thu, 04 Oct 2018 06:01:24 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a1-v6sm421415lfk.63.2018.10.04.06.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:01:23 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v6 02/10] mtd: physmap_of: Remove unused struct of_device_id
Date:   Thu,  4 Oct 2018 15:01:02 +0200
Message-Id: <20181004130110.8496-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
References: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This struct does not seem to be used anywhere on the code

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/physmap_of_gemini.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of_gemini.c b/drivers/mtd/maps/physmap_of_gemini.c
index 830b1b7e702b..9df62ca721d5 100644
--- a/drivers/mtd/maps/physmap_of_gemini.c
+++ b/drivers/mtd/maps/physmap_of_gemini.c
@@ -44,11 +44,6 @@
 
 #define FLASH_PARALLEL_HIGH_PIN_CNT	(1 << 20)	/* else low pin cnt */
 
-static const struct of_device_id syscon_match[] = {
-	{ .compatible = "cortina,gemini-syscon" },
-	{ },
-};
-
 int of_flash_probe_gemini(struct platform_device *pdev,
 			  struct device_node *np,
 			  struct map_info *map)
-- 
2.19.0

