Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DC5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C358E21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6YkTTbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C358E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbeKUXR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:17:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34992 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbeKUXR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:17:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id v1-v6so5419569plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 04:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UWJmw+YwW/0Ds6hjqIdSq52nGa+a4aC++4JYMN3iXwY=;
        b=m6YkTTbOtI3oq2QnWFp4iiKTAPzieXxRlRQ80OH10x9HhwrwDfqUPKRyNT0YOD/iUl
         r59QyC/zSIndf2BJrQEsQQF45ckjR4XXLcw0YU5UKbKvljpKqBEGfLvwPf/1l5MkkoPo
         VYlrKgWFU2msJmOyi62/YbpO96QcAxqQ61DrF4deLO323PUhesBo+0nATVFj3WJIYlC6
         ZbjTTcASjuctAVAw/Uf4E7mDp+BifDC1LD7HukIoDyTr/H9wQJEqDZ8jWFMXTj6sG+jR
         KeGJK1dmaYSu61LYwg1zDsFmqaWbUJxPr+OqJmvfUdsNlbIyQnY/OpjvYXRS4cb0dqIP
         rjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UWJmw+YwW/0Ds6hjqIdSq52nGa+a4aC++4JYMN3iXwY=;
        b=OyDEu1u5NgCenhrM0ySDqXS3ARHBBtBywUg63kTbvVjlFDIKcabsESSQY8yTRVYkTt
         adv4wnki3ZPrpOL2MfnNQ8fGNokc3LGxDFbQHPReYYKzSr91TqnbgmnA7JUw708Wyw4c
         27phlTnHE98h9xaJvJXbTsOw0xGohz6t1zONJ+5g+FVj30lDaSC71ylv1MkwApT/V9GS
         xOCkmXXGmPGWrgcvPcPM9eFVNHrb7qGGv8yf5ACJKh67Zf8P14t6Bl+GN+d1SZMTRGKU
         bBhT70mz14R+HQ8vZV4IoEvoXXIvwagkmZGrSh/s0gXDnB+FzILvKroCCRf5ku/pVNNm
         ovhQ==
X-Gm-Message-State: AA+aEWa7l/CRYT9w2oK9hSIf1fKCQ2Tv9hUhm72/ESvHKCWVATbn6kfx
        ofK4q6Drqi8/qv1rHiLlEy8=
X-Google-Smtp-Source: AFSGD/VWi0i5Kd4M8LOiNu/fW3mVIr41MdrJ4kKRRpgiKCg6JQgXZvRL+fpn8tS4tb0SpKGCkUD+gw==
X-Received: by 2002:a63:a35c:: with SMTP id v28mr5792926pgn.205.1542804225653;
        Wed, 21 Nov 2018 04:43:45 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id s62-v6sm56954420pfb.73.2018.11.21.04.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 04:43:44 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     computersforpeace@gmail.com, gregory.0xf0@gmail.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        olof@lixom.net, treding@nvidia.com, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] soc: bcm: brcmstb: add of_node_put()
Date:   Wed, 21 Nov 2018 07:43:42 -0500
Message-Id: <20181121124342.21987-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node returned
by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/soc/bcm/brcmstb/common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index 14185451901d..95b777fffee6 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -32,12 +32,15 @@ static const struct of_device_id brcmstb_machine_match[] = {
 bool soc_is_brcmstb(void)
 {
 	struct device_node *root;
+	bool rc;
 
 	root = of_find_node_by_path("/");
 	if (!root)
 		return false;
 
-	return of_match_node(brcmstb_machine_match, root) != NULL;
+	rc = of_match_node(brcmstb_machine_match, root) != NULL;
+	of_node_put(root);
+	return rc;
 }
 
 u32 brcmstb_get_family_id(void)
-- 
2.17.0

