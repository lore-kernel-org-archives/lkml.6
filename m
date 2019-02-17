Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6AEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C9B2195D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfBQMwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 07:52:02 -0500
Received: from mail.us.es ([193.147.175.20]:45126 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbfBQMwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 07:52:02 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 32E3DF279A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 13:51:54 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 211FCDA85E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 13:51:54 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0184EDA86E; Sun, 17 Feb 2019 13:51:53 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B52C6DA797;
        Sun, 17 Feb 2019 13:51:51 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 17 Feb 2019 13:51:51 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 8BF7A4265A2F;
        Sun, 17 Feb 2019 13:51:51 +0100 (CET)
Date:   Sun, 17 Feb 2019 13:51:56 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrea Claudi <aclaudi@redhat.com>, coreteam@netfilter.org,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Julian Anastasov <ja@ssi.bg>, Li Shuang <shuali@redhat.com>,
        netfilter-devel@vger.kernel.org, Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] netfilter/ipvs: Fix unused variable warning
Message-ID: <20190217125156.ywp35hqlflafns6e@salvia>
References: <20190216223358.30711-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216223358.30711-1-bp@alien8.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 11:33:58PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Move the local variable 'ret' into the IP_VS_IPV6 ifdef so that the
> unused variable warning doesn't fire for randconfig builds with
> CONFIG_IP_VS_IPV6 disabled.

Thanks! We already have a patch for this, will pass it to David asap.

https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git/commit/?id=c93a49b9769e435990c82297aa0baa31e1538790
