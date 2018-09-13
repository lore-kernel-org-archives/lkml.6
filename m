Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9586C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6213320882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gdPGgc7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6213320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeIMOiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:38:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeIMOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+uV1wEWkcB0IWNI3VJTg622FuZS3tK/L6GKtqSIyrWU=; b=gdPGgc7CFQxv/iSIOCUxnv2G6
        pwIV+4ob+Kt3LP4poKuSaFFSnuN/+is4nWkBi6xIAWOQ8FuZCK7oqLBSzUS2a9lem12SbRQm5xhzb
        Susv9EELiuHAN7AHKK8m0fe5FEICTUtX+iJ1/5iMUqtNNcKD8vmQoBv8y+1pHoGIgEWfXTpe07J6a
        XIsmZzeQ+1OazCDkmlNSe2licMyeO/fT1CyAOvEpTb9lTY6Mn5mJS4+/DSQJzfNfeof9INhPkRWWl
        IavAAjiDQ4QYL2dYK69RJLEbGIAee1tmLx6ZSwf7+1ILdE9he2mpaN1WPLrHR0GoExAyc7vomEEHr
        trPCvmshA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0Nw0-0000un-9V; Thu, 13 Sep 2018 09:29:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 37C6E20587E40; Thu, 13 Sep 2018 11:29:10 +0200 (CEST)
Message-ID: <20180913092110.817204997@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Sep 2018 11:21:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Subject: [RFC][PATCH 00/11] my generic mmu_gather patches
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some further mmu_gather/tlb patches I have that go on top of Will's
current tlb branch.

I mostly wrote them 2 weeks ago and haven't been able to get back to them; but
Will offered to have a wee look.

Esp. the full arch conversions (ARM, SH, UM, IA64) were based on patches I did
7 years ago and haven't been tested other than with a compiler.

The notable exception is s390, which after this series, is the only remaining
architecture with a private mmu_gather implementation. I didn't get around to
converting that.

Anyway, have a look, hopefully there's a few good bits in :-)

