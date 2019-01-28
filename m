Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46250C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB5E20882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfA1KU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:20:27 -0500
Received: from mail.us.es ([193.147.175.20]:53372 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfA1KU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:20:26 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3A4E52C4735
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:20:25 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 29AA7DA555
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:20:25 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 24B3FDA87E; Mon, 28 Jan 2019 11:20:25 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 00071DA86F;
        Mon, 28 Jan 2019 11:20:22 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 28 Jan 2019 11:20:22 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D0BF04265A4C;
        Mon, 28 Jan 2019 11:20:22 +0100 (CET)
Date:   Mon, 28 Jan 2019 11:20:22 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nft_counter: remove wrong __percpu of
 nft_counter_resest()'s arg
Message-ID: <20190128102022.mrnh2j6orgnrdfyp@salvia>
References: <20190119215024.90174-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119215024.90174-1-luc.vanoostenryck@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 10:50:24PM +0100, Luc Van Oostenryck wrote:
> nft_counter_rest() has its first argument declared as
> 	struct nft_counter_percpu_priv __percpu *priv
> but this structure is not percpu (it only countains
> a member 'counter' which is, correctly, a pointer to a
> percpu struct nft_counter).
> 
> So, remove the '__percpu' from the argument's declaration.

Applied, thanks.
