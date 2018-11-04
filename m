Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49944C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA6B2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6PBUOLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA6B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeKDMGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 07:06:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33792 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbeKDMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 07:06:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id k1-v6so2662101pgq.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 19:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TEj0UfRyAG3KX5ahhn4MYaNDQLW4PRCkoVBVWXuiLZI=;
        b=E6PBUOLtqzAUFATwUW8jhzLlgWJTqFGPxwD6Ju3r2jrBBf02IuhoEtJfusxssYTWfz
         wUkhiGWvkCEUX9vcTARjCuUGvIrNv3Sotyau7EzQrcWE3izzEcP37Xw8ehW5lGFiBHKS
         vcXu+431XJJlXhrZUvPB7pxSkFMcj/8tZ8B4vLPFa+yMsTkw5N7e4YnpTMPUl57s+p6l
         Rt4YRd4iLIgQh4DEpP9J/zzeJiPjILRWNCdduv88jvEQiTfA6q0mP5qbsMl0AYbng+wz
         zVIM1rTqzw3SDwIwIyFv8QBKFx7coXri0A0Ai/9bl1iU96W+Uwu7vZp2atJO/3o8AaTc
         3t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TEj0UfRyAG3KX5ahhn4MYaNDQLW4PRCkoVBVWXuiLZI=;
        b=dVlxLKmlGQHFNpptRIYX6SHNKBMnSs2dVy+Y4xkz+mfzs1czo+PZam8Nuz2KpQNfs3
         VC4/o0pEVceot5Hi/58Xf+yfg6Sey1cwA917Z3X6ydyKgTnuUPTE1MzbMtOjhkiO3isw
         imBoli9i+cpVX6X/asH/ZoeCQnMsqE0QfV7LkipISvVIz1w2ndARCQDjwJYmxiKrPsIV
         He6PHGNeYNS+Tqr5Izt6ot7v6EyBiyFwfvDP0eSQklRIn7TcHbzXpav4X198TV+5hR40
         7wplAXM6iTa2DBWL8w8DnYWSWr+JK66czuJJjYw+8kwdavAlWcn0FyT6z+2737IXTH0E
         QIsQ==
X-Gm-Message-State: AGRZ1gKGffmL+NSzZoaABYX6ggvnqIKiGHPxCV9Wy1QeeTigHwnAZULo
        pXBj21g3AKl2DK1m+YC5+6o=
X-Google-Smtp-Source: AJdET5dKMQ6yBmHwd5RdBiCAQ2SINmnz+pHS4QiQ6fY3HeIJ9zTNEeuvtvewuZBRybqrWmp/3F0DyQ==
X-Received: by 2002:a63:6205:: with SMTP id w5mr15669364pgb.53.1541298468613;
        Sat, 03 Nov 2018 19:27:48 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id n26-v6sm25413606pfh.166.2018.11.03.19.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 19:27:47 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tj@kernel.org, guro@fb.com, axboe@kernel.dk, dennis@kernel.org,
        hannes@cmpxchg.org, dennisszhou@gmail.com
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cgroup: remove unnecessary unlikely()
Date:   Sat,  3 Nov 2018 22:27:41 -0400
Message-Id: <20181104022741.2518-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to use
unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/cgroup/cgroup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6aaf5dd5383b..2e5d90dfcb49 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5978,10 +5978,8 @@ static ssize_t show_delegatable_files(struct cftype *files, char *buf,
 
 		ret += snprintf(buf + ret, size - ret, "%s\n", cft->name);
 
-		if (unlikely(ret >= size)) {
-			WARN_ON(1);
+		if (WARN_ON(ret >= size))
 			break;
-		}
 	}
 
 	return ret;
-- 
2.17.0

