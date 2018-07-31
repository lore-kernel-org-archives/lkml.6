Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074D6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F85D208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="m8fkrXB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F85D208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbeGaIIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:08:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34376 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbeGaIIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:08:15 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so6707248plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 23:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4op/UZBvIySF+WDKzYy4Yd56uknU6JHQLEzUDmr7W94=;
        b=m8fkrXB6wK/X0UMFDFyndbm9Z/ar0bRMzefDY6fTz60e1Ez2lbFo3v1aoVdfXTrq/S
         dwtvg77BITfEIPsIU9lzNbP0fzXYk0/Cj6kWW3aGkgW7gQrVZlhgmUJNJza6xhqdNwqI
         PLnr9/h2OWcVoukEZFWYRTVN1uiUU3HdAB2tHvpfXNir9/+tJcmgzgOmR8Os3WsbINIT
         9L+ECm3wTNToX6UozSclQEDAZXf8uVGepcCkfxYdoJhgtHy17Yv85wn0aSLLC4Npo1jV
         dkdyqQoqkJNt51Fxm9O/PDQHaijYY1haDUcWyuFRVsU4SKVD9D6IUMhTKyFEQUh4wCXt
         VP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4op/UZBvIySF+WDKzYy4Yd56uknU6JHQLEzUDmr7W94=;
        b=r8s+pO2gOw/XgDXKLm7vvBTRYAiP98bingJwC9fCDNR9S6EYYW5tlvhbIpNaQ2At53
         l99+1YG1bEE6zXHksDG4IzFlKn4+iz9QOwqTuuRyB8PcGqbQd2ITtLYCtLDFBcaN23zl
         DQQ2ky4g76YaK+Fs3UOLKd0qnJ+7QU/LfnAKl5hXHo7Nxb2bGVp7Ec26rJ3su8pSLVBD
         lpIzqKCuAHUJTfnaDzxC/XshAuI8ipUodLB1piSHkumRxn/rpt/0nqLhnyALbo3MGbbP
         QyYUkCFwE+o/9XTIQ7XBp9BsCDOVF1cwPePW9KO/J1EI+VDL/LpozUjkig0WgYLj1/UJ
         rC6w==
X-Gm-Message-State: AOUpUlHJIjTscXposoKXt5vXFIR/0wMbKdjoCaSF60+1V3INaQtK8IiR
        MfaY0WI8uRS+aeNg32SOVCv+Ug==
X-Google-Smtp-Source: AAOMgpcmUy4qeW7M8OZ94th6u+dps5pWNHsOHonZQU9HZ3n4hWF7hL0kbcn7e6CAqpVXfQZW6bQDvg==
X-Received: by 2002:a17:902:aa87:: with SMTP id d7-v6mr19208489plr.215.1533018573292;
        Mon, 30 Jul 2018 23:29:33 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id m4-v6sm18577694pgn.82.2018.07.30.23.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 23:29:32 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A8FD43002A5; Tue, 31 Jul 2018 09:29:27 +0300 (+03)
Date:   Tue, 31 Jul 2018 09:29:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
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
Message-ID: <20180731062927.hjknfcb2cj3bwd7b@kshutemo-mobl1>
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
 <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com>
 <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1>
 <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
 <alpine.LSU.2.11.1807301410470.4805@eggly.anvils>
 <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 06:01:26PM -0700, Linus Torvalds wrote:
> On Mon, Jul 30, 2018 at 2:53 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > I have no problem with reverting -rc7's vma_is_anonymous() series.
> 
> I don't think we need to revert the whole series: I think the rest are
> all fairly obvious cleanups, and shouldn't really have any semantic
> changes.
> 
> It's literally only that last patch in the series that then changes
> that meaning of "vm_ops". And I don't really _mind_ that last step
> either, but since we don't know exactly what it was that it broke, and
> we're past rc7, I don't think we really have any option but the revert
> it.
> 
> And if we revert it, I think we need to just remove the
> VM_BUG_ON_VMA() that it was supposed to fix. Because I do think that
> it is quite likely that the real bug is that overzealous BUG_ON(),
> since I can't see any reason why anonymous mappings should be special
> there.
> 
> But I'm certainly also ok with re-visiting that commit later.  I just
> think that right _now_ the above is my preferred plan.
> 
> Kirill?

Considering the timing, I'm okay with reverting the last patch with
dropping the VM_BUG_ON_VMA().

But in the end I would like to see strong vma_is_anonymous().

The VM_BUG_ON_VMA() is only triggerable by the test case because
vma_is_anonymous() false-positive in fault path and we get anon-THP
allocated in file-private mapping.

I don't see immediately how this may trigger other crashes.
But it definitely looks wrong.

> > I'm all for deleting that VM_BUG_ON_VMA() in zap_pmd_range(), it was
> > just a compromise with those who wanted to keep something there;
> > I don't think we even need a WARN_ON_ONCE() now.
> 
> So to me it looks like a historical check that simply doesn't
> "normally" trigger, but there's no reason I can see why we should care
> about the case it tests against.

I'll think more on what could go wrong with __split_huge_pmd() called on
anon-THP page without mmap_sem(). It's not yet clear cut to me.


-- 
 Kirill A. Shutemov
