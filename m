Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E28DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E0520BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E0520BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeGLMTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:19:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50322 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbeGLMTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:19:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75363ED1;
        Thu, 12 Jul 2018 05:09:58 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4762A3F5B1;
        Thu, 12 Jul 2018 05:09:58 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 9D3491AE53FB; Thu, 12 Jul 2018 13:10:40 +0100 (BST)
Date:   Thu, 12 Jul 2018 13:10:40 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH] arm64: Clear the stack
Message-ID: <20180712121040.GB16043@arm.com>
References: <20180629190553.7282-1-labbott@redhat.com>
 <CAGXu5jLwhdKy6rfSKOeN2hajP5aCnYeT3yMka5ZbJ_o02z=WTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLwhdKy6rfSKOeN2hajP5aCnYeT3yMka5ZbJ_o02z=WTA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 05:05:32PM -0700, Kees Cook wrote:
> On Fri, Jun 29, 2018 at 12:05 PM, Laura Abbott <labbott@redhat.com> wrote:
> >  include/linux/stackleak.h             |  1 +
> > [...]
> > diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
> > index e2da99b3a191..00d62b302efb 100644
> > --- a/include/linux/stackleak.h
> > +++ b/include/linux/stackleak.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/sched/task_stack.h>
> >
> > +#include <asm/stacktrace.h>
> >  /*
> >   * Check that the poison value points to the unused hole in the
> >   * virtual memory map for your platform.
> 
> FYI, I squashed this change into my copy of the stackleak v14 series.
> (And I just sent this arm64 patch with the adjustments for it to be
> stand-alone.)

I can't find that -- can you point me to it, please?

Will
