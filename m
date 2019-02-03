Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653E5C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 06:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3255D21773
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 06:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="fG0rb3LA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfBCGVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 01:21:20 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41786 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfBCGVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 01:21:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so5282385pfi.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 22:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zxEjaYy+JsHVGX0Na5H2IIsv1IZR8sj0qq1XGIVMrvc=;
        b=fG0rb3LAqiMpw7kMFwZ2BqmN+BqjEcdKYjEwk+719BDaGX2DDF+Ly5rzNkp3AqyhKn
         UJM5r/O0RYpLzy126uMJFnu8UwXBcCWc0Y8cMCrywuAhOH2V+K7epx1tX+HJHZkbgQki
         QdZoDwDErh7q9JtPlJVEwkawEhLWhCJtOFaGQu6maez7E0WLOaqwE1RuUq7/GmLLL2Lq
         Mhcg0zty16Xbe0JfAYrZXt6wMjt/vT1Mh5+t88nK4tE+tKnY8+pPdm2AHV+8F+R5iYoL
         SJ87J5Z61dYAPfFoxLu3Z6HxkKut4q//qDX8IVL/JYLBXW468qmOg3nIAlKLd68g8kvB
         U8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zxEjaYy+JsHVGX0Na5H2IIsv1IZR8sj0qq1XGIVMrvc=;
        b=XKKMhElRIX13CN0APucXs0corEAPmUSkEZ00cL79mfcTKXL0/qeoYSI58y5LR1N9j8
         FkT15c+76wK/3h7OOK6SjrPTOpdcdAe1iBLjh+gr5DXcQ8lyH82mX92lsOmUYtEFZYKQ
         62ERKPf8en2Yy39aNarfuhWxwXDAMgr++9obiYLFgdps4XoS/s2wK09c3rlmohRFmnos
         2J08q/TNV9fCG7Tq/EHnvlAFPgPqwGzRml3/1kftFn9YKkYMuKifRu8DM7kVT4JLOMzh
         TCkabDZYA7S7GvXHxazVY5tcfB1rNLXCqkNXcjOkOTwtTLB6Raj7SbVV+7qKWZhtTFdB
         ztNg==
X-Gm-Message-State: AHQUAuZxluxIZ++dXEnYbK/wZQ4HdHVVMV0x2TION/c5XH06V8xn9M7K
        RVBXf0tbSrc0ongTltDwHwz+cw==
X-Google-Smtp-Source: AHgI3IZOb1aucWJvwRr4/Z8hFCdTydsb5pBrcyfqrHvEkfsKKkIxmY54b19zR7PSqeLyrCvPB3v7Xg==
X-Received: by 2002:a65:448a:: with SMTP id l10mr8595082pgq.387.1549174878794;
        Sat, 02 Feb 2019 22:21:18 -0800 (PST)
Received: from localhost (c-73-170-36-70.hsd1.ca.comcast.net. [73.170.36.70])
        by smtp.gmail.com with ESMTPSA id y12sm18425995pfk.70.2019.02.02.22.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 22:21:18 -0800 (PST)
Date:   Sat, 2 Feb 2019 22:21:14 -0800
From:   Sandeep Patil <sspatil@android.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, adobriyan@gmail.com,
        avagin@openvz.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel-team@android.com, dancol@google.com
Subject: Re: [PATCH] mm: proc: smaps_rollup: Fix pss_locked calculation
Message-ID: <20190203062114.GC235465@google.com>
References: <20190121011049.160505-1-sspatil@android.com>
 <20190128161509.5085cacf939463f1c22e0550@linux-foundation.org>
 <b15205cd-33e3-6cac-b6a4-65266be7a9c8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b15205cd-33e3-6cac-b6a4-65266be7a9c8@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 04:52:21PM +0100, Vlastimil Babka wrote:
> On 1/29/19 1:15 AM, Andrew Morton wrote:
> > On Sun, 20 Jan 2019 17:10:49 -0800 Sandeep Patil <sspatil@android.com> wrote:
> > 
> >> The 'pss_locked' field of smaps_rollup was being calculated incorrectly
> >> as it accumulated the current pss everytime a locked VMA was found.
> >> 
> >> Fix that by making sure we record the current pss value before each VMA
> >> is walked. So, we can only add the delta if the VMA was found to be
> >> VM_LOCKED.
> >> 
> >> ...
> >>
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
> >> @@ -709,6 +709,7 @@ static void smap_gather_stats(struct vm_area_struct *vma,
> >>  #endif
> >>  		.mm = vma->vm_mm,
> >>  	};
> >> +	unsigned long pss;
> >>  
> >>  	smaps_walk.private = mss;
> >>  
> >> @@ -737,11 +738,12 @@ static void smap_gather_stats(struct vm_area_struct *vma,
> >>  		}
> >>  	}
> >>  #endif
> >> -
> >> +	/* record current pss so we can calculate the delta after page walk */
> >> +	pss = mss->pss;
> >>  	/* mmap_sem is held in m_start */
> >>  	walk_page_vma(vma, &smaps_walk);
> >>  	if (vma->vm_flags & VM_LOCKED)
> >> -		mss->pss_locked += mss->pss;
> >> +		mss->pss_locked += mss->pss - pss;
> >>  }
> > 
> > This seems to be a rather obscure way of accumulating
> > mem_size_stats.pss_locked.  Wouldn't it make more sense to do this in
> > smaps_account(), wherever we increment mem_size_stats.pss?
> > 
> > It would be a tiny bit less efficient but I think that the code cleanup
> > justifies such a cost?
> 
> Yeah, Sandeep could you add 'bool locked' param to smaps_account() and check it
> there? We probably don't need the whole vma param yet.

Agree, I will send -v2 shortly.

- ssp
