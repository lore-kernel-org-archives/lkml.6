Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0A3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F49C20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfBKXkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:40:41 -0500
Received: from mail.us.es ([193.147.175.20]:52250 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbfBKXki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:40:38 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id F3AB680763
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:40:35 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E0972DA872
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:40:35 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D315EDA863; Tue, 12 Feb 2019 00:40:35 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AF039DA84C;
        Tue, 12 Feb 2019 00:40:33 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 12 Feb 2019 00:40:33 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 7A9714265A4C;
        Tue, 12 Feb 2019 00:40:33 +0100 (CET)
Date:   Tue, 12 Feb 2019 00:40:33 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Simon Horman <horms@verge.net.au>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wensong Zhang <wensong@linux-vs.org>,
        Julian Anastasov <ja@ssi.bg>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipvs: Use struct_size() helper
Message-ID: <20190211234033.wwpygxamqwvsuxmv@salvia>
References: <20190208004456.GA15845@embeddedor>
 <20190208095648.la4ushbjxkqgqzb6@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208095648.la4ushbjxkqgqzb6@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:56:48AM +0100, Simon Horman wrote:
> On Thu, Feb 07, 2019 at 06:44:56PM -0600, Gustavo A. R. Silva wrote:
> > One of the more common cases of allocation size calculations is finding
> > the size of a structure that has a zero-sized array at the end, along
> > with memory for some number of elements for that array. For example:
> > 
> > struct foo {
> >     int stuff;
> >     struct boo entry[];
> > };
> > 
> > size = sizeof(struct foo) + count * sizeof(struct boo);
> > instance = alloc(size, GFP_KERNEL)
> > 
> > Instead of leaving these open-coded and prone to type mistakes, we can
> > now use the new struct_size() helper:
> > 
> > size = struct_size(instance, entry, count);
> > 
> > This code was detected with the help of Coccinelle.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Pablo, could you consider applying this?

Applied, thanks!
