Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2215C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970EF20891
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQeY51hY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970EF20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeG1Gra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 02:47:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33780 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeG1Gra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 02:47:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so4361134pgv.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 22:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g3DTaHMBk0c8q3SaHSbQjN4q2FsVZK91rmELZp2hvhg=;
        b=rQeY51hYGX+CBI3/cylMmRWecV6G9+N9z87ikANskr97TJHxy08HVTOE9FFEihiRhP
         peO/df7poUvZeBmZieGI4Oi/3DXEAmX7THA0X9K+a7ygEtLQnYY3GYVm5lrE8eAN3GRm
         WY/i+Wi139EovySnVbna574zrZAfpd5DAS9gRucXn1LNRHB4JAlrd3UcrkAnugvnsdTu
         MMiQV8jdwExEiH6qKhNbotFn51to/nnPmX0V8d1tAUrlfj35+8PWNw/efPyOstOSISwP
         ZH1sprxtMOyVPC9kF9qO4K0L1mnnnGnrL2wLSb3bBc/g4kh2chGv2WzumXrwMH5hrFCv
         u26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3DTaHMBk0c8q3SaHSbQjN4q2FsVZK91rmELZp2hvhg=;
        b=fQXLRQ4c4UK3SvBO6UbDhLy/HXKu3CcGrH2gJAHWwEN5G+D+koeW4ZKfxgDvM+gfn1
         aD37KaHTjvmJ7twCrBWxJlzMaeDLE+kZkFjN/OzrInzBvnmCBwJVlOtVYVwu9lL6vPza
         4rK+5LhrC8PpaK+vqdjOsEOYy/sf1AvekppgIEMoTcYZBAeO9mi28ofxhWBwxix+z77A
         w5GlHOtJeY09eubJLvBXY6KKcmjMZ2q77DQUphDFzO4IevskNN7FVBj3gYn16l7Z6fX0
         FYs8KJEuwYFsDaKlwPKQ4UPTEvj6dDgAxKw6jLpde5/aERTYoOSPRuMH5qMKBICToLw/
         geeA==
X-Gm-Message-State: AOUpUlGhUj3IF8LlnaluiWAP9hWud8Ogbsa1+CwNiq+nz01kUNX4Lk9o
        jOQ8H6VAeoaqwP4CNuoiZbY=
X-Google-Smtp-Source: AAOMgpfeJ18KRiN6xj8p5fvg6xyp0wEeBlzvjwupUDQxIrZiL4/fQrpdyX5Ocqzuyv2iKUH5ujbGFA==
X-Received: by 2002:a63:4d5:: with SMTP id 204-v6mr8587840pge.129.1532755343167;
        Fri, 27 Jul 2018 22:22:23 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id y85-v6sm8837195pfa.170.2018.07.27.22.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 22:22:22 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 3/5] staging: gasket: sysfs: remove unnecessary NULL check on device ptr
Date:   Fri, 27 Jul 2018 22:21:58 -0700
Message-Id: <20180728052200.228796-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180728052200.228796-1-toddpoynor@gmail.com>
References: <20180728052200.228796-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The device pointer passed into get_mapping() will never be NULL; the
check is unnecessary.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index 2d8647de697cd..da972ce0e0db0 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -67,11 +67,6 @@ static struct gasket_sysfs_mapping *get_mapping(struct device *device)
 {
 	int i;
 
-	if (!device) {
-		pr_debug("%s: Received NULL device\n", __func__);
-		return NULL;
-	}
-
 	for (i = 0; i < GASKET_SYSFS_NUM_MAPPINGS; i++) {
 		mutex_lock(&dev_mappings[i].mutex);
 		if (dev_mappings[i].device == device) {
-- 
2.18.0.345.g5c9ce644c3-goog

