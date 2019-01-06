Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73ACC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 00:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD8C222B9
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 00:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DrY0B8uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfAFAXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 19:23:07 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38265 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfAFAXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 19:23:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so2757990lfk.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 16:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXpC9nTs/Gy04v0woM2MVm7mCFE7zuhC308r47ayVvI=;
        b=DrY0B8uoWPWa1RjKPnPb3r8ev+OuXLf3EnrQrWZahMYQCyQbAKLWGLn2KWWDqAEXra
         knZblOic5+lDI51aAoKR9myovivvtxrJVgamF860KwgWqLw4GasvfJyeM9V71Gqe0r5g
         PdmK2cJlGtOC5rpioE4BYhOVX6KAsN+xb79gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXpC9nTs/Gy04v0woM2MVm7mCFE7zuhC308r47ayVvI=;
        b=uIRQk5WlPxyUVe/hbSAq+JZMUGYwsROrR3xqaw3f8LeB9PeZ/RXzHqu3rWn+sJJ7NT
         GkqIEXdfFcEjSCWkKtnLFw6KN7+PdQMx6+OcLwKgiZ2mjdbZ3kVXqtE12mSZLrCxZyBK
         9eGaxjMRVGl6Ozo73bjvkOxBsTz6XnB0z0VaefEN1jfDF2xpewGRwxy2lR6dcYiMLVgL
         cyHfgL/KAPGdO23js/IarErKE5So6ezm802+wNQhSO0RhDCeQZTwzIHdZ92eiJBNCsrx
         NJu9UDnwiFUjBlxgE65Y5X19H8s/h2SNZaYTATNQN9amogiOyiaue0GtQUOID5XaW/Mv
         HhYA==
X-Gm-Message-State: AA+aEWZWeheKk+0F2o0rr1yxkjVQ11SX7Uoni1bEPtv+DtmKISzNIt0G
        lNobY0G+rC9nOiqcdU7XF9rM6iC3uMs=
X-Google-Smtp-Source: AFSGD/WdFzB3zr/+IIMbxx0CVhe3vSCqgSRIUHy7SRPi4R7BEwh79G4I9YSOIQ7E4s3FzumbCd5bOA==
X-Received: by 2002:a19:518d:: with SMTP id g13mr27057141lfl.143.1546734184684;
        Sat, 05 Jan 2019 16:23:04 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id j18-v6sm13052338ljc.52.2019.01.05.16.23.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 16:23:03 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id z13so27768002lfe.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 16:23:03 -0800 (PST)
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr29443371lfg.117.1546734182916;
 Sat, 05 Jan 2019 16:23:02 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com>
 <CAHk-=whL4sZiM=JcdQAYQvHm7h7xEtVUh+gYGYhoSk4vi38tXg@mail.gmail.com>
 <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
 <CAHk-=wiMQeCEKESWTmm15x79NjEjNwFvjZ=9XenxY7yH8zqa7A@mail.gmail.com> <20190106001138.GW6310@bombadil.infradead.org>
In-Reply-To: <20190106001138.GW6310@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 16:22:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
Message-ID: <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Jiri Kosina <jikos@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 4:11 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> FreeBSD claims to have a manpage from SunOS 4.1.3 with mincore (!)
>
> https://www.freebsd.org/cgi/man.cgi?query=mincore&apropos=0&sektion=0&manpath=SunOS+4.1.3&arch=default&format=html
>
> DESCRIPTION
>        mincore()  returns  the primary memory residency status of pages in the
>        address space covered by mappings in the range [addr, addr + len).

It's still not clear that "primary memory residency status" actually means.

Does it mean "mapped", or does it mean "exists in caches and doesn't need IO".

I don't even know what kind of caches SunOS 4.1.3 had. The Linux
implementation depends on the page cache, and wouldn't work (at least
not very well) in a system that has a traditional disk buffer cache.

Anyway, I guess it's mostly moot. From a "does this cause regressions"
standpoint, the only thing that matters is really whatever Linux
programs that have used this since it was introduced 18+ years ago.

But I think my patch to just rip out all that page lookup, and just
base it on the page table state has the fundamental advantage that it
gets rid of code. Maybe I should jst commit it, and see if anything
breaks? We do have options in case things break, and then we'd at
least know who cares (and perhaps a lot more information of _why_ they
care).

                     Linus
