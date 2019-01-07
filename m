Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51314C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2859A2183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfAGOjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:39:33 -0500
Received: from foss.arm.com ([217.140.101.70]:60530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfAGOjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:39:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D704680D;
        Mon,  7 Jan 2019 06:39:30 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 364973F5AF;
        Mon,  7 Jan 2019 06:39:29 -0800 (PST)
Date:   Mon, 7 Jan 2019 14:39:24 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, mingo@redhat.com,
        rostedt@goodmis.org, akpm@linux-foundation.org
Subject: Re: [RFC PATCH 3/3] arm64: add a new config option KTEST_RUNNABLE
Message-ID: <20190107143924.GA46743@lakrids.cambridge.arm.com>
References: <20181213122910.24193-1-anders.roxell@linaro.org>
 <20181213122910.24193-4-anders.roxell@linaro.org>
 <20181213151823.GK10669@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213151823.GK10669@sirena.org.uk>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 03:18:23PM +0000, Mark Brown wrote:
> On Thu, Dec 13, 2018 at 01:29:10PM +0100, Anders Roxell wrote:
> 
> > With this new config option, we can boot a allmodconfig kernel in qemu.
> > Config options SERIAL_AMBA_PL011, SERIAL_AMBA_PL011_CONSOLE, UNIX needs
> > to be enabled in order to get a console. Options like CPU_BIG_ENDIAN,
> > CMDLINE_FORCE, CMDLINE_OVERRIDE and HVC_DCC needs to be disabled.
> 
> Does ktest really not run with BIG_ENDIAN?  
> 
> > +config KTEST_RUNNABLE
> > +	bool "Test build kernels that run in qemu for ktest"
> > +	select SERIAL_AMBA_PL011
> > +	select SERIAL_AMBA_PL011_CONSOLE
> > +	select UNIX
> 
> The opposite angle for my question on patch 1 I guess but is this really
> a generic thing for running ktest?  It seems like it's specific to qemu
> (and other systems which have the PL011 as the console serial port).

This is definitely platform-specific rather than ktest specific.

If I wanted to run ktest in a kvmtool VM, I would not need PL011 at all,
since that uses 8250 and virtio-console.

Thanks,
Mark.
