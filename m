Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52A4C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D1B20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZpZhNMsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D1B20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeIMRtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:49:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56832 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeIMRtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gmScunkOuJMb6n5DsV3A7MCcYH8oPFce7O8It6FRQ0U=; b=ZpZhNMsRuxSgB0GNtu3GzAWXb
        sGsL5ZpQD3VHPKzN+YSpIUZAUUBYaT62kbSlVXYGP0OQOi/LqlyWsKCPdS+ljOhqf20HpZzD9WBou
        w91nqjEU3wwrAElGyWpplWcMv/CJIpn72tfhJWPJOI4jDd25ZyBtr7PRA9eLYwr5tZHLMDHvJo7HL
        DMBjKOvJPh2JjTuZF64khadIyFnEYQjT7RuNc5Z7RD248lOMQ/vTCfCPNxMBLgtNZIpzb17i99hZ1
        ZXbmvvROFnBIuPFG9bAcboRQ/93bVulBtfBIXNrvhvILDShjXHmqXL3kV6fxUpNIzNuAkbnZITrBD
        wuPpXfHew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0QuJ-0002fk-Qf; Thu, 13 Sep 2018 12:39:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 344BE202C1A2D; Thu, 13 Sep 2018 14:39:37 +0200 (CEST)
Date:   Thu, 13 Sep 2018 14:39:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
Message-ID: <20180913123937.GX24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092811.894806629@infradead.org>
 <20180913123014.0d9321b8@mschwideX1>
 <20180913105738.GW24124@hirez.programming.kicks-ass.net>
 <20180913141827.1776985e@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913141827.1776985e@mschwideX1>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 02:18:27PM +0200, Martin Schwidefsky wrote:
> We may get something working with a common code mmu_gather, but I fear the
> day someone makes a "minor" change to that subtly break s390. The debugging of
> TLB related problems is just horrible..

Yes it is, not just on s390 :/

And this is not something that's easy to write sanity checks for either
AFAIK. I mean we can do a few multi-threaded mmap()/mprotect()/munmap()
proglets and catch faults, but that doesn't even get close to covering
all the 'fun' spots.

Then again, you're more than welcome to the new:

  MMU GATHER AND TLB INVALIDATION

section in MAINTAINERS.
