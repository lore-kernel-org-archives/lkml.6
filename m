Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B155C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22896208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZP1x7qD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22896208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeH0TQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:16:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37716 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeH0TQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:16:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id j8-v6so12307191lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Dgcbtv6XW/rq9Ilgf43SWMMqfSuJhvOEOCTFb5E748=;
        b=PZP1x7qD+LILEkZVIcHQs+IPhU77PUu8vQWhAWzKlntplYvs75ajaPm93arNxhAWUt
         n/r7DxvZVJYTaAVOX+dCUnL7yHTJClrIdJ1ptsaeLWVwirag3muQz+TyMvyrrp+SxmJ9
         so9PnAZoLejIqPpLwZ/Zb6Bm/Uk7JgQRmLU7C/RtIdn8Ya5mUljBa9uvoz6GWCHn79I5
         NnUONdSk/E9SWAkp+YOMbZwAZ9bRfXesSKFUl7M164lKSnXMmRmt+a+WjakTR4EwsJd7
         6uaTar6NJ/sqlT2tyMpfxM6XsU1MUmVE1D2lb6AgeU3bMJyVrQV6TNyl4rDft3lb3RGa
         iRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Dgcbtv6XW/rq9Ilgf43SWMMqfSuJhvOEOCTFb5E748=;
        b=OwFWay3HmvZ7aukZitPkIlUM2cLWxhgu4jDJ1GnD1O1uK84AIWqKsv7d3fMzksXB9a
         qnGnzdrJbhI9SJMecy1bVupjwSpI2E9Cqot9t2A1XKI1y33b0+H+nYHKWdyKIjGByaUK
         7SKvVwCxLCT2sORYW2Z8M7Sq7mYAWlhBIoubRT9j0+3ds292njpxSjHhXxAv/J/3HcdV
         rN3sUiITCEzYdwpND8Y/7CUjGWHAbyg6YW6Gjpxc5L8yx4jeeidRAg+mNy9Hn6ghUs40
         t92zFX/E4uj1HyoJdQIDBn1ZkGl1lGdAhFGnxaKr7tnnLrTusmhRdVgEbq8E/VRU+A02
         gMDA==
X-Gm-Message-State: APzg51BYUabVTjZ+KEn3Fh7bAKk4+im+5AysLRyXvZaK7B1o88tmZLcY
        m5VRrwELh7DaYCqY5oL+eSzw0Z5uUXzdJh6VtC4=
X-Google-Smtp-Source: ANB0Vda+JvlJlPPO8P8b5yGdTP5SOz0R7JaH5lL7N4q685i3J5OsoBHmZaC/k3/OOwwS9AH4XF4KD5SlYzDp1enJr/U=
X-Received: by 2002:a19:1ac8:: with SMTP id a191-v6mr3935528lfa.54.1535383736668;
 Mon, 27 Aug 2018 08:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180703123910.2180-1-willy@infradead.org> <20180703123910.2180-2-willy@infradead.org>
 <alpine.DEB.2.21.1807161116590.2644@nanos.tec.linutronix.de>
 <CAFqt6zbgoTgw1HNp+anOYY8CiU1BPoNeeddsnGGXWY_hVOd5iQ@mail.gmail.com> <alpine.DEB.2.21.1808031503370.1745@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808031503370.1745@nanos.tec.linutronix.de>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 27 Aug 2018 21:01:48 +0530
Message-ID: <CAFqt6zbJq9kca8dHDVAs-MOWNZgo2C=id3Cp4M0C76MQDXevJg@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86: Convert vdso to use vm_fault_t
To:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 6:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 3 Aug 2018, Souptick Joarder wrote:
> > On Mon, Jul 16, 2018 at 2:47 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > On Tue, 3 Jul 2018, Matthew Wilcox wrote:
> > >
> > >> Return vm_fault_t codes directly from the appropriate mm routines instead
> > >> of converting from errnos ourselves.  Fixes a minor bug where we'd return
> > >> SIGBUS instead of the correct OOM code if we ran out of memory allocating
> > >> page tables.
> > >>
> > >> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> > >
> > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > >
> >
> > Thomas, are these 3 patches part of this series will be queued
> > for 4.19 ?
>
> I don't know. I expected that these go through the mm tree, but if nobody
> feels responsible, I could pick up the whole lot. But I'd like to see acks
> from the mm folks for [1/3] and [3/3]
>
>   https://lkml.kernel.org/r/20180703123910.2180-1-willy@infradead.org
>
> Thanks,
>
>         tglx
>

Any comment from mm reviewers for patch [1/3] and [3/3] ??

https://lkml.kernel.org/r/20180703123910.2180-1-willy@infradead.org
