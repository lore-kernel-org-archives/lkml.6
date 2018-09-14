Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A78EFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B096F20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/TnECiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B096F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeINP6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:58:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40767 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeINP6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:58:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207-v6so1435200wme.5;
        Fri, 14 Sep 2018 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WL3CoAfyrz+DdXQDmDzsPgOLVAdiPICdvltmWLSWYgw=;
        b=A/TnECiM639MdxKNnW0kC9hNPaJzuVFVgtG/O+rLKnF+/TCs1jMuwUfBy+y1cD7A10
         6hB7rOrR4bzlkOeulz9gHeiCSypmuFscleYMxdtXUIkvhHMPJS8HtJzT4chQwvsdfbfZ
         NKJ7Fx54Cv4xq2Qc3rhOhGwJpl9jCtt7m3E+m+4JWteLy+drvgVRe2AOtoCbaiV8N59s
         j6trjtFz6RNuBrAptxL3wm4qFlYiWLlJBOuxrYAmtqBecmEJM9+KcbOny7QeGx7kRmoT
         M/yw/+UnuYUYIAYoNB0+u4U+cQI9PoFr+r7vcmdnpcscOxwXlXyv7CmGMITTJNWNC9U4
         hpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WL3CoAfyrz+DdXQDmDzsPgOLVAdiPICdvltmWLSWYgw=;
        b=FDYVnaoIqQp4qjieY3HTJyMLranGP99OvKAsh68Jdg8M+5jy2nDoDU1kfPyl93xa2R
         ca3f9GSt/SnMq7WT40+ykCGD8Ro9kN07QrjSjjjQDey16Ogffxbc8Y3McLrUyZYAPDKv
         TLGe9bHT7NQjQZzzoZrOt2yCYSRy6d8QWer4RMlbOavbXtJeNDvxrDYIWlILXvnskSv1
         NxRvgEU3Da92vi8S58CeRSlXrQVFvhU9oCB3pZh/uPr16tWIjZF3QXiP2j1Kp57xRGDK
         Jj97mkIb8tf/JJ3LDJOcArIRaNPLc/FMjVz8jBtotLQ8Gtv5ta/pWDRg+nmHG3RX6oOs
         DSMQ==
X-Gm-Message-State: APzg51AjrWZzBFyDRpxh0etacgjS1/ik9/AuehNj/jFQMbDEFsUDWwIg
        /zltxyVMb2CXXZK+ZkL+9UqMTf1S
X-Google-Smtp-Source: ANB0Vdbe5KWLgEvvhtxb/fm1oKJ31NCSkxVzZvn8ja/MqbhJVIUSLGPIBTF2P//cp7i2eHFrajJxrA==
X-Received: by 2002:a1c:90e:: with SMTP id 14-v6mr1779496wmj.130.1536921873155;
        Fri, 14 Sep 2018 03:44:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.googlemail.com with ESMTPSA id l24-v6sm13812997wrb.65.2018.09.14.03.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 03:44:32 -0700 (PDT)
From:   Harshit Jain <harshitjain6751@gmail.com>
Cc:     stable@vger.kernel.org, Harshit Jain <dev-harsh1998@hotmail.com>,
        Tony Finch <dot@dotat.at>, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: unifdef: fix stringop-truncation warning
Date:   Fri, 14 Sep 2018 16:14:27 +0530
Message-Id: <20180914104427.3900-1-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harshit Jain <dev-harsh1998@hotmail.com>

* This commit resolves the following warning when the mainline kernel is build with the android environment.

-> warning :-> https://gist.github.com/dev-harsh1998/757427b16a58f5498db3d87212a9651b

* This warning is persistant in all the currently maintained android kernel i.e 3.18, 4.4, 4.9, 4.14.

Signed-off-by: Harshit Jain <dev-harsh1998@hotmail.com>
---
 scripts/unifdef.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/unifdef.c b/scripts/unifdef.c
index 7493c0ee51cc..4ce008eda362 100644
--- a/scripts/unifdef.c
+++ b/scripts/unifdef.c
@@ -395,8 +395,8 @@ usage(void)
  * When we have processed a group that starts off with a known-false
  * #if/#elif sequence (which has therefore been deleted) followed by a
  * #elif that we don't understand and therefore must keep, we edit the
- * latter into a #if to keep the nesting correct. We use strncpy() to
- * overwrite the 4 byte token "elif" with "if  " without a '\0' byte.
+ * latter into a #if to keep the nesting correct. We use the memcpy() 
+ * from the string header overwrite the 4 byte token "elif" with "if  ".
  *
  * When we find a true #elif in a group, the following block will
  * always be kept and the rest of the sequence after the next #elif or
@@ -450,7 +450,7 @@ static void Idrop (void) { Fdrop();  ignoreon(); }
 static void Itrue (void) { Ftrue();  ignoreon(); }
 static void Ifalse(void) { Ffalse(); ignoreon(); }
 /* modify this line */
-static void Mpass (void) { strncpy(keyword, "if  ", 4); Pelif(); }
+static void Mpass (void) { memcpy(keyword, "if  ", 4); Pelif(); }
 static void Mtrue (void) { keywordedit("else");  state(IS_TRUE_MIDDLE); }
 static void Melif (void) { keywordedit("endif"); state(IS_FALSE_TRAILER); }
 static void Melse (void) { keywordedit("endif"); state(IS_FALSE_ELSE); }
-- 
2.18.0

