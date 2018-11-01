Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED8C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A126520820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nRyiJF6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A126520820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeKBCMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:12:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54836 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKBCMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jSislqE+AJGzdIO99eirTTUGxDTH9V/LGpGloAJW35M=; b=nRyiJF6tEzjAixqDn2meRKEED
        lO5z+OQNvMn+JOexJIrYS17meAWxSJRNr7iK5D4iB1FDqRg0DY3C3cPB3XrKJxkvS2PLp8PnpPExn
        x1E/YLbvw153MFd3L0tGkOC4bplwgrhmr8QvZc9N4ZF1OqJwmXZ84I6fEI5JBKAQ7c+YAvEqP5M5t
        7AnQZYuad0vLe6eIAc3CNSMmvVxTiLecDSEeRRcg48oi556JJIUs5jiQMkVJQ+8qWEhKk4j83CO3J
        YB9G7Z+4SUBkJ1hmw0sJsQiPG9tEeqEsQpstZGGEsw2bnMZGpmQn5ZJYaD7ZaRu4L9nHZymD2+kju
        RFFMAgk7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIGS3-0005l6-Lt; Thu, 01 Nov 2018 17:08:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 702D72029F9FF; Thu,  1 Nov 2018 18:08:09 +0100 (CET)
Date:   Thu, 1 Nov 2018 18:08:09 +0100
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
Message-ID: <20181101170809.GG3178@hirez.programming.kicks-ass.net>
References: <20181030175814.GB10491@bombadil.infradead.org>
 <20181030182841.GE7343@cisco>
 <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
 <20181030213557.GE10491@bombadil.infradead.org>
 <CALCETrW1FcT88u0QY9k_PMOeZj0G8H6KNb5Bnreo-12NvmmCEQ@mail.gmail.com>
 <20181031100237.GN744@hirez.programming.kicks-ass.net>
 <659CFC78-22BF-492B-B2E4-B8E89AA08446@amacapital.net>
 <20181031210032.GA3159@hirez.programming.kicks-ass.net>
 <2E29C35B-3F98-473D-A874-0D9B9B15B399@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E29C35B-3F98-473D-A874-0D9B9B15B399@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 03:57:21PM -0700, Andy Lutomirski wrote:
> > On Oct 31, 2018, at 2:00 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> >> On Wed, Oct 31, 2018 at 01:36:48PM -0700, Andy Lutomirski wrote:

> >> This stuff is called *rare* write for a reason. Do we really want to
> >> allow atomics beyond just store-release?  Taking a big lock and then
> >> writing in the right order should cover everything, no?
> > 
> > Ah, so no. That naming is very misleading.
> > 
> > We modify page-tables a _lot_. The point is that only a few sanctioned
> > sites are allowed writing to it, not everybody.
> > 
> > I _think_ the use-case for atomics is updating the reference counts of
> > objects that are in this write-rare domain. But I'm not entirely clear
> > on that myself either. I just really want to avoid duplicating that
> > stuff.
> 
> Sounds nuts. Doing a rare-write is many hundreds of cycles at best.

Yes, which is why I'm somewhat sceptical of the whole endeavour.

