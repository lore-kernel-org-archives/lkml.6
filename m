Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E9EECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DF720685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XE6cCwPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DF720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeJaTJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:09:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35630 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeJaTJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gq+In4AB5xCINJI4HV1K716XlMaT2LdiwoPTCQL+wv4=; b=XE6cCwPxeHBHyBSmrkkSTtRE4
        fFj0439HWdMorMVwv7jsOrdkAXPvSjMnG/TENzReeveGoTBa+dxhZ76iqkmyThYV/MB1dmgIPVqQD
        MSKW5vE1nLpkVp6eBNJowgXIICZK7MbBSZUKahue+7DkfjGMRbFJvFyPf99SqB95s3MrWytVaO4jf
        51lu/xx4Qn4ZxcZbAUCoYETUTMyP21EfRyu9SmJn9YN/f42JOr7Bk1P1enkB2Pkn/e4MoXiAxENhO
        G87ck59YrOaR4fQ2/VojZzeVciQeAaKM9RVVxbQqXVNCiE30fW+THRoTmxgxZNEZ2lKjn3j4mg7Cj
        Eoe6im17Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHnTD-0002jN-Qt; Wed, 31 Oct 2018 10:11:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34E802029FA14; Wed, 31 Oct 2018 11:11:24 +0100 (CET)
Date:   Wed, 31 Oct 2018 11:11:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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
Message-ID: <20181031101124.GO744@hirez.programming.kicks-ass.net>
References: <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
 <20181030182841.GE7343@cisco>
 <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
 <BAA65A07-F3AF-4209-9D18-7075CEF11EE8@amacapital.net>
 <2cfb3835-0c18-b3fb-1722-5d693ae0ecd2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cfb3835-0c18-b3fb-1722-5d693ae0ecd2@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:15:46AM +0200, Igor Stoppa wrote:
> On 30/10/2018 23:02, Andy Lutomirski wrote:

> > But I dislike allowing regular writes in the protected region. We
> > really only need four write primitives:
> > 
> > 1. Just write one value.  Call at any time (except NMI).
> > 
> > 2. Just copy some bytes. Same as (1) but any number of bytes.
> > 
> > 3,4: Same as 1 and 2 but must be called inside a special rare write
> > region. This is purely an optimization.
> 
> Atomic? RCU?

RCU can be done, that's not really a problem. Atomics otoh are a
problem. Having pointers makes them just work.

Andy; I understand your reason for not wanting them, but I really don't
want to duplicate everything. Is there something we can do with static
analysis to make you more comfortable with the pointer thing?
