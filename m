Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFE4C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D1E2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4K5W7Wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D1E2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeJYAQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:16:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44376 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJYAQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:16:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so2499133pgs.11;
        Wed, 24 Oct 2018 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EIbMW1tFpD4VD8eWMfVuJYXOyQCJ/LMV7zXxdtpIduA=;
        b=Z4K5W7WkpKrIIAvoQud/ROubmBRgGoXErGhya7h4AuUts+BkQN25cgJlWIB/9i8KVe
         4d2nBEJ3yYKMuhwu8tZuktdeDd18WCxr3NQCL735jHcyIo60pWucxuzGscUpqjjsxK2m
         hjGsi8prqLI0lNPAfPOLEqVGbriFJQg0rAFMiWOEmHj0myJUNzruaVfyBK0Rxp687Ica
         R49UzRCjkwzYfc/UOH3C27k1v+hXd95yfjOMvdUYK1HkKeSjNDu1r8s6N5271LyFgYh1
         lraiXATKh6UL7QNOqwjNt04rH6GKf6rBaB2ewngH18qfbRNUZ0ybWcdiXlee+y8Moay0
         UzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EIbMW1tFpD4VD8eWMfVuJYXOyQCJ/LMV7zXxdtpIduA=;
        b=qNGx+V+U/u21CsDxolVth2QU5ympMiNxOF0wKwyFByLxTY9JSV50tCDxyKLglgkyG9
         3Uicjjkl2IjLtTZ9Dfrq+eB/PYbXIyuCdhRCaZ25hz4Ys6D7HhcL73QEV8q3/zEnSpNh
         C+9P6sKo5M6vaWpe9ezMp6+gd76kpUPlx289/nNCE/2qbvVxtjNsyQ+OGz/npOESDyge
         i75S9RoCFgFdy09/RRWxsV+fmSqHMjqLCp9mMANX6dYOr8/NIvlN6w944IxOZvxEYBVh
         lVohKKnExXCi0tjkbXIrP9Aa1hrX7NEYt0trSePOJ+PtCKycj9Qs/jrBO1QIgyPsGumu
         RtDw==
X-Gm-Message-State: AGRZ1gLxhTwfRznJ+mCdIH2rL/YZVVrCTEl943DPsj0WLFsDVXY+yadc
        G4pGgozhGYnAXU/rDSQTrkA=
X-Google-Smtp-Source: AJdET5fn66edZVWpE43x2jnUvLlBHXPymNig8JxbwCIVRDfLj/QN2Ca4pRksQOx3rU0L87OKiyDVpg==
X-Received: by 2002:a62:c2c1:: with SMTP id w62-v6mr3134702pfk.35.1540396067002;
        Wed, 24 Oct 2018 08:47:47 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:a22:7570:6c13:fc48:9aa7:acaa])
        by smtp.gmail.com with ESMTPSA id 67-v6sm4756340pfk.134.2018.10.24.08.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 08:47:46 -0700 (PDT)
From:   Wang Hai <wanghaifine@gmail.com>
To:     edumazet@google.com
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wang Hai <wanghaifine@gmail.com>
Subject: [PATCH] Change judgment len position
Date:   Wed, 24 Oct 2018 23:47:29 +0800
Message-Id: <20181024154729.5312-1-wanghaifine@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To determine whether len is less than zero, it should be put before 
the function min_t, because the return value of min_t is not likely 
to be less than zero.

Signed-off-by: Wang Hai <wanghaifine@gmail.com>
---
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 10c624639..49af9fdc3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3301,11 +3301,11 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 	struct net *net = sock_net(sk);
 	int val, len;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
-- 
2.17.1

