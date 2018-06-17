Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E36C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8E420693
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klak7P7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8E420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933277AbeFQLRD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 07:17:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44413 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754255AbeFQLRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 07:17:02 -0400
Received: by mail-pf0-f194.google.com with SMTP id h12-v6so6834376pfk.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 04:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XbyL4z96xfT3YlWw8BGvtGOlSct9gr9UlwfO+ED5Xsc=;
        b=klak7P7sqevcta86Mmxlo42WJKai1jIZBm5JVtr0b5GuvpDWtZKxChIUx3Jx/P7FYT
         JaKcouNxCccIt7qWJICndlqXq7tCPugLoDrO7bjt76kWgYeCac70uXWdpiQrFuBzZNbi
         nocsRCv4urJgiZLWNKqSaK+MDsWIXvhGCjskpzHbhiOquoQ3oeYINij07Orl98kos5Iu
         0NxqOWAOH0gH0xM5SsuFIAlDX8LKgMA4F8TkdV3gbw4ItKwL4VVG0GDAPfSxV4sJu6BP
         ilagHJqvLYblEn8wDXxWLVgcT4J1h6nltNQtPy/0GLNmDtaR+Dm+YZrnj9G9X1mwNsef
         JKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XbyL4z96xfT3YlWw8BGvtGOlSct9gr9UlwfO+ED5Xsc=;
        b=WeG2Fexr87X+g/6ZYD32UJbKKeY8NvIHvvrulMe9x3hZQqncsMchYSfYg0DYsVzul3
         v4wDEU/rky8rB8A7V4+78CXboiWfvZRJFET/CtQsRrq7rRFSQznCfPnViOZVjxqAWq0l
         bjXvl8S6b8rh7d/MVxqnVI8ylL9IlqKS774oE0S8Qg7TzV2BWZA9dOkfPTxZYTkv6pFH
         WXi5qfsVXbNnwUe6ew2k4SdJXhcXqjrNS2sDIKQSzd71evL11VuXuZXYFT7NHDPgHTxZ
         CNsRJdFPhYjQmbilGhu465e/wNqNkj1DciDzPnppJi03AWMKTg9p5TB7XKhVqwbyYkhj
         WP/A==
X-Gm-Message-State: APt69E1pa7+UbnOF+zg5MrluMkiTWoTaHIogCPD1tiuzg7a6Du6RPiI8
        fdpVRqeDa23kuS7CG290aPuFnQ==
X-Google-Smtp-Source: ADUXVKIOa1LrtHE4wFV/d7vnhqrj9cUnpVmIxMLjQS2kswZjWjqByT55O3up5Y3bNVtcEpNFPjh92Q==
X-Received: by 2002:a65:56c1:: with SMTP id w1-v6mr7724265pgs.227.1529234222202;
        Sun, 17 Jun 2018 04:17:02 -0700 (PDT)
Received: from shreeya-VirtualBox ([103.212.140.156])
        by smtp.gmail.com with ESMTPSA id o65-v6sm16178047pga.75.2018.06.17.04.17.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 04:17:01 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     oleg.drokin@intel.com, andreas.dilger@intel.com,
        jsimmons@infradead.org, gregkh@linuxfoundation.org,
        lustre-devel@lists.lustre.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH] Staging: lustre: Use kmemdup() instead of kzalloc and memcpy
Date:   Sun, 17 Jun 2018 16:46:55 +0530
Message-Id: <1529234215-4010-1-git-send-email-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace calls to kzalloc or kmalloc followed by a memcpy with
a direct call to kmemdup to shorten the code.

The Coccinelle semantic patch used to make this change is as follows:
@@
expression from,to,size,flag;
statement S;
@@

-  to = \(kmalloc\|kzalloc\)(size,flag);
+  to = kmemdup(from,size,flag);
   if (to==NULL || ...) S
-  memcpy(to, from, size);

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/lustre/lnet/lnet/api-ni.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/lustre/lnet/lnet/api-ni.c b/drivers/staging/lustre/lnet/lnet/api-ni.c
index f9ed697..36ea14e 100644
--- a/drivers/staging/lustre/lnet/lnet/api-ni.c
+++ b/drivers/staging/lustre/lnet/lnet/api-ni.c
@@ -1271,15 +1271,14 @@ lnet_startup_lndni(struct lnet_ni *ni, struct lnet_ioctl_config_data *conf)
 		lnd_tunables = (struct lnet_ioctl_config_lnd_tunables *)conf->cfg_bulk;
 
 	if (lnd_tunables) {
-		ni->ni_lnd_tunables = kzalloc(sizeof(*ni->ni_lnd_tunables),
+		ni->ni_lnd_tunables = kmemdup(lnd_tunables,
+					      sizeof(*ni->ni_lnd_tunables),
 					      GFP_NOFS);
 		if (!ni->ni_lnd_tunables) {
 			mutex_unlock(&the_lnet.ln_lnd_mutex);
 			rc = -ENOMEM;
 			goto failed0;
 		}
-		memcpy(ni->ni_lnd_tunables, lnd_tunables,
-		       sizeof(*ni->ni_lnd_tunables));
 	}
 
 	/*
-- 
2.7.4

