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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24343ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1652214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Wc+AKzpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1652214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeIWPNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 11:13:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34046 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeIWPNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 11:13:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id t15so8826934wrx.1;
        Sun, 23 Sep 2018 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mgTHSkW4YsUxUx1zKtiHWDUN6r3Nwhwqj9hrE/x7CNo=;
        b=Wc+AKzpODe7ForUbxmyjR4bMznQBH6KzYVXXayh9YW0C/J1UDFkTofyZdq1USy+RWV
         +uEBfX8sAgCRcXrPSbZ+N2qst78RGC1WN3gn1zJmn1jemnfNbEoiXBRvO59wTvj/GIuW
         vdHx29av1WfS6Ss06JhS5E55hD+LGyB36muPACAaDGped2cE1TrYFiyfoqFSWaigI+3+
         fWwXq9H08gMC+SRE2WzLbXpiQHW+GbYiwZGjzBrFNrfne7JLplp1ncUNvYy4K3n6FhM6
         HmnZHE7nVzgtfUtivn8ZwhjY9fwXdXmZvUXjOfbdQ3Ub0+eWh/mSLOlwy8ev+kf6UqT3
         PY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mgTHSkW4YsUxUx1zKtiHWDUN6r3Nwhwqj9hrE/x7CNo=;
        b=E262xRZ4Ji+g93V0oipDtnXHo2sYacLxx0cVQI5Lxd1pmwiGZEQsemHWokkZ14EnNI
         7xXay2xLIJuKWX9VSjtqhLbQrR87iSKjLW41JEzSIzwa3S6OwT27LDJsdLftX3/C5cUS
         RwTnHUmNyTgBwwuibBvn0zoXQTLHUPYw7xrfoPI3rqJ+kbA16CZEAQJwm/eWDW8F4zjR
         qJu5vWxhYMLFL/4r6CKQyO5zFnSt9yFHHdPMyoZ226jK6kX/ZuKYB3bRzveCVApAszjr
         f69Vwo4p0Mg9bFpRdty8HSkP8zvff+RC8RCN5n8HjQf9rqr2WvbZjpyJjiOhoKRjzxPw
         IKjA==
X-Gm-Message-State: ABuFfohfM3Olf/7Od6ECVnqHR1Xze9ygVIjw1oEMgE6aUbR23T6IcHgm
        XPMkUPiHbrJVtZAtCxLR9Vc=
X-Google-Smtp-Source: ACcGV62H6fugQK5nnM9SfOD3sNjgMMW/Kg3GFWrvHuUZlWjaNYq9Z9LHjFnZ4M406TRFuDriIl6ung==
X-Received: by 2002:adf:cc8d:: with SMTP id p13-v6mr4517294wrj.67.1537694186446;
        Sun, 23 Sep 2018 02:16:26 -0700 (PDT)
Received: from desktopdebian.localdomain (x4dbb2f17.dyn.telefonica.de. [77.187.47.23])
        by smtp.gmail.com with ESMTPSA id m68-v6sm20865759wmb.10.2018.09.23.02.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 02:16:25 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@paul-moore.com,
        sds@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org,
        serge@hallyn.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: [PATCH 2/2] netfilter: nf_tables: add requirements for connsecmark support
Date:   Sun, 23 Sep 2018 11:16:11 +0200
Message-Id: <20180923091611.19815-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180923091611.19815-1-cgzones@googlemail.com>
References: <20180923091611.19815-1-cgzones@googlemail.com>
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

Based on nf-next
Tested with v4.18.8

 net/netfilter/nft_ct.c   | 15 +++++++++++++++
 net/netfilter/nft_meta.c |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index d74afa707..dcc451c20 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
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
index ac5df9508..555fcd66b 100644
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

