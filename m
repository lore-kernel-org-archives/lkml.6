Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA6CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC402084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC402084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbeGSLYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:24:07 -0400
Received: from foss.arm.com ([217.140.101.70]:47068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbeGSLYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:24:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE42780D;
        Thu, 19 Jul 2018 03:41:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FD353F246;
        Thu, 19 Jul 2018 03:41:32 -0700 (PDT)
Date:   Thu, 19 Jul 2018 11:41:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     will.deacon@arm.com, catalin.marinas@arm.com, alex.popov@linux.com,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com
Subject: Re: [PATCH] arm64: Clear the stack
Message-ID: <20180719104130.egfevpo3ie4azaq6@lakrids.cambridge.arm.com>
References: <20180629190553.7282-1-labbott@redhat.com>
 <9733d929-3c6a-40e1-6110-8f79975323d3@linux.com>
 <1b97aa7d-2b6c-a5df-0caa-1cd16e18a816@redhat.com>
 <20180703121440.v4olvwqb3ykgt5fm@lakrids.cambridge.arm.com>
 <06dd55e6-d39e-7617-b644-bdd04fa3c030@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06dd55e6-d39e-7617-b644-bdd04fa3c030@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 17, 2018 at 03:58:19PM -0700, Laura Abbott wrote:
> On 07/03/2018 05:14 AM, Mark Rutland wrote:
> > > It might be cleaner just to use on_accessible_stack and then another
> > > function to get the top of stack. This also might just be
> > > reimplementing what x86 already has? (Mark, Ard?)
> > It looks like we could build a get_stack_info() as they have.
> > 
> > We could probably clean up our stack traced atop of that, too.
> 
> So I spent some time looking at this and I'm not 100% clear
> if there would actually be much benefit to re-writing with
> get_stack_info. Most of that design seems to come from x86
> needing to handle multiple unwind options which arm64 doesn't
> need to worry about. Any rework ended up with roughly
> the same code without any notable benefit that I could see.
> It's possible I'm missing what kind of cleanup you're suggesting
> but I think just going with a tweaked version of on_accessible_stack
> would be fine.

I was mostly thinking that a struct stack_info with stack type
enumeration would also be helpful for ensuring that we terminated stack
traces when we had a loop.

I'll reply on your new thread.

Thanks,
Mark.
