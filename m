Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E25C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECD721528
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECD721528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbeI1U0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:26:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54511 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeI1U0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:26:11 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5tLM-0008Jd-N9; Fri, 28 Sep 2018 16:02:08 +0200
Date:   Fri, 28 Sep 2018 16:02:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
cc:     Tvrtko Ursulin <tursulin@ursulin.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
In-Reply-To: <e89ec139-1a97-803e-343c-76eedf244d65@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1809281542180.2004@nanos.tec.linutronix.de>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com> <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de> <e89ec139-1a97-803e-343c-76eedf244d65@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tvrtko,

On Fri, 28 Sep 2018, Tvrtko Ursulin wrote:
> On 28/09/2018 11:26, Thomas Gleixner wrote:
> > On Wed, 19 Sep 2018, Tvrtko Ursulin wrote:
> > 
> > It would be very helpful if you cc all involved people on the cover letter
> > instead of just cc'ing your own pile of email addresses. CC'ed now.
> 
> I accept it was by bad to miss adding Cc's on the cover letter, but my own
> email addresses hopefully should not bother you. It is simply a question of
> what I have in .gitconfig vs what I forgot to do manually.

The keyword in the above sentence is 'just'. You can add as many of yours
as you want as long as everybody else is cc'ed.

> > I read through the previous thread and there was a clear request to involve
> > security people into this. Especially those who are deeply involved with
> > hardware side channels. I don't see anyone Cc'ed on the whole series.
> 
> Who would you recommend I add? Because I really don't know..

Sure, and because you don't know you didn't bother to ask around and
ignored the review request.

I already added Kees and Jann. Please look for the SECCOMP folks in
MAINTAINERS.

> > For the record, I'm not buying the handwavy 'more noise' argument at
> > all. It wants a proper analysis and we need to come up with criteria which
> > PMUs can be exposed at all.
> > 
> > All of this want's a proper documentation clearly explaining the risks and
> > scope of these knobs per PMU. Just throwing magic knobs at sysadmins and
> > then saying 'its their problem to figure it out' is not acceptable.
> 
> Presumably you see adding fine grained control as diminishing the overall
> security rather than raising it? Could you explain why? Because incompetent
> sysadmin will turn it off for some PMU, while without having the fine-grained
> control they wouldn't turn it off globally?

I did not say at all that this might be diminishing security. And the
argumentation with 'incompetent sysadmins' is just the wrong attitude.

What I was asking for is proper documentation and this proper documentation
is meant for _competent_ sysadmins.

That documentation has to clearly describe what kind of information is
accessible and what potential side effects security wise this might
have. You cannot expect that even competent sysadmins know offhand what
which PMU might expose. And telling them 'Use Google' is just not the right
thing to do.

If you can't explain and document it, then providing the knob is just
fulfilling somebodys 'I want a pony' request.

> This feature was requested by the exact opposite concern, that in order to
> access the i915 PMU, one has to compromise the security of the entire system
> by allowing access to *all* PMU's.
> 
> Making this ability fine-grained sounds like a logical solution for solving
> this weakening of security controls.

Sure, and this wants to be documented in the cover letter and the
changelogs.

But this does also require a proper analysis and documentation why it is
not a security risk to expose the i915 PMU or what potential security
issues this can create, so that the competent sysadmin can make a
judgement.

And the same is required for all other PMUs which can be enabled in the
same way for unprivileged access. And we might as well come to the
conclusion via analysis that for some PMUs unpriviledged access is just not
a good idea and exclude them. I surely know a few which qualify for
exclusion, so the right approach is to provide this knob only when the risk
is analyzed and documented and the PMU has been flagged as candidate for
unpriviledged exposure. I.e. opt in and not opt out.

Thanks,

	tglx
