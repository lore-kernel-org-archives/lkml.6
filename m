Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2BDC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E94214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWWjryxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E94214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJITWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:22:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36027 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJITWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:22:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id f18-v6so720109pgv.3;
        Tue, 09 Oct 2018 05:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j728AhKyvqO+SkkudrX1Dpm06WwxmvVoUZ/LAx1+0YE=;
        b=lWWjryxgOPOPzlcjqTF2RwZzMMngrQDr8sfpxf3azWuxF5FPTap01LtmqHEEpa2l0Z
         9vzMjstfyWE4G1DgrgaBCgGLjfPqjjnjmcJMbiv+kfjZoVgO4gPfg2JmpF+zlMymeuVc
         7FP0fsCN4gxQN7tT0bYlFRzpwaHQCDObu831DxJiGuBOTCVOPHC8r6W1gp0EmVlQksX/
         NH06UtDk9SSV8luGZwVWtCul1rAshQJ1ujiQ7x8gYifYr9x/zvdDEgmPt4+yNAPbqIIY
         6cR68E+Seh/LesLFnJT3xram2Hwn1De6x5+BjFaK5GUNcSC5Y+Q5GRihJoBSTM9Wu6Co
         sGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j728AhKyvqO+SkkudrX1Dpm06WwxmvVoUZ/LAx1+0YE=;
        b=c5PVptBG4Q/zkEsJrQqIftK00CZwu6z8u5DZcEZcKMiwu8irEOYYYFi9Uwh3jWUTWv
         pzKULI7ZLmuPLyE8lIX0oFlgD1IaF+QP8U2mZRQYnQ2Zcc31kPzb6S5+hcE/CmsuyKgb
         tLeeKzC3Kc7qXBTAD+7PuHJBuEKBAqDp1P/ZCjU2E8DKJvpat14zV+G2nKv+7GOoRwp3
         lFTHG/yNOynz4VMfRl9zo4NOV4fVRB1JV40YSmhoS7w55yJ8n99oiSh5PqWJpBDhihJD
         t/QzOGWbYBljQ7i+qK+gTUhbXgAxqnZRqhzRFh8j4SCRXbUXsItGgvNfWiUR9+eyYHK4
         wGUQ==
X-Gm-Message-State: ABuFfoid2XYdN1HA9giXQ99VeU4Y9VhQ6YjOGpl4Br4q4DabK5dJ56Hg
        ODrvn5m3kjWA9qbg0VQogTM=
X-Google-Smtp-Source: ACcGV62JZkhkjPsQtXRVkK0+UQv4UZZolCbnlQxJwoTADngkTNCgCUF38jy8gCoH6z8L0jEh8FLLPw==
X-Received: by 2002:a63:ef0b:: with SMTP id u11-v6mr25339879pgh.283.1539086751203;
        Tue, 09 Oct 2018 05:05:51 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id m11-v6sm23517239pgn.39.2018.10.09.05.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 05:05:50 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] tcp: forbid direct reclaim if MSG_DONTWAIT is set in send path
Date:   Tue,  9 Oct 2018 20:05:18 +0800
Message-Id: <1539086718-4119-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1539086718-4119-1-git-send-email-laoar.shao@gmail.com>
References: <1539086718-4119-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the sk->sk_allocation is GFP_KERNEL, that means if there's
no enough memory it will do both direct reclaim and background reclaim.
If the size of system memory is great, the direct reclaim may cause great
latency spike.

When we set MSG_DONTWAIT in send syscalls, we really don't want it to be
blocked, so we'd better clear __GFP_DIRECT_RECLAIM when allocate skb in the
send path. Then, it will return immediately if there's no enough memory to
be allocated, and then the appliation has a chance to do some other stuffs
instead of being blocked here.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 43ef83b..fe4f5ce 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1182,6 +1182,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	bool process_backlog = false;
 	bool zc = false;
 	long timeo;
+	gfp_t gfp;
 
 	flags = msg->msg_flags;
 
@@ -1255,6 +1256,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	/* Ok commence sending. */
 	copied = 0;
 
+	gfp = flags & MSG_DONTWAIT ? sk->sk_allocation & ~__GFP_DIRECT_RECLAIM :
+	      sk->sk_allocation;
+
 restart:
 	mss_now = tcp_send_mss(sk, &size_goal, flags);
 
@@ -1283,8 +1287,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			}
 			first_skb = tcp_rtx_and_write_queues_empty(sk);
 			linear = select_size(first_skb, zc);
-			skb = sk_stream_alloc_skb(sk, linear, sk->sk_allocation,
-						  first_skb);
+			skb = sk_stream_alloc_skb(sk, linear, gfp, first_skb);
 			if (!skb)
 				goto wait_for_memory;
 
-- 
1.8.3.1

