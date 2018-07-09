Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35977C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CB3208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+TOk0yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CB3208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933609AbeGIWnc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:43:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35229 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933166AbeGIWn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:43:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id v3-v6so18712485wmh.0;
        Mon, 09 Jul 2018 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZLf0WhIai3jR7LvewS2sDfi0QvlUsjMwaqVya5bupjA=;
        b=S+TOk0yyJVSelmSXtkY1uEyLdvkygtz2leArNxBYb8H0vewtQQZ0aFStqDv08seaxx
         fV+0GPELKminioVz7Z5tYSFb21MDLnucJ0mLbg/RjnQj+yXG9w7+dVMQMuJby+wLoCP+
         WNqtd9RO38J7bILN6o9m6haq4S7Yo9NK6MUt2dIkJAjgyc+g3BcElC4FRWdf1LsyzGVS
         1C2WxtcNHxY0ERXd5zoRrNxhflOoI2OriOe207M6qXuQdf2yjOOzdxdufmGOGMSLS4EJ
         FvRfp25arwUfVMF+FMS74jAQVTObWlH0XXxxGycCXnoTH2l5OKoUqx9VkNkuN6LVWXD5
         DTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZLf0WhIai3jR7LvewS2sDfi0QvlUsjMwaqVya5bupjA=;
        b=Nj6vzl73Ci8UjzuTcjaRydm1yXDsttNNfyDuk97CmjtWHSwOD+8Cvid7a7T6SFtsjZ
         r7sJU/DyFx3LQ/lgguHinVVFzZLPzmhYDrib0NCn/W21JRhN3IfUEH7RJoWOs8ztmGkI
         46UKlwTgHkCpsqBDAIt/9xeeFa9Ll+3bYH99vcLkaiUTvSbMG6bY8hs1olizJxG0FzoT
         y3GmGPz20Dz7YAMih3kg2Pj0zcz4Vd2gEV+Wn5pcjYlQPt8hwIrzhADezAYsSqs/VJ7W
         m8Db+BBdocMJb5HnHkAnKgjLGoGYUTMAR4WLb36vPd6KQBxGECeVjziNurKCHWRchfZM
         F6ww==
X-Gm-Message-State: APt69E0iGanOJdzgfCsvlq4QLzGni6OIz4j73B64x6MfWD7bxVTDxjVe
        /MvxXjJ+ePQbFoB1cirGo4U=
X-Google-Smtp-Source: AAOMgpf966P86xkzpodjFQhlzsN6o+iVyNwYW878dxWqIExxtuqeQmmPGWAhxjldNbB9oR0CS2GNQg==
X-Received: by 2002:a1c:b801:: with SMTP id i1-v6mr12727238wmf.30.1531176208116;
        Mon, 09 Jul 2018 15:43:28 -0700 (PDT)
Received: from localhost.localdomain ([185.175.214.210])
        by smtp.gmail.com with ESMTPSA id o21-v6sm17480482wmg.28.2018.07.09.15.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 15:43:26 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [V9fs-developer] [PATCH] p9_check_errors() validate PDU length
Date:   Tue, 10 Jul 2018 00:43:23 +0200
Message-Id: <20180709224323.20597-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p9_check_errors() does not validate the size of the PDU read
in p9_parse_header(). Any size can be passed, provoking out-of-bound reads.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com
---
As suggested by Dominique:
https://lkml.org/lkml/2018/7/9/688
Such check is not enough as it will prevent to read more than how it has
been allocated but it won't prevent to read more than how it has been read
So this patch will require some more changes to prevent bad sizes.

 net/9p/client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 40f7c47f2f74..5b161b576b8a 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -520,10 +520,13 @@ EXPORT_SYMBOL(p9_parse_header);
 static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 {
 	int8_t type;
+	int32_t size;
 	int err;
 	int ecode;
 
-	err = p9_parse_header(req->rc, NULL, &type, NULL, 0);
+	err = p9_parse_header(req->rc, &size, &type, NULL, 0);
+	if (size > req->rc->capacity)
+		return -EINVAL;
 	/*
 	 * dump the response from server
 	 * This should be after check errors which poplulate pdu_fcall.
-- 
2.11.0

