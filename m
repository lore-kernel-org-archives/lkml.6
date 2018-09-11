Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B2FC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076D32086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhVu2WK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076D32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeIKLUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:20:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38759 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeIKLUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:20:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so49569wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 23:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gd/kdvnkXqDET6v0VQ5anA2WmTcdQisNIFRcC5+vlHQ=;
        b=VhVu2WK6DkzqY1Jqkp4/Bt6cjfGBaOBF8tH0c54y3omCBZW+YXqFtmQO93wYefcpjw
         kI3ApRlZfShYRZSqkzRYokl5Y9VcB/jewLL2qukH7iCV4r1tTkPfdYEDVJpTRJ2LaBb6
         KwG3V6+iQBXL3wUJaRLjK9jQj9oOoHFwqdF3cdgbCm0i3aMM7j2JCSA5Dgu2Ago+VTES
         VlwcEBJsC19qNGlJ+kthPrOKxjai2jBd93KXAWN/HNvLfItyXxKGSPzIahtNyUU/n9a/
         FuHnndB034eddQ5yfu9Bnpo4vsv6wXGqllEQPDY5Hw47CFp4zHXiLNRinzOWHLOHTaEk
         h94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gd/kdvnkXqDET6v0VQ5anA2WmTcdQisNIFRcC5+vlHQ=;
        b=nBoY/8Ys1nXwwLmwUTZ2DJF8j4V5xPDE9wP2VXvI+xdcbmzrWCqkaDLEBmA7rQCaXW
         ypSKRlBudrzme2HI1B4imlvYBVhejw78TnAqXx0EDXw2iYJpjYQEDafMECtcYbATg3Tc
         M4N3s+7K46W+LTdwSjadYFfotZDRVPnRR7mpf1PdlAa2wUV4K/ROZDjhAwmTd3ZT8L70
         87LikwREtiyQbfhec6LfNAOOKGpl3OLdcAs/KFQz/SkLENFbcMiVjhqJa5FFF6k1+4Np
         i9Ab1p4BwIG/i2gB7y6yO7hP+C1Dtk6hCwZwwBFMWVARzu4tzApfdfL+RDI7x0PZqdQ1
         j6+Q==
X-Gm-Message-State: APzg51DQzu+L8t3o5huU23EFkY+b+972ikwxtXSPBO80lhU/2od+aMYi
        kEVPNLP6iceeSLbixYFeCos=
X-Google-Smtp-Source: ANB0VdZVklSDYiO7e2pHHO01UjEEfXHmWT6yc/PHYldJ8NsZwKs8CuoMJOFbxrbarzhcQ8kVb+SRcw==
X-Received: by 2002:a1c:ca17:: with SMTP id a23-v6mr228542wmg.122.1536646972075;
        Mon, 10 Sep 2018 23:22:52 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i125-v6sm83636wmd.23.2018.09.10.23.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 23:22:51 -0700 (PDT)
Date:   Tue, 11 Sep 2018 08:22:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Li Zhijian <zhijianx.li@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Disable LB_BIAS by default
Message-ID: <20180911062249.GD72017@gmail.com>
References: <20180809135753.21077-1-dietmar.eggemann@arm.com>
 <20180910141205.GM24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910141205.GM24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Aug 09, 2018 at 02:57:53PM +0100, Dietmar Eggemann wrote:
> > LB_BIAS allows the adjustment on how conservative load should be
> > balanced.
> 
> > It is very likely that LB_BIAS' influence on load balancing can be
> > neglected (see test results below). This is further supported by:
> > 
> > (1) Weighted CPU load today is by itself a decayed average value (PELT)
> >     (cfs_rq->avg->runnable_load_avg) and not the instantaneous load
> >     (rq->load.weight) it was when LB_BIAS was introduced.
> > 
> > (2) Sd imbalance_pct is used for CPU_NEWLY_IDLE and CPU_NOT_IDLE (relate
> >     to sd's newidle and busy idx) in find_busiest_group() when comparing
> >     busiest and local avg load to make load balancing even more
> >     conservative.
> > 
> > (3) The sd forkexec and newidle idx are always set to 0 so there is no
> >     adjustment on how conservatively load balancing is done here.
> > 
> > (4) Affine wakeup based on weight (wake_affine_weight()) will not be
> >     impacted since the sd wake idx is always set to 0.
> > 
> > Let's disable LB_BIAS by default for a few kernel releases to make sure
> > that no workload and no scheduler topology is affected. The benefit of
> > being able to remove the LB_BIAS dependency from source_load() and
> > target_load() is that the entire rq->cpu_load[idx] code could be removed
> > in this case.
> 
> Certainly worth a try; as I've written somewhere in a comment; it would
> be very nice to get rid of that load tracking crud.
> 
> And it is trivial to revert if something does show up.
> 
> Ingo, what do you think?

Ack, I'm very much in favor of reducing complexity.

Thanks,

	Ingo
