Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E629EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB39020657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfANM0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:26:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60816 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfANM0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:26:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C929680D;
        Mon, 14 Jan 2019 04:26:21 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AAE53F5BD;
        Mon, 14 Jan 2019 04:26:19 -0800 (PST)
Date:   Mon, 14 Jan 2019 12:26:16 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
Message-ID: <20190114122616.GD10258@lakrids.cambridge.arm.com>
References: <20190104141053.360F768D93@newverein.lst.de>
 <20190104175017.GA7157@lakrids.cambridge.arm.com>
 <20190114121359.GB26056@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114121359.GB26056@350D>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 11:13:59PM +1100, Balbir Singh wrote:
> On Fri, Jan 04, 2019 at 05:50:18PM +0000, Mark Rutland wrote:
> > Hi Torsten,
> > 
> > On Fri, Jan 04, 2019 at 03:10:53PM +0100, Torsten Duwe wrote:
> > > Use -fpatchable-function-entry (gcc8) to add 2 NOPs at the beginning
> > > of each function. Replace the first NOP thus generated with a quick LR
> > > saver (move it to scratch reg x9), so the 2nd replacement insn, the call
> > > to ftrace, does not clobber the value. Ftrace will then generate the
> > > standard stack frames.
> 
> Do we know what the overhead would be, if this was a link time change
> for the first instruction?

No, but it should be possible to benchamrk that for a given workload,
which is what I'd like to see.

> Also, I was under the impression that some arch's do ftrace_call_replace
> under stop_machine(), is that a possibility here?

Something like that is a possibility.

I think we need numbers either way.

Thanks,
Mark.
