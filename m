Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47450C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD37322429
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gIHzmkCw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pF69PpXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD37322429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeHJWtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:49:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeHJWtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:49:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AA24460807; Fri, 10 Aug 2018 20:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533932297;
        bh=DtQxNBxy1/RcWeXb3sKfaKn2PNQvRgg45B98YKz0VLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIHzmkCwP1hDPSFUWHhe1zta+idhbREOv7WbkGKpFQxzxgphaK2CNMMxhVQCpy3V5
         AH62O+DN4SRErVjTXxss/OWJyWntbLZp1NaZrcSeCpdUX2/iNkzU3mjOewqg/lAHGp
         47ZC5t77tU8jpiktIR7T01CXYv0iTpLiLHYTTfN8=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C51C660807;
        Fri, 10 Aug 2018 20:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533932296;
        bh=DtQxNBxy1/RcWeXb3sKfaKn2PNQvRgg45B98YKz0VLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pF69PpXo+6TSC5bDrpmhw640qg/AGIHGSUeqweo0ZMSTPCEsNdm5tGyPFFFpkRdlC
         2WGji47x53Aq+uIKkuM/4wRV0PkIsusNP0XHx+A3SBiKadehjycoRnuqACnkwJ3UGe
         huMYWtpMp7wUP/HyjD0aFTvl4A3kT16M0NPVMokQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C51C660807
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 10 Aug 2018 14:18:15 -0600
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
Message-ID: <20180810201815.GE5081@codeaurora.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <2056372.NMt4aPaF4h@aspire.rjw.lan>
 <2205807.cU2puvubpP@aspire.rjw.lan>
 <1726374.375PCQfjLZ@aspire.rjw.lan>
 <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
 <CAJZ5v0hk1wfm10fyycmddKF6wR4D51r30fD_-J5UDMbtB3+V-Q@mail.gmail.com>
 <20180808105619.GB25150@e107981-ln.cambridge.arm.com>
 <20180808180248.GC27850@codeaurora.org>
 <20180809102504.GB13428@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180809102504.GB13428@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09 2018 at 04:25 -0600, Lorenzo Pieralisi wrote:
>On Wed, Aug 08, 2018 at 12:02:48PM -0600, Lina Iyer wrote:
>> On Wed, Aug 08 2018 at 04:56 -0600, Lorenzo Pieralisi wrote:
>> >On Mon, Aug 06, 2018 at 11:37:55AM +0200, Rafael J. Wysocki wrote:
>> >>On Fri, Aug 3, 2018 at 1:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> >>> [...]
>> >>>
>> >>>>>
>> >>>>> Assuming that I have got that right, there are concerns, mostly regarding
>> >>>>> patch [07/26], but I will reply to that directly.
>> >>>>
>> >>>> Well, I haven't got that right, so never mind.
>> >>>>
>> >>>> There are a few minor things to address, but apart from that the general
>> >>>> genpd patches look ready.
>> >>>
>> >>> Alright, thanks!
>> >>>
>> >>> I will re-spin the series and post a new version once 4.19 rc1 is out.
>> >>> Hopefully we can queue it up early in next cycle to get it tested in
>> >>> next for a while.
>> >>>
>> >>>>
>> >>>>> The $subject patch is fine by me by itself, but it obviously depends on the
>> >>>>> previous ones.  Patches [01-02/26] are fine too, but they don't seem to be
>> >>>>> particularly useful without the rest of the series.
>> >>>>>
>> >>>>> As far as patches [10-26/26] go, I'd like to see some review comments and/or
>> >>>>> tags from the people with vested interest in there, in particular from Daniel
>> >>>>> on patch [12/26] and from Sudeep on the PSCI ones.
>> >>>>
>> >>>> But this still holds.
>> >>>
>> >>> Actually, patch 10 and patch11 is ready to go as well. I ping Daniel
>> >>> on patch 12.
>> >>>
>> >>> In regards to the rest of the series, some of the PSCI/ARM changes
>> >>> have been reviewed by Mark Rutland, however several changes have not
>> >>> been acked.
>> >>>
>> >>> On the other hand, one can also interpret the long silence in regards
>> >>> to PSCI/ARM changes as they are good to go. :-)
>> >>
>> >>Well, in that case giving an ACK to them should not be an issue for
>> >>the people with a vested interest I suppose.
>> >
>> >Apologies to everyone for the delay in replying.
>> >
>> >Side note: cpu_pm_enter()/exit() are also called through syscore ops in
>> >s2RAM/IDLE, you know that but I just wanted to mention it to compound
>> >the discussion.
>> >
>> >As for PSCI patches I do not personally think PSCI OSI enablement is
>> >beneficial (and my position has always been the same since PSCI OSI was
>> >added to the specification, I am not even talking about this patchset)
>> >and Arm Trusted Firmware does not currently support it for the same
>> >reason.
>> >
>> >We (if Mark and Sudeep agree) will enable PSCI OSI if and when we have a
>> >definitive and constructive answer to *why* we have to do that that is
>> >not a dogmatic "the kernel knows better" but rather a comprehensive
>> >power benchmark evaluation - I thought that was the agreement reached
>> >at OSPM but apparently I was mistaken.
>> >
>> I will not speak to any comparison of benchmarks between OSI and PC.
>> AFAIK, there are no platforms supporting both.
>
>PSCI specifications, 5.20.1:
>
>"The platform will boot in platform-coordinated mode."
>
>So all platforms implementing OSI have to support both.
>
I understand. But there are no actual platforms out there that support
both. QC platforms do not support Platform coordinated in the firmware.
The primary reason for not doing PC is that it did not fit the
requirements for all high level OSes running on the AP. Also, having
dead code in a firmware that also does secure aspects was not desirable
for QC platforms. That said, the decision to not do PC is beyond my pay
grade.

>> But, the OSI feature is critical for QCOM mobile platforms. The
>> last man activities during cpuidle save quite a lot of power.
>
>What I expressed above was that, in PSCI based systems (OSI or PC
>alike), it is up to firmware/hardware to detect "the last man" not
>the kernel.
>
>I need to understand what you mean by "last man activities" to
>provide feedback here.
>
When the last CPU goes down during deep sleep, the following would be
done
- Lower resource requirements for shared resources such as clocks,
  busses and regulators that were used by drivers in AP. These shared
  resources when not used by other processors in the SoC may be turned
  off and put in low power state by a remote processor. [1][2]
- Enable and setup wakeup capable interrupts on an always-on interrupt
  controller, so the GIC and the GPIO controllers may be put in low
  power state. [3][4]
- Write next known wakeup value to the timer, so the blocks that were
  powered off, may be brought back into operational before the wakeup.
  [4][5]

These are commonly done during suspend, but to achieve a good power
efficiency, we have to do this when all the CPUs are just executing CPU
idle. Also, they cannot be done from the firmware (because the data
required for all this is part of Linux). OSI plays a crucial role in
determining when to do all this.

>> Powering off the clocks, busses, regulators and even the oscillator is
>> very important to have a reasonable battery life when using the phone.
>> Platform coordinated approach falls quite short of the needs of a
>> powerful processor with a desired battery efficiency.
>
>I am sorry but if you want us to merge PSCI patches in this series you
>will have to back the claim above with a detailed technical explanation
>of *why* platform-coordination falls short of QCOM (or whoever else)
>needs wrt PSCI OSI.
These items above add much value to reduce latency in wakeup idle,
increase cache performance and increase days of use. Even if we had a
platform to test for platform coordinated, it would be hard to quantify
because of the inability to do low power state for resources and setting
up wakeup is not easily possible with platform coordinated. Not doing
it, would leave a lot of power efficiency and performance on the table.

Thanks,
Lina

[1]. https://lkml.org/lkml/2018/6/11/546
[2]. For older production code -
https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/soc/qcom/rpm-smd.c?h=LA.HB.1.1.5.c1
Line 1764.
[3]. https://lkml.org/lkml/2018/8/10/437
[4]. Older production code -
https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/soc/qcom/mpm-of.c?h=LA.HB.1.1.5.c1
[5]. https://lkml.org/lkml/2018/7/19/218


