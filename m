Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC1AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2A1208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="elq6sHTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2A1208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeK2TLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:11:34 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37038 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeK2TLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:11:32 -0500
Received: by mail-vs1-f67.google.com with SMTP id h18so608813vsj.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 00:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yEaeayPmO0YnoftslT2ejHvS42yrzrZiYJovhPn/xE=;
        b=elq6sHTwgwZfaEvETwZQ/j2c3rOkVyxP3G7x4xy9M+EyLu6XLnzjbHP3J/9qhNyWVy
         totM1ddPI28kikLfuqsKSY66gyZCV2wCR2tRfsMQ1nSDJZk3IJcBRVjyInBBAmU70pNz
         qTlSboiFiBHAa1h1sFKpSdGYGnAzBd0LKbSEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yEaeayPmO0YnoftslT2ejHvS42yrzrZiYJovhPn/xE=;
        b=KE169z4C/QIsabrJ+MugjHN1CcWk9XqClRtbb0W4uRhZ0Yb92caU1W8S2lIe9JuVGb
         dMaDnvPc7Hyig3ZnQ5RS3mzgpA1AU5tikHNnLM7Tt0wiBeNZ9jZe3iEq+PwVvNzqNrXs
         uoaPJsck9Ub6fLo2LpuK8DXL9/vnIwxhVy3hqr7wGLe5JlJEwV4lHU/EH1kTFyxes9pf
         WZyye9mrr5IW8MVnGRtOe6s6KrjaynukYMNaQddYvzGxeFh65up0c0pg+GGRQ9ZDOKnl
         KoTIRi6gcTqBnW9uN+MxahlIz6VAYmN00u7zWOCYWHMXqeLi/rHNFkvnmV0/KXX8Pwk2
         IIag==
X-Gm-Message-State: AA+aEWafWzL12wbMRVBbQmV9Ywbxum5gDElKhRJ+wMksIQ63P+510cC0
        B25Yi18zJdAD6n5MZaMx7nV9BbJ24uIKjWsq816K0Q==
X-Google-Smtp-Source: AFSGD/Wl/EXXYlWEBE1Ptqa8QC1fWdpxEOqAG+M9nAXqmaGsnVIPRapGgLKoe0VNkJbp2bqNAP1e4V707nv1NCf6n+M=
X-Received: by 2002:a67:7685:: with SMTP id r127mr208305vsc.35.1543478821119;
 Thu, 29 Nov 2018 00:07:01 -0800 (PST)
MIME-Version: 1.0
References: <9986634.fXZiTbRPzQ@aspire.rjw.lan>
In-Reply-To: <9986634.fXZiTbRPzQ@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Nov 2018 09:06:25 +0100
Message-ID: <CAPDyKFp_1nCF7nn0dXYbm_kJDo+0rp8O1nGPFH+NrS3wz8RW1Q@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: admin-guide: PM: Add cpuidle document
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        jacob.jun.pan@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        ggherdovich@suse.cz, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 at 12:47, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Important information is missing from user/admin cpuidle documentation
> available today, so add a new user/admin document for cpuidle containing
> current and comprehensive information to admin-guide and drop the old
> .txt documents it is replacing.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Wow! Great work!

[...]

> +.. _idle-states-representation:
> +
> +Representation of Idle States
> +=============================
> +
> +For the CPU idle time management purposes all of the physical idle states
> +supported by the processor have to be represented as a one-dimensional array of
> +|struct cpuidle_state| objects each allowing an individual (logical) CPU to ask
> +the processor hardware to enter an idle state of certain properties.  If there
> +is a hierarchy of units in the processor, one |struct cpuidle_state| object can
> +cover a combination of idle states supported by the units at different levels of
> +the hierarchy.  In that case, the `target residency and exit latency parameters
> +of it <idle-loop_>`_, must reflect the properties of the idle state at the
> +deepest level (i.e. the idle state of the unit containing all of the other
> +units).
> +
> +For example, take a processor with two cores in a larger unit referred to as
> +a "module" and suppose that asking the hardware to enter a specific idle state
> +(say "X") at the "core" level by one core will trigger the module to try to
> +enter a specific idle state of its own (say "MX") if the other core is in idle
> +state "X" already.  In other words, asking for idle state "X" at the "core"
> +level gives the hardware a license to go as deep as to idle state "MX" at the
> +"module" level, but there is no guarantee that this is going to happen (the core
> +asking for idle state "X" may just end up in that state by itself instead).

This is a good description of a HW like x86 and ARM64 (using PSCI in
platform coordinated mode).

However, for "legacy" ARM products, having at least two cores in a
module, this description does in many cases *not* match how the HW
works. I wonder about other architectures.

My point is, I think it would be fair to mention that the above
description is specific to certain HWs. In other words, for HWs that
leaves the entire state synchronization of the last man standing
algorithm to be managed by a FW, the cpuidle framework plays well. But
for others it has limitations.

> +Then, the target residency of the |struct cpuidle_state| object representing
> +idle state "X" must reflect the minimum time to spend in idle state "MX" of
> +the module (including the time needed to enter it), because that is the minimum
> +time the CPU needs to be idle to save any energy in case the hardware enters
> +that state.  Analogously, the exit latency parameter of that object must cover
> +the exit time of idle state "MX" of the module (and usually its entry time too),
> +because that is the maximum delay between a wakeup signal and the time the CPU
> +will start to execute the first new instruction (assuming that both cores in the
> +module will always be ready to execute instructions as soon as the module
> +becomes operational as a whole).

For the HW working as you described, this is a nice clarification, thanks!

[...]

> +
> +.. _cpu-pm-qos:
> +
> +Power Management Quality of Service for CPUs
> +============================================
> +
> +The power management quality of service (PM QoS) framework in the Linux kernel
> +allows kernel code and user space processes to set constraints on various
> +energy-efficiency features of the kernel to prevent performance from dropping
> +below a required level.  The PM QoS constraints can be set globally, in
> +predefined categories referred to as PM QoS classes, or against individual
> +devices.
> +
> +CPU idle time management can be affected by PM QoS in two ways, through the
> +global constraint in the ``PM_QOS_CPU_DMA_LATENCY`` class and through the

No objections to the description, it's really nice! However, the
naming of this QOS class, is to me, rather confusing.

I realize renaming the sysfs node is not an option, but maybe we
should make a tree wide change to rename the class to something more
descriptive. What do you think?

[...]

Kind regards
Uffe
