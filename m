Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16FBC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87DD2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87DD2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbeGSLVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:21:55 -0400
Received: from foss.arm.com ([217.140.101.70]:47002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeGSLVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:21:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 757B215AD;
        Thu, 19 Jul 2018 03:39:23 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 663333F246;
        Thu, 19 Jul 2018 03:39:22 -0700 (PDT)
Date:   Thu, 19 Jul 2018 11:39:19 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Qais Yousef <Qais.Yousef@arm.com>
Subject: Re: arm: v4.18-rc5 with cpuidle on TC2 (A7 boot) spectre v2 issue
Message-ID: <20180719103919.GB19287@e105550-lin.cambridge.arm.com>
References: <2abc6c11-2e8c-a4ea-6911-0f495d90ace6@arm.com>
 <20180719100109.GH17271@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719100109.GH17271@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:01:10AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 19, 2018 at 11:42:50AM +0200, Dietmar Eggemann wrote:
> > Hi,
> > 
> > running v4.18-rc5 (plus still missing "power: vexpress: fix corruption in
> > notifier registration", otherwise I get this rcu_sched stall issue) on TC2
> > (A7 boot) with vanilla multi_v7_defconfig plus
> > CONFIG_ARM_BIG_LITTLE_CPUIDLE=y gives me continuous:
> > 
> > ...
> >  CPUX: Spectre v2: incorrect context switching function, system vulnerable
> > ...
> > 
> > messages.
> > 
> > Work around is to disable CONFIG_HARDEN_BRANCH_PREDICTOR.
> 
> or disable big.Little if you want the hardening.
> 
> The choices are currently either protection against Spectre or big.Little
> support since the two are mutually exclusive at the moment.

Would it be possible to make those message only appear once like they do
when booting on A15?

As it is we have to change the default setting of this new option to
make the platform useable as those messages are flooding the console. I
see >40 messages per second.

Morten
