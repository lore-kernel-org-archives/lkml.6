Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944FFC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DC62084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaMutjyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DC62084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeGSUvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:51:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42452 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeGSUvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:51:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so7541955ljc.9;
        Thu, 19 Jul 2018 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uxQ7ZVIbXjJzI3VK2/066QXTwvE33shPFfeCFLf9jAg=;
        b=PaMutjyiOyNjrFlxU+kx1EefLaYZt+/P+RHvufduslt6xpIosFZlLpOTnTnTVmDbsW
         veIitudfED1A27G6t6oPBvpaND/7oJAMbj2r9hjW/T6kTtX4Rc32kTy5kaQHfPkQG3SL
         szvcUvxUvEyGJYzRErqJC0pJY6RBFqXcSoewky6xu07Yl5ODftEky25JrAiEYokWmTQm
         147FRVCqToiD8xDpVD2GqPkO2Ovy98Twa9k11/sacgONu2Bhjm+2DNbE4i+1dU8NvTsy
         Ae67sGZNVCDB8pcj2E0bN0qB5f3LGAD5U6rGNPEMwlyHkhhTZyQNqGZ9dhnBsRmbikjy
         njKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uxQ7ZVIbXjJzI3VK2/066QXTwvE33shPFfeCFLf9jAg=;
        b=WLXbaa+Ku5pAHWWgR//dsLAcAbkIQqWqlrzauhrrwmRNL8iWxvBe0GdjjwwIXHmiTN
         yQIHK0GoAkQfX7bUq34AAPzyoqf/I10lPahs5uEkrfh4syCiro+n/Kl6R352zw5HfOLo
         JMMXqk4xfxOOcfQAToAAWthPWoIgW5Y5jz1dyu7AbZIdxIc2VKhjfa59v/uXMJuSljTi
         M+nppyw4mwI5+0ldqWdp4mNtSamPKYlzmFL80xbOsd67FeXR8w7c0MmQLWNSwH8yfo4I
         oSCDL9xuLjD6kmuMc2ASowuYkkBA2YJTPcyVSyIlC25XeFV5XB2rCDqlQ9QEsTQdzBGh
         zPlg==
X-Gm-Message-State: AOUpUlGdISIo0+yyjtkLruP0syv2wK6PhTCgkkuQYusgHa5w6rWDWhRR
        Sqcv5U4WVgEeboKzeY1HGXE=
X-Google-Smtp-Source: AAOMgpd5Z9aEFObvZ7s+ahXBQ8bWf4jMwyp7u5AUjseDuyku4bSm/ZDKgmGe4Y9wToJLzuNAoYAM8g==
X-Received: by 2002:a2e:9d0e:: with SMTP id t14-v6mr8649997lji.112.1532030823880;
        Thu, 19 Jul 2018 13:07:03 -0700 (PDT)
Received: from debian-tom.lan ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id o11-v6sm8397ljh.34.2018.07.19.13.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 13:07:02 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] /net/9p/trans_fd.c: fix race-condition by flushing workqueue before the kfree()
Date:   Thu, 19 Jul 2018 22:06:07 +0200
Message-Id: <20180719200607.30286-1-tomasbortoli@gmail.com>
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
it has to explicitly call flush_scheduled_work() before the kfree().

 net/9p/trans_fd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index bf459ee0feab..76ae134c05d9 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -185,6 +185,8 @@ static void p9_mux_poll_stop(struct p9_conn *m)
 	spin_lock_irqsave(&p9_poll_lock, flags);
 	list_del_init(&m->poll_pending_link);
 	spin_unlock_irqrestore(&p9_poll_lock, flags);
+
+	flush_scheduled_work();
 }
 
 /**
-- 
2.11.0

