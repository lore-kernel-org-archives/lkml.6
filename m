Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3C684C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CA82086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMWfGvg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CA82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeFLEoC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:44:02 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44884 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbeFLEoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:44:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id h12-v6so11414640pfk.11;
        Mon, 11 Jun 2018 21:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bvFo6VM9yuamEu0fsHOGtDid0BSJt7eSHoHqr0Ibmso=;
        b=fMWfGvg1rTvpe2lLPvpUVJ7PtSYKc7xEIMKASXqSMZQgf8G0+C86H81/wAvPshWFd6
         ASTeEe2JDMfzMSWMPt7S+dQOkxfVcF0W9QjXQx7M3XnD8jB7hAWI1WS7E2fjcjQWjzhH
         8xlbelRMBtF7x7hIsiVIuMnNTVmFZ2mpr40HGlXyIaFofIp3OAkMxfkl9g+34VV01gpP
         ULiwgF6H+VaNKIRWai4/5mFv0vJRnFDd0XS/xhj1e2RUOsNbXYwXSG2lwn0WkfGNReiu
         IxKcwQYq/2GHBNF70IOwPGjEJsGLw1bVmothIxquVecqvybVidnDtQs7EowIKOnRDiRP
         N+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bvFo6VM9yuamEu0fsHOGtDid0BSJt7eSHoHqr0Ibmso=;
        b=akdCa0Oxu4KJE8yPbSS3HJEP0ZTObTYrkhzIhpDjJw8AiDEHYm6ql3+NIyB8eHSGwW
         5olnQw73s65/nDyNHH8g800k6bD2wzxjiKdC6YEHfJT8jKqYKqlGRyXOpTtsIRPAq1Ek
         vFaZThRLQRKyy0iVkwLDPFvsowp1qCJqiwzRQu0GVoSgsoKomUueq4DMQ857VYETBRD5
         Exl2vw6WSlXDNnU0ZxzQZPYx30Y1Wfyv5XOct+HnS2UkpwPIZkDZ1P+bMw4L9PfNWkeC
         BfO+P7m5Cgtnq+IWJ2EZaZLkvlaDU7ksoLe5GqG7CQjfhHVqK5HKb5k8yGE3s2snc6w3
         zduw==
X-Gm-Message-State: APt69E3GGA2w6x6PXvYwR1gTC0U1UsiJyiOA3knvMDJRk92wsiwzJ4y3
        h6a/CNFMF7xzfs1MLdX4u1o=
X-Google-Smtp-Source: ADUXVKIkGV6vmgXSggEzMHiA9LSmktr35L3Sk/r7wy4Qy8vK5XRCrsRnHM8Y1OYfllRRbw3b5TVrqQ==
X-Received: by 2002:a63:b215:: with SMTP id x21-v6mr1755694pge.393.1528778640893;
        Mon, 11 Jun 2018 21:44:00 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id k129-v6sm75770753pga.94.2018.06.11.21.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:44:00 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Kees Cook <keescook@chromium.org>,
        Annie Cherkaev <annie.cherk@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiten Thakkar <jitenmt@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] isdn/i4l: add error handling for try_module_get
Date:   Tue, 12 Jun 2018 12:43:53 +0800
Message-Id: <1528778635-41763-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When try_module_get fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling try_module_get.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/isdn/i4l/isdn_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/isdn/i4l/isdn_common.c b/drivers/isdn/i4l/isdn_common.c
index 7c6f3f5..7e52851 100644
--- a/drivers/isdn/i4l/isdn_common.c
+++ b/drivers/isdn/i4l/isdn_common.c
@@ -71,7 +71,8 @@ static int isdn_add_channels(isdn_driver_t *d, int drvidx, int n, int adding);
 static inline void
 isdn_lock_driver(isdn_driver_t *drv)
 {
-	try_module_get(drv->interface->owner);
+	if (!try_module_get(drv->interface->owner))
+		printk(KERN_WARNING "isdn_lock_driver: cannot get module\n");
 	drv->locks++;
 }
 
-- 
2.7.4

