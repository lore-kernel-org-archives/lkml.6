Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9575ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832EB2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="sQxoz6Mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832EB2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbeGMW14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:27:56 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:41782 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731935AbeGMW14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:27:56 -0400
Received: by mail-yw0-f193.google.com with SMTP id q129-v6so9497098ywg.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 15:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7PgyzSNJ2bqfKN8F6PdixT1ZQ9Zdxvkc+fOPVFGcypE=;
        b=sQxoz6MkrCfzDoTQIGPLrKd4xVZIMBDrFsvmmbmc+kAXLuPFVzlBm5DjzRN15UUcP+
         D7v/yop7r0jW80AiPLdBdouqkREe6MC+FUAQJ4gfG0ZakjNWam5rQa0H5Y7FH2RuwHH6
         s5s7RZkRnpgIG7TuhiZhNE3q/4Y2z0J9iDU9ihUo5g4GXwZCWKCxjBnYuRTEE2ypCC/i
         RIANcG9WiWGFY9p6utjE8yzYIxvUz1vpALUKT3z5Sps64dBwKb6oxhuMU2uWTsHkl+ed
         b4XL+3azzT4UCDcQ60eOhDO0R2cSNk0SWITJ1ctbRX4y+0OPC3Oq9ilN8F67S2O5SNkd
         cYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7PgyzSNJ2bqfKN8F6PdixT1ZQ9Zdxvkc+fOPVFGcypE=;
        b=S/208LqIVxOhPkjdKot8FDjcO/mN2RTrCGs2/Gh8TbR7x3eeRxVqguEMkOJ4YB7lWh
         nF9V9N3+Br/hcPa5DXu29aPEy5ugjEGaw7xxGvPdneMI+JGpyQdsaGWY4DYSDWP7z+qv
         5SAdXZYPCbJmUKznyOJTLBl+fJs4ssS9lO9ONFiNDBJsZolLqys01EEhFt/8nrdXhf4Y
         UzemBCQk9t8t0Eqin9I8xYZQzVDhqw/vW32ScVgWH/jFOD2b/knoxcr1Efb2sqcbVxaA
         WdKXNnVfg9yHQgBSfWntQbSZ1LrcVh9XeeJ+W0ZuIXFPI5+wAvQ/vsEvBxUXe32oIfCU
         bVDw==
X-Gm-Message-State: AOUpUlHJe9eQNOQaP7EW1/EF+maFDcIZr7KuRUj1FxTRCKZLEH920W8Z
        dH9Htjo50fz/m5TGtBYkI9H4Vw==
X-Google-Smtp-Source: AAOMgpf6OFLMtuM3GudZL3CJhIr8Srya+y2URed93alFwwv4BxfbTBdNEq8av4fRO+NJba3B7NFlrw==
X-Received: by 2002:a81:160c:: with SMTP id 12-v6mr4207053yww.254.1531519883181;
        Fri, 13 Jul 2018 15:11:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:23bd])
        by smtp.gmail.com with ESMTPSA id d189-v6sm10476114ywh.93.2018.07.13.15.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 15:11:22 -0700 (PDT)
Date:   Fri, 13 Jul 2018 18:14:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory,
 and IO v2
Message-ID: <20180713221042.GA30013@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712164422.a53cc0f9c26b078dbc7e5731@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712164422.a53cc0f9c26b078dbc7e5731@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 04:44:22PM -0700, Andrew Morton wrote:
> On Thu, 12 Jul 2018 13:29:32 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> >
> > ...
> >
> > The io file is similar to memory. Because the block layer doesn't have
> > a concept of hardware contention right now (how much longer is my IO
> > request taking due to other tasks?), it reports CPU potential lost on
> > all IO delays, not just the potential lost due to competition.
> 
> Probably dumb question: disks aren't the only form of IO.  Does it make
> sense to accumulate PSI for other forms of IO?  Networking comes to
> mind...

It's conceivable, although I haven't thought too much about it yet. If
that turns out to be a state we might want to track, we can easily add
a task state to identify such stalls and add /proc/pressure/net e.g.

"io" in this case means only the block layer / filesystems. I think
keeping this distinction makes sense in the interest of identifying
which type of hardware resource is posing a pressure problem.
