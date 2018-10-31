Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF3EECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DF52064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r+gKVQiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DF52064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeKAGAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:00:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44108 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeKAGAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n9e9jx5bhT7iQOS4/AYUEiXPtLoQRDuZXOe6A2RZAow=; b=r+gKVQiBGZuRlTYYn0pqnPPZx
        w/uYbpzWqFEmKqO1lW1UDk4pwqHcTlkYOwrTom7IgA8qgZBKle+fe34Wlq6PlSguoF9RDPmq7zeRS
        8Ab4CTH7M/LBH2kZCZb2FT0iD7vmeqIhwnK9v3r9k8pEwcE7nGf56wYCEMVkVN/GgHagIJZMV+ocE
        FaARVd5/5jIlTD5iqJZ3wU6G2Dn2JAMdS3Sbtdilc8hJwQd5FhqHsSW01ci5V1bi8WgGn+XvGtEMg
        9uKedkCdXFCuT/Qlu6D7ErBAUWZj/tb8/ZslR3FSo6LnS9l4bLJZINJTVte/Su89aqSRcCZTHSZSx
        rY9hJ/9TA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHxbO-0006zU-6J; Wed, 31 Oct 2018 21:00:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3FE712029F887; Wed, 31 Oct 2018 22:00:32 +0100 (CET)
Date:   Wed, 31 Oct 2018 22:00:32 +0100
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
Message-ID: <20181031210032.GA3159@hirez.programming.kicks-ass.net>
References: <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
 <20181030182841.GE7343@cisco>
 <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
 <20181030213557.GE10491@bombadil.infradead.org>
 <CALCETrW1FcT88u0QY9k_PMOeZj0G8H6KNb5Bnreo-12NvmmCEQ@mail.gmail.com>
 <20181031100237.GN744@hirez.programming.kicks-ass.net>
 <659CFC78-22BF-492B-B2E4-B8E89AA08446@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659CFC78-22BF-492B-B2E4-B8E89AA08446@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 01:36:48PM -0700, Andy Lutomirski wrote:
> 
> > On Oct 31, 2018, at 3:02 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> >> On Tue, Oct 30, 2018 at 09:41:13PM -0700, Andy Lutomirski wrote:
> >> To clarify some of this thread, I think that the fact that rare_write
> >> uses an mm_struct and alias mappings under the hood should be
> >> completely invisible to users of the API.  No one should ever be
> >> handed a writable pointer to rare_write memory (except perhaps during
> >> bootup or when initializing a large complex data structure that will
> >> be rare_write but isn't yet, e.g. the policy db).
> > 
> > Being able to use pointers would make it far easier to do atomics and
> > other things though.
> 
> This stuff is called *rare* write for a reason. Do we really want to
> allow atomics beyond just store-release?  Taking a big lock and then
> writing in the right order should cover everything, no?

Ah, so no. That naming is very misleading.

We modify page-tables a _lot_. The point is that only a few sanctioned
sites are allowed writing to it, not everybody.

I _think_ the use-case for atomics is updating the reference counts of
objects that are in this write-rare domain. But I'm not entirely clear
on that myself either. I just really want to avoid duplicating that
stuff.
