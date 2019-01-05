Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9616FC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6047D222F0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vy1s/+P5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfAEX2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 18:28:40 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42776 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfAEX2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 18:28:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so35243216lja.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 15:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5UH4pfWyQs4/o8iN9usZb3uixTnpzedXbZLwZju+Xnw=;
        b=Vy1s/+P5NMNsFNOwWt1LLInuk+ntWVFTDJtSxCVKVIIYg1AEnMy9K7h69QPpXAn/rN
         UOhyNwMdL3pZ6oNf2UkegmPg7nFD7KFdUN8yQWn4bRLdByG5iKDgxoDp9kYFnb9VIw38
         l3rvFtZebFJMWoGj3bmBaOAakkxYuwAU1ZZUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5UH4pfWyQs4/o8iN9usZb3uixTnpzedXbZLwZju+Xnw=;
        b=RC0dH7IVtIQErX0jw9D+qHpZTx5fg9nG3mI0WzpjVN4uesQy2ySjAJbNER7p9jrDv6
         M0krRlYibOQdyQuTa4Cchoe5ZeA5sAMPOCGhc0RJz/q4Srr/1LqNXTXlj+bP5OQcBNMw
         cPYJILRMatXA+WXRsMEXrSbZAXfwdqiXbaIBSB4oADRAL3kLnYlqdIohUJkgCm2pXBMI
         BrSaFb4Hnxq3INQwsWkM1gQUeUALoJl9nqmBCqLleWsSho4zao+JYO+krOXeBBlBhWWR
         cRWUicWZcjp6Xb+fuaPYJ6ZqqN+CAsZshhbBdPGwXZ/8UVZhA4bBEOMkP0XbF+e44vee
         +nGg==
X-Gm-Message-State: AJcUukeQkSJwpJippjNdIN8azPFCmPCmaHG5Em3Eh6iNhZ5eqlaQiX1g
        j4t1Fl0yFqso0iJ0/J6L+8jnpgt7XYs=
X-Google-Smtp-Source: AFSGD/UxDdU+yoaONijeu9xe20IPi9UUv0u1Tbj8k0tsGnmrQZzG8KhRw8tTLHqnsLWH8YkjY/TU6Q==
X-Received: by 2002:a2e:8596:: with SMTP id b22-v6mr31722184lji.122.1546730917804;
        Sat, 05 Jan 2019 15:28:37 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r7-v6sm13113820ljc.10.2019.01.05.15.28.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 15:28:36 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id u89-v6so35338395lje.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 15:28:35 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr15001293lji.133.1546730915544;
 Sat, 05 Jan 2019 15:28:35 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com>
 <CAHk-=whL4sZiM=JcdQAYQvHm7h7xEtVUh+gYGYhoSk4vi38tXg@mail.gmail.com> <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 15:28:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wie+SA1WCQ5nTKgvWyBUdTGxHjAOaoms-=Xu7-wC4j=Ag@mail.gmail.com>
Message-ID: <CAHk-=wie+SA1WCQ5nTKgvWyBUdTGxHjAOaoms-=Xu7-wC4j=Ag@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Jann Horn <jannh@google.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
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

On Sat, Jan 5, 2019 at 3:16 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It goes back to forever, it looks like. I can't find a reason.

Our man-pages talk abouit the "without doing IO" part. That may be the
result of our code, though, not the reason for it.

The BSD man-page has other flags, but doesn't describe what "in core"
really means:

     MINCORE_INCORE        Page is in core (resident).

     MINCORE_REFERENCED        Page has been referenced by us.

     MINCORE_MODIFIED        Page has been modified by us.

     MINCORE_REFERENCED_OTHER  Page has been referenced.

     MINCORE_MODIFIED_OTHER    Page has been modified.

     MINCORE_SUPER        Page is part of a large (``super'') page.

but the fact that it has MINCORE_MODIFIED_OTHER does obviously imply
that yes, historically it really did look up the pages elsewhere, not
just in the page tables.

Still, maybe we can get away with just making it be about our own page
tables. That would be lovely.

                 Linus
