Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0290AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4EB20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub/5mo8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4EB20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeGTKPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:15:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38132 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeGTKPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:15:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so10574695ljc.5;
        Fri, 20 Jul 2018 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=idb1mXY0Z7rqmiUMtg8HSu3iIEEwRY3Iy++nCpxALIg=;
        b=Ub/5mo8cOJPeLHGakNNFBI1k9+ZXKDxDpVsDIvtFssnHW7yh53MlcW2P/WzDjHWpzW
         7EqAskmnBUXSs/j8QPs8B01WCPoIE2h3aiSYKjsKXuHqlP4oDzx0tcm7sb9ev1NF5gnN
         pXsOgZkbYjBdgIU2DL7MQ4MJAkoNGpcDuaApr/V4LeiAxHPrZRQjaIq8nzxT/1TrYgik
         z2gvRbq1dI7v8dUocWgJI4qLndAg6k4txUEunIpQe9Xvnu83DZSl7Ak0DhCU1DeQT0XM
         KkaZv58JLVZr1Ad+mqjkWyBWU5YqVcdLffwruJ05Lu2/SZBYpHhQ6Epked2G2S0mxZZw
         4qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=idb1mXY0Z7rqmiUMtg8HSu3iIEEwRY3Iy++nCpxALIg=;
        b=IZW1WFbGDskdOF/VaeYvOThi5ad0Emf7Ed59C0+joJ0cjncbduBAZSG/Mh2VT8BVke
         h1CtlXHMYq2rmPILKaJdttgXm0bVT0sfJzPX49fKDOWJ40yHdwZH8RPVqxZ5VSocsUAC
         nAQsJn5YSPonDEFDqGTv7EK7MlRhGcq/zhdxuWeuFqYT9LLBBR5zEliQ4tzlgIMXqYVe
         bFSKuHtXDE39EVpyYfCF8G2FDv4u7ECegGhGrDEcDxoM/oyG9heMD4A+oFgA4QQdE7Va
         SdyjDsg+BtcEfkL2KDyPhk+Je7xDMi31FsTuXFfLy1cE4D9aXKNWLSTMF6jqRlcd4UPE
         oKuw==
X-Gm-Message-State: AOUpUlHk5QgZAnYUMZs+5KCWUi/PsYa8xEh3tFtGVTEALVSIMVFfJzwA
        LdnutIyULwYlkD2IQAHhOGM=
X-Google-Smtp-Source: AAOMgpdh63/vdzcWhedwqQoBaP7q+MvrqAOpleJOmTIDOD48A5DbpKjwRmiU9wUdOc1oKVKSTV6Z9Q==
X-Received: by 2002:a2e:944:: with SMTP id 65-v6mr1085436ljj.30.1532078858214;
        Fri, 20 Jul 2018 02:27:38 -0700 (PDT)
Received: from debian-tom.lan ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id q19-v6sm264854lje.29.2018.07.20.02.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 02:27:37 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     jiangyiwen@huawei.com, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] [V9fs-developer] [PATCH] /net/9p/trans_fd.c: fix race-condition by flushing workqueue before the kfree()
Date:   Fri, 20 Jul 2018 11:27:30 +0200
Message-Id: <20180720092730.27104-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds the flush in p9_mux_poll_stop() as it the function used by
p9_conn_destroy(), in turn called by p9_fd_close() to stop the async
polling associated with the data regarding the connection.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+39749ed7d9ef6dfb23f6@syzkaller.appspotmail.com
---
As shown by Syzbot, it is possible to provoke a race between p9_fd_close() 
and p9_poll_workfn() that is called to take care of the async read/write work
to do. To make sure p9_fd_close() frees "trans" when it is not used anymore, 
it has to explicitly flush p9_poll_work before the kfree().

 net/9p/trans_fd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index bf459ee0feab..a64b01c56e30 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -185,6 +185,8 @@ static void p9_mux_poll_stop(struct p9_conn *m)
 	spin_lock_irqsave(&p9_poll_lock, flags);
 	list_del_init(&m->poll_pending_link);
 	spin_unlock_irqrestore(&p9_poll_lock, flags);
+
+	flush_work(&p9_poll_work);
 }
 
 /**
-- 
2.11.0

