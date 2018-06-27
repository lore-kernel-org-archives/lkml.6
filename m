Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4F9C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FB326061
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FB326061
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754909AbeF0Pv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:51:27 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:54638 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751177AbeF0PvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:51:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 219D1200A7;
        Wed, 27 Jun 2018 17:51:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QtuP4LJxn-Tb; Wed, 27 Jun 2018 17:51:23 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 353172018E;
        Wed, 27 Jun 2018 17:51:23 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 27 Jun 2018
 17:51:22 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id BC0023182281;
 Wed, 27 Jun 2018 17:51:22 +0200 (CEST)
Date:   Wed, 27 Jun 2018 17:51:22 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "Hideaki YOSHIFUJI" <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH 1/1] esp6: fix memleak on error path in esp6_input
Message-ID: <20180627155122.i6lbultmbqpq5nte@gauss3.secunet.de>
References: <1530071368-15156-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1530071368-15156-1-git-send-email-thunder.leizhen@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 7AC44A6E-4FD9-4D72-A430-BFC6E279EBD3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:49:28AM +0800, Zhen Lei wrote:
> This ought to be an omission in e6194923237 ("esp: Fix memleaks on error
> paths."). The memleak on error path in esp6_input is similar to esp_input
> of esp4.
> 
> Fixes: e6194923237 ("esp: Fix memleaks on error paths.")
> Fixes: 3f29770723f ("ipsec: check return value of skb_to_sgvec always")
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied, thanks a lot for the fix!
