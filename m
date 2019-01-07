Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9350C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B932183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfAGR7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:59:21 -0500
Received: from foss.arm.com ([217.140.101.70]:35956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfAGR7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:59:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E653F15AB;
        Mon,  7 Jan 2019 09:59:18 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4616A3F5A0;
        Mon,  7 Jan 2019 09:59:17 -0800 (PST)
Date:   Mon, 7 Jan 2019 17:59:11 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, mingo@redhat.com,
        rostedt@goodmis.org, akpm@linux-foundation.org
Subject: Re: [RFC PATCH 3/3] arm64: add a new config option KTEST_RUNNABLE
Message-ID: <20190107175911.GA11863@lakrids.cambridge.arm.com>
References: <20181213122910.24193-1-anders.roxell@linaro.org>
 <20181213122910.24193-4-anders.roxell@linaro.org>
 <20190107144356.GB46743@lakrids.cambridge.arm.com>
 <20190107175531.GN9570@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107175531.GN9570@sirena.org.uk>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 05:55:31PM +0000, Mark Brown wrote:
> On Mon, Jan 07, 2019 at 02:43:57PM +0000, Mark Rutland wrote:
> 
> > Is it possible to use an allyesconfig rather than an allmodconfig? That
> > would leave all relevant options built-in.
> 
> The allyesconfig would make it more difficult to apply this approach to
> real hardware which is part of the goal here - the idea was to come up
> with a way of making runnable configurations which are likely to be
> usable with random userspace testsuites in order to avoid needing ever
> expanding combinations of builds.

Ok.

Is it somehow possible to fuse defconfig with an allmodconfig, with
defconfig's CONFIG_FOO=y taking precedence over allmodconfig's
CONFIG_FOO=m?

IIUC, that would give you the necessary platform bits, at least for
anything supported by defconfig. That would also happen to get
CONFIG_UNIX=y, too.

Thanks,
Mark.
