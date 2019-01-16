Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22879C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25452082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QWHBTSl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbfAPEzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 23:55:13 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44698 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732117AbfAPEzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 23:55:13 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so3817902lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 20:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9dT6Z1C6XjxVvtC/JI24HhxwtHBgNAG7wWwQyTEeC8g=;
        b=QWHBTSl2+YiO/WzrvJahbbQ87bpLZ6/onh/Kp5srLGkZrYPlaN6oukCtm1Z0AT1LYO
         HLIcgFSc+gs7NYsU09HhM39Ym/DIXj/Veu+3Ku/WQn/1IYdcRQ6YkKQPT4jpWtQ4IQkz
         Qll14RPpm50bpXY+tnYbA7BNDP+sTXeHXafdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9dT6Z1C6XjxVvtC/JI24HhxwtHBgNAG7wWwQyTEeC8g=;
        b=DZoGbrfLU+wEPW2HI7DTMQIWDjAqcTTHuIRLtXAyk8ALpt70u2UDE4yiUdiWFMWJtQ
         25Nv2aBzzMJm6dzgOwlry1YufgbMC3BPWneTsKG9eZ14qerQiR3lOvzNrK/QX7+C6lG0
         E0Ye4dm2Ld6y1s46Ljk52L4ArDPD5OJthw6hbp8ORzHEtQ4ruLbVI4TCUqN4RQy1jCRV
         gvNjQ563CY/PSYVZ4XeBRRhTnGY3ePTGuOwiN+mQ0FecAhDB9jjTM+nmKMNUeoC5RbDs
         K5+R0rbDMaZTBDv9W+ZGz2hNsW29mOaW66KxrDV7YPhPaL67g+4iYGH0FNtmHLPJsJcf
         os8g==
X-Gm-Message-State: AJcUukflGmyarVqSMOUWpUKxGzdYki1e0lksGBwq3Adea8lYpcQxmgTJ
        AzyYHwznRxBUOw+x4qcwCR+s31haldo=
X-Google-Smtp-Source: ALg8bN6cl1dddm1y3KRMKX+ELr8UZvMpaK34EOkySadUkRtp3MLFjhzVDD6BNzdJb4G5d1u/IoQ3Vg==
X-Received: by 2002:a19:41c4:: with SMTP id o187mr5548514lfa.32.1547614510434;
        Tue, 15 Jan 2019 20:55:10 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id h22-v6sm845265ljg.24.2019.01.15.20.55.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 20:55:07 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id n18so3844393lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 20:55:07 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr5021271lff.16.1547614506503;
 Tue, 15 Jan 2019 20:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <20190111020340.GM27534@dastard> <CAHk-=wgLgAzs42=W0tPrTVpu7H7fQ=BP5gXKnoNxMxh9=9uXag@mail.gmail.com>
 <20190111040434.GN27534@dastard> <CAHk-=wh-kegfnPC_dmw0A72Sdk4B9tvce-cOR=jEfHDU1-4Eew@mail.gmail.com>
 <20190111073606.GP27534@dastard> <CAHk-=wj+xyz_GKjgKpU6SF3qeqouGmRoR8uFxzg_c1VpeGEJMw@mail.gmail.com>
 <20190115234510.GA6173@dastard>
In-Reply-To: <20190115234510.GA6173@dastard>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Jan 2019 16:54:49 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjc2inOae8+9-DK4jFK78-7ZpNR=TEyZg0Dj57SYwP-ng@mail.gmail.com>
Message-ID: <CAHk-=wjc2inOae8+9-DK4jFK78-7ZpNR=TEyZg0Dj57SYwP-ng@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
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

On Wed, Jan 16, 2019 at 11:45 AM Dave Chinner <david@fromorbit.com> wrote:
>
> I'm assuming that you can invalidate the page cache reliably by a
> means that does not repeated require probing to detect invalidation
> has occurred. I've mentioned one method in this discussion
> already...

Yes. And it was made clear to you that it was a bug in xfs dio and
what the right thing to do was.

And you ignored that, and claimed it was a feature.

Why do you then bother arguing this thing? We absolutely agree that
xfs has an information leak. If you don't care, just _say_ so. Don't
try to argue against other people who are trying to fix things.

We can easily just say "ok, xfs people don't care", and ignore the xfs
invalidation issue. That's fine.

But don't try to make it a big deal for other filesystems that _don't_
have the bug. I even pointed out how ext4 does the page cache flushing
correcrly. You pooh-poohed it.

You can't have it both ways.

Either you care or you don't. If you don't care (and so far everything
you said seems to imply you don't), then why are you even discussing
this? Just admit you don't care, and we're done.

                  Linus
