Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5300CECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3F3208D9
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sYTZ55pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3F3208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeIXAZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 20:25:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37700 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIXAZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 20:25:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id n11-v6so7889605wmc.2;
        Sun, 23 Sep 2018 11:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vnlw7/pMb0oHqqOMoluWOOGIReW9qKzzqbHvYF5dZzY=;
        b=sYTZ55pvdBDNCs3mKqlH7POokJNwUd2F+mJu5xgLe3Rnk35Mz6lPw8AO0nwa4AqILw
         jX93+cGgCfJVe+i+oVjfvz7Xipukn6Tt2XzGuW66VvyKy8GnxmyFWRm48lXCWK0d6mr/
         B64R3aRyDpLaX4HfD47wb2v5Atl8PsqqZPfnAHvgJfx7eSjN2NR95r73OR5oGFQ1Vwa7
         XjdUYy+GSVYb7jntjjexw6FBVCWwCkB8PjKk7G/Pnl4bIMTuNDqtaJ6K/gjKQEBMpfIA
         AI2FBJVP0lpaYLlLpG3cKlmgjvg5pJNNXaexTVtAr9Wx6NsHfmzZJpiMZdv/FygkyXnH
         54bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vnlw7/pMb0oHqqOMoluWOOGIReW9qKzzqbHvYF5dZzY=;
        b=M3daaw21T/U1YlYI+7k3BfGyEqd++hd94doB0iCWP9u1uWHD6Jd/vg1mRbPHPLwaLr
         VaFvVTnTz71cnUQF6x25d3EqTgU98XBpLo2Nbx/4HnYe8+379O6NHsXiA1lCQx4QdJoK
         JcVRG0LbDpQ5vTv7X+ZgEMvsPgBcyDU1DwAF+YnrG4eOqNmFJkdQU7dzinhtYIgxH0Ok
         6sO6dbm2QrphHNnJ+iXt23Qn/EwcWoXJsetUorpKGHbrvs3280V2tF8EV+u0UPoX3Dvi
         DnrxLG1VVBxEib5r1tyXKjmU4uJKqCaB60a1DjDxkODlvXncfZJ7ejWyi4TtYABXabHH
         zLsw==
X-Gm-Message-State: APzg51CpY7mpl9Bi7ANdwhnzvA93v3bWGGuWk43SSfhq9oZsCcS6cP/E
        20E9KSW4vUyFCUwZPcfMl/Q=
X-Google-Smtp-Source: ANB0VdaOnzyLowbdPPii5VjFXa1uiFn+wJ8dRWC8T18G+/7aaWvAtFonFyN1xllmV3mb6k8hsClnnw==
X-Received: by 2002:a1c:adcc:: with SMTP id w195-v6mr4546884wme.41.1537727207983;
        Sun, 23 Sep 2018 11:26:47 -0700 (PDT)
Received: from desktopdebian.localdomain (x4dbb2f17.dyn.telefonica.de. [77.187.47.23])
        by smtp.gmail.com with ESMTPSA id c8sm15007248wrx.92.2018.09.23.11.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 11:26:47 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@paul-moore.com,
        sds@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org,
        serge@hallyn.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 2/2] netfilter: nf_tables: add requirements for connsecmark support
Date:   Sun, 23 Sep 2018 20:26:16 +0200
Message-Id: <20180923182616.11398-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180923182616.11398-1-cgzones@googlemail.com>
References: <20180923182616.11398-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ability to set the connection tracking secmark value.

Add ability to set the meta secmark value.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---

v3: fix compile error when CONFIG_NF_CONNTRACK_MARK not defined

Based on nf-next
Tested with v4.18.8

 net/netfilter/nft_ct.c   | 17 ++++++++++++++++-
 net/netfilter/nft_meta.c |  8 ++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index d74afa707..586627c36 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -279,7 +279,7 @@ static void nft_ct_set_eval(const struct nft_expr *expr,
 {
 	const struct nft_ct *priv = nft_expr_priv(expr);
 	struct sk_buff *skb = pkt->skb;
-#ifdef CONFIG_NF_CONNTRACK_MARK
+#if defined(CONFIG_NF_CONNTRACK_MARK) || defined(CONFIG_NF_CONNTRACK_SECMARK)
 	u32 value = regs->data[priv->sreg];
 #endif
 	enum ip_conntrack_info ctinfo;
@@ -298,6 +298,14 @@ static void nft_ct_set_eval(const struct nft_expr *expr,
 		}
 		break;
 #endif
+#ifdef CONFIG_NF_CONNTRACK_SECMARK
+	case NFT_CT_SECMARK:
+		if (ct->secmark != value) {
+			ct->secmark = value;
+			nf_conntrack_event_cache(IPCT_SECMARK, ct);
+		}
+		break;
+#endif
 #ifdef CONFIG_NF_CONNTRACK_LABELS
 	case NFT_CT_LABELS:
 		nf_connlabels_replace(ct,
@@ -564,6 +572,13 @@ static int nft_ct_set_init(const struct nft_ctx *ctx,
 			return -EINVAL;
 		len = sizeof(u32);
 		break;
+#endif
+#ifdef CONFIG_NF_CONNTRACK_SECMARK
+	case NFT_CT_SECMARK:
+		if (tb[NFTA_CT_DIRECTION])
+			return -EINVAL;
+		len = sizeof(u32);
+		break;
 #endif
 	default:
 		return -EOPNOTSUPP;
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index c8ac0ef4b..a6715c816 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -284,6 +284,11 @@ static void nft_meta_set_eval(const struct nft_expr *expr,
 
 		skb->nf_trace = !!value8;
 		break;
+#ifdef CONFIG_NETWORK_SECMARK
+	case NFT_META_SECMARK:
+		skb->secmark = value;
+		break;
+#endif
 	default:
 		WARN_ON(1);
 	}
@@ -436,6 +441,9 @@ static int nft_meta_set_init(const struct nft_ctx *ctx,
 	switch (priv->key) {
 	case NFT_META_MARK:
 	case NFT_META_PRIORITY:
+#ifdef CONFIG_NETWORK_SECMARK
+	case NFT_META_SECMARK:
+#endif
 		len = sizeof(u32);
 		break;
 	case NFT_META_NFTRACE:
-- 
2.19.0

