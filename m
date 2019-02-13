Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054BBC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CCC222C7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D6CV266y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbfBMJTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:19:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfBMJTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5LGvSoe69FnoglVukOtgnmZkcbVIsBSUqUf2rz2sYh8=; b=D6CV266yhDXUsdfTqETufWTE/
        WVUWqkHw9Pz7NE3/BWXhq3HKKhO6dL9ictS9w6dVUVpiDaQjepKeF1COhpALDlYVR9PDckR51XN6s
        twEFlri/bAB06ML9Pr7683PaE9tpi1UoTOYPiZWEv+zIdUfYVmdVttF9EoavqzA4WN6I7Ak6sjD0i
        jlcF65aT8BaXaHiLv6T7j6INSiwbEZWfOq5nvpVPrOgGETVI8dfgxiCRSMSndSUPAl94pU6RdPCPm
        bBiVORq8hRntB+FBhUXN1qnOCN4ugTr5NCHrRdAc40nDgIKuqHqXS1QIYq2RVB4lmDHrKbHSRQQNW
        jkIMcj3Hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtqhN-0002O8-It; Wed, 13 Feb 2019 09:19:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D90AA213D8924; Wed, 13 Feb 2019 10:19:18 +0100 (CET)
Date:   Wed, 13 Feb 2019 10:19:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 03/10] locking/rwsem: Rename kernel/locking/rwsem.h
Message-ID: <20190213091918.GL32494@hirez.programming.kicks-ass.net>
References: <1550017627-14504-1-git-send-email-longman@redhat.com>
 <1550017627-14504-4-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550017627-14504-4-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 07:27:00PM -0500, Waiman Long wrote:
> The content of kernel/locking/rwsem.h is now specific to rwsem-xadd only.
> Rename it to rwsem-xadd.h to indicate that it is specific to rwsem-xadd
> and include it only when CONFIG_RWSEM_XCHGADD_ALGORITHM is set. As a result,
> the CONFIG_RWSEM_XCHGADD_ALGORITHM conditional compilation directives can
> be removed. There is no functional change.

Since all of rwsem-xadd is now generic code; how about we delete the
spinlock thing and keep everything rwsem ?

We don't carry a special spinlock mutex implementation either. And
arguably any arch that uses spinlock based atomics (afaict the only case
where rwsem-spinlock makes any sense anyway) suck anyway.
