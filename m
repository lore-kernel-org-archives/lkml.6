Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3307DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AC4222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="twxx4HWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389239AbfBMNJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:09:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbfBMNJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0owrKY9cJm7Sk1CsRqy4fhCGpNqmJ2sVQjxHs+TmEgs=; b=twxx4HWi/nD/VXCeqyHWo4MOBJ
        CQpDtFqI74t5VlFbwV67/Kdt/q6he9Pi+1ObWjFqeA/iw2HHO14FwpqMjXQQaUBAUXCGhJL4JaNTE
        qGGncZdti08VLimO/ay6tRuZROwylBi4AhIDUjd4nue5+cYssOXqw9rPpQ+qA2lQ2fZn+7xY4QLJe
        mqdtlCCSsfkaRGMRr8r/nsCZ+4IX3lm8/r7eh1N4MCd77Bdw/vrRIMkBAyeLW9aEM9B06fAHTicxD
        /qYqohznN3anZ/1JSa3eBhk8K+UezmsutJmuGXt/3+mnAhTSzCyqytCk60e2XAX2napDyfVBHW6YI
        7qyg92ww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtuI0-0002CD-N9; Wed, 13 Feb 2019 13:09:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21E1A22BBEBE5; Wed, 13 Feb 2019 14:09:23 +0100 (CET)
Date:   Wed, 13 Feb 2019 14:09:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Farin <hvtaifwkbgefbaei@gmail.com>,
        Linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 4.19.21: perf does not work on Ryzen, OK with 4.19.20
Message-ID: <20190213130923.GR32494@hirez.programming.kicks-ass.net>
References: <20190213110803.xbnganrtvgmfgh3b@m.mifar.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213110803.xbnganrtvgmfgh3b@m.mifar.in>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 12:08:03PM +0100, Sami Farin wrote:
> The same .config, BIOS, and kernel boot parameters in both kernels.
> 
> # perf top -v
>            ┌─Error:────────────────────────────────────────┐
>            │Failed to mmap with 12 (Cannot allocate memory)│

I think you got bit by this one:

http://lkml.kernel.org/r/tip-528871b456026e6127d95b1b2bd8e3a003dc1614@git.kernel.org
