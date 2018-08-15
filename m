Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4309C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EF120C09
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="BY7FZLhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EF120C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbeHOTcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:32:19 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33648 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbeHOTcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:32:19 -0400
Received: by mail-yw1-f66.google.com with SMTP id c135-v6so1278896ywa.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vw8oH0yPD0vgtmJLJkDjGwEryVYk6Pm/sYpfzldQLmQ=;
        b=BY7FZLhhwpiX7FgXINIZJAnAeHNZ1Jvj7o0ZqOi2ubKr1gKayM6Xym5wskmZCAhPgf
         iPKRCsEmwvk7RM8eDFKIokRam+j1IwmUEHS9G81yHmWkg56hAz9rVPDsUEneQZDFkh0W
         0gaDuzDM7/5OnMcXnlNaCEy1tqjMWxiM88ecM5vgutNFY7JqN3zgfoZPW0eqhlLUT5Qh
         PyaWaTgIOOcBSYkAvy4xXoBVNIx3pn7ZQBzyWvEwA2WHPxTW1Bei8Og247fHnPPi/2Qb
         MU1UFhgPw63XzqmhyJxjJPYlqdGm7fGjXBGDcyLZK07qDvMV92C7roR9Pw/hbs7VT+AZ
         MJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vw8oH0yPD0vgtmJLJkDjGwEryVYk6Pm/sYpfzldQLmQ=;
        b=rdsP9+o66q//nJkcaAMpdhSC98zC8EmuYv7sdM9jgt0Pba6lA9v8Ybfe7PF8ourJ+N
         f1d5r5Zr2zB0kvnNumyBiBBufckUsPhfYchFeRSCriOL+JD8yEtxg+3Uopno1MFQbVRd
         hhKfNo0KLLXs1rbpQvyxZAwnZxwPUENiyDgz1whuX7gDJO9wPz+O9qAblq63cNSe7r63
         ZHxEn0Z6KLikB1rJxdqYW9gK97gj1bD6XyA8HagRQjpUADvBk0KkEI6kHaQkeGnVBYAz
         zvzHDYLa4xF7fglxe1YakeTpO73FqUaRoSvyahpLzNnYEthP+J9nVJKM7exlxSMB9ItW
         C1rw==
X-Gm-Message-State: AOUpUlHsHMkU2vHeh8N2xfLrPu+GQ5F7t1gch+o0WNyDGktIIKp3u4GM
        j+xcSo5Jp3A3k7yVDsM/XO6FnQ==
X-Google-Smtp-Source: AA+uWPyHGyQaSv8wgTkdlppW1G5KXghWm9XYkampIxWjNSf5jD8MLY1nh5+jYj+38WYIlE+1zW/KzA==
X-Received: by 2002:a25:addf:: with SMTP id d31-v6mr197706ybe.98.1534351166352;
        Wed, 15 Aug 2018 09:39:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::9380])
        by smtp.gmail.com with ESMTPSA id h65-v6sm9836056ywe.75.2018.08.15.09.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 09:39:25 -0700 (PDT)
Date:   Wed, 15 Aug 2018 12:39:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Michal Hocko <mhocko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
Message-ID: <20180815163923.GA28953@cmpxchg.org>
References: <20180815003620.15678-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815003620.15678-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 05:36:19PM -0700, Roman Gushchin wrote:
> @@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>  		return s->addr;
>  	}
>  
> +	/*
> +	 * Allocated stacks are cached and later reused by new threads,
> +	 * so memcg accounting is performed manually on assigning/releasing
> +	 * stacks to tasks. Drop __GFP_ACCOUNT.
> +	 */
>  	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
>  				     VMALLOC_START, VMALLOC_END,
> -				     THREADINFO_GFP,
> +				     THREADINFO_GFP & ~__GFP_ACCOUNT,
>  				     PAGE_KERNEL,
>  				     0, node, __builtin_return_address(0));
>  
> @@ -246,12 +251,41 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>  #endif
>  }
>  
> +static void memcg_charge_kernel_stack(struct task_struct *tsk)
> +{
> +#ifdef CONFIG_VMAP_STACK
> +	struct vm_struct *vm = task_stack_vm_area(tsk);
> +
> +	if (vm) {
> +		int i;
> +
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +			memcg_kmem_charge(vm->pages[i], __GFP_NOFAIL,
> +					  compound_order(vm->pages[i]));
> +
> +		/* All stack pages belong to the same memcg. */
> +		mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> +				     THREAD_SIZE / 1024);
> +	}
> +#endif
> +}

Before this change, the memory limit can fail the fork, but afterwards
fork() can grow memory consumption unimpeded by the cgroup settings.

Can we continue to use try_charge() here and fail the fork?
