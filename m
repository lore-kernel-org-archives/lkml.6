Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4E5C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D6E2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RdfaVRLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D6E2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJaGVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:21:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaGVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q8w/sHoucG3GmKpRw8+C/5yNw6xEMIv7YocwV/fFoKI=; b=RdfaVRLcsYI1IQiMSBBDcyBiLT
        7X8Lh03D9wTpHp0iQthLGjZyRF3Mb4TYwIWiWYNpqx06nlaJ9JAEkssaXPRfJ8T3jhJq+DxNutqxP
        PqtxzMEDPqZxgyfPFe5KgQS8zF7jK/JC6tgz8cKp6b/EsVKE/CuVf5HMZQn5q0IxDW76q2M4qDOPd
        rFyN7Lxla7U/MdQxv2xSxGsIkVtlKwlR7IZfxbqMMgayaJ8NlqiFL2K8x1B4KeIZ6D3anPUdKTEKG
        xCZB7Z+/GKe5r2j+pzroo7jZlBNYpojN4z5QL5l9Pr//Q61CDRjiZul61sN6rl2AuwtktwKwbC5N2
        BK8vQk2g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHbWJ-0001ft-En; Tue, 30 Oct 2018 21:25:51 +0000
Date:   Tue, 30 Oct 2018 14:25:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     nadav.amit@gmail.com, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20181030212551.GD10491@bombadil.infradead.org>
References: <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
 <28C8CD2A-BDC0-49A5-854E-1E18968528B8@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28C8CD2A-BDC0-49A5-854E-1E18968528B8@amacapital.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 11:51:17AM -0700, Andy Lutomirski wrote:
> Finally, one issue: rare_alloc() is going to utterly suck
> performance-wise due to the global IPI when the region gets zapped out
> of the direct map or otherwise made RO.  This is the same issue that
> makes all existing XPO efforts so painful. We need to either optimize
> the crap out of it somehow or we need to make sure it’s not called
> except during rare events like device enumeration.

Batching operations is kind of the whole point of the VM ;-)  Either
this rare memory gets used a lot, in which case we'll want to create slab
caches for it, make it a MM zone and the whole nine yeards, or it's not
used very much in which case it doesn't matter that performance sucks.

For now, I'd suggest allocating 2MB chunks as needed, and having a
shrinker to hand back any unused pieces.
