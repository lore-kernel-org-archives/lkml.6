Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144E9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEEC2156F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuDH6zd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEEC2156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391628AbeIVFaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:30:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36727 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeIVFaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:30:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id v17-v6so8518458lfe.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 16:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dCaiOk3F/KGB7VVMwtkjn1h1KxQNoK32W3u0wilmq9Q=;
        b=cuDH6zd44UYdeOzj8DSrwKFqQlzpnTrkQPG3jqu5/n/Jo92X7cPhteyjs4ojgHl31H
         9ohv90ic0lkHTJ6vvO42yQqcMc74JPjZQm7cOdGsTXp5Mtgav2nC0D8nA/nc0kVxZ7hF
         DAiLPcbfGGekmWvvEdKcDYmKVg2rPz/7UgaR7P5kcp+l3SNkBaCqLw3aa4GTEaJCxtdj
         ttYEJ69sZVbGRn11d01VGT2HBzfyNhHroxaNefwAsPAUy0eC7pIHGYsDl2ViIX1j2Dru
         K1ihHpPZhdyo4Mry6G+C753/Ab6W7hdK1wBYT9rcwAmoEJnpg35R2MimyQ3EecW7t5uA
         LwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dCaiOk3F/KGB7VVMwtkjn1h1KxQNoK32W3u0wilmq9Q=;
        b=NVhcQnL9lpoB+H3abHW7yauaQbSTwBzR/DDplFhAC+7N5hFlHCJkkns+OcdpRf+ipB
         Tr6fjO7AFeFJefRQEMuIZIwd29ILEKE8mTLyGuUAMdDg/mE+zNujsQeyn2iI03reI7BZ
         AdCS+gLTgVDMg8uwZo+SfFVomk6UINF5YQJcZUfdwc+xlSPs8srHGoH6S89rW+BVgTo4
         1roo7m3ZM6eyq1nHJQyQWmoXoQf4pgZiJ9X/6eVtlbjEWHxkSmb8RMBgS3lK4TBczFEd
         rzaCB7MiOG6vDInUaEJHmgEnP3jcJiGkCXQQT9SFoklj84hHkQQxOB+cygcpOJkm+Abk
         SZQg==
X-Gm-Message-State: APzg51CGtZK00jUVkktNPCbQI84jLG8Blk3KgwHFK1OoOclLUuVJbLS2
        SMAFIk9m0e1c2ANDYEW9Eks=
X-Google-Smtp-Source: ANB0Vdb/LJiWC5TVMOd2UNgNHiSAU2ykMSsm15rF5c2+tHphS5RH3erzbW7lgFhs1SrrEyqXp9Gq1g==
X-Received: by 2002:a19:109e:: with SMTP id 30-v6mr16075lfq.96.1537573135479;
        Fri, 21 Sep 2018 16:38:55 -0700 (PDT)
Received: from VB.local (89-64-36-36.dynamic.chello.pl. [89.64.36.36])
        by smtp.gmail.com with ESMTPSA id o67-v6sm2479986lff.36.2018.09.21.16.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 16:38:54 -0700 (PDT)
From:   =?UTF-8?q?Przemys=C5=82aw=20G=C5=82=C4=99bocki?= 
        <glebocki.przemyslaw@gmail.com>
To:     paul@paul-moore.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Przemys=C5=82aw=20G=C5=82=C4=99bocki?= 
        <glebocki.przemyslaw@gmail.com>
Subject: [PATCH] audit: fixed a braces coding style issue
Date:   Sat, 22 Sep 2018 01:38:22 +0200
Message-Id: <20180921233822.4362-1-glebocki.przemyslaw@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Przemysław Głębocki <glebocki.przemyslaw@gmail.com>
---
 kernel/audit_tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index ea43181cde4a..3d0e45fa765d 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -112,10 +112,9 @@ static void free_chunk(struct audit_chunk *chunk)
 {
 	int i;
 
-	for (i = 0; i < chunk->count; i++) {
+	for (i = 0; i < chunk->count; i++)
 		if (chunk->owners[i].owner)
 			put_tree(chunk->owners[i].owner);
-	}
 	kfree(chunk);
 }
 
-- 
2.17.1

