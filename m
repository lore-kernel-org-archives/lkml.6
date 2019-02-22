Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB72C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82C32081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEH3hhEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBVNTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:19:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37037 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfBVNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:19:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id m12so1740668edv.4;
        Fri, 22 Feb 2019 05:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHqTCPXdvug5lA59A68yzeo0AQkFEugXyQy7aWtvks0=;
        b=IEH3hhEYyjEB7PY0hJHit2gyESnYXrjJU4Bk+m9lM7UTCh2RjSuyruZUZCB0RP01JJ
         z4E2VpApEDiw4xicWzu8i6Nn9hu/gVJz2zdUpLDVYBjTUFnUZGWZkRZbjEplsVmRU2Ay
         Uz6BGClA5QesR7d/ppQHtXmALXMPLPM65yz+HubvvjOmehk9wfG9DVaSTrc4JnMrdw+1
         wq+kRDu/n9J9/+BP/J3i/dUjhxkM7GdBk1kmexXUi7ohBm/7L3kzR50jFDkTOrsThLWX
         S6fcGazJhh08asQEIBCX/eRy7y/38umDB5vYwUfmegleQqguVaHFQy+RbKfR+0wqK5Ye
         kyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=aHqTCPXdvug5lA59A68yzeo0AQkFEugXyQy7aWtvks0=;
        b=BlI8NWgzfS73vIC2NYDE5s2b/HLXgEIhAOwqHQwoUMeaS2TgsHu8USeslTDFOd8uEQ
         u5nyESmRt4WVQNWnk0F7LgZBJOwXr9fgU0LH6+sDyrugmLVozOaLkErAK35QfrCOAWen
         1ZFHsheHB11FPx0GCaRGpjGbxdsj4LoDXlrQwvfxatcOTeY/ODe1KVelbiKM/3zv/sA5
         D+GrmBISPNqMKyvxVolypoDgnvFJvWQtmzc7eN976CsMRloztSs2rCeAO/8LIETdG8cw
         EPiIvm0O3R/VsaY2MwHgVn7AG3LQocvxRTCL7e1zRodbYbncFa3U9I8yzSS8IskXBfc0
         X5kw==
X-Gm-Message-State: AHQUAuaYGl0WTX90mgPB65wH9TphYraPdCcJcMfirOPE8M7icshuG2pT
        gJGEI2NOpKw1DB9ivg5yiHE=
X-Google-Smtp-Source: AHgI3IYOv4EalwqQJX4KqlvclEArILNjMkZOT04x809eEe5oFqNWloPmXG9fT2Ri+TDchxGi5NLVPg==
X-Received: by 2002:a05:6402:158e:: with SMTP id c14mr3259322edv.218.1550841580272;
        Fri, 22 Feb 2019 05:19:40 -0800 (PST)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id i24sm403288edq.0.2019.02.22.05.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 05:19:39 -0800 (PST)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf v2] bpf, lpm: fix lookup bug in map_delete_elem
Date:   Fri, 22 Feb 2019 14:19:08 +0100
Message-Id: <20190222131908.6207-1-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

trie_delete_elem() was deleting an entry even though it was not matching
if the prefixlen was correct. This patch adds a check on matchlen.

Reproducer:

$ sudo bpftool map create /sys/fs/bpf/mylpm type lpm_trie key 8 value 1 entries 128 name mylpm flags 1
$ sudo bpftool map update pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 aa bb cc dd value hex 01
$ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
key: 10 00 00 00 aa bb cc dd  value: 01
Found 1 element
$ sudo bpftool map delete pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 ff ff ff ff
$ echo $?
0
$ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
Found 0 elements

A similar reproducer is added in the selftests.

Without the patch:

$ sudo ./tools/testing/selftests/bpf/test_lpm_map
test_lpm_map: test_lpm_map.c:485: test_lpm_delete: Assertion `bpf_map_delete_elem(map_fd, key) == -1 && errno == ENOENT' failed.
Aborted

With the patch: test_lpm_map runs without errors.

Fixes: e454cf595853 ("bpf: Implement map_delete_elem for BPF_MAP_TYPE_LPM_TRIE")
Cc: Craig Gallek <kraig@google.com>
Signed-off-by: Alban Crequy <alban@kinvolk.io>

---

Changes v1 to v2:
- add selftest (review from Martin)
- update commitmsg tags (review from Martin)
- rebase on "bpf" tree and test again (review from Martin)
---
 kernel/bpf/lpm_trie.c                      |  1 +
 tools/testing/selftests/bpf/test_lpm_map.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index abf1002080df..93a5cbbde421 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -471,6 +471,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 	}
 
 	if (!node || node->prefixlen != key->prefixlen ||
+	    node->prefixlen != matchlen ||
 	    (node->flags & LPM_TREE_NODE_FLAG_IM)) {
 		ret = -ENOENT;
 		goto out;
diff --git a/tools/testing/selftests/bpf/test_lpm_map.c b/tools/testing/selftests/bpf/test_lpm_map.c
index 147e34cfceb7..02d7c871862a 100644
--- a/tools/testing/selftests/bpf/test_lpm_map.c
+++ b/tools/testing/selftests/bpf/test_lpm_map.c
@@ -474,6 +474,16 @@ static void test_lpm_delete(void)
 	assert(bpf_map_lookup_elem(map_fd, key, &value) == -1 &&
 		errno == ENOENT);
 
+	key->prefixlen = 30; // unused prefix so far
+	inet_pton(AF_INET, "192.255.0.0", key->data);
+	assert(bpf_map_delete_elem(map_fd, key) == -1 &&
+		errno == ENOENT);
+
+	key->prefixlen = 16; // same prefix as the root node
+	inet_pton(AF_INET, "192.255.0.0", key->data);
+	assert(bpf_map_delete_elem(map_fd, key) == -1 &&
+		errno == ENOENT);
+
 	/* assert initial lookup */
 	key->prefixlen = 32;
 	inet_pton(AF_INET, "192.168.0.1", key->data);
-- 
2.20.1

