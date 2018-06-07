Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id U04qOueqGFscGQAAmS7hNA
	; Thu, 07 Jun 2018 03:48:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 998F2607F7; Thu,  7 Jun 2018 03:48:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ3jrR7m"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 235AD60290;
	Thu,  7 Jun 2018 03:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 235AD60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932408AbeFGDsV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 23:48:21 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39749 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932118AbeFGDsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 23:48:19 -0400
Received: by mail-pl0-f68.google.com with SMTP id f1-v6so5158340plt.6;
        Wed, 06 Jun 2018 20:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fLl2ofzpSUPGaZwlx3JM9rdi+vVMd8jIdo41E+dCiVI=;
        b=EQ3jrR7mKMTNIPYaPKnmAbHywyQ1+/40Bo3gqHSpKD+SsogXeDmloV9DVmP5m9ZXWg
         /sNwS8Y1TAMDTBHFnwU7hqdCIxw3g+cVJlDzDFXHAh7Gqg4oeOgKFqrtlkfBUY/2519Q
         VYpDhTRuoVSBBR8EcHQvhlGH0ZU0wcexOzifbJK0SptSTvykZRb1P23Jr7jZd0ZnWE32
         5Bh4G9jIdvFe49l1+M/sl3lKBn8h8mBnrewV9hagLt1Jbwxc2AkctxFHcvhOXfmMcm7G
         HnAlLYPximu/K+3ai175h03QL8ENh4UMYbAjoy4qery9TNlO36FNLL0ZDys4WMzDNyXm
         z3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fLl2ofzpSUPGaZwlx3JM9rdi+vVMd8jIdo41E+dCiVI=;
        b=izmhktpJxQB4q7VZqIwCMrADqN9TDl0zQjaKybn93xD5OUMakN/EH1u9/+d8TJniKH
         arFTXERp8+L2xtK/Zp0odk3r8WFuHNVBgPLOkL7EE/bBWSOAIrLpe85zHX0NOOVjLqSP
         Z/zR2Rn4ae8g+tm02T65oj120ctsbhsjj3+mZjXWjlrRV3QRSvh79FWmihKc8NhVlg3H
         DubW87ZXFRn9sGOc3VE3lAPubeqgZxncjL5RCOvlLgfhu7/CLJUW/aM5N7oqN2n+P0Nv
         DArzpMmWw/u1Zwzvys5ikNlcwtu/tEGCx1B2L6c1dWkx83J08NgIMahmNi4fKwhHiM6D
         B+Jg==
X-Gm-Message-State: APt69E3tssNmITc9T1gNlG296wTE/+2ywyoNo6uIhcL/Th3sxuSEoAvq
        1lFf9GcAdu6WaiZRwtCggbhP9g==
X-Google-Smtp-Source: ADUXVKIHuDQPrTojrQd9Ak4v3fR6aV6eYrmq0PoadPj7gq3gokxnGbCADvZlz+V3441+T0NwqpCspg==
X-Received: by 2002:a17:902:683:: with SMTP id 3-v6mr225023plh.291.1528343299167;
        Wed, 06 Jun 2018 20:48:19 -0700 (PDT)
Received: from localhost.localdomain ([103.62.68.119])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm91994137pfp.137.2018.06.06.20.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 20:48:18 -0700 (PDT)
From: Varsha Rao <rvarsha016@gmail.com>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH v2 1/2] message: fusion: Remove extra parentheses
Date: Thu,  7 Jun 2018 09:18:05 +0530
Message-Id: <431da1b7c0fa06aea38acc22fed41963b6d44421.1528342739.git.rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1528342739.git.rvarsha016@gmail.com>
References: <cover.1528342739.git.rvarsha016@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix clang warning of extraneous parentheses and check patch issue,
remove extra parentheses and replace x == NULL with !x.

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
Following coccinele script is used to fix the warnings.

@disable is_null,paren@
expression e;
statement s;
@@
if (
- (e==NULL)
+!e
 )
s

Changes in v2:
 - Removed coccinelle script from commit message.

 drivers/message/fusion/mptbase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index a746ccdd630a..5b98b7fca0f2 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -335,11 +335,11 @@ static int mpt_remove_dead_ioc_func(void *arg)
 	MPT_ADAPTER *ioc = (MPT_ADAPTER *)arg;
 	struct pci_dev *pdev;
 
-	if ((ioc == NULL))
+	if (!ioc)
 		return -1;
 
 	pdev = ioc->pcidev;
-	if ((pdev == NULL))
+	if (!pdev)
 		return -1;
 
 	pci_stop_and_remove_bus_device_locked(pdev);
-- 
2.17.0
