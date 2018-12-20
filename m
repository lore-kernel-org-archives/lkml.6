Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22F1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CD121841
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbeLTAqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 19:46:37 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:59944 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbeLTAqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 19:46:36 -0500
Received: from p4fea4820.dip0.t-ipconnect.de ([79.234.72.32] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gZmTp-0006Fu-TX; Thu, 20 Dec 2018 01:46:26 +0100
Date:   Thu, 20 Dec 2018 01:46:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Taking a break - time to look back
Message-ID: <alpine.DEB.2.21.1812200022580.1651@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I'm about to vanish for a truly needed break until Jan 7th. Time to look
back to an interesting year.

Almost exactly a year ago, all hell broke loose and quite some people were
forced to cancel their Christmas and New Year vacation and instead of
spending quality time with family and friends they tried to bring the bits
and pieces for the Meltdown and Spectre mitigations into shape.

While the Meltdown part (KPTI) was in a halfways good shape - at least in
mainline - the Spectre mitigations did not make it into mainline on time
and caused havoc in distros. The broken microcode updates and other
unpleasant issues did not help the situation either. And no, the 6 days
extra if the embargo wouldn't have ended early would not have made any
difference. It's a wonder that it held up until Jan. 3rd at all.

The reasons for this disaster have been pretty much covered in various
ways, so no point to go back to that again. Though it's worth to mention
that some of the mitigations took quite some time to materialize and the
development was not at all driven by those who are responsible for the
problem in the first place. Primary examples are KPTI support for 32bit and
STIBP which took more than 9 months to get into the mainline. KPTI for
32bit was ignored completely and STIPB only got attention due to
performance regressions, though the response was causing more work than
help.

The next round of speculation-related issues including the scary L1TF
hardware bug was a way more "pleasant" experience to work on. While for
obvious reasons the mitigation development happened behind closed doors in
a smaller group of people, we were at least able to collaborate in a way
which is somehow close to what we are used to.

There were surely a few rough edges with respect to bringing in particular
developers and information flow, but both Intel and we as a community have
learned how to deal with that and improved a lot.

As a consequence, we are going to have a well documented and formalized
process for this in the foreseeable future. There are also efforts on the
way to have non-public testing infrastructure available for future events
of this kind.

No need to speculate whether this makes sense. I'm not overly optimistic
that we have seen all of that by now and my gut feeling tells me that we
are going to be haunted by that kind of issues for a very long time. For
the very unlikely case that I'm proven wrong, then I'm surely not going to
shed a tear about the time spent on writing the documentation and getting
things prepared.

At this point I want to say BIG THANKS to everybody involved for all the
great work which was done under not so enjoyable circumstances. Both the
required secrecy and the set in stone timelines are pretty different from
our normal workflow. At the same time I want to take the opportunity and
apologize for any outburst I had. I know that I went overboard occasionally
and it's nothing I'm proud of.

Looking back, I have to say that all of this certainly had consequences
outside of that restricted setting. The coordinated release dates forced
quite some people to put a break on other tasks which were piling up
nevertheless. The review backlog was from time to time tremendous and I'm
sure that we dropped stuff on the way and that we still have things to
catch up with on all ends.

Though a lot of this pressure and fallout is home-grown and could have been
avoided at least to some extent. The underlying reasons are not specific to
the mitigation development, the circumstances just emphasized them and made
them more observable for everyone - involved or not.

 1) Lack of code quality

    This is a problem which I observe increasing over many years.

    The feature driven duct tape engineering mode is progressing
    massively. Proper root cause analysis has become the exception not the
    rule.

    In our normal kernel development it's just annoying and eats up review
    capacity unnecessarily, but in the face of a timeline or real bugs it's
    worse. Aside of wasting time for review rounds, at some point other
    people have to just drop everything else and get it fixed.

    Even if some people don't want to admit it, the increasing complexity
    of the hardware technology and as a consequence the increasing
    complexity of the kernel code base makes it mandatory to put
    correctness and maintainability first and not to fall for the
    featuritis and performance chants which are driving this
    industry. We've learned painfully what that causes in the last year.

 2) Lack of review response

    Not addressing review feedback is not a new problem, but again under
    time pressure or in the face of real bugs it becomes a real pain and
    causes extra work for others and maintainers in particular.

 3) Outright refusal

    I've seen particularly in this year quite some people who responded to
    review feedback with outright and outspoken refusal. The points they
    refuse to address are not some esoteric whims of particular
    maintainers, no it's refusal to accept that there are documented
    process and patch submission rules which apply for everyone.

    Again, not a big problem if it's related to features. If it's related
    to actual bugs or the timelined mitigation development then it causes
    extra burden for others.

In other words, if we are exposed to more half-baked patches, sloppy
addressing of review feedback or in the worst case refusal to collaborate
and then on top getting complaints about maintainers and reviewers being
bottlenecks, then this will become a real problem in the not so distant
future.

Companies have to understand, that the kernel community cannot provide
all-inclusive educational programs for their engineers. It's about time,
that the companies catch the obvious wreckage before it leaves the house
and make sure that feedback is addressed properly and in all points.

I'm neither expecting perfect patches nor is there a guarantee that even
well thought out and well written code will go into the tree undisputed.
Though reviewing and discussing something which is well done is way less
time consuming and frustrating than dealing with the above.

I know that some people will come forth immediately and educate me once
more on maintainer models and the need to bring new maintainers in fast.

I'm all for more maintainers, but it's hard to find the right people.

All good maintainers - and I've brought quite a few of them into that role
myself - had proven themselves in their contributor role before taking that
up. Rest assured that I constantly look out for these people and try to get
them on board. Picking them out is based on their technical skills but even
more so on their mindset. Unfortunately quite some of them don't want to
step into that role because they are well aware of the responsibility and
the burden which comes with it. I respect that decision and I definitely
can understand it. I was more than once on the verge of throwing in the
towel during the last year.

I'm not opposed to try new things, quite the contrary. But something which
worked out for a particular subsystem cannot be applied blindly to
everything else in the hope that it works out. That needs a lot more
thought and I'm not at all buying that tooling is a crucial part of the
solution.

Last but not least, I'm not sure whether more maintainers can solve the
pain points which bugger me most. I rather think we'd need lots of
nursemaids and teachers to address that.

Sorry for the lengthy and maybe unpleasant read, but keeping the
frustration which built up over the year to myself would just cause me
gastric ulcer and a bad mood over Christmas. So I decided to vent and share
it with all of you even at the risk that I'm barking up the wrong tree.

That said, I'm going to vanish into vacation until Jan. 7th and I'm not
going to read any (LKML) mails until then. As I predict from experience
that my (filtered) inbox will be a untameable beast by then, don't expect
me to actually go through it mail by mail. If your mail will unfortunately
end up in the 'lkml/done' folder without being read, I'm sure you'll notice
and find a way to resend it.

I'm nevertheless looking positively forward to the new challenges of 2019
and I wish you all a Merry Christmas, a Happy New Year and a refreshing
break! I wish especially for those who suffered a year ago, that they can
enjoy quality time with their families and friends!

Thanks,

	Thomas
