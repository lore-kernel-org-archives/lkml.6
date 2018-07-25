Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55B0C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A06F20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZ25xIKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A06F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbeGYUCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:02:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37607 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbeGYUCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:02:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so8344717wrd.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 11:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pit0IoZyKRuBV/BUuheLw/fR9l4naQRoQX7O+ZI0jg0=;
        b=YZ25xIKdwmjFrN0eqNrvH7s9nb26wI86heyqsg/QRGY1ALqyao6QW8uRdzfw8+r49m
         oXimGai3l2RmI7rpKvHEClbZ7hlGJCgZrXjmG13IvUdwmuGSsgmQn/at7G82m75zQLfk
         3MSl7y44RdzSiqfQXpy6MFNXskc/yZMlBl8u0k9ABsQBC5yaLLop/LsfxnlMV2vDra6c
         y/xbvjKDP43tU9llBtscudKR9BM6yPNYD3BRWXjZir5+c/5tOCK+B8nh7DHFuPrr0lnI
         crUQkSVpUg4TqwaxzGKz1+TXmvPvFtmtKpFug5XddviggSJ43RCl8M1lEq+BXjWicRsl
         tRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pit0IoZyKRuBV/BUuheLw/fR9l4naQRoQX7O+ZI0jg0=;
        b=nlgeA9a6mGuZLS1Vg9Ignyr3QfiZNOXJpIaHZeUzCXUxwsI6svBqg89U8YdU6PiljK
         CmG7hJljr89+pGdJvyyZorvWphT7ZBQTTX4Akcx14vvtN0AvUYjQOEJ6h2V+0cjhcf3k
         EYQO0cZ6zYwAQJyePTqK4DrG1a/QQpcBDMTIF9lxXqjGZhL4zOTubaPKho3j3WibQBAl
         9SeNZeq+RDKHSPIyuChAoLunUJb1KH70M1/7VbrBEyi6v3/kBBeT2zrduyx8IzR09jR3
         1R48Gu59XMJrUmS3bBGAGyaliYuxfVvoXpoMXSE66JrjT3WW1ICwZ4Gsbwh7FOXakZeN
         I0kQ==
X-Gm-Message-State: AOUpUlGNskOee1cpGZoAyeeRgU9w0FmN1NRm+EfPPZ1iIuzvY42GqHM8
        CViN6dkWsVmClCOMHLVeBsAHYnjyomutPKCf6Bk9Tg==
X-Google-Smtp-Source: AAOMgpcvQxNZ351sfLYCqwjYZqNg01c6cObUhs5bi2sy4I34kk8WYkHU1vxbQ8r5YIlkTZSRPsFrAD5RlqGx9VCpz48=
X-Received: by 2002:adf:adc9:: with SMTP id w67-v6mr14809904wrc.135.1532544541809;
 Wed, 25 Jul 2018 11:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180724210923.GA20168@bombadil.infradead.org>
 <20180725023728.44630-1-cannonmatthews@google.com> <DF4PR8401MB11806B9D2A7FE04B1F5ECBF8AB540@DF4PR8401MB1180.NAMPRD84.PROD.OUTLOOK.COM>
 <CAJfu=Uf98_FBNkULq5RD6dapY5K6gL=Xm7DOSJJVscDfKkwq0Q@mail.gmail.com> <20180725182303.GA1366@bombadil.infradead.org>
In-Reply-To: <20180725182303.GA1366@bombadil.infradead.org>
From:   Cannon Matthews <cannonmatthews@google.com>
Date:   Wed, 25 Jul 2018 11:48:50 -0700
Message-ID: <CAJfu=UecUoAiSy48sJXVuzoRzzvhoJzvKXc_xgNW5BKX-vFE7Q@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: clear 1G pages with streaming stores on x86
To:     willy@infradead.org
Cc:     elliott@hpe.com, mhocko@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andres Lagar-Cavilla <andreslc@google.com>,
        Salman Qazi <sqazi@google.com>, Paul Turner <pjt@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Alain Trinh <nullptr@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:23 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jul 25, 2018 at 10:30:40AM -0700, Cannon Matthews wrote:
> > On Tue, Jul 24, 2018 at 10:02 PM Elliott, Robert (Persistent Memory)
> > > > +     BUG_ON(pages_per_huge_page % PAGES_BETWEEN_RESCHED != 0);
> > > > +     BUG_ON(!dest);
> > >
> > > Are those really possible conditions?  Is there a safer fallback
> > > than crashing the whole kernel?
> >
> > Perhaps not, I hope not anyhow,  this was something of a first pass
> > with paranoid
> > invariant checking, and initially I wrote this outside of the x86
> > specific directory.
> >
> > I suppose that would depend on:
> >
> > Is page_to_virt() always available and guaranteed to return something valid?
> > Will `page_per_huge_page` ever be anything other than 262144, and if so
> > anything besides 512 or 1?
>
> page_to_virt() can only return NULL for HIGHMEM, which we already know
> isn't going to be supported.  pages_per_huge_page might vary in the
> future, but is always going to be a power of two.  You can turn that into
> a build-time assert, or just leave it for the person who tries to change
> gigantic pages from being anything other than 1GB.
>
> > It seems like on x86 these conditions will always be true, but I don't know
> > enough to say for 100% certain.
>
> They're true based on the current manuals.  If Intel want to change them,
> it's fair that they should have to change this code too.

Thanks for the confirmations!

>
> > Before I started this I experimented with all of those variants, and
> > interestingly found that I could equally saturate the memory bandwidth with
> > 64,128, or 256bit wide instructions on a broadwell CPU ( I did not have a
> > skylake/AVX-512 machine available to run the tests on, would be a curious
> > thing to see it it holds for that as well).
> >
> > >From userspace I did a mmap(MAP_POPULATE), then measured the time
> >  to zero a 100GiB region:
> >
> > mmap(MAP_POPULATE):     27.740127291
> > memset [libc, AVX]:     19.318307069
> > rep stosb:              19.301119348
> > movntq:                 5.874515236
> > movnti:                 5.786089655
> > movtndq:                5.837171599
> > vmovntdq:               5.798766718
> >
> > It was interesting also that both the libc memset using AVX
> > instructions
> > (confirmed with gdb, though maybe it's more dynamic/tricksy than I know) was
> > almost identical to the `rep stosb` implementation.
> >
> > I had some conversations with some platforms engineers who thought this made
> > sense, but that it is likely to be highly CPU dependent, and some CPUs might be
> > able to do larger bursts of transfers in parallel and get better
> > performance from
> > the wider instructions, but this got way over my head into hardware SDRAM
> > controller design. More benchmarking would tell however.
> >
> > Another thing to consider about AVX instructions is that they affect core
> > frequency and power/thermals, though I can't really speak to specifics but I
> > understand that using 512/256 bit instructions and zmm registers can use more
> > power and limit the  frequency of other cores or something along those
> > lines.
> > Anyone with expertise feel free to correct me on this though. I assume this is
> > also highly CPU dependent.
>
> There's a difference between using AVX{256,512} load/store and arithmetic
> instructions in terms of power draw; at least that's my recollection
> from reading threads on realworldtech.  But I think it's not worth
> going further than you have.  You've got a really nice speedup and it's
> guaranteed to be faster on basically every microarch.  If somebody wants
> to do something super-specialised for their microarch, they can submit
> a patch on top of yours.

Good point, that was a subtly that escaped my recollection. In particular I've
also been told that using the zmm registers has power/thermal penalties as
well, though xmm/ymm is OK as long as you don't wake up the multipliers
at least on specific microarches.

Nonetheless I agree, we can start with this general one and leave room for
more specialized alternatives should anyone ever have the interest to build on
top of this.
