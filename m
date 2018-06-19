Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35206C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CE620661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEnr4aaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CE620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967172AbeFSTV6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:21:58 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46645 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966263AbeFSTV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:21:57 -0400
Received: by mail-pg0-f68.google.com with SMTP id d2-v6so300093pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ErM6exH4CZg9YGfbDH+JQKCWehkVeHH+tKVazVn5+GI=;
        b=TEnr4aaGZvUMWuioyjqZ8noBy5X7j6NpJS7TeTAps0pXGSwQ8aKwptjv+g5GGv+Oea
         gPtCdyHnLL0EmbmpRNo4/8q4higSuSG6HQbOJzOyF6LNGIy1NCphpSfzrhYPYknNLPwl
         upAbPWAzU+rO+cTozOfE5uV81n5lu8yorwXkejfPkZ+INrn7tGAttlCCF5lSqlVebsyU
         tWg9VZzELVISTs/4kNheVWeDtxp01bTf7FcYFWfHp0eWuZzYIPqcpZyt6NeCV2VEKkbm
         FiYzsMvdpTzVxbSF6gVOlDW4OseDbrwWeJiTjlASbPd2TDSc39PJSv2jPLcdgFwS6ayW
         3Jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ErM6exH4CZg9YGfbDH+JQKCWehkVeHH+tKVazVn5+GI=;
        b=ZxsX9HbjSUTZKGFSnYQ6Bs6pNWG2MG4yV9qaQJyK7wBEzgTYqx9W9P3R8wdmhoYT0g
         AqoiGlp6JINslQppXpuU2II8Wu9ksunlWbYPkAbJp3OU2L6x7xXrAJhyNNHrZMVRzmjw
         ++QsOWNUZj8dvq9iRBX1PJKs28u7HRvmB3b0E42Jnr7UKxPnP+fGwdO/SYmI/4n2XKWP
         c/FfI8Cy3iZFGxa9c8tpx8fjr0jJvhr/Zy7Jkb5y8BZnxqR961q4aQhCpC0ly9yVl/Ty
         nWT9JaeTxXQXrdyX7P/Bw1Ir2EpBKO70YQuaDLyvtERwNzEfugfaNu+pD5QDkyvGL3tK
         PrFw==
X-Gm-Message-State: APt69E1KZJKe3pPel5EpK8AELi8RMSSuJ0uNWb7gDHJy1QRWtNR9pz5m
        ix1hJWZdLXWn7ghjWI1HqqnO/A==
X-Google-Smtp-Source: ADUXVKJhMc5dFkrETyHJxzXq8pnYnDGPnWtchZdFpsXM1d0BN88TiaZ7dR9DkVqecmZL/M2ZL4mv/Q==
X-Received: by 2002:a62:e816:: with SMTP id c22-v6mr19270092pfi.124.1529436115786;
        Tue, 19 Jun 2018 12:21:55 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id z19-v6sm440007pfe.163.2018.06.19.12.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:21:54 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, aryabinin@virtuozzo.com,
        Alexander Potapenko <glider@google.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: Possible regression in "slab, slub: skip unnecessary kasan_cache_shutdown()"
Date:   Tue, 19 Jun 2018 12:21:39 -0700
Message-Id: <20180619192139.31781-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <CAHmME9q7aKGNiYauCjyy6Fu+bryPphEoLEMbAObTJgTrTfS2uw@mail.gmail.com>
References: <CAHmME9q7aKGNiYauCjyy6Fu+bryPphEoLEMbAObTJgTrTfS2uw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 8:19 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Tue, Jun 19, 2018 at 5:08 PM Shakeel Butt <shakeelb@google.com> wrote:
> > > > Are you using SLAB or SLUB? We stress kernel pretty heavily, but with
> > > > SLAB, and I suspect Shakeel may also be using SLAB. So if you are
> > > > using SLUB, there is significant chance that it's a bug in the SLUB
> > > > part of the change.
> > >
> > > Nice intuition; I am indeed using SLUB rather than SLAB...
> > >
> >
> > Can you try once with SLAB? Just to make sure that it is SLUB specific.
>
> Sorry, I meant to mention that earlier. I tried with SLAB; the crash
> does not occur. This appears to be SLUB-specific.

Jason, can you try the following patch?

---
 mm/slub.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index a3b8467c14af..746cfe4515c2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3673,9 +3673,17 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 
 bool __kmem_cache_empty(struct kmem_cache *s)
 {
+	int cpu;
 	int node;
 	struct kmem_cache_node *n;
 
+	for_each_online_cpu(cpu) {
+		struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
+
+		if (c->page || slub_percpu_partial(c))
+			return false;
+	}
+
 	for_each_kmem_cache_node(s, node, n)
 		if (n->nr_partial || slabs_node(s, node))
 			return false;
-- 
2.18.0.rc1.244.gcf134e6275-goog

