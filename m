Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202C1C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60F320828
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyTdicCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60F320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeJ1Ffl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 01:35:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46087 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeJ1Ffl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 01:35:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id x3-v6so4236409lji.13;
        Sat, 27 Oct 2018 13:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NouTOrVxM+TYM0FPOjxglnjMsZBSdocm3PI+f9WRak0=;
        b=UyTdicCiSNt98rqfVKE3tjd5BYfHPs6nOBiFi6pK5a9HqqtFab9dlTs9Q2l9M+x+X8
         K82XPS92DrvuPNTyU3c4n/M0jzkxTCJlsOVWCcElGjI4QrDSVX9jjVRCQ9VNm/W/Mspb
         NiY44FjxC3IPIykolQVref5A9QkEYFbvm7hXP/bMpQyjPSkMKmoeabn+KH2e6dkSFO7j
         4FNY2Hg5y+dZu7afRANTqCNBxqjcHE6wFKK2jfBhqgRg0QM3BB5Pei0PHpM4hI1gEKq9
         aKQZVvlYqRjYvqVsN07EwsDwmRDFqmadb4yF2C8w5fX6zflfNbl8vBk/sUBv3HwZEzlu
         K2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NouTOrVxM+TYM0FPOjxglnjMsZBSdocm3PI+f9WRak0=;
        b=fAFLNJpZ0kTVjYGsWP2sUyn3hfme+C3bLGJSvZUiJXHBR9HMyxjgwWRw8c1wb3wTU6
         9UwuJBAODR/Eed/VDrkUgWAMojsNXzmF83Pv+QbWpMWZFDvnTfgevL/Nmx0JEzqGOzvq
         2YgCGnQUQz3bg7L7Ic24zTAA3WRkuGz2DgF/f7zu0wSOuZiQhbkylaoYoLcXsVFEaZwW
         FjO9fjY3cwXdn352sh3cf7PQnuSCktcIItLH0F0EtGNkE6T6d4c+FNgvLqhjRfPtQN/T
         B6bKs6W0gSHHxhxHrcXG9amgTM09mmtUR5xy7BRSa+ig0ERMzk2z5Vwd5Uz9GNnC4+Ds
         gh3w==
X-Gm-Message-State: AGRZ1gKEd8AK1ZLnx28ox0yKgGsBNjGzRpo70x6wI/RxYPdxoewAhmDF
        AHM/T5UFtXRPd1SBBiG2glQ=
X-Google-Smtp-Source: AJdET5fEw319xdBp1z0511rC8mcrlhdrO+drSJhFlUsG49FE95gVNxzbTyukAB19rM0EESFMpDWQqQ==
X-Received: by 2002:a2e:9b46:: with SMTP id o6-v6mr6084715ljj.78.1540673605485;
        Sat, 27 Oct 2018 13:53:25 -0700 (PDT)
Received: from localhost.localdomain ([95.174.65.6])
        by smtp.gmail.com with ESMTPSA id g3-v6sm2080077lfj.3.2018.10.27.13.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 13:53:25 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com
Cc:     davem@davemloft.net, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH v2] sctp: socket.c validate sprstat_policy
Date:   Sat, 27 Oct 2018 22:53:20 +0200
Message-Id: <20181027205320.14975-1-tomasbortoli@gmail.com>
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
 net/sctp/socket.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index fc0386e8ff23..14dce5d95817 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7083,7 +7083,9 @@ static int sctp_getsockopt_pr_assocstatus(struct sock *sk, int len,
 	}
 
 	policy = params.sprstat_policy;
-	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)))
+	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)) ||
+	    __SCTP_PR_INDEX(policy) > SCTP_PR_INDEX(MAX) ||
+	    __SCTP_PR_INDEX(policy) < 0)
 		goto out;
 
 	asoc = sctp_id2assoc(sk, params.sprstat_assoc_id);
@@ -7142,7 +7144,9 @@ static int sctp_getsockopt_pr_streamstatus(struct sock *sk, int len,
 	}
 
 	policy = params.sprstat_policy;
-	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)))
+	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)) ||
+	    __SCTP_PR_INDEX(policy) > SCTP_PR_INDEX(MAX) ||
+	    __SCTP_PR_INDEX(policy) < 0)
 		goto out;
 
 	asoc = sctp_id2assoc(sk, params.sprstat_assoc_id);
-- 
2.11.0

