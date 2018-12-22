Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E9AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D6E21927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDQz/dDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeLVCMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 21:12:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38090 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLVCMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 21:12:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so3268586plb.5;
        Fri, 21 Dec 2018 18:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DpBXnTrI3d3LSp9uVlQfU7VTXWrDm9hWpNXZOCmAIV4=;
        b=XDQz/dDAou1ZwGcANy2a0ttg8Lym0TQc8Rz4TlghW30bOwvkLzIxqQ0/gr4GgCHalR
         tjeICMQnd+TDgd41hwbYlZzwsvsBLoYgIvbWoPMsSwHHE281PcPCVsbemFMeLVGXOCya
         +/47lc0a4fH3JztoqNnyYReVqrpY1Xe16fGG8ywpPBjuEaj+x1HVo0bZRkIG6LqVe9rD
         Rrf4WhnE3viDBjL9I0aeX3qMZj5jv8dGJBp2RloMeTuW5VZJf0Qi+Ulryh3P7vdd3fNI
         AoM8A1Ibae6E2bnNclW2kWDJSLWzzXmbuLwzKTv6qk0db4tz9eYdJ3kfWET1SyJ/KBv7
         M4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DpBXnTrI3d3LSp9uVlQfU7VTXWrDm9hWpNXZOCmAIV4=;
        b=c4TA5ae2icr67Bdefcd8SUO8ST8SJCBEF0OAhGbF2UuJdx8edgJGJHU0NaEGjD1q7a
         1DSZvZMVYEyQS12/IkLApiKDO9LrpWpFxNN0vg4hw/76svYDtXNTJUUQmg8VdWUCmQMD
         AdF4zAsx9c3/p7coKDDNfDgZOeZidUgKLhLAtYzsIqIWxQwPnGZ1YS9L4C4MVQtjnjBp
         mMk8NhkUIeGruG8YrLsRXxkWHWFoAMH74hdAgQ5IDV01lu2l/Twz9GaKSknFd4Mjz9iy
         pJsdMlyDizk/4HoMJX5ACNZu2v0liZOBtA7zc0c230j8ErbiL8fa15xHW/nztDd+FeKV
         DVdA==
X-Gm-Message-State: AJcUuke0C3e4GKfh0rAvy8qyXv8zo6G5o2Yyl3os1BdPeDW/Or52z/kk
        xquoYjO8V4w1i5TGtT6PEPY=
X-Google-Smtp-Source: ALg8bN5fmmG/i6ee5iIYRv5CfR39/S0owTb9pWxcvhluSuELBUplv/ObYVzojV8PXD4BXoPwFvEKAQ==
X-Received: by 2002:a17:902:7296:: with SMTP id d22mr4955123pll.265.1545444764949;
        Fri, 21 Dec 2018 18:12:44 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id i62sm27587666pge.44.2018.12.21.18.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 18:12:44 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mcgrof@kernel.org, keescook@chromium.org, adobriyan@gmail.com,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] proc: sysctl: fix double drop_sysctl_table()
Date:   Sat, 22 Dec 2018 10:12:21 +0800
Message-Id: <1545444741-31694-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callers of insert_header() will drop sysctl table whatever
insert_header() successes or fails.
So we can't call drop_sysctl_table() in insert_header().

The call sites of insert_header() are all in fs/proc/proc_sysctl.c.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/proc/proc_sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 4d598a3..5eddca4 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -241,7 +241,6 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 	if (header->ctl_table == sysctl_mount_point)
 		clear_empty_dir(dir);
 	header->parent = NULL;
-	drop_sysctl_table(&dir->header);
 	return err;
 }
 
-- 
1.8.3.1

