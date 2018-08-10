Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36525C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DAB21E17
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cJCkj+dr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TwNeByi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DAB21E17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeHJXHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 19:07:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeHJXHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 19:07:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7AE8B60B23; Fri, 10 Aug 2018 20:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533933366;
        bh=fkHHVmOz1r4sMon1YaYHWBo8hxWmP4NWuZxp1RFAriA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJCkj+drrg7FWRF3RTHzlEqx7kL9b9tdII2IxvqBMcesE7hEvH5glXyd5QPyYFhW6
         YOfFgPh/FyNgANI5JxZegCGfrpy9HNqoci+4dUkLEYbzUNk6BXnqC/V+lHGdK54wmJ
         PErAOdrIKeXMMawhdJCZ3oqAuDhQbkQVplpXhBNE=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2048860807;
        Fri, 10 Aug 2018 20:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533933365;
        bh=fkHHVmOz1r4sMon1YaYHWBo8hxWmP4NWuZxp1RFAriA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwNeByi+mkdTraNl0MKjwMj95RjVyc47TlrJ5cuQRYqvrqlPhlaGXE9PSptjG9UqL
         UdxCJ1ROb06dKMCF41+tsFBVkv+sxlbsCcUYK6jux0zLsZAUaXMoY+ZqhyakDHbtHq
         cHxH+mB0/6fdZt8zlN46pHY/cOwiWO0Ayg/slehM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2048860807
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 10 Aug 2018 14:36:04 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Message-ID: <20180810203604.GF5081@codeaurora.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <2056372.NMt4aPaF4h@aspire.rjw.lan>
 <2205807.cU2puvubpP@aspire.rjw.lan>
 <1726374.375PCQfjLZ@aspire.rjw.lan>
 <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
 <CAJZ5v0hk1wfm10fyycmddKF6wR4D51r30fD_-J5UDMbtB3+V-Q@mail.gmail.com>
 <20180808105619.GB25150@e107981-ln.cambridge.arm.com>
 <20180808180248.GC27850@codeaurora.org>
 <CAJZ5v0gnZCmfgERSJfAFM6Y+jLX4V3Rsr4D5gBACWRNbGcEN-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gnZCmfgERSJfAFM6Y+jLX4V3Rsr4D5gBACWRNbGcEN-A@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09 2018 at 02:16 -0600, Rafael J. Wysocki wrote:
>On Wed, Aug 8, 2018 at 8:02 PM, Lina Iyer <ilina@codeaurora.org> wrote:
>> On Wed, Aug 08 2018 at 04:56 -0600, Lorenzo Pieralisi wrote:
>>>
>>> On Mon, Aug 06, 2018 at 11:37:55AM +0200, Rafael J. Wysocki wrote:
>>>>
>>>> On Fri, Aug 3, 2018 at 1:42 PM, Ulf Hansson <ulf.hansson@linaro.org>
>>>> wrote:
>>>> > [...]
>>>> >
>>>> >>>
>>>> >>> Assuming that I have got that right, there are concerns, mostly
>>>> >>> regarding
>>>> >>> patch [07/26], but I will reply to that directly.
>>>> >>
>>>> >> Well, I haven't got that right, so never mind.
>>>> >>
>>>> >> There are a few minor things to address, but apart from that the
>>>> >> general
>>>> >> genpd patches look ready.
>>>> >
>>>> > Alright, thanks!
>>>> >
>>>> > I will re-spin the series and post a new version once 4.19 rc1 is out.
>>>> > Hopefully we can queue it up early in next cycle to get it tested in
>>>> > next for a while.
>>>> >
>>>> >>
>>>> >>> The $subject patch is fine by me by itself, but it obviously depends
>>>> >>> on the
>>>> >>> previous ones.  Patches [01-02/26] are fine too, but they don't seem
>>>> >>> to be
>>>> >>> particularly useful without the rest of the series.
>>>> >>>
>>>> >>> As far as patches [10-26/26] go, I'd like to see some review comments
>>>> >>> and/or
>>>> >>> tags from the people with vested interest in there, in particular
>>>> >>> from Daniel
>>>> >>> on patch [12/26] and from Sudeep on the PSCI ones.
>>>> >>
>>>> >> But this still holds.
>>>> >
>>>> > Actually, patch 10 and patch11 is ready to go as well. I ping Daniel
>>>> > on patch 12.
>>>> >
>>>> > In regards to the rest of the series, some of the PSCI/ARM changes
>>>> > have been reviewed by Mark Rutland, however several changes have not
>>>> > been acked.
>>>> >
>>>> > On the other hand, one can also interpret the long silence in regards
>>>> > to PSCI/ARM changes as they are good to go. :-)
>>>>
>>>> Well, in that case giving an ACK to them should not be an issue for
>>>> the people with a vested interest I suppose.
>>>
>>>
>>> Apologies to everyone for the delay in replying.
>>>
>>> Side note: cpu_pm_enter()/exit() are also called through syscore ops in
>>> s2RAM/IDLE, you know that but I just wanted to mention it to compound
>>> the discussion.
>>>
>>> As for PSCI patches I do not personally think PSCI OSI enablement is
>>> beneficial (and my position has always been the same since PSCI OSI was
>>> added to the specification, I am not even talking about this patchset)
>>> and Arm Trusted Firmware does not currently support it for the same
>>> reason.
>>>
>>> We (if Mark and Sudeep agree) will enable PSCI OSI if and when we have a
>>> definitive and constructive answer to *why* we have to do that that is
>>> not a dogmatic "the kernel knows better" but rather a comprehensive
>>> power benchmark evaluation - I thought that was the agreement reached
>>> at OSPM but apparently I was mistaken.
>>>
>> I will not speak to any comparison of benchmarks between OSI and PC.
>> AFAIK, there are no platforms supporting both.
>>
>> But, the OSI feature is critical for QCOM mobile platforms. The
>> last man activities during cpuidle save quite a lot of power. Powering
>> off the clocks, busses, regulators and even the oscillator is very
>> important to have a reasonable battery life when using the phone.
>> Platform coordinated approach falls quite short of the needs of a
>> powerful processor with a desired battery efficiency.
>
>Even so, you still need firmware (or hardware) to do the right thing
>in the concurrent wakeup via an edge-triggered interrupt case AFAICS.
>That is, you need the domain to be prevented from being turned off if
>one of the CPUs in it has just been woken up and the interrupt is
>still pending.
Yes, that is true and we have been doing this on pretty much every QC
SoC there is, for CPU domains. Generally, there is a handshake of sorts
with the power domain controller when the core executes WFI. It
decrements the reference on the controller when going down and
increments when coming up. The controller is only turned off when the
reference count is 0 and is turned back on before the CPU is ready to
exit the WFI.

What we are doing here is hand the domain's ->power_off and ->power_on
over to the platform firmware, which needs to make sure the races are
handled correctly either in h/w or through mechanisms like MCPM or in
the firmware. I would consider what happens during the power on/off of
the domains beyond the realm of the genpd at least for CPU specific PM
domains.

Thanks,
Lina


