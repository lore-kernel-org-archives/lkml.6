Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37236C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F692192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbfBOSUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:20:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37266 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388282AbfBOSUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:20:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 899E0A78;
        Fri, 15 Feb 2019 10:20:43 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCE553F589;
        Fri, 15 Feb 2019 10:20:40 -0800 (PST)
Date:   Fri, 15 Feb 2019 18:20:38 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        julien.thierry@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, steven.price@arm.com,
        Christoffer Dall <christoffer.dall@arm.com>,
        kvmarm@lists.cs.columbia.edu, ykaukab@suse.de, dave.martin@arm.com,
        shankerd@codeaurora.org
Subject: Re: [PATCH v4 03/12] arm64: Remove the ability to build a kernel
 without ssbd
Message-ID: <20190215182037.GI100037@arrakis.emea.arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-4-jeremy.linton@arm.com>
 <20190130180415.0cab24e0@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130180415.0cab24e0@donnerap.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:04:15PM +0000, Andre Przywara wrote:
> On Fri, 25 Jan 2019 12:07:02 -0600
> Jeremy Linton <jeremy.linton@arm.com> wrote:
> > Buried behind EXPERT is the ability to build a kernel without
> > SSBD, this needlessly clutters up the code as well as creates
> > the opportunity for bugs. It also removes the kernel's ability
> > to determine if the machine its running on is vulnerable.
> 
> I don't know the original motivation for this config option, typically
> they are not around for no reason.
> I see the benefit of dropping those config options, but we want to make
> sure that people don't start hacking around to remove them again.
> 
> > Since its also possible to disable it at boot time, lets remove
> > the config option.
> 
> Given the level of optimisation a compiler can do with the state being
> known at compile time, I would imagine that it's not the same (though
> probably very close).
> 
> But that's not my call, it would be good to hear some maintainer's
> opinion on this.

Having spoken to Will, we'd rather keep the config options if possible.
Even if they are behind EXPERT and default y, they come in handy when
debugging.

Can we still have the sysfs information regardless of whether the config
is enabled or not? IOW, move the #ifdefs around to always have the
detection while being able to disable the actual workarounds via config?

Are the code paths between config and cmdline disabling identical? At a
quick look I got the impression they are not exactly the same.

-- 
Catalin
