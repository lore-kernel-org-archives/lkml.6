Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7F0C18DF5
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002F222419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qewFqXv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002F222419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbeKMGkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:40:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54041 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbeKMGkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:40:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id f10-v6so9790945wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 12:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xscVXSYp1r/J/AX8d0FmFgSQZTJqSlZgSwnOfa2N4jY=;
        b=qewFqXv9auGSFUZ3MyAO+VG/O3wk1tSa9gedrByqYsdNLy+mZtiIAa104u1rBHavjb
         Dd61xU2fbWIbXVo+X/GI8b1g0/15J5MY7To+XDtlRgpesx9o9xLxua+7TH6VGaresz59
         oN0YtBbmhjR4gaxpIT5Oh2WmhozvaDRKx9h6332eqRPaAdg94HFoYYoQ8/xVTz2t9DQM
         gzITiZG02vil8BaooT+YFss3iJmr0A/VicAbazNeMij4+37hkUWe777WZEWKjYiDjJKH
         0dV1i3O46DSc7QIKzn5d328FIbTs/XUsYg2N96XDRE5q7nOwbH5sNxUEVETDhFKMnbw0
         jPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xscVXSYp1r/J/AX8d0FmFgSQZTJqSlZgSwnOfa2N4jY=;
        b=A4K/fs97WBitJVFS4s1iHU8or1sTqQhtWMBSbM9FipnOJgfWxAGggyuiRu1pLPNemm
         to4o3MrHeJwteYn+umRumg77y8t5FACCTxx1njUXwLvJWt4/tc5+JflIkjJh8O5EW2xv
         7woEo6UkiauZT1JRs+VzuozJF0h3tVfvUzKSu5SNlW1+46ykiR3/9r91Xq48uypjc8vJ
         Hh3nMNWMl4h6n8uutbDsexpwHp8idk9FYrc82mPS5qJew2mMKDooBT/lEYN3y3v9kNOZ
         nCVL2E0Hc5/5YRrIB6bPqAInx8MFXPbVehhVT4hWI1cxnjnOgz2Q6edm1QoMxaoSGJ8a
         VNgw==
X-Gm-Message-State: AGRZ1gI73aQVMhFM7cAn4t/k+9p3uUSQ1meT98LdrVLD3qBEW+pBepm7
        9EYHdvFfPSavfrTnfNTSzuWc1vXaYog=
X-Google-Smtp-Source: AJdET5fr9ly+K81Vj2wkms3L4w8fyG0qjGCG1oRHwx59iYzNSi2IiP4zo36V85lovMMQFn2Ah+kU1Q==
X-Received: by 2002:a1c:880e:: with SMTP id k14-v6mr1012273wmd.88.1542055525965;
        Mon, 12 Nov 2018 12:45:25 -0800 (PST)
Received: from localhost ([95.239.98.134])
        by smtp.gmail.com with ESMTPSA id e10-v6sm22909811wrp.56.2018.11.12.12.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 12:45:25 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Cristian Sicilia <sicilia.cristian@gmail.com>
Subject: [PATCH 3/3] staging: erofs: unzip_vle.c: Align parameter to the parentesis
Date:   Mon, 12 Nov 2018 21:43:59 +0100
Message-Id: <1542055439-24444-4-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542055439-24444-1-git-send-email-sicilia.cristian@gmail.com>
References: <1542055439-24444-1-git-send-email-sicilia.cristian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align parameters to the opened parentesis.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/erofs/unzip_vle.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 35add4e..6a283f6 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -35,9 +35,10 @@ static inline int init_unzip_workqueue(void)
 	 * we don't need too many threads, limiting threads
 	 * could improve scheduling performance.
 	 */
-	z_erofs_workqueue = alloc_workqueue("erofs_unzipd",
-		WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE,
-		onlinecpus + onlinecpus / 4);
+	z_erofs_workqueue =
+		alloc_workqueue("erofs_unzipd",
+				WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE,
+				onlinecpus + onlinecpus / 4);
 
 	return z_erofs_workqueue ? 0 : -ENOMEM;
 }
@@ -46,8 +47,8 @@ int __init z_erofs_init_zip_subsystem(void)
 {
 	z_erofs_workgroup_cachep =
 		kmem_cache_create("erofs_compress",
-		Z_EROFS_WORKGROUP_SIZE, 0,
-		SLAB_RECLAIM_ACCOUNT, NULL);
+				  Z_EROFS_WORKGROUP_SIZE, 0,
+				  SLAB_RECLAIM_ACCOUNT, NULL);
 
 	if (z_erofs_workgroup_cachep) {
 		if (!init_unzip_workqueue())
-- 
2.7.4

