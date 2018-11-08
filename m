Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF80ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0267F20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0267F20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeKIBZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:25:17 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44536 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeKIBZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:25:17 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKmYK-0002tm-Hq; Thu, 08 Nov 2018 16:49:04 +0100
Date:   Thu, 8 Nov 2018 16:49:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jonathan Corbet <corbet@lwn.net>
cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        john.stultz@linaro.org, acme@redhat.com, frederic@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, daniel.lezcano@linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [patch 0/2] Documentation/process: Add subsystem/tree handbook
In-Reply-To: <20181108074920.4c601ee3@lwn.net>
Message-ID: <alpine.DEB.2.21.1811081637550.1549@nanos.tec.linutronix.de>
References: <20181107171010.421878737@linutronix.de> <20181107124855.328133e7@lwn.net> <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com> <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de> <20181108074920.4c601ee3@lwn.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jon,

On Thu, 8 Nov 2018, Jonathan Corbet wrote:
> On Wed, 7 Nov 2018 21:51:38 +0100 (CET)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> >   +   SOB chains should reflect the *real* route a patch took as it was 
> >   +   propagated to us, with the first SOB entry signalling primary
> >   +   authorship of a single author. Acks should be given as Acked-by 
> >   +   lines and review approvals as Reviewed-by lines.
> 
> If SOB means anything like what it's supposed to mean, this *can't* be a
> "local quirk" - we have to agree on it globally.

Agreed.

> If you want to push this into the tree in something like its current form,
> I'm not going to resist too hard - far be it from me to say we don't want
> more documentation!  But allow me to complain a little.

Please ask for allowance next time _before_ complaining :)

> Suppose I came along with my nifty new architecture, and it dragged in a
> whole new set of timer and interrupt subsystems that duplicated a lot of
> what's in the kernel now, but buried a few "local quirks" deep in the
> middle.  "Don't worry", I say, "we'll factor out the common stuff later
> once we figure out what it is; I'd rather not deal with the bikeshedding
> now". Correct me if I'm wrong, but I suspect I might just get a response
> back from you.  That's not how we normally do things.

Darn. Not much I can argue about.

> This proposal takes a similar approach to the documentation.  Changelog
> rules, your comment rules (other than tail comments), brace rules, line
> breaks, etc. are common stuff; if they are not well-enough documented in
> the global docs, the fix should really be applied there.  If it lands in
> the current form, you know as well as I do that it will almost certainly
> stay there for years, if not indefinitely.
> 
> IMO, the subsystem-specific documentation should be something that an
> existing kernel developer can use to quickly learn how to avoid surprises
> when wandering into a different subsystem.  So it should be concise and
> strongly focused on the local customs.  If we don't start that way, I'm
> afraid we'll never have that.  Then developers will miss the important
> information, and we'll reinforce the image of the kernel project as a
> collection of little fiefdoms that one wanders into at one's own risk.
> And Documentation/ will continue to be a painful mess.

Fair enough. TBH, I picked up Marks idea and it started out small and then
all the stuff which itches me/us got dumped into it. Let me try to split
that into pieces.

> Might it be worth asking Ted for a kernel summit slot to talk about this
> next week?

Aside of the scheduling conflicts, definitely yes.

> (And thanks again for doing this!  I like the material and think we
> definitely want it.)

At least it was not complete waste of time then :)

Thanks,

	tglx
