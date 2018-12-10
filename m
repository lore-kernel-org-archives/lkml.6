Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB9FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F69D20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKl1ZVpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F69D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbeLJXnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:43:21 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54610 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbeLJXnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:43:13 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so755770ita.4;
        Mon, 10 Dec 2018 15:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwnqfnbdMvDVr4hlccXEnXGHSABVmmK0B7a4EWV88iY=;
        b=mKl1ZVpJNIelyPCFBZxNdIfcp9gBx8O5oMGqqziX3C5COKNGAS4zrkfpP19Eu+MrqQ
         Er3ypCkJmtMGfPkxhga/lGsNFiNByJTRDndbzdQHsh3iEupkJgLNxvcqZFQ1MIx+kaSF
         E2hMtirU9RVt8ggKQTso3wLf4v9x5/4/5l73DbfDCD91ibH51brLeX3KXqeba1waEqmW
         ObHTffFKX3Gq6l/RA2nqm6jZB3NnI+59bwH1ImrNeiUcZtT2xj9mDNUa8sJ90IWPZ21P
         h9uVmAARLy1y6zfnsIlcFyT2ET3kg38akd7GpjsPMlwXFhXQyYqWxMgjzyq7nLH4pf/T
         xa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwnqfnbdMvDVr4hlccXEnXGHSABVmmK0B7a4EWV88iY=;
        b=YywEO2g0AGUDdDqimoK2EaB9GXadVAj/NWMdS0fcvpJ4/WIdeuZapHCdzkQboXTbqQ
         GsJXtyYSg0lqJC812caNZ+vcyan4CmUyME8UixHCofFU5/1GIKR/U5of/jmkISKXRxa5
         znoHY9oBCl4uF8vj1fui95TESdk3d1vwWuVMYJQM14z68nxBCEYyoZkzFaZp2JxCGL/z
         A4ASkzNKpHAyaUScWDQHIrq2lSFdUF1wDEYe6SGmr1BReCAmc1Ns14ys3QJn7zsdP4nU
         dvnrYS+GHiV83OmPdZl53ynMaCn5S2IM90+zm6wd4Y4AuTWwcnR6eem5ms0PPJLr7jZf
         eulg==
X-Gm-Message-State: AA+aEWYU+XYCj77PJxIo/i92uf50Lz59Qbyz239+i0UVWweGic22bgDP
        FeCV2gFIWXl81vDWLLbevSS9kSMvA8g=
X-Google-Smtp-Source: AFSGD/UvyGWWVSSkpkjD2K+O2QyP3MrM+TheDxE25ekNPyvMasFcS0CD9RqDqoW2qvRp+bK4NdVLiA==
X-Received: by 2002:a24:6a83:: with SMTP id l125mr369674itc.161.1544485391435;
        Mon, 10 Dec 2018 15:43:11 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::4:375a])
        by smtp.gmail.com with ESMTPSA id e68sm625346ite.7.2018.12.10.15.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 15:43:10 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     netdev@vger.kernel.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 2/3] bpf: add bpffs pretty print for cgroup local storage maps
Date:   Mon, 10 Dec 2018 15:43:01 -0800
Message-Id: <20181210234302.31327-3-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210234302.31327-1-guro@fb.com>
References: <20181210234302.31327-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement bpffs pretty printing for cgroup local storage maps
(both shared and per-cpu).
Output example (captured for tools/testing/selftests/bpf/netcnt_prog.c):

Shared:
  $ cat /sys/fs/bpf/map_2
  # WARNING!! The output is for debug purpose only
  # WARNING!! The output format will change
  {4294968594,1}: {9999,1039896}

Per-cpu:
  $ cat /sys/fs/bpf/map_1
  # WARNING!! The output is for debug purpose only
  # WARNING!! The output format will change
  {4294968594,1}: {
  	cpu0: {0,0,0,0,0}
  	cpu1: {0,0,0,0,0}
  	cpu2: {1,104,0,0,0}
  	cpu3: {0,0,0,0,0}
  }

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/btf.h        |  1 +
 kernel/bpf/btf.c           | 22 +++++++++
 kernel/bpf/local_storage.c | 93 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index b98405a56383..a4cf075b89eb 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -47,6 +47,7 @@ void btf_type_seq_show(const struct btf *btf, u32 type_id, void *obj,
 int btf_get_fd_by_id(u32 id);
 u32 btf_id(const struct btf *btf);
 bool btf_name_offset_valid(const struct btf *btf, u32 offset);
+bool btf_type_is_reg_int(const struct btf_type *t, u32 expected_size);
 
 #ifdef CONFIG_BPF_SYSCALL
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e0a827f95e19..804ab24283f6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -514,6 +514,28 @@ static bool btf_type_int_is_regular(const struct btf_type *t)
 	return true;
 }
 
+/*
+ * Check that given type is a regular int and has the expected size.
+ */
+bool btf_type_is_reg_int(const struct btf_type *t, u32 expected_size)
+{
+	u8 nr_bits, nr_bytes;
+	u32 int_data;
+
+	if (!btf_type_is_int(t))
+		return false;
+
+	int_data = btf_type_int(t);
+	nr_bits = BTF_INT_BITS(int_data);
+	nr_bytes = BITS_ROUNDUP_BYTES(nr_bits);
+	if (BITS_PER_BYTE_MASKED(nr_bits) ||
+	    BTF_INT_OFFSET(int_data) ||
+	    nr_bytes != expected_size)
+		return false;
+
+	return true;
+}
+
 __printf(2, 3) static void __btf_verifier_log(struct bpf_verifier_log *log,
 					      const char *fmt, ...)
 {
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index b65017dead44..5eca03da0989 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -1,11 +1,13 @@
 //SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf-cgroup.h>
 #include <linux/bpf.h>
+#include <linux/btf.h>
 #include <linux/bug.h>
 #include <linux/filter.h>
 #include <linux/mm.h>
 #include <linux/rbtree.h>
 #include <linux/slab.h>
+#include <uapi/linux/btf.h>
 
 DEFINE_PER_CPU(struct bpf_cgroup_storage*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
 
@@ -308,6 +310,94 @@ static int cgroup_storage_delete_elem(struct bpf_map *map, void *key)
 	return -EINVAL;
 }
 
+static int cgroup_storage_check_btf(const struct bpf_map *map,
+				    const struct btf *btf,
+				    const struct btf_type *key_type,
+				    const struct btf_type *value_type)
+{
+	const struct btf_type *t;
+	struct btf_member *m;
+	u32 id, size;
+
+	/* Key is expected to be of struct bpf_cgroup_storage_key type,
+	 * which is:
+	 * struct bpf_cgroup_storage_key {
+	 *	__u64	cgroup_inode_id;
+	 *	__u32	attach_type;
+	 * };
+	 */
+
+	/*
+	 * Key_type must be a structure with two fields.
+	 */
+	if (BTF_INFO_KIND(key_type->info) != BTF_KIND_STRUCT ||
+	    BTF_INFO_VLEN(key_type->info) != 2)
+		return -EINVAL;
+
+	/*
+	 * The first field must be a 64 bit integer at 0 offset.
+	 */
+	m = (struct btf_member *)(key_type + 1);
+	if (m->offset)
+		return -EINVAL;
+	id = m->type;
+	t = btf_type_id_size(btf, &id, NULL);
+	size = FIELD_SIZEOF(struct bpf_cgroup_storage_key, cgroup_inode_id);
+	if (!t || !btf_type_is_reg_int(t, size))
+		return -EINVAL;
+
+	/*
+	 * The second field must be a 32 bit integer at 64 bit offset.
+	 */
+	m++;
+	if (m->offset != offsetof(struct bpf_cgroup_storage_key, attach_type) *
+	    BITS_PER_BYTE)
+		return -EINVAL;
+	id = m->type;
+	t = btf_type_id_size(btf, &id, NULL);
+	size = FIELD_SIZEOF(struct bpf_cgroup_storage_key, attach_type);
+	if (!t || !btf_type_is_reg_int(t, size))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void cgroup_storage_seq_show_elem(struct bpf_map *map, void *_key,
+					 struct seq_file *m)
+{
+	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+	int cpu;
+
+	rcu_read_lock();
+	storage = cgroup_storage_lookup(map_to_storage(map), key, false);
+	if (!storage) {
+		rcu_read_unlock();
+		return;
+	}
+
+	btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
+	stype = cgroup_storage_type(map);
+	if (stype == BPF_CGROUP_STORAGE_SHARED) {
+		seq_puts(m, ": ");
+		btf_type_seq_show(map->btf, map->btf_value_type_id,
+				  &READ_ONCE(storage->buf)->data[0], m);
+		seq_puts(m, "\n");
+	} else {
+		seq_puts(m, ": {\n");
+		for_each_possible_cpu(cpu) {
+			seq_printf(m, "\tcpu%d: ", cpu);
+			btf_type_seq_show(map->btf, map->btf_value_type_id,
+					  per_cpu_ptr(storage->percpu_buf, cpu),
+					  m);
+			seq_puts(m, "\n");
+		}
+		seq_puts(m, "}\n");
+	}
+	rcu_read_unlock();
+}
+
 const struct bpf_map_ops cgroup_storage_map_ops = {
 	.map_alloc = cgroup_storage_map_alloc,
 	.map_free = cgroup_storage_map_free,
@@ -315,7 +405,8 @@ const struct bpf_map_ops cgroup_storage_map_ops = {
 	.map_lookup_elem = cgroup_storage_lookup_elem,
 	.map_update_elem = cgroup_storage_update_elem,
 	.map_delete_elem = cgroup_storage_delete_elem,
-	.map_check_btf = map_check_no_btf,
+	.map_check_btf = cgroup_storage_check_btf,
+	.map_seq_show_elem = cgroup_storage_seq_show_elem,
 };
 
 int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
-- 
2.19.2

