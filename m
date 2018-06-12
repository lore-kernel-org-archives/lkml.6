Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8FFC3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A56208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJqwphis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A56208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932951AbeFLDok (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:44:40 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40903 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbeFLDoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:44:39 -0400
Received: by mail-pg0-f66.google.com with SMTP id l2-v6so10767608pgc.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 20:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aUhT9jqKZFY72Z1/qW6kXOFlp/YvK0MiyVB6Pgj0070=;
        b=YJqwphisIRCDqe0OJEnV1AVA/egZDHO0t0vgf0zHEDeHBPj3k2ogDhGla6tYrCsU7k
         +F0DtIfHmxfJvt4BLhlXQZ8xbvzPsx4Jl51C+bzr+1IYjVHUFTDGcJR6OQL0SkNQ4275
         RW6etGp285VtsmuQgl5HPBGGX+LQPNLuc6AfBC7vZFrLZL89Y6faU0tzdBakzAfr31KY
         sdo5Ctv+czeiUyWQdrpS2XGwPcYFS6+GNurnuhmNqDPMKwcj2SPHrCZJERz9IfnDoImC
         E8aZ4SQpBpxVIrkPpJ7ndSoYa80XME2AwZAskBiGrEcKd+Ic+i71wFvnhypT5SlmouLH
         Qclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aUhT9jqKZFY72Z1/qW6kXOFlp/YvK0MiyVB6Pgj0070=;
        b=tgAOgfAgXaX5WxbG1k9Ms/dUGwZC07K9nZWOSlLx0T1RB4Yy5A+7Nr3w8B7EIXzDZj
         E+4Mj8BFW4geHHJ6jTNOc3lvkGNm0Txg4Vhr6PGTu++/jzhYhc5QQyLSL1LB6WJ+W+Ng
         /Xlgc81bXhDcAuBg+tKEhlCgy+KuVB1kzwpz1Mnyl6B58Xt09BoV2XvQMz6RlA7khR8K
         MzghA5LGJ1zi7iMlRNgLKjDdlB6zL+Si+0dsetIz2/H/nCuHR68tziVaBkSX6xBtgTsx
         bN2z8NoIChuFxM2I81jV42ZLzZBDrjFo++K4sMqfmiRiu0DBpWgD1f2Kl3fAzp4NTYJi
         zPCw==
X-Gm-Message-State: APt69E2w4H01/O3P1U7rySkWJhpjnEQ7LvS7G8vHaRm79wc5W1Ku5hqs
        dJHkSVDOYsjkFG8vfAKwtWc=
X-Google-Smtp-Source: ADUXVKI9lIFV0PFU8qvq8Zia0AHL7/eIiTXz+Pgf80DymMJUOuZqOqc0N49D47iAjK0FyTooMCpWyQ==
X-Received: by 2002:a62:4785:: with SMTP id p5-v6mr1981645pfi.164.1528775079104;
        Mon, 11 Jun 2018 20:44:39 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id i17-v6sm32290369pfj.95.2018.06.11.20.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:44:38 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen: add error handling for xenbus_printf
Date:   Tue, 12 Jun 2018 11:44:33 +0800
Message-Id: <1528775073-39322-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
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
 drivers/xen/manage.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 8835065..159694d 100644
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
+			pr_err("Error %d writing sysrq code in control/sysrq\n",
+			       err);
+			xenbus_transaction_end(xbt, 1);
+			return;
+		}
+	}
 
 	err = xenbus_transaction_end(xbt, 0);
 	if (err == -EAGAIN)
@@ -342,7 +349,11 @@ static int setup_shutdown_watcher(void)
 			continue;
 		snprintf(node, FEATURE_PATH_SIZE, "feature-%s",
 			 shutdown_handlers[idx].command);
-		xenbus_printf(XBT_NIL, "control", node, "%u", 1);
+		err = xenbus_printf(XBT_NIL, "control", node, "%u", 1);
+		if (err) {
+			pr_err("Error %d writing %s\n", err, node);
+			return err;
+		}
 	}
 
 	return 0;
-- 
2.7.4

