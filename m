Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00869ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D03A20671
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ZSI4GvaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D03A20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbeIRNMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:12:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45353 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIRNMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:12:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id p52-v6so1029041eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 00:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=19dNveM2mFw76QGcbi170r/izzRIUvZSJ3Ry8FOcEUk=;
        b=ZSI4GvaVRh+qIOUJrcK9viXqmGBixPw829wCEHOlQL89BkdICvxI4kboIIoiu1mE6k
         nQS89T0uk+F7GLpHB3iRwo+Vh5CalRfOaha+ugzWahPMVP31jU/VVeLItSZhw7A8IPCG
         yTDxKnT17F9jJZDELmKt9sQRKfEm56XWYFESBdzRhx3r3saFzshlGKktC3i30KroVVGX
         7BoGvLSkarlXu+KAjazxGb+1x7FdVeyCbx9LfyRmEkOhpLo30nzb6Kttc4KurbbqA8hP
         s/VfNLEgT99td+NuDuEMjUivpCFQnVmGFsruc3ahIrbvJcrh6hl9b0c7Z76PwN6BcwmY
         VMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=19dNveM2mFw76QGcbi170r/izzRIUvZSJ3Ry8FOcEUk=;
        b=tkbb0RK1aZ4L8Md25eTbP123cws5IbFI1Ni+6I2aeJIq55b9ZVXlwm9BNeqPJSJ5rV
         aV+ys0O0uy5GYeSm8lXCPwTCfa+7UnuF4+m+n/fcDLG+/tBHO02BY2iMob0gx4z/G4aB
         o4BVTjBA1YhYwimpI74ne95r5GrJZoZpYg91qqIu+frDCJifwa/QSFHtzAhhQ5pbKFLq
         urKejc6PumH8PwMOcjIyFmX14wORI2I2BmJ2zKtDUDcZLon/yq2Xa7SFxuXxE1o99Ozc
         9JSdpXJwDANFw6AtccVyKGXBei9iAE1ecuZAIsfUZMXqSXoZcrxbIOehxXLZ1ykFY7h8
         kyCw==
X-Gm-Message-State: APzg51DXWACzh+XEyi3qSiwj1t4jOhFeuhZCDnGNKjy579+KzqkYhiXy
        gDZkxJDbnJHq/Jey8/IveMJXMtL7py8=
X-Google-Smtp-Source: ANB0VdbPJwsm4hjuwjg87SinbM4tk76OLZTd/MyN7gDJQ4K0U0tHSKBDzyarwS8cwkgdStQIIEJAvg==
X-Received: by 2002:a50:cd58:: with SMTP id d24-v6mr50278701edj.1.1537256456003;
        Tue, 18 Sep 2018 00:40:56 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id g38-v6sm8037566edc.40.2018.09.18.00.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 00:40:55 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: fix race on sysfs line state
Date:   Tue, 18 Sep 2018 09:40:32 +0200
Message-Id: <1537256432-19807-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pblk exposes a sysfs interface that represents its internal state. Part
of this state is the map bitmap for the current open line, which should
be protected by the line lock to avoid a race when freeing the line
metadata. Currently, it is not.

This patch makes sure that the line state is consistent and NULL
bitmap pointers are not dereferenced.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 5 +++--
 drivers/lightnvm/pblk-sysfs.c | 8 +++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a23e965d32fc..fec0ad68dcd6 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1662,13 +1662,14 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 	struct pblk_line *cur, *new = NULL;
 	unsigned int left_seblks;
 
-	cur = l_mg->data_line;
 	new = l_mg->data_next;
 	if (!new)
 		goto out;
+
+	spin_lock(&l_mg->free_lock);
+	cur = l_mg->data_line;
 	l_mg->data_line = new;
 
-	spin_lock(&l_mg->free_lock);
 	pblk_line_setup_metadata(new, l_mg, &pblk->lm);
 	spin_unlock(&l_mg->free_lock);
 
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index cba83ac43e62..2d2818155aa8 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -263,8 +263,14 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 		sec_in_line = l_mg->data_line->sec_in_line;
 		meta_weight = bitmap_weight(&l_mg->meta_bitmap,
 							PBLK_DATA_LINES);
-		map_weight = bitmap_weight(l_mg->data_line->map_bitmap,
+
+		spin_lock(&l_mg->data_line->lock);
+		if (l_mg->data_line->map_bitmap)
+			map_weight = bitmap_weight(l_mg->data_line->map_bitmap,
 							lm->sec_per_line);
+		else
+			map_weight = 0;
+		spin_unlock(&l_mg->data_line->lock);
 	}
 	spin_unlock(&l_mg->free_lock);
 
-- 
2.7.4

