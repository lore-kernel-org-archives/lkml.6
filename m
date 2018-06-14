Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0D9D2C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4AD208B5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lpd0b2j8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4AD208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965155AbeFNXfH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:35:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34339 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965056AbeFNXfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:35:05 -0400
Received: by mail-pg0-f67.google.com with SMTP id q4-v6so3611221pgr.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 16:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QQNKtzgcetzD86rnRxV18V5fUo1RGn/dAr7kXklW984=;
        b=Lpd0b2j8lZ+cdOP+mO8pAvySQGlkOIr1Icdq5z1bYR6bavhGNUfothWV9No3jQGY2x
         JqA5NKln0ejaa6WxJPygaGrQIW1W/PQvUALoGww+45+RC8OyQDr0tEUkuhAA6yMkWpIo
         bfss6fpT1sdEwSdCbSIgqfGv7Il3i68DKsBkUSJf5jwHLfV7hYESVeNJynsJJVfC6yxM
         Ezf3Trtl02OVHu+TTQcfC42oQJILMJAk/f5NLr7VolQBs2Q5eqO3lptu3RctNAiuSIWa
         evPHRsDDjibdECqUMVpiUgfpDvGaADAbLVHbICRGEKpDhAUbjcmhWCUWg7FX9plBTF9s
         j9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QQNKtzgcetzD86rnRxV18V5fUo1RGn/dAr7kXklW984=;
        b=baecebo0NxQz85XGr55xh/k3F/xeDIZGN9CDGrfcG8SgA+uWVU66TYE8L8iTrZCPaa
         O1LDnSlaMdLBbHbymT7mOGqNnucCtSZr3YHEyaZV/aeGrqfRltH3nlEOVSO13FzCaSsF
         0bur/h5JGbyjfM1SHR8G5bFw43vlcz5Ky1humgapIbXSoRelOSjdwUow+6bA5QtMvzGd
         HI813NydBBV8HwQnko69xYmQlt3oLLUHJLfqiYhK7Bt2Jfqn8FPPn8BGV8tG4gwvxyb+
         XIcoeBrcO0dIg9+Dkse2ELcmXGS0HvBzcasTnsXV9np4p42y/vfac3vBDZuFrXchYFwt
         OsWw==
X-Gm-Message-State: APt69E3rPS0qMyNW+RN/uIRFpcJ0eOLZcIMDHkqKO2OEHdyF73p+BSbr
        ZfmfIdMyqIAlDPTXjHJBuDg=
X-Google-Smtp-Source: ADUXVKLuRoNPyPsfZzB73ax2akzAGYBa2Iv1JLEL5wCLOhjbb6HlYvJFAViI2czhkW3l9eLkjo0YNg==
X-Received: by 2002:a65:6147:: with SMTP id o7-v6mr4025702pgv.163.1529019305540;
        Thu, 14 Jun 2018 16:35:05 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id l11-v6sm6840491pff.50.2018.06.14.16.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 16:35:05 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] xen: add error handling for xenbus_printf
Date:   Fri, 15 Jun 2018 07:34:52 +0800
Message-Id: <1529019293-55493-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528775073-39322-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528775073-39322-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When xenbus_printf fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling xenbus_printf.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Add __func__.
---
 drivers/xen/manage.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 8835065..c93d8ef 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -289,8 +289,15 @@ static void sysrq_handler(struct xenbus_watch *watch, const char *path,
 		return;
 	}
 
-	if (sysrq_key != '\0')
-		xenbus_printf(xbt, "control", "sysrq", "%c", '\0');
+	if (sysrq_key != '\0') {
+		err = xenbus_printf(xbt, "control", "sysrq", "%c", '\0');
+		if (err) {
+			pr_err("%s: Error %d writing sysrq in control/sysrq\n",
+			       __func__, err);
+			xenbus_transaction_end(xbt, 1);
+			return;
+		}
+	}
 
 	err = xenbus_transaction_end(xbt, 0);
 	if (err == -EAGAIN)
@@ -342,7 +349,12 @@ static int setup_shutdown_watcher(void)
 			continue;
 		snprintf(node, FEATURE_PATH_SIZE, "feature-%s",
 			 shutdown_handlers[idx].command);
-		xenbus_printf(XBT_NIL, "control", node, "%u", 1);
+		err = xenbus_printf(XBT_NIL, "control", node, "%u", 1);
+		if (err) {
+			pr_err("%s: Error %d writing %s\n", __func__,
+				err, node);
+			return err;
+		}
 	}
 
 	return 0;
-- 
2.7.4

