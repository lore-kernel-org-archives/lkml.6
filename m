Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A89EECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCF520832
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCF520832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeJYJd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:33:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36916 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeJYJd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:33:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFU3K-0007e8-OZ; Thu, 25 Oct 2018 01:03:10 +0000
Date:   Thu, 25 Oct 2018 02:03:10 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Joe Perches <joe@perches.com>
Cc:     David Miller <davem@davemloft.net>, wanghaifine@gmail.com,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Change judgment len position
Message-ID: <20181025010310.GE32577@ZenIV.linux.org.uk>
References: <20181024154729.5312-1-wanghaifine@gmail.com>
 <20181024.101028.1211941922121897721.davem@davemloft.net>
 <61d94f2a5563db4d6580c8385c3b93c8eeb3669a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d94f2a5563db4d6580c8385c3b93c8eeb3669a.camel@perches.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:28:11AM -0700, Joe Perches wrote:
> On Wed, 2018-10-24 at 10:10 -0700, David Miller wrote:
> > From: Wang Hai <wanghaifine@gmail.com>
> > Date: Wed, 24 Oct 2018 23:47:29 +0800
> > 
> > > To determine whether len is less than zero, it should be put before 
> > > the function min_t, because the return value of min_t is not likely 
> > > to be less than zero.
> []
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c

[snip obviously broken patch]

> > You can't be serious?
> 
> I'm not personally taken aback by this but
> there is the new Code of
> Conduct to consider.
> 
> John McEnroe earned quite a bit of his
> reputation as an 'enfant terrible' via a
> similar statement.
> 
> https://www.youtube.com/watch?v=t0hK1wyrrAU
> 
> Perhaps a different word choice next time in
> reply to submitters of ill-considered and/or
> defective patches could be useful.

Please tell me we are being Poe'd...
