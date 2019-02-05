Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C001C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B965206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9yb2TSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfBELBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:01:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41069 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBELBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:01:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so1305869pfi.8;
        Tue, 05 Feb 2019 03:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tXr2Q5JlVp9niJmUFpaK2vIEtJtsyo+lziZvV04en6Y=;
        b=R9yb2TSjpnG5gAvDEolwLCYYpBLSloYpmfVSBDqJDnVPEp+ClTf4FDFBlZniRRmQuL
         Yo27oi/oDBafW1PUXXN/k2x1YOZU2h/Sq0LWLlUbwqWhYM2x3NGQ9xa6VW1GyvazqSji
         XXefKJ0xZHQAA/tfaDy7XF5J8gQUmq2qtJx+H9nxHSbO2lCGQCAy2ltOfSh31i60B2Mo
         yLstT4FnWN0iBNZG9o8B8QpZIOVB1eUfsS6xtMwgAdf2bdLj4v4S0031ahy6XQCoWUPr
         XVd1HNJbUSIcaXuH7b7+wV/HfkyjgavmFnRmWN+OTGvvhHRtlUSUZphl+g9kDk2kZjxD
         KIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tXr2Q5JlVp9niJmUFpaK2vIEtJtsyo+lziZvV04en6Y=;
        b=hgXp/pciq4zeXYm1YXN5I85e4UogqZRDZ3od2da6vuc7fnH55wSI5vemyCWQNqybFP
         7O+rtktDUdGeQmiD3A8KA8//CIcqM+2vYemkrZtE9VJC9cY17s15x2KMU9jVAyNNENYW
         go5MJJZYxjMc21NcpJSYVsjqFvrhs58Hq6CrfmSIolGEU5hUlrhAbG0jqfUhK/a7PLFR
         rg8mMH/Y7sO+t7JzoiVj05gnsVAyv+gMQv4PgHVAcrHRcsQKGLbKMgUXuUWJzaa7AH4v
         EKdAFRPXg7Oo5Jvny7umCBDKr5oPIjTm7qa8OUeLtO/2YsVuM5nyJzGhmOhdOc07sd+2
         zgUw==
X-Gm-Message-State: AHQUAuZcFiUFL4+mdCgql4WOoJFULHjQ1CFBqOQBmx8zq04+OoCIWjdA
        z/eHVHM0HETahYhXE+Rt8eyNxnkry7k=
X-Google-Smtp-Source: AHgI3Ia8mXSuD/is44mnwgd1QwfYAltegU4X6sQ1iSwPYg65po1GXjtzOBqH3EihaqjRi1VrOQTk6Q==
X-Received: by 2002:a62:5910:: with SMTP id n16mr4351751pfb.128.1549364480400;
        Tue, 05 Feb 2019 03:01:20 -0800 (PST)
Received: from localhost ([207.148.115.208])
        by smtp.gmail.com with ESMTPSA id d88sm5298537pfe.19.2019.02.05.03.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 03:01:19 -0800 (PST)
Date:   Tue, 5 Feb 2019 19:01:13 +0800
From:   Jin Chen <nobijinc@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: Rename setDisplayControl to
 set_display_control - style
Message-ID: <20190205110113.GA3642@jin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl warning:
    CHECK: Avoid CamelCase: <setDisplayControl>

Signed-off-by: Jin Chen <nobijinc@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 1273e7d..f38051e 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -5,7 +5,7 @@
 #include "ddk750_power.h"
 #include "ddk750_dvi.h"
 
-static void setDisplayControl(int ctrl, int disp_state)
+static void set_display_control(int ctrl, int disp_state)
 {
 	/* state != 0 means turn on both timing & plane en_bit */
 	unsigned long reg, val, reserved;
@@ -137,12 +137,12 @@ void ddk750_setLogicalDispOut(enum disp_output output)
 
 	if (output & PRI_TP_USAGE) {
 		/* set primary timing and plane en_bit */
-		setDisplayControl(0, (output & PRI_TP_MASK) >> PRI_TP_OFFSET);
+		set_display_control(0, (output & PRI_TP_MASK) >> PRI_TP_OFFSET);
 	}
 
 	if (output & SEC_TP_USAGE) {
 		/* set secondary timing and plane en_bit*/
-		setDisplayControl(1, (output & SEC_TP_MASK) >> SEC_TP_OFFSET);
+		set_display_control(1, (output & SEC_TP_MASK) >> SEC_TP_OFFSET);
 	}
 
 	if (output & PNL_SEQ_USAGE) {
-- 
1.9.1

