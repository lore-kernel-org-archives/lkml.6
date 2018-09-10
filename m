Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A399CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522EA2088E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkeT/rbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522EA2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeIJNU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:20:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33471 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbeIJNU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:20:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id r1-v6so4774485wmh.0;
        Mon, 10 Sep 2018 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NtpmaRK8+dQOP+jqyjy301QZbo8/kU3iwE2oiaFn06w=;
        b=pkeT/rbhJ5GWD5YnqeGcyKz5JfZzhvOiUx0s/p6druFzNR6GGdLkbguAFInKOlvGdN
         tfVHw8smH2jQ5nD4WgFfsO+rucaYwwEHuNkdc87wf0d30eQm47jnOpaSmP22H/s8D90G
         HGiFJgNIkkDRoqp9bW2RvgSg8k82ZZVTWmULf7EaNo0520gkA8HQUB0aYRzMN+kjmn4w
         NVSsgVPLAQFAu2Q2Q5uqFzECy3ikB9B4FkXgyvUCIcPCuiLTzefY5SsPIQB7DgPW+8Yi
         N+1qLr9L+JyevqjYtKSfK8/PiW+0dw2yJwIRF8MDFQLyTKmL84lv53/E/gqrsf2T3D6D
         1TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtpmaRK8+dQOP+jqyjy301QZbo8/kU3iwE2oiaFn06w=;
        b=Pp7KQRT9c00ssc1O62qZ9563I+/XAxhBmfbIgL0K2QSgtfPtyVUVpN+5A7tHEe/Fk2
         HTw3xZ4BP8XzUf/yL7/SixOJq/4Ru1sVwmjKHWdeU5tNVuvumoKQcazUE5E7LjkCCONh
         r3UvdREzioRfDrCQjptPpnSopV3xGyya/JG30dMEvZpmj/HtO8+65uahs723Eot1CdvQ
         h0v6DYPsD8CZRR28fTE1GuLuNxyciMIjMYCJXCVGrmE1gZyDW0RhsnAM5bncEyFwlbcE
         szSfffqlBAn0EoslJeKAXXGk2+Kz/s9V/MtBBR/z20yAWe1HnrHwR/IF1mkgpx6fFGly
         hu7g==
X-Gm-Message-State: APzg51DqWEWrFF0UDy0v5D4jeKQ08Yi8INWO9t98Erh/kV5LQBS4VaiP
        OCqp5eiQDp1eQBMoTmBzbsDI9aLoOVc=
X-Google-Smtp-Source: ANB0VdYwi7+qCOmeALn3v1V1SoldRpm+CC3mkLbLDykR0oC92NQsP5xacRiA+3LXcUdgu3Nhiu/rSg==
X-Received: by 2002:a1c:b54b:: with SMTP id e72-v6mr12782672wmf.117.1536568052302;
        Mon, 10 Sep 2018 01:27:32 -0700 (PDT)
Received: from Buzz.fritz.box (p200300EE0F0184008022AC53B7CF59F1.dip0.t-ipconnect.de. [2003:ee:f01:8400:8022:ac53:b7cf:59f1])
        by smtp.gmail.com with ESMTPSA id 69-v6sm13236026wmb.27.2018.09.10.01.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 01:27:31 -0700 (PDT)
From:   Andre Naujoks <nautsch2@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Erik Kline <ek@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Shaohua Li <shli@fb.com>, Andre Naujoks <nautsch2@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: [PATCH 1/1] ipv6: Add sockopt IPV6_MULTICAST_ALL analogue to IP_MULTICAST_ALL
Date:   Mon, 10 Sep 2018 10:27:15 +0200
Message-Id: <20180910082715.11506-2-nautsch2@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
In-Reply-To: <20180910082715.11506-1-nautsch2@gmail.com>
References: <20180910082715.11506-1-nautsch2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The socket option will be enabled by default to ensure current behaviour
is not changed. This is the same for the IPv4 version.

A socket bound to in6addr_any and a specific port will receive all traffic
on that port. Analogue to IP_MULTICAST_ALL, disable this behaviour, if
one or more multicast groups were joined (using said socket) and only
pass on multicast traffic from groups, which were explicitly joined via
this socket.

Without this option disabled a socket (system even) joined to multiple
multicast groups is very hard to get right. Filtering by destination
address has to take place in user space to avoid receiving multicast
traffic from other multicast groups, which might have traffic on the same
port.

The extension of the IP_MULTICAST_ALL socketoption to just apply to ipv6,
too, is not done to avoid changing the behaviour of current applications.

Signed-off-by: Andre Naujoks <nautsch2@gmail.com>
Acked-By: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
---
 include/linux/ipv6.h     |  3 ++-
 include/uapi/linux/in6.h |  1 +
 net/ipv6/af_inet6.c      |  1 +
 net/ipv6/ipv6_sockglue.c | 11 +++++++++++
 net/ipv6/mcast.c         |  2 +-
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 8415bf1a9776..495e834c1367 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -274,7 +274,8 @@ struct ipv6_pinfo {
 						 */
 				dontfrag:1,
 				autoflowlabel:1,
-				autoflowlabel_set:1;
+				autoflowlabel_set:1,
+				mc_all:1;
 	__u8			min_hopcount;
 	__u8			tclass;
 	__be32			rcv_flowinfo;
diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index ed291e55f024..71d82fe15b03 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -177,6 +177,7 @@ struct in6_flowlabel_req {
 #define IPV6_V6ONLY		26
 #define IPV6_JOIN_ANYCAST	27
 #define IPV6_LEAVE_ANYCAST	28
+#define IPV6_MULTICAST_ALL	29
 
 /* IPV6_MTU_DISCOVER values */
 #define IPV6_PMTUDISC_DONT		0
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 9a4261e50272..77ef8478234f 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -209,6 +209,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	np->hop_limit	= -1;
 	np->mcast_hops	= IPV6_DEFAULT_MCASTHOPS;
 	np->mc_loop	= 1;
+	np->mc_all	= 1;
 	np->pmtudisc	= IPV6_PMTUDISC_WANT;
 	np->repflow	= net->ipv6.sysctl.flowlabel_reflect;
 	sk->sk_ipv6only	= net->ipv6.sysctl.bindv6only;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index c0cac9cc3a28..381ce38940ae 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -674,6 +674,13 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			retv = ipv6_sock_ac_drop(sk, mreq.ipv6mr_ifindex, &mreq.ipv6mr_acaddr);
 		break;
 	}
+	case IPV6_MULTICAST_ALL:
+		if (optlen < sizeof(int))
+			goto e_inval;
+		np->mc_all = valbool;
+		retv = 0;
+		break;
+
 	case MCAST_JOIN_GROUP:
 	case MCAST_LEAVE_GROUP:
 	{
@@ -1266,6 +1273,10 @@ static int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		val = np->mcast_oif;
 		break;
 
+	case IPV6_MULTICAST_ALL:
+		val = np->mc_all;
+		break;
+
 	case IPV6_UNICAST_IF:
 		val = (__force int)htonl((__u32) np->ucast_oif);
 		break;
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 4ae54aaca373..6895e1dc0b03 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -636,7 +636,7 @@ bool inet6_mc_check(struct sock *sk, const struct in6_addr *mc_addr,
 	}
 	if (!mc) {
 		rcu_read_unlock();
-		return true;
+		return np->mc_all;
 	}
 	read_lock(&mc->sflock);
 	psl = mc->sflist;
-- 
2.19.0.rc2

