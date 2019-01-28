Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811DFC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4561321741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAaANvc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbfA1RDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:03:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33849 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387527AbfA1QN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id f7so18770229wrp.1;
        Mon, 28 Jan 2019 08:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3iWLsQKWSdm0NgJ85ZFgVcH5evF1kFvhDVwP7Yj1TPE=;
        b=ZAaANvc+iCyiO42llxT4mz4NugiZaQ3YMn5LhmWkbdFDd+uBLi8LSHN3oQ+riBBOFg
         c0dIF/XLZLkg1hVQkoIVw8iVmEbM0dGUnBnUPKvJJ7l669hWt1jassJh0d+TQaL5eBoK
         EHT7sLRvUzL6XJODk5SP+iySIy7jxckVBbO1if+6wKqfm4IkEPZtEkVl3YJM6xfFKfb/
         NE1QSUZ+jpRr1CNVpIgd3jttibtGtn24YqECioO+XzOHkcKp1ZhtZ0cUdsgl0t1v94Ns
         FjpUuryEQ+/MUl20vs16gDWWX5s+uBYtNO71NvE8OBa+wSau4mSy84DlrhIWA8Owcg5j
         up1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=3iWLsQKWSdm0NgJ85ZFgVcH5evF1kFvhDVwP7Yj1TPE=;
        b=gjJ5IRhpH/HKgDKCRuydK5fC5osI04wBmRVdiJ7YIeaMyAy7Z9Lm5c2cRzw4Sp1ZjN
         8aDgMzpSwfGmYlXlrT/5tqmECwOwYiEXZx8u+iVuunR3iJob/vjS+48qkNYmtOmh0iS0
         UHdonxifjT/jmf0o4iaphgSKqoXhK9/CnL9N4mK+uOG5kpNwAebgYG//cQhz7yoLPfGJ
         cH6XYJwRzXAzmdNJewdDOkLtkoE0z4I2YoMSZYhIiAFL305KgERgQCv8YQ3RLic6Xvhp
         p/C/du411yxnuF5OmeVvBhZ83axBf7dsR8T1zpjuHhBRVQzzEZ67Wz2A13T3TTE252sr
         z8dQ==
X-Gm-Message-State: AJcUukfd/zY7jP/2uZrdRlW5IE354N0+MTlY9lGOAJ4r4yvFaicYM2y1
        3UC5Axc0mNqra21oYcanvTs=
X-Google-Smtp-Source: ALg8bN7k7QoAa5ZQw8z32bugwnSj8NBLHx/EvHf69SCWDqkV+gCItdF7hf5bAxYgIL7zLCxGGTrZuw==
X-Received: by 2002:adf:de91:: with SMTP id w17mr23997899wrl.320.1548692036634;
        Mon, 28 Jan 2019 08:13:56 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id l20sm246445944wrb.93.2019.01.28.08.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:13:55 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH lora-next 09/11] net: lora: introduce lora socket addressing for metadata
Date:   Mon, 28 Jan 2019 16:13:03 +0000
Message-Id: <20190128161306.27805-10-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128161306.27805-1-ben.whitten@lairdtech.com>
References: <20190128161306.27805-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Information such as spreading factor, coding rate and power are on a per
transmission basis so we can encode this information in the lora socket
address.
In future we may have a different format for receive with additional
fields which get populated.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 include/linux/lora/skb.h  |  9 ++++++++
 include/uapi/linux/lora.h | 14 ++++++++++++
 net/lora/dgram.c          | 45 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/include/linux/lora/skb.h b/include/linux/lora/skb.h
index 8806741464d0..6abeb39b8b7f 100644
--- a/include/linux/lora/skb.h
+++ b/include/linux/lora/skb.h
@@ -12,6 +12,15 @@
 
 struct lora_skb_priv {
 	int ifindex;
+
+	u64 freq;
+	u8 sf;
+	u8 cr;
+	u16 bw;
+
+	u8 sync;
+
+	s8 power;
 };
 
 static inline struct lora_skb_priv *lora_skb_prv(struct sk_buff *skb)
diff --git a/include/uapi/linux/lora.h b/include/uapi/linux/lora.h
index 4ff00b9c3c20..4c458ee3ed9a 100644
--- a/include/uapi/linux/lora.h
+++ b/include/uapi/linux/lora.h
@@ -10,6 +10,18 @@
 #include <linux/types.h>
 #include <linux/socket.h>
 
+/* TX addressing definition */
+struct tx_addr {
+	__u64 freq;
+	__u8 sf;
+	__u8 cr;
+	__u16 bw;
+
+	__u8 sync;
+
+	__s8 power;
+};
+
 /* particular protocols of the protocol family PF_LORA */
 #define LORA_PROTO_DATAGRAM	0
 #define LORA_NPROTO		1
@@ -17,7 +29,9 @@
 struct sockaddr_lora {
 	__kernel_sa_family_t lora_family;
 	int lora_ifindex;
+	__u8 lora_protocol;
 	union {
+		struct tx_addr	tx;
 	} lora_addr;
 };
 
diff --git a/net/lora/dgram.c b/net/lora/dgram.c
index 4d931fd3778a..1556ad0f8835 100644
--- a/net/lora/dgram.c
+++ b/net/lora/dgram.c
@@ -20,6 +20,15 @@ struct dgram_sock {
 	int ifindex;
 	bool bound;
 	struct notifier_block notifier;
+
+	u64 freq;
+	u8 sf;
+	u8 cr;
+	u16 bw;
+
+	u8 sync;
+
+	s8 power;
 };
 
 static inline struct dgram_sock *dgram_sk(const struct sock *sk)
@@ -69,6 +78,12 @@ static int dgram_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		ifindex = 0;
 
 	dgram->ifindex = ifindex;
+	dgram->freq = addr->lora_addr.tx.freq;
+	dgram->sf = addr->lora_addr.tx.sf;
+	dgram->cr = addr->lora_addr.tx.cr;
+	dgram->bw = addr->lora_addr.tx.bw;
+	dgram->sync = addr->lora_addr.tx.sync;
+	dgram->power = addr->lora_addr.tx.power;
 	dgram->bound = true;
 
 out:
@@ -118,6 +133,12 @@ static int dgram_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	lora_skb_reserve(skb);
 	lora_skb_prv(skb)->ifindex = netdev->ifindex;
+	lora_skb_prv(skb)->freq = dgram->freq;
+	lora_skb_prv(skb)->sf = dgram->sf;
+	lora_skb_prv(skb)->cr = dgram->cr;
+	lora_skb_prv(skb)->bw = dgram->bw;
+	lora_skb_prv(skb)->sync = dgram->sync;
+	lora_skb_prv(skb)->power = dgram->power;
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (ret < 0)
@@ -172,6 +193,12 @@ static int dgram_getname(struct socket *sock, struct sockaddr *uaddr,
 	memset(addr, 0, sizeof(*addr));
 	addr->lora_family = AF_LORA;
 	addr->lora_ifindex = dgram->ifindex;
+	addr->lora_addr.tx.freq = dgram->freq;
+	addr->lora_addr.tx.sf = dgram->sf;
+	addr->lora_addr.tx.cr = dgram->cr;
+	addr->lora_addr.tx.bw = dgram->bw;
+	addr->lora_addr.tx.sync = dgram->sync;
+	addr->lora_addr.tx.power = dgram->power;
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 13, 0)
 	return sizeof(*addr);
@@ -198,6 +225,12 @@ static int dgram_release(struct socket *sock)
 	lock_sock(sk);
 
 	dgram->ifindex = 0;
+	dgram->freq = 0;
+	dgram->sf = 0;
+	dgram->cr = 0;
+	dgram->bw = 0;
+	dgram->sync = 0;
+	dgram->power = 0;
 	dgram->bound = false;
 
 	sock_orphan(sk);
@@ -251,6 +284,12 @@ static int dgram_notifier(struct notifier_block *nb, unsigned long msg, void *pt
 		lock_sock(sk);
 
 		dgram->ifindex = 0;
+		dgram->freq = 0;
+		dgram->sf = 0;
+		dgram->cr = 0;
+		dgram->bw = 0;
+		dgram->sync = 0;
+		dgram->power = 0;
 		dgram->bound = false;
 
 		release_sock(sk);
@@ -277,6 +316,12 @@ static int dgram_init(struct sock *sk)
 	pr_debug("lora: %s\n", __func__);
 
 	dgram->bound = false;
+	dgram->freq = 0;
+	dgram->sf = 0;
+	dgram->cr = 0;
+	dgram->bw = 0;
+	dgram->sync = 0;
+	dgram->power = 0;
 	dgram->ifindex = 0;
 
 	dgram->notifier.notifier_call = dgram_notifier;
-- 
2.17.1

