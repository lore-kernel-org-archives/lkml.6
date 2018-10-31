Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19C2ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B8220664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LuMwa/8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B8220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeJaTAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:00:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeJaTAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KhMAhBPCmFC0aUGbgvoiLZH5FhFNf1AiTeeE2IzOrhY=; b=LuMwa/8TiPSDzsOWBP0RSErtj
        PJ6TLUo+qujpl+Whj7KyBUlK6DyJp90I2jNlS9IJP/4GMpWFocmOpzoM67lBZAjg6jlyPDLuQdet1
        gpo3U8iQqRwBUbJ3OvWSXOnIZHdSIEaXiO19drefFcvr+LD5wYEQ5inl/G66ug0TxUe4ZPWZqercE
        M5CcuGDu54hHOjM+XD+68VqtG15QIEEHB7hITbl73jYojpEUOsZ/wba3J0VIbHos52xextiMcA94x
        zLsiE152bCMxYQg4rpX6lo9stPPTCUQ45oSjTG6HN0qWpVdRhmNSLmK2ToFLEXrzIU2B5Qkh+ItCy
        EN+5JVjNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHnKh-00063y-G6; Wed, 31 Oct 2018 10:02:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 665ED2029FA14; Wed, 31 Oct 2018 11:02:37 +0100 (CET)
Date:   Wed, 31 Oct 2018 11:02:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
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
Message-ID: <20181031100237.GN744@hirez.programming.kicks-ass.net>
References: <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
 <20181030182841.GE7343@cisco>
 <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
 <20181030213557.GE10491@bombadil.infradead.org>
 <CALCETrW1FcT88u0QY9k_PMOeZj0G8H6KNb5Bnreo-12NvmmCEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW1FcT88u0QY9k_PMOeZj0G8H6KNb5Bnreo-12NvmmCEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 09:41:13PM -0700, Andy Lutomirski wrote:
> To clarify some of this thread, I think that the fact that rare_write
> uses an mm_struct and alias mappings under the hood should be
> completely invisible to users of the API.  No one should ever be
> handed a writable pointer to rare_write memory (except perhaps during
> bootup or when initializing a large complex data structure that will
> be rare_write but isn't yet, e.g. the policy db).

Being able to use pointers would make it far easier to do atomics and
other things though.

> For example, there could easily be architectures where having a
> writable alias is problematic.

Mostly we'd just have to be careful of cache aliases, alignment should
be able to sort that I think.

> If you have multiple pools and one mm_struct per pool, you'll need a
> way to find the mm_struct from a given allocation.

Or keep track of it externally. For example by context. If you modify
page-tables you pick the page-table pool, if you modify selinux state,
you pick the selinux pool.

> Regardless of how the mm_structs are set up, changing rare_write
> memory to normal memory or vice versa will require a global TLB flush
> (all ASIDs and global pages) on all CPUs, so having extra mm_structs
> doesn't seem to buy much.

The way I understand it, the point is that if you stick page-tables and
selinux state in different pools, a stray write in one will never affect
the other.

