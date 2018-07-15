Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6468FECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A3B2089E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pq8rbZFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A3B2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeGOJHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:07:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41059 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeGOJHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:07:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id z8-v6so4918380pgu.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ke5mcxjc1p1i6LwnE9uo00I/PSLCh0+m5j2RKzMGdP4=;
        b=Pq8rbZFZhvSYWBgVY4oSzTXFuDVax6VMPjIGo+alqGquNNJbFkpojl4wou9/omy7vj
         h7Olt/uu9HmMa9bNBukaVdlxieJnIoF0Yq4TXgKoTYz1YrwZi+9mvZlV123QoDUBXy63
         BkfgO9ti6PSGJHsoHaOAXSitHZg8+CRL7SwI4zj527ChYmebp9+qgBDRplcIPBNbtpbl
         MsQj/lNyYoNVDxcR/51N8v8menYqK2LWHPsPZ/Aa93RvhBktJ8JeprZlx+Lk8nUF/uE6
         z/gMM4uFyrd7ICyThiKZ1om8sF7WOb16sMqiskBRtVjScwjCMlwqUf+2/v49ajBScQNE
         OduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ke5mcxjc1p1i6LwnE9uo00I/PSLCh0+m5j2RKzMGdP4=;
        b=RW1goOf/WHf4pkXbQJ5wWrGbrXOt/hrmOlMy6BM1ro3Q90CMXRavHjYApCZmfvUPej
         OLLuQy67PCyfuaS+5qcyK0Rz3KxVRSAWe5aoBKiKCns9yWi8N8kNcEKY8LWXCIWMpbhV
         0zYwjIWXUG+KVIWdR9h8TMObxPEUk283hsOZurPhyai2XkEd1SwdfsQK2OikBVKEY+rV
         e5WKocIXR3z8fZuKJNuQsieVGKpKvEkGQ8LXh9DhAeyfoxKWOVASCCWeErNhZkFcxOxl
         hgyvYkrVEv+Th7N5U1BfZTefRVvqzXFEF97xWzmbfBs0akN9iR0ifuHkFWfr7Yvujbnq
         yOlQ==
X-Gm-Message-State: AOUpUlEuqeGcj7cYviFFptB2yeM4ZW7lFcExGHedmg6d4uxxjmgSwO+p
        R1ZuzdzgJcHIy8l11Q04lWZcnnPXhsA=
X-Google-Smtp-Source: AAOMgpdotRJHkrfC7rJ468FoI3qwCJJXPAMkg3PRhphkdOHwQ8X2z6NYE+JOmji7ZTu1JaTnfqS3iA==
X-Received: by 2002:a62:4add:: with SMTP id c90-v6mr13792525pfj.23.1531644326811;
        Sun, 15 Jul 2018 01:45:26 -0700 (PDT)
Received: from localhost ([2620:15c:2c4:201:eb53:1b1b:5cf2:c15b])
        by smtp.gmail.com with ESMTPSA id a17-v6sm29789370pfg.106.2018.07.15.01.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 01:45:26 -0700 (PDT)
From:   Eddie Hao <eddieh@google.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie Hao <eddieh@google.com>
Subject: [PATCH] bpf: allow BPF programs access skb_shared_info->gso_segs field
Date:   Sun, 15 Jul 2018 01:45:24 -0700
Message-Id: <20180715084524.181717-1-eddieh@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the ability to read gso_segs from a BPF program. This is useful
for user space monitoring systems to get gso_segs statistics for each
arbitrary group of flows defined by the BPF program.

Signed-off-by: Eddie Hao <eddieh@google.com>
---
 include/uapi/linux/bpf.h | 1 +
 net/core/filter.c        | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b7db3261c62d..282085445616 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2266,6 +2266,7 @@ struct __sk_buff {
 	/* ... here. */
 
 	__u32 data_meta;
+	unsigned short gso_segs;
 };
 
 struct bpf_tunnel_key {
diff --git a/net/core/filter.c b/net/core/filter.c
index b9ec916f4e3a..f17e249f3fbb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5820,6 +5820,15 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 				      bpf_target_off(struct sock_common,
 						     skc_num, 2, target_size));
 		break;
+
+	case offsetof(struct __sk_buff, gso_segs):
+		BUILD_BUG_ON(FIELD_SIZEOF(struct skb_shared_info, gso_segs) !=
+					  sizeof(unsigned short));
+		off = offsetof(struct sk_buff, end);
+		off += offsetof(struct skb_shared_info, gso_segs);
+		*insn++ = BPF_LDX_MEM(BPF_SIZEOF(unsigned short), si->dst_reg,
+						 si->src_reg, off);
+		break;
 	}
 
 	return insn - insn_buf;
-- 
2.18.0.203.gfac676dfb9-goog

