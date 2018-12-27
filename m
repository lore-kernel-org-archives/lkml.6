Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F8AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961E0214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVFqSnlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbeL0TIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 14:08:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45353 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbeL0TIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 14:08:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so9467820pfd.12;
        Thu, 27 Dec 2018 11:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wMtxKrlb5S1b05ezaTrpeU8MfFOhOA1dgmWDjaTi/nI=;
        b=fVFqSnltiUJWepUCnVR8ikfY7a2hruf1LVSk6b548JWRgrN3LjFdxkPrkITkWBAgMt
         Rs2ZH1KlxSBtFP3/aqN4mVC85e2O+1Mu2chJGk9fR77yKI/jKcUDp8301BDd3ggvjc2g
         /tPHPIebZbDdR02b1oaf58OCVUeB49VpTsZdabKv+apjBGbTvtaNzfjUaLH2mZ4q1PO8
         1F5JcWXvomE7xdV2isjdmvy8Rj5wn7JTv/+RMFIoz/gtuzzXTT7OJSLUtisCOzyfTnzq
         APRxiteRbHbPDCZGCvgOMYnzLgNZ3itEQgGTfuMVtVEbLPrUi3vL2QDGseE03/t5TKWV
         gzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wMtxKrlb5S1b05ezaTrpeU8MfFOhOA1dgmWDjaTi/nI=;
        b=pbVPCuw/wnyjXuw9tgnPgjzxgXNRItHGVoty1IJmKtqMaBsTl5jkPuyhBoqSm5ZcoE
         Q3RhOZMOpJ68v7BfO4IMFqFDpEneibgo0c45FtScGEmDMFm1b46+V4FTgWIqePPzNipF
         Og1+Ivzl74w36UcML54NgG9YrtLC9y74KI0Me/ZE/xQuw6eoMepwnZhDyhUk6CwTtqdm
         nN3Yjy8Huji0L/LiWyvXSWlYFoHUGB8ul6MpiZFDLggjWh8Q0Oo0sPwle/mmKcUKvxza
         qaG22CiukZrBImrB+yLdW7O4ugl2D4pfj2vGyhYZuHA4Z/QYagbc2mbYyc7ewY7Ao1y2
         BMSw==
X-Gm-Message-State: AA+aEWa4vepPOUqwqHraopLoYb22HB6rRvpGF6sx4Oh6meKEmtLyzkAm
        eKaUkR2fmNcM88JrWXhzXT4=
X-Google-Smtp-Source: AFSGD/WzGP+2+sV+IqZCe7YMv1YIhJrByPi+lh9bR5U6XYNnbgrwy9ZA47vEvHHFj4vfgY/uMTxXGg==
X-Received: by 2002:a62:1b50:: with SMTP id b77mr25426045pfb.36.1545937729622;
        Thu, 27 Dec 2018 11:08:49 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id d69sm51982409pfg.168.2018.12.27.11.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 11:08:48 -0800 (PST)
Date:   Thu, 27 Dec 2018 11:08:45 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] libceph: protect pending flags in ceph_con_keepalive()
Message-ID: <20181227190842.GA19565@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

con_flag_test_and_set() sets CON_FLAG_KEEPALIVE_PENDING and
CON_FLAG_WRITE_PENDING flags without protection in ceph_con_keepalive().
It triggers WARN_ON() in clear_standby() if the flags are set after
con_fault() changes connection state to CON_STATE_STANDBY. Move
con_flag_test_and_set() to be called before releasing the lock and store
the condition to check after the critical section.

Reported-by: syzbot+acdeb633f6211ccdf886@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 net/ceph/messenger.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 2f126eff275d..e15da22d4f37 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3216,12 +3216,16 @@ void ceph_msg_revoke_incoming(struct ceph_msg *msg)
  */
 void ceph_con_keepalive(struct ceph_connection *con)
 {
+	bool pending;
+
 	dout("con_keepalive %p\n", con);
 	mutex_lock(&con->mutex);
 	clear_standby(con);
+	pending = (con_flag_test_and_set(con,
+					 CON_FLAG_KEEPALIVE_PENDING) == 0 &&
+		   con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0);
 	mutex_unlock(&con->mutex);
-	if (con_flag_test_and_set(con, CON_FLAG_KEEPALIVE_PENDING) == 0 &&
-	    con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
+	if (pending)
 		queue_con(con);
 }
 EXPORT_SYMBOL(ceph_con_keepalive);
-- 
2.17.1

