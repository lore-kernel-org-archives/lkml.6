Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A54C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607612175F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UUeE535Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607612175F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbeGDBev (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 21:34:51 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38484 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932364AbeGDBeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 21:34:50 -0400
Received: by mail-pf0-f194.google.com with SMTP id j17-v6so1836987pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 18:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uyiqE6wSM43Y9Oisrog8zs9G/dKKyZrIsJr2kjVewZ8=;
        b=UUeE535Q+tRn74MFDbtpi1w426VPbDs37AEh97+YyW7PwjxiaOGBTY9vPG7vgcLpuR
         vriZ+vdvj+cIXPLbTz67rCWDRE54GabXAYahfEGMz8mDcTCOPlgVNoVJBB9qRaM0ghaj
         Ofz9D2mtMGd4NpOmaBzgHV9wX81J9Bm0SChUM1VXtRWpi4KBrmA49aQWwwItjYpL+/vH
         CGEsDar+xbGI7WicJK6CLHkhce5AsdpES1KfW2tmIVFBi/KbtZDOmXBgVTNqVU4Sn00e
         rr9hjaP10yeLsmfetyi+z2Wwweu5v1rGoJ/JRPHj70LaXoFfoZC3043coE/KDKepVjb9
         mkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uyiqE6wSM43Y9Oisrog8zs9G/dKKyZrIsJr2kjVewZ8=;
        b=lUUa6CmglYOTIZdbLruOQoHjjxjNDiNMsZMycAvjTYC9Z4u+YNKHEY/RqX7WOlmxPT
         SdEoHucaeT/PlObqpf7Yw+Q80WEL+jd9AnN3nDpnBSEQB1iuqTszFu5RdKYrXatpYuSG
         oPfwOc6BcvdNxCWQL4Gji3jCGUufDk0Ksp+MESogO4v1ATmoy6DRNzLFwauo/R0LxCuM
         1n7W/2oma0IuaW2jcKA7vFb91hviKlUtsB1GJX1n7OnwBHHYlzrseugQ2jxb6RlGMaQR
         vXajIUA/JpVFcb/oqk40uiOoWIpLc8NKmidjAlwtvLS5FAPgMJAw/c3yI5E2RwtEx6aJ
         xBwA==
X-Gm-Message-State: APt69E3iYEaPfS7dIVQhXQz3i3XvHV2HhnFGJxQdrpNnfqwhABE1L3j+
        B1jaEtXapYTLBED2F0tvZy5quQ==
X-Google-Smtp-Source: AAOMgpfZ8XoydyDZ9ej7M1yneoyAii1Cmh98yphMGleDgZJzcgaDrUOu8IcjQVdp2aktQgvrq487Xw==
X-Received: by 2002:a63:26c3:: with SMTP id m186-v6mr61443pgm.56.1530668089401;
        Tue, 03 Jul 2018 18:34:49 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d188-v6sm4285065pfc.96.2018.07.03.18.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 18:34:48 -0700 (PDT)
Date:   Tue, 3 Jul 2018 18:34:48 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Rodrigo Freire <rfreire@redhat.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: be more informative in OOM task list
In-Reply-To: <7de14c6cac4a486c04149f37948e3a76028f3fa5.1530461087.git.rfreire@redhat.com>
Message-ID: <alpine.DEB.2.21.1807031832540.110853@chino.kir.corp.google.com>
References: <7de14c6cac4a486c04149f37948e3a76028f3fa5.1530461087.git.rfreire@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jul 2018, Rodrigo Freire wrote:

> The default page memory unit of OOM task dump events might not be
> intuitive for the non-initiated when debugging OOM events. Add
> a small printk prior to the task dump informing that the memory
> units are actually memory _pages_.
> 
> Signed-off-by: Rodrigo Freire <rfreire@redhat.com>
> ---
>  mm/oom_kill.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 84081e7..b4d9557 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -392,6 +392,7 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
>  	struct task_struct *p;
>  	struct task_struct *task;
>  
> +	pr_info("Tasks state (memory values in pages):\n");
>  	pr_info("[ pid ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
>  	rcu_read_lock();
>  	for_each_process(p) {

As the author of dump_tasks(), and having seen these values misinterpreted 
on more than one occassion, I think this is a valuable addition.

Could you also expand out the "pid" field to allow for seven digits 
instead of five?  I think everything else is aligned.

Feel free to add

Acked-by: David Rientjes <rientjes@google.com>

to a v2.
