Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD44C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E316A21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfA1Jvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:51:48 -0500
Received: from mail.us.es ([193.147.175.20]:58124 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfA1Jvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:51:48 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4BBCF2325C8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:51:46 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3B40ADA86E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:51:46 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 216A1DA87B; Mon, 28 Jan 2019 10:51:46 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 11A33DA796;
        Mon, 28 Jan 2019 10:51:44 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 28 Jan 2019 10:51:44 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D36034265A4E;
        Mon, 28 Jan 2019 10:51:43 +0100 (CET)
Date:   Mon, 28 Jan 2019 10:51:43 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     kadlec@blackhole.kfki.hu, fw@strlen.de, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: ipt_CLUSTERIP: fix warning unused variable cn
Message-ID: <20190128095143.5yxst4dn7pvodqwn@salvia>
References: <20190123114811.25388-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190123114811.25388-1-anders.roxell@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 12:48:11PM +0100, Anders Roxell wrote:
> When CONFIG_PROC_FS isn't set the variable cn isn't used.
> 
> net/ipv4/netfilter/ipt_CLUSTERIP.c: In function ‘clusterip_net_exit’:
> net/ipv4/netfilter/ipt_CLUSTERIP.c:849:24: warning: unused variable ‘cn’ [-Wunused-variable]
>   struct clusterip_net *cn = clusterip_pernet(net);
>                         ^~
> 
> Rework so the variable 'cn' is declared inside "#ifdef CONFIG_PROC_FS".

Applied, thanks.
