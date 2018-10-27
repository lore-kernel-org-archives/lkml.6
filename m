Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92845C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 19:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B38E2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 19:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu/5VmWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B38E2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJ1ElI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 00:41:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47091 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbeJ1ElI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 00:41:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id x3-v6so4174018lji.13;
        Sat, 27 Oct 2018 12:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Xj2s6ge2CpWnsk1bP+uWJhJ/coQfpXyxy1jcA8VZdWY=;
        b=Tu/5VmWJp9+pz5qwbDG9fV/4uftjUQmw0nhClyq1Scr0NFGut0509R22qBAXVZCeCR
         S1M33rMBefe2gQx3jyscDNN9StxmF1qS9Y0ehSNz208RX8u1M8rpUTdExGNHj2O3VXSB
         6+nGpewSBbrzhgLLt5UOuZlddU1UVyBLs26yfhtnkdnTjThijTiLe+vECHZIX8XiAZDL
         CFcr3nfMVn8SwuIfWP1LSfHo9C3seZSqcmKRuofUARxqfXcb90Qs7Sy1ANyQ2AOgSyLo
         s+d7DNKiq5eEMvnazMFCBwK5GwQ+0b95eRrQgmpz2xxEq47Gvuww/9WHNIIshZjfmgbd
         oStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xj2s6ge2CpWnsk1bP+uWJhJ/coQfpXyxy1jcA8VZdWY=;
        b=UdiByUsYMeGvucAwKnX5lkE6MD/idpapN0BxswwspR9E2yfD4BegOEyacXafGXgmcK
         gk5oR7HpIPhEMxhnQT7QtfeH0z59zRcCXcfwNExeel6CwsysVVwIb3LqlLmwh1dn4dYY
         f2N9Px/m+wzsSyIS4phpsxT53F5oOY/Jsb2ervTpO12KLhtdHMGdUNr45TRDNjEpdbSV
         D+r0dgJr1rY/ER5/hsHuR9qc0bRZvVhQ0T7DNPLr30mSts+BqNEHyvH3GA3zhWqFXlwl
         QP1yPGMNr5wsWlYdfRI0WPV2JbN/7ADlcO8PZMuD63CFL5ZlUUCS+KkhRN2HvCo3Yve4
         n/4A==
X-Gm-Message-State: AGRZ1gJ1K+2XEtfc5SvvtaRQSxAqYXoXmx8G1kPHao63gD5+OL316NGU
        OIRX/e4s+b22VN22tG3UBgY=
X-Google-Smtp-Source: AJdET5dJTUjRGzLAZUuIikjPsWdFgQjxCUpWVuhUIgTjsxkqvjgFoWj2sZRbVOn1LB67fBvc/D8neg==
X-Received: by 2002:a2e:5dd9:: with SMTP id v86-v6mr415669lje.86.1540670342235;
        Sat, 27 Oct 2018 12:59:02 -0700 (PDT)
Received: from localhost.localdomain ([95.174.65.6])
        by smtp.gmail.com with ESMTPSA id o14-v6sm1975333lfe.16.2018.10.27.12.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 12:59:01 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com
Cc:     davem@davemloft.net, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] sctp: socket.c validate sprstat_policy
Date:   Sat, 27 Oct 2018 21:58:53 +0200
Message-Id: <20181027195853.30243-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to perform out-of-bound reads on
sctp_getsockopt_pr_streamstatus() and on
sctp_getsockopt_pr_assocstatus() by passing from userspace a
sprstat_policy that overflows the abandoned_sent/abandoned_unsent
fixed length arrays. The over-read data are directly copied/leaked
to userspace.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+5da0d0a72a9e7d791748@syzkaller.appspotmail.com
---
 net/sctp/socket.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index fc0386e8ff23..5290b8bd40c8 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7083,7 +7083,8 @@ static int sctp_getsockopt_pr_assocstatus(struct sock *sk, int len,
 	}
 
 	policy = params.sprstat_policy;
-	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)))
+	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL))
+	    __SCTP_PR_INDEX(policy) > SCTP_PR_INDEX(MAX))
 		goto out;
 
 	asoc = sctp_id2assoc(sk, params.sprstat_assoc_id);
@@ -7142,7 +7143,8 @@ static int sctp_getsockopt_pr_streamstatus(struct sock *sk, int len,
 	}
 
 	policy = params.sprstat_policy;
-	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)))
+	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)) ||
+	    __SCTP_PR_INDEX(policy) > SCTP_PR_INDEX(MAX))
 		goto out;
 
 	asoc = sctp_id2assoc(sk, params.sprstat_assoc_id);
-- 
2.11.0

