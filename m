Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B635AC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B41A2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="FpvWNRzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfBVQEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:04:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35178 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVQEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:04:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id j5so1316964pfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 08:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4C8EM7PAuUt6hpnlstAb/V1eFsLaP3MGjMb2gR8iaBQ=;
        b=FpvWNRzhKa5GnV8aiDCFJN+5lEchggfDt/QwMKRr1XVCUKWRHUdaCLF6lHbL3/nOKD
         RAAptJT3nwhTW/+n/BdoBeDIoh/P5NoCBQu4LMSHQkqWq8/PUvt/ORA0fs8Geyk/jQmP
         /QDYez2TBycM6NZ4a65ptO6fFop3NLReo4k/VfqK5r6G7tnEtTifM4niDzdNZ79lB2QZ
         GDIq3oqD9WMZ9DvtpU8Y17jfqTHo91aCAMsiYmpKISc8IlfX9yHBqQ1Xl9bZN2CLE0ea
         o6+vR5q9SDta3Dam2tKM/H8aqSNGi5rFY54ThlRy8l/VPE9lIA4kKnIaxLPWPgSuTfEH
         AMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4C8EM7PAuUt6hpnlstAb/V1eFsLaP3MGjMb2gR8iaBQ=;
        b=hDhnkW+I34mfYUcrkmk9CuMflm7BxM1rKwvMl0g+7Axc6AV6bBMVjg4zqQzAUt8pgE
         Zs1hGPvqxIVMyOzv6vL4odYOEheCePsecAQZUa2QNL8gK05wjMSptTa2k5SHItlMSAYE
         6hsAFSbBZEn0uRavW5po+B19WqpHpdAt/7cEjmTTsH42N81YTfAitXy3WzfvrI5sLjWL
         CvtdddhqY4bnPQ9s9/n9smInKg3Vvf23yNeefGV/HQNSJpUJArVNE5yiAD0Wi8elUc9e
         qhAcKFxmUqkgBwUPkffqy1a5Qd6cllzor+BchsVBvSjztPFoa1Llyyfz5I55HjwK90Bt
         HmSQ==
X-Gm-Message-State: AHQUAuarENayyI0qxC5MZsFOa3DMMSzLzfyFZT9swSVBc6L4jxtNQt6E
        3+Q1w3UJTBGEMwugwCVHr3mmZocapurjqA==
X-Google-Smtp-Source: AHgI3IbvYCB2qZQOJzjiBNUgaO/Z4utFFYhtWHKptxAYh/yU70Mvd7Ee9QgzfAjuth3dnedSELTsEw==
X-Received: by 2002:a63:575d:: with SMTP id h29mr4655710pgm.442.1550851445795;
        Fri, 22 Feb 2019 08:04:05 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id h63sm7271822pfd.148.2019.02.22.08.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 08:04:05 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Arad, Ronen" <ronen.arad@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mark Salyzyn <salyzyn@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Safonov <dima@arista.com>,
        David Ahern <dsahern@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Li RongQing <lirongqing@baidu.com>, YU Bo <tsu.yubo@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>, netdev@vger.kernel.org,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Alexander Potapenko <glider@google.com>
Subject: [stable 3.18 backport v2] netlink: Trim skb to alloc size to avoid MSG_TRUNC
Date:   Fri, 22 Feb 2019 08:03:28 -0800
Message-Id: <20190222160330.34237-1-salyzyn@android.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Arad, Ronen" <ronen.arad@intel.com>

Direct this upstream db65a3aaf29ecce2e34271d52e8d2336b97bd9fe sha to
stable 3.18.  This patch addresses a race condition where a call to

 nlk->max_recvmsg_len = max(nlk->max_recvmsg_len, len);
 nlk->max_recvmsg_len = min_t(size_t, nlk->max_recvmsg_len,

one thread in-between another thread:

 skb = netlink_alloc_skb(sk,

and

 skb_reserve(skb, skb_tailroom(skb) -
             nlk->max_recvmsg_len);

in netlink_dump.  The result can be a negative value and will cause
a kernel panic ad BUG at net/core/skbuff.c because the negative value
turns into an extremely large positive value.

Original commit:

netlink_dump() allocates skb based on the calculated min_dump_alloc or
a per socket max_recvmsg_len.
min_alloc_size is maximum space required for any single netdev
attributes as calculated by rtnl_calcit().
max_recvmsg_len tracks the user provided buffer to netlink_recvmsg.
It is capped at 16KiB.
The intention is to avoid small allocations and to minimize the number
of calls required to obtain dump information for all net devices.

netlink_dump packs as many small messages as could fit within an skb
that was sized for the largest single netdev information. The actual
space available within an skb is larger than what is requested. It could
be much larger and up to near 2x with align to next power of 2 approach.

Allowing netlink_dump to use all the space available within the
allocated skb increases the buffer size a user has to provide to avoid
truncaion (i.e. MSG_TRUNG flag set).

It was observed that with many VLANs configured on at least one netdev,
a larger buffer of near 64KiB was necessary to avoid "Message truncated"
error in "ip link" or "bridge [-c[ompressvlans]] vlan show" when
min_alloc_size was only little over 32KiB.

This patch trims skb to allocated size in order to allow the user to
avoid truncation with more reasonable buffer size.

Signed-off-by: Ronen Arad <ronen.arad@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

(cherry pick commit db65a3aaf29ecce2e34271d52e8d2336b97bd9fe)
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ronen Arad <ronen.arad@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>
Cc: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Andrei Vagin <avagin@virtuozzo.com>
Cc: Li RongQing <lirongqing@baidu.com>
Cc: YU Bo <tsu.yubo@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # 3.18
---
 net/netlink/af_netlink.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 50096e0edd8e..14295cef6b76 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1977,6 +1977,7 @@ static int netlink_dump(struct sock *sk)
 	struct nlmsghdr *nlh;
 	struct module *module;
 	int err = -ENOBUFS;
+	int alloc_min_size;
 	int alloc_size;
 
 	mutex_lock(nlk->cb_mutex);
@@ -1985,9 +1986,6 @@ static int netlink_dump(struct sock *sk)
 		goto errout_skb;
 	}
 
-	cb = &nlk->cb;
-	alloc_size = max_t(int, cb->min_dump_alloc, NLMSG_GOODSIZE);
-
 	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
 		goto errout_skb;
 
@@ -1996,22 +1994,34 @@ static int netlink_dump(struct sock *sk)
 	 * to reduce number of system calls on dump operations, if user
 	 * ever provided a big enough buffer.
 	 */
-	if (alloc_size < nlk->max_recvmsg_len) {
-		skb = netlink_alloc_skb(sk,
-					nlk->max_recvmsg_len,
-					nlk->portid,
+	cb = &nlk->cb;
+	alloc_min_size = max_t(int, cb->min_dump_alloc, NLMSG_GOODSIZE);
+
+	if (alloc_min_size < nlk->max_recvmsg_len) {
+		alloc_size = nlk->max_recvmsg_len;
+		skb = netlink_alloc_skb(sk, alloc_size, nlk->portid,
 					(GFP_KERNEL & ~__GFP_WAIT) |
 					__GFP_NOWARN | __GFP_NORETRY);
-		/* available room should be exact amount to avoid MSG_TRUNC */
-		if (skb)
-			skb_reserve(skb, skb_tailroom(skb) -
-					 nlk->max_recvmsg_len);
 	}
-	if (!skb)
+	if (!skb) {
+		alloc_size = alloc_min_size;
 		skb = netlink_alloc_skb(sk, alloc_size, nlk->portid,
 					(GFP_KERNEL & ~__GFP_WAIT));
+	}
 	if (!skb)
 		goto errout_skb;
+
+	/* Trim skb to allocated size. User is expected to provide buffer as
+	 * large as max(min_dump_alloc, 16KiB (mac_recvmsg_len capped at
+	 * netlink_recvmsg())). dump will pack as many smaller messages as
+	 * could fit within the allocated skb. skb is typically allocated
+	 * with larger space than required (could be as much as near 2x the
+	 * requested size with align to next power of 2 approach). Allowing
+	 * dump to use the excess space makes it difficult for a user to have a
+	 * reasonable static buffer based on the expected largest dump of a
+	 * single netdev. The outcome is MSG_TRUNC error.
+	 */
+	skb_reserve(skb, skb_tailroom(skb) - alloc_size);
 	netlink_skb_set_owner_r(skb, sk);
 
 	if (nlk->dump_done_errno > 0)
-- 
2.21.0.rc0.258.g878e2cd30e-goog

