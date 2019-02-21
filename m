Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D35FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF162083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO4fYVKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfBUQkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:40:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44624 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:40:04 -0500
Received: by mail-ed1-f65.google.com with SMTP id b20so23652129edw.11;
        Thu, 21 Feb 2019 08:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oUUaNAWEKXrWA7CoHeNhBNEez01JJHhKBXSilmyhjWs=;
        b=NO4fYVKxyeeUhgIoi8vqdB4NkFgwSomvUrr9AkFH/rXUB9MW9c1tHnFfqBG2ykiCrD
         KHnQ5GIlYM41O0CiFNDzNs136ffGIp3yekrFQoEygo6TtXjRzDx7RtgMkjj9nWTYM+rx
         yHK3GzxWFnp8MCvPinGF/JSIwSKFAYy5crqJQXDX85AWXwjnajxdTuOfelCst8gzKriO
         ESCHIftAB7H8N6lX4pVly32OunXeBCTdZ8Mpxm2zbH9V39m9KjhJ6tRsMjhTtHJWo16K
         kFyTJyWzvFKQO/cnXnUSz07pNJTEUVyYmeGlpgudhKz3qO5fAnw1B949lYophKxZiCcl
         8avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=oUUaNAWEKXrWA7CoHeNhBNEez01JJHhKBXSilmyhjWs=;
        b=eAytoVd3bJ9FTiBTY7A768WvfT4sA1SkkEOXPtPPIwmkBhSobjUGoF8To0sMAQ51Qz
         04N1iY4STFygX9pMZCTE2Unv3YeifRHHfzDqLoHIaSc19yO9NgJwAIy/jdATa5V3nyVg
         i8Q+G1VqFd/rqa0ye53Ez0bAEz44qvsSun7tj5sKwqyKIsWOTjXTsUfCFi/p4d9UJyEP
         Ujj/CfoPYkSS9J6LQSmkVykA+nyJZ0ehXFIauU7Zx63J5iWBr/6eLYvBgZEk6pUqipOd
         cq9K2jMxzhloTS+r+ROrDnK/9bzn4AfOxUXhl0jFwxY6Wwia5YexVEq5Ex/Qt78AlMsy
         B0jA==
X-Gm-Message-State: AHQUAub3Hxe0xirsbljD6tgRJGhhniCY5Ll2KEiOfuxqXyQNKdFRmVxg
        PDzvA1Q61dKYnaGkdEpI2emxt4MI0N4=
X-Google-Smtp-Source: AHgI3IbMgJNMAfNUCjv6imcLjd05phMBrF+Z4V9s8HgSFC2/ezNuI5BgW3mQoWZssiMVzDD6hvJayg==
X-Received: by 2002:a50:a978:: with SMTP id m53mr2558048edc.178.1550767202394;
        Thu, 21 Feb 2019 08:40:02 -0800 (PST)
Received: from localhost.localdomain (ip5b402483.dynamic.kabel-deutschland.de. [91.64.36.131])
        by smtp.gmail.com with ESMTPSA id b29sm4620061eda.48.2019.02.21.08.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 08:40:01 -0800 (PST)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v1] bpf, lpm: fix lookup bug in map_delete_elem
Date:   Thu, 21 Feb 2019 17:39:26 +0100
Message-Id: <20190221163926.15221-1-alban@kinvolk.io>
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

Signed-off-by: Alban Crequy <alban@kinvolk.io>
---
 kernel/bpf/lpm_trie.c | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.20.1

