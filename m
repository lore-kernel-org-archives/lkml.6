Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69404C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7092073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2b323YE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7092073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeI2Xck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:32:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37134 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbeI2Xck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:32:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so6620892pgq.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:reply-to:mime-version
         :content-disposition:user-agent;
        bh=xOYsHzIVIqXkd+oxHdpbJWMi2vKrLBi/u8T0C8kHHiE=;
        b=P2b323YEhcuOn1t38oYomaAmhJFmxuUQHiV7Vzx0eVth4NGiHhKOIa9BupGuq+jB1z
         SNybbslBspwC4OXV8MYKrKoHYYtjDg/VVnFUygta119XJEmjsY+g5RzMJHTP9TMVQVnd
         jP4oPg9elIT/u1SxxX7m9s0EffxEvCu3XUhowUmq9QIueavO9W2mrsJeqSmnlyTy2Bhc
         Skh8qb2HO4XCJp9BgcDc8qP4z7fr/VMsr/oWQdZjI4j3OulnjVT8xR7SVYYKj7IG5Flf
         6BKY6VqDZc6j/KrwaK6yuSW+PmU9TEenzgEkOfjCLSdjxVW7vshMz5y99cj9xwq/En8j
         Ol0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:reply-to
         :mime-version:content-disposition:user-agent;
        bh=xOYsHzIVIqXkd+oxHdpbJWMi2vKrLBi/u8T0C8kHHiE=;
        b=OPYvoX8t0L3LvKw7H/kNJuHduH/xij+J7fKJAlygrEG/ZO/xAsahdrhiRyEx1LcubD
         MFnGMEc3UtSjd6IKK4+fqjZeTI4znz1KDxM3rsxzM3A/V4JXo30rZiLIbAtakIgH2XaD
         c85o+AJLv8GlZ/W+v11A8eFeV7hYMNdiosuYI3v3ebVXH6gYoNKz7kb8Dupv0nfK0g+B
         DM8HDJ8IPUXD8Mbu7KvU6mjlKikflKuZVKL1/BCPewkdHCxP4L5tDUpC/nSc6fe27WOQ
         TC94IAUgKwTVNwUPvuWnvYnoI7aLQgy+B6xPLAYcZf2zh60dqN3mYwVLMq/fdBC/lZkj
         Hviw==
X-Gm-Message-State: ABuFfojM/cedDVzC/tiAq8Id+JE/rIqYQ0/Au53hfTLU3XZTVt39Tpj1
        kwKB0MkFm2etaEqyAPSOh69xXwM=
X-Google-Smtp-Source: ACcGV62NZUJhnaSiN1v+6BriXYEU55C8DsfH3yXUThl1aDT9/1/DhxY7iPqkmQoTZaKXQ1ESqGP1Cw==
X-Received: by 2002:a17:902:b08e:: with SMTP id p14-v6mr3983878plr.241.1538240610412;
        Sat, 29 Sep 2018 10:03:30 -0700 (PDT)
Received: from localhost ([182.69.157.96])
        by smtp.gmail.com with ESMTPSA id q85-v6sm12050531pfa.151.2018.09.29.10.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 10:03:28 -0700 (PDT)
Message-ID: <5bafb060.1c69fb81.ebebd.f24c@mx.google.com>
X-Google-Original-Message-ID: <20180929170325.GA8525@tapaswenipathak@gmail.com>
Date:   Sat, 29 Sep 2018 22:33:25 +0530
From:   Tapasweni Pathak <tapaswenipathak@gmail.com>
To:     gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, tglx@linutronix.de,
        tapaswenipathak@gmail.com, linux-kernel@vger.kernel.org
Cc:     tapaswenipathak@gmail.com
Subject: [PATCH] tools: lib: subcmd: Fix null pointer dereference
Reply-To: tapaswenipathak@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add null check before dereferencing ent. ent is pointer to memory
allocated using malloc and is dereferenced immediately without
null check.

Found using Facebook's Infer. Build tested it.

Signed-off-by: Tapasweni Pathak <tapaswenipathak@gmail.com>
---
Another option is to dereference only inside if (ent).
 tools/lib/subcmd/help.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 2859f10..b805d1d 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -16,13 +16,18 @@
 void add_cmdname(struct cmdnames *cmds, const char *name, size_t len)
 {
 	struct cmdname *ent = malloc(sizeof(*ent) + len + 1);
-
+        if (!ent) {
+                printf("mem alloc failed\n");
+                goto error;
+        }
 	ent->len = len;
 	memcpy(ent->name, name, len);
 	ent->name[len] = 0;

 	ALLOC_GROW(cmds->names, cmds->cnt + 1, cmds->alloc);
 	cmds->names[cmds->cnt++] = ent;
+        error:
+                if (ent) free(ent);
 }

 void clean_cmdnames(struct cmdnames *cmds)
--
2.7.4
