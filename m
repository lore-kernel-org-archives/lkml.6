Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15332C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D320421780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j996MWPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D320421780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbeKOEFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:05:01 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41400 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKOEFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:05:01 -0500
Received: by mail-io1-f66.google.com with SMTP id s22so504657ioc.8;
        Wed, 14 Nov 2018 10:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QzUGctcKkN3Yox3+qg/RJuYjGh7fVIBul+U6Le4fp3A=;
        b=j996MWPEOXArZ5BvQBnoOmhuW7C1W35FrPh4kU53JE6sTL48tFRVw33vvr7PJ/CbnU
         WC7aCbjqj90smMg5P59M89yCCf/dqqw4veDluvSKgs4vIoDWafKaYa1AsLgwMApTI4+L
         YU6iwFrYcPscUCbSz5wB4IWzksD0yZeZ9Uq2qAp9mru63msikgA5XcHQBBSoLnZaOTTr
         vQVE0jP0U6t3Q7mMI4LVYToQa7KOl2gZB7A5dglIgdHobrU/0QYEKxbP8L/KAQRX0ht9
         QlFDCFUYfOX+LFnDGN2pJ7HmAiDfFf2llGfqQNUy/yfldqw3+4JkQXHaGiTPzf/1M+Ve
         7ROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QzUGctcKkN3Yox3+qg/RJuYjGh7fVIBul+U6Le4fp3A=;
        b=hx9JpMBvpt36HNpFyPXhjzj8j7GkGulqn6ZPe3QlAHIXSejtSnLGtzlZ3Bu7z32umP
         t0IqT6k0YU5V7vgxtNKZ1b3qkICp7f49nDpKtgyrwVoRHKMU1HHOGz8ZgdzXe/Uh+hVc
         Mthbe0W3j4TiSCdUZHgOASWHGqzEBB0IW1hzWxawYtNU6OI/ZVR/7GkjyiyGB8myg4d7
         lTPltX6HnLSKAH+5e8eoXSkBrIzdF4bvMf8rCM7fBQWNYdu4o2h3DLrPAg7Zexlw28GH
         mnbHEHKN9z1fTCd5JWQ9DosFvvf0tc5lHLr0s/OAh1LzKEP1DoztKTkQvH53FGgM0TXu
         qHTQ==
X-Gm-Message-State: AGRZ1gIcBQYcCw4xQIhKAyLv0vmrDI5dtMAX/3mpTlUyJfhqK1oFMlpU
        FhdftoO1ieof6OrwUo3KLYM64wExmDM=
X-Google-Smtp-Source: AFSGD/XjOm79F/QxPsrr9QsjgVFlVjch30PRp/FgbcOQFYDenob61yW/lP6hG/5b5vm1mR3bmWmbrA==
X-Received: by 2002:a6b:6f18:: with SMTP id k24mr1621306ioc.236.1542218447677;
        Wed, 14 Nov 2018 10:00:47 -0800 (PST)
Received: from castle.tfbnw.net ([2620:10d:c090:180::1:6f7f])
        by smtp.gmail.com with ESMTPSA id y5sm1125453itb.42.2018.11.14.10.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 10:00:46 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] bpf: allocate local storage buffers using GFP_ATOMIC
Date:   Wed, 14 Nov 2018 10:00:34 -0800
Message-Id: <20181114180034.25558-1-guro@fb.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naresh reported an issue with the non-atomic memory allocation of
cgroup local storage buffers:

[   73.047526] BUG: sleeping function called from invalid context at
/srv/oe/build/tmp-rpb-glibc/work-shared/intel-corei7-64/kernel-source/mm/slab.h:421
[   73.060915] in_atomic(): 1, irqs_disabled(): 0, pid: 3157, name: test_cgroup_sto
[   73.068342] INFO: lockdep is turned off.
[   73.072293] CPU: 2 PID: 3157 Comm: test_cgroup_sto Not tainted
4.20.0-rc2-next-20181113 #1
[   73.080548] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   73.088018] Call Trace:
[   73.090463]  dump_stack+0x70/0xa5
[   73.093783]  ___might_sleep+0x152/0x240
[   73.097619]  __might_sleep+0x4a/0x80
[   73.101191]  __kmalloc_node+0x1cf/0x2f0
[   73.105031]  ? cgroup_storage_update_elem+0x46/0x90
[   73.109909]  cgroup_storage_update_elem+0x46/0x90

cgroup_storage_update_elem() (as well as other update map update
callbacks) is called with disabled preemption, so GFP_ATOMIC
allocation should be used: e.g. alloc_htab_elem() in hashtab.c.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/local_storage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index c97a8f968638..bed9d48a7ae9 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -139,7 +139,8 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
 		return -ENOENT;
 
 	new = kmalloc_node(sizeof(struct bpf_storage_buffer) +
-			   map->value_size, __GFP_ZERO | GFP_USER,
+			   map->value_size,
+			   __GFP_ZERO | GFP_ATOMIC | __GFP_NOWARN,
 			   map->numa_node);
 	if (!new)
 		return -ENOMEM;
-- 
2.17.2

