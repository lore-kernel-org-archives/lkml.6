Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502F3C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45D020673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhSzN8Y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45D020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeG0FHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:07:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38200 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeG0FHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:07:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so2406487pgq.5;
        Thu, 26 Jul 2018 20:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FAz28giP30tTtKMNzD3J2A75r00iuvGNmBVlkqtctcQ=;
        b=XhSzN8Y7OljFAQHWpludtSWdITsO16BODhW4JXbjnWU/npFr9HYd1PtF8GZ6u8YKus
         MWQL2Qvvz2xirN3kYQtV1+J4czDeTu5ZIO8rABI1mJlyzwlEN8HcG+VqPE9wXGHfHzs4
         voCGK7VB4iIXhGs3t0xHZTluKyM8KR91vcAT49e/uPyLsLLPtcjGa87BFcmcUNWONiv0
         qSHcbuiRZgzWrHPAJKpk9vU84SZpB5FmMrZqcl/qyDgUCAojXrzeZyjiRFSBiFz/8gU5
         LpRvPH7trviJnx7wBmDHHkrUTjs+B8pp7bFeJbmKc8foDdu/KOUgda1UHxEk98926Ynj
         bekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FAz28giP30tTtKMNzD3J2A75r00iuvGNmBVlkqtctcQ=;
        b=bXGLjAfYZTsxWpprmMx//BFjHFBcESrccFGQbgiKKSICzJltkKHvKivhpicjCRceQQ
         m05UzGQqnRKKgRrwDTIPilu0t3CuO49IBgSIzdxqVZWf82Q6+YGc7gF8mJ8JGQt18eGH
         mMt0/xLfy80fe978rdeZCf+2XKrRb1nVL5JOnFOHsQTGaWbGrWMI+2APwrqHdzk1V0Zh
         69KURI8a/ocL75dOOb64Z3Z3qWRjqaRyXxcJpJwyEF2ZpdtI5HpD9SuhcLjhJ9tnwNbS
         1FJ+AgFlVNTWNawFti/Ydfl8xgdNWB1W8bx8Fie11SuyFxuC+xoirwpRAWinOSulk9Tm
         6t8Q==
X-Gm-Message-State: AOUpUlGLOt9tkXWxwv7F9miz2isvuNmPt97CQpK4W05sPs7T1/zDPNbk
        Gstl99UDkjO9YFqi6ahyIf4=
X-Google-Smtp-Source: AAOMgpeVaJ/WHxLu/0JcyaA7vLYg8Q3yRNvz7ibAlm5vigjwAKGc9cJI22hb+GkPRJoy2NOz8hf9Gg==
X-Received: by 2002:a62:89d8:: with SMTP id n85-v6mr4811633pfk.83.1532663267037;
        Thu, 26 Jul 2018 20:47:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id p8-v6sm4199668pfk.186.2018.07.26.20.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:47:46 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] message: fusion: Replace GFP_ATOMIC with GFP_KERNEL
Date:   Fri, 27 Jul 2018 11:47:39 +0800
Message-Id: <20180727034739.4513-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpt_attach() and mptfc_probe() are never called in atomic context.
They call kzalloc() and kcalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/message/fusion/mptbase.c | 2 +-
 drivers/message/fusion/mptfc.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 51eb1b027963..64aee8c96641 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -1779,7 +1779,7 @@ mpt_attach(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct proc_dir_entry *dent;
 #endif
 
-	ioc = kzalloc(sizeof(MPT_ADAPTER), GFP_ATOMIC);
+	ioc = kzalloc(sizeof(MPT_ADAPTER), GFP_KERNEL);
 	if (ioc == NULL) {
 		printk(KERN_ERR MYNAM ": ERROR - Insufficient memory to add adapter!\n");
 		return -ENOMEM;
diff --git a/drivers/message/fusion/mptfc.c b/drivers/message/fusion/mptfc.c
index 6d461ca97150..1febf4dfa944 100644
--- a/drivers/message/fusion/mptfc.c
+++ b/drivers/message/fusion/mptfc.c
@@ -1292,7 +1292,7 @@ mptfc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* SCSI needs scsi_cmnd lookup table!
 	 * (with size equal to req_depth*PtrSz!)
 	 */
-	ioc->ScsiLookup = kcalloc(ioc->req_depth, sizeof(void *), GFP_ATOMIC);
+	ioc->ScsiLookup = kcalloc(ioc->req_depth, sizeof(void *), GFP_KERNEL);
 	if (!ioc->ScsiLookup) {
 		error = -ENOMEM;
 		goto out_mptfc_probe;
-- 
2.17.0

