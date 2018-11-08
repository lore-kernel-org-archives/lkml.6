Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9295ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B514B206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B514B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeKICYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:24:53 -0500
Received: from foss.arm.com ([217.140.101.70]:45154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbeKICYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:24:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C8E580D;
        Thu,  8 Nov 2018 08:48:32 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52843F5CF;
        Thu,  8 Nov 2018 08:48:29 -0800 (PST)
Date:   Thu, 8 Nov 2018 16:48:27 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Damien.LeMoal@wdc.com, alankao@andestech.com, zong@andestech.com,
        anup@brainfault.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC 0/2] Add RISC-V cpu topology
Message-ID: <20181108164827.GB10953@e107155-lin>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
 <20181106141331.GA28458@e107155-lin>
 <969fc2a5198984e0dfe8c3f585dc65f9@mailhost.ics.forth.gr>
 <20181106162051.w7fyweuxrl7ujzuz@lakrids.cambridge.arm.com>
 <abcae019e6ae749b17ecb0c721fd3177@mailhost.ics.forth.gr>
 <20181107122803.GA8433@e107155-lin>
 <d04779705c47b59b94300365e805dbd3@mailhost.ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d04779705c47b59b94300365e805dbd3@mailhost.ics.forth.gr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 04:52:30PM +0200, Nick Kossifidis wrote:
> Στις 2018-11-07 14:28, Sudeep Holla έγραψε:
> >
> > I agree, but we have kernel code using it(arm64/kernel/topology.c). It's
> > too late to remove it. But we can always keep to optional if we move the
> > ARM64 binding as generic to start with and mandate it for only ARM64.
> >
>
> That's my point as well, if we are going to define something to be used
> by everybody and in this case, at least for RISC-V, there is no need to
> carry this from the ARM64 binding.

Sure, whatever you don't need in RISC-V you can see if they can be made
optional. I don't think that should be a problem.

> It shouldn't be that hard to fix this
> in the future for ARM64 as well, we may give the new mapping another name,
> maybe cpu-map2 or cpu-topology to slowly move to the new one.

No, we have it and we will continue to support it. It's not broken to
fix on ARM64. Why do you think that it's broken on ARM64 ?

> Changing the
> dts files shouldn't be this hard, we can provide a script for it. We can
> even contain some compatibility code that also understands <thread> nodes
> and e.g. merges them together on a core node.
>

Sure, hang on this idea of scripting, we can make a better use of it.
Details later further in the mail.

[...]

> > > The same also happens with the generic numa binding on
> > > Documentation/devicetree/bindings/numa.txt
> > > which says we should add the nuna-node-id on each of the cpu nodes.
> > >
> >
> > Yes, but again what's the problem ?
> >
>
> There is no problem with the above bindings, the problem is that we have
> to put them on each cpu node which is messy. We could instead put them
> (optionally) on the various groupings used on cpu-map. This would allow
> cpu-map to be more specific of what is shared across the members of each
> group (core/cluster/whatever).
>

I think Mark has already explain why/how generic bindings are useful.
If you still have concerns, take it up separately and see how you can
build *perfect* bindings for RISC-V to avoid any legacy baggage.

We have reasons why we can't assume information about cache or power
domain topology from CPU topology. I have summarised them already and
we are not discussing. There may not be perfect bindings but there are
already supported and nothing is broken here to fix. DT bindings are
*not* same as code to fix it with a patch to the bindings themselves.
Once agreed and merged, they need to be treated like user ABI.

> As I wrote on my answer to Mark previously, the bindings for infering
> the cache topology, numa topology, power domain topology etc are already
> there, they are in the devicet tree spec and provide very specific
> informations we can use. Much "stronger" hints of what's going on at
> the hw level. The cpu-map doesn't provide such information, it just
> provides a view of how the various harts/threads are "packed" on the chip,
> not what they share inside each level of "packing". It's useful because
> it saves people from having to define a bunch of cache nodes and describe
> the cache hierarchy on the device tree using the standard spec.
>

Ah, here comes. If you want to save people's time or whatever, you can use
your scripting magic you have mentioned above to define those bunch of nodes
you want to avoid.

> So since cpu-map is there for convenience let's make it more convenient !
> What I'm saying is that cpu-map could be a more compact way of using the
> existing bindings for adding properties on groups of harts instead of
> putting them on each hart individually. It will simplify the representation
> and may also optimize the implementation a bit (we may get the information
> we need faster). I don't see any other reason for using cpu-map on RISC-V
> or for making it global across archs.
>

Sure, I don't have strong opinions there. Just stop mentioning that this
is the only solution and all existing ones are broken. They are not and
needs to be supported until they are explicitly deprecated, becomes
obsolete and finally removed.

[...]

> >
> > Why are you so keen on optimising the representation ?
> > If you are worried about large systems, generate one instead of
> > handcrafted.
> >
>
> I don't see a reason not to try to optimize it, since we are talking
> about a binding to be used by RISC-V and potentially everybody, I think
> it makes sens to improve upon what we already have.
>

Sure, you can always unless you stop treating existing ones are broken.
I have already told DT bindings are not *normal code*. You can just
replace existing ones with new optimised ones. You can only add the new
(*optimised*) ones to the existing ones. You *need* to understand that
concept first, otherwise there's not point in this endless discussion
IMO.

I will stop here as I will have to repeat whatever I have already
mentioned to comment on your arguments below.

In summary, I am not against improving the bindings if you think it's
possible, but I don't see how it's more beneficially especially if we
are going to support existing ones also. Mark has already given all the
details.

--
Regards,
Sudeep
