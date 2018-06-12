Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7E2A9C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE65208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="S+5ZXhRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE65208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933122AbeFLL3g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:29:36 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45472 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754019AbeFLL3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:29:31 -0400
Received: by mail-lf0-f65.google.com with SMTP id n3-v6so35439965lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZvEAc39P434CkCcOSMTcAuUZ3KCu4b2yBOGy1PfwQJ4=;
        b=S+5ZXhRpryAjvQWtS1AUtHpPEOPLoPXoeJpEm3/PwYjkW/TWekZ8IEtQBsI1NJsqQU
         WYgTzAruJSmilFmGICB/V/IFuuz3TTVlESEVmk+Ju+0DjpOCWhr7rWKsVHFhOw2GUYcJ
         UgJ6Bhqy+l2+wy7RzMKMd5ewLzKxqzNOUkdGG+N68l6mrkIhpg9pFIspe2XwXpOfCI6O
         lRnZTbRXsnMcHRXIzwsS7kGBQzp3ETogCbjRvOHc1hGpUB5YC4RfWmhbGh+B3A3hlabw
         xCfi74ZgkqypLkm3A7MsXxg/E832BZPxkncyn0BUfa66PRUXw93MvpmfX4DpHoPNU+Ic
         8hEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZvEAc39P434CkCcOSMTcAuUZ3KCu4b2yBOGy1PfwQJ4=;
        b=BDcRIuU+v3hZ7HNWmz5wefVyO3ZgHjW7Z8PVQz9ayq2G8xjck+u8lm5pNwfGEiIqQu
         +D1CHkWML0gzoW2I6tqb7eqnzOcfXIKCvTxJW+oRyFTESyG6dnzyyzrreKa2UyZxGKDm
         ZACIscftPZ/m3XdyrAYagNmsNNlJTua22ntEtQm5GObIfgGPNWM81nbuVj7jiCugIYVM
         scWD3uznNJY+V98XLwp2324SYI7FL0TZDn0b54083zHGhhkYtSzZ6OmFnbVEJaS+rc6j
         iGHxeuYyrqg8MvhLt0I29xTzX/5Msjs9G4UTtIudX6DwuZH8Gwvj4LjGs+NExbfDT9AK
         xPag==
X-Gm-Message-State: APt69E21XmJ2VGWglGjxsRNEOMa1O1Y2LLqpyPrQYjkRTQ2RNMN2zd4S
        SE2FYwoJUk81470EawbQ9NA0kQ==
X-Google-Smtp-Source: ADUXVKIyIGbKSRPNrU6VZSIVm/062sSl6FOsvsuXQFc4vJXWFoK8dWMTdSMCgkTgIRfb4LUegGk4tg==
X-Received: by 2002:a2e:96c6:: with SMTP id d6-v6mr2147774ljj.21.1528802970027;
        Tue, 12 Jun 2018 04:29:30 -0700 (PDT)
Received: from Macroninja.cnexlabs.com (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id h99-v6sm180779lji.19.2018.06.12.04.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 04:29:28 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH 2/2] lightnvm: pblk: enable line minor version detection
Date:   Tue, 12 Jun 2018 13:29:18 +0200
Message-Id: <20180612112918.25795-2-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180612112918.25795-1-mb@lightnvm.io>
References: <20180612112918.25795-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When recovering a line, an extra check was added when debugging was
active, such that minor version where also checked. Unfortunately,
this used the ifdef NVM_DEBUG, which is not correct.

Instead use the proper DEBUG def, and now that it compiles, also fix
the variable.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Fixes: d0ab0b1ab991f ("lightnvm: pblk: check data lines version on recovery")
---
 drivers/lightnvm/pblk-recovery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 598342833d0d..b1a91cb3ca4d 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -742,9 +742,10 @@ static int pblk_recov_check_line_version(struct pblk *pblk,
 		return 1;
 	}
 
-#ifdef NVM_DEBUG
+#ifdef CONFIG_NVM_PBLK_DEBUG
 	if (header->version_minor > EMETA_VERSION_MINOR)
-		pr_info("pblk: newer line minor version found: %d\n", line_v);
+		pr_info("pblk: newer line minor version found: %d\n",
+				header->version_minor);
 #endif
 
 	return 0;
-- 
2.11.0

