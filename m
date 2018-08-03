Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05139C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8DA2175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8DA2175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeHCNVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:21:14 -0400
Received: from mail.us.es ([193.147.175.20]:49668 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbeHCNVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:21:14 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EE38DC5144
        for <linux-kernel@vger.kernel.org>; Fri,  3 Aug 2018 13:23:08 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D1080FAB5C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Aug 2018 13:23:08 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C01F3F7307; Fri,  3 Aug 2018 13:23:08 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 986C4FAB52;
        Fri,  3 Aug 2018 13:23:06 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 03 Aug 2018 13:23:06 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 62DD24265A4E;
        Fri,  3 Aug 2018 13:23:06 +0200 (CEST)
Date:   Fri, 3 Aug 2018 13:25:16 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Simon Horman <horms@verge.net.au>
Cc:     Julian Anastasov <ja@ssi.bg>, Tan Hu <tan.hu@zte.com.cn>,
        wensong@linux-vs.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
Subject: Re: [PATCH v3] ipvs: fix race between ip_vs_conn_new() and
 ip_vs_del_dest()
Message-ID: <20180803112516.zexgzi4hewvy6oo6@salvia>
References: <1532503387-3800-1-git-send-email-tan.hu@zte.com.cn>
 <alpine.LFD.2.20.1807252208320.2437@ja.home.ssi.bg>
 <20180731165421.ee265xghmbqcy54g@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731165421.ee265xghmbqcy54g@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 06:54:21PM +0200, Simon Horman wrote:
> On Wed, Jul 25, 2018 at 10:12:48PM +0300, Julian Anastasov wrote:
[...]
> > 	v3 looks good to me,
> > 
> > Acked-by: Julian Anastasov <ja@ssi.bg>
> > 
> > 	Simon and Pablo, this can be applied to ipvs/nf tree...
> 
> Acked-by: Simon Horman <horms@verge.net.au>
> 
> Pablo, please consider this for the nf tree.

Applied, thanks!
