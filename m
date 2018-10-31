Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6FEECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F315520685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HA1WlLxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F315520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeJaSmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:42:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJaSmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5duRF5Ve0wJcAnT0Nx+ccoQUyWmGXvrB97qVmZnpHNQ=; b=HA1WlLxiJQhwR98VcoVIEWsUTd
        G9aW8fe9+smp2ldyfb4DGTjYtjxKvVtcCafBMsG3R0hx3Wp4tZTzf/GznxbP/NftKQs4bTqhsV64S
        8FPhoT/LUpOCxZFLg+KzJG6GJpZVWb16efuo9KPb2iU6kCqj2WYSeP5PHNzM6vs9/6gRiIb2X5WZS
        SQVQ9yKiPvOf8mnycWNn+v8wkg4+bMLyOa3LXatp/KOAsWXrhLsKhp54Ui4OpJY50lyPfdr7ogFN9
        LDW/27qcUabj6v4H+K4LqALcOFU+/mVwVYlUcbCltJ3qhjy1ay+KAHTPCSRCf3QIrDJgXUFyxfcQw
        QxAvu8wQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHn3k-0000rL-F1; Wed, 31 Oct 2018 09:45:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A8B492029FA14; Wed, 31 Oct 2018 10:45:06 +0100 (CET)
Date:   Wed, 31 Oct 2018 10:45:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 10/17] prmem: documentation
Message-ID: <20181031094506.GM744@hirez.programming.kicks-ass.net>
References: <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
 <20181030182841.GE7343@cisco>
 <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
 <BAA65A07-F3AF-4209-9D18-7075CEF11EE8@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BAA65A07-F3AF-4209-9D18-7075CEF11EE8@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 02:02:12PM -0700, Andy Lutomirski wrote:
> But I dislike allowing regular writes in the protected region. We
> really only need four write primitives:
> 
> 1. Just write one value.  Call at any time (except NMI).
> 
> 2. Just copy some bytes. Same as (1) but any number of bytes.

Given the !preempt/!IRQ contraints I'd certainly put an upper limit on
the number of bytes there.

> 3,4: Same as 1 and 2 but must be called inside a special rare write
> region. This is purely an optimization.
> 
> Actually getting a modifiable pointer should be disallowed for two
> reasons:
> 
> 1. Some architectures may want to use a special
> write-different-address-space operation.

You're thinking of s390 ? :-)

> Heck, x86 could, too: make
> the actual offset be a secret and shove the offset into FSBASE or
> similar. Then %fs-prefixed writes would do the rare writes.

> 2. Alternatively, x86 could set the U bit. Then the actual writes
> would use the uaccess helpers, giving extra protection via SMAP.

Cute, and yes, something like that would be nice.

> We don’t really want a situation where an unchecked pointer in the
> rare write region completely defeats the mechanism.

Agreed.
