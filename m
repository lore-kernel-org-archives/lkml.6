Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F247EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31302086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="amwtGCvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfAREtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:49:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43227 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfAREtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:49:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so10504007lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 20:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gqf9qHHa0eKIHV+14V27XEKAlPK94YNO0a+RM1lW6M0=;
        b=amwtGCvKbkeY8xeTsPStBlygztpu7+NzIWZeZMInmmPPgYzP70KMKK+wXQun03oZTL
         4gaqpdKCC94C/fIW4letO9lVl33BumTvbRz3lEu44trR3vQ/1GBqPj4MtSJ6uCOREp/d
         /2WdUfwUpfb1hyWXK5ciVRMxO8irBXFtrq4F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gqf9qHHa0eKIHV+14V27XEKAlPK94YNO0a+RM1lW6M0=;
        b=GaC0415dFXd7S39+73HK29B5gAu8a39BI7JmX64Q+SH48qcpeCNWa6Tv8VIqpdYFSG
         MajbDqJmk/OxZnB3scZHjkHp7it9lamgVELRPq3/Vr3LBGYpGqSMOSlm6zAUvt0mik/R
         sjl7Ezr5T7tLz151U1ttjqsL68g9dgT2DNaGnDU7PJ9ewnI33q8R2f73UBZCK5NSvVjK
         4dYQdjt5WRQ2KCBWwbqXFag09cQPQ8ltNPddILf1bUrlQzt3ggRoNy+8w4hmDqQL9309
         jGpPj+ces6X2j82+zYTiPyN3jntpset3mNBoBBLPTfxfG+y9Yb6yK3us6YagOsu5f4ld
         gXIA==
X-Gm-Message-State: AJcUukckAOb14ZNTHgUtfyKYhjHgogevZ5ZInAAmolstxFOaYIi8FVGJ
        Jby/nED8qARnYlYYt/7bJosIN6xA5dE=
X-Google-Smtp-Source: ALg8bN7+Cch9u7JbVT2XEexAn7qSFZgByyldXwe5U3/wf+khoyRs6VQcj8nrPBnWJPFtjQ4O/tXC+g==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr10873945ljj.49.1547786989102;
        Thu, 17 Jan 2019 20:49:49 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id v5-v6sm550448lje.78.2019.01.17.20.49.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 20:49:47 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id a8so9541001lfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 20:49:47 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr11103285lff.16.1547786987162;
 Thu, 17 Jan 2019 20:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com> <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
 <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net> <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com>
 <20190116054613.GA11670@nautica> <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
 <20190116063430.GA22938@nautica> <CA+t-nXTfdo07EBvVo+mu8SRhrVyB=mEPLDQikHfpJue1jALJtQ@mail.gmail.com>
 <a056deb7-9c11-612e-2b3a-6482acca4ff6@suse.cz>
In-Reply-To: <a056deb7-9c11-612e-2b3a-6482acca4ff6@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jan 2019 16:49:30 +1200
X-Gmail-Original-Message-ID: <CAHk-=wi0MXm4zTC6jjS1TBfbHW_sQq_OcyfeLBNGJ29m88pt+g@mail.gmail.com>
Message-ID: <CAHk-=wi0MXm4zTC6jjS1TBfbHW_sQq_OcyfeLBNGJ29m88pt+g@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Josh Snyder <joshs@netflix.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
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

On Fri, Jan 18, 2019 at 9:45 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Or maybe we could resort to the 5.0-rc1 page table check (that is now being
> reverted) but only in cases when we are not allowed the page cache residency
> check? Or would that be needlessly complicated?

I think it would  be good fallback semantics, but I'm not sure it's
worth it. Have you tried writing a patch for it? I don't think you'd
want to do the check *when* you find a hole, so you'd have to do it
upfront and then pass the cached data down with the private pointer
(or have a separate "struct mm_walk" structure, perhaps?

So I suspect we're better off with the patch we have. But if somebody
*wants* to try to do that fancier patch, and it doesn't look
horrendous, I think it might be the "quality" solution.

              Linus
