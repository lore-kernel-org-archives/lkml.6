Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1C028C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2782089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD8iFRq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2782089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933417AbeFLMqq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:46:46 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42075 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754292AbeFLMqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:46:42 -0400
Received: by mail-lf0-f68.google.com with SMTP id v135-v6so35794735lfa.9;
        Tue, 12 Jun 2018 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bBoaUCOTWw/Q1lsXklByX+UelIgt865AyYJ9aA0n4BA=;
        b=hD8iFRq6/4p3B+srXxz5PZdKZK1Emhf9olsd1Jze4kwtRefenL3PbuT/EBuVQDSxUz
         87Vuj1wDEmu4vdlKyToe2cPJ2tQTr+mtwkFs1lAYrXUaCT/l3V/BORov0f7656P/eCqH
         3sBoC7j8W+5XqxNK3lYXl6pqpa7tPX5yEegBARyG6FFQPUNrabLDizqiWgotw/ozlyzA
         NVOUiLnkEHgCMAVCBia1/YrcDu2pCI2pTfX92Rz5HmSsXR6c522SBwSJ1zyNHRx6Q/ez
         kvw68dBDhX5nSfgst2Gn5V0QCVXF7JpNNblmLkGdW24uP5O+Zq+iUzlMmD24pOTma7gm
         2awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=bBoaUCOTWw/Q1lsXklByX+UelIgt865AyYJ9aA0n4BA=;
        b=s426dthYqfsedLJju/g7AWQjpHGnFFQdl5RXnRRqrH8DXbfRzat3p2VjLaBopTquDl
         jsDdECzsWE8vGB+Ybk5cghuvgeJOO97LlfEpzhMPAGTFZ6/ScgmbUv7C+Zm6ijdAG6l/
         O7kuNxc64Vhn0+pqn5X5j43Ya152JmZmjhZVWu4xrb64skWCjjrj8p2TAyy0S3uBpjBj
         sN+XX0k0/rFxDw938q2XNhSigvIWVgIR8lDEy+CCWvNzCCTd6XP1K/rSxhuVaq4KR2l9
         L9ERGScADyT48RYyK6ByHNQW+j3c2el455c/MwaPGpwpqWIozjDmWHSkHZGGUl9ONrNc
         1tLQ==
X-Gm-Message-State: APt69E1n7YUKlJNtWlF8GrPFVPLQIu14ftPMS60jBV5RmYahgQp3l8Kj
        mRslnBKj+GHcSlFy0RGpujuqYL+E
X-Google-Smtp-Source: ADUXVKJdiX0yWzjJBFj5eXKyhym7cKjFlWxpxq4w8m2XvJ/at+6RU/whj9gx9Y6DTNlVOGWdO1kQ4g==
X-Received: by 2002:a2e:9d5:: with SMTP id 204-v6mr181563ljj.40.1528807601190;
        Tue, 12 Jun 2018 05:46:41 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id r23-v6sm15892ljj.86.2018.06.12.05.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 05:46:40 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@xi.terra>)
        id 1fSigj-0001hb-OB; Tue, 12 Jun 2018 14:46:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH 2/2] EDAC: i7core: fix memleaks and use-after-free on probe and remove
Date:   Tue, 12 Jun 2018 14:43:35 +0200
Message-Id: <20180612124335.6420-2-johan@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612124335.6420-1-johan@kernel.org>
References: <20180612124335.6420-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to free and deregister the addrmatch and chancounts devices
allocated during probe in all error paths. Also fix use-after-free in a
probe error path and in the remove success path where the devices were
being put before before deregistration.

Fixes: 356f0a30860d ("i7core_edac: change the mem allocation scheme to make Documentation/kobject.txt happy")
Cc: stable <stable@vger.kernel.org>     # 3.6
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/edac/i7core_edac.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 8c5540160a23..23e441dbaf49 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1177,15 +1177,14 @@ static int i7core_create_sysfs_devices(struct mem_ctl_info *mci)
 
 	rc = device_add(pvt->addrmatch_dev);
 	if (rc < 0)
-		return rc;
+		goto err_put_addrmatch;
 
 	if (!pvt->is_registered) {
 		pvt->chancounts_dev = kzalloc(sizeof(*pvt->chancounts_dev),
 					      GFP_KERNEL);
 		if (!pvt->chancounts_dev) {
-			put_device(pvt->addrmatch_dev);
-			device_del(pvt->addrmatch_dev);
-			return -ENOMEM;
+			rc = -ENOMEM;
+			goto err_del_addrmatch;
 		}
 
 		pvt->chancounts_dev->type = &all_channel_counts_type;
@@ -1199,9 +1198,18 @@ static int i7core_create_sysfs_devices(struct mem_ctl_info *mci)
 
 		rc = device_add(pvt->chancounts_dev);
 		if (rc < 0)
-			return rc;
+			goto err_put_chancounts;
 	}
 	return 0;
+
+err_put_chancounts:
+	put_device(pvt->chancounts_dev);
+err_del_addrmatch:
+	device_del(pvt->addrmatch_dev);
+err_put_addrmatch:
+	put_device(pvt->addrmatch_dev);
+
+	return rc;
 }
 
 static void i7core_delete_sysfs_devices(struct mem_ctl_info *mci)
@@ -1211,11 +1219,11 @@ static void i7core_delete_sysfs_devices(struct mem_ctl_info *mci)
 	edac_dbg(1, "\n");
 
 	if (!pvt->is_registered) {
-		put_device(pvt->chancounts_dev);
 		device_del(pvt->chancounts_dev);
+		put_device(pvt->chancounts_dev);
 	}
-	put_device(pvt->addrmatch_dev);
 	device_del(pvt->addrmatch_dev);
+	put_device(pvt->addrmatch_dev);
 }
 
 /****************************************************************************
-- 
2.17.1

