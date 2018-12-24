Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFABBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976892176F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="m594MeOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeLXAzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 19:55:32 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:47018 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeLXAzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 19:55:32 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 6225DC26
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 00:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4oGs3RUwELZ4 for <linux-kernel@vger.kernel.org>;
        Sun, 23 Dec 2018 18:55:30 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 3BF32C1D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 18:55:30 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id w15so12538567ita.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 16:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8rE0A9BsmRipspGDaSpFgsJdz4hxNU545p0jPEDLIlo=;
        b=m594MeOhv0nR4OrrDzkm+ZNHHIIITozJmElqAN3W6m5DFbl8LxqwH7Rp3MgYJvDAny
         0P5Bpu4KOVWrf1HeHJowFtI8y+XkAJd68dzExkSzLb3PdfyucGH5H+Tp+i5fltwFTD+A
         oa1JwmcLIv3Qke2IPmq5SuDxU+GeYWCn7MrmzMJ+sobEZz/fSjDjPj/4H3DXDCcLCYz8
         J6jgSprketEgJfmdsN1gjdXvYG+t95dqqUgvmpypS22/dq/IvS4y67DCeG0xjxexGB79
         4IZMh+RTPRx1SIaRuT691m3JWa+lzS5VFeIU95PzE76gS0A8Wbe2X4yHlPTf7hyX49pU
         4CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8rE0A9BsmRipspGDaSpFgsJdz4hxNU545p0jPEDLIlo=;
        b=qzI6YffvkJ33eepoRGvCCGa5+JzzyWNa1CbcXqgulg4RVaZQ4Jt2h3Pwi0tQEmhrFi
         ncFqOYnSjLJBo/A0kfZ8fv15y1Qw0xBoAs+QsEmXfql501zMmSuDh6vAHDl2pW5P02Uf
         LPb5vzw95H14/6OYFxnnIkJurG1eXrUVRCBJj9OBx7mCP1oMT8/ECTlktJSW6AkHS1J/
         5jYJU0F5sUDIo0xqmAnLME35HciEcxEW/PhLLFqBs1Y9tlfE0fPzvNVVLhDVGDsHfUDn
         701GXODM9+dGET3Y57BCXhH40hd8P4rLSo7PeHqmXk/7+GaYFdwTJAw3chBWz0/gOsf0
         W03w==
X-Gm-Message-State: AJcUukcvm7goXnTcU72r1FqrA5HBVNhgjbkA16CfDY47ot10/OL9ks1I
        /ae/4FrlSXeNo8EVJhUX3qNVV7Z1G9LtINodZYpjeh/CU5xXSrn/J+SBM9xjIr5mHUBwnyiXAK+
        WNDz5yTVGK9NeA0LhNwL91O7eHdj5
X-Received: by 2002:a24:d441:: with SMTP id x62mr7500264itg.141.1545612929780;
        Sun, 23 Dec 2018 16:55:29 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XUBnZ47ije2EWYdFP5ymYsCkKHUtpM+vQ43bZOVjAKTz4LuRYwG/vuwzQ2zKcJnZMEhl2FVQ==
X-Received: by 2002:a24:d441:: with SMTP id x62mr7500254itg.141.1545612929562;
        Sun, 23 Dec 2018 16:55:29 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id m45sm9596157iti.10.2018.12.23.16.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 16:55:29 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] net/netlink_compat: Fix a missing check of nla_parse_nested
Date:   Sun, 23 Dec 2018 18:54:53 -0600
Message-Id: <20181224005453.9992-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tipc_nl_compat_sk_dump(), if nla_parse_nested() fails, it could return
an error. To be consistent with other invocations of the function call,
on error, the fix passes the return value upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/tipc/netlink_compat.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 6376467e78f8..21f6ccc89401 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -951,8 +951,11 @@ static int tipc_nl_compat_sk_dump(struct tipc_nl_compat_msg *msg,
 		u32 node;
 		struct nlattr *con[TIPC_NLA_CON_MAX + 1];
 
-		nla_parse_nested(con, TIPC_NLA_CON_MAX,
-				 sock[TIPC_NLA_SOCK_CON], NULL, NULL);
+		err = nla_parse_nested(con, TIPC_NLA_CON_MAX,
+				       sock[TIPC_NLA_SOCK_CON], NULL, NULL);
+
+		if (err)
+			return err;
 
 		node = nla_get_u32(con[TIPC_NLA_CON_NODE]);
 		tipc_tlv_sprintf(msg->rep, "  connected to <%u.%u.%u:%u>",
-- 
2.17.1

