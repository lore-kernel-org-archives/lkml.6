Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BX7kJLT/G1uMXAAAmS7hNA
	; Sat, 09 Jun 2018 16:26:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7EA39608BA; Sat,  9 Jun 2018 16:26:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bah16FjL"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CCDB9605A5;
	Sat,  9 Jun 2018 16:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCDB9605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbeFIQ0Y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 12:26:24 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39318 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeFIQ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 12:26:23 -0400
Received: by mail-it0-f68.google.com with SMTP id p185-v6so6174737itp.4;
        Sat, 09 Jun 2018 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XE5N49Wm0XEv7gBcdt3m3mV5z/SP9+xz1mfU9cWU14=;
        b=bah16FjL5BKw3qYth0gQmAqcHenfNIuNH3tI77mSVWN8WQ+TxV+b/0NCY1UliauNIE
         coGoODX0JioQ6Y1z1xzaL0REgQX43SULUnb91sVWs1PEYzoLNZgeHe9ICA1+OmE7B2FD
         DIMuRY2cDp2wxGEYwwe4aP5sai6+p8cCdfaaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XE5N49Wm0XEv7gBcdt3m3mV5z/SP9+xz1mfU9cWU14=;
        b=YqmWWiomtDexXBwTlAsUBdCDnNG6H+n41Bw7eQj9qjagPGWFIXYHeFaH/8UhW0/w8j
         hpr/xPGFSTSFdybF0C7A4qhDFI1CuYZBWplelOYeML4oMxiMaTSPVvB4O5bC+v7rctT6
         1d38Vsq1IOpKaUDFKbVWj2GXk1Z8SdcaFPa1ALrI+cV+a71CUCmUnwAcdzbqT89g6NdP
         Gu5u4L/hLINNkc0SASyJ8SghaUJPyHJURTMkfxFc0QWqFC0iKVk9gsRCn7UCE+62JOrK
         OZu2JOCvpPevBC+tAMwRt7gtXWguoUwWH32m5KdmNKNhfLwFbisQTDh6QFvdiS+GXuUG
         txaA==
X-Gm-Message-State: APt69E2DlIlXI7vetyE3l+6vf0Mij2gvvw6oARugLYxjmUyfj2GZCd9Q
        UCoy0rABuHn5QqS4bqRB5UQm/7YsnONMVOxClkU=
X-Google-Smtp-Source: ADUXVKJlXyHSP6Y1ceI9giasX04blyysvKZhL636cEBKO4RRsFf+TFUL4aF6WMc+2YF1S12nM2xuUjxbsOYpHE2hnbA=
X-Received: by 2002:a24:6b14:: with SMTP id v20-v6mr5550172itc.100.1528561582290;
 Sat, 09 Jun 2018 09:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <1528502307.25740.14.camel@intel.com> <CA+55aFy_fiF2bwW=0gL4g8uL5099hWarL4+Q9djmDEuwRR2KKw@mail.gmail.com>
 <CA+55aFyTXHxaRQhsCwgicFw6=xk80Bjw92tgfmmRP4HQ-AhSvw@mail.gmail.com> <CAPcyv4hPTyfSO5pncQ84cPrTe4sUJ+jA6cMHXm-6ocvLGKr65A@mail.gmail.com>
In-Reply-To: <CAPcyv4hPTyfSO5pncQ84cPrTe4sUJ+jA6cMHXm-6ocvLGKr65A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 Jun 2018 09:26:11 -0700
Message-ID: <CA+55aFzW_2iMYDRsz2-z6VvOcFwyuB5_72BAEARzpdG60h0=Zw@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm for 4.18
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 9, 2018 at 8:17 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Well, crap. I've been doing it the wrong way for a while.

.. you're not the only one ;*(

I only really catch it when it's very obvious, like it was now when
the last merge was just before so it stood out like a sore thumb when
I looked at the resulting "git log".

.. or then I catch it in the (happily rare) case when a merge causes
issues, and then I curse.

> Do you have a preference for more pull requests or just splitting what
> is now a top level tag message into a summary changelog per branch
> when I merge the ready branches for the merge window? I had been
> assuming that the arrangement you have with Ingo / Thomas to pull
> individual topics was a privilege for the tip tree and not necessarily
> something everyone that sends you pulls should be doing.

Oh, the -tip tree arrangement is absolutely not a "privilege" for the
-tip tree. In fact, there are a few other trees that I have basically
_required_ do the same because not doing it was too messy. So now I
pull the security subsystem trees as 4-5 different separate branches
too, for example. (And obviously the ARM tree is the "historically
nasty" one that hasn't actually been a problem for several years, but
the solution was the same: split it up.

So I'm perfectly happy getting more than one pull request from everybody.

That said, I also don't want to get _pointless_ pull requests. I don't
want people to split their pulls "just because". It needs to make
sense.

And I *am* perfectly happy with you doing your merges too - I actually
like seeing submaintainers using topic branches for the different
things they do, and do their own merges. Because if I see splits, I
want them to be along some "broader" more generic thing, not - for
example - some "per driver pull request".

But I do ask that when people do their own merges, they actually write
a merge message for that local merge. I will still want the pull
request to talk about the *whole* thing I'm pulling (so you having
details in a local small merge doesn't mean that they shouldn't be
mentioned when then asking me to pull the whole result), so there may
be some duplication in commit messages as things get merged "up the
stack", but that's fine.

Also, the merge message really doesn't have to be extensive. But it
should at least talk about what the topic branch you merged was doing.
Just a sentence or two is fine, unless there's something subtle going
on, in which case that subtle thing needs to be explained.

Examples of "something subtle going on" is when the merge isn't just
for normal development on your own, but is (for example) merging a
common branch that you are also sharing with some other tree, or if
the merge is a back-merge that has some important reason for it.
Hopefully those back-merges don't even happen in the first place, but
if they do, I _really_ want an explanation for _why_ they happened.

For a regular topic branch merge, the "why" is not needed, because
it's "obvious". You're merging development. Then just a short sentence
of two of what the development is. Sometimes the topic branch name
itself *might* be enough, but usually just a _bit_ more information.

So for example, in that

    Merge branch 'for-4.18/mcsafe' into libnvdimm-for-next

merge, even just then adding below that a few sentences saying something like

 "Introduce new machine-check safe copy iterator to dax and make pmem
  use it.

  Add a test-case"

would have been appreciated.

It really doesn't need to be much. Just a "when people do 'git log',
they see what each commit does without having to know the big
picture".

Because imagine doing just 'git log' on my tree. You won't see just
the libnvdimm commits - you'll see tons of random other commits too,
and the commits that get merged by that merge commit are *not* obvious
(because they are probably way down deep in the history, and it's not
so easy to find them in the output of "git log" among all the other
thousands of  commits).

So just making each commit - whether it's a regular commit or a merge
- say what it does without the reader having to know the whole context
really makes it much more understandable.

So to re-iterate: you *can* send those branches individually to me,
and I'll just do three merges instead of one. That works too. But
libnvdimm isn't big enough of a subsystem for me to really necessarily
care at that level, so you doing your own topic branch merges is
*also* good.

But when you do your topic branch merges, imagine that you are me, and
that you're a maintainer that is merging something from a
submaintainer, and write the commit message as if you were a bit of an
outsider that had the submaintainer explain to you what you're
merging.

And simplifying and abstracting is good. Don't try to explain the
commits that get merged at an individual commit level - that's what
the commit messages _in_ those commits are for. The merge should have
a more high-level view of what gets merged.

             Linus
