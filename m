Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAB1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA3A20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA3A20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933523AbeGIQu4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:50:56 -0400
Received: from mail.us.es ([193.147.175.20]:33588 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933213AbeGIQuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:50:54 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 8B902E1521
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 18:49:07 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4867ADA794
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 18:49:07 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2F214DA4D6; Mon,  9 Jul 2018 18:49:07 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C5372DA727;
        Mon,  9 Jul 2018 18:49:04 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 09 Jul 2018 18:49:04 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 847654265A4E;
        Mon,  9 Jul 2018 18:49:04 +0200 (CEST)
Date:   Mon, 9 Jul 2018 18:50:50 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        "David S. Miller" <davem@davemloft.net>,
        =?iso-8859-1?Q?M=E1t=E9?= Eckl <ecklm94@gmail.com>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        "Pablo M. Bermudo Garay" <pablombg@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netfilter: conntrack: add weak IPV6 dependency
Message-ID: <20180709165050.uuglk24ctiezhnye@salvia>
References: <20180706130005.3640993-1-arnd@arndb.de>
 <20180706135516.viz6pjtkdmcoqq2l@breakpoint.cc>
 <CAK8P3a1o6+dcZuW_iMGzwBBw_dcW41QAQ2Mu4A5Ru9ScnwaYDA@mail.gmail.com>
 <20180706150037.knqt736uq6uyh3bs@breakpoint.cc>
 <20180706183548.hk7jwobomkqdccs5@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706183548.hk7jwobomkqdccs5@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 08:35:48PM +0200, Florian Westphal wrote:
> Florian Westphal <fw@strlen.de> wrote:
> > Arnd Bergmann <arnd@arndb.de> wrote:
> > > and that resulted in a new build failure:
> > > 
> > > net/netfilter/nf_conntrack_proto.o:(.rodata+0x788): undefined
> > > reference to `nf_conntrack_l4proto_icmpv6'
> > > net/ipv6/netfilter/nf_conntrack_reasm.o: In function `nf_ct_frag6_expire':
> > > nf_conntrack_reasm.c:(.text+0x2320): undefined reference to
> > > `ip6_expire_frag_queue'
> > > net/ipv6/netfilter/nf_conntrack_reasm.o: In function `nf_ct_frag6_init':
> > > nf_conntrack_reasm.c:(.text+0x2384): undefined reference to `ip6_frag_init'
> > > nf_conntrack_reasm.c:(.text+0x2394): undefined reference to `ip6_frag_init'
> > > nf_conntrack_reasm.c:(.text+0x2398): undefined reference to `ip6_rhash_params'
> > > net/ipv6/netfilter/nf_conntrack_reasm.o: In function `nf_ct_frag6_expire':
> > > nf_conntrack_reasm.c:(.text+0x10bc): undefined reference to
> > > `ip6_expire_frag_queue'
> > > 
> > > I don't think we can get CONFIG_NF_DEFRAG_IPV6=y to work with IPV6=m.
> > 
> > Yes, not with current implementation, but I still don't think this
> > is unavoidable.
> > 
> > In case this is urgent I'm fine with the patch that adds the dependency,
> > otherwise I'd like to try and disentangle nf_conntrack_reasm and ipv6.
> 
> This links fine for me with IPV6=m:
> 
> Pablo, do you think this is too ugly?

Well, yes...

> It requires some copypastry from ipv6 defrag into nfct ipv6 defrag
> to avoid the link errors outlined above.

This is a bit of a regression I think.

While I think a bit of demodularization is fine, if things like this
start to kick in, it's probably good if we go make a step back...

Let me know, thanks.
