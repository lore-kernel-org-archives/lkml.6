Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59002C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E7120672
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytheb-org.20150623.gappssmtp.com header.i=@bytheb-org.20150623.gappssmtp.com header.b="Z5hmTd9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E7120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bytheb.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeKZFBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:01:17 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35018 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeKZFBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:01:16 -0500
Received: by mail-io1-f68.google.com with SMTP id u19so12157574ioc.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 10:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytheb-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HImVIHjiKiueh5AFbs/HvT4PXHBa+AMvxJlO0XW1Us=;
        b=Z5hmTd9EvobjHm/rMZB5LQRzgIE3eIeXSEBA1Gb1VpKWByaIhe+Xl5ERi+XlGIR3/I
         B/tdNM7wYUCl3p21DdGO8Xcdyz3o8VZdcSjv3X4hpo1zw5hB0Q7ZgzUz+F+jAGGXjNeR
         0PEkS23YufmbDl+Gqbt1r3Xf8cWN6ApIjGlXfc96L8jcT7YNMQ0z9ihq3vVA6FuBkGLn
         FAeZZ4Trh17UUlt5BhyBJzqHlM9Se8BrDNHNnK4vwYlDYav4GKvZoiN/GjfAK+XFsE6J
         1CqxmMFLVOFZa2bKG+QfcktwfJtviko0BQjAov65BEkHceLsDk3ZuQ4B7W1UD/HJ7DGk
         funw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HImVIHjiKiueh5AFbs/HvT4PXHBa+AMvxJlO0XW1Us=;
        b=dJI1XtzLbQW/AQOaLAJZMSnx9yLT6iQkIn0eXDXMgsPfRm/ohoe8racA3sgy+H12Dl
         CTrl3n5iU3wEH+YJF2/u3gUavLkRnhXJZfAF+/mvqv39B3vcWUS32r6BeIHJkysCfNA7
         rEPvOvPoXazWeXWLra+0wc0+ANluwY1fak22EHNnPqn9Gs59PanFXm9j9qMriO952W+5
         EthlKARoz0IJ0HfD8moUhZVJiGXCWtvZf3I1XepK9fEW1SujPMy0GTXRLGiPmknv/9tU
         FMkIi55ezW5Zox6EfGASRNmQfXGKqeIHVnvZCbT/A8MxsLgvR11F7G6KXU5KXkEIn2Xj
         N4Hg==
X-Gm-Message-State: AA+aEWZc4AlXHZVcDYDQ2Z11MByG47/axIBN2SYW4aLupRpj1YSUkhDh
        Xtrm5e6tiAZJDiDGa5DE74l4FmMTaL5F/w==
X-Google-Smtp-Source: AFSGD/WwAnErXMg1jEVBDMs+dFyBTi/ep3hy7h9/hbo51gUE6HokA6p2hJyG8rDl6NG4AMB38fa0Gg==
X-Received: by 2002:a6b:7a01:: with SMTP id h1mr17552020iom.116.1543169378222;
        Sun, 25 Nov 2018 10:09:38 -0800 (PST)
Received: from dhcp-25.97.bos.redhat.com (047-014-005-015.res.spectrum.com. [47.14.5.15])
        by smtp.gmail.com with ESMTPSA id y8sm5959768ita.5.2018.11.25.10.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 10:09:37 -0800 (PST)
From:   Aaron Conole <aconole@bytheb.org>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Brouer <brouer@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        Rony Efraim <ronye@mellanox.com>,
        Simon Horman <horms@verge.net>,
        Marcelo Leitner <marcelo.leitner@gmail.com>
Subject: [RFC -next v0 1/3] bpf: modular maps
Date:   Sun, 25 Nov 2018 13:09:17 -0500
Message-Id: <20181125180919.13996-2-aconole@bytheb.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125180919.13996-1-aconole@bytheb.org>
References: <20181125180919.13996-1-aconole@bytheb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit allows for map operations to be loaded by an lkm, rather than
needing to be baked into the kernel at compile time.

Signed-off-by: Aaron Conole <aconole@bytheb.org>
---
 include/linux/bpf.h  |  6 +++++
 init/Kconfig         |  8 +++++++
 kernel/bpf/syscall.c | 57 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 33014ae73103..bf4531f076ca 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -553,6 +553,7 @@ static inline int bpf_map_attr_numa_node(const union bpf_attr *attr)
 
 struct bpf_prog *bpf_prog_get_type_path(const char *name, enum bpf_prog_type type);
 int array_map_alloc_check(union bpf_attr *attr);
+void bpf_map_insert_ops(size_t id, const struct bpf_map_ops *ops);
 
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
@@ -665,6 +666,11 @@ static inline struct bpf_prog *bpf_prog_get_type_path(const char *name,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline void bpf_map_insert_ops(size_t id,
+				      const struct bpf_map_ops *ops)
+{
+}
 #endif /* CONFIG_BPF_SYSCALL */
 
 static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
diff --git a/init/Kconfig b/init/Kconfig
index a4112e95724a..aa4eb98af656 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1489,6 +1489,14 @@ config BPF_JIT_ALWAYS_ON
 	  Enables BPF JIT and removes BPF interpreter to avoid
 	  speculative execution of BPF instructions by the interpreter
 
+config BPF_LOADABLE_MAPS
+	bool "Allow map types to be loaded with modules"
+	depends on BPF_SYSCALL && MODULES
+	help
+	  Enables BPF map types to be provided by loadable modules
+	  instead of always compiled in.  Maps provided dynamically
+	  may only be used by super users.
+
 config USERFAULTFD
 	bool "Enable userfaultfd() system call"
 	select ANON_INODES
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cf5040fd5434..fa1db9ab81e1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -49,6 +49,8 @@ static DEFINE_SPINLOCK(map_idr_lock);
 
 int sysctl_unprivileged_bpf_disabled __read_mostly;
 
+const struct bpf_map_ops loadable_map = {};
+
 static const struct bpf_map_ops * const bpf_map_types[] = {
 #define BPF_PROG_TYPE(_id, _ops)
 #define BPF_MAP_TYPE(_id, _ops) \
@@ -58,6 +60,15 @@ static const struct bpf_map_ops * const bpf_map_types[] = {
 #undef BPF_MAP_TYPE
 };
 
+static const struct bpf_map_ops * bpf_loadable_map_types[] = {
+#define BPF_PROG_TYPE(_id, _ops)
+#define BPF_MAP_TYPE(_id, _ops) \
+	[_id] = NULL,
+#include <linux/bpf_types.h>
+#undef BPF_PROG_TYPE
+#undef BPF_MAP_TYPE
+};
+
 /*
  * If we're handed a bigger struct than we know of, ensure all the unknown bits
  * are 0 - i.e. new user-space does not rely on any kernel feature extensions
@@ -105,6 +116,48 @@ const struct bpf_map_ops bpf_map_offload_ops = {
 	.map_check_btf = map_check_no_btf,
 };
 
+/*
+ * Fills in the modular ops map, provided that the entry is not already
+ * filled, and that the caller has CAP_SYS_ADMIN.  */
+void bpf_map_insert_ops(size_t id, const struct bpf_map_ops *ops)
+{
+#ifdef CONFIG_BPF_LOADABLE_MAPS
+	if (!capable(CAP_SYS_ADMIN))
+		return;
+
+	if (id >= ARRAY_SIZE(bpf_loadable_map_types))
+		return;
+
+	id = array_index_nospec(id, ARRAY_SIZE(bpf_loadable_map_types));
+	if (bpf_loadable_map_types[id] == NULL)
+		bpf_loadable_map_types[id] = ops;
+#endif
+}
+EXPORT_SYMBOL_GPL(bpf_map_insert_ops);
+
+static const struct bpf_map_ops *find_loadable_ops(u32 type)
+{
+	struct user_struct *user = get_current_user();
+	const struct bpf_map_ops *ops = NULL;
+
+	if (user->uid.val)
+		goto done;
+
+#ifdef CONFIG_BPF_LOADABLE_MAPS
+	if (!capable(CAP_SYS_ADMIN))
+		goto done;
+
+	if (type >= ARRAY_SIZE(bpf_loadable_map_types))
+		goto done;
+	type = array_index_nospec(type, ARRAY_SIZE(bpf_loadable_map_types));
+	ops = bpf_loadable_map_types[type];
+#endif
+
+done:
+	free_uid(user);
+	return ops;
+}
+
 static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 {
 	const struct bpf_map_ops *ops;
@@ -115,7 +168,8 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 	if (type >= ARRAY_SIZE(bpf_map_types))
 		return ERR_PTR(-EINVAL);
 	type = array_index_nospec(type, ARRAY_SIZE(bpf_map_types));
-	ops = bpf_map_types[type];
+	ops = (bpf_map_types[type] != &loadable_map) ? bpf_map_types[type] :
+		find_loadable_ops(type);
 	if (!ops)
 		return ERR_PTR(-EINVAL);
 
@@ -180,6 +234,7 @@ int bpf_map_precharge_memlock(u32 pages)
 		return -EPERM;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bpf_map_precharge_memlock);
 
 static int bpf_charge_memlock(struct user_struct *user, u32 pages)
 {
-- 
2.19.1

