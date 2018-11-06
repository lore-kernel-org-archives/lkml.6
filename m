Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9868FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6C820830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NLbA2OBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6C820830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeKGFIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:08:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeKGFIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I9VVNVKF+70RffheDOVW9AEN+7TndZupFlw+kLWl8zw=; b=NLbA2OBOscQ/AxBnxPhT6bICp
        GCRmgj/Oy+dtgObU7+ogwLW48GSLTY5ov8IuVho8VO3IiSaNDV7ftMbBK48YRnpWL+9vEq6/QOl/D
        sBQt/+Bw4jOhsO2Yc3xtxJbKdjvoUaLzXVboGvlGmk6eF2l3gFC47k4pXHx9MVhgItX9nGeHJGO8X
        /hlNAVxBi/Q5iM4bq1+O66ubRNyqYPU5hSCV+9YOszfz+QgUszu9AR7tgK00DE+PXPGCZ7XCWOL9h
        KIWCd4b9GxFjvASAtwVI0INqfUm5jjIyOeIO1x64jHMAInPIqvUOylvtU/DHTCI4+oWU6Roib6vSX
        hJunPqwAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK7EV-00005m-Hc; Tue, 06 Nov 2018 19:41:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26C6B20284C61; Tue,  6 Nov 2018 20:41:49 +0100 (CET)
Date:   Tue, 6 Nov 2018 20:41:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        bp@alien8.de, namit@vmware.com, joe@perches.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        segher@kernel.crashing.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH] tree-wide: Remove __inline__ and __inline usage
Message-ID: <20181106194149.GC9761@hirez.programming.kicks-ass.net>
References: <20181106100229.GI22431@hirez.programming.kicks-ass.net>
 <CAHk-=wjFL-4p-4FrJbtKADXRaBPK_Pi_-BSSqm_j784Mq6aHjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjFL-4p-4FrJbtKADXRaBPK_Pi_-BSSqm_j784Mq6aHjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 11:18:59AM -0800, Linus Torvalds wrote:
> On Tue, Nov 6, 2018 at 2:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Therefore I'm proposing to run:
> >
> >   git grep -l "\<__inline\(\|__\)\>" | while read file
> >   do
> >         sed -i -e 's/\<__inline\(\|__\)\>/inline/g' $file
> >   done
> >
> > On your current tree, and apply the below fixup patch on top of that
> > result.
> 
> So I started doing this, and in fact fixed up a few more issues by
> hand on top of your patch, but then realized hat it's somewhat
> dangerous and possibly broken.
> 
> For the uapi header files in particular, __inline__ may actually be
> required. Depending on use, and compiler settings, "inline" can be a
> word reserved for the user, and shouldn't be used by system headers.

*groan*, indeed. Now obvious those headers need to compile without our
override, so we could simply exclude uapi from the transformation.

(and __inline is mostly in staging/ and a few stray places, we really
should get rid of that one I feel, there's so few of them)

> But we *could* get rid of these two lines in include/linux/compiler_types.h
> 
>   #define __inline__ inline
>   #define __inline   inline
> 
> and just say that "inline" for the kernel means "always_inline", but
> if you use __inline__ or __inline then you get the "raw" compiler
> inlining.
> 
> Then people can decide to get rid of __inline__ on a case-by-case basis.

Right, that gets us what we need; but makes a fair bunch of kernel code
compile differently.

It probably doesn't matter, and a fair amount of the __inline__ usage is
in fairly crusty code which will likely never get fixed up.

And that is probably still a safer option than removing the #define
inline entirely.

Do you want me to do that patch, or have you already just done it?
