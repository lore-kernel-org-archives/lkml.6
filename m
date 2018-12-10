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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7376C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8429D2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiX74oW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8429D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbeLJXnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:43:15 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36336 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLJXnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:43:12 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so848286itj.1;
        Mon, 10 Dec 2018 15:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YG6k1tVFdVgQPRwNjfcZcQUx8EyghPoLGHnjPOBceD8=;
        b=OiX74oW3dCrCNV8RR/35ZIStdll4IboNM2bNq75QxKOnK8KQbeeYsZm2klYVKQwt3A
         Deuwhik/1tQ7wzRtj4FI8eJHaiGvVxoOzKVbhd/lbDN5NoZemmCFNW6SODUe9rPqaUDC
         zNBs3JvXZf3v0JndEbW8aooWlXJdNhKIGrbr0AWYgBYje7tKjWZBR0RDyGcpgij0WMWi
         6Fc0xxlbqBCFF8iSkfHURRBOSjaLOtLcBkkj/a9LkSQQwFjPEshh7TxWLRzlRlqJCwUo
         LJXzGeYzjzh3btuRRDqPWvkB8OaB0H3r88jEc0yEc3IMf4U4lSxFGWE7gRcBySy1YW2V
         NzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YG6k1tVFdVgQPRwNjfcZcQUx8EyghPoLGHnjPOBceD8=;
        b=Ybixgc3pcMfOwCgkDzbfFW2Qb+DnvO6kEMmlCkutOWq48Wtctz4YuFzXQ573quqezV
         aEQeO1nDpTfTh6XE4FpzqAqFIA6XerkbtrIiyxmqNzW453psGTxjEAo6fvkwg4er73Vo
         tg/3khGgiaIaw931OP4sXuoUAvocvA+msKoy1SiQzEdRjKnZp3ww0tb1P5zF1SGt6EZJ
         wG8yabn7+3dXZBwGPoWAtKImASbaXkgNQ4U2SXdcjAFAPvLP+cxxTt5bN252awKZVT/k
         237tXn+mU3Fl1jqrcj0zX2LESOF1g1l7G2nLBZjgT3ZE2p9RdFwO4m/0Ized8vbFTHLI
         ycSg==
X-Gm-Message-State: AA+aEWZBc61Pa1PTvsy+q19feP6yoChm+Q6H7kUH4zlzkm49qo8k8yL1
        F5UdOozBilrYJIZo8GXgJO+DSQdNo/0=
X-Google-Smtp-Source: AFSGD/W9/Sv8Ef8RMCtVNWNVjO1n/kiA68mrexiKc97ddJewy3qUSaCezy4G/PftuWaOMf4XHHFtmg==
X-Received: by 2002:a05:660c:648:: with SMTP id y8mr412244itk.48.1544485389924;
        Mon, 10 Dec 2018 15:43:09 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::4:375a])
        by smtp.gmail.com with ESMTPSA id e68sm625346ite.7.2018.12.10.15.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 15:43:09 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     netdev@vger.kernel.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 1/3] bpf: pass struct btf pointer to the map_check_btf() callback
Date:   Mon, 10 Dec 2018 15:43:00 -0800
Message-Id: <20181210234302.31327-2-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210234302.31327-1-guro@fb.com>
References: <20181210234302.31327-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If key_type or value_type are of non-trivial data types
(e.g. structure or typedef), it's not possible to check them without
the additional information, which can't be obtained without a pointer
to the btf structure.

So, let's pass btf pointer to the map_check_btf() callbacks.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h   | 3 +++
 kernel/bpf/arraymap.c | 1 +
 kernel/bpf/lpm_trie.c | 1 +
 kernel/bpf/syscall.c  | 3 ++-
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0c992b86eb2c..e734f163bd0b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -23,6 +23,7 @@ struct bpf_prog;
 struct bpf_map;
 struct sock;
 struct seq_file;
+struct btf;
 struct btf_type;
 
 /* map is generic key/value storage optionally accesible by eBPF programs */
@@ -52,6 +53,7 @@ struct bpf_map_ops {
 	void (*map_seq_show_elem)(struct bpf_map *map, void *key,
 				  struct seq_file *m);
 	int (*map_check_btf)(const struct bpf_map *map,
+			     const struct btf *btf,
 			     const struct btf_type *key_type,
 			     const struct btf_type *value_type);
 };
@@ -126,6 +128,7 @@ static inline bool bpf_map_support_seq_show(const struct bpf_map *map)
 }
 
 int map_check_no_btf(const struct bpf_map *map,
+		     const struct btf *btf,
 		     const struct btf_type *key_type,
 		     const struct btf_type *value_type);
 
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 24583da9ffd1..25632a75d630 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -382,6 +382,7 @@ static void percpu_array_map_seq_show_elem(struct bpf_map *map, void *key,
 }
 
 static int array_map_check_btf(const struct bpf_map *map,
+			       const struct btf *btf,
 			       const struct btf_type *key_type,
 			       const struct btf_type *value_type)
 {
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index bfd4882e1106..abf1002080df 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -728,6 +728,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 }
 
 static int trie_check_btf(const struct bpf_map *map,
+			  const struct btf *btf,
 			  const struct btf_type *key_type,
 			  const struct btf_type *value_type)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a99a23bf5910..4eb7750cb5c0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -456,6 +456,7 @@ static int bpf_obj_name_cpy(char *dst, const char *src)
 }
 
 int map_check_no_btf(const struct bpf_map *map,
+		     const struct btf *btf,
 		     const struct btf_type *key_type,
 		     const struct btf_type *value_type)
 {
@@ -478,7 +479,7 @@ static int map_check_btf(const struct bpf_map *map, const struct btf *btf,
 		return -EINVAL;
 
 	if (map->ops->map_check_btf)
-		ret = map->ops->map_check_btf(map, key_type, value_type);
+		ret = map->ops->map_check_btf(map, btf, key_type, value_type);
 
 	return ret;
 }
-- 
2.19.2

