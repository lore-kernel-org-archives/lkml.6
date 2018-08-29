Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FB5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F892083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="VTH3oS/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F892083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeH2QUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:20:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41301 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeH2QUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:20:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so3771539edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iBg1uCqOePo2LDQD2c20wRoYMAK/OSTDbgOTeB8gv9s=;
        b=VTH3oS/evm991XifbHxtoLWtJba9u+i+SMVE79aiZQYpTlVXJpLT07prOzvdrhecvG
         Fqg1V1tY69ZHsQwYYr3KygrZ2LAWrLCC7g6HJLm/5ZtGeTALAa663TethDCgCxGpELyh
         LqQxov5J3ozG5UXK+pQljH+/WP3j+fSU8vzn5d2Vmtp9nJLF+2uNxOL2ASts6na1DzUR
         fJ/OLIs1Ttwqo/SuQy+It/jUA8Ksl6+Bp3nNL+BtNYd47m3KFfyt7E4Fd48fFtmSFwD/
         Om07UwJGkvLllnwjQOMZ4BmoXx4KGyvcDFVVrMhAoK939DBFn66DVGB2rR3CoiK4rwVS
         UfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iBg1uCqOePo2LDQD2c20wRoYMAK/OSTDbgOTeB8gv9s=;
        b=hSL/cKcMT4vcX8FyZda3VKGy1YZKm4Z0eu3PkKLamqhj20/uXGaYubpKD76QNTAf/b
         KiZVzPDyTzGibKC2GgT6OR8aPR9t3itLBRHRAMz2Pw0KKmTATohTdIkjvsCe7pWzXEyJ
         H3jQ6JcoDexfATcv0EXSmT7Edmozyq1o2rvfgOUQQZ1cAPFlgy1WZtMtc1EIQUWh/ECA
         cr1YNVWPBMZmZUoYgp5wAdFaEyX+Yd87xTIpa7vKUO705P5n/ckJOKkyGpjkipGvZI4u
         ORMVgEdNqFQkoIsFeYbUCbY50I5lth0loZg+g4an4IvWgmutKBJgl/aFvYK3169qgtxZ
         FVOw==
X-Gm-Message-State: APzg51DpBWhPuCoJvcMIunRo7qoUJBVpGW64MCfy+03QzxO+hZapU6FJ
        h1gcrKrehXXPM1vAfCt3LVShsQ==
X-Google-Smtp-Source: ANB0VdYbZmjm7lvjZzIrAgDIF4woMGj3O/Sn3M5tcK/PDoYspDA130nYXhZyi+digGGWYSWY/JEA5Q==
X-Received: by 2002:a50:94b3:: with SMTP id s48-v6mr7142068eda.125.1535545438286;
        Wed, 29 Aug 2018 05:23:58 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id f26-v6sm1752068edb.28.2018.08.29.05.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 05:23:57 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 6/7] lightnvm: pblk: fix up prints in pblk_read_check_rand
Date:   Wed, 29 Aug 2018 14:23:33 +0200
Message-Id: <1535545414-550-7-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The prefix when printing ppas in pblk_read_check_rand should be "rnd"
not "seq", so fix this so we can differentiate between lba missmatches
in random and sequential reads. Also change the print order so
we align with pblk_read_check_seq, printing read lba first.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index df3c4eb13be9..6d13763f2f6a 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -149,10 +149,10 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 #ifdef CONFIG_NVM_PBLK_DEBUG
 			struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
-			print_ppa(pblk, &ppa_list[j], "seq", j);
+			print_ppa(pblk, &ppa_list[j], "rnd", j);
 #endif
 			pblk_err(pblk, "corrupted read LBA (%llu/%llu)\n",
-								lba, meta_lba);
+							meta_lba, lba);
 			WARN_ON(1);
 		}
 
-- 
2.7.4

