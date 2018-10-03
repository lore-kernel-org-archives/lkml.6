Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791F4C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6EE205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/Br6iBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6EE205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJCM04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:26:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35864 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJCM0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:26:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id b7-v6so1115775pfo.3;
        Tue, 02 Oct 2018 22:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=z9CwLD0k5YiJjok0Y71vUUmqjQPguT7a+6nipaDQNPQ=;
        b=N/Br6iBqUBH7v3/lOCQagf+Ey8ayM7vBx0E0lNVo0XlMSzUPyt/ILU3+PSGr1+XS83
         HQTHK6ylUv2DWsWhgbTIJH7kuDRAbs/qHPcg+FEkoT0wgJQztdS3aIpBAXT2LRwqr1So
         iVJgXaqJJw8dvNBTgHnkCSI8Yuo2E++1LqlA6P0TpIZJ0/WzXTbb5/v0CFD170Exz5YL
         rXqF3sD7IxTtBM4z9v9zsSyxloKcNbPck+kENCd/spTd2KADd9lqhOlzHSKzfjUylD4J
         WwjzMPfXm9LXO+x7xwOMuT5avRP/gV+hKDOQDAAN4IEZcZCwslAnetd+yq9kVxLEy2pX
         fhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=z9CwLD0k5YiJjok0Y71vUUmqjQPguT7a+6nipaDQNPQ=;
        b=qvZvenso9QYcTsjGblPfUHvEv1f0fALkj+vpD6y9GzW7eUR9RUMKZDPum5kkbnVIFE
         kQWaSvau4DIAELSGP9L3dBGgJC1MZ3Zdbq8weEI765N73OeojUYB9fY1nmSUQ+AtAfri
         VstHlALftTWcObljSYvXCusiDm43JtLa8I6j23L0eV9o7Oe9ke5ym4jLxMvdy1EOGpwW
         xUVnAMe3tDls67jDVgePKRU1vScP9mACxDihCOMGplarK8P7iLI8IYET/9QVWFpR2om4
         olGVBH2V9uat8QFP+unCrxboKmQY9cazBDqo1DY0ypoDOTMFkM5O92dLcuculSVCPQSN
         QM0w==
X-Gm-Message-State: ABuFfoiMepxp2IwVfYT5BrwEYepTIGEj7Ik4LvfC3Wze/tijpl9/eYnB
        erw1xAX/tBpQIYxmBPriPYI=
X-Google-Smtp-Source: ACcGV63hgRct5dztJFWFxbdPEHdvRUPpv97sRK8L9CvA91bYRR8VFUHVAuAJk207gOodRSXisJpVSA==
X-Received: by 2002:a63:1d62:: with SMTP id d34-v6mr7880143pgm.180.1538545205503;
        Tue, 02 Oct 2018 22:40:05 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id o85-v6sm752811pfk.94.2018.10.02.22.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:40:04 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 267281643D0; Tue,  2 Oct 2018 22:40:04 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 09/16] scsi: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:38:55 -0700
Message-Id: <20181003053902.6910-10-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003053902.6910-1-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
Reply-To: Lance Roy <ldr709@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep_assert_held() is better suited to checking locking requirements,
since it won't get confused when someone else holds the lock. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Karan Tilak Kumar <kartilak@cisco.com>
Cc: Sesidhar Baddela <sebaddel@cisco.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: <linux-scsi@vger.kernel.org>
---
 drivers/scsi/snic/snic_scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/snic/snic_scsi.c b/drivers/scsi/snic/snic_scsi.c
index d9b2e46424aa..42e485139fc9 100644
--- a/drivers/scsi/snic/snic_scsi.c
+++ b/drivers/scsi/snic/snic_scsi.c
@@ -2001,7 +2001,7 @@ snic_dr_finish(struct snic *snic, struct scsi_cmnd *sc)
 	}
 
 dr_failed:
-	SNIC_BUG_ON(!spin_is_locked(io_lock));
+	lockdep_assert_held(io_lock);
 	if (rqi)
 		CMD_SP(sc) = NULL;
 	spin_unlock_irqrestore(io_lock, flags);
@@ -2604,7 +2604,7 @@ snic_internal_abort_io(struct snic *snic, struct scsi_cmnd *sc, int tmf)
 	ret = SUCCESS;
 
 skip_internal_abts:
-	SNIC_BUG_ON(!spin_is_locked(io_lock));
+	lockdep_assert_held(io_lock);
 	spin_unlock_irqrestore(io_lock, flags);
 
 	return ret;
-- 
2.19.0

