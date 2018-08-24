Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751F7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150DC2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N5qXOAdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150DC2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeHXSXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:23:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeHXSXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wRHB8n+kQaC7+65+t0TQY94+FnoFOKCE5uWXJW0EcK0=; b=N5qXOAdSFKhtxR8TR0hqZLCSc
        7uyfN7m/Kyw4zhpJ/uhzddxdMQ6lUvEvwISyHF0SRo5w26QrjWiZcoyJxEiT5gtPeN8bLlfeHqupk
        I091k2gOtbKBpsymbLVwQ5UsBlJKnn61uCwUL+rTl+GBlldq2HbfiYIfMXF3AZhfKFqMJUa7kk9j9
        Dc4dayX+XEbg/GjmkES/EcykHT49bX2jdKsSbF1rVy4QhTUaZYUTOUhASM+Z1nC4ymggbWbIGprRy
        HKMBD79j+7f0nMJLiy8SjbiLkygVsj4oculLpk0vo7p8W+Ud6RZgQPTkvO9ISytdWNXwATZmbWjk1
        VPdMYjq8A==;
Received: from [24.132.217.100] (helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ftCs6-0007zP-W8; Fri, 24 Aug 2018 14:16:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07D862024C927; Fri, 24 Aug 2018 16:13:15 +0200 (CEST)
Date:   Fri, 24 Aug 2018 16:13:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com
Subject: Re: [PATCH v2 00/11] x86/paravirt: several cleanups
Message-ID: <20180824141314.GQ24124@hirez.programming.kicks-ass.net>
References: <20180813073739.26108-1-jgross@suse.com>
 <45bfe8ab-683f-ab79-e3c6-c0a707b667c2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45bfe8ab-683f-ab79-e3c6-c0a707b667c2@suse.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 03:52:55PM +0200, Juergen Gross wrote:
> Ping?

Looking good; although I messed it up a little bit by adding a new
paravirt function.

Thanks for doing this!
