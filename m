Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA27EC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 07:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5414621A76
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 07:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7xTpEx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5414621A76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeHLJfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 05:35:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39138 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeHLJfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 05:35:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id a11-v6so6158875pgw.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 23:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KKxaNydyGpmRa//Lja/l6lRO0TveX+lDLJnNrPc+i+Q=;
        b=k7xTpEx27vyemi292P7zg9KiuDecJAZmE18VEKFlB7UksIesF0lToBG1aJinP6z++j
         +BzNAClE83b2C5amD8rIQm8+WdyKCbjwRYHuu868AePGN0EiaiFodbA4eaMyVQcqvGQS
         syIJGoxbdsNlZxzpRh0vMmH4Cjf3zbQhD4NczLpVeh51uaSsKuofniz3DXjNDj2DrrwZ
         0eVjpk/30Nr2m21LEUSZQEObD+RPCotU5PeH1xM/H1HRnbUgTtyr9+mLsK7IgJylrmle
         zZhcJytFiBVTdWEmaurmBe/pSxoZJ0MwO7/26tEYILNoNDtWoWCIM9i1arvu10PQx04H
         MS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KKxaNydyGpmRa//Lja/l6lRO0TveX+lDLJnNrPc+i+Q=;
        b=Agm5Fop1jDL18OQJFJcQAjTxBV7zsUG9CfcnKywEJTHakPtIPkf55aJwC/NMS/65Rv
         U+33w3W1qLbCLUbvWVm0Xfz4nlhX87IBVxu8fy7PY5BZ8H/xtcJkjX63BznhNa/Zvq3E
         UeHzMtZuoNuWXshOLEs+ofezrYl5E6UU5Yl1fxRmlTSYz6lRXDXG0SWikIajuhxzISvs
         NRyhRNONYp+lSE0/pkFhp0HeC/23p6qem5BUrzCdP12G2/vc+WtYbrDehxy+yrbP77bk
         CFD+6TO6j+Hgsg7uQBsyVHdGteuJZdFdV6/GzNrS5ovc4CQitjxp07Gu+IksY5XVsJ3G
         L/aA==
X-Gm-Message-State: AOUpUlGTj+dgSrzuc/Xw0hVxHXIaKTLpI1ZmNAuHjf2hoEtAVXAPBmzr
        S07qXvZQivygdtPWloW3sVxSmw9Dd3M=
X-Google-Smtp-Source: AA+uWPyTF0VaEOKjg5HfUryCoriY0G5dCjsepmrcZks38pLWhDgudXCVYjiDAoDEO/YypCSt4zyzRg==
X-Received: by 2002:a63:f244:: with SMTP id d4-v6mr12215935pgk.2.1534057121388;
        Sat, 11 Aug 2018 23:58:41 -0700 (PDT)
Received: from ubuntu ([119.82.107.14])
        by smtp.gmail.com with ESMTPSA id 22-v6sm24381818pfl.126.2018.08.11.23.58.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Aug 2018 23:58:40 -0700 (PDT)
Date:   Sun, 12 Aug 2018 12:28:37 +0530
From:   Sumit Kumar <sumit686215@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gasket: remove null ptr check before kfree
Message-ID: <20180812065837.GA20728@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove null ptr check before kfree because kfree is null ptr safe.
Issue found by checkpatch.

Signed-off-by: Sumit Kumar <sumit686215@example.com>
---
 drivers/staging/gasket/gasket_page_table.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index d4c5f8a..bd921dc 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1328,10 +1328,8 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 				  num_pages * PAGE_SIZE, mem, handle);
 	}
 
-	if (gasket_dev->page_table[index]->coherent_pages) {
-		kfree(gasket_dev->page_table[index]->coherent_pages);
-		gasket_dev->page_table[index]->coherent_pages = NULL;
-	}
+	kfree(gasket_dev->page_table[index]->coherent_pages);
+	gasket_dev->page_table[index]->coherent_pages = NULL;
 	gasket_dev->page_table[index]->num_coherent_pages = 0;
 	return -ENOMEM;
 }
-- 
2.7.4

