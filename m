Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04FBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA9E21471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HCaWk7Ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA9E21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeJQFQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:16:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43752 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJQFQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:16:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id p24-v6so12065153pff.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=cEjiXo0pDyslBkZXXs48s40ZK3GrToDaKA+Tbg/ruN8=;
        b=HCaWk7BalYOPB6o+U/wf2hPu2rPpUEhKcyLftGHAjaYgWjXWZCRJnphgsS/1cCUdrU
         E7gVJr5IIMVYxEwwqjBETe/urZjBK4A3UmThftRkyIm9fTr3EGOVhgK7wJIqQZ/Tplep
         sghd7OdpFxk29X/+USiUSbZVpWOpLU12nu5vuKazvHnhTYKwiX15qAZgHzYcCw50zDZ/
         UYiOsxvmJM63pSKup6WWc+Hi56V3YOG4zB4vz47TPhSsNLXc/Rp23bsGq6OdejabzfzK
         NlewKjRaDW50ezGLFs+EcYXnAp2N0WYkwCX5J6wUxK7XWfxsspgooMnqiSeb0pxFSzIb
         DWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=cEjiXo0pDyslBkZXXs48s40ZK3GrToDaKA+Tbg/ruN8=;
        b=rgvCPfiJz4L40z3aowTnoU25lCoU8etjz4V+g09sSwHXqnb1eAR05nS8mOALnzWgkc
         cDu9JfKUZMhajn17PKK5QMsjzlxxA0+ibFIRpvHA5KSf2GphUMi9iuyCwKvKDAfGUeST
         HO1V9MYxxzcYjhLhfeibVtdUMGcQEifZieQswusBpJZNlbQM4ippmY9Gyv4jw+8+kHro
         3JvV+UlzDEF1xFFOiae1xa/ll9c6qWScqa0WsAF7qDXqFpq/2mTRTpOgXq56bosQyqG9
         qxLpUBvLECNqkkOHCexEA5yzSyYQ0b/+0TcBP1Bl0RFSsRFZHH47FQu7bt3vPUxPqeuK
         DheQ==
X-Gm-Message-State: ABuFfohpXNm03sp112UP8oOGEeb7Wc8GiIF1WYAwuXb4/QqaA7p8QRTL
        J5qHvzTasqCAGZuQbfiJvdr/5w==
X-Google-Smtp-Source: ACcGV61Y/AWaVJh24EL/kgcvJhJg+b1hm9pjyOOqDvAQzqnCSzBXYqMby0sUEncuZdN2MOumeR2fAA==
X-Received: by 2002:a63:ff46:: with SMTP id s6-v6mr21748116pgk.241.1539725061322;
        Tue, 16 Oct 2018 14:24:21 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y1-v6sm20161163pfy.89.2018.10.16.14.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 14:24:20 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:24:19 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] mm, proc: report PR_SET_THP_DISABLE in proc
In-Reply-To: <20181016104855.GQ18839@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1810161416540.83080@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1810021329260.87409@chino.kir.corp.google.com> <20181003073640.GF18290@dhcp22.suse.cz> <alpine.DEB.2.21.1810031547150.202532@chino.kir.corp.google.com> <20181004055842.GA22173@dhcp22.suse.cz> <alpine.DEB.2.21.1810040209130.113459@chino.kir.corp.google.com>
 <20181004094637.GG22173@dhcp22.suse.cz> <alpine.DEB.2.21.1810041130380.12951@chino.kir.corp.google.com> <20181009083326.GG8528@dhcp22.suse.cz> <20181015150325.GN18839@dhcp22.suse.cz> <alpine.DEB.2.21.1810151519250.247641@chino.kir.corp.google.com>
 <20181016104855.GQ18839@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018, Michal Hocko wrote:

> > I don't understand the point of extending smaps with yet another line.  
> 
> Because abusing a vma flag part is just wrong. What are you going to do
> when a next bug report states that the flag is set even though no
> userspace has set it and that leads to some malfunctioning? Can you rule
> that out? Even your abuse of the flag is surprising so why others
> wouldn't be?
> 

The flag has taken on the meaning of "thp disabled for this vma", how it 
is set is not the scope of the flag.  If a thp is explicitly disabled from 
being eligible for thp, whether by madvise, prctl, or any future 
mechanism, it should use VM_NOHUGEPAGE or show_smap_vma_flags() needs to 
be modified.

I agree with you that this could have been done better if an interface was 
defined earlier that userspace could have used.  PR_SET_THP_DISABLE was 
merged long after thp had already been merged so this can be a reminder 
that defining clean, robust, and extensible APIs is important, but I'm 
afraid we can't go back in time and change how userspace queries 
information, especially in cases where there was only one way to do it.

> > The only way for a different process to determine if a single vma from 
> > another process is thp disabled is by the "nh" flag, so it is reasonable 
> > that userspace reads this.  My patch fixes that.  If smaps is extended 
> > with another line per your patch, it doesn't change the fact that previous 
> > binaries are built to check for "nh" so it does not deprecate that.  
> > ("THP_Enabled" is also ambiguous since it only refers to prctl and not the 
> > default thp setting or madvise.)
> 
> As I've said there are two things. Exporting PR_SET_THP_DISABLE to
> userspace so that a 3rd party process can query it. I've already
> explained why that might be useful. If you really insist on having
> a per-vma field then let's do it properly now. Are you going to agree on
> that? If yes, I am willing to spend my time on that but I am not going
> to bother if this will lead to "I want my vma field abuse anyway".

I think what you and I want is largely irrelevant :)  What's important is 
that there are userspace implementations that query this today so 
continuing to support it as the way to determine if a vma has been thp 
disabled doesn't seem problematic and guarantees that userspace doesn't 
break.
