Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 17B01C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1044208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLqL31PH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1044208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753985AbeFLEwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:52:36 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40853 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbeFLEwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:52:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id z24-v6so11423161pfe.7;
        Mon, 11 Jun 2018 21:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m14ufEtRSa+LUzqFSxg+yOEVHxaSLIpqRPCDa7ILFqA=;
        b=JLqL31PHxA4O/P8WhlrF/2n44rQSyKZYQPLOW1uhnAdV0egeWotdVEKAyYpR+JQdKo
         4NCsIPFYl7m6bkBoricNOX4t/GDEHG2lV1wpbbAuI3HUfInzU5Vvnkk9KvW9Lc4YDRsg
         sOMW5K3r3mdrqUKjEASYSzlAxRci06orkvEuEkez1qlpyZTrq809nQ7gBCrVms83SfFA
         ZNFTUMP8U4VxsGj//JVFCpoaf8Gcg2plYRJtrMx904KQZi0mCq4wjtgfLECjgsC4vZ6G
         9gnZn0h/Z/b7OwfDgGYiLaGUMS7RR6rjVHxlEI8srGUDRXIS+MGKmV8p2jKs4Su3iF4w
         cycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m14ufEtRSa+LUzqFSxg+yOEVHxaSLIpqRPCDa7ILFqA=;
        b=j9OmhNrHEZcLa+r+lQNppR3rP+scbLH0uafqXBOLecBVcVZBK3D03/0ZhFV1b3tzsp
         YonEFiC5k2c3OQD5+rf9YT2LhCkG2oShxcdZ30Oo6jRxE1K+DihywzhEvt/sX7xGsIH0
         zo7w0AR39MttLTDWMgtpoff+o3ogaQew9BhdQVx8FFCugHqz/wgUrjJuasLuoU6ewDRu
         i/kvymFRppGoKfpvCLJnTU3ahkdfJRdaHwyEi/lixfxevVkwuShu1rWZIICx6yBC+WiR
         zdDfIrvCN4O6CHl9hVMKmujwYp+UPyAu1YK4K+8Rydk0xYsA52pmhFMxx2h+Fk/LN0pr
         ZDKw==
X-Gm-Message-State: APt69E2vlBoQN4TIP1VuqxuR2EcITw+1QatxbchYNzp9Bz1drWcFSnsn
        FT1qZoe/ECIZOm8nQo/9hptYktQcJsI=
X-Google-Smtp-Source: ADUXVKJU6zVO5A3E+54JlL6Mfq/k0tpH2Wk++m2T3E5y1FFbOi3szH36i1MPSSlwv8fuCQHkgiehbg==
X-Received: by 2002:a65:644f:: with SMTP id s15-v6mr1847820pgv.228.1528779154241;
        Mon, 11 Jun 2018 21:52:34 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id p12-v6sm27331565pfi.175.2018.06.11.21.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:52:33 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] target: add error handling for match_int
Date:   Tue, 12 Jun 2018 12:52:28 +0800
Message-Id: <1528779148-42485-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When match_int fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling match_int.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/target/target_core_rd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_rd.c b/drivers/target/target_core_rd.c
index a6e8106..7bc89ff 100644
--- a/drivers/target/target_core_rd.c
+++ b/drivers/target/target_core_rd.c
@@ -573,14 +573,16 @@ static ssize_t rd_set_configfs_dev_params(struct se_device *dev,
 		token = match_token(ptr, tokens, args);
 		switch (token) {
 		case Opt_rd_pages:
-			match_int(args, &arg);
+			if (match_int(args, &arg))
+				return -EINVAL;
 			rd_dev->rd_page_count = arg;
 			pr_debug("RAMDISK: Referencing Page"
 				" Count: %u\n", rd_dev->rd_page_count);
 			rd_dev->rd_flags |= RDF_HAS_PAGE_COUNT;
 			break;
 		case Opt_rd_nullio:
-			match_int(args, &arg);
+			if (match_int(args, &arg))
+				return -EINVAL;
 			if (arg != 1)
 				break;
 
-- 
2.7.4

