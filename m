Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58085C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BE5213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTRbJOUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BE5213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeHQQF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:05:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43540 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeHQQF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:05:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so2242401pgb.10;
        Fri, 17 Aug 2018 06:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tnV+BGPIPlSKgGQZ5260CLaewCxmsyLkhl/SNKkqrJU=;
        b=DTRbJOUBf2dfjtWWKq3FmPHZnfB4Vdc8hqlxuzkMpjIU8kMXIiaH6RmSfOaoSbS7TM
         Wr3Cdj81ehPcOsz1TBKZKzEvkrvoLcwW+Zf69um8qnE7GKgRNOPgBiXfkhYf8nwqEvh3
         ZQYsJIW57sisqiqHq5zWqveOS/7SbTzHMb4JN/Riv+J/p0vOXO+9K8VQo7f3kvbUZbqf
         9l0+8ZZ+7COh5qMxPCEplPegCwR34aat9cmtIwmoTWxC25sYgPVW3yyYuiXfoRqJafx+
         FVu16fh5rK6BeUiTjAkv1p/KcAEr9rkp9UsmwglFtSCW68cYjnJch/FA06D7BYguynxu
         ZTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tnV+BGPIPlSKgGQZ5260CLaewCxmsyLkhl/SNKkqrJU=;
        b=WOk+dSv7KGS4i/Cl/ROXqTwHznBaPwXA+XCgXVtyERcqJuEMkYLvZO9HvaIVbZ2pW5
         /puWMF365LoJl7TqEVg35hLWSFpAKfbxEDwqzD+SY+Ja+9b5/CsXRGr2H9xz1x/7Q6hN
         3UymV5W4igcwSKnDFIQq5mlJwaH+EQSvxOmeA8TdOAjWKY1E+HWrG76j5OtrByW2JTQY
         mkYKB6vMC297eTQ89cpGT3RPGWhCCkjnmQq9L7UGCfrl3rNKIl4r6b52GImULmdOlq0m
         NPMpmgBudPevy58jhOZsGx0SAaNAPVHtW5r/CHzB4ZwRn7IE+Wt88p5A2Bc17nWWE8PY
         MB3Q==
X-Gm-Message-State: AOUpUlEN/ms1N9rjvbqUxlZY8ZAS/P8IHFh4i4KG9ptmHKGKlgdHQpBK
        qvbmgpszBLaOndrPLvKRU2Q=
X-Google-Smtp-Source: AA+uWPzNaHqwdxya8hLMuomJQivERgsqcMNeW7UtxHh2eR86vZUp109Kh7HZGm9W9yRCHnm2nLPATA==
X-Received: by 2002:a63:dd49:: with SMTP id g9-v6mr32560723pgj.356.1534510957936;
        Fri, 17 Aug 2018 06:02:37 -0700 (PDT)
Received: from localhost.localdomain ([47.88.150.209])
        by smtp.gmail.com with ESMTPSA id w13-v6sm2138223pgs.89.2018.08.17.06.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 06:02:36 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     dan.j.williams@intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/3] dmaengine: mv_xor: move spin_lock_bh to spin_lock in tasklet
Date:   Fri, 17 Aug 2018 06:02:02 -0700
Message-Id: <1534510922-7735-1-git-send-email-21cnbao@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 drivers/dma/mv_xor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 969534c..7f59535 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -348,9 +348,9 @@ static void mv_xor_tasklet(unsigned long data)
 {
 	struct mv_xor_chan *chan = (struct mv_xor_chan *) data;
 
-	spin_lock_bh(&chan->lock);
+	spin_lock(&chan->lock);
 	mv_chan_slot_cleanup(chan);
-	spin_unlock_bh(&chan->lock);
+	spin_unlock(&chan->lock);
 }
 
 static struct mv_xor_desc_slot *
-- 
2.7.4

