Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A6AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0144820851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C6MlEvjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfAQEwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 23:52:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33229 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbfAQEwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 23:52:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so6778602lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 20:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yg/fey2gwxJ3j2bGARMVT/eRJirMo8WI+36rgecn44=;
        b=C6MlEvjFBkcWofmUUmP+orz3WZY5+zYliTWZFP0dxTKmc6y20wo/64FLm3lY/8d7uq
         zRUrUISklDIlgc9mcichrGZav7zNAit4hsMlYOxsvg/fQVAkEU+k/3J7nNx7BOUgMqHi
         snOWNxQuPFTwE3YsEekTQj4G0UD1pozuqEmEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yg/fey2gwxJ3j2bGARMVT/eRJirMo8WI+36rgecn44=;
        b=ECZicebYdoRTmhXLD2Iu48CYysHtlbwXD8dmSM0x9NuHSnJur46Wjew91fs/CLYQYK
         7gBcpOPlXW5JOMeTTOqLjwFUd9Guf02nPjO92Y5vszg14wqaMhZWGWVvCRtV9fZjMg9w
         7HCcZMb06tKVXP+3EJ+yGpOZjCsjVqRaE37q7vLM39nd5QL3olT0yc88AlEkg17Pnj+s
         DAHhbuBRq5orONvvT+FOdDrs7ah+RhIUg2VKjMrSsRIO/tVhFirh8BxYyTnr/eyi9+co
         6RaIjJS8YiitFx9tuH3ZYgsDAb7ehdogb/CMnp9p5FKtIvBXHnBzhaVg2TySTDFt97P1
         onbA==
X-Gm-Message-State: AJcUukfFroqs0Jiy/AxXPmddbvjg/Bn2KA51BKiVsF17RdS7daL7cD8T
        PRd8KArOYIZjpZkI3vl2nvGeF+DllTE=
X-Google-Smtp-Source: ALg8bN7+mjFZ2sbYyWDMjUAaC3+QoBBzSEHt7OyJbqIu8i7S9Us2THqBUBye9uZnT04kyoT5nY/JNw==
X-Received: by 2002:a19:739d:: with SMTP id h29mr9637871lfk.85.1547700723997;
        Wed, 16 Jan 2019 20:52:03 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p10-v6sm54619ljh.59.2019.01.16.20.52.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 20:52:02 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id n18-v6so7409676lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 20:52:02 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr8407355lja.148.1547700722094;
 Wed, 16 Jan 2019 20:52:02 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com> <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
 <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net> <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com>
 <20190116054613.GA11670@nautica> <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
 <nycvar.YFH.7.76.1901161710470.6626@cbobk.fhfr.pm> <CAHk-=wgsnWvSsMfoEYzOq6fpahkHWxF3aSJBbVqywLa34OXnLg@mail.gmail.com>
 <nycvar.YFH.7.76.1901162120000.6626@cbobk.fhfr.pm> <20190116213708.GN6310@bombadil.infradead.org>
In-Reply-To: <20190116213708.GN6310@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Jan 2019 16:51:44 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjciBwJo5JHcvUO+JAC13TUME1PH=ftsaNt+0RC-3PCSw@mail.gmail.com>
Message-ID: <CAHk-=wjciBwJo5JHcvUO+JAC13TUME1PH=ftsaNt+0RC-3PCSw@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Josh Snyder <joshs@netflix.com>,
        Dave Chinner <david@fromorbit.com>,
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

On Thu, Jan 17, 2019 at 9:37 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Your patch 3/3 just removes the test.  Am I right in thinking that it
> doesn't need to be *moved* because the existing test after !PageUptodate
> catches it?

That's the _hope_.

That's the simplest patch I can come up with as a potential solution.
But it's possible that there's some nasty performance regression
because somebody really relies on not even triggering read-ahead, and
we might need to do some totally different thing.

So it may be that somebody has a case that really wants something
else, and we'd need to move the RWF_NOWAIT test elsewhere and do
something slightly more complicated. As with the mincore() change,
maybe reality doesn't like the simplest fix...

> Of course, there aren't any tests for RWF_NOWAIT in xfstests.  Are there
> any in LTP?

RWF_NOWAIT is actually _fairly_ new.  It was introduced "only" about
18 months ago and made it into 4.13.

Which makes me hopeful there aren't a lot of people who care deeply.

And starting readahead *may* actually be what a RWF_NOWAIT read user
generally wants, so for all we know it might even improve performance
and/or allow new uses. With the "start readahead but don't wait for
it" semantics, you can have a model where you try to handle all the
requests that can be handled out of cache first (using RWF_NOWAIT) and
then when you've run out of cached cases you clear the RWF_NOWAIT
flag, but now the IO has been started early (and could overlap with
the cached request handling), so then when you actually do a blocking
version, you get much better performance.

So there is an argument that removing that one RWF_NOWAIT case might
actually be a good thing in general, outside of  the "don't allow
probing the cache without changing the state of it" issue.

But that's handwavy and optimistic. Reality is often not as accomodating ;)

                   Linus
