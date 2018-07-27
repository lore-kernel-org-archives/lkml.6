Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9864C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D38208A0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCVSA1jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D38208A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbeG0Lkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:40:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46484 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbeG0Lkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:40:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id l16-v6so3179360lfc.13;
        Fri, 27 Jul 2018 03:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kqhe5/J3tTn/Za0w7kcOWAK2KSjhQ/tjb+ybn+FYwjk=;
        b=BCVSA1jn7T0y6E4KywM9ITF3++vP1pSv6Df+b4sh3NhLm+hrELiLWltk5zmPGWEX74
         fQlWC3IlMXyfm82gd/9c9qXkUFdGP1it5V5OjwZQsnaaX44pKxyeoTIIcqvUwYy/h9z3
         5/6aThTFj+QczXQNAN/JsdfPtumi4zaC4IEv+YMwVqtnjMquF0+p+cMFyyBsO6558Ye4
         VUvR80fDqUUUA+w4qqQkuzUOZDURfzHEjKrfpZiAmGlW3Qo1Mcyy86CsIv3QZj8/Yomg
         WIkTLOBcS2btXroCHyvKzCuRsPcT5lNDLpabVdaH1nk1gTM5NZjiWcltmTgGYrI7dMWV
         qdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kqhe5/J3tTn/Za0w7kcOWAK2KSjhQ/tjb+ybn+FYwjk=;
        b=KRaaU9bOw8zstxFR18rznFeubVtQE9AB7EUMG08Qoe/WjshVGge2M/Ke2g2Xd815SS
         qAOYz+Ff7wIsaDT+F1nWv+hbPT/5B+q3VY/y+TRpGCaR/83xVXKpwhYUPwWXPgaYDpvl
         JRdZIFXGBg8/ysEFNNtiNFCC598+9MEKRnOiRu6p0zH11m0Z0458hahDpUgLddiE97Ja
         u5bAsu7aPGBu9/4qi3Yvfw5MiMlYrWkqf+fxo3bNBJUgzTFmq2Lwi6yOaFhZ9pucObCt
         GeEO92W0xi5Bm+ocLdJzcM6acjqlllmNeGWgduYh5NlfgslhtphP3IeW3ChnhSJ1haFp
         Wmqw==
X-Gm-Message-State: AOUpUlGgcmZAjSVuYGEghsAEvu+fCw8B3pqKCUjZaBSdQ3nHKDvYrNa2
        nwtRc7R0eAGo1e72oxsriJM=
X-Google-Smtp-Source: AAOMgpcakWp7D35V3UrSeuU/FmIoAGHDeU1N8jUgKZ+SOIQNh9l/2LaFzb82n/KEXOSisH3FY9HQug==
X-Received: by 2002:a19:c954:: with SMTP id z81-v6mr3514481lff.107.1532686762365;
        Fri, 27 Jul 2018 03:19:22 -0700 (PDT)
Received: from debian-tom.lan ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id g28-v6sm494723lfh.92.2018.07.27.03.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 03:19:21 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     asmadeus@codewreck.org, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] 9p: fix multiple NULL-pointer-dereferences
Date:   Fri, 27 Jul 2018 12:19:15 +0200
Message-Id: <20180727101915.4191-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added checks to prevent GPFs from raising.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
---
 net/9p/trans_fd.c     | 5 ++++-
 net/9p/trans_rdma.c   | 3 +++
 net/9p/trans_virtio.c | 3 +++
 net/9p/trans_xen.c    | 3 +++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 964260265b13..e2ef3c782c53 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -945,7 +945,7 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 	if (err < 0)
 		return err;
 
-	if (valid_ipaddr4(addr) < 0)
+	if (addr == NULL || valid_ipaddr4(addr) < 0)
 		return -EINVAL;
 
 	csocket = NULL;
@@ -995,6 +995,9 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
 
 	csocket = NULL;
 
+	if (addr == NULL)
+		return -EINVAL;
+
 	if (strlen(addr) >= UNIX_PATH_MAX) {
 		pr_err("%s (%d): address too long: %s\n",
 		       __func__, task_pid_nr(current), addr);
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index 2649b2ebf961..2ab4574183c9 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -645,6 +645,9 @@ rdma_create_trans(struct p9_client *client, const char *addr, char *args)
 	struct rdma_conn_param conn_param;
 	struct ib_qp_init_attr qp_attr;
 
+	if (addr == NULL)
+		return -EINVAL;
+
 	/* Parse the transport specific mount options */
 	err = parse_opts(args, &opts);
 	if (err < 0)
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 06dcd3cc6a29..8ca356eb66bb 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -654,6 +654,9 @@ p9_virtio_create(struct p9_client *client, const char *devname, char *args)
 	int ret = -ENOENT;
 	int found = 0;
 
+	if (devname == NULL)
+		return -EINVAL;
+
 	mutex_lock(&virtio_9p_lock);
 	list_for_each_entry(chan, &virtio_chan_list, chan_list) {
 		if (!strncmp(devname, chan->tag, chan->tag_len) &&
diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 2e2b8bca54f3..c2d54ac76bfd 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -94,6 +94,9 @@ static int p9_xen_create(struct p9_client *client, const char *addr, char *args)
 {
 	struct xen_9pfs_front_priv *priv;
 
+	if (addr == NULL)
+		return -EINVAL;
+
 	read_lock(&xen_9pfs_lock);
 	list_for_each_entry(priv, &xen_9pfs_devs, list) {
 		if (!strcmp(priv->tag, addr)) {
-- 
2.11.0

