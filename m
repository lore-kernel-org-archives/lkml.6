Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D62C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1098A208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uat6p3fi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1098A208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbeHABwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 21:52:46 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:34452 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732826AbeHABwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 21:52:45 -0400
Received: by mail-pl0-f49.google.com with SMTP id f6-v6so7891128plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 17:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=k+TV9hLlK+NXPBlauTCWQvqUYLgZSGTySxntvwmHisw=;
        b=Uat6p3fiL1S1outeGVpv55E0Lb4dGtirdUK+tIHE/6pJiMR5Jb/ccaOWDQUnIzBzEe
         mglFHKi6HO8MKEfsUlF4Od6+rEfTZV99lvxJiPc4jAL3NG3jQ3NzIvI4271UNjQ73nmf
         auVgE/YWMLjEwKBMPkCFzAiYShyyvq4aP9lGW2bRMqluFfe4O0pxnuDB1vv6wUfvSjiR
         hgmBxHWoPatzuxeXr/XFv4T8rsxCoGROeCr3ZKAsxT+4xkp42WImfM6SIHSPeNN1x1gU
         h1QQL1rd0lDuVxyPxRZn9KFFB6lyQAzrRyJPGNCWtapZ3rroOQzJaLU58kz0nKdwMese
         1u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=k+TV9hLlK+NXPBlauTCWQvqUYLgZSGTySxntvwmHisw=;
        b=UqFIpyD/TnAx3adEDpgJCkZYJvYgwspiKeRsXELRAVzyhS7CMs/FQKGBXQH3TmOn9a
         aZoIo1owmelosb5uERYMES7/z7VfeRb1K+Vq+wyYydcXPEi2OTOmF3STaqdoUTfQwLZV
         Y2Nme+VVaQbxUAWDdsk9tbmTDv8kN5xYw5GzftGVEU8LwOXeAFim/QPd5Y+143b8g3VA
         LZhKkzQYhYPHERUvxHA4qureg+NrgYV4pkh46cCAvgjIQ5Mazujb7yETIeghDfTTYv5t
         I07E32ttfdlD04S6BKhxjfqpV+m7SzQLaU/6cpcWBdBuY0GxehHa9m/Y4OXILEqzVk+y
         0DWw==
X-Gm-Message-State: AOUpUlE58/YroUiJuBFFjTvI1vgfQdaBNZQPbh6plaOLiVItT00+g5H/
        Cod8gARArhPAROY4uzwqjV3zfQ==
X-Google-Smtp-Source: AAOMgpdWoJmzV8Enve8yXxMR1WXzS41R6x6F/yicCIqiutq+UNLzFUDP+WkZG24x8VY1OKUi6uecjQ==
X-Received: by 2002:a17:902:1ab:: with SMTP id b40-v6mr21861134plb.55.1533082197762;
        Tue, 31 Jul 2018 17:09:57 -0700 (PDT)
Received: from [100.112.71.195] ([104.133.8.99])
        by smtp.gmail.com with ESMTPSA id j1-v6sm40818798pfk.125.2018.07.31.17.09.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 17:09:56 -0700 (PDT)
Date:   Tue, 31 Jul 2018 17:09:48 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling257@gmail.com
Subject: Re: Linux 4.18-rc7
In-Reply-To: <20180731145718.pbyy3qkp2a2yvucs@kshutemo-mobl1>
Message-ID: <alpine.LSU.2.11.1807311611380.8601@eggly.anvils>
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com> <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com> <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1> <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
 <alpine.LSU.2.11.1807301410470.4805@eggly.anvils> <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com> <20180731062927.hjknfcb2cj3bwd7b@kshutemo-mobl1> <20180731145718.pbyy3qkp2a2yvucs@kshutemo-mobl1>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018, Kirill A. Shutemov wrote:
> On Tue, Jul 31, 2018 at 09:29:27AM +0300, Kirill A. Shutemov wrote:
> > On Mon, Jul 30, 2018 at 06:01:26PM -0700, Linus Torvalds wrote:
> > > 
> > > So to me it looks like a historical check that simply doesn't
> > > "normally" trigger, but there's no reason I can see why we should care
> > > about the case it tests against.
> > 
> > I'll think more on what could go wrong with __split_huge_pmd() called on
> > anon-THP page without mmap_sem(). It's not yet clear cut to me.
> 
> I think not having mmap_sem taken at least on read when we call
> __split_huge_pmd() opens possiblity of race with khugepaged:
> khugepaged can collapse the page back to THP as soon as we drop ptl.
> As result pmd_none_or_trans_huge_or_clear_bad() would return true and we
> basically leave the THP behind, not zapped.

I think we don't care deeply about the POSIX truncate semantics on the
kind of "file" that has managed to get to this point: in the unlikely
event that a THP is immediately recreated there, never mind, so long as
we don't crash or leak memory or suchlike (the surplus THP would get
freed at exit).

I think we're altogether better off just deleting that VM_BUG_ON_VMA();
but I do find it very very hard to arrive at a firm conclusion on the
absolute safety of splitting a pmd without mmap_sem there (though any
problem unlikely even if real, and more likely a figment of my paranoia).

I believe the VM_BUG_ON is a relic from the old days, when anon_vma_lock
played a big part in guarding the pmd+page split: remember how mmap_sem
is one of the ways you can guarantee that the anon_vma will not vanish
beneath you (page_get_anon_vma was added later than anon THP).

I'm a little more worried by the nearby zap_huge_pmd() (which could
never be covered by a suitable VM_BUG_ON): the way that frees a
previously deposited page table, and you have no guarantee of when
and where that page table was last used. Again I can't point to an
actual problem, just the recollection that it's been found subtly
safe in the past, but any change in the conditions might affect that.

And a little worried to see how split_huge_page_to_list() uses
anon_vma_lock on PageAnon versus i_mmap_lock on !PageAnon: which
makes complete sense in itself, but won't protect against a PageAnon
THP being concurrently split from the truncate_pagecache() direction,
where unmap_mapping_range() uses i_mmap_lock. (simple_setattr() the
default setattr: that's a bit of a worry too.)

I feel I'm moaning and crying at shadows, rather than providing any
useful suggestions or patches; but thought I ought to report back.

Hugh
