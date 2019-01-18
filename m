Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3127C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5120204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfARLcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:32:53 -0500
Received: from foss.arm.com ([217.140.101.70]:55218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfARLcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:32:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 370D380D;
        Fri, 18 Jan 2019 03:32:53 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3AFE3F557;
        Fri, 18 Jan 2019 03:32:50 -0800 (PST)
Date:   Fri, 18 Jan 2019 11:32:42 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Pramod Kumar <pramod.kumar@broadcom.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
Message-ID: <20190118113242.GA8928@e107155-lin>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:16:20AM +0530, Pramod Kumar wrote:
> If CPU hotplug is supported, ipi_cpu_stop should use PSCI cpudie
> call to stop the CPU. This call ensures L1/L2 cache flush,
> CPUs cache-cohenrecy setting w.r.to interconnect.
>

Firstly, this is not specific to PSCI and I don't see any PSCI calls as
$subject claims. Next, you fail to explain why do you have to ensure
caches are cleaned and why do you need that in ipi_cpu_stop ?
What's the use case ?

> Apart from this, this gives control to f/w to reduce power consumption
> by take appropriate decesion on power rails for plugging-out core.
>

May be, but ipi_cpu_stop is used is machine reboot/poweroff/halt which
may restart or poweroff the system, powering down individual CPUs is not
necessary and may consume lot of time in systems with large number of CPUs.
It would be good to know the use-case in case I am missing to consider
that.

--
Regards,
Sudeep
