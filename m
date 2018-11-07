Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCA4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F1A2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAklOp16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F1A2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbeKGUuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:50:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38558 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeKGUuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:50:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so7586033pfi.5;
        Wed, 07 Nov 2018 03:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s+/LY0Utln20yvP4ObufTh8Pnkckv99Fm/1BIKpKhyk=;
        b=iAklOp16v730+zBUPgMggKYxExGCnsDq1gUJZGHq0EK4iGA1Je1+rfrXk5a8NrmTX+
         hA84qoxM1QL7m+JMuwe3frdRortXTT+6aRIDaF+yfvEDqxQNW7nKZsNHkmjAd4vszN1F
         Z3yXaFPNUll9TTqOb+cXDgjO9WMhT7MsAVoQQJyxlswj4iTscEzbdH1IaajnyHqnwFyZ
         Oe/DNPkP0q1afmT6m2UWvERM39p+s+VYHILne6EZ1z+KjWvtJeMP/1iF+hsc+o2oUqP6
         QkaKTrJjLj2F6jWfyDzTbQXVkADJFD3hQxbrOGqcJL2y1ytF2m57Y55kbG/w0ZhF7nmL
         VAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s+/LY0Utln20yvP4ObufTh8Pnkckv99Fm/1BIKpKhyk=;
        b=JGE1bx3bxE4R+QTDXmDVqhql4+sr4i7x84x30Wzf+U9aoOX9xlWBEt/LGjf7wpWpvK
         GVoRYnxHabHvzjdlyXF/DWR8WlNHio2fFtEDCBNf2xXsgI5DkhLRNnSD8hQdPqllelK2
         nbisrbZqx5BoSWBHw/BSVhF28zJosqEW8YXfO4ReAEOmrLAjNvz87B3uKIXqUgqKFhg2
         +P8fd4WHgoDhLUoBszle3BtzWc0Ncj0xRML55v71Yr9ab6lv3RTt6fX0xlfukc+TW+vR
         43rhmoBhTW7/mb2ylfrP57qJ8l8Zg8YH+MXVOZ7y+Q9D0KAiu/BbdVekhcN1x5amKhwA
         V9rg==
X-Gm-Message-State: AGRZ1gLq3OcHeauQox6UvkwIxXgSFFaglSdimctW7AHLfZKTz2sPpMl3
        tgDIhoY4LcXgISJM8BRTyEcKGFgh
X-Google-Smtp-Source: AJdET5duFCI+pYAzW5ekd4IC05eQ/Z1z61MQ0z0q7DJboxhma9H4pbc3k+m0eyrEbaegx8EmtJk4DA==
X-Received: by 2002:a62:5bc7:: with SMTP id p190-v6mr4000pfb.175.1541589653937;
        Wed, 07 Nov 2018 03:20:53 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id m129-v6sm452622pfm.78.2018.11.07.03.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 03:20:53 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     davem@davemloft.net, edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH net-next] tcp: minor optimization in tcp ack fast path processing
Date:   Wed,  7 Nov 2018 19:20:17 +0800
Message-Id: <1541589617-1607-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541589617-1607-1-git-send-email-laoar.shao@gmail.com>
References: <1541589617-1607-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bitwise operation is a little faster.
So I replace after() with (flag & FLAG_SND_UNA_ADVANCED) as this flag is
already set before.

Cc: Joe Perches <joe@perches.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2868ef2..0167015 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3610,7 +3610,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if (flag & FLAG_UPDATE_TS_RECENT)
 		tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
 
-	if (!(flag & FLAG_SLOWPATH) && after(ack, prior_snd_una)) {
+	if (!(flag & FLAG_SLOWPATH) && (flag & FLAG_SND_UNA_ADVANCED)) {
 		/* Window is constant, pure forward advance.
 		 * No more checks are required.
 		 * Note, we use the fact that SND.UNA>=SND.WL2.
-- 
1.8.3.1

