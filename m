Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012CDC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910F5214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1iqE/b7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910F5214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeJQJTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:19:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33083 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbeJQJTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:19:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so11707214pge.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 18:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=CS8dgnIFpYQ7Enn0sLvT3ctTvSkag//XEF+SGM30/ik=;
        b=V1iqE/b7mbZxVebrEW2TwdC1dnfGW++tJFxMWQF7YcYDpKpnUhl7UJd4ExRPNKXYsv
         NxCbufA92jY0tk0r+zM888yvi5IRd7P8mT3AlIrRDwTaA2MtVQhjgTt8b6sZaELUtXCc
         1mzpmtefGlUUaOfh/iPsFIkFw/YYoanuR7FSsmOfaEN6Arb6fKxEAtgCVi0e2RJiRbEe
         vTJZHkNjCv9mAXNdZmqXtyuCXBc75v5Z5bSqAXNwhoisQ+fuc2emxEHjFPEyNnv0LPvo
         mhMlLD6ptw9djq/wTjEmEj24CmoAapKuhabv6RcVFqvHP66YZayK75FF1vOZqd4DwzUI
         Cjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=CS8dgnIFpYQ7Enn0sLvT3ctTvSkag//XEF+SGM30/ik=;
        b=Lemi9D8RkF7zJxP5kqhd1KhIGqyJPMNkl+nS4+jEsM2YpLtGV5FnJX0pO3u1rkK0SI
         7r+OBsH5tldSlDuqJ688+0ByJ4UhC0fw9E6bmiweSHg6lkJlfViWjBMLE6A6vlJAjxLk
         SqVnmNxfV/qMqkpALUUoeF0Bs3MBefzK2vzcJDuaEQkLXP9pjDkJpqkHTNQWIo4stHnw
         tFQ4ZV6+x35Vs0T1mmItTHFqpRWklTOFnbssm4515WJwbgZRe4Y5S1kv0XaEgkm/uUPo
         6W0etoAumg8ynoYBNtqqd6G81IFBSghX3kH6Tx1tXrtIhE6ZGL9D+DdQ98y/KaI0AY62
         MlXQ==
X-Gm-Message-State: ABuFfojRycMzhH4qoMlNV+LSGLlAYINPQHwQr8lRx5r/4Bx942HutGEQ
        c5nE6J9u5juIbIetmTSEdCk=
X-Google-Smtp-Source: ACcGV60GNtiJzp2PHXN/UZtAs9vz6moXmWujTblh55/4MOF2NbPfYHtI1XV9jzM+qLAO6QX1i2KgtA==
X-Received: by 2002:a62:210:: with SMTP id 16-v6mr25316117pfc.100.1539739570220;
        Tue, 16 Oct 2018 18:26:10 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id t85-v6sm24126389pfi.73.2018.10.16.18.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 18:26:09 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] cacheinfo: Keep the old value if of_property_read_u32 fails
Date:   Wed, 17 Oct 2018 09:26:03 +0800
Message-Id: <1539739563-1886-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
property_read_u32 instead of get_property,read_number") makes cache
size and number_of_sets be 0 if DT doesn't provide there values. I
think this is unreasonable so make them keep the old values, which is
the same as old kernels.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 drivers/base/cacheinfo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 5d5b598..dd6a685 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -79,8 +79,7 @@ static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].size_prop;
 
-	if (of_property_read_u32(np, propname, &this_leaf->size))
-		this_leaf->size = 0;
+	of_property_read_u32(np, propname, &this_leaf->size);
 }
 
 /* not cache_line_size() because that's a macro in include/linux/cache.h */
@@ -114,8 +113,7 @@ static void cache_nr_sets(struct cacheinfo *this_leaf, struct device_node *np)
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].nr_sets_prop;
 
-	if (of_property_read_u32(np, propname, &this_leaf->number_of_sets))
-		this_leaf->number_of_sets = 0;
+	of_property_read_u32(np, propname, &this_leaf->number_of_sets);
 }
 
 static void cache_associativity(struct cacheinfo *this_leaf)
-- 
2.7.0

