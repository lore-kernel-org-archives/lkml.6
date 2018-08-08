Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB9AC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A3A219EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eEio7hjm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I5J3On0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A3A219EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbeHHUXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:23:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeHHUXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:23:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3135360AFF; Wed,  8 Aug 2018 18:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533751370;
        bh=NGDvh0D7LD0ANRLIdVpj19Z5JygIB17sY61oj5NblPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEio7hjmslZR8MzUo1qqT7U8XCIildEEz0Vlg6b6ugZMYiGS1iRM4gflkVlL5l5Si
         5icjg6+b/PxGeT5vNdl5o1hdBKJ6ZuzIFd2H3q+6U5nbcSLmnAo2sC9XhjOUFRQWUZ
         GaHIlmob+oeRLqCUziIslQzgVplBC6O4JGyVOeko=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D370C60AFF;
        Wed,  8 Aug 2018 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533751369;
        bh=NGDvh0D7LD0ANRLIdVpj19Z5JygIB17sY61oj5NblPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5J3On0MzfnyWeOhfl9+TsLZ41yqZucaAJ6zQ0fEHeSp/WnDk/rx5UmE/zVAjo4Qi
         Yzvh6+nKQJ5yLgyHcmREDKPA9JuMpl55cv3K+n2HXKbr4BOE830bnhnht5NziGjYce
         NAPTE389Kz9aGwRJyiIiDU106A1GO1jwYbLRhK7g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D370C60AFF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 8 Aug 2018 12:02:48 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 09/26] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
Message-ID: <20180808180248.GC27850@codeaurora.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <2056372.NMt4aPaF4h@aspire.rjw.lan>
 <2205807.cU2puvubpP@aspire.rjw.lan>
 <1726374.375PCQfjLZ@aspire.rjw.lan>
 <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
 <CAJZ5v0hk1wfm10fyycmddKF6wR4D51r30fD_-J5UDMbtB3+V-Q@mail.gmail.com>
 <20180808105619.GB25150@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180808105619.GB25150@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08 2018 at 04:56 -0600, Lorenzo Pieralisi wrote:
>On Mon, Aug 06, 2018 at 11:37:55AM +0200, Rafael J. Wysocki wrote:
>> On Fri, Aug 3, 2018 at 1:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> > [...]
>> >
>> >>>
>> >>> Assuming that I have got that right, there are concerns, mostly regarding
>> >>> patch [07/26], but I will reply to that directly.
>> >>
>> >> Well, I haven't got that right, so never mind.
>> >>
>> >> There are a few minor things to address, but apart from that the general
>> >> genpd patches look ready.
>> >
>> > Alright, thanks!
>> >
>> > I will re-spin the series and post a new version once 4.19 rc1 is out.
>> > Hopefully we can queue it up early in next cycle to get it tested in
>> > next for a while.
>> >
>> >>
>> >>> The $subject patch is fine by me by itself, but it obviously depends on the
>> >>> previous ones.  Patches [01-02/26] are fine too, but they don't seem to be
>> >>> particularly useful without the rest of the series.
>> >>>
>> >>> As far as patches [10-26/26] go, I'd like to see some review comments and/or
>> >>> tags from the people with vested interest in there, in particular from Daniel
>> >>> on patch [12/26] and from Sudeep on the PSCI ones.
>> >>
>> >> But this still holds.
>> >
>> > Actually, patch 10 and patch11 is ready to go as well. I ping Daniel
>> > on patch 12.
>> >
>> > In regards to the rest of the series, some of the PSCI/ARM changes
>> > have been reviewed by Mark Rutland, however several changes have not
>> > been acked.
>> >
>> > On the other hand, one can also interpret the long silence in regards
>> > to PSCI/ARM changes as they are good to go. :-)
>>
>> Well, in that case giving an ACK to them should not be an issue for
>> the people with a vested interest I suppose.
>
>Apologies to everyone for the delay in replying.
>
>Side note: cpu_pm_enter()/exit() are also called through syscore ops in
>s2RAM/IDLE, you know that but I just wanted to mention it to compound
>the discussion.
>
>As for PSCI patches I do not personally think PSCI OSI enablement is
>beneficial (and my position has always been the same since PSCI OSI was
>added to the specification, I am not even talking about this patchset)
>and Arm Trusted Firmware does not currently support it for the same
>reason.
>
>We (if Mark and Sudeep agree) will enable PSCI OSI if and when we have a
>definitive and constructive answer to *why* we have to do that that is
>not a dogmatic "the kernel knows better" but rather a comprehensive
>power benchmark evaluation - I thought that was the agreement reached
>at OSPM but apparently I was mistaken.
>
I will not speak to any comparison of benchmarks between OSI and PC.
AFAIK, there are no platforms supporting both.

But, the OSI feature is critical for QCOM mobile platforms. The
last man activities during cpuidle save quite a lot of power. Powering
off the clocks, busses, regulators and even the oscillator is very
important to have a reasonable battery life when using the phone.
Platform coordinated approach falls quite short of the needs of a
powerful processor with a desired battery efficiency.

-- Lina

>As a reminder - PSCI firmware implementation has to have state machines
>and locking to guarantee safe power down operations (and to flush caches
>only if necessary - which requires cpu masks for power domains) and
>that's true whether we enable PSCI OSI or not, the coordination logic
>must be in firmware/hardware _already_ - the cpumasks, the power domain
>topology, etc.
>
>I agree with the power-domains representation of idle-states (since
>that's the correct HW description) and I thought and hoped that runtime
>PM could help _remove_ the CPU PM notifiers (by making the notifiers
>callbacks a runtime PM one) even though I have to say that's quite
>complex, given that only few (ie one instance :)) CPU PM notifiers
>callbacks are backed by a struct device (eg an ARM PMU is a device but
>for instance the GIC is not a device so its save/restore code I am not
>sure it can be implemented with runtime PM callbacks).
>
>Lorenzo
