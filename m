Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF96C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BEA2081C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCIbomH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BEA2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLHAxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:53:37 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55897 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbeLHAxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:53:31 -0500
Received: by mail-it1-f194.google.com with SMTP id o19so9644009itg.5;
        Fri, 07 Dec 2018 16:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYjictBvToDP2fG683ft+LFjqnfwpgL77qtlsL3PEVs=;
        b=FCIbomH5kefjW38yGhMlSdZk7n2OhyZPZ/N3UeS+NLQZgvpaF7I3Hd/aW4FDPMWroK
         S8ZXeqN6LLeqKAAy8y55XFhakX9riCw4htnf+lIwCKwbN4UZ+dQtCu7y7weEYwzBl8Bc
         eDSOLL4Y9m9uw/T8yfKGiJDAtfFFd0LIdD/pvrM2IKjOk5AJfrEhA3aNqnS0qCBIGZ3W
         xO3x9XjNFX5xuw4okMCWk8ffwRcl+8XU7TN6woVMFwIL7a+klle2r9DpBRzKSFTmCqoL
         MVsApGF7wSH4m/m76tncEYe3dY6GZwsu43egigp6xC7DD/27xTzrMCYu9ERvnerjXbPB
         7Ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYjictBvToDP2fG683ft+LFjqnfwpgL77qtlsL3PEVs=;
        b=I9w2FWq0Ew9iok07v39djcS6W8RtfEhe+68cDGcz63ldmkbEkd6admetcyGnqs3+VB
         SUZ2fV/olmb6ehqvzqxVsIOR9/wFN8DoSoAwHRRocqpGiMAC0uVPKMNLSF6LiVgcZMJ0
         AgsONKFFpOvd5XNSL2gKZYuB+8dVnrDVC2imMLkp82fUg1MlFZV8uBX15xH8BA6RpTlK
         kwKR8z5InaN13PPfXeP0XqhAUmG/7Qq9F86wj4vzKqRMxLCUNqlUqMEHTdl8z8YN1WBE
         kdiren6ZsdfuVNkHyBPdbTtrq70azOo/xzjCVm/lR59XOqJklZJMIdyLXpKdoPcSR0Ae
         rpzw==
X-Gm-Message-State: AA+aEWbxZu+N1+vDCETNzhzrUHysFJ61jxZfHiPQH6YrqXzm2y5O5hjU
        oBvcMGt7VYHP/i8s94MbSD6FHlKdfXI=
X-Google-Smtp-Source: AFSGD/VJU//1UdxYyZd9aMwRpFMvNfdBLW3oAEbAhf9J/rw0cFyzKqTn2uIDE8Fz9kEGg697IIihzw==
X-Received: by 2002:a05:660c:5d4:: with SMTP id x20mr3911050itk.143.1544230410073;
        Fri, 07 Dec 2018 16:53:30 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::6:9a2e])
        by smtp.gmail.com with ESMTPSA id 21sm2069769iou.79.2018.12.07.16.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 16:53:29 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     netdev@vger.kernel.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 2/3] bpf: add bpffs pretty print for cgroup local storage maps
Date:   Fri,  7 Dec 2018 16:53:14 -0800
Message-Id: <20181208005315.3500-2-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208005315.3500-1-guro@fb.com>
References: <20181208005315.3500-1-guro@fb.com>
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
 include/linux/btf.h        | 10 +++++
 kernel/bpf/local_storage.c | 90 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 8c2199b5d250..ac67bc4cbfd9 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -5,6 +5,7 @@
 #define _LINUX_BTF_H 1
 
 #include <linux/types.h>
+#include <uapi/linux/btf.h>
 
 struct btf;
 struct btf_type;
@@ -63,4 +64,13 @@ static inline const char *btf_name_by_offset(const struct btf *btf,
 }
 #endif
 
+static inline const struct btf_type *btf_orig_type(const struct btf *btf,
+						   const struct btf_type *t)
+{
+	while (t && BTF_INFO_KIND(t->info) == BTF_KIND_TYPEDEF)
+		t = btf_type_by_id(btf, t->type);
+
+	return t;
+}
+
 #endif
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index b65017dead44..7b51fe1aba3c 100644
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
 
@@ -308,6 +310,91 @@ static int cgroup_storage_delete_elem(struct bpf_map *map, void *key)
 	return -EINVAL;
 }
 
+static int cgroup_storage_check_btf(const struct bpf_map *map,
+				    const struct btf *btf,
+				    const struct btf_type *key_type,
+				    const struct btf_type *value_type)
+{
+	const struct btf_type *st, *t;
+	struct btf_member *m;
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
+	 * Key_type must be a structure (or a typedef of a structure) with
+	 * two members.
+	 */
+	st = btf_orig_type(btf, key_type);
+	if (BTF_INFO_KIND(st->info) != BTF_KIND_STRUCT ||
+	    BTF_INFO_VLEN(st->info) != 2)
+		return -EINVAL;
+
+	/*
+	 * The first field must be a 64 bit integer at 0 offset.
+	 */
+	m = (struct btf_member *)(st + 1);
+	t = btf_orig_type(btf, btf_type_by_id(btf, m->type));
+	if (!t || BTF_INFO_KIND(t->info) != BTF_KIND_INT || m->offset ||
+	    t->size !=
+	    FIELD_SIZEOF(struct bpf_cgroup_storage_key, cgroup_inode_id))
+		return -EINVAL;
+
+	/*
+	 * The second field must be a 32 bit integer at 0 offset.
+	 */
+	m = m + 1;
+	t = btf_orig_type(btf, btf_type_by_id(btf, m->type));
+	if (!t || BTF_INFO_KIND(t->info) != BTF_KIND_INT ||
+	    m->offset != offsetof(struct bpf_cgroup_storage_key, attach_type) *
+	    BITS_PER_BYTE || t->size !=
+	    FIELD_SIZEOF(struct bpf_cgroup_storage_key, attach_type))
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
@@ -315,7 +402,8 @@ const struct bpf_map_ops cgroup_storage_map_ops = {
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

