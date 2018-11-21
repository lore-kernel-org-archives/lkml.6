Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88A5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90865214C1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jofmZ/wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90865214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeKUSxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:53:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeKUSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N+2uTAmafTPD6PxtUmIc/GNuiahevdS+MIWPlwc2AU0=; b=jofmZ/wxeb8IcELzcUGKs93BR
        CtqTrufDtzFlC/81qs3Q+JNdj+FKUr+wl7sL11nc2EcTSkx0cLg89laHsR5raYU3i9zrgsJG3X48h
        HgDmt3Mr2U77qz5h1+Dp/JqUuMi6/2o1leV+y7lp4SefKCOmdG7C+NSBz93J9x35KDEzLHYynfeKU
        cwD7PVPHMr7m+FOYz3F/PD33i4bLWC1yUTYPavDKuTYMZGHpRLOMjMWiOJb5mB/iP+LZECJldJ7+K
        9muDHEQAr4egvVdeaKpIYlMeEAqgjaa64wKyhTpZpi1/1qqRDoiQBcSCw+2FKYkMYi6b6hrMLCz78
        +e854zI2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPNjV-0004h5-Gi; Wed, 21 Nov 2018 08:19:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A5BB2029FD58; Wed, 21 Nov 2018 09:19:36 +0100 (CET)
Date:   Wed, 21 Nov 2018 09:19:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] proc: add /proc/<pid>/arch_state
Message-ID: <20181121081936.GH2131@hirez.programming.kicks-ass.net>
References: <1542236407-4323-1-git-send-email-aubrey.li@intel.com>
 <1542236407-4323-2-git-send-email-aubrey.li@intel.com>
 <20181119173904.GC2131@hirez.programming.kicks-ass.net>
 <c62acf67-2529-15b1-5325-e0265b0f613d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c62acf67-2529-15b1-5325-e0265b0f613d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 09:39:00AM +0800, Li, Aubrey wrote:
> > Also; you were going to shop around with the other architectures to see
> > what they want/need for this interface. I see nothing on that.
> > 
> I'm open for your suggestion, :)

Well, we have linux-arch and the various maintainers are also listed in
MAINTAINERS. Go forth and ask..
