Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33DEECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C792075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="o9RGiv4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C792075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbeGRWhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:37:14 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37462 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeGRWhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:37:14 -0400
Received: by mail-qk0-f193.google.com with SMTP id t79-v6so3237577qke.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ker0quClZEgZ5kE8sfGIwDQw5tHDLXhMgyW7gYa9G0=;
        b=o9RGiv4y0vhHEG2inTBc8qIvGE+KizE7Db5zpOsll0EtQgVu+/dDkWiHq0Q9tuC1pj
         2/thP6va7TBIeHrgQQptHGESNnwaotgins3E3RxUI+zsXvp7kWIXi1fos7xzchs/iSoI
         GbYrlNAVKdvu8699D3yCX4g6kQ5uh2Ui2AyIQAgzRnSXv3fOM5vmcQEBoQGLVq0EnmGI
         VlUbYrHBGFtF5dPgRDgSO4oCivjJJiYFNWy5rlWSR4RSF8+sVSJotQK8Vf7iKwhxIsm1
         ZPA9tTbvzihNzcsH5o9X0vQSO1CKSvGKcZsPW20Kv1sVqllaRkNurDa3w0EZAyTpZ68h
         OsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ker0quClZEgZ5kE8sfGIwDQw5tHDLXhMgyW7gYa9G0=;
        b=QFt/Ga/Av6s2Cry2S83+EF0Gn9WCi74eD2+6rcJZBqZXZtwtoHFNHuJCqZNSpgty5n
         QdwB62J116+jiGtrNy8S69PxjZATj9M90+qfW8hbvMpmY1bU6bUKNPl1kuh4DkAAj2ms
         tj9w3qNbwB/WLwkrdyE8Eq9E3OUCv7lxS7OK3iZoF/+wAtpvfQ/lgIJYicqY/8nm2Qkt
         UEoIHDOYocgtwWMXEZeGqcbb9JQqFn0piXRvbYfqbprjQxN3oFTHceiONDQhmdtNUkAh
         QRgELhO1VnqtNVZFTAayXn+cOOXs4s1M1Np+mR44EBQU0VtrUrTs//rJbBXV4oOuWXOs
         xEtQ==
X-Gm-Message-State: AOUpUlH47f0nz4BHC0RJAawyMOlNaMYQj7/8RpAoOWZ4866YA3bq8oC2
        hEQ8w82TXCcvkDiWaciOqdI8ag==
X-Google-Smtp-Source: AAOMgpenhcCJad3V2zEhkjCbiaNo/uQhi41mhWbF0il68Nny1fyaEfG9SL1lo9grP8T+K+nZWqUaJw==
X-Received: by 2002:a37:953:: with SMTP id 80-v6mr7089513qkj.331.1531951040819;
        Wed, 18 Jul 2018 14:57:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:7eca])
        by smtp.gmail.com with ESMTPSA id v88-v6sm4510813qkv.63.2018.07.18.14.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 14:57:19 -0700 (PDT)
Date:   Wed, 18 Jul 2018 18:00:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180718220006.GC2838@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180717141614.GE2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717141614.GE2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:16:14PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> > +/* Tracked task states */
> > +enum psi_task_count {
> > +	NR_RUNNING,
> > +	NR_IOWAIT,
> > +	NR_MEMSTALL,
> > +	NR_PSI_TASK_COUNTS,
> > +};
> 
> > +/* Resources that workloads could be stalled on */
> > +enum psi_res {
> > +	PSI_CPU,
> > +	PSI_MEM,
> > +	PSI_IO,
> > +	NR_PSI_RESOURCES,
> > +};
> 
> These two have mem and iowait in different order. It really doesn't
> matter, but my brain stumbled.

No problem, I swapped them around for v3.
