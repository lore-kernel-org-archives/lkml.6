Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15358C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DE22088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqgdJ3Ou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DE22088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeGZJ0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:26:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45442 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeGZJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:26:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id j143-v6so574527lfj.12;
        Thu, 26 Jul 2018 01:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Rrp/68miJgWjpJ7zFFkV6Im+RbF3YAJllr/nxUM+/A4=;
        b=FqgdJ3Oucm2jDyMh5wOSojqZ5zt0oyg9iBlZl7M5xdtPcqEz3IHEFpiV7XIYFGazbY
         kP4f+pyPpLKmTztpeLLIYSkMhJe/WyUShCAlSRDiYllQZjjXjkm4El8oEAZCNBg8lo0J
         p2PnuDhUN4gvhcg14CGCeVVXfSKRVPpwcqoP8XRvDb09mF7+tG/mo0XlCQ7SoMnhX7Ll
         H/9juZT93xul4RV7wWJUF6/qxd/Kvdqxdnv0Z/8Dx1ppADGD3V2GwQZzy05sphXf6gGC
         gy6goQbOXiTJYrICcPFGjujub5xgZgRXHeg7Ms0Q6H/CiiK0/JCRR1/My/AtBe9DLDQx
         XVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rrp/68miJgWjpJ7zFFkV6Im+RbF3YAJllr/nxUM+/A4=;
        b=Q6A4zggc2WkSkD8vijbUL1cWjEEXvG+o43aYLNmz4VlXWvOQfcbEssc2jWx0e0zrOA
         7Srf06DQnzItDjQf9ZV8fZE7qeAvQUQOhYfbXiXto5kozidaMFb/zKy+owZSRKVYKQGP
         cjGoT33uFe4ZReU/pEo5ETMPlhhuPT4g7MZSxb4D1NBR7nDyi6fh9LXt4kbZ6lr8MJDM
         ZX9cOYejZB6p8fcpzE3Q126jbfiQsbEr6pgIWdYbP2pEVB3e6P+s8Xh5SZhozLA0tcT6
         M/nrswfFsOaWBe9H/z+WkWsEYdYOIqmchmrsT+zxNdHUNQv9olT4gHYNGyTs0tm+Bjk0
         mMaw==
X-Gm-Message-State: AOUpUlFYsgVmAH2TmAbavlSV829tqvzetaUL+z39x6RUPY8l5X0sy9fq
        su/3r7mjlxBevFoiyZRcaGs=
X-Google-Smtp-Source: AAOMgpfdpNK/dsLzDH2XBMJggZgMgAfif7wi4SS18XJmQeMkGkBHzdA9LmD1n6ijr1qbXOrh/Mc4yg==
X-Received: by 2002:a19:5509:: with SMTP id n9-v6mr700755lfe.133.1532592657908;
        Thu, 26 Jul 2018 01:10:57 -0700 (PDT)
Received: from debian-tom.lan ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id x2-v6sm114186ljx.64.2018.07.26.01.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 01:10:56 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     asmadeus@codewreck.org, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] 9p: fix NULL pointer dereferences
Date:   Thu, 26 Jul 2018 10:10:49 +0200
Message-Id: <20180726081049.10527-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In p9_fd_create_tcp() and p9_fd_create_unix() it is possible to get
a NULL value in the addr parameter. Return -EINVAL in such cases.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+1a262da37d3bead15c39@syzkaller.appspotmail.com
---
 net/9p/trans_fd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 964260265b13..ecfceb659d0c 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -941,6 +941,9 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 	struct sockaddr_in sin_server;
 	struct p9_fd_opts opts;
 
+	if (addr == NULL)
+		return -EINVAL;
+
 	err = parse_opts(args, &opts);
 	if (err < 0)
 		return err;
@@ -995,6 +998,9 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
 
 	csocket = NULL;
 
+	if (addr == NULL)
+		return -EINVAL;
+
 	if (strlen(addr) >= UNIX_PATH_MAX) {
 		pr_err("%s (%d): address too long: %s\n",
 		       __func__, task_pid_nr(current), addr);
-- 
2.11.0

