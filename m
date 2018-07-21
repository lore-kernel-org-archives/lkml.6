Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229A6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08EA20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2EnJfw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08EA20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbeGUNu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34820 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbeGUNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6-v6so9024464pgv.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MG6jsLkszC3R0FeIrd5LjxKJQBeR0pBYt0FFTyPwqHE=;
        b=a2EnJfw4SyMk6RX1OOr0MY11UxJiJeNWQ276ipMNmBpOgvs8VC3D6c18OYkekuyflX
         dqx6yGDWY0IRiOoZ/3IPTvQ/MhT9UL0TFPNxAhpqaPWZd2By0QBa0TJ5qhn3BPGcp7O/
         aVjwhLUL9zwNBHyeWq/A5v/9pav7kPouwAO8gSYjQMNXvpw2lB9homQEWWiU0NM49ocU
         xIlZyAxQU66WTqZigGteYXSLyFELYRipsjkoF55hfNXJ8gUsw8fQJJYBC36HoGbi9AQl
         Vfdq1gYOU0LXvgOrl/MTMkKdywka2fl9vS8/RoT6I3DzVLm/YS9Bu1lp4eVgy27OOOhu
         2s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MG6jsLkszC3R0FeIrd5LjxKJQBeR0pBYt0FFTyPwqHE=;
        b=FoBGc8QeE3/yu5NoG18CKAAeCovfstncJFlK/p4vDdvKStTnB6DE8VtFbxpyA3IHpF
         64PTsu7+KezE3LmUcbQLbhwvjFgjyi4VKIQKqu7PCX+ied1xp+oeGZiy/dQLLbETwkiJ
         +2pQPuUvaciQVajVXCydCEws94zC+QIuJoX7j0XwBj/scg0NBmuPENNvVhWfH4V+LUkr
         GGuZLqNpLzcARnzk39REWvH2U/9ZtmQXuqBmwlFNIZwLTBM35NIFPQ9z21CLuVFUoa+j
         7ToE1Ta/qlDSpbxRDKi72u0GeN8rtkjEWC6P3wSSpoCwB+mxLFl5NUrUnMLgTIOeyTgh
         BzRw==
X-Gm-Message-State: AOUpUlFTmO+a56LxK3NJlcaGzAz3lkZLJbfgXL20e+Q2R3K74iCEDAd+
        SGzNaot8hAhWrt4maIVyTu4=
X-Google-Smtp-Source: AAOMgpfhVUz23864R9nNGlGFbCgBqt5rs96L73rfj8WIeXvD7tjEJYWwA1mUDZefczkAD1ee5rAS9g==
X-Received: by 2002:a62:6eca:: with SMTP id j193-v6mr6035125pfc.256.1532177866620;
        Sat, 21 Jul 2018 05:57:46 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:46 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 08/14] staging: gasket: apex return error on sysfs show of missing attribute
Date:   Sat, 21 Jul 2018 05:56:54 -0700
Message-Id: <20180721125713.88501-16-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Apex sysfs show function return -ENODEV if the attribute is not present,
rather than silently failing from the standpoint of the userspace
accessor.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 3e76c4db5db2e..1c6f73b5a2a9e 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -710,14 +710,14 @@ static ssize_t sysfs_show(
 	gasket_dev = gasket_sysfs_get_device_data(device);
 	if (!gasket_dev) {
 		gasket_nodev_error("No Apex device sysfs mapping found");
-		return 0;
+		return -ENODEV;
 	}
 
 	gasket_attr = gasket_sysfs_get_attr(device, attr);
 	if (!gasket_attr) {
 		gasket_nodev_error("No Apex device sysfs attr data found");
 		gasket_sysfs_put_device_data(device, gasket_dev);
-		return 0;
+		return -ENODEV;
 	}
 
 	type = (enum sysfs_attribute_type)gasket_sysfs_get_attr(device, attr);
-- 
2.18.0.233.g985f88cf7e-goog

