Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF45ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798E020831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798E020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeJYC5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:57:22 -0400
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:54013 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbeJYC5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:57:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 16859181D3419;
        Wed, 24 Oct 2018 18:28:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: beast87_64d6c568c022d
X-Filterd-Recvd-Size: 1931
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Oct 2018 18:28:12 +0000 (UTC)
Message-ID: <61d94f2a5563db4d6580c8385c3b93c8eeb3669a.camel@perches.com>
Subject: Re: [PATCH] Change judgment len position
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>, wanghaifine@gmail.com
Cc:     netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Oct 2018 11:28:11 -0700
In-Reply-To: <20181024.101028.1211941922121897721.davem@davemloft.net>
References: <20181024154729.5312-1-wanghaifine@gmail.com>
         <20181024.101028.1211941922121897721.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-24 at 10:10 -0700, David Miller wrote:
> From: Wang Hai <wanghaifine@gmail.com>
> Date: Wed, 24 Oct 2018 23:47:29 +0800
> 
> > To determine whether len is less than zero, it should be put before 
> > the function min_t, because the return value of min_t is not likely 
> > to be less than zero.
[]
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
[]
> > @@ -3301,11 +3301,11 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
> >       struct net *net = sock_net(sk);
> >       int val, len;
> >  
> > +     len = min_t(unsigned int, len, sizeof(int));
> > +
> >       if (get_user(len, optlen))
> >               return -EFAULT;
> 
> You can't be serious?

I'm not personally taken aback by this but
there is the new Code of
Conduct to consider.

John McEnroe earned quite a bit of his
reputation as an 'enfant terrible' via a
similar statement.

https://www.youtube.com/watch?v=t0hK1wyrrAU

Perhaps a different word choice next time in
reply to submitters of ill-considered and/or
defective patches could be useful.


