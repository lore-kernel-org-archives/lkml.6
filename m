Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07A9C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3D02184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g7TozyAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfAWU1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:27:45 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42710 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfAWU1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:27:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so3157936lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDfZ035GKrH1GIAaUIA14ZhvfHWjaHvHCf05UvEOp58=;
        b=g7TozyAr/TjlyP/pj0UDRVzDDsvR3kAUFSxxPmVW5Kf+mSJT0VpQZ2TFgJ0xW0gsNh
         JeEA2KmzeYsEySIspPK22HdB9Dx9Fo7UXTKXBgFtm/fQBocUpVYGoSXmaEqGv1nLKa70
         wpaoxnVihOxqnAcYAIt6fmk0R5xaGGxsN83rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDfZ035GKrH1GIAaUIA14ZhvfHWjaHvHCf05UvEOp58=;
        b=CuzDYwrzb+7BHQ0Bjg8DgSohwnjOgTZm4DM7tm/Cs63KgoeHwxRctHLNZVa8OQLHkH
         effYxSaDGQWLs1HCHSP4XTgnyS4kg0dIjHvNUfoFoMF9RRupNI4I9dUzWT+vtGhYPLB6
         8QqpMbndpLrH1IXLsW5q55MV0SkQ3dG4g1m4HJeeH3VILOKo1AncCO/7WjLZ3CkCeJqo
         Ok4W0GPuygzcFbNdcNu1bxkW/wAyfpR+dOF+hqUkyDAOX1cAMrOucMmPXuA1RYhPI17n
         INGIYc/lArs/IlXUxjAvSbPJHMnyYarALaU3uq2L+AaXz1Oc6Xj1IbggCUERHK4/XQfh
         ucEA==
X-Gm-Message-State: AJcUukfX0EmPDLGgxzTUQYVpB0u6IyJDb8QOWXKT403O2e9gKYTJ11as
        vS+rLNrEi1dDctMiUo4aEZr3SGOt/7/ChQ==
X-Google-Smtp-Source: ALg8bN5/Ba6fiMj/uw8LoFAP1Jm+JGmkG3D4mTRjf6jjDvWeqyyBdaIG6bhCkNCzIxesRF1P3qgwgg==
X-Received: by 2002:a2e:8596:: with SMTP id b22-v6mr3196316lji.122.1548275261952;
        Wed, 23 Jan 2019 12:27:41 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id z6sm636233lfa.87.2019.01.23.12.27.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:27:38 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id n18-v6so3153978lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:27:38 -0800 (PST)
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr3213844ljk.4.1548275258095;
 Wed, 23 Jan 2019 12:27:38 -0800 (PST)
MIME-Version: 1.0
References: <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com> <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
 <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net> <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com>
 <20190116054613.GA11670@nautica> <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
 <nycvar.YFH.7.76.1901161710470.6626@cbobk.fhfr.pm> <CAHk-=wgsnWvSsMfoEYzOq6fpahkHWxF3aSJBbVqywLa34OXnLg@mail.gmail.com>
 <nycvar.YFH.7.76.1901162120000.6626@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1901162120000.6626@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Jan 2019 09:27:21 +1300
X-Gmail-Original-Message-ID: <CAHk-=wg+C65FJHB=Jx1OvuJP4kvpWdw+5G=XOXB6X_KB2XuofA@mail.gmail.com>
Message-ID: <CAHk-=wg+C65FJHB=Jx1OvuJP4kvpWdw+5G=XOXB6X_KB2XuofA@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Josh Snyder <joshs@netflix.com>,
        Dave Chinner <david@fromorbit.com>,
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

On Thu, Jan 17, 2019 at 9:23 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> So I've done some basic smoke testing (~2 hours of LTP+xfstests) on the
> kernel with the three topmost patches from
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/jikos/jikos.git/log/?h=pagecache-sidechannel
>
> applied (also attaching to this mail), and no obvious breakage popped up.
>
> So if noone sees any principal problem there, I'll happily submit it with
> proper attribution etc.

So this seems to have died down, and a week later we seem to not have
a lot of noise here any more. I think it means people either weren't
testing it, or just didn't find any real problems.

I've reverted the 'let's try to just remove the code' part in my tree.
But I didn't apply the two other patches yet. Any final comments
before that should happen?

                     Linus
