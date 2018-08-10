Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AB0C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9FE217CD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHODbGfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9FE217CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeHJPBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:01:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43828 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeHJPBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:01:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id a14-v6so4332408pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YWLp1tjil45LCw2K+MUgM4HgTWa8fEgPMWH0rKahaX8=;
        b=jHODbGfYZN8iUVQLfh9ZdtD8Vqs/OKw8XOJBNe4BSpLllBTM3zGkCBLdFRs8pQ2nCA
         ILbelh0XKik1fw8frLyC8m7ttv4KiRNxRLq82AiG8cq5WjOPaJRo+0k3I/05xz2peJdE
         mu9eb6umsYLtyouPNw6PwV2OaE6+V++1ijxBKkfUxBcS/XOpO07pxMBTFFbalmoX8d8m
         9hVBK43aC7RfIX7dbPCgAPWjxBVz+4LI0MdQBwp6b7p1jiRH1Wm/yqqn/aPpAvcP82uG
         RhZsZz0Pfs67Ih6aVrRWrnQmFuGLG2O97uw/qzmbKjlUuW2uNC9qlEd8kXAZwunpCNF0
         M88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YWLp1tjil45LCw2K+MUgM4HgTWa8fEgPMWH0rKahaX8=;
        b=iy/ZdoJPC62hl3bZAhGQQKlTMai2JcuPZ7awXqP63cbjoVRTUgqE1WBr4HZi1Jwztg
         DSvdJO33qD1ZitADF8eniAk+SCYZEWyJCNGRfTRIlffmFiFfdWtManOyyORTvnM65i8m
         gQcBkBY9qOz3kOGduQAfrWqpF7WvDPTPcoXAPDRJcweUsTp1d9bEVDcTN43WyPLf0EjM
         +PNgoR31p4mP1gMMNoc/c+6fxRtrNoBRAuoYZtYdfBmmSVip/1i+YE1mkaH2pcAc/SGk
         zZ+lUF8I9cb8Fwl8B2ZcSioN/jLdkP0beKO9FV3cEZPbfHQbZotdPAyWw46VTtvpk/44
         lAYw==
X-Gm-Message-State: AOUpUlF48GG9HOALliU/5QaVjxtitJwZEZtGvQTuFXJOtfzgpSpFP+wB
        ts0YCy8HazOaUN+YuXLM0ko=
X-Google-Smtp-Source: AA+uWPxWegovjS8JkwYK3cbevBexIx+u9vaI52cXlX610IYZlIwbhl52ckn+3Uagq57zdmUr35HtYg==
X-Received: by 2002:a62:c4c3:: with SMTP id h64-v6mr6857165pfk.39.1533904306885;
        Fri, 10 Aug 2018 05:31:46 -0700 (PDT)
Received: from blackpearl ([123.201.241.44])
        by smtp.gmail.com with ESMTPSA id e82-v6sm19838867pfd.40.2018.08.10.05.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 05:31:46 -0700 (PDT)
From:   Sumit Pundir <pundirsumit11@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Sumit Pundir <pundirsumit11@gmail.com>
Subject: [PATCH] staging: mt7621-mmc: place a check for sscanf
Date:   Fri, 10 Aug 2018 18:01:40 +0530
Message-Id: <20180810123140.19821-1-pundirsumit11@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Placed a check for the return value of sscanf. -EINVAL is returned if
the value is anything other than expected. Reported by checkpatch.pl

Signed-off-by: Sumit Pundir <pundirsumit11@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mmc/dbg.c
index 6e518dce9029..4fe4d2fd111e 100644
--- a/drivers/staging/mt7621-mmc/dbg.c
+++ b/drivers/staging/mt7621-mmc/dbg.c
@@ -249,7 +249,9 @@ static ssize_t msdc_debug_proc_write(struct file *file,
 	cmd_buf[count] = '\0';
 	pr_debug("msdc Write %s\n", cmd_buf);
 
-	sscanf(cmd_buf, "%x %x %x", &cmd, &p1, &p2);
+	ret = sscanf(cmd_buf, "%x %x %x", &cmd, &p1, &p2);
+	if (ret != 3)
+		return -EINVAL;
 
 	if (cmd == SD_TOOL_ZONE) {
 		id = p1;
-- 
2.17.1

