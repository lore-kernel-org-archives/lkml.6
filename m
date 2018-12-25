Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF26C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 06:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C830C20857
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 06:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Z7ToxyOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbeLYGWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 01:22:13 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:52272 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeLYGWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 01:22:13 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id A9E98C0A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 06:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O3Rp3qjD5iLx for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 00:22:11 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 7E6AEC06
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 00:22:11 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id i12so15376901ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 22:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=a9GyhpuUrRYBNp+M48bV8E+CTjRuEk+Lrbj7GFJck90=;
        b=Z7ToxyOiRh986lp4cKGMzmgPIHgZLmxP15UCQQvB4845LLqI1DtuVIU4lm7zxI/8dz
         Uwog4tsdgKQLyhFu9nMkeMXrRJyB/nrfDzxPRxD2KLHYkVjBqkPP4vpDuxu6EsFEUOeQ
         IG7tPD40d+htZJbsrQqmOxv0USI48d7lOKnZoy+q1wsNRHTmxG+A/qcsMYTh8vmX7lLv
         fzh++JaChkRYavTCr0qUPFqhkpHVt1bYVhHhpj3DVkRmxbwCwSyyb6GtRH88daXfLJZY
         ZjcOBSrG/Bw66b7y8nxdsPiWO21BHQMUFWlZMmr/zI9cAT5Q1PIhTRfh/nDa96tlW3Fm
         kaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a9GyhpuUrRYBNp+M48bV8E+CTjRuEk+Lrbj7GFJck90=;
        b=uRWKgZCtkAFIA5f9e3JqZkuiwYTWOlIjfOsCkitepvVmtkbaRXb8buftyvSjvpyMlp
         Gn9eZ1URSvhl87NI/uzmogG2scan4/ewz4gXMnwk4CuZDjt4l/5Q2MIzTlN0bbQQWPii
         TFB9DIzlZ4Q/4pqk/pmI5UfsRUqLrOlSaOlh6HyQ+hqmod8EJAJz1TuoOrZIv191ojNO
         o87SaGlSuh9h/bZARmHbShbXODRaozVgq6/5Y4DCBiQSWZOlOy0pc4ZzqaIuWXOgcXmr
         EWSQuev705PPI7KG8/OC++/tYebbpw7kfAyCvzNSoz7efWJitqU8PoM60Kkqn6WG+RBJ
         K4IA==
X-Gm-Message-State: AJcUukdkH+ezT6/URQbDGU2sOBFE9vbMeRIdcTZzLL35eaGA8h9vlaWY
        K7NLpjeCJ0YwgkvHbbq+lcvVhq7htjB3SITP7bOljSBx+Z5R3Qs5JLkLaxSuP1iX9ym7KVIptUL
        0Vj27crulaifDwExxc/ZdqAr/8AaP
X-Received: by 2002:a24:1490:: with SMTP id 138mr11934385itg.101.1545718931077;
        Mon, 24 Dec 2018 22:22:11 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XfYXP9g0p5dbtxJzToqpEqkl3DO/LYjmVzYdwJ4WN3n6c51QaUNu/sdWj6l5AEoGDIt/Sjtw==
X-Received: by 2002:a24:1490:: with SMTP id 138mr11934374itg.101.1545718930776;
        Mon, 24 Dec 2018 22:22:10 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id l11sm14963983iob.24.2018.12.24.22.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 22:22:09 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: (adp8870) fix a missing check for adp8870_write
Date:   Tue, 25 Dec 2018 00:21:09 -0600
Message-Id: <20181225062109.66943-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adp8870_write() may fail. This fix checks if adp8870_write fails, and if
so, returns its error code.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/video/backlight/adp8870_bl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 8d50e0299578..79901fb4fcd1 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -811,9 +811,14 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
 		if (!ret) {
 			reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
 			reg_val |= (val - 1) << CFGR_BLV_SHIFT;
-			adp8870_write(data->client, ADP8870_CFGR, reg_val);
-		}
-		mutex_unlock(&data->lock);
+			ret = adp8870_write(data->client,
+					ADP8870_CFGR, reg_val);
+			if (ret) {
+				mutex_unlock(&data->lock);
+				return ret;
+			}
+		}	else
+			mutex_unlock(&data->lock);
 	}
 
 	return count;
-- 
2.17.2 (Apple Git-113)

