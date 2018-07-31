Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931CEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EA3208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="wc+YSr1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EA3208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeGaQiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:38:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38158 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbeGaQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:38:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so9220694pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RGgn3PFXwcU9A9OnXHcqNNvMrbrHZqJ5jkILJrTmkpk=;
        b=wc+YSr1nLaUItVpldyFLJUwqKr01J1c45AI30PtCYloUkQz2WHchDDwYW5F54thWle
         D57d6vkwYBWrtILTBcZAsYh0MIANhZtAjREImV5z5rzEYzMEez6fW3vp1e7YZRgAjKIA
         ajvIwbr2JLEdB6XKAK8hhlRqANY0ARCcYEWefLO7UPwoiq21ChpGbg+4n0xynvTw6frp
         J3TkqRn7roLSasjzJNsDqBhnDYrbCc49UQ1z7N+C0vWrlYLFTLXf1KAs2U2WPce+Kg1R
         L84wCc+/xebON7ZPbRgdIxwhtnRWXMQpSZLm3nB0x4BlYfFcPEIMFSt8mWAGnuz697ca
         4NPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RGgn3PFXwcU9A9OnXHcqNNvMrbrHZqJ5jkILJrTmkpk=;
        b=bCJ2QTD5T94Etk4DtvkfjN8YCALbeGLhFpOPdCyuOVyGrAlhA4tCo7TUNmF13vc2eo
         VnXpksYTCTFRgPplv+1YP83Bm+PqvvNqkLe+1Rwd+dv5q7HA28y3KEOQb8qa6OYkUNUs
         uBzJGMpwFI8Hja41E6pT6lLO+9B0QkmuNzqKP8OniNcI5e29YwSOGwoe1/WlKrBda2ME
         e2wgjofoXMNvoZ3sS4AJGwRiXLCBUq4Eym9r69HoPY2zTcujKuom0dEYmsHt7tZu5MsO
         fX9s6Ug2dKisThNaJxM+WoDqpnfKGsdbFQH/a+WeAUQrt7/PxrSDpsyiC3lDrHot8PhR
         P3KA==
X-Gm-Message-State: AOUpUlFHFNTAAQNewsQccKUi+o2lpBegE6uLK9AcVTOeHlhEmO/PqEA2
        rAqBUlFxHWwfFmQdiksayRnLXQ==
X-Google-Smtp-Source: AAOMgpe+wxa/lPdNYvBHc2fe7573/6qdWF84Vc2hXfcvTRo1yJTc3Rk7iMQp1rNJfBeoUv+28JvrHg==
X-Received: by 2002:a63:e516:: with SMTP id r22-v6mr20405502pgh.170.1533049045427;
        Tue, 31 Jul 2018 07:57:25 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id y3-v6sm42973955pfi.24.2018.07.31.07.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 07:57:24 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4E9143002A5; Tue, 31 Jul 2018 17:57:19 +0300 (+03)
Date:   Tue, 31 Jul 2018 17:57:19 +0300
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
Message-ID: <20180731145718.pbyy3qkp2a2yvucs@kshutemo-mobl1>
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
 <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com>
 <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1>
 <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
 <alpine.LSU.2.11.1807301410470.4805@eggly.anvils>
 <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
 <20180731062927.hjknfcb2cj3bwd7b@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731062927.hjknfcb2cj3bwd7b@kshutemo-mobl1>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 09:29:27AM +0300, Kirill A. Shutemov wrote:
> On Mon, Jul 30, 2018 at 06:01:26PM -0700, Linus Torvalds wrote:
> > On Mon, Jul 30, 2018 at 2:53 PM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > I have no problem with reverting -rc7's vma_is_anonymous() series.
> > 
> > I don't think we need to revert the whole series: I think the rest are
> > all fairly obvious cleanups, and shouldn't really have any semantic
> > changes.
> > 
> > It's literally only that last patch in the series that then changes
> > that meaning of "vm_ops". And I don't really _mind_ that last step
> > either, but since we don't know exactly what it was that it broke, and
> > we're past rc7, I don't think we really have any option but the revert
> > it.
> > 
> > And if we revert it, I think we need to just remove the
> > VM_BUG_ON_VMA() that it was supposed to fix. Because I do think that
> > it is quite likely that the real bug is that overzealous BUG_ON(),
> > since I can't see any reason why anonymous mappings should be special
> > there.
> > 
> > But I'm certainly also ok with re-visiting that commit later.  I just
> > think that right _now_ the above is my preferred plan.
> > 
> > Kirill?
> 
> Considering the timing, I'm okay with reverting the last patch with
> dropping the VM_BUG_ON_VMA().
> 
> But in the end I would like to see strong vma_is_anonymous().
> 
> The VM_BUG_ON_VMA() is only triggerable by the test case because
> vma_is_anonymous() false-positive in fault path and we get anon-THP
> allocated in file-private mapping.
> 
> I don't see immediately how this may trigger other crashes.
> But it definitely looks wrong.
> 
> > > I'm all for deleting that VM_BUG_ON_VMA() in zap_pmd_range(), it was
> > > just a compromise with those who wanted to keep something there;
> > > I don't think we even need a WARN_ON_ONCE() now.
> > 
> > So to me it looks like a historical check that simply doesn't
> > "normally" trigger, but there's no reason I can see why we should care
> > about the case it tests against.
> 
> I'll think more on what could go wrong with __split_huge_pmd() called on
> anon-THP page without mmap_sem(). It's not yet clear cut to me.

I think not having mmap_sem taken at least on read when we call
__split_huge_pmd() opens possiblity of race with khugepaged:
khugepaged can collapse the page back to THP as soon as we drop ptl.
As result pmd_none_or_trans_huge_or_clear_bad() would return true and we
basically leave the THP behind, not zapped.

-- 
 Kirill A. Shutemov
