Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F1DC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309622084C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9YC1Bk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309622084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933342AbeGHVJk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:09:40 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45460 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933074AbeGHVFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:35 -0400
Received: by mail-pf0-f195.google.com with SMTP id i26-v6so719063pfo.12;
        Sun, 08 Jul 2018 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wpQoSsGu/dAezAbrk/DRxmURgIXqpOmeNpRbw4f9Plg=;
        b=k9YC1Bk0pvrOE4G1lGM4AOsQgFbBSRrCKQBAci6TcSRGcddtQzIaRCIVfmlMsV6Bdd
         jb8R6n689BRVAW38RJggYmtEZwxMq3y8eI3I3eXU7S+dOsXJrYbDB4wsXuZrDe1mgNLE
         +WcY1P+7v45BDbshkpiuCJt/twb4U4n3TdsHNozlkxaU8BOCDQyhs23+vytFSxlBuAHg
         5p4jwMvfPVKo2SDrAq+DO7VVt1A6MmOfzAt1tiHdnO43c505yQ/X77aapn0wlNY5SW6d
         m6aKhB9pqmx8QgtKEP2fQP69u7yP9FSnu/oskfW8Yo6ZUp+VNE0DkQjbxSZx5iVWlRJl
         C4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wpQoSsGu/dAezAbrk/DRxmURgIXqpOmeNpRbw4f9Plg=;
        b=YWoEOsneqSN/MQ/wV70FZ18GyWjrrc+Yi2lA5FLKvlm/SirLKcTqrb8zgem+Ymhk2J
         drArcyrHrok9z2kQvQlczkqPaN1KzpwB/9vpYe2pV8bxx/bZaxarbA4d7LFFTtkvMV/d
         tJl59Gy6Cnz+kdhkXAKQSnRfvyomKVwLyqfpNLDy+kKvSSOPiw6Wkdw5wzMPoa3i7FWK
         uw+bjpWHat9p4plkQ0qGXguaBGM2Ukm2sHq/4rbeQuOU6KiBNO5XCYGfn/xqdBEtC63H
         bNchhCRZi5UFEQlfyTQuQhKJs2qRUh5/50rJGf2VZDJdTzdg3FEPrr2cx6EQdykAgFVr
         o0Hg==
X-Gm-Message-State: APt69E0qOi0+6H0p6m6AWbIrUYsuw3rQoH2wfw86bllPTXxpZCgXsbSX
        OtkSvUyTb7h1CdeSMj9Uc7Y=
X-Google-Smtp-Source: AAOMgpdVO4Pljg8Kiq5gcGTKxWVoKUS3OY3fEuBM5SLqZile1C95gLd+V6+idpW0JhXE4YfMKevHuQ==
X-Received: by 2002:a63:68c1:: with SMTP id d184-v6mr16460573pgc.239.1531083934531;
        Sun, 08 Jul 2018 14:05:34 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:34 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 02/18] fs_context: fix shrinker leak in sget_fc()
Date:   Sun,  8 Jul 2018 14:01:38 -0700
Message-Id: <20180708210154.10423-3-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

alloc_super() now preallocates the shrinker, so sget_fc() must only
register the pre-allocated shrinker, not allocate one again.

Fixes: 8a2e54b8af88 ("vfs: Implement a filesystem superblock creation/configuration context")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index e6052a72f3558..a992dd0f27670 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -559,7 +559,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(s->s_type);
-	register_shrinker(&s->s_shrink);
+	register_shrinker_prepared(&s->s_shrink);
 	return s;
 }
 EXPORT_SYMBOL(sget_fc);
-- 
2.18.0

