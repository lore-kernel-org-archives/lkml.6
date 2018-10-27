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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE37C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6A42085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2KJ2hIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6A42085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeJ1FDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 01:03:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41387 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeJ1FDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 01:03:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id c16so3310754lfj.8;
        Sat, 27 Oct 2018 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EWMUqs6CaHzLIxKw/s30cfrMD8CaJcuQBftfn1gEFGk=;
        b=p2KJ2hIoEpPZL/XynATC31xOqWgwqYGiVrAig40gdWiKnqkrKKG7ylqYY8Au/GwG3v
         WuKwh2l5iJx0zQ+wUdCyQd4auLeH5OknI/VICF2kOdQ/ATX8XcS22PPf/z0KFa4BMt0b
         nq/1XmWp1fBahJelOLero2mIWzvVqYtfhJVkLNoReBaMs3qSTtm4loSR7ClMGfspXfBf
         q1Nc3xsQNyd7Yi759ZuAS6z3tIVZWdqpBzO0tPngKLXxv919SZoNOpGgZ2wliY/6zqPJ
         y69CxYqfEY9gu+ZLWU6OAD//RXKAA68ihlkn1REhkDTE/4Ga+cYl6a4y+ATrrPr3c/lZ
         uKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EWMUqs6CaHzLIxKw/s30cfrMD8CaJcuQBftfn1gEFGk=;
        b=M/YmiBDtH1BAvjtvLzIQp9GckR5PPPP+PtlezXTPUuseVv2BJDBg6bm7FejjWvckO/
         ZC0DFqi8ZHqS9hO1VfpPF2fw60eb6UdV/FGj/lON1qJO+uRsp6N+E5FmCHoai8k+HCq+
         cTAZGI5BmhUsCzGCK6qrx1+wG2XV87pHMvhE7KjZ+ySElbNV+9zc7rC3s7wNr8k1T6Vw
         4KVqCANjQh/F1fepBYHiIgNkKdtOh5FXOARtZ/EOiiOKMMYMhPITuThI41BJovcbZQ4P
         gXGy4P1ClzkmJTBOb6Gm1tLOs5BY1FaocH5lFLAtZHaEZYZMlt06KaX4Cx8nKwqbSZJK
         SeNw==
X-Gm-Message-State: AGRZ1gIA4sdDU3e8lWkJ4QlxgBD4l/fexMMXxEzmNPhFHmnzouhSLBtY
        h/wZQ6ZmFBspwHvL2NPj8Oo=
X-Google-Smtp-Source: AJdET5ePccC2+hit3PP7SpUjiYPtVOLt/BJK/a+yb64PNe1U2MbhScHJoRtQKEqp3nLNhN4OS69i4A==
X-Received: by 2002:a19:cb94:: with SMTP id b142mr5141435lfg.117.1540671655451;
        Sat, 27 Oct 2018 13:20:55 -0700 (PDT)
Received: from localhost.localdomain ([95.174.65.6])
        by smtp.gmail.com with ESMTPSA id d13-v6sm2216147ljc.25.2018.10.27.13.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 13:20:54 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com
Cc:     davem@davemloft.net, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] sctp: socket.c validate sprstat_policy
Date:   Sat, 27 Oct 2018 22:20:26 +0200
Message-Id: <20181027202026.32157-1-tomasbortoli@gmail.com>
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
v2 - added forgot ||

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
+	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)) ||
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

