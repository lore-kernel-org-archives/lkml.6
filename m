Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6A6C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3C02053B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUUTNUlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3C02053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbeLNNWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:22:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37871 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbeLNNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:22:27 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so4886369lja.4;
        Fri, 14 Dec 2018 05:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5tHOV+8kWpRLL2iyRBk9ZOn14M/aMT7Ov6uIuXi0Hdo=;
        b=BUUTNUlGnOQwaX0sfVz7lTMuSyk9DFdxFtPFOd+avXsvDZGchILwzFHYJA+8BKUcF9
         KbBuyoySvTnOAqyeEqNxyV0YBPtT8ikFDstPJsfb9HYbVIW9mjmikW1dMM+OKiXnaW6t
         Wp6My9BsAufTfjI8TNu7viDdc9uG98CEyMia/Isuo+Z/gF+JNGpTNhvqqyuxIhZLxmXR
         g2gbYnNHg1lTh5ZVFp687Ad8pUIR5nnfUcio8TtcWnvVzdRRCWsaVzHcuB5YCcD8chJk
         Ii5KBP5/rMnnuFDPZh20GmtIy+QHvhjAbhLuV1OscAzSaVnbqcET5GDHcN22h0oUE/j2
         4F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5tHOV+8kWpRLL2iyRBk9ZOn14M/aMT7Ov6uIuXi0Hdo=;
        b=tOs5D8SqHBxqvJDBlgmoOhLl4Ac0AymFfTJSlhtHYsQwHowI+doNOIGpmjWoEyhCC+
         Xlm6OQab7gy8CABrGdBod7yK5qKoYthe/O/rO4h019Egk7B/Ebr02P8w6Bq9G+GysrMw
         rml6yZiMEShFdqgaSMIslI6HX8G8nb+4l+oc8QSEcTtk12BBIpZWq2XY+Uqk4o3/f5gc
         RXGOhJk1kErRC8bxS4G9oWNA/regdO1c+bParqgfTiWKx6fc7Wz17ru94J169MEvfOQ6
         dfTyehi1UtiQAOGpdFQUYrdVJlJ4BF5gqXbbRNlKBl9l0MaQu0H4kJnBD901w/hj8VUu
         nzrQ==
X-Gm-Message-State: AA+aEWb02ZIScHeD9i0+GIUSqj1tocNb14oI7HWZUXRIaZGFO4TsEWcH
        PYLpohg0sZjS5tgMvR7b0yAoU2sH7wS7RLXu
X-Google-Smtp-Source: AFSGD/XnzVpBH4SWx+RNX51AtdhI9gMFPqIxt/K0mXZqzut6A+FN3hQV7PDUtD9Qcnjeds2ccKKBBg==
X-Received: by 2002:a2e:4299:: with SMTP id h25-v6mr1767781ljf.5.1544793745065;
        Fri, 14 Dec 2018 05:22:25 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id u79-v6sm944101lje.36.2018.12.14.05.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 05:22:24 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-scsi@vger.kernel.org, mironov.ivan@gmail.com
Cc:     linux-kernel@vger.kernel.org, Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com
Subject: [PATCH 3/6] scsi: hpsa: Add/mask existing devices on rescan if visibility changes
Date:   Fri, 14 Dec 2018 18:21:12 +0500
Message-Id: <20181214132115.21440-4-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181214132115.21440-1-mironov.ivan@gmail.com>
References: <20181214132115.21440-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Controller may be switched between RAID and HBA modes even without a
reboot.

When changing to HBA mode, it does some internal reset magic and
automatically removes any configured RAID arrays. Without this patch,
driver successfully detects disappearance of logical arrays, but does
not expose any physical disks.

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/scsi/hpsa.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index ee3d7c722a63..60f1f7949d8d 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -1541,6 +1541,14 @@ static inline int device_updated(struct hpsa_scsi_dev_t *dev1,
 	return 0;
 }
 
+static inline bool device_expose_changed(struct hpsa_scsi_dev_t *dev1,
+	struct hpsa_scsi_dev_t *dev2)
+{
+	if (dev1->expose_device != dev2->expose_device)
+		return true;
+	return false;
+}
+
 /* Find needle in haystack.  If exact match found, return DEVICE_SAME,
  * and return needle location in *index.  If scsi3addr matches, but not
  * vendor, model, serial num, etc. return DEVICE_CHANGED, and return needle
@@ -1569,6 +1577,8 @@ static int hpsa_scsi_find_entry(struct hpsa_scsi_dev_t *needle,
 			if (device_is_the_same(needle, haystack[i])) {
 				if (device_updated(needle, haystack[i]))
 					return DEVICE_UPDATED;
+				if (device_expose_changed(needle, haystack[i]))
+					return DEVICE_CHANGED;
 				return DEVICE_SAME;
 			} else {
 				/* Keep offline devices offline */
-- 
2.19.2

