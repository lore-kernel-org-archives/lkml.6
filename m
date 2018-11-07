Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87405C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B452085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B452085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeKGUn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:43:57 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:60948 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeKGUn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:43:57 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990946AbeKGLOA1mr0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 12:14:00 +0100
Date:   Wed, 7 Nov 2018 11:14:00 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Christoph Hellwig <hch@lst.de>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: SiByte: Enable swiotlb for SWARM and BigSur
In-Reply-To: <20181107075923.GD24381@lst.de>
Message-ID: <alpine.LFD.2.21.1811071108150.20378@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1811050501010.20378@eddie.linux-mips.org> <20181107075923.GD24381@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018, Christoph Hellwig wrote:

> Do we really need a new source file just to call swiotlb_init?

 I think it being a separate file is actually good, as it saves a little 
bit of code space at run time if this is not used without the need to 
wrap the entire function into #ifdef.

>  And
> if we do that file should have a SPDX header these days.

 It does or I have missed something.

 Thanks for your review.

  Maciej
