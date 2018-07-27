Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CB6C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06D820671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06D820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbeG0G5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:57:40 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:54124 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbeG0G5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 02:57:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 45D2B20092;
        Fri, 27 Jul 2018 09:37:13 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QvBr2Ha50ySn; Fri, 27 Jul 2018 09:37:12 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 35E5B20087;
        Fri, 27 Jul 2018 09:37:12 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.399.0; Fri, 27 Jul 2018
 07:37:27 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id D1E5C318201B;
 Fri, 27 Jul 2018 07:37:26 +0200 (CEST)
Date:   Fri, 27 Jul 2018 07:37:26 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec-next] xfrm: fix 'passing zero to ERR_PTR()' warning
Message-ID: <20180727053726.hxw5hrbbq3e2xw6o@gauss3.secunet.de>
References: <20180725085433.18756-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180725085433.18756-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 4B1D697D-ED6C-4F45-BCC0-221BDC8504D7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 04:54:33PM +0800, YueHaibing wrote:
> Fix a static code checker warning:
> 
>   net/xfrm/xfrm_policy.c:1836 xfrm_resolve_and_create_bundle() warn: passing zero to 'ERR_PTR'
> 
> xfrm_tmpl_resolve return 0 just means no xdst found, return NULL
> instead of passing zero to ERR_PTR.
> 
> Fixes: d809ec895505 ("xfrm: do not assume that template resolving always returns xfrms")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks a lot!
