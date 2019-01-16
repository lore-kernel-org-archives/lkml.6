Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11A1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F02220859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PPNwGegn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbfAPF6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:58:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34491 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbfAPF6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:58:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so4426033lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZS1U4v3VDXUyEzZkch2LpzJzGSGpGfSwXpd93MlFK4=;
        b=PPNwGegng2NcNnY4scnYrVjmXI/IOp7EcDNxzrLfLqB1Z6oAmDCmQFBvGCPnpyNDak
         t+OaiqHTIpJ5WZRC0xGNwJ/DmR6oi4yJAQ1xfTGRPzfSsREsHHbLttRkZXqm3asv03xb
         D2ojNpW7Jvq3VlY3z0zP4wGyOck8ObDRQi2NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZS1U4v3VDXUyEzZkch2LpzJzGSGpGfSwXpd93MlFK4=;
        b=JPyq4JO+Y+8MY53dsMCtgmMb7mIGeP2OMFttf0UGTZs25TEMbl+65tQizvtzHpZcs7
         ARWCmnBMd3EcGqiv4ZPGJjeZYpD6SMYymmynwznf9vEkF4CN755WydEaAgc1ftGEwDOT
         wnVv6t3ddzrmDOvG9rdtlmD4EuyvQ0YOfwZtSORSDF4VzqscrKEPuqxyY3tZAKroHANS
         uvWFmeez0DdavA4K1hRRrhg4efWJnWggXLKJZ5AsoUwZZ00DRWafT+bBYtHVaunJtiE7
         r8QttChRBUPka0aL2yv0dZVf3RbgYa8cjwg2W5vXGWP76sM70YTn9nUihfCnQvhe4i7O
         L20Q==
X-Gm-Message-State: AJcUukck+Hx6319wdDg3k7Y99wHy//VHaJr0MLbo+iu13MqCYC05Q36k
        w6uaNgFCQLvJfUBL8hlPZ7Kr8vf/Kvs=
X-Google-Smtp-Source: ALg8bN6jt9B4YiFymp5OLcI7IP0SDkvfggYAYsrDoHs/ac0UBhEykeDnyVUN5Y631Rtqjt5AET9g9A==
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr5220180lji.57.1547618331595;
        Tue, 15 Jan 2019 21:58:51 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m21sm987239lfl.97.2019.01.15.21.58.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 21:58:50 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id e26so3939427lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:58:49 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr5557953lfa.135.1547618329349;
 Tue, 15 Jan 2019 21:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com> <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
 <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net> <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com>
 <20190116054613.GA11670@nautica>
In-Reply-To: <20190116054613.GA11670@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Jan 2019 17:58:32 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
Message-ID: <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Josh Snyder <joshs@netflix.com>,
        Dave Chinner <david@fromorbit.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
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

On Wed, Jan 16, 2019 at 5:46 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> "Being owner or has cap" (whichever cap) is probably OK.
> On the other hand, writeability check makes more sense in general -
> could we somehow check if the user has write access to the file instead
> of checking if it currently is opened read-write?

That's likely the best option. We could say "is it open for write, or
_could_ we open it for writing?"

It's a slightly annoying special case, and I'd have preferred to avoid
it, but it doesn't sound *compilcated*.

I'm on the road, but I did send out this:

    https://lore.kernel.org/lkml/CAHk-=wif_9nvNHJiyxHzJ80_WUb0P7CXNBvXkjZz-r1u0ozp7g@mail.gmail.com/

originally. The "let's try to only do the mmap residency" was the
optimistic "maybe we can just get rid of this complexity entirely"
version..

Anybody willing to test the above patch instead? And replace the

   || capable(CAP_SYS_ADMIN)

check with something like

   || inode_permission(inode, MAY_WRITE) == 0

instead?

(This is obviously after you've reverted the "only check mmap
residency" patch..)

            Linus
