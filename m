Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE8FC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C672206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAHsm6fD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C672206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeKTX74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:59:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40509 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKTX74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:59:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22-v6so1009585pls.7;
        Tue, 20 Nov 2018 05:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Jj+IBPS75yOfj3K1NF/fGtDTYWZ8n1i3EaUHftboACg=;
        b=FAHsm6fDINrGw8wMygdx2fSENuQEwt0x2CZon4ougH539Y48NqbJnT9lz39OTGijFH
         IDrniuiTXAh/6Ah6sZHUqOqUEeMg/gETFAeIlW4k6dngyqWmGkKpUfZjGqjIgXReNhaJ
         qcuI+rZ03WPiIVxt3Qbq7rsC4jkkh82xf1EhjqpE059GXqVeBaYpx3hZXFzXCMvP7T7C
         Z0ba76jamXN9OW1NxHNirEZT2LFaa2o6HuVxPhaL01Lq+WuKbOigz0dDAPMTa3GXo/Bj
         cuzz/4DFmHV+Ht8o7pJ1w5piaCraf7PnkfeKMMNH04yCc/e6qyij3itl2fqPNFtbxP9F
         uPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jj+IBPS75yOfj3K1NF/fGtDTYWZ8n1i3EaUHftboACg=;
        b=VsZBdvxVaWRxEMwBQWcfbw+2NLktGXnF0alygbcSkH1K00Tm2QC6rCEn+Qr7YEv1nA
         tonwte9bXFs2gROfnEbQOpryavgF0dfl6XTao4XhF20P3/L/sc8waYlDWgnCoWXeU8w+
         228IBmsgglWojrEiNGEkQP8gUM0AmX4cvhEJhvVJg8H/U2a83Au7cqVVnRVQHxeHoAcA
         meHYvAdcsACWEqJ1Ox6A5EON5S32M89HFrTCJxz1oLv3Zb8CMSI/3uXyOQUxLUNyqMrx
         8546m6ihlX2U65/nyWBG5eOHhMiU0QfgOHTQPGIUtA70+N6cGbo/SUFCs0x5QECwKudS
         Tt2w==
X-Gm-Message-State: AA+aEWb+KzNl/tp7JM3XNpR/tNPerZLovJDfzn3mk6vkw0q7F8KY0VFP
        kfWZ/sAyU8Ra/UNYRlRetCo=
X-Google-Smtp-Source: AFSGD/Vi6EWAH5TOjtTqqv64+sWF84fQudtTJvW/N8Jc+U7WdyfNF6OROv0D4eT6AFcgz/xzhW+PRg==
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr2170449plq.195.1542720646991;
        Tue, 20 Nov 2018 05:30:46 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id p6sm22330209pfn.53.2018.11.20.05.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 05:30:46 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] sbus: char: add of_node_put()
Date:   Tue, 20 Nov 2018 08:30:40 -0500
Message-Id: <20181120133040.19889-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/sbus/char/display7seg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index 5c8ed7350a04..a36e4cf1841d 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -220,6 +220,7 @@ static int d7s_probe(struct platform_device *op)
 	dev_set_drvdata(&op->dev, p);
 	d7s_device = p;
 	err = 0;
+	of_node_put(opts);
 
 out:
 	return err;
-- 
2.17.0

