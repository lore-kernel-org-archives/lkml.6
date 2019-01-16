Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D53C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D222082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dMA7vAKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbfAPFeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:34:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46766 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAPFeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:34:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id y14so3858301lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LDxDttklbhpkSSFdds0eF04wkYvET9AjjK+yF2ZuPzE=;
        b=dMA7vAKe4Uxo13jLl7fuE02FkWSO9VLEtIiC20q6ryh7qGuilSEBxz0+EQjqTdCvH1
         dfnnNIrDVHLAmspi+kEutDaiSBDCjQXDDZeWLIuw36P0qGup094crertM7FqgpCuwxbz
         NTB7xxRsm9w7aa4NUnH42wRZALAPuidJQR0qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LDxDttklbhpkSSFdds0eF04wkYvET9AjjK+yF2ZuPzE=;
        b=cOWxsXTYC2bHNpWceLYAZMGhEbr66P5RBace4KmMVofrt/pUHpVzpAfXc5GzSJDYNL
         iC32LI4zc81qa9n4Rw9lHkwXFbYbHimhLTWdiM/EkakIIz+ZvjG9iuTtX/ofkFjmeRVz
         8QfiKuhxNUSdrBd+jC11mNQj+UVvGhUT+1vZKoVlg0eiqMbGdjvWGPohkeO37OqA2Kes
         ZMeEhyetRgO36f20/bEaKdS+gc8Jt7jtwzW0FpqhAQ7c0ZzFgJBaCsM9eHpFJXQQep5e
         x4oLZmUZN21CcDTbqFePTg5x1dsE/HNlNPWtzqK0AG3VLW3w8HUyl6R7Gv+f+XFExfU9
         93tg==
X-Gm-Message-State: AJcUukc9rfUWCueMj63HDS1xmLaeKYtXQDgc0GTUvDIkCPQ0oFZSsk/A
        8rUt6s0fQApmiqax7qGSRmJKY1XyRFo=
X-Google-Smtp-Source: ALg8bN7XYOrZVWbTMOs1R+J5/kaGf/pSF5ebd7t5HaStslBpkJ8Z6kHuJwV/q5xPoRPYLGLIXnJrKw==
X-Received: by 2002:ac2:4343:: with SMTP id o3mr5548267lfl.129.1547616859214;
        Tue, 15 Jan 2019 21:34:19 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id l21-v6sm851913lji.6.2019.01.15.21.34.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 21:34:19 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id k19-v6so4329143lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:34:18 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr4899089ljj.120.1547616858160;
 Tue, 15 Jan 2019 21:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com> <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
 <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net>
In-Reply-To: <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Jan 2019 17:34:01 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com>
Message-ID: <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Josh Snyder <joshs@netflix.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
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

On Wed, Jan 16, 2019 at 5:25 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> Something like CAP_DAC_READ_SEARCH might not be crazy.

I agree that it would work. In fact' it's what Jiri's patch basically
did. Except Jiri used CAP_SYS_ADMIN instead.

But that then basically limits it to root (or root-like with
capability masks), which is quite likely to not work in practice all
that well. That's why I wanted to find alternatives.

*Very* few people want to run their databases as root.

Jiri's original patch kind of acknowledged that by making the new test
be conditional, and off by default. So then it's a "only do this for
lockdown mode, because normal people won't find it acceptable".

And I'm not a huge fan of that approach. If you don't protect normal
people, then what's the point, really?

              Linus
