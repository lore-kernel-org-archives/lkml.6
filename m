Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA22C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272EB20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reVpgvIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272EB20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeHaCkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42165 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeHaCkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id z11-v6so8465626lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r6G6XvOx7WSJ50kmm6yeAHslC7dwvm+gtE9Rh/+Z8H0=;
        b=reVpgvIYNUYhY/Ko2VzJEhjtULIqREfwFJIHA8V2uv88LqGXio66wK1Jo2oxyVaUuY
         KH43vGh3Sw5pm67oZxHyqTZUfQxQqfYVco7Zz97ngl12NbTM3d1cRrCVX3ayTdzWV+vX
         rQsLZh6DoiDKN57CEWkMgevsHF5Qr9daYs+kB8fc9k8gY7xx58D4ilG52ykl4QSry/JJ
         3b0k2jEwJb9NMm2F2rNDOPBT77jEStUv2vIHJ5DfSpwg9m4jcSTC5ceTbJSyCDuk9C2J
         cvR9wpMYAv/YK+ctkmPOaSCM9UKPj+wQdQ5GnmPB1zzpdrPLk8wMsVfzkyXjgFLSZsVB
         0PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r6G6XvOx7WSJ50kmm6yeAHslC7dwvm+gtE9Rh/+Z8H0=;
        b=J2kDxaIe5cT7z6ZTMWq7dAdmp5RjLGIqVR8GMzmAuXbRKEWid90REWSRYgVodu69dA
         3ldeMloe/tiVB3w4BrFwR+b2chDi2Nvq2gI4Q8RctsMNoTMO+gllZUUTPWxUgB7u7/iH
         9OQecVk1CoD7Cv+CdKb+a6A+w5jZZQE7UbrciCZpeUmlPUb3QUJNx5U4dtlVOxSoew6f
         j+tSr+tn9AOPZCKEkjZ/qWBUcpPYvEwvZG/9rvlO0IUR8scXaoQ2u2NZBYYkXC42JREZ
         PdXCj7CI/QV/XN9gQdz0A9XFumvzUU6nSDAyLXE9OGTa8nA7VKvn7+Kcyqaoom4spPCh
         YHTg==
X-Gm-Message-State: APzg51DvAOnp7FFt1vzvqxGQqq+EtIhef4uzarPlONGz0mLNnQ/XWGLm
        RNesic7V+bOFxy0luBP0xaq0Z/udT7M=
X-Google-Smtp-Source: ANB0VdZU3rLHGB23IciywXOuE6qTANaDofRQlZQxDezr2eeb3jA1AX1J12DX8Yqa1/LMKPdbvdj81Q==
X-Received: by 2002:ac2:50c7:: with SMTP id h7-v6mr8337424lfm.47.1535668549092;
        Thu, 30 Aug 2018 15:35:49 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:48 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 18/23] infiniband: scsi: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:24 +0300
Message-Id: <20180830223429.30051-19-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index f37cbad022a2..447d21ea479a 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2708,7 +2708,7 @@ static void srpt_queue_response(struct se_cmd *cmd)
 		break;
 	}
 
-	if (unlikely(WARN_ON_ONCE(state == SRPT_STATE_CMD_RSP_SENT)))
+	if (WARN_ON_ONCE(state == SRPT_STATE_CMD_RSP_SENT))
 		return;
 
 	/* For read commands, transfer the data to the initiator. */
-- 
2.17.1

