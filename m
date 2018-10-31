Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FBEECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD012054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PVv3dc4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD012054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJaSGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:06:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34634 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJaSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b+PNiizic8LnfCukl4WTQF/yDJSRLRR2Ckyz0vp16yM=; b=PVv3dc4wxhYzQ/Yyep2S2Ie6vj
        swVR6pWp6uD9E1BJGqjDJoxLfBfAD4Q/FtqfsHWr9qmg49AfXyqbban4tU4RA/w8CYJkfWgW7/dm5
        KZoHbc+H3PBIXcRRY6HxKH533QlEZFp8YQqbfn3XfikEkFdYayrHe6e/02uRDtgfHaxK8L4Iqvt+l
        yy3i/qiePRVMSrnjYC414KDZJV2ZsnkC+R35lJxnLpROuja1BxBaVc+mb9lBc7HVCgWI+mWWkKOAs
        s3uT0BKIxJxSzS+Z2nrNYmN2I/a8/of3G0G1zc35JikELiaxO2qjvnNn7qYZIZh/hTar/JSiHahuX
        7p1iAxCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHmUQ-0002NO-Dd; Wed, 31 Oct 2018 09:08:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DCF02029FA14; Wed, 31 Oct 2018 10:08:35 +0100 (CET)
Date:   Wed, 31 Oct 2018 10:08:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Igor Stoppa <igor.stoppa@gmail.com>,
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
Message-ID: <20181031090835.GG744@hirez.programming.kicks-ass.net>
References: <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
 <28C8CD2A-BDC0-49A5-854E-1E18968528B8@amacapital.net>
 <CAC99157-7A9B-4AC6-BA41-EAA7A99FE53D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC99157-7A9B-4AC6-BA41-EAA7A99FE53D@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 04:18:39PM -0700, Nadav Amit wrote:
> > Nadav, want to resubmit your series? IIRC the only thing wrong with it was
> > that it was a big change and we wanted a simpler fix to backport. But
> > that’s all done now, and I, at least, rather liked your code. :)
> 
> I guess since it was based on your ideas…
> 
> Anyhow, the only open issue that I have with v2 is Peter’s wish that I would
> make kgdb use of poke_text() less disgusting. I still don’t know exactly
> how to deal with it.
> 
> Perhaps it (fixing kgdb) can be postponed? In that case I can just resend
> v2.

Oh man, I completely forgot about kgdb :/

Also, would it be possible to entirely remove that kmap fallback path?
