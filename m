Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57867C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0BF2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IM4otyA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfBDPRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:17:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36940 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbfBDPRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mBfcILnCkce2xOQjs0eEN/EB8Iik4oGxg5YwFR9Ah3Y=; b=IM4otyA8uMrZcAAn9pZEMsARe
        I2E74YvGX8nOsViK6W2+VIwT6lHmFDKty3USnUBcbzrqPzSwBWgBb6YfGHPFdZJ5bVYFn301TtBWg
        s9vNmUBLWg1XX/WetJPWu4CKBYPsyisLSjWfbZMPcTNqBXaPN+HJM0qJn/BYg3SBGU6gjTZndDxOx
        wlvi35JJarflYPpKyCAFDyoNz61Cpbe0LtjghrXPPjp4yEtODwhKWnIlqtpsXMoWLj31elALtygne
        J6vUF97Zu53TDq3jc8oep3U1qDKyhFJS9S2j6791sD6miGWqu0ON94IgNUw1sN0l7S8YYl1ANyG94
        T11ZP1V/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqg0G-0008NL-1Y; Mon, 04 Feb 2019 15:17:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85825202A2A0F; Mon,  4 Feb 2019 16:17:41 +0100 (CET)
Date:   Mon, 4 Feb 2019 16:17:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, mingo@redhat.com, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
Message-ID: <20190204151741.GB17582@hirez.programming.kicks-ass.net>
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204150623.GF17528@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204150623.GF17528@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 04:06:23PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 21, 2019 at 01:42:28PM -0800, kan.liang@linux.intel.com wrote:
> 
> So what's wrong with the below?
> 
> Installing a quirk for 

(typing hard..)

but what I was going to say is that it seems overkill to sprinkle all
that stuff around.

