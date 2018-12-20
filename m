Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37E021741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbeLTILc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:11:32 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:40106 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbeLTILc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:11:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 169A7201B9;
        Thu, 20 Dec 2018 09:11:31 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JsqTZXOzXFWW; Thu, 20 Dec 2018 09:11:30 +0100 (CET)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id B695F20068;
        Thu, 20 Dec 2018 09:11:30 +0100 (CET)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 20 Dec 2018
 09:11:30 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 47F6B3182739;
 Thu, 20 Dec 2018 09:11:30 +0100 (CET)
Date:   Thu, 20 Dec 2018 09:11:30 +0100
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] xfrm6_tunnel: Fix spi check in
 __xfrm6_tunnel_alloc_spi
Message-ID: <20181220081130.GB3581@gauss3.secunet.de>
References: <20181219064509.9804-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181219064509.9804-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 73B6D09D-E687-47C4-AFB1-C4660A7CFE46
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 02:45:09PM +0800, YueHaibing wrote:
> gcc warn this:
> 
> net/ipv6/xfrm6_tunnel.c:143 __xfrm6_tunnel_alloc_spi() warn:
>  always true condition '(spi <= 4294967295) => (0-u32max <= u32max)'
> 
> 'spi' is u32, which always not greater than XFRM6_TUNNEL_SPI_MAX
> because of wrap around. So the second forloop will never reach.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Also applied, thanks a lot!
