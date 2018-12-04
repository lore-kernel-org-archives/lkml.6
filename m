Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2BDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03932082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03932082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeLDSXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:23:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbeLDSXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:23:48 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60FFE2081B;
        Tue,  4 Dec 2018 18:23:47 +0000 (UTC)
Date:   Tue, 4 Dec 2018 13:23:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        mingo@redhat.com, Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
Message-ID: <20181204132344.2fcf13c3@vmware.local.home>
In-Reply-To: <CADYN=9K+On_Qbd_4a+C=59tffWiLF9YwACF4kXyTtDU1mazxjA@mail.gmail.com>
References: <20181130150956.27620-1-anders.roxell@linaro.org>
        <20181203192228.GC29028@arm.com>
        <CAK8P3a2gekEqUuvsC-_+ijhiqqff2bK-s2wQfkjn7z-HtNnMDQ@mail.gmail.com>
        <20181204005012.11f73df9@vmware.local.home>
        <20181204111242.GA32596@arm.com>
        <20181204122627.225befaa@vmware.local.home>
        <CADYN=9K+On_Qbd_4a+C=59tffWiLF9YwACF4kXyTtDU1mazxjA@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 19:07:16 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:


> > > > +   schedulable = !irqs_disabled() & !preempt_count();  
> > >
> > > Looks suspiciously like a bitwise preemptible() to me!  
> >
> > Ah, thanks. Yeah, that should have been &&. But what did you expect.
> > I didn't even compile this ;-)
> >  


> > If it does, then I'll add it. Or take a patch for it ;-)  
> 
> I tested your patch. it worked.
> 
> I'll send a patch shortly.
>

Thanks. Please add a comment above the schedulable test stating that
some archs call this with interrupts or preemption disabled, but
other archs don't and this can cause a tremendous unneeded latency.

-- Steve
 
