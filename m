Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809D1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405F52086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw4B6iW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405F52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeK2DFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:05:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42108 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeK2DFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:05:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so10359359pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 08:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DdzvoSy2h2u5B6dtluZVRVLXIvWmyO3wmCU9GEAMkSM=;
        b=Gw4B6iW+qdnhgfd/FAdkgikS8HhOs7Vp4qshaFNkY1Sn4wGxu5fuJaA9NnFgkNcwtU
         xaXhVkJR/bRpuVlCYV9f5hNZBBU/TjiiktSjbaVttBmKZScI3Ztcwf+eSmeHkQErb/nH
         eycWmvoUbmXn6JhmAbKHiC0EWL0ycY2L61vGtmcEaT9eRyFM18OIOS378aaFNfDA90JZ
         cL/BN7qXssFBFuQuHpTViq//5v9hEM80LJgGO1XPgXDM8xqgv59OAmKr4PQ7l/ZU7AxF
         /CqZLRvxdg+1e60IgIErySjA3/WsSCQG5EsFDBifS+S78vg1oW1BC8hW0GtofZA+dxKs
         fuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DdzvoSy2h2u5B6dtluZVRVLXIvWmyO3wmCU9GEAMkSM=;
        b=JQjoRL11YWWDmJ7ONfWAD9DljMV9rFi/4HuzA1MNTxGO+HzaJUbFtclmEuRlmIvqbF
         gdIDldrJkInFATukruYxhazsAf3eKNYEQ1DawYURAi8UKxL2RC0bVW2cvZlZO9Iec9ha
         IojOOTGjCDBIo7Y3HcmoQgk5m46aqGcYNBD1SmottTS8WRdO7oo2nZKmYL3nro3nH6dB
         mABg57GimItLYUQzw1vUjNl212n4yTffjRvpuBi3mnf9sQsA5fNiDBYjYxO/Q4w0IC5k
         Q8Mh9HvT42YESWA+w5UV6/EmPJvD7DvxWYH7I0qERN8RgT5J028wONJo6OBaAVRu4jVk
         Mmpw==
X-Gm-Message-State: AA+aEWYqr/8+yVO0UyYd+gCRO+ypbvzo6IUCOWrNciZE7Cw/E/FZn+SX
        l4CsIDQomQJkhPL8OG96uCc=
X-Google-Smtp-Source: AFSGD/X1GT11cRqXSVolBssxMlmRV2EfyhgjU8hjLzuAeITqOlhoMQX67bvPJHlFkb7YqkY3UM1FXQ==
X-Received: by 2002:a63:e711:: with SMTP id b17mr32685960pgi.363.1543420984721;
        Wed, 28 Nov 2018 08:03:04 -0800 (PST)
Received: from ubuntu.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id i123sm15823809pfg.164.2018.11.28.08.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 08:03:04 -0800 (PST)
From:   Kaitao Cheng <pilgrimtao@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, smuchun@gmail.com, pilgrimtao@163.com,
        linux-kernel@vger.kernel.org, Kaitao cheng <pilgrimtao@gmail.com>
Subject: [PATCH RESEND v2] driver core: Replace simple_strto{l,ul} by kstrtou{l,ul}
Date:   Wed, 28 Nov 2018 08:02:49 -0800
Message-Id: <20181128160249.6082-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaitao cheng <pilgrimtao@gmail.com>

The simple_strto{l,ul} are deprecated, use kstrtou{l,ul} instead.

Signed-off-by: Kaitao cheng <pilgrimtao@gmail.com>
---
 drivers/base/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd7..ed145fb 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -794,10 +794,12 @@ ssize_t device_store_ulong(struct device *dev,
 			   const char *buf, size_t size)
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
-	char *end;
-	unsigned long new = simple_strtoul(buf, &end, 0);
-	if (end == buf)
-		return -EINVAL;
+	int ret;
+	unsigned long new;
+
+	ret = kstrtoul(buf, 0, &new);
+	if (ret)
+		return ret;
 	*(unsigned long *)(ea->var) = new;
 	/* Always return full write size even if we didn't consume all */
 	return size;
@@ -818,9 +820,14 @@ ssize_t device_store_int(struct device *dev,
 			 const char *buf, size_t size)
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
-	char *end;
-	long new = simple_strtol(buf, &end, 0);
-	if (end == buf || new > INT_MAX || new < INT_MIN)
+	int ret;
+	long new;
+
+	ret = kstrtol(buf, 0, &new);
+	if (ret)
+		return ret;
+
+	if (new > INT_MAX || new < INT_MIN)
 		return -EINVAL;
 	*(int *)(ea->var) = new;
 	/* Always return full write size even if we didn't consume all */
-- 
2.7.4

