Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD1EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CBD2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoS9EI8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CBD2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbeG0JqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:46:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34716 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbeG0JqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:46:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so2816826pgv.1;
        Fri, 27 Jul 2018 01:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3jlmpDi3pSMTdz6KTum7rjiXC4zJCibhSFCAK3K7xuA=;
        b=FoS9EI8P/dpjTwRRG3tWmdxp9FMxfpMY5tbSqVH1NGyRo44jSNxd7gJGfsBywD2gui
         gFhdRV3DBy2Vn+ySA8LHMxYozqfXO8TjiZZI2kYzAnpHnil+nymCbzdqbWaNDMkB4jtf
         a+vrwl7KpkyNGrT97YrqfEAYMnLIc0Q4ExX2gnWUAuPYPvqR8xuYaqRofkNfKuUHJAjA
         5ngXC7a+O/tBZb8IIbJiGZ1aF6UpqxvPdlD7Ewo9rApzsnWkd9dA+DsF/ltihi7lp8bK
         SAO2sINNGLoXbioknJ/IDpsesXfc932RN+i9Q2QRHzBSCY84t1gImP1m85HObmq9Xa2T
         mhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3jlmpDi3pSMTdz6KTum7rjiXC4zJCibhSFCAK3K7xuA=;
        b=pOw3+3QxQ7nPt+XWLk5DYzXHt8w4ppDQVnJhTHWAaD8EMc4kaNViZf7692Z40MrkIx
         0ecDo9e0x1h9Lo1QPZYTpbtVyiNiNr/40Kjk7237RAULPbiTSoMtI34VtUD5tjFlThNa
         rXh5qeSCEQ3saRQ/LAkFRWeZth8wYeHS4r+m68aQmsVZ75evpeikoTNgv8CTagodSHuJ
         kntAeKqk8HPujEfzKqLW7i78hfeQZ5jEPvQgKYAZSAKNckpm0yHthjH2kDzWRzG8A42b
         64jBrY9c2SP9gcZk0sH4XJjDyh1TzhMqJaDfG0UVV3Rq9MZOvzqSm4rpagnCgfQHCDq+
         QdlQ==
X-Gm-Message-State: AOUpUlEKhMBvlSjj8uqeIGodrHCwSVSmRPHT4xVeBGGZdONAHVfkMLhA
        eldqJ/5nbkDpTd8Tq75Afmg=
X-Google-Smtp-Source: AAOMgpdxti9L0mA1jgjIBHUysp8LTHZd8nYuJXLp8fwteytxnTEIptL+zMMNiGNE2zIIoJj1/9/pkQ==
X-Received: by 2002:a63:ed56:: with SMTP id m22-v6mr5178830pgk.148.1532679915463;
        Fri, 27 Jul 2018 01:25:15 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id v7-v6sm5060830pgh.57.2018.07.27.01.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:25:15 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     cooldavid@cooldavid.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: jme: Replace mdelay() with msleep() and usleep_range() in jme_wait_link()
Date:   Fri, 27 Jul 2018 16:25:07 +0800
Message-Id: <20180727082507.3917-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jme_wait_link() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/jme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index 8a165842fa85..de5ed09212b0 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -1909,10 +1909,10 @@ jme_wait_link(struct jme_adapter *jme)
 {
 	u32 phylink, to = JME_WAIT_LINK_TIME;
 
-	mdelay(1000);
+	msleep(1000);
 	phylink = jme_linkstat_from_phy(jme);
 	while (!(phylink & PHY_LINK_UP) && (to -= 10) > 0) {
-		mdelay(10);
+		usleep_range(10000, 11000);
 		phylink = jme_linkstat_from_phy(jme);
 	}
 }
-- 
2.17.0

