Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F755C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86C5217D2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86C5217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeHIMXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:23:01 -0400
Received: from foss.arm.com ([217.140.101.70]:51240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbeHIMXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:23:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D52718A;
        Thu,  9 Aug 2018 02:58:55 -0700 (PDT)
Received: from e107155-lin (e107155-lin.Emea.Arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C95643F5D4;
        Thu,  9 Aug 2018 02:58:51 -0700 (PDT)
Date:   Thu, 9 Aug 2018 10:58:44 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 09/26] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
Message-ID: <20180809095844.GA3444@e107155-lin>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <2056372.NMt4aPaF4h@aspire.rjw.lan>
 <2205807.cU2puvubpP@aspire.rjw.lan>
 <1726374.375PCQfjLZ@aspire.rjw.lan>
 <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
 <CAJZ5v0hk1wfm10fyycmddKF6wR4D51r30fD_-J5UDMbtB3+V-Q@mail.gmail.com>
 <20180808105619.GB25150@e107981-ln.cambridge.arm.com>
 <20180808180248.GC27850@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808180248.GC27850@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 12:02:48PM -0600, Lina Iyer wrote:

[...]

> I will not speak to any comparison of benchmarks between OSI and PC.
> AFAIK, there are no platforms supporting both.
>

That's the fundamental issue here. So we have never ever done a proper
comparison.

> But, the OSI feature is critical for QCOM mobile platforms. The
> last man activities during cpuidle save quite a lot of power. Powering
> off the clocks, busses, regulators and even the oscillator is very
> important to have a reasonable battery life when using the phone.
> Platform coordinated approach falls quite short of the needs of a
> powerful processor with a desired battery efficiency.
>

As mentioned above, without the actual comparison it's hard to justify
that. While there are corner cases where OSI is able to make better
judgement, may be we can add ways to deal with that in the firmware
with PC mode, have we explored that before adding complexity to the OSPM ?
Since the firmware complexity with OSI remains same as PC mode, isn't it
worth checking if the corner case we are talking here can be handled in
the firmware.

--
Regards,
Sudeep
