Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7702C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9BD2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGd1C76F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9BD2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbeLEVOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:14:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36692 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeLEVOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:14:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so9591481pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GMz2EIwH2WgkDln2haXdayGa7cvr+Ps4oWLojflnUhs=;
        b=RGd1C76FOHH4RsslXnYqUk1hzJG4EMRD1TT6B24OgqTe8wKsdTTHcDrReyrXyn7odU
         Ej8pwv0CpLIBiw/Ll7YmbA1ANSs9tazGtIA3MXwVteEGESj6g4i5V0B92LteZzbyffP2
         SrkqctzUZTrEJFzKtBp92RWdS8DzF1VPP2iyqJUSOFtH5I9SMENb+2cQ1unwqbTqcbNk
         NNdHCmybqrsqyIHsQwMuRRBEcPzyLuWTunezexc5jEIIAUJppvZthg0DGKmN/MrL+Fhk
         pqTDBSMu2uli5Gy8PMN6cKVL2qnTDAvI1ZHws591f0W6N/peSKO98M9p9Hfr9CKXZo8K
         D5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GMz2EIwH2WgkDln2haXdayGa7cvr+Ps4oWLojflnUhs=;
        b=fxYsuFKZeYct6i46RYu/PHELhsmYRGL701L5EYDKTrNzeyEM4SthSNRB+01bieP3T5
         CZOTw04623RHlZqJLwzNjg0f/issjCHDUdsOpBT7p8aoOJEomup4n2PG01tJxwcy6Shq
         sAJYF8B0rc0EmWoQSVTuxqo+40WoMFXvN2GMeFQMB+G8sBPYTIDVnXfIFdZu4P1757zr
         NkGVqW3ZqUp08o7F2qR9XmXRJXMcTGF3Na5UVqxMKGLMt9KR9t/NcqNs+taVZCEcSOsd
         W9WTIlhFLu3HEw9PfmEXzoiYFCeGaE40sbdXEc9wPclzhjU2KS8ZT6V1udfSV2XC2q2Y
         OEkw==
X-Gm-Message-State: AA+aEWZ2elwXb5f5mlRuBNZ9TtYcGbuTOtBzr1G/TK9BUd89ZYBbBbzF
        KBVFTfXV2Wu2EjHDzQNbzTQJYQ==
X-Google-Smtp-Source: AFSGD/W8RBnYD6AxsXgpFTV/dvbNWKfoONObcYKnZXV2HnbVb4axcBe/VmpFe6irg/TJrPzfqtHVPA==
X-Received: by 2002:a62:6f49:: with SMTP id k70mr25757855pfc.7.1544044479555;
        Wed, 05 Dec 2018 13:14:39 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m20sm23271861pgv.93.2018.12.05.13.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 13:14:38 -0800 (PST)
Date:   Wed, 5 Dec 2018 13:14:37 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
In-Reply-To: <20181205203243.GX1286@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1812051308330.9633@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com> <bb198d88-27be-0d5c-d871-1ffd26a08e29@suse.cz> <alpine.DEB.2.21.1812041356490.157466@chino.kir.corp.google.com> <20181205090554.GX1286@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812051142040.240991@chino.kir.corp.google.com> <20181205203243.GX1286@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Michal Hocko wrote:

> > As we've been over countless times, this is the desired effect for 
> > workloads that fit on a single node.  We want local pages of the native 
> > page size because they (1) are accessed faster than remote hugepages and 
> > (2) are candidates for collapse by khugepaged.
> > 
> > For applications that do not fit in a single node, we have discussed 
> > possible ways to extend the API to allow remote faulting of hugepages, 
> > absent remote fragmentation as well, then the long-standing behavior is 
> > preserved and large applications can use the API to increase their thp 
> > success rate.
> 
> OK, I just give up. This doesn't lead anywhere. You keep repeating the
> same stuff over and over, neglect other usecases and actually force them
> to do something special just to keep your very specific usecase which
> you clearly refuse to abstract into a form other people can experiment
> with or at least provide more detailed broken down numbers for a more
> serious analyses. Fault latency is only a part of the picture which is
> much more complex. Look at Mel's report to get an impression of what
> might be really useful for a _productive_ discussion.

The other usecases is part of patch 2/2 in this series that is 
functionally similar to the __GFP_COMPACT_ONLY patch that Andrea proposed.  
We can also work to extend the API to allow remote thp allocations.

Patch 1/2 reverts the behavior of commit ac5b2c18911f ("mm: thp: relax 
__GFP_THISNODE for MADV_HUGEPAGE mappings") which added NUMA locality on 
top of an already conflated madvise mode.  Prior to this commit that was 
merged for 4.20, *all* thp faults were constrained to the local node; this 
has been the case for three years and even prior to that in other kernels.  
It turns out that allowing remote allocations introduces access latency in 
the presence of local fragmentation.

The solution is not to conflate MADV_HUGEPAGE with any sematic that 
suggests it allows remote thp allocations, especially when that changes 
long-standing behavior, regresses my usecase, and regresses the kernel 
test robot.

I'll change patch 1/2 to not touch new_page() so that we are only 
addressing thp faults and post a v2.
