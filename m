Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD38C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E720420644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L7/ZuEab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E720420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJIXBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:01:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50486 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJIXBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=++vuG6TpA+w9/zjx5UQwe+jRBnit/ly0KoVTl6QyMG4=; b=L7/ZuEabywGZfjtrWu61Jucz/
        EYGM4UFepMcfaZKorypVBKxm2+QhNZzQ0VBYUJdFHEfNSq08Ki7Od+TygeUXgW1Lk3+aMzx3RhMuJ
        M0kfqEcDWFnTK5NWm49jpdpQkq8mNZjxVa1mq2M5i/9VFBbnevzAr4W+tT6ONY2TLBfZoZi8aKhFi
        DeE6X0IexFm2ARpw3JQ+r9rOXXcfcb9O0tdzFKyv2stnDL9YEgpOYaFRvwAwqyg1HThPA1MXBlqbl
        8Aj3ckHoLWTBsFrvO+cInC2pRjulHn4tlHxyotWVshQy9Is+knrkKRLR36mHrKNm9twLCq2pX0AiX
        C2X831y5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9uB4-000683-F8; Tue, 09 Oct 2018 15:44:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B175220274BAE; Tue,  9 Oct 2018 17:43:59 +0200 (CEST)
Date:   Tue, 9 Oct 2018 17:43:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, mingo@redhat.com, will.deacon@arm.com,
        corbet@lwn.net
Subject: Re: [PATCH] Doc: lockdep: add information about performance impact
Message-ID: <20181009154359.GB5728@hirez.programming.kicks-ass.net>
References: <CGME20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056@eucas1p2.samsung.com>
 <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 05:39:27PM +0200, Lukasz Luba wrote:
> This patch add some warning related to performance drop.
> It should be mentioned that this is not for free
> and the platfrom resources (cache, bus interconnect, etc.)
> will be used more frequently.

To me this reads a bit like: water is wet.

Is this really needed?
