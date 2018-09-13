Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90486C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 01:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE942146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 01:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="h73uUlN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE942146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeIMGtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 02:49:36 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39459 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeIMGtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 02:49:36 -0400
Received: by mail-qk1-f193.google.com with SMTP id b19-v6so2357787qkc.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 18:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VdZwQEtokhXFqQgOaDWPImZ0OtaxyieFqTEkszsaRkc=;
        b=h73uUlN+s+uj9lboUDoazfMpyclBYHreR+DdmFBGCcQldQ6qq1GYzFwlO35jC9t3fw
         5AQJhYg/xyROkjyljdEJc1gedsHbPUZTHXhge8wdgGJz1SQ9nVzYjjyOESeslkGEmUa2
         C7finErnFH4AZeYTCy9AR28HhFHPE7PLUFC/4yfsWfGL00ViAslKT9WzzHSefDrRzqvm
         7x8RhRmzzypPn49xjDE40/CDGXBCt3omS4IvynzBMl3JpxX62Kh4iZuZqcC2UfgLMxm8
         cSPU3p+DbthbtV9XfbGIiXdm8aJ0VN1tDApLCVav+2uATJHIG8dNrAJYGQfqA6c3lKV4
         yc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VdZwQEtokhXFqQgOaDWPImZ0OtaxyieFqTEkszsaRkc=;
        b=AD/KNR/EFGAAiASuYadHDiHSdbxUSr2ITG7Om6wVE4Kh/8X+s4v2kMJTsu6hf/io8O
         fae9guVNEdBz+Rgt2rP1Jbysw5DLdF1P/OGUxzkIa6zGIUmbeSfms2jGjRk8/r7d0VBD
         x9wJdLoWsE/83uoRox1cPzLLEEmnCcppNFnSK5ds+rihjo/XDjdGwstfNhpyr4iI+i8r
         3HdPUUTzy5ex5L9Dbl0K+VUS0ejSPCymVekuvgH1qU95oTSW1QiocOWSPpXDhdjL198L
         eceFqzeoFhs7IXpUV+pJkVTuQWUgd/0AeE7mnXrfYKpqLAgGf40+vap5dLBKK1Wmtuay
         VwnQ==
X-Gm-Message-State: APzg51C3tNqMivgUtrsfVZD9zFcJl9KFaPyq6REFEzoe6KiWcleK+s9l
        xH+PikJO0AkOmgbBN7/o6uyiLQ==
X-Google-Smtp-Source: ANB0VdbsYU7o2el1561feIeAZ64kvh3VSBllvgOSQ9ByU+sAMUvWfVkOXxfxOHRuFxFmJm8zEFpH/g==
X-Received: by 2002:a37:7fc7:: with SMTP id a190-v6mr3588928qkd.247.1536802943927;
        Wed, 12 Sep 2018 18:42:23 -0700 (PDT)
Received: from localhost (pool-72-69-128-58.nycmny.fios.verizon.net. [72.69.128.58])
        by smtp.gmail.com with ESMTPSA id u38-v6sm1924002qth.67.2018.09.12.18.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 18:42:22 -0700 (PDT)
Date:   Wed, 12 Sep 2018 21:42:22 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Subject: Re: mmotm 2018-09-12-16-40 uploaded (psi)
Message-ID: <20180913014222.GA2370@cmpxchg.org>
References: <20180912234039.Xa5RS%akpm@linux-foundation.org>
 <a9bef471-ac93-2983-618b-ffee65f01e0b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9bef471-ac93-2983-618b-ffee65f01e0b@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thanks for the report.

On Wed, Sep 12, 2018 at 05:45:08PM -0700, Randy Dunlap wrote:
> Multiple build errors when CONFIG_SMP is not set: (this is on i386 fwiw)
> 
> in the psi (pressure) patches, I guess:
> 
> In file included from ../kernel/sched/sched.h:1367:0,
>                  from ../kernel/sched/core.c:8:
> ../kernel/sched/stats.h: In function 'psi_task_tick':
> ../kernel/sched/stats.h:135:33: error: 'struct rq' has no member named 'cpu'
>    psi_memstall_tick(rq->curr, rq->cpu);

This needs to use the SMP/UP config-aware accessor.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---

diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 2e07d8f59b3e..4904c4677000 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -132,7 +132,7 @@ static inline void psi_task_tick(struct rq *rq)
 		return;
 
 	if (unlikely(rq->curr->flags & PF_MEMSTALL))
-		psi_memstall_tick(rq->curr, rq->cpu);
+		psi_memstall_tick(rq->curr, cpu_of(rq));
 }
 #else /* CONFIG_PSI */
 static inline void psi_enqueue(struct task_struct *p, bool wakeup) {}
