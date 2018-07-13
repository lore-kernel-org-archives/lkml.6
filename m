Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E10ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8C320870
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5wRceQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8C320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeGMWiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:38:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44003 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeGMWiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:38:54 -0400
Received: by mail-pf0-f195.google.com with SMTP id y8-v6so23358519pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uBvK+CpFVs8tPczYSr3WG/TRHUUD6mG9sr52JxtA/is=;
        b=i5wRceQS0RAlhBpEBhaXVNKGYkgIsB8mDvIcn6vLh1iE8IYadpSgpasNACm2i0Se/v
         Me12G67SriCbVXDoNyoAuwXsMazGnhtOquTLd3O+SKp/BKPNJ57C5zGifUz/lzPGdmLj
         ZnRwYtC0LDZX01AxXlertUpVyqBKOFsvOrW7+lPfXWlZqUR23vAbmjsEqer4tseQg1YO
         zMcXfkY/skCa2YZSZ0Zw9kCFSMKNLIYPmqnXrEa6YqXok7sp5uK9v/R3V25g3iZa/CCq
         MtuPGBR2UqMOeFAbzCteFjy6kxEjH0dFkkz4UC4OHiSmHCGNHAbIoMd+DvGMcQAfOPw3
         ID/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uBvK+CpFVs8tPczYSr3WG/TRHUUD6mG9sr52JxtA/is=;
        b=rzNT7JGJmeHVyScY7zgWSWTzvMuK7F1MEfDYekZbyA0j1KBsANyAqHzef2wRK1OS38
         nu4VQGQOfWwZS2A+N5MYcdJjRrYkwnBODTp62VZeVjZ0toSDr1/r48fzfy943TWtwZeZ
         UXjPNLcIdILYCduY3yvoBEBOaCTu3eNRIoVfc2uk7aVjOGoy4I9x4U+jhsUg75oac7tw
         oFf82Hi7Sle9JED8bXzliPYk+YjIrepJYv/sY/MUim4uzH2veO++OMdsLn6pPLj+abYs
         botpmlqEWpZbn9am9EYVMJajnd81rOX6o66IJ0rqcSD6P5XUE3fR9mSydZ99BI6MOPR0
         bDDA==
X-Gm-Message-State: AOUpUlEojUtTPAQZGVUL6WwDm1LPonaTDF/xnsbHhXIixRd6ifiCAwE4
        McLv8i39btKjx2XhlPCUCx0Hcw==
X-Google-Smtp-Source: AAOMgpfne10IGF47qH0p95fHys82Welp/RMD0GbHoqr5MqlLCltTOvPmiF/sNTh/TovNzAV7X/C5Kw==
X-Received: by 2002:a62:6303:: with SMTP id x3-v6mr8861999pfb.91.1531520539210;
        Fri, 13 Jul 2018 15:22:19 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v22-v6sm50750888pfi.60.2018.07.13.15.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 15:22:18 -0700 (PDT)
Date:   Fri, 13 Jul 2018 15:22:17 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     ufo19890607@gmail.com
cc:     akpm@linux-foundation.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian@didichuxing.com
Subject: Re: [PATCH v13 2/2] Add oom victim's memcg to the oom context
 information
In-Reply-To: <1531482952-4595-1-git-send-email-ufo19890607@gmail.com>
Message-ID: <alpine.DEB.2.21.1807131521030.202408@chino.kir.corp.google.com>
References: <1531482952-4595-1-git-send-email-ufo19890607@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018, ufo19890607@gmail.com wrote:

> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 531b2c86d4db..7fbd389ea779 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -434,10 +434,11 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>  			oom_constraint_text[oc->constraint],
>  			nodemask_pr_args(oc->nodemask));
>  	cpuset_print_current_mems_allowed();
> +	mem_cgroup_print_oom_context(oc->memcg, p);
>  	pr_cont(",task=%s,pid=%5d,uid=%5d\n", p->comm, p->pid,
>  		from_kuid(&init_user_ns, task_uid(p)));
>  	if (is_memcg_oom(oc))
> -		mem_cgroup_print_oom_info(oc->memcg, p);
> +		mem_cgroup_print_oom_meminfo(oc->memcg);
>  	else {
>  		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
>  		if (is_dump_unreclaim_slabs())

Ugh, could we please not pad the pid and uid with spaces?  I don't think 
it achieves anything and just makes regex less robust.

Otherwise, looks good!
