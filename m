Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94C2ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 01:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E842208D4
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 01:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdCd++I4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E842208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbeGOCPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:15:22 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36253 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731955AbeGOCPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:15:21 -0400
Received: by mail-qt0-f193.google.com with SMTP id t5-v6so4390130qtn.3;
        Sat, 14 Jul 2018 18:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=71d8ELp5ZJhp6gtNsTfzu+p7cXsohtPfcYzdTN/UKe0=;
        b=FdCd++I4HOsCERg8VZkVZ8tx9SkrKXotrm9zd2mtKEg85sPqGOw3ETbC/GtAkGBSqB
         UvIT4Gx7eTQpA/N/yBIDqH3Lg/OUJsylxxK8tVmAEd6RS9OcQfcyvYMQFA/P66D6c9js
         rqJBip86Y7rvzhHiVWzai8e+o6PWGqy/1iQsVGAv2qSM595VWy33zLZIRlgxwZ6QSSuy
         j02nwxnfyQiUGTryldhprYDtAXJG1zQdbz2RXrZjjjCIvhjLM+T8nnyiP10NHQFeF37w
         qZQwz5q2q20EkcxWCErc2Ddx2zY9WDF914qbOkXAgi5PXsCXafYaNiQOMV6HhL9g0kp2
         zNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=71d8ELp5ZJhp6gtNsTfzu+p7cXsohtPfcYzdTN/UKe0=;
        b=SIh0fWooiOSzLzwHwwPin5kQxKkyFsvNGmdbz4TDg8EYFW9Bs9jJ+IDpMjdGYTU9uP
         Au9nMMfpAHHN4UgbhA9zU8HzyHT8tqN4j7gLhb3PYUoAIrBMjv5pbGGv6jXoZUZBEmGK
         6ywKGmM/nO3t8RtkNtDlK05U0d1SdBkgq5z+7UIZruLJMWxm0Zm0XFA4ucaSsmdqb5vr
         Z/bTTlIAvz9MsLkTTHP0U2Cll8prDG+M0EgstE6AWa4hbmkJ0jCZgUkm+Kun55VLPxWL
         s6nLKIfvfh5wpZfATAnbthzDamWdeOqR91IEJNqO4B7YSBm384dwGBtDptZpKHPWnfKy
         qLFg==
X-Gm-Message-State: AOUpUlGdwqvxqXv63ZA2JLXeUx8CLJw/4GStresPL4RNo4NuKtogFCcx
        fYeCZXvQC7enThqcryyPxe4=
X-Google-Smtp-Source: AAOMgpcA3GqpogmYt/T1/dLkhBdpa7k2lLc7WgFh/OtR0bThDIshUfvzfbc5vlblPM5DaxaRElnRoA==
X-Received: by 2002:ac8:2cb0:: with SMTP id 45-v6mr10814902qtw.29.1531619655685;
        Sat, 14 Jul 2018 18:54:15 -0700 (PDT)
Received: from localhost.localdomain.iceblazer.shadowybug.net (pool-173-67-16-152.bltmmd.fios.verizon.net. [173.67.16.152])
        by smtp.gmail.com with ESMTPSA id t3-v6sm2949667qto.26.2018.07.14.18.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 18:54:14 -0700 (PDT)
From:   Stefan Baranoff <sbaranoff@gmail.com>
Cc:     Andrey Vagin <avagin@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Stefan Baranoff <sbaranoff@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] tcp: Fix broken repair socket window probe patch
Date:   Sat, 14 Jul 2018 21:54:09 -0400
Message-Id: <1531619649-1518-1-git-send-email-sbaranoff@gmail.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct previous bad attempt at allowing sockets to come out of TCP
repair without sending window probes. To avoid changing size of
the repair variable in struct tcp_sock, this lets the decision for
sending probes or not to be made when coming out of repair by
introducing two ways to turn it off.

Fixes: 70b7ff130224 ("tcp: allow user to create repair socket without window probes")
Signed-off-by: Stefan Baranoff <sbaranoff@gmail.com>
---
 include/uapi/linux/tcp.h |  4 ++++
 net/ipv4/tcp.c           | 12 +++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 29eb659..e3f6ed8 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -127,6 +127,10 @@ enum {
 
 #define TCP_CM_INQ		TCP_INQ
 
+#define TCP_REPAIR_ON		1
+#define TCP_REPAIR_OFF		0
+#define TCP_REPAIR_OFF_NO_WP	-1	/* Turn off without window probes */
+
 struct tcp_repair_opt {
 	__u32	opt_code;
 	__u32	opt_val;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8e5e2ca..9163fb1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2824,15 +2824,17 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 		if (!tcp_can_repair_sock(sk))
 			err = -EPERM;
 		/* 1 for normal repair, 2 for no window probes */
-		else if (val == 1 || val == 2) {
-			tp->repair = val;
+		else if (val == TCP_REPAIR_ON) {
+			tp->repair = 1;
 			sk->sk_reuse = SK_FORCE_REUSE;
 			tp->repair_queue = TCP_NO_QUEUE;
-		} else if (val == 0) {
+		} else if (val == TCP_REPAIR_OFF) {
+			tp->repair = 0;
+			sk->sk_reuse = SK_NO_REUSE;
+			tcp_send_window_probe(sk);
+		} else if (val == TCP_REPAIR_OFF_NO_WP) {
 			tp->repair = 0;
 			sk->sk_reuse = SK_NO_REUSE;
-			if (tp->repair == 1)
-				tcp_send_window_probe(sk);
 		} else
 			err = -EINVAL;
 
-- 
1.8.3.1

