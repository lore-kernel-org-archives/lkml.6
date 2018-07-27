Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD835C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522EE20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F83HHjR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522EE20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbeG0FEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:04:21 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41731 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeG0FEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:04:20 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so1713564ply.8;
        Thu, 26 Jul 2018 20:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5UmX7FBH46w04MxobJWSRzfyKYqJnefAltJO3HUXG9M=;
        b=F83HHjR6iVAE4gwlunqRsy3MhznBBni3wFNJmC8ODVfSWkv5I1SLzqSbC4yX296tpc
         kcSaahUdgxa5xAiGX1n24MZx4jMmYxMWvr02v1dnRjhuVbpCJ1p7yv46Wwgb5VCOSdAq
         jYblGvVo0WQ5QqZZ1Zew3EydqlyStWYfNnWKB6uzGL6YhkDNZDgYzrzhmhnmpQs8gUAc
         XDrFPISZFoy5ns8B7wqIQYsBci8AC/5euW4MHaTte+xOI+Z6ADTTrZOMvJXMohujmb0s
         wSVhYIrYftCcAOZZLOiulp8KEo3Fgzy5Rx6OSqET6ncRxZnTch3jlQaMfzxX/dkqJxb3
         iHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5UmX7FBH46w04MxobJWSRzfyKYqJnefAltJO3HUXG9M=;
        b=iJ/L7z9UKHUhcz0Qmjo4vjbEq6V9IAfRXlWV8d2jyZLbaKSMoUHCSE0NxinCAfezcn
         UgOTfnwo+0le8IYUJBmRQbACo3hkka3uXO3QmzWwD1zMgOzWtczlISTvgJLhr4Zl+UJu
         J39i4DXZrZh8NHkux191TYYqpTck8AfPychdKBVX1ckU0HxsK0Jj5kFbz0+LQ46/S+T/
         M5KVuId9wxgiPgEups6jI5ZpLmWsl7OAsXQS724UblKJHhrE6nXFqo+6CvTMZ5VB2JNR
         rysJ3OxL4Lk/2lIQivYkRqrtUGIWPqExhUyBRaBmLDCM9e9f2OPWoz8Xa5yev7II0ZrG
         jgkQ==
X-Gm-Message-State: AOUpUlGENO6ZsLymOa0zkGzKSK4pHbEVtV9+UfFREWKGeTPVBGdSsfiV
        Y3W03RRpa5VBMnKBQswFcKM=
X-Google-Smtp-Source: AAOMgpcdykjGf2QFHedEitsSv71merLCe8tmBxBkOH7QBdoSFnnItf7e5eIDbN55A7Js6nNryJGBXw==
X-Received: by 2002:a17:902:4503:: with SMTP id m3-v6mr4458054pld.168.1532663070675;
        Thu, 26 Jul 2018 20:44:30 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id 14-v6sm4769662pft.93.2018.07.26.20.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:44:30 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     awalls@md.metrocast.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] media: pci: ivtv: Replace GFP_ATOMIC with GFP_KERNEL
Date:   Fri, 27 Jul 2018 11:44:24 +0800
Message-Id: <20180727034424.4405-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ivtv_probe() and ivtvfb_init_card() are never called in atomic context.
They call kzalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/pci/ivtv/ivtv-driver.c | 2 +-
 drivers/media/pci/ivtv/ivtvfb.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-driver.c b/drivers/media/pci/ivtv/ivtv-driver.c
index 6b2ffdc96961..dd727098daf4 100644
--- a/drivers/media/pci/ivtv/ivtv-driver.c
+++ b/drivers/media/pci/ivtv/ivtv-driver.c
@@ -999,7 +999,7 @@ static int ivtv_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
 	int vbi_buf_size;
 	struct ivtv *itv;
 
-	itv = kzalloc(sizeof(struct ivtv), GFP_ATOMIC);
+	itv = kzalloc(sizeof(struct ivtv), GFP_KERNEL);
 	if (itv == NULL)
 		return -ENOMEM;
 	itv->pdev = pdev;
diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
index 8e62b8be6529..1d7d10367d55 100644
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@ -1178,7 +1178,7 @@ static int ivtvfb_init_card(struct ivtv *itv)
 	}
 
 	itv->osd_info = kzalloc(sizeof(struct osd_info),
-					GFP_ATOMIC|__GFP_NOWARN);
+					GFP_KERNEL|__GFP_NOWARN);
 	if (itv->osd_info == NULL) {
 		IVTVFB_ERR("Failed to allocate memory for osd_info\n");
 		return -ENOMEM;
-- 
2.17.0

