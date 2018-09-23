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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C842C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FC9214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ryLMMcov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FC9214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeIWPNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 11:13:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35115 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeIWPNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 11:13:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id o16so3429365wrx.2;
        Sun, 23 Sep 2018 02:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wluegA9G0mQsc00qdkhXnSZHdeUAa9MHd8gbxoTToGU=;
        b=ryLMMcovXTf077FcxlhGTkV4zius2JJPHHPBSmjYgU+zPpgiHCHZ0ejBE3Wa80xXS7
         bm8GWbOzaZBGY/1+pD5nLKNBqQpom/BUMoHkf6+ksT0/+FJDYlOrSScJFiX0XYKSzMa5
         /G9WU0SCzxJsnJOBDPuBb4o+/Ge3/iIRJ3DeX/EeP6QkfmidR6nW/hESHHboRkmVNgRs
         2HVKW9PhHSwKGkL6VOqq16EQljFe0j0uUBpaAp5GYg8juk1O4YCwxcS+Yw0CNuPhCPCI
         Uen36fTPIOSxmjzvG786XS3/fVRmCuZpwnZ9cSTPR8tn3tdVHUktXZ3CU7L+OfMsn2MD
         WeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wluegA9G0mQsc00qdkhXnSZHdeUAa9MHd8gbxoTToGU=;
        b=ncO2kVQFNqguQqeN/sHxAbvoYW9zH+L1J5I/2skdV5LXegVSJq9OGgvMnTTpt3ryu+
         Esr08gYtnONmkVeNxiMK771qMfuR5CwmhiapDiU6Z+0/T1nCr3162j66t2Fwa1/YSnpt
         +I48GsQl8w5DM+Dvo1WzVtDBRr5Ow8gPPYPBAVSqvDejxm98ZiOebB7p49sboZAkaqvx
         U8aERwKJnXrl8QGLVcqOteUgm1joC1vJSsqDH4G/pu9jyfdA0v3PO2Y4Og4TWR5rHJxC
         AHfw3CUB4o1f2haEb3EOalC34KTErLQ0Qw7oJoII+uo3upXLcRsSP95BSWcgI+NQLn3V
         T76Q==
X-Gm-Message-State: ABuFfohiHtNizQkFlr8Ysp4wocTTdfHAK+U7WSCS/2bjDhTITTwRcG8n
        +D3nZ4W0ixxeY9afMq4X8BU=
X-Google-Smtp-Source: ACcGV60eAEtkerqWJxCiE1r0wA+L7IgQKjDPk+dB//ebcuqFAvpd1zyAJxvV1/0YOTRqQAwhiYS54g==
X-Received: by 2002:adf:d149:: with SMTP id b9-v6mr4555889wri.17.1537694185488;
        Sun, 23 Sep 2018 02:16:25 -0700 (PDT)
Received: from desktopdebian.localdomain (x4dbb2f17.dyn.telefonica.de. [77.187.47.23])
        by smtp.gmail.com with ESMTPSA id m68-v6sm20865759wmb.10.2018.09.23.02.16.24
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
Subject: [PATCH v2 1/2] netfilter: nf_tables: add SECMARK support
Date:   Sun, 23 Sep 2018 11:16:10 +0200
Message-Id: <20180923091611.19815-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to set the security context of packets within the nf_tables framework.
Add a nft_object for holding security contexts in the kernel and manipulating packets on the wire.

Convert the security context strings at rule addition time to security identifiers.
This is the same behavior like in xt_SECMARK and offers better performance than computing it per packet.

Set the maximum security context length to 256.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---

v2: convert security context strings to ids on rule addition time

Based on nf-next
Tested with v4.18.8

 include/net/netfilter/nf_tables_core.h   |   4 +
 include/uapi/linux/netfilter/nf_tables.h |  18 +++-
 net/netfilter/nf_tables_core.c           |  28 ++++++-
 net/netfilter/nft_meta.c                 | 101 +++++++++++++++++++++++
 4 files changed, 146 insertions(+), 5 deletions(-)

diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 8da837d2a..2046d104f 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -16,6 +16,10 @@ extern struct nft_expr_type nft_meta_type;
 extern struct nft_expr_type nft_rt_type;
 extern struct nft_expr_type nft_exthdr_type;
 
+#ifdef CONFIG_NETWORK_SECMARK
+extern struct nft_object_type nft_secmark_obj_type;
+#endif
+
 int nf_tables_core_module_init(void);
 void nf_tables_core_module_exit(void);
 
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 702e4f0be..5444e7687 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1176,6 +1176,21 @@ enum nft_quota_attributes {
 };
 #define NFTA_QUOTA_MAX		(__NFTA_QUOTA_MAX - 1)
 
+/**
+ * enum nft_secmark_attributes - nf_tables secmark object netlink attributes
+ *
+ * @NFTA_SECMARK_CTX: security context (NLA_STRING)
+ */
+enum nft_secmark_attributes {
+	NFTA_SECMARK_UNSPEC,
+	NFTA_SECMARK_CTX,
+	__NFTA_SECMARK_MAX,
+};
+#define NFTA_SECMARK_MAX	(__NFTA_SECMARK_MAX - 1)
+
+/* Max security context length */
+#define NFT_SECMARK_CTX_MAXLEN		256
+
 /**
  * enum nft_reject_types - nf_tables reject expression reject types
  *
@@ -1432,7 +1447,8 @@ enum nft_ct_timeout_timeout_attributes {
 #define NFT_OBJECT_CONNLIMIT	5
 #define NFT_OBJECT_TUNNEL	6
 #define NFT_OBJECT_CT_TIMEOUT	7
-#define __NFT_OBJECT_MAX	8
+#define NFT_OBJECT_SECMARK	8
+#define __NFT_OBJECT_MAX	9
 #define NFT_OBJECT_MAX		(__NFT_OBJECT_MAX - 1)
 
 /**
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index ffd5c0f94..3fbce3b9c 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -249,12 +249,24 @@ static struct nft_expr_type *nft_basic_types[] = {
 	&nft_exthdr_type,
 };
 
+static struct nft_object_type *nft_basic_objects[] = {
+#ifdef CONFIG_NETWORK_SECMARK
+	&nft_secmark_obj_type,
+#endif
+};
+
 int __init nf_tables_core_module_init(void)
 {
-	int err, i;
+	int err, i, j = 0;
+
+	for (i = 0; i < ARRAY_SIZE(nft_basic_objects); i++) {
+		err = nft_register_obj(nft_basic_objects[i]);
+		if (err)
+			goto err;
+	}
 
-	for (i = 0; i < ARRAY_SIZE(nft_basic_types); i++) {
-		err = nft_register_expr(nft_basic_types[i]);
+	for (j = 0; j < ARRAY_SIZE(nft_basic_types); j++) {
+		err = nft_register_expr(nft_basic_types[j]);
 		if (err)
 			goto err;
 	}
@@ -262,8 +274,12 @@ int __init nf_tables_core_module_init(void)
 	return 0;
 
 err:
+	while (j-- > 0)
+		nft_unregister_expr(nft_basic_types[j]);
+
 	while (i-- > 0)
-		nft_unregister_expr(nft_basic_types[i]);
+		nft_unregister_obj(nft_basic_objects[i]);
+
 	return err;
 }
 
@@ -274,4 +290,8 @@ void nf_tables_core_module_exit(void)
 	i = ARRAY_SIZE(nft_basic_types);
 	while (i-- > 0)
 		nft_unregister_expr(nft_basic_types[i]);
+
+	i = ARRAY_SIZE(nft_basic_objects);
+	while (i-- > 0)
+		nft_unregister_obj(nft_basic_objects[i]);
 }
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 297fe7d97..ac5df9508 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -543,3 +543,104 @@ struct nft_expr_type nft_meta_type __read_mostly = {
 	.maxattr	= NFTA_META_MAX,
 	.owner		= THIS_MODULE,
 };
+
+#ifdef CONFIG_NETWORK_SECMARK
+
+struct nft_secmark {
+	char ctx[NFT_SECMARK_CTX_MAXLEN];
+	int len;
+	u32 secid;
+};
+
+static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
+	[NFTA_SECMARK_CTX]     = { .type = NLA_STRING, .len = NFT_SECMARK_CTX_MAXLEN },
+};
+
+static int nft_secmark_secconversion(struct nft_secmark *priv)
+{
+	int err;
+	u32 tmp_secid = 0;
+
+	err = security_secctx_to_secid(priv->ctx, priv->len, &tmp_secid);
+	if (err)
+		return err;
+
+	if (!tmp_secid)
+		return -ENOENT;
+
+	err = security_secmark_relabel_packet(tmp_secid);
+	if (err)
+		return err;
+
+	priv->secid = tmp_secid;
+	return 0;
+}
+
+static void nft_secmark_obj_eval(struct nft_object *obj, struct nft_regs *regs, const struct nft_pktinfo *pkt)
+{
+	const struct nft_secmark *priv = nft_obj_data(obj);
+	struct sk_buff *skb = pkt->skb;
+
+	skb->secmark = priv->secid;
+}
+
+
+static int nft_secmark_obj_init(const struct nft_ctx *ctx, const struct nlattr * const tb[], struct nft_object *obj)
+{
+	int err;
+	struct nft_secmark *priv = nft_obj_data(obj);
+
+	if (tb[NFTA_SECMARK_CTX] == NULL)
+		return -EINVAL;
+
+	nla_strlcpy(priv->ctx, tb[NFTA_SECMARK_CTX], NFT_SECMARK_CTX_MAXLEN);
+	priv->len = strlen(priv->ctx);
+
+	err = nft_secmark_secconversion(priv);
+	if (err)
+		return err;
+
+	security_secmark_refcount_inc();
+
+	return 0;
+}
+
+static int nft_secmark_obj_dump(struct sk_buff *skb, struct nft_object *obj, bool reset)
+{
+	int err;
+	struct nft_secmark *priv = nft_obj_data(obj);
+
+	if (nla_put_string(skb, NFTA_SECMARK_CTX, priv->ctx))
+		return -1;
+
+	if (reset) {
+		err = nft_secmark_secconversion(priv);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void nft_secmark_obj_destroy(const struct nft_ctx *ctx, struct nft_object *obj)
+{
+	security_secmark_refcount_dec();
+}
+
+static const struct nft_object_ops nft_secmark_obj_ops = {
+	.type		= &nft_secmark_obj_type,
+	.size		= sizeof(struct nft_secmark),
+	.init		= nft_secmark_obj_init,
+	.eval		= nft_secmark_obj_eval,
+	.dump		= nft_secmark_obj_dump,
+	.destroy	= nft_secmark_obj_destroy,
+};
+struct nft_object_type nft_secmark_obj_type __read_mostly = {
+	.type		= NFT_OBJECT_SECMARK,
+	.ops		= &nft_secmark_obj_ops,
+	.maxattr	= NFTA_SECMARK_MAX,
+	.policy		= nft_secmark_policy,
+	.owner		= THIS_MODULE,
+};
+
+#endif /* CONFIG_NETWORK_SECMARK */
-- 
2.19.0

