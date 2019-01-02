Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60DAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B79E20879
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfOEJAnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfABTnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:43:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37623 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfABTnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:43:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so14904472plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 11:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=R11YRNGLg7CgD4a9KU3qTMje2Bj1pNep2Y2+/ttJnKQ=;
        b=bfOEJAnjnaN57sGdjQL7WTLCb47OFeG9Jx9a7m41YFvupoOw/BDT8FCtSgCQJHNKoD
         zrcTbdFz1BtMs2ipclejuZ5rxueDg05/fV/IZyh29nM9aRxzQaas9TxhqofVO7hOJlMX
         ym6tCsHNKSzn4md6EeHHz+RMawQhHjaw751q2Q81oTwlF8mCS32vaodtA7ByBw3YUl6Y
         xRcHoh0WtT0a35nF7I8vK6eGjnAnJlo6bNHSiOpn1jmnzL43YYgX/rP6jZwqO3/NKrd+
         sZx7c+Qbx0Ns8zrG1fka+XyGxuTq9r20jHSB4uBSsjYQ9NHTdow+Ku0yrw4JZ3od8gdp
         5elA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=R11YRNGLg7CgD4a9KU3qTMje2Bj1pNep2Y2+/ttJnKQ=;
        b=RfDL0QgLjJR2yL77yLKpBIQiagwoBsSbKdH+23Gs59cZq0Wq9M/ZdcOklZoJeX5CJa
         Zu6vGsq/XYIW5QQgUfhuIVTgX1GbpFq55bxETt1b1XCml5ybqd7WHa2RGxD7gr3xGKQ/
         wz04KF6yx2X73LUZuQ+iUokAbktSvrC3zYNKBfhkvvqdY7y9TXYRLKEX0kMXfwoa/I8F
         1AGPDh8dfhMMNtlY5ChVdNP54lHbLYfPdtjfZknt2dndFTVvuVZB+b6ASo4V4THCvcXN
         gH8ZvS4amktNgpGYtTFnEwY0grjhNClfEr7EkRvDPhcdiQ39+F6oCKEHVbT7VlJwVV/Z
         NzXA==
X-Gm-Message-State: AJcUukc3i1B4ghJIOaXYTiTa9pRDMiO7yXBd6ZhIzREpEOns07bkueGW
        QAYe6qtdTpSHz37TUYYphSX89w==
X-Google-Smtp-Source: ALg8bN4T5keWdjzEDYXMLBrTaz792i+sHg8SlzQOmoMyLJz9y9szbkag54wCLTpqqc8D1CB/GiY8yQ==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr43746591pln.204.1546458200138;
        Wed, 02 Jan 2019 11:43:20 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id w11sm64310340pgk.16.2019.01.02.11.43.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 11:43:18 -0800 (PST)
Date:   Wed, 2 Jan 2019 11:43:12 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Vineeth Pillai <vpillai@digitalocean.com>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kelley Nielsen <kelleynnn@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v3 2/2] mm: rid swapoff of quadratic complexity
In-Reply-To: <CANaguZC_d2EBmNuXtcJRcEcw8uXK234tYSXx6Uc2o9JH_vfP4A@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.1901021039490.13761@eggly.anvils>
References: <20181203170934.16512-1-vpillai@digitalocean.com> <20181203170934.16512-2-vpillai@digitalocean.com> <alpine.LSU.2.11.1812311635590.4106@eggly.anvils> <CANaguZAStuiXpk2S0rYwdn3Zzsoakavaps4RzSRVqMs3wZ49qg@mail.gmail.com> <alpine.LSU.2.11.1901012010440.13241@eggly.anvils>
 <CANaguZC_d2EBmNuXtcJRcEcw8uXK234tYSXx6Uc2o9JH_vfP4A@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2019, Vineeth Pillai wrote:
> 
> After reading the code again, I feel like we can make the retry logic
> simpler and avoid the use of oldi. If my understanding is correct,
> except for frontswap case, we reach try_to_unuse() only after we
> disable the swap device. So I think, we would not be seeing any more
> swap usage on the disabled swap device, after we loop through all the
> process and swapin the pages on that device. In that case, we would
> not need the retry logic right?

Wrong.  Without heavier locking that would add unwelcome overhead to
common paths, we shall "always" need the retry logic.  It does not
come into play very often, but here are two examples of why it's
needed (if I thought longer, I might find more).  And in practice,
yes, I sometimes saw 1 retry needed.

One, the issue already discussed, of a multiply-mapped page which is
swapped out, one pte swapped off, but swapped back in by concurrent
fault before the last pte has been swapped off and the page finally
deleted from swap cache.  That swapin still references the disabled
swapfile, and will need a retry to unuse (and that retry might need
another).  We may fix this later with an rmap walk while still holding
page locked for the first pte; but even if we do, I'd still want to
retain the retry logic, to avoid dependence on corner-case-free
reliable rmap walks.

Two, get_swap_page() allocated a swap entry for shmem file or vma
just before the swapoff started, but the swapper did not reach the
point of inserting that swap entry before try_to_unuse() scanned
the shmem file or vma in question.

> For frontswap case, the patch was missing a check for pages_to_unuse.
> We would still need the retry logic, but as you mentioned, I can
> easily remove the oldi logic and make it simpler. Or probably,
> refactor the frontswap code out as a special case if pages_to_unuse is
> still not zero after the initial loop.

I don't use frontswap myself, and haven't paid any attention to the
frontswap partial swapoff case (though notice now that shmem_unuse()
lacks the plumbing needed for it - that needs fixing); but doubt it
would be a good idea to refactor it out as a separate case.

Hugh
