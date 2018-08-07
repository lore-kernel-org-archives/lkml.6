Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFB9C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AC321A13
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpkbEmUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AC321A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeHGH1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 03:27:12 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33950 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeHGH1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 03:27:12 -0400
Received: by mail-qk0-f196.google.com with SMTP id b66-v6so10612611qkj.1;
        Mon, 06 Aug 2018 22:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ECg5tW3IEA5yaNPnCr5GWtcBdddZ85KRBwnE2L4stZY=;
        b=WpkbEmUsmxF5wnzM7mKxsU2kPxWcuuURpFpjwHauj/4i5wuq35bk2G4fyJrezh9/md
         7vFvcpZtFlFIGHtP5l8KFuUEPMEswRs09EGM3OdCt+xPorEdxzKDvGo4OuGpGEt/BNed
         UBV0K5yfHU6on+dp7IT3kOa7fjJO+i5uhFuHcO2k0A6eKK2IIS7t+Aqs2nSoXdF0GnHC
         FZcnmi36fU46EM9q9YJSu6WtEeeIqUGLhZQOLNiAK9TTbMyW9s+1Gzv3M2u3B9bL36YA
         y7pmubPaKVh8fJSs340uLSmJhYlOEtM3X6Qoo/tctwMHsHnlgerpbzZKh5CltCLUtMIP
         LzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ECg5tW3IEA5yaNPnCr5GWtcBdddZ85KRBwnE2L4stZY=;
        b=ZvJzKptT9LU8KjaGHZ4WCpf0twAw3nlqCzVUpGGWMHbAMKuX9tprDxOTClcMdFwZqV
         ICkkFuCVlLmVho+P8U4UB7A8/SHJkA6lV40o8N90Zw6PXdZ/6DkmBt0MD/2vFYjhJ6ys
         Tddq2Y2f9Qjaf2u6YB22+yFWzml5w+2D7tkM4s5FLYubka0IWcB/sDi5+kLyvE3LA7dh
         OQydxgefbBkMxjkN28r1L/GHDaU5uEeDe15EuJ1Lhm8WXX6eiZoIHprsd8Mf3FYhzQUg
         3yC+4hcGalg6XUv1CC2HH1y8m8EQGGvF++/3aftHcWQ0IvsLrqyBtiYITVI1MS5yuB7g
         dOWQ==
X-Gm-Message-State: AOUpUlEngDXt7p2iTXg11i3tyb6M4FT8k8IPMIhcmgubelrBXT1l8e9Y
        99fSAJO2FLfG/GPK45zNsoA=
X-Google-Smtp-Source: AA+uWPxJU0gRkISG2DvujlgR0S7Ey1eNnVhNZWMmsWwEwvZfK9mSv2IK+hKtZum790q8Ab3PtX5THw==
X-Received: by 2002:a37:2bc9:: with SMTP id r70-v6mr10644378qkr.141.1533618878565;
        Mon, 06 Aug 2018 22:14:38 -0700 (PDT)
Received: from localhost ([67.22.19.206])
        by smtp.gmail.com with ESMTPSA id d2-v6sm239270qkj.76.2018.08.06.22.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 22:14:37 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     aacraid@microsemi.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dzm77@ist.psu.edu, Dongliang Mu <mudongliangabcd@gmail.com>
Subject: [PATCH] requesed -> requested
Date:   Tue,  7 Aug 2018 01:14:29 -0400
Message-Id: <20180807051429.19077-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/scsi/aacraid/commsup.c | 2 +-
 drivers/scsi/aacraid/dpcsup.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index d62ddd63f4fe..6e1b022a823d 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -514,7 +514,7 @@ int aac_fib_send(u16 command, struct fib *fibptr, unsigned long size,
 	 *	The only invalid cases are if the caller requests to wait and
 	 *	does not request a response and if the caller does not want a
 	 *	response and the Fib is not allocated from pool. If a response
-	 *	is not requesed the Fib will just be deallocaed by the DPC
+	 *	is not requested the Fib will just be deallocaed by the DPC
 	 *	routine when the response comes back from the adapter. No
 	 *	further processing will be done besides deleting the Fib. We
 	 *	will have a debug mode where the adapter can notify the host
diff --git a/drivers/scsi/aacraid/dpcsup.c b/drivers/scsi/aacraid/dpcsup.c
index 417ba349e10e..ddc69738375f 100644
--- a/drivers/scsi/aacraid/dpcsup.c
+++ b/drivers/scsi/aacraid/dpcsup.c
@@ -65,7 +65,7 @@ unsigned int aac_response_normal(struct aac_queue * q)
 	/*
 	 *	Keep pulling response QEs off the response queue and waking
 	 *	up the waiters until there are no more QEs. We then return
-	 *	back to the system. If no response was requesed we just
+	 *	back to the system. If no response was requested we just
 	 *	deallocate the Fib here and continue.
 	 */
 	while(aac_consumer_get(dev, q, &entry))
-- 
2.18.0

