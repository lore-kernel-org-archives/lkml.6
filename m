Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D8EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39784208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39784208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933349AbeGJMOl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:14:41 -0400
Received: from mail.us.es ([193.147.175.20]:32946 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932620AbeGJMOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:14:39 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0234DE8E94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:12:50 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D255CDA4D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:12:50 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C1761DA4CD; Tue, 10 Jul 2018 14:12:50 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 32BC8DA817;
        Tue, 10 Jul 2018 14:12:48 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 10 Jul 2018 14:12:48 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.243.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id DD0B54265A4E;
        Tue, 10 Jul 2018 14:12:47 +0200 (CEST)
Date:   Tue, 10 Jul 2018 14:14:33 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     =?iso-8859-1?Q?M=E1t=E9?= Eckl <ecklm94@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Flavio Leitner <fbl@redhat.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netfilter: NFT_SOCKET don't use NF_SOCKET_IPV6 without
 NF_TABLES_IPV6
Message-ID: <20180710121433.in7tzjahptem6vnq@salvia>
References: <20180709213537.2748896-1-arnd@arndb.de>
 <20180710080227.qwh53ahq26j6phhd@sch.bme.hu>
 <20180710080538.d7xqpjdvpksfrx6o@sch.bme.hu>
 <CAK8P3a0zYmdoMdWdFDcWprZY_4w2hbMYq4--iZB=JE4x2UiscA@mail.gmail.com>
 <20180710105605.evgtmjiq5z46zld6@salvia>
 <20180710111536.hio2xalz7pyxucc6@sch.bme.hu>
 <20180710112459.ielgaydrgd4kxizo@salvia>
 <20180710114517.nxnkav6mimyivh4m@sch.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180710114517.nxnkav6mimyivh4m@sch.bme.hu>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 01:45:17PM +0200, Máté Eckl wrote:
> On Tue, Jul 10, 2018 at 01:24:59PM +0200, Pablo Neira Ayuso wrote:
> > On Tue, Jul 10, 2018 at 01:15:36PM +0200, Máté Eckl wrote:
> > > On Tue, Jul 10, 2018 at 12:56:05PM +0200, Pablo Neira Ayuso wrote:
> > [...]
> > > This patch only solves the nf_socket and nft_socket modules problem so I can
> > > only submit a v2 for 'netfilter: Kconfig: Change IPv6 select dependencies' but
> > > you already applied it so it would meen a force push. Should I do this?
> > > 
> > > I think Arnd's patch solves these problems in case we don't want to force-push
> > > or rebase.
> > 
> > You are refering to these two patches, right?
> > 
> > https://patchwork.ozlabs.org/patch/941374/
> > https://patchwork.ozlabs.org/patch/941696/
> 
> Oh, I missed the first one. So basically I should just squash them and resubmit
> right? Or even replace ("netfilter: Kconfig: Change IPv6 select
> dependencies") with these changes?

That's one possibility, yes.
