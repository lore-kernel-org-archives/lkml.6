Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D36C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4649A24072
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4649A24072
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbeGDOD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:03:26 -0400
Received: from foss.arm.com ([217.140.101.70]:37866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752197AbeGDODY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:03:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 481BC18A;
        Wed,  4 Jul 2018 07:03:24 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 195303F5A0;
        Wed,  4 Jul 2018 07:03:24 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0D4F11AE189D; Wed,  4 Jul 2018 15:04:04 +0100 (BST)
Date:   Wed, 4 Jul 2018 15:04:04 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Popov <alex.popov@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: Clear the stack
Message-ID: <20180704140403.GE4828@arm.com>
References: <20180629190553.7282-1-labbott@redhat.com>
 <CAGXu5jL8kZHtg-MdScZ5m_6xH_Ho4TsdKGWH83zEL9Y5rutncw@mail.gmail.com>
 <706dc06b-0157-89cb-33a6-d0b9d811dcf0@redhat.com>
 <CAGXu5jLW5FJdRdRXcP=xPOEcQ=Tg+uSi=vj6vQ39iVp=QHSRAQ@mail.gmail.com>
 <20180702095931.GB28665@arm.com>
 <CAGXu5jJSUFFUpaWYToiKQymKR-wwem55WgAgbygWXdTfHQUs4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJSUFFUpaWYToiKQymKR-wwem55WgAgbygWXdTfHQUs4Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Mon, Jul 02, 2018 at 10:29:24AM -0700, Kees Cook wrote:
> On Mon, Jul 2, 2018 at 2:59 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Jun 29, 2018 at 01:25:20PM -0700, Kees Cook wrote:
> >> No worries! I've made the change locally and will push this out to
> >> -next unless there are objections?
> >
> > I'm a bit wary of conflicts in entry.S, since it's likely that we're going
> > to have a lot going on in there for 4.19.
> >
> > Could I take this via arm64 instead, please, or are there dependencies
> > on other parts of your tree?
> 
> It depends on the plugin existing, but we could split it up so the
> arm64 part could go separately. It would just be a no-op in the arm64
> tree since CONFIG_GCC_PLUGIN_STACKLEAK won't exist there. Whatever
> works best for you!

If you could split it up then that would be really helpful, please.

Thanks,

Will
