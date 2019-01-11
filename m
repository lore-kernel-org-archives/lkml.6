Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9327AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C79E20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HGj/rnID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfAKHLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:11:44 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42736 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfAKHLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:11:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so11980477lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 23:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ran2Tn+WYwgFy+GtFJyFcZV6eUa7NG8NL2k0jnbBh1A=;
        b=HGj/rnIDA7w/CWKwOeurlFEaqKK1al46Dss9ncxDgNiAUDZIPiSfmNpTdB8HWGfDQ4
         kODe24uzyisA3eqzkKr6meSOn6eXHpZ7y8yrZhOmS/w/6HQBmt5S8qPz140Wj61cp28G
         jSiHMmS3IietdkxIyexQ13K9ImtqvcYArprbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ran2Tn+WYwgFy+GtFJyFcZV6eUa7NG8NL2k0jnbBh1A=;
        b=r16mhnlOs6uHNwuTNQ522qf/yQsTt9xXarRIyRulQ2t8g1hCYEhFBcxxG2czpFJou2
         +t2bc5kDm22oHVyU28GstXdYB9QBuGM6oAd0tx6HgV0hPi/4e6rVDO5AqkZJeby7tEww
         H/l0gU97Ju5OWbnTSxAi2OU38qW9C3an5z2dHlVmGZQD62O4uVP381NQ+bQaQkujZfTx
         R+erNDRJFNVpfF/0QBD/3Fs7Jqq9voCwzaGdmvX73iLVZG3izn/UHFNb+R8JsBAGG1/e
         G+sSg+mzHIS971E/9vI3tVJCyZyJkHQaEd74ZKxfT905VqS56Tq6ZFPNGmNjigb3vYmf
         p4ZA==
X-Gm-Message-State: AJcUukcEzWWRquTJHIfvni9R6fsGnIIPTMkYTK5NCNirMrViyDIjvqZQ
        a9ImVhHdgSxuywSzEfkHIwPh2svCe/w=
X-Google-Smtp-Source: ALg8bN4DgLusrtviCm4tHjbEqQcLNhab5u57rDNc7tjEh/PGVIsRrvoBAe6UFUrbeiyAdnT/rBaung==
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr6777782ljj.43.1547190701276;
        Thu, 10 Jan 2019 23:11:41 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id c22sm14496051lfd.88.2019.01.10.23.11.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 23:11:40 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id c16so10081537lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 23:11:40 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr7044684lfj.138.1547190699923;
 Thu, 10 Jan 2019 23:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <20190111045750.GA27333@nautica>
In-Reply-To: <20190111045750.GA27333@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jan 2019 23:11:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqfAdmmE+pR3O5zs=xtkd6A6ShyyCwpwSZ+341L=zVYw@mail.gmail.com>
Message-ID: <CAHk-=wiqfAdmmE+pR3O5zs=xtkd6A6ShyyCwpwSZ+341L=zVYw@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jiri Kosina <jikos@kernel.org>,
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

On Thu, Jan 10, 2019 at 8:58 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> I get on average over a few queries approximately a real time of 350ms,
> 230ms and 220ms immediately after drop cache and service restart, and
> 150ms, 60ms and 60ms after a prefetch (hand-wavy average over 3 runs, I
> didn't have the patience to do proper testing).
> (In both cases, user/sys are less than 10ms; I don't see much difference
> there)

But those numbers aren't about the mincore() change. That's just from
dropping caches.

Now, what's the difference with the mincore change, and without? Is it
actually measurable?

Because that's all that matters: is the mincore change something you
can even notice? Is it a big regression?

The fact that things are slower when they are cold in the cache isn't
the issue. The issue is whether the change to mincore semantics makes
any difference to real loads.

                Linus
