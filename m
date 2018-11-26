Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38DFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB6120663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCRo8Z/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB6120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeK0Bpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:45:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33960 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbeK0Bpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:45:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so6698349pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1zyIcnckUSRiKfZOtJe0DJi6ekaw2hheXMhU4y1aanI=;
        b=WCRo8Z/SFy4kcMxoDKFRlPeddo8MZQa7aOqgjyu9bkpzP4PQJQ5GTAFeV7oLgpwWic
         Oe4QuUq3sfqFBJzHKnVwWggaTujIKYxiE7heBeWwMIY+VBkDUmuaNDWWHYrNfc8RW3XC
         FM3LSdiyh9ipIZoc7WCz9ZdGtzJD1Oy2dNYQC46JJ53K8eOrPgr1J1zc7fTe/sXhkDth
         tAAX0VebXoHU3Llz/+MoqmHbiVFnDVsuqDDuhZX9HuQbpAw6Zq2qjnJdsrfyAzjt8ac/
         q2uJUuoM1nQPc5TzKNaKAVWRJe+40+L7H2ZGLHLQdQ87wjxYXfT5wk/TA6JoHUhmKC4a
         Q0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1zyIcnckUSRiKfZOtJe0DJi6ekaw2hheXMhU4y1aanI=;
        b=mBXw/XLt9YY/VKqY+iFcO8+orF3+JF/X1S15flmYs9x6mMaiSjKgREuWEc87cNR23e
         d38KgKFU3aOk/gHSUwyxmV6Qr261AF3jFQchbfU9MIkZCI/HTJJ5k8WPC4Xuilw2zfjT
         MLUVUPC9uADlTLtZOzqXDSWmduR2Rh/t1QkR5THHFx9epab+g8YXKWKs0rKyhPIYN0C/
         nXPi5w7K41LR78fsjKIUap0chu6FE6KF+E98BERdshKE1Y9gCVg/mnIjh93VdoIIvRyx
         gyTQ18yI/GhrzPMNSdMwxB6md8LueqipH/I824XCMeBK9acsZUqZ7uZsMneQuxDeHIcv
         xJFg==
X-Gm-Message-State: AGRZ1gK7Lgi6FmtccSJmiyI9M+jAMCzzWUd8ZozzrK3jppcynM3MFYki
        VyI0qDlHX2aYbFRS0wsoC98Zo4yGa4I=
X-Google-Smtp-Source: AJdET5eB06Y3qAWIIgJ1hmEONyUW07YjJf/hAm7NjlDtzscS+iSJdQG1CZeDPQdvGoY3gzXEtqnZpA==
X-Received: by 2002:a62:f5da:: with SMTP id b87mr28858299pfm.253.1543243871250;
        Mon, 26 Nov 2018 06:51:11 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id a15sm620242pgb.1.2018.11.26.06.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 06:51:10 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     paul@paul-moore.com, eparis@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] audit: remove some duplicated includes
Date:   Mon, 26 Nov 2018 09:51:07 -0500
Message-Id: <20181126145107.31597-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

audit.h and skbuff.h are included twice.It's unnecessary.
hence just remove them.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/audit.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 2a8058764aa6..a677715891d0 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -62,11 +62,8 @@
 #include <linux/pid.h>
 #include <linux/slab.h>
 
-#include <linux/audit.h>
-
 #include <net/sock.h>
 #include <net/netlink.h>
-#include <linux/skbuff.h>
 #ifdef CONFIG_SECURITY
 #include <linux/security.h>
 #endif
-- 
2.17.0

