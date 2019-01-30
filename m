Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20340C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D320C218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOY7RZKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfA3Ke0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:34:26 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53752 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfA3KeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:34:25 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so9474937ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 02:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfmBU1SOE6jbN5pTRQsbsythjkmyR25xQoNf3627yp4=;
        b=QOY7RZKwfKsWRg8Fao3kQ/KZ9yh35Wv9PI8uFFENAMRHrZQD91DDxQ85HBDbm7YB9M
         Tc1X2HXvEYS0jNBrNJzoI0sMrEFKS8zP8WnoSN+A3ci79ktbqE43mhnOjRRto1W7eret
         5vg6kI+XZEMA+F5bWvI/60pVmDr+3yQBBrXa2Z8SfpY1GTpfqHAxcr5DROgvWP0BPzKA
         5Shh0RjLEB6kU9pAVDbmZhVL8yskuQ4EfP1acWV7Y74yE4L4ZIUnTtrtsTBJilYVKdg7
         y2d22OY31Eqkd5A+TB4v4tjQ4KTRnZfVNYZHtL3jUNsx+xP8/ec0SzgLhIOKqtkrxa7A
         yRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfmBU1SOE6jbN5pTRQsbsythjkmyR25xQoNf3627yp4=;
        b=Vmnh+cJfJblqx4bbty2vrh4EIiNGF4tWhN7qLGz4WeCXMHULoru9uHiYq8fAWIymjX
         FqbQepM1f5kor5c4+vjvPMnmU7wVDjM7odLTpk7jvzF13vQtahVu0tdGcB4qZimpi7g6
         BOJC4ClxhklIn10+KTkQutvXwokSvuYMKIItiH0+zkn7sUZMWoTfwmIaRUqT5bmmo2O8
         8SmrA4VB5fFwBoX70/PVxGOo7BA7Jgl17Voc8pnEDdFB5DDRRYcewYLWjTQuwbN+xClA
         135r5PTc7bKC9LBuGgsTWBzFnRvvPK0IHh/vDRgNd+IsTCkTVEoCfBYSc+ECPcP79kK8
         kEpQ==
X-Gm-Message-State: AJcUukc3VLngQqYizxtHKQP8OYENXk6X5dioTxXE2j0iYfFMD3UPsxOm
        l0CD29c03VNDc+MI6/ExpSXkF8cJCkBAr/ZmSn8bTPwgZTM=
X-Google-Smtp-Source: ALg8bN4O4Zl/xwsbodE1iNlKyGUQoNTKD8+EpwR9r2QMNNyF13MrHOQQz4T+lRUTQ+XT6lC0WqYNd2Fgs5U8rBHRCuk=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr12441472iti.166.1548844464475;
 Wed, 30 Jan 2019 02:34:24 -0800 (PST)
MIME-Version: 1.0
References: <1548677377-22177-1-git-send-email-elena.reshetova@intel.com>
 <CACT4Y+aw1L7u+WJb8Ug8ED2bESfZccVK3o_7OBbjyQbQrLskbg@mail.gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4B99139@IRSMSX102.ger.corp.intel.com>
 <20190130032701.GA3739@andrea> <2236FBA76BA1254E88B949DDB74E612BA4B9A2B5@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4B9A2B5@IRSMSX102.ger.corp.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 30 Jan 2019 11:34:13 +0100
Message-ID: <CACT4Y+Y2GFQ2dt2GiNP4k+9F1kYw3BzeqhBBJ-QzjZmSux9gHA@mail.gmail.com>
Subject: Re: [PATCH] refcount_t: add ACQUIRE ordering on success for
 dec(sub)_and_test variants
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 11:19 AM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
>  > So, you are saying that ACQUIRE does not guarantee that "po-later stores
> > > on the same CPU and all propagated stores from other CPUs
> > > must propagate to all other CPUs after the acquire operation "?
> > > I was reading about acquire before posting this and trying to understand,
> > > and this was my conclusion that it should provide this, but I can easily be wrong
> > > on this.
> > >
> > > Andrea, Peter, could you please comment?
> >
> > Short version:  I am not convinced by the above sentence, and I suggest
> > to remove it (as done in
> >
> >   http://lkml.kernel.org/r/20190128142910.GA7232@andrea ).
>
> Sorry, I misunderstood your previous email on this. I somehow misread it
> that " A-cumulative property" as a notion that is not used in LKMM for ACQUIRE,
> so I should not mention the notion, but the guarantees stay, but it is guarantees
> that are also wrong, which is much worse.
>
> >
> > ---
> > To elaborate:  I think that we should first discuss the meaning of that
> > "[...] after the acquire operation (does)",  because there is no notion
> > of "ACQUIRE (or more generally, load) propagation" in the LKMM:
> >
> > Stores propagate (after being executed) to other CPUs.  Loads _execute_
> > (possibly multiple times /speculatively, but this is irrelevant for the
> > discussion below).
> >
> > A detailed, but still informal, description of these concepts is in:
> >
> >   tools/memory-model/Documentation/explanation.txt
> >
> > (c.f., in particular, section "AN OPERATIONAL MODEL"); I can illustrate
> > them with an example:
> >
> >       { initially: x=0, y=0; }
> >
> >       CPU0                    CPU1
> >       --------------------------------------
> >       LOAD-ACQUIRE x=0        LOAD y=1
> >       STORE y=1
> >
> > In this scenario,
> >
> >   a) CPU0's "LOAD-ACQUIRE x=0" executes before CPU0's "STORE y=1"
> >      executes (this is guaranteed by the ACQUIRE),
> >
> >   b) CPU0's "STORE y=1" executes before "STORE y=1" propagates to
> >      CPU1 (a store cannot be propagated before being executed),
> >
> >   c) CPU0's "STORE y=1" propagates to CPU1 before CPU1's "LOAD y=1"
> >      executes (since CPU1 "sees the store").
> >
> > The example also illustrates the following property:
> >
> >   ACQUIRE guarantees that po-later stores on the same CPU must
> >   propagate to all other CPUs after the acquire _executes_.
> >
> > (combine (a) and (b) ).
> >
> > OTOH, please notice that:
> >
> >   ACQUIRE does _NOT_ guarantee that all propagated stores from
> >   other CPUs (to the CPU executing the ACQUIRE) must propagate
> >   to all other CPUs after the acquire operation _executes_.
>
> Thank you very much Andrea, this example and explanation clarifies it nicely!
> So Acquire only really affects the current CPU "view of the world" and operation
> propagation from it, and not anything else, which is actually very logical.
>
> My initial confusion was because I was thinking of ACQUIRE as a pair
> for RELEASE, i.e. it should provide a complementary guarantees to
>  RELEASE ones, just on po-later operations.
>
> >
> > In fact, we've already seen how full barriers can be used to break such
> > "guarantee"; for example, in
> >
> >       { initially: x=0, y=0; }
> >
> >       CPU0                    CPU1
> >               ...
> >       ---------------------------------------------------
> >       STORE x=1               LOAD x=1
> >                               FULL-BARRIER
> >                               LOAD-ACQUIRE y=0
> >
> > the full barrier forces CPU0's "STORE x=1" (seen by/propagated to CPU1)
> > to be propagated to all CPUs _before_ "LOAD-ACQUIRE y=0" is executed.
> >
> > Does this make sense?
>
> Yes, thank you again! I think it would take me still a long while to be familiar
> with all these notions and not to be confused even in simple things.
>
> >
> >
> > > > Is ACQUIRE strictly stronger than control dependency?
> > >
> > > In my understanding yes.
> >
> > +1 (or we have a problem)
> >
> >
> > >
> > > > It generally looks so unless there is something very subtle that I am
> > > > missing. If so, should we replace it with just "RELEASE ordering +
> > > > ACQUIRE ordering on success"? Looks simpler with less magic trickery.
> > >
> > > I was just trying to mention all the applicable orderings/guarantees.
> > > I can remove "control dependency" part if it is easier for people to understand
> > > (the main goal of documentation).
> >
> > This sounds like a good idea; thank you, Dmitry, for pointing this out.
>
> I will remove it. So, the rule that we always mention the strongest type of barrier
> When we mention some ordering guarantees, right?


My reasoning here was that control dependency is just a very subtle
thing so I think it's better if people just not see it at all and not
start thinking in terms of control dependencies until absolutely
necessary.

I am not sure how to generalize this. There are not too many other
cases where one barrier type is a full superset of another. E.g.
rmb/wmb are orthogonal to acquire/release.

But if we take full barrier, then, yes, it definitely makes sense to
just say that an operation provides full barrier rather than full
barrier, acquire barrier, release barrier, read barrier, write
barrier, control dependency, ... :)
