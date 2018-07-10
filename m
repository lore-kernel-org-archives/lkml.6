Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43991C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099B920883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099B920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933245AbeGJK4O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:56:14 -0400
Received: from mail.us.es ([193.147.175.20]:41244 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932752AbeGJK4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:56:12 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BF1BAE122C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 12:54:23 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AA867DA4CA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 12:54:23 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A6AB4DA57F; Tue, 10 Jul 2018 12:54:23 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 47B8BDA4C9;
        Tue, 10 Jul 2018 12:54:21 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 10 Jul 2018 12:54:21 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.243.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 056E9426CC52;
        Tue, 10 Jul 2018 12:54:20 +0200 (CEST)
Date:   Tue, 10 Jul 2018 12:56:05 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?iso-8859-1?Q?M=E1t=E9?= Eckl <ecklm94@gmail.com>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Flavio Leitner <fbl@redhat.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netfilter: NFT_SOCKET don't use NF_SOCKET_IPV6 without
 NF_TABLES_IPV6
Message-ID: <20180710105605.evgtmjiq5z46zld6@salvia>
References: <20180709213537.2748896-1-arnd@arndb.de>
 <20180710080227.qwh53ahq26j6phhd@sch.bme.hu>
 <20180710080538.d7xqpjdvpksfrx6o@sch.bme.hu>
 <CAK8P3a0zYmdoMdWdFDcWprZY_4w2hbMYq4--iZB=JE4x2UiscA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0zYmdoMdWdFDcWprZY_4w2hbMYq4--iZB=JE4x2UiscA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 11:10:40AM +0200, Arnd Bergmann wrote:
> On Tue, Jul 10, 2018 at 10:05 AM, Máté Eckl <ecklm94@gmail.com> wrote:
> > On Tue, Jul 10, 2018 at 10:02:27AM +0200, Máté Eckl wrote:
> >> On Mon, Jul 09, 2018 at 11:35:09PM +0200, Arnd Bergmann wrote:
> >> > It is now possible to build the nft_socket module as built-in when
> >> > NF_TABLES_IPV6 is disabled, and have NF_SOCKET_IPV6=m set manually.
> >> >
> >> > In this case, the NF_SOCKET_IPV6 functionality will be useless according
> >> > to the explanation in commit 35bf1ccecaaa ("netfilter: Kconfig: Change
> >> > IPv6 select dependencies"), but on top of that it also causes a link
> >> > error:
> >> >
> >> > net/netfilter/nft_socket.o: In function `nft_socket_eval':
> >> > nft_socket.c:(.text+0x162): undefined reference to `nf_sk_lookup_slow_v6'
> >> >
> >> > This changes the compile-time check so we don't attempt to use
> >> > the NF_SOCKET_IPV6 code when it cannot be used, and make it all
> >> > compile again. That may lead to unexpected behavior when a user
> >> > enables NF_SOCKET_IPV6 but cannot use it, but seems to be the
> >> > logical conclusion of the 35bf1ccecaaa change.
> >> >
> >> > Fixes: 35bf1ccecaaa ("netfilter: Kconfig: Change IPv6 select dependencies")
> >> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>
> >> I think this should be fixed in the Kconfig rather than inside the module(s).
> 
> Should we revert your patch then, or do you have a better idea?

Máté, would you resubmit a new patch that addresses all the problems
that Arnd is reporting in one go?

I think it's better if we toss your original patch in the tree and
rebase, ie. take the new one that fixes all issues that Arnd is
reporting. It would be good if we can sort out this before I send the
next pull request for net-next stuff.

I was afraid of fallout like this when I saw your original patch,
kbuild is always tricky.

Please Cc Arnd, Florian and me for review.

Thanks!
