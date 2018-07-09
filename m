Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4AAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209F1208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJwJLPPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209F1208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbeGIWaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:30:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40276 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeGIWaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:30:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so22289583wma.5;
        Mon, 09 Jul 2018 15:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V1tIzA5s9ZBQjG86PfvAc0FOgEnotiBT+EEwpCJjPAo=;
        b=NJwJLPPLxl1z4uBJhO7TA/MYd/KkQSBuCN2aACrtdnTVhQoLiZTsbnqsd835uAAomW
         //lYyLCey6D6VPM7hpjStNTdWLvuaPEclzmHoYAyaRC8fUrOZKs0ZRNsrT7tL4Oj3uGJ
         GfUqVtTx0Zdnh7860EZHJML1XYYCr0VDX3ACjGrxC8jMZCAbWOfbaWmbl+zypUyZWhwX
         cvVy8Caq/dukvs0T2Vfy4UB1EvK3RM9bhso9qEx7wElmowdTegaP2oxdpGgyNramSxSe
         qIgotkPWggXkYj/q5pWbM+ktl0HjUPW+ysSIZQ0VqVDAeg+sTikQGviGqKqmZQda4Lc8
         zCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V1tIzA5s9ZBQjG86PfvAc0FOgEnotiBT+EEwpCJjPAo=;
        b=uAHsn7axlDBCZILmhx6nbXX+z4woMyMsgUK+Sjxz63fVLTy0l0W7DAu5Rk7u1uiwjS
         Y76p4fvvw6hMgFQiO3fAWbyKAIcaycsz4LOP/BXtODaysKlPMgzGPaR/68kl1isNFWh4
         MokDi0uIWBOgy+0436bjD1dkbEIBQRpsfYwAlYWFECGyZb0iQG3Bamt2rNdpwTKb0Mza
         UBT4T7ocGky5BXEErz83NQ9EqSqnTwbVV1fe5kUvxtX/5bb3p+fseJvVA/h7eu7cXkrQ
         K+B7Y2EP57gpjCiCodPLWU0taJ5IJFlzjmzCsytJ9Mh53Gbl7cQC8cYlvh1eEoWtzhE0
         iNjA==
X-Gm-Message-State: APt69E1ogrLmsOYtuznHwVLW5v0PgkCbutmpIkKVVzOVag07MHdQJGd0
        X4CL6oGJAZxZT5f9LB8IsBA=
X-Google-Smtp-Source: AAOMgpcy3tf4Kw+tTe1aZd/B8H9QWOsVvv8DCvs5z3HLS/6l3KspxvAtReCB/IsRuPwntC9KK5o5SQ==
X-Received: by 2002:a1c:ec86:: with SMTP id h6-v6mr9587749wmi.53.1531175400723;
        Mon, 09 Jul 2018 15:30:00 -0700 (PDT)
Received: from localhost.localdomain ([185.175.214.210])
        by smtp.gmail.com with ESMTPSA id s16-v6sm13197865wrq.20.2018.07.09.15.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 15:29:59 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [V9fs-developer] [PATCH] version pointer uninitialized
Date:   Tue, 10 Jul 2018 00:29:43 +0200
Message-Id: <20180709222943.19503-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The p9_client_version() does not initialize the version
pointer. If the call to p9pdu_readf() returns an error and version has not
been allocated in p9pdu_readf(), then the program will jump to the "error"
label and will try to free the version pointer. If version is not
initialized, free() will be called with uninitialized, garbage data and
will provoke a crash.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com
---
 net/9p/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 18c5271910dc..40f7c47f2f74 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -957,7 +957,7 @@ static int p9_client_version(struct p9_client *c)
 {
 	int err = 0;
 	struct p9_req_t *req;
-	char *version;
+	char *version = NULL;
 	int msize;
 
 	p9_debug(P9_DEBUG_9P, ">>> TVERSION msize %d protocol %d\n",
-- 
2.11.0

