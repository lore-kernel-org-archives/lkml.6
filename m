Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9A8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1F920666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1F920666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeI1VsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:48:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54685 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeI1VsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:48:11 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5ucT-000182-3a; Fri, 28 Sep 2018 17:23:53 +0200
Date:   Fri, 28 Sep 2018 17:23:52 +0200 (CEST)
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
In-Reply-To: <732fdf91-0b44-e71d-f943-66ba63b5776f@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1809281709350.2004@nanos.tec.linutronix.de>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com> <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de> <e89ec139-1a97-803e-343c-76eedf244d65@linux.intel.com> <alpine.DEB.2.21.1809281542180.2004@nanos.tec.linutronix.de>
 <732fdf91-0b44-e71d-f943-66ba63b5776f@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tvrtko,

On Fri, 28 Sep 2018, Tvrtko Ursulin wrote:
> On 28/09/2018 15:02, Thomas Gleixner wrote:
> > > Presumably you see adding fine grained control as diminishing the overall
> > > security rather than raising it? Could you explain why? Because
> > > incompetent
> > > sysadmin will turn it off for some PMU, while without having the
> > > fine-grained
> > > control they wouldn't turn it off globally?
> > 
> > I did not say at all that this might be diminishing security. And the
> > argumentation with 'incompetent sysadmins' is just the wrong attitude.
> 
> Wrong attitude what? I was trying to guess your reasoning (cues in
> "presumably" and a lot of question marks) since it wasn't clear to me why is
> your position what it is.

Guessing my reasonings has nothing to do with you mentioning incompentent
sysadmins.

> > What I was asking for is proper documentation and this proper documentation
> > is meant for _competent_ sysadmins.
> > 
> > That documentation has to clearly describe what kind of information is
> > accessible and what potential side effects security wise this might
> > have. You cannot expect that even competent sysadmins know offhand what
> > which PMU might expose. And telling them 'Use Google' is just not the right
> > thing to do.
> 
> I did not mention Google.

I did not say that you mentioned google. But what is a sysadmin supposed to
do when there is no documentation aside of using google? And not having
documentation is basically the same thing as telling them to use google.

> > If you can't explain and document it, then providing the knob is just
> > fulfilling somebodys 'I want a pony' request.
> 
> Well it's not a pony, it is mechanism to avoid having to turn off all
> security. We can hopefully discuss it without ponies.

If you want to make a pettifogger contest out of this discussion, then we
can stop right here. I explained it technically why just adding a knob
without further explanation and analysis is not acceptable.

> > And the same is required for all other PMUs which can be enabled in the
> > same way for unprivileged access. And we might as well come to the
> > conclusion via analysis that for some PMUs unpriviledged access is just not
> > a good idea and exclude them. I surely know a few which qualify for
> > exclusion, so the right approach is to provide this knob only when the risk
> > is analyzed and documented and the PMU has been flagged as candidate for
> > unpriviledged exposure. I.e. opt in and not opt out.
> 
> I am happy to work on the mechanics of achieving this once the security guys
> and all PMU owners get involved. Even though I am not convinced the bar to
> allow fine-grained control should be evaluating all possible PMUs*, but if the
> security folks agree that is the case it is fine by me.

Making the knob opt in per PMU does not need all PMU owners to be
involved. It allows to add the opt in flag on a case by case basis.

> *) The part of my reply you did not quote explains how the fine-grained
> control improves security in existing deployments. The documentation I added
> refers to the existing perf_event_paranoid documentation for explanation of
> security concerns involved. Which is not much in itself. But essentially we
> both have a PMU and a knob already. I don't see why adding the same knob
> per-PMU needs much more stringent criteria to be accepted. But as said, that's
> for security people to decide.

The fact, that the existing knob is poorly documented does make an excuse
for adding more knobs without documentation. Quite the contrary, if we
notice that the existing knob lacks proper documentation, then we should
fix that first.

Thanks,

	tglx
