Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CBDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFB42054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFB42054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeJaXQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:16:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41634 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbeJaXQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:16:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 597F7341;
        Wed, 31 Oct 2018 07:18:24 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D26353F71D;
        Wed, 31 Oct 2018 07:18:21 -0700 (PDT)
Date:   Wed, 31 Oct 2018 14:18:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, kristina.martsenko@arm.com
Subject: Re: [PATCH v4 1/3] arm64: implement ftrace with regs
Message-ID: <20181031141819.lv2tuj4ne5nf3lh3@lakrids.cambridge.arm.com>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142148.6353A68C94@newverein.lst.de>
 <20181031121002.hmag2mwvlpzwobvf@lakrids.cambridge.arm.com>
 <nycvar.YFH.7.76.1810311417361.30233@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1810311417361.30233@cbobk.fhfr.pm>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 02:19:07PM +0100, Jiri Kosina wrote:
> On Wed, 31 Oct 2018, Mark Rutland wrote:
> 
> > I guess skipping the original function prologue would simplify the
> > implementation of the replacement function (and would mean that the regs
> > held the function arguments per the procedure call standard), but AFAICT
> > other architectures aren't relying on that, so it doesn't seem to be a
> > strict requirement.
> > 
> > What am I missing?
> > 
> > How does livepatching handle the pre-mcount function preambles on
> > architectures with existing support?
> 
> Other architectures do rely on that. That's exactly for example why on x86 
> we use '-pg -mfentry', to make sure we hook the function *before* 
> prologue.

Ah, I'd missed -mfentry for x86. I now see that's also the case with
__gnu_mcount_nc on arch/arm, so that covers my confusion.

Thanks for correcting me, and sorry for noise!

Mark.
