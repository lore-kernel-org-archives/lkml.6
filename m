Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE94C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BB7218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BY9X9J/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfAWUfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:35:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46680 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfAWUfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:35:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so2579385lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKJLCHAPKT7F2kMasdD5CPgiqsCrm80NhZkTQRdPbiY=;
        b=BY9X9J/4+qqxYeGyF3R59zxkMjOBG19x6ckQ3lzQ8Ru+lHBQz5Wyx5u058TqaI8R+Z
         qAmOrx5ByYriMlr+YA0ByQJdlVx3veIJOEF+gI83DzB5PUQc/2ZZMGeD81NKhNvS3PWM
         /uSEKiKERYfDI2z3E2tUOXDOKJqrmctffswU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKJLCHAPKT7F2kMasdD5CPgiqsCrm80NhZkTQRdPbiY=;
        b=I5GAjG0P27YTqJFShZS5ifZTWTFypZfkHs3huwhqChPZifmU/wjn8PArICxx1yh7d+
         +Zi1Au9jgNFEV9nyVVuV3TlAdiP0A77NDC3TRDDoQJdRigQ/6ffbv5gSjd+wqqUJzJMg
         5j3m9KtT5SML7OmwZKiArHf3upjge65BDLfbpUgTWWFlpw7IKAsIwqopxnX5XM+mWWdv
         qOlChX17ZbnHhoVwmsSbITFfKsWZp8fxuwbDqwWj/beXAM0nHb1ouJsCIYQJOfYWx63t
         CWYpku3U5ESR2b0O6arZDkp2jraignfZSgn9cyVjn5gGk7rXw0UUqXO2gili7KELplQp
         HH/Q==
X-Gm-Message-State: AJcUukeW266sbn0pp2he/bxUMs93M1pYMhT/bA8k1gHJGYy+Y6If+t2n
        aEKNAoI+6+BTJNVjmIPXapCEp1Z/hwoQbg==
X-Google-Smtp-Source: ALg8bN7zroQrJgGhndl49yS6GR4Z04Y5HDKOASncLEWpRJiPtpUTekkUNqMujYUVzz1Z84CO4EbNwA==
X-Received: by 2002:a19:a28e:: with SMTP id l136mr3000840lfe.87.1548275750830;
        Wed, 23 Jan 2019 12:35:50 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id v64sm635729lfa.48.2019.01.23.12.35.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:35:49 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id v15-v6so3152862ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:35:49 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr3388044ljh.174.1548275749194;
 Wed, 23 Jan 2019 12:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com> <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
 <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net> <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com>
 <20190116054613.GA11670@nautica> <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
 <nycvar.YFH.7.76.1901161710470.6626@cbobk.fhfr.pm> <CAHk-=wgsnWvSsMfoEYzOq6fpahkHWxF3aSJBbVqywLa34OXnLg@mail.gmail.com>
 <nycvar.YFH.7.76.1901162120000.6626@cbobk.fhfr.pm> <CAHk-=wg+C65FJHB=Jx1OvuJP4kvpWdw+5G=XOXB6X_KB2XuofA@mail.gmail.com>
In-Reply-To: <CAHk-=wg+C65FJHB=Jx1OvuJP4kvpWdw+5G=XOXB6X_KB2XuofA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Jan 2019 09:35:32 +1300
X-Gmail-Original-Message-ID: <CAHk-=wgy+1YT-Rhj5qWb_aCuBADhcq42GDKHB74sqrnOVPKzPg@mail.gmail.com>
Message-ID: <CAHk-=wgy+1YT-Rhj5qWb_aCuBADhcq42GDKHB74sqrnOVPKzPg@mail.gmail.com>
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

On Thu, Jan 24, 2019 at 9:27 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've reverted the 'let's try to just remove the code' part in my tree.
> But I didn't apply the two other patches yet. Any final comments
> before that should happen?

Side note: the inode_permission() addition to can_do_mincore() in that
patch 0002, seems to be questionable. We do

+static inline bool can_do_mincore(struct vm_area_struct *vma)
+{
+       return vma_is_anonymous(vma)
+               || (vma->vm_file && (vma->vm_file->f_mode & FMODE_WRITE))
+               || inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
+}

note how it tests whether vma->vm_file is NULL for the FMODE_WRITE
test, but not for the inode_permission() test.

So either we test unnecessarily in the second line, or we don't
properly test it in the third one.

I think the "test vm_file" thing may be unnecessary, because a
non-anonymous mapping should always have a file pointer and an inode.
But I could  imagine some odd case (vdso mapping, anyone?) that
doesn't have a vm_file, but also isn't anonymous.

Anybody?

Anyway, it's one reason why I didn't actually apply those other two
patches yet. This may be a 5.1 issue..

                   Linus
