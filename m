Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52860C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F182089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De9+5RYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F182089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbeG0M1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:27:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44097 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbeG0M1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:27:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so4082096ljq.11;
        Fri, 27 Jul 2018 04:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2eCDJqCQOR5gJhwrnKSgSE2xyMt1RtU4mVw1jc49DtY=;
        b=De9+5RYFkEKrgTdSJtIPY2K7AsY0faRjBt1jyqFm6s8g1YM4QQUEqJ2kURuCIhopoj
         bE7t7ndxcXjsvrwG0myxXF7rzcXkdZNDvlaE4mhe6GQIXZUUGyC2Y8C4msmsluRuS4Jx
         LteQaVxzGJOd7CihD9NOlov7d1OzOKLkoa6CqQ5spAY7hygsrXZFEjkoXtI/HZFPyghe
         yq+Tcp5zu2fhbHC8AN5bPa6MsZtc1bDYdByLADdMlwugPizh3qWEF0jqtW2HDhpooxYg
         K3YzXikjUuZKsk4tNI684Szgn0XWA3ENwl0+1cwpCEAJCPxwYDPhZM4wl46RpnssSXGF
         5Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2eCDJqCQOR5gJhwrnKSgSE2xyMt1RtU4mVw1jc49DtY=;
        b=b8+MRintATTUFqy3MH61tiMpxyvtcnixtA5KIBl8PLB5MY8rqjA06wDO1Uh6E0eYD+
         vlkrBg41crtkNFRuPs2TlqgJq64Co6b0y+qu/nrhM+xxSXPXGK/PQP4JTMjFRig5pHt5
         CoMWtf2dIp/YiiFCiVkoVjf000woOjXgdrHh4lre4ND+CV/QeyrdZc7pU/hht5lgwAuz
         dOd4YhBEEvrL9pJ39ecw2hNTplTjoUQMF/TSAE4ZMrSUhqyXI8DrU71/2ZJvkziirkzr
         ZAAeECwOkZf1TYayXGUq4klwiF5g7L9n20R3q4efqwspzaYe5EfjYDUsC0XTr7vtAdUv
         PHqw==
X-Gm-Message-State: AOUpUlGoZeBTHHcfrAkvgBrMKijLIJsW3ZPPugF2badmCW7SK7DGMRq1
        M9GNhhqi0t1if6iQ07oVxIU=
X-Google-Smtp-Source: AAOMgpeSlmXiFkrDbWHot+/ZCruZTggaYVxuRpChVlwva/hbVJJ82IpfHnOadx3pVbZGhysYrZtdUQ==
X-Received: by 2002:a2e:1517:: with SMTP id s23-v6mr4813145ljd.73.1532689566182;
        Fri, 27 Jul 2018 04:06:06 -0700 (PDT)
Received: from debian-tom.lan ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id t66-v6sm616475lje.95.2018.07.27.04.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 04:06:05 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     asmadeus@codewreck.org, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] 9p: fix multiple NULL-pointer-dereferences
Date:   Fri, 27 Jul 2018 13:05:58 +0200
Message-Id: <20180727110558.5479-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added checks to prevent GPFs from raising.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+1a262da37d3bead15c39@syzkaller.appspotmail.com
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

