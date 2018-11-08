Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C59FECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF8A2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF8A2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeKIAZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:25:13 -0500
Received: from ms.lwn.net ([45.79.88.28]:58898 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbeKIAZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:25:12 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 367154FA;
        Thu,  8 Nov 2018 14:49:21 +0000 (UTC)
Date:   Thu, 8 Nov 2018 07:49:20 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20181108074920.4c601ee3@lwn.net>
In-Reply-To: <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
References: <20181107171010.421878737@linutronix.de>
        <20181107124855.328133e7@lwn.net>
        <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
        <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 21:51:38 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> So I agree with Dan, that we should collect as much documentation from
> subsystems/maintainers and get it into the tree so we can:
> 
>    - give contributors immediate access to subsystem/maintainer specific
>      quirks
> 
>    - extract common views and move them into the general guidelines
> 
>    - have a clear idea which kind of things need to be discussed and agreed
>      on and what might be left in the susbsystem/maintainer specific
>      interpretation/expectation realm.

Ah, but Dan said:

> Not at all, and this is one of the thrusts of my talk next week at
> Plumbers. I *do* want to propose that sub-systems document all their
> local quirks. 

My concern is that you're going far beyond "local quirks" here, and
actually hiding the real quirks in the process. Just one example from
Ingo's email storm this (US/Mountain) morning:

> Even after a decade of introducing Git I still see Signed-off-by used as 
> an Acked-by or Reviewed-by substitutes, so I'd suggest adding this small 
> explanation as well:
> 
>   +   SOB chains should reflect the *real* route a patch took as it was 
>   +   propagated to us, with the first SOB entry signalling primary
>   +   authorship of a single author. Acks should be given as Acked-by 
>   +   lines and review approvals as Reviewed-by lines.

If SOB means anything like what it's supposed to mean, this *can't* be a
"local quirk" - we have to agree on it globally.

If you want to push this into the tree in something like its current form,
I'm not going to resist too hard - far be it from me to say we don't want
more documentation!  But allow me to complain a little.

Suppose I came along with my nifty new architecture, and it dragged in a
whole new set of timer and interrupt subsystems that duplicated a lot of
what's in the kernel now, but buried a few "local quirks" deep in the
middle.  "Don't worry", I say, "we'll factor out the common stuff later
once we figure out what it is; I'd rather not deal with the bikeshedding
now". Correct me if I'm wrong, but I suspect I might just get a response
back from you.  That's not how we normally do things.

This proposal takes a similar approach to the documentation.  Changelog
rules, your comment rules (other than tail comments), brace rules, line
breaks, etc. are common stuff; if they are not well-enough documented in
the global docs, the fix should really be applied there.  If it lands in
the current form, you know as well as I do that it will almost certainly
stay there for years, if not indefinitely.

IMO, the subsystem-specific documentation should be something that an
existing kernel developer can use to quickly learn how to avoid surprises
when wandering into a different subsystem.  So it should be concise and
strongly focused on the local customs.  If we don't start that way, I'm
afraid we'll never have that.  Then developers will miss the important
information, and we'll reinforce the image of the kernel project as a
collection of little fiefdoms that one wanders into at one's own risk.
And Documentation/ will continue to be a painful mess.

</soapbox>

Might it be worth asking Ted for a kernel summit slot to talk about this
next week?

(And thanks again for doing this!  I like the material and think we
definitely want it.)

jon
