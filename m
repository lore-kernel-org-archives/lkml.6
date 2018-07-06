Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C76C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAF922AAE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAF922AAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933641AbeGFPyJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:54:09 -0400
Received: from mail.us.es ([193.147.175.20]:59140 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933042AbeGFPyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:54:06 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 18F1C1373B3
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jul 2018 17:52:22 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F2B7BDA4E3
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jul 2018 17:52:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id ED5C9DA4E0; Fri,  6 Jul 2018 17:52:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9158FDA7F1;
        Fri,  6 Jul 2018 17:52:19 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 06 Jul 2018 17:52:19 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5F76F4265A5C;
        Fri,  6 Jul 2018 17:52:19 +0200 (CEST)
Date:   Fri, 6 Jul 2018 17:54:02 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        =?iso-8859-1?Q?M=E1t=E9?= Eckl <ecklm94@gmail.com>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        "Pablo M. Bermudo Garay" <pablombg@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] netfilter: fix NETFILTER_XT_TARGET_TEE
 dependencies
Message-ID: <20180706155401.7jwc5laxqvnfpiur@salvia>
References: <20180706123805.2852900-1-arnd@arndb.de>
 <20180706124542.jybscbmzixyt4rx2@salvia>
 <20180706124827.xwho2rgu3jkk3hp5@salvia>
 <CAK8P3a23rdqk-5i_6jLtCH6Z+_SSJ-0=5r=KfPuL-Xaas=6VyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a23rdqk-5i_6jLtCH6Z+_SSJ-0=5r=KfPuL-Xaas=6VyA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:05:13PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 6, 2018 at 2:48 PM, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > On Fri, Jul 06, 2018 at 02:45:42PM +0200, Pablo Neira Ayuso wrote:
> >> On Fri, Jul 06, 2018 at 02:37:58PM +0200, Arnd Bergmann wrote:
> >> > With NETFILTER_XT_TARGET_TEE=y and IP6_NF_IPTABLES=m, we get a link
> >> > error when referencing the NF_DUP_IPV6 module:
> >> >
> >> > net/netfilter/xt_TEE.o: In function `tee_tg6':
> >> > xt_TEE.c:(.text+0x14): undefined reference to `nf_dup_ipv6'
> >> >
> >> > The problem here is the 'select NF_DUP_IPV6 if IP6_NF_IPTABLES'
> >> > that forces NF_DUP_IPV6 to be =m as well rather than setting it
> >> > to =y as was intended here. Adding a soft dependency on
> >> > IP6_NF_IPTABLES avoids that broken configuration.
> >>
> >> Applied to nf.git, thanks Arnd.
> >
> > Sorry, let me reconsider.
> >
> > We many need similar patches to other spots in 35bf1ccecaaa ?
> >
> > If so, it would be good to fix in the one go.
> 
> I'm fairly sure that  NETFILTER_XT_TARGET_LOG is safe, since
> NF_LOG_IPV6 already depends on IP6_NF_IPTABLES.
> 
> NF_SOCKET_IPV6 like NF_DUP_IPV6 does not depend on
> IP6_NF_IPTABLES, so we may have a similar problem there, though
> I have not come across that. I have done only a few hundred randconfig
> builds since I started yesterday, so I may have missed something,
> but I think this is safe because CONFIG_NF_SOCKET_IPV6 is
> used like a 'bool' symbol these days, we don't actually control building
> a module with it, only a small portion in the nft_socket file.

Thanks for explaining.

Applied, thanks!
