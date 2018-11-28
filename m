Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BC7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6488A208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qhsAXnR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6488A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeK1PP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:15:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeK1PP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oE09f7qYHKPuWY8/p61vpM2C1nmazqx6v1jVlKC9baI=; b=qhsAXnR/TwgNux0N3Ucp4l7DI
        IpZruluehOtRjTqZXSe36QunUAIw029kS+FtqMzeVsaaYH8ED8wwj6A7wFg8nV0aH6FHNuEhiDGjH
        uaUJVAI/49+MeUxD+2a9NRdFiFSS6V/YVs7DJOI0/f/OaQhFEXVUrG9j5MAHAaq0G2zb40nt0V9ze
        jZmFOJ5orpBTaCbBLDjOn8NbPKwfc0GA/c4USD3QXKs3CrS2AlwR0WNNGjr7+gMEcYD7cKobgB+c7
        uM6D9/cfFjd9mzRXY6Uz0lMRSnFJ0IZC9K5QwkWnCOAFpCnI4zpVj3DO5tZ6hWhJfHtjQ1OeT0UyB
        6KQoAvxJw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRrFt-0005Ec-Cj; Wed, 28 Nov 2018 04:15:17 +0000
Subject: Re: linux-next: Tree for Nov 27 (scsi/aha1542)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <20181127152539.55426063@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ef9090cf-e86a-7fd0-dfa9-6810eaaf7e65@infradead.org>
Date:   Tue, 27 Nov 2018 20:14:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127152539.55426063@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/18 8:25 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181126:
> 

on i386:

ERROR: "__udivdi3" [drivers/scsi/aha1542.ko] undefined!

somewhere in aha1542_interrupt() according to objdump.


-- 
~Randy
