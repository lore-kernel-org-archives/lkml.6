Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id d3QwGFE8GVv/MwAAmS7hNA
	; Thu, 07 Jun 2018 14:08:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 074D1608B8; Thu,  7 Jun 2018 14:08:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPNoSARG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 66DC1607DC;
	Thu,  7 Jun 2018 14:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66DC1607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932868AbeFGOIb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:08:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33171 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753447AbeFGOI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:08:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so3366904wma.0;
        Thu, 07 Jun 2018 07:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTq6FcN4scqYAmpupQ6CB48xck81EgeWWIq/66Nv8pw=;
        b=pPNoSARG77X2wVbfkDovvpmLl33EQ52hkiAQv4X228ETXY5avxq7Ok+wHWAetLq9qA
         fAfvvn8XR9g9PlpAWFokcsklu3CrZU3zlKyWt4FsqgQhiWBRB9zjPFGAZRKoGwRr7+Kp
         fStTU91Rta3A6Bd3YBP+kUw0Y7Os7AVTo5U2IY9d9MNl+OxTaTdoxykWD4KLS9G8E27v
         dRIGleMRsQg/uj9MN4YpBPROOCoRvWDGr3sXgmP00vn/IFj/IzgjHqwGKvufkmvwckdW
         25YOGakzdZ1zho8cAg06LproiyVxln/3tP9XwfOGGJozqeHgNyxtBcf1NsMrsXqpuuW0
         N3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTq6FcN4scqYAmpupQ6CB48xck81EgeWWIq/66Nv8pw=;
        b=l62HCdWOP12pztRTQy5DJczV37BN0D6MIFBhnJXIBPtZmNQaHMPMV4tYf/3vRtfqMO
         7zmZ6BQQ8iwfdLOWj41E+bkzsoBPfq9yXw6YhuX23pt4vME0HuYmDBmf0BeZH1kiNJkU
         HOwPZ303E972zj1KU4oq6HNl3zfvsSWnUW+n1pnT9Dg7U61A7RDAefr4CGggEaK1HUnq
         qQVWkLG6S7zBBKGYctg+ggjQ0BmZQNpWYptcAeB2dZ/S7DkVoQhzp/bYuMbHjJB03i9s
         TQTd2aUsrAPHtUDYoGoQsdfIX+p3LvTfprgMi/DRKIXInsJaH3JotM5QZ1uZMGPS/6ts
         IeWA==
X-Gm-Message-State: APt69E234A7C59rTvh/nBJAaCdD4VPVFjYlJc+f0LEmFX2eUuv4UZdKe
        oxcZ9BsFjhIK2puZHqZ2XuQ=
X-Google-Smtp-Source: ADUXVKIUik/H5/qn+dAq5f8+S+SNF/r2JnHZzq1bZJEvgBZyrEbxQ3NiDGU2p9NCvX8w0hGosjFxMQ==
X-Received: by 2002:a1c:5b0d:: with SMTP id p13-v6mr1766032wmb.53.1528380508122;
        Thu, 07 Jun 2018 07:08:28 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id u15-v6sm2591636wma.37.2018.06.07.07.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:08:27 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Romuald Cari <romuald.cari@devialet.com>,
        linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH] ieee802154: add rx LQI from userspace
Date: Thu,  7 Jun 2018 16:08:02 +0200
Message-Id: <20180607140802.22666-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Romuald CARI <romuald.cari@devialet.com>

The Link Quality Indication data exposed by drivers could not be accessed from
userspace. Since this data is per-datagram received, it makes sense to make it
available to userspace application through the ancillary data mechanism in
recvmsg rather than through ioctls. This can be activated using the socket
option WPAN_WANTLQI under SOL_IEEE802154 protocol.

This LQI data is available in the ancillary data buffer under the SOL_IEEE802154
level as the type WPAN_LQI. The value is an unsigned byte indicating the link
quality with values ranging 0-255.

Signed-off-by: Romuald Cari <romuald.cari@devialet.com>
Signed-off-by: Clément Peron <clement.peron@devialet.com>
---
 include/net/af_ieee802154.h |  1 +
 net/ieee802154/socket.c     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
index a5563d27a3eb..8003a9f6eb43 100644
--- a/include/net/af_ieee802154.h
+++ b/include/net/af_ieee802154.h
@@ -56,6 +56,7 @@ struct sockaddr_ieee802154 {
 #define WPAN_WANTACK		0
 #define WPAN_SECURITY		1
 #define WPAN_SECURITY_LEVEL	2
+#define WPAN_WANTLQI		3
 
 #define WPAN_SECURITY_DEFAULT	0
 #define WPAN_SECURITY_OFF	1
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index a60658c85a9a..bc6b912603f1 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -25,6 +25,7 @@
 #include <linux/termios.h>	/* For TIOCOUTQ/INQ */
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/socket.h>
 #include <net/datalink.h>
 #include <net/psnap.h>
 #include <net/sock.h>
@@ -452,6 +453,7 @@ struct dgram_sock {
 	unsigned int bound:1;
 	unsigned int connected:1;
 	unsigned int want_ack:1;
+	unsigned int want_lqi:1;
 	unsigned int secen:1;
 	unsigned int secen_override:1;
 	unsigned int seclevel:3;
@@ -486,6 +488,7 @@ static int dgram_init(struct sock *sk)
 	struct dgram_sock *ro = dgram_sk(sk);
 
 	ro->want_ack = 1;
+	ro->want_lqi = 0;
 	return 0;
 }
 
@@ -713,6 +716,7 @@ static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	size_t copied = 0;
 	int err = -EOPNOTSUPP;
 	struct sk_buff *skb;
+	struct dgram_sock *ro = dgram_sk(sk);
 	DECLARE_SOCKADDR(struct sockaddr_ieee802154 *, saddr, msg->msg_name);
 
 	skb = skb_recv_datagram(sk, flags, noblock, &err);
@@ -744,6 +748,13 @@ static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		*addr_len = sizeof(*saddr);
 	}
 
+	if (ro->want_lqi) {
+		err = put_cmsg(msg, SOL_IEEE802154, WPAN_WANTLQI,
+			       sizeof(uint8_t), &(mac_cb(skb)->lqi));
+		if (err)
+			goto done;
+	}
+
 	if (flags & MSG_TRUNC)
 		copied = skb->len;
 done:
@@ -847,6 +858,9 @@ static int dgram_getsockopt(struct sock *sk, int level, int optname,
 	case WPAN_WANTACK:
 		val = ro->want_ack;
 		break;
+	case WPAN_WANTLQI:
+		val = ro->want_lqi;
+		break;
 	case WPAN_SECURITY:
 		if (!ro->secen_override)
 			val = WPAN_SECURITY_DEFAULT;
@@ -892,6 +906,9 @@ static int dgram_setsockopt(struct sock *sk, int level, int optname,
 	case WPAN_WANTACK:
 		ro->want_ack = !!val;
 		break;
+	case WPAN_WANTLQI:
+		ro->want_lqi = !!val;
+		break;
 	case WPAN_SECURITY:
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
 		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
-- 
2.17.1
