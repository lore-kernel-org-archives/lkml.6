Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C9BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5836E20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5/T4GfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5836E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeJLS0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:26:30 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:56894 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbeJLS0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:26:30 -0400
Received: by mail-yw1-f73.google.com with SMTP id i79-v6so6813702ywc.23
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iJ0w2QmBeWzzXmgZ7T+6kotO8VQoLq5AqshPrpzTAw8=;
        b=Q5/T4GfTAwtPDbwyWBdriWdM8m2pGkbJshMnLNOatEaEloUfO+3f5+xUvkFo/2VA5q
         vAxF51cFY3HY0cYuQyti3Avrci2kbjpFrULPr07B+ZLVbdfqcJWg7+PzanA3seDtlu4y
         YeSevBmE52zK2m8DTj4RqspkmA2cRvEvGGIip9G7Ppkfg1NfnAe3b3zh9H1Jx07M3SEj
         XXhCvaUaQ/73BaVvGVT/4SHWeujyNCXDAfJPSCcpbQjrr8L1hlKmEzhZfywLzAbLINId
         5Ouh3tutwELqNsYFHHRXahWucR1LqMYwH2swGOEtXVryV2Xua/5bg4VGEsqJqymClunw
         pY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iJ0w2QmBeWzzXmgZ7T+6kotO8VQoLq5AqshPrpzTAw8=;
        b=lHcriVx3CrEeckg1FUHU+YzsZH7bzMJu7aPyh4i5vlNvBb2YsMda1qDTpWxy+JU/A2
         cJCw3UifcFKeMlVfBsPDvKvkREjnSdkXHNdSS66evJRyBi6SpET5qjX+cojzLcxsBK+q
         ch4oE7WjLfQUrEuTh9BMkSo3CUTgs59uztSkTeXKDMQYHW70NWTajg3NpEAmLYua2jlG
         Tc41DcZZ8P6hBN/aRRpXLzvmmTcLb44rJWJPSYkEPjlZOVlqnqSG2cy3zk+gjgCxjMyS
         3Au8fsldOMLumdgj3Dyg+z4QnnuhKenLmyKuqIcUUCMMZE5rz2P9kv7dahMan1xQWEwt
         ekpw==
X-Gm-Message-State: ABuFfohXNhrQ10Fl01/gB0ecmDJqz3JT9BNlsubh6DUEj0znNBDsXJZ9
        y9aBFHiANCQ+iXia9Q+sknuL6+KyWkA=
X-Google-Smtp-Source: ACcGV60goeVbL8P/j6n4P8SSnlaDo9my3oMsw4QaYWQGFwwjgaRrBXRb9WpZ9kl0SsGPJCtKrH2DsG/wFAo=
X-Received: by 2002:a25:844c:: with SMTP id r12-v6mr2984914ybm.35.1539341678744;
 Fri, 12 Oct 2018 03:54:38 -0700 (PDT)
Date:   Fri, 12 Oct 2018 03:54:27 -0700
In-Reply-To: <20180816040145.gqzqicab4s6kcbye@ast-mbp.dhcp.thefacebook.com>
Message-Id: <20181012105427.243779-1-dancol@google.com>
Mime-Version: 1.0
References: <20180816040145.gqzqicab4s6kcbye@ast-mbp.dhcp.thefacebook.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v4] Wait for running BPF programs when updating map-in-map
From:   Daniel Colascione <dancol@google.com>
To:     joelaf@google.com
Cc:     linux-kernel@vger.kernel.org, timmurray@google.com,
        netdev@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The map-in-map frequently serves as a mechanism for atomic
snapshotting of state that a BPF program might record.  The current
implementation is dangerous to use in this way, however, since
userspace has no way of knowing when all programs that might have
retrieved the "old" value of the map may have completed.

This change ensures that map update operations on map-in-map map types
always wait for all references to the old map to drop before returning
to userspace.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 kernel/bpf/syscall.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8339d81cba1d..d7c16ae1e85a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -741,6 +741,18 @@ static int map_lookup_elem(union bpf_attr *attr)
 	return err;
 }
 
+static void maybe_wait_bpf_programs(struct bpf_map *map)
+{
+	/* Wait for any running BPF programs to complete so that
+	 * userspace, when we return to it, knows that all programs
+	 * that could be running use the new map value.
+	 */
+	if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
+	    map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS) {
+		synchronize_rcu();
+	}
+}
+
 #define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
 
 static int map_update_elem(union bpf_attr *attr)
@@ -831,6 +843,7 @@ static int map_update_elem(union bpf_attr *attr)
 	}
 	__this_cpu_dec(bpf_prog_active);
 	preempt_enable();
+	maybe_wait_bpf_programs(map);
 out:
 free_value:
 	kfree(value);
@@ -883,6 +896,7 @@ static int map_delete_elem(union bpf_attr *attr)
 	rcu_read_unlock();
 	__this_cpu_dec(bpf_prog_active);
 	preempt_enable();
+	maybe_wait_bpf_programs(map);
 out:
 	kfree(key);
 err_put:
-- 
2.19.0.605.g01d371f741-goog

