Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E984C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9E6206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfAJILT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:11:19 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:44682 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbfAJILS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:11:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 814B9200AA;
        Thu, 10 Jan 2019 09:11:16 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zYJv8RnuE05S; Thu, 10 Jan 2019 09:11:16 +0100 (CET)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 254032006F;
        Thu, 10 Jan 2019 09:11:16 +0100 (CET)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 10 Jan 2019
 09:11:15 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id AFFEB31805AD;
 Thu, 10 Jan 2019 09:11:15 +0100 (CET)
Date:   Thu, 10 Jan 2019 09:11:15 +0100
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suyanjun218@gmail.com>
Subject: Re: [PATCH v2] vti4: Fix a ipip packet processing bug in 'IPCOMP'
 virtual tunnel
Message-ID: <20190110081115.GM3581@gauss3.secunet.de>
References: <1546828280-26039-1-git-send-email-suyj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1546828280-26039-1-git-send-email-suyj.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 82F089C0-8112-4198-8458-7653549539FA
X-G-Data-MailSecurity-for-Exchange-ProcessedOnRouted: True
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 09:31:20PM -0500, Su Yanjun wrote:
> Recently we run a network test over ipcomp virtual tunnel.We find that
> if a ipv4 packet needs fragment, then the peer can't receive
> it.
> 
> We deep into the code and find that when packet need fragment the smaller
> fragment will be encapsulated by ipip not ipcomp. So when the ipip packet
> goes into xfrm, it's skb->dev is not properly set. The ipv4 reassembly code
> always set skb'dev to the last fragment's dev. After ipv4 defrag processing,
> when the kernel rp_filter parameter is set, the skb will be drop by -EXDEV
> error.
> 
> This patch adds compatible support for the ipip process in ipcomp virtual tunnel.
> 
> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>

Patch applied, thanks!
