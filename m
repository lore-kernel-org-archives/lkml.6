Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2134C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5B5206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obaeeyqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5B5206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeIFBHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:07:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46003 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbeIFBHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:07:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id u83-v6so7367695lje.12;
        Wed, 05 Sep 2018 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q+ETAP1+maNYec/rRBgtch6mMVPItqHLdIw/EsJVvhg=;
        b=obaeeyqa2zTsaG5acPlgKnhJpEMV1k0U/h46FY2GLgvpgkXhaf2pvePOCPL+fTfZBV
         hmkrYiYK4lYKIJMeBO4D1X+dd1MXWD6UuHOzTeH0Y0hyErdm2botA5xmFdf/YJHP4eiP
         036tE9j3PtFdR1pintsspE6ZqcdHwIbV0S60yz35Ev+ZaRcNaLtdoV86lrgMkrERHNru
         +AAPYBzP9MRhq5Y6dNU1AMSSeMUT3qE2iqfTaf6hKJkXhFC6rZMheQOjHamYDC70FdLj
         zpUaftnO6hUHVj73QkwekUCC7yeE3rIMSFxFcJa7EJjUa1SoBzu+KhFGp4mUz84GxVLH
         lq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q+ETAP1+maNYec/rRBgtch6mMVPItqHLdIw/EsJVvhg=;
        b=kadcn77fhEfjbFBN338VRixR5xkK6LFlJHp/bAQDc8RjA+iRArya0zBLp805kjqiO3
         qUDLUw6gd0rAEe+yYloHm0CkRCvtuPZCcBvuo0HJDaDtzOsTOAoh1Xnb0i9hGmY439y+
         6altCk+3AqIhqPRyTbUZ60ce6T0qleJl6rWKLZhc5uckuNhtVDEIh/q5/gNBr+w2JnCz
         CxaXhF6WnAH07InZNNm6Ncz+6CMIFud/zxg0f3MYjTBv/zSEkxevgvMjhQq1bFwIzqee
         pP9QrOuX9Hikyq88at1sHTjeZSReUl8gupknJHHBcDlvAegvcMCOzlOla7HDkzuR5Anm
         TMVg==
X-Gm-Message-State: APzg51Dz7Qtl/f/PvLpnECEedtM2jKqR6Jzk7gq117WNDln1f5pegN0T
        xJD6FaI3xA58B27znbzFo4c=
X-Google-Smtp-Source: ANB0VdYA6z8CxOkJALwkCDR/BA4L/J1hrCMRFst683QaNTQCglMKptzi2iJakxo0hQkAL2qd2Bja2w==
X-Received: by 2002:a2e:1301:: with SMTP id 1-v6mr20327019ljt.56.1536179708243;
        Wed, 05 Sep 2018 13:35:08 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id b26-v6sm463683lfc.68.2018.09.05.13.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 13:35:07 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] seccomp: remove unnecessary unlikely()
Date:   Wed,  5 Sep 2018 23:34:43 +0300
Message-Id: <20180905203443.32289-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to wrap it
into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index fd023ac24e10..5a2a9af4663e 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -195,7 +195,7 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 			READ_ONCE(current->seccomp.filter);
 
 	/* Ensure unexpected behavior doesn't result in failing open. */
-	if (unlikely(WARN_ON(f == NULL)))
+	if (WARN_ON(f == NULL))
 		return SECCOMP_RET_KILL_PROCESS;
 
 	if (!sd) {
@@ -297,7 +297,7 @@ static inline pid_t seccomp_can_sync_threads(void)
 		/* Return the first thread that cannot be synchronized. */
 		failed = task_pid_vnr(thread);
 		/* If the pid cannot be resolved, then return -ESRCH */
-		if (unlikely(WARN_ON(failed == 0)))
+		if (WARN_ON(failed == 0))
 			failed = -ESRCH;
 		return failed;
 	}
-- 
2.17.1

