Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF41C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE5720832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE5720832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeK2HBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:01:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49666 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbeK2HBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:01:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09AC8A78;
        Wed, 28 Nov 2018 11:59:04 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD09F3F59C;
        Wed, 28 Nov 2018 11:59:03 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0E2A61AE0A5A; Wed, 28 Nov 2018 19:59:22 +0000 (GMT)
Date:   Wed, 28 Nov 2018 19:59:22 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH] arm64: ftrace: Fix to enable syscall events on arm64
Message-ID: <20181128195921.GA32668@arm.com>
References: <CAA93ih1-xpm1P0suT6SNCc_ARvAfyBEwb0-uKFikM5k4CvG8jg@mail.gmail.com>
 <154333618522.27355.8094935453351562295.stgit@devbox>
 <20181127165848.GA19569@arm.com>
 <20181127131859.79ce7da9@gandalf.local.home>
 <20181128085555.a8987cbe18aa6d1d1f0a827e@kernel.org>
 <20181128120502.GC24868@arm.com>
 <20181128092223.2a100448@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128092223.2a100448@gandalf.local.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 09:22:23AM -0500, Steven Rostedt wrote:
> On Wed, 28 Nov 2018 12:05:02 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> 
> > Ok! Then please add a comment to arch_syscall_match_sym_name() along those
> > lines, and you can add my ack:
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Shouldn't this go through your tree?

Yup; I'm hoping Catalin will pick it up as a fix for 4.20 (we take it in
turns, so I'm looking at stuff for 4.21 atm).

Will
